package lib

import (
	"encoding/json"
	"homework/model"
	"net/http"
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

	json.NewEncoder(response.Writer).Encode(r)
}
