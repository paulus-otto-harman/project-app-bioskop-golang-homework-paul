package repository

import "database/sql"

type Session struct {
	Db *sql.DB
}

func InitSessionRepo(db *sql.DB) *Session {
	return &Session{Db: db}
}

func (repo Session) Validate(sessionId string) error {
	isValid := false
	return repo.Db.QueryRow("SELECT EXISTS(SELECT 1 FROM sessions WHERE token = $1 AND expired_at IS NULL)", sessionId).Scan(&isValid)
}
