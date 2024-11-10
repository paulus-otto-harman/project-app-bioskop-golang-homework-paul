package router

import (
	"database/sql"
	"github.com/go-chi/chi/v5"
	"homework/handler"
	"homework/middleware"
	"homework/repository"
	"homework/service"
	"html/template"
	"log"
)

func initTemplate() (*repository.WebPageData, *template.Template) {
	tmpl, err := template.ParseGlob("view/*.html")
	if err != nil {
		log.Fatalf("Error parsing template: %v", err)
		return nil, nil
	}

	return &repository.WebPageData{}, tmpl
}

func NewRouter(db *sql.DB) *chi.Mux {
	r := chi.NewRouter()

	handleWebTemplate := handler.InitWebPageHandler(*service.InitWebPageService(*repository.InitWebPageRepo(initTemplate())))

	r.Route("/api", func(r chi.Router) {
		r.Use(middleware.JsonResponse())

		r.Post("/register", nil)
		r.Post("/login", nil)
		r.Post("/logout", nil)

		r.Get("/payment-methods", nil)

		r.Route("/cinemas", func(r chi.Router) {
			r.Get("/", nil)
			r.Get("/{cinemaId}", nil)
			r.Get("/{cinemaId}/seats", nil)
		})

		r.Group(func(r chi.Router) {
			r.Use(middleware.Auth(*service.InitSessionService(*repository.InitSessionRepo(db))))
			r.Post("/booking", nil)
			r.Post("/pay", nil)
		})

	})

	r.Get("/app.css", handleWebTemplate.Static)

	return r
}
