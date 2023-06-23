package types

import (
	"gorm.io/gorm"
)

type Course struct {
	gorm.Model
	course_id   int    `gorm:"course_id;primaryKey"`
	course_name string `gorm:"course_name"`
}
