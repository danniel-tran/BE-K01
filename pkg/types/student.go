package types

import (
	"gorm.io/gorm"
)

type Student struct {
	gorm.Model
	stud_id     int    `gorm:"stud_id;primaryKey"`
	stud_lname  string `gorm:"stud_lname"`
	stud_fname  string `gorm:"stud_fname"`
	stud_street string `gorm:"stud_street"`
	stud_city   string `gorm:"stud_city"`
	stud_zip    string `gorm:"stud_zip"`
}
