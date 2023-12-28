FROM golang:1.20

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
COPY ./gen ./gen

RUN CGO_ENABLED=0 GOOS=linux go build -o /mestor
CMD ["/ls"]
EXPOSE 50051
CMD ["/mestor"]
