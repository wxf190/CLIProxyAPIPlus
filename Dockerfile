FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o cli-proxy-api-plus .

FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata
WORKDIR /CLIProxyAPI
COPY --from=builder /app/cli-proxy-api-plus .
EXPOSE 8317
CMD ["./cli-proxy-api-plus"]
