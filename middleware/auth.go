package middleware

import (
	"homework/lib"
	"homework/service"
	"net/http"
)

func Auth(sessionService service.SessionService) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			sessionId := r.Header.Get("token")
			if !sessionService.Validate(sessionId) {
				lib.Response(w).Json(http.StatusUnauthorized, "Unauthorized")
				return
			}
			next.ServeHTTP(w, r)
		})
	}
}
