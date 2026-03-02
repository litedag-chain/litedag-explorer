FROM golang:1.24-alpine AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o /explorer .

FROM alpine:3.21
WORKDIR /app
COPY --from=build /explorer .
COPY static/ ./static/
COPY html/templates/ ./html/templates/
EXPOSE 8080
CMD ["./explorer"]
