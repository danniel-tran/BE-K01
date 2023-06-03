package types

import (
	"gorm.io/gorm"
)

type Professor struct {
	gorm.Model
	FirstName string `gorm:"first_name"`
	LastName  string `gorm:"last_name"`
}
