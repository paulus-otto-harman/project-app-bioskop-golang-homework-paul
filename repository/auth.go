package repository

import (
	"database/sql"
	"errors"
	"homework/model"
	"log"
)

type Auth struct {
	Db *sql.DB
}

func InitAuthRepo(db *sql.DB) *Auth {
	return &Auth{Db: db}
}

func (repo *Auth) Authenticate(user model.User) (*model.Session, error) {
	query := `INSERT INTO sessions (user_id) SELECT id FROM users WHERE username=$1 AND password=$2 RETURNING token`
	var session model.Session
	if err := repo.Db.QueryRow(query, user.Username, user.Password).Scan(&session.Token); err != nil {
		return nil, err
	}
	return &session, nil
}

func (repo *Auth) Logout(token string) error {
	log.Println("logout", token)
	query := `UPDATE sessions SET expired_at=now() WHERE token=$1 AND expired_at IS NULL`
	result, err := repo.Db.Exec(query, token)

	if err != nil {
		return err
	}
	loggedOut, _ := result.RowsAffected()
	if loggedOut == 0 {
		return errors.New("logout failed :: invalid session")
	}

	return nil
}
