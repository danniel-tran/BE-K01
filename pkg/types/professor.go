package types

import (
	"gorm.io/gorm"
)

type Professor struct {
	gorm.Model
	prof_id    int    `gorm:"prof_id;primaryKey"`
	prof_lname string `gorm:"prof_lname"`
	prof_fname string `gorm:"prof_fname"`
}
