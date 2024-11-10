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

func (response ResponseWriter) Json(statusCode int, message string, args ...interface{}) {
	r := model.Response{
		StatusCode: statusCode,
	}

	if message != "" {
		r.Message = &message
	}

	switch {
	case len(args) > 0:
		r.Data = args[0]
		fallthrough
	case len(args) > 1:
		transactionId := args[1].(int)
		r.TransactionId = &transactionId
		fallthrough
	case len(args) > 2:
		transactionId := args[1].(int)
		r.TransactionId = &transactionId
	}

	json.NewEncoder(response.Writer).Encode(r)
}
