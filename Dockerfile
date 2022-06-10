# syntax=docker/dockerfile:1

FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /k8s-deployment-updator

FROM alpine
COPY --from=builder /k8s-deployment-updator /usr/bin/k8s-deployment-updator
ENTRYPOINT [ "k8s-deployment-updator" ]