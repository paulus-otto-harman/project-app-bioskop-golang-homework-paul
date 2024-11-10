package service

import "homework/repository"

type SessionService struct {
	Session repository.Session
}

func InitSessionService(repo repository.Session) *SessionService {
	return &SessionService{Session: repo}
}

func (repo *SessionService) Validate(sessionId string) bool {
	return repo.Session.Validate(sessionId) == nil
}
