package handler

import (
	"encoding/json"
	"homework/lib"
	"homework/model"
	"homework/service"
	"net/http"
	"strings"
)

type UserHandler struct {
	UserService service.UserService
}

func InitUserHandler(userService service.UserService) UserHandler {
	return UserHandler{UserService: userService}
}

func (handle *UserHandler) Registration(w http.ResponseWriter, r *http.Request) {
	user := model.User{}
	json.NewDecoder(r.Body).Decode(&user)

	if user.Username == "" {
		lib.Response(w).Json(http.StatusUnprocessableEntity, "username required")
		return
	}

	if user.Password == "" {
		lib.Response(w).Json(http.StatusUnprocessableEntity, "password required")
		return
	}

	if len(user.Username) > 15 {
		lib.Response(w).Json(http.StatusUnprocessableEntity, "username too long, max 15 characters")
	}

	if len(user.Password) > 15 {
		lib.Response(w).Json(http.StatusUnprocessableEntity, "password too long, max 15 characters")
	}

	if len(user.Email) > 25 {
		lib.Response(w).Json(http.StatusUnprocessableEntity, "email too long, max 25 characters")
	}

	err := handle.UserService.Register(user)
	if err != nil {
		if strings.Contains(err.Error(), "users_username_key") {
			lib.Response(w).Json(http.StatusConflict, "username already exists")
			return
		}
		if strings.Contains(err.Error(), "users_email_key") {
			lib.Response(w).Json(http.StatusConflict, "email already exists")
			return
		}
	}

	lib.Response(w).Json(http.StatusCreated, "User registered successfully.")
}
