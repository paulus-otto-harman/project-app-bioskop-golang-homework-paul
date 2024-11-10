package lib

import (
	"encoding/json"
	"homework/model"
	"log"
	"net/http"
	"reflect"
)

func Response(w http.ResponseWriter) ResponseWriter {
	return ResponseWriter{Writer: w}
}

type ResponseWriter struct {
	Writer http.ResponseWriter
}

func (response ResponseWriter) Json(statusCode int, message string, args ...any) {
	r := model.Response{
		StatusCode: statusCode,
		Message:    &message,
	}

	if message == "" {
		r.Message = nil
	}

	log.Println(reflect.TypeOf(args), reflect.ValueOf(args))

	json.NewEncoder(response.Writer).Encode(r)
}
