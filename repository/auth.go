package repository

import (
	"database/sql"
	"errors"
	"homework/model"
)

type Auth struct {
	Db *sql.DB
}

func InitAuthRepo(db *sql.DB) *Auth {
	return &Auth{Db: db}
}

func (repo *Auth) Authenticate(user model.User) (*model.Session, error) {
	query := `WITH newsession AS (
    			INSERT INTO sessions (user_id)
    			    SELECT id FROM users WHERE username=$1 AND password=$2
    			    RETURNING token,user_id
    	       ) SELECT username, email, token FROM newsession JOIN users ON newsession.user_id=users.id`
	var session model.Session
	if err := repo.Db.QueryRow(query, user.Username, user.Password).Scan(&session.Username, &session.Email, &session.Token); err != nil {
		return nil, err
	}
	return &session, nil
}

func (repo *Auth) Logout(token string) error {
	query := `UPDATE sessions SET expired_at=now() WHERE token=$1 AND expired_at IS NULL`
	result, err := repo.Db.Exec(query, token)

	if err != nil {
		return err
	}

	if loggedOut, _ := result.RowsAffected(); loggedOut == 0 {
		return errors.New("logout failed :: invalid session")
	}

	return nil
}
