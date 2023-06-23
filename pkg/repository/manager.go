package repository

import (
	"github.com/EngineerProOrg/BE-K01/pkg/types"
	"gorm.io/gorm"
)

type StudentRepository interface {
	GetStudentByIdx(id int64)
}

type repo struct {
	db *gorm.DB
}

func NewStudentRepository(db *gorm.DB) StudentRepository {
	return &repo{
		db: db,
	}
}

func (r *repo) GetStudentByIdx(id int64) {
	std := &types.Student{}
	r.db.First(std, id)
}

func (r *repo) GetStudentProfessorRelated(id int64) {
	var query = "SELECT CONCAT(P.PROF_FNAME , ' ' , P.PROF_LNAME) AS PROFFESSOR_NAME, CONCAT(S.STUD_FNAME , ' ' , S.STUD_LNAME) AS STUDENT_NAME, COUNT(C.CLASS_ID) AS TIME_MEET FROM PROFFESSOR AS P "
	var join = "INNER JOIN CLASS AS C ON C.PROF_ID = P.PROF_ID INNER JOIN ENROLL AS E ON E.CLASS_ID = C.CLASS_ID INNER JOIN STUDENT AS S ON S.STUD_ID = E.STUD_ID GROUP BY PROFFESSOR_NAME,STUDENT_NAME;"
	query += join
	r.db.Raw(query)
}
