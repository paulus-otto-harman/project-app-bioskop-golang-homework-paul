package repository

import (
	"database/sql"
	"homework/model"
)

type User struct {
	Db *sql.DB
}

func InitUserRepo(db *sql.DB) *User {
	return &User{Db: db}
}

func (repo *User) Register(user model.User) error {
	query := "INSERT INTO users (username, password, email) VALUES($1, $2, $3) RETURNING id"
	return repo.Db.QueryRow(query, user.Username, user.Password, user.Email).Scan(&user.Id)
}
