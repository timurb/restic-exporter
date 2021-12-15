# syntax=docker/dockerfile:1

FROM golang:1.16-alpine as build

WORKDIR /app
COPY . .
RUN go build -o bin/restic-exporter src/*.go


FROM restic/restic
WORKDIR /stats
COPY --from=build /app/bin/restic-exporter /usr/bin

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/usr/bin/restic"]
