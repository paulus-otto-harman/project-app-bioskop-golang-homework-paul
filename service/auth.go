package service

import (
	"homework/model"
	"homework/repository"
)

type AuthService struct {
	Auth repository.Auth
}

func InitAuthService(repo repository.Auth) *AuthService {
	return &AuthService{Auth: repo}
}

func (repo *AuthService) Login(user model.User) (*model.Session, error) {
	return repo.Auth.Authenticate(user)
}

func (repo *AuthService) Logout(token string) error {
	return repo.Auth.Logout(token)
}
