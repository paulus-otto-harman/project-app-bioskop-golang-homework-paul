package service

import (
	"homework/model"
	"homework/repository"
)

type UserService struct {
	User repository.User
}

func InitUserService(repo repository.User) *UserService {
	return &UserService{User: repo}
}

func (repo *UserService) Register(user model.User) error {
	return repo.User.Register(user)
}
