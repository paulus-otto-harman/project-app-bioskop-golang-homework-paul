package service

import "homework/repository"

type Session struct {
	Session repository.Session
}

func InitSessionService(repo repository.Session) *Session {
	return &Session{Session: repo}
}

func (repo *Session) Validate(sessionId string) bool {
	return repo.Session.Validate(sessionId) == nil
}
