package handler

import (
	"encoding/json"
	"homework/lib"
	"homework/model"
	"homework/service"
	"net/http"
)

type AuthHandler struct {
	AuthService service.AuthService
}

func InitAuthHandler(authService service.AuthService) AuthHandler {
	return AuthHandler{AuthService: authService}
}

func (handle *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	user := model.User{}
	json.NewDecoder(r.Body).Decode(&user)

	if user.Username == "" || user.Password == "" {
		lib.Response(w).Json(http.StatusUnauthorized, "Invalid username or password.")
		return
	}

	result, err := handle.AuthService.Login(user)
	if err != nil {
		lib.Response(w).Json(http.StatusUnauthorized, "Invalid username or password.")
		return
	}

	lib.Response(w).Json(http.StatusOK, "", result)
}

func (handle *AuthHandler) Logout(w http.ResponseWriter, r *http.Request) {
	token := r.Header.Get("token")

	err := handle.AuthService.Logout(token)
	if err != nil {
		lib.Response(w).Json(http.StatusNotFound, err.Error())
		return
	}
	lib.Response(w).Json(http.StatusOK, "User logged out successfully.")
}
