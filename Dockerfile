# syntax=docker/dockerfile:1

FROM golang:1.16-alpine as build

WORKDIR /app
COPY . .
RUN go build -o bin/restic-exporter src/*.go


FROM restic/restic
WORKDIR /app
COPY --from=build /app/bin/restic-exporter /app

ENTRYPOINT /bin/sh
