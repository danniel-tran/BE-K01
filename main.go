package main

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"io"
	"net/http"
	"os/exec"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"github.com/golang/groupcache/lru"
)

// GLOBAL VARIABLE
var lruCache *lru.Cache
var client = connectRedis()

const (
	KEY_LOCK_PING      = "redis-ping-lock"
	PING_SORT          = "sort-set"
	PREFIX_COUNT_LIMIT = "count-limit-"
	COUNT_HYPER        = "count-hyper"
)

func sessionId() string {
	b := make([]byte, 32)
	if _, err := io.ReadFull(rand.Reader, b); err != nil {
		return ""
	}
	rand_string := base64.URLEncoding.EncodeToString(b)
	fmt.Println("session_id is %v", rand_string)
	return rand_string
}

func loginHandler(c *gin.Context) {
	username := c.PostForm("username")
	password := c.PostForm("password")
	context := context.Background()
	if username == "user" && password == "password" {
		session := sessionId()
		err := client.Set(context, session, username, time.Minute*10).Err()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal Server Error"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"message": "you are logged in"})
		return
	}
	c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
}

func handlePingCount(username string) bool {
	pipe := client.Pipeline()
	ctx := context.Background()
	key_count_limit := PREFIX_COUNT_LIMIT + username
	numberRequest := pipe.Incr(ctx, key_count_limit).Val()
	if numberRequest == 1 {
		client.Expire(client.Context(), key_count_limit, 1*time.Minute)
	}
	if numberRequest >= 3 {
		return false
	}
	// increase count
	numberRequestPerUser := pipe.Incr(ctx, username).Val()
	// for hyperloglog
	client.PFAdd(client.Context(), COUNT_HYPER, username).Err()
	// for sort set
	client.ZAdd(ctx, PING_SORT, &redis.Z{
		Score:  float64(numberRequestPerUser),
		Member: username,
	}).Err()
	return true
}

func countPingHandler(c *gin.Context) {
	username := c.Params.ByName("username")
	ctx := context.Background()
	value, err := client.Get(ctx, username).Result()
	if err == redis.Nil {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "ping times is " + value})
}

func pingHandler(c *gin.Context) {
	newUUID, err := exec.Command("uuidgen").Output()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}
	// authorizeSession
	context := context.Background()
	var session_id = c.PostForm("session")
	value, err := client.Get(context, session_id).Result()
	if err == redis.Nil {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "server error"})
		return
	}
	// lock rediskey
	lockKeyRedis(KEY_LOCK_PING, string(newUUID), time.Minute*10)
	// count Ping
	pingHandle := handlePingCount(session_id)
	if !pingHandle {
		unlockKeyRedis(KEY_LOCK_PING)
		c.JSON(http.StatusTooManyRequests, gin.H{"message": "too many request"})
	}
	// unlock key
	unlockKeyRedis(KEY_LOCK_PING)
	// sleep
	time.Sleep(5 * time.Second)
	c.JSON(http.StatusOK, gin.H{"message": "ok", "value": value})
}

func lockKeyRedis(key string, value string, expiredTime time.Duration) bool {
	ctx := context.Background()
	_, err := client.SetNX(ctx, key, value, expiredTime).Result()
	if err != nil {
		return false
	}
	return true
}

func unlockKeyRedis(key string) {
	ctx := context.Background()
	if err := client.Del(ctx, key).Err(); err != nil {
		panic(err)
	}
}

func topHandler(c *gin.Context) {
	// Retrieve the top 10 most-called /ping APIs
	ctx := context.Background()
	result, err := client.ZRevRangeWithScores(ctx, PING_SORT, 0, 9).Result()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to retrieve top APIs"})
		return
	}

	var topAPIs []string
	for _, value := range result {
		topAPIs = append(topAPIs, value.Member.(string))
	}

	c.JSON(http.StatusOK, gin.H{"top_apis": topAPIs})
}

func connectRedis() *redis.Client {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})
	context := context.Background()
	_, err := client.Ping(context).Result()
	if err != nil {
		panic("cannot connect to rediss")
	}
	return client
}

func countHandler(c *gin.Context) {
	// Retrieve the approximate number of callers to /ping API using HyperLogLog
	ctx := context.Background()
	count, err := client.PFCount(ctx, COUNT_HYPER).Result()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to retrieve count"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"count": count})
}

func main() {
	r := gin.Default()
	r.GET("/api/top", topHandler)
	r.POST("/api/ping", pingHandler)
	r.POST("/api/login", loginHandler)
	r.POST("/api/ping-count/:username", countPingHandler)
	r.GET("/api/count", countHandler)
	r.Run(":8080")
}
