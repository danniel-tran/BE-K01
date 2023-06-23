package types

import (
	"gorm.io/gorm"
)

type Enroll struct {
	gorm.Model
	stud_id  int    `gorm:"column:stud_id;primaryKey"`
	class_id int    `gorm:"column:class_id;primaryKey"`
	grade    string `gorm:"column:grade"`
}
