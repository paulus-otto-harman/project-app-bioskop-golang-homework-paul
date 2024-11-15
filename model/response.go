package model

type Response struct {
	StatusCode    int         `json:"statusCode,omitempty"`
	Data          interface{} `json:"data,omitempty"`
	Message       *string     `json:"message,omitempty"`
	TransactionId *int        `json:"transactionId,omitempty"`
	Booking       interface{} `json:"booking,omitempty"`
	BookingId     *string     `json:"bookingId,omitempty"`
}
