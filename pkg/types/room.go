package types

import (
	"gorm.io/gorm"
)

type Room struct {
	gorm.Model
	room_id  int    `gorm:"room_id;primaryKey"`
	room_loc string `gorm:"room_loc"`
	room_cap string `gorm:"room_cap"`
	class_id int    `gorm:"class_id"`
}
