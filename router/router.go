package router

import (
	"database/sql"
	"github.com/go-chi/chi/v5"
	"homework/handler"
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

	})

	r.Get("/app.css", handleWebTemplate.Static)

	return r
}
