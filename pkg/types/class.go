package types

import (
	"gorm.io/gorm"
)

type Class struct {
	gorm.Model
	class_id   int    `gorm:"class_id;primaryKey"`
	class_name string `gorm:"class_name"`
	prof_id    string `gorm:"prof_id"`
	course_id  string `gorm:"course_id"`
}
