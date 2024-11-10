package model

type DataPage struct {
	StatusCode bool        `json:"statusCode"`
	Page       int         `json:"page,omitempty"`
	Limit      int         `json:"limit,omitempty"`
	TotalItems int         `json:"totalItems,omitempty"`
	TotalPages int         `json:"totalPages,omitempty"`
	Data       interface{} `json:"data,omitempty"`
}
