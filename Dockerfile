FROM golang:alpine as builder

MAINTAINER otiai10 <otiai10@gmail.com>

RUN apk add --no-cache git

ADD . /go/src/github.com/otiai10/amesh
WORKDIR /go/src/github.com/otiai10/amesh
RUN go get ./...
WORKDIR /go/src/github.com/otiai10/amesh/amesh
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" main.go main_go10.go

FROM scratch
COPY --from=builder /go/src/github.com/otiai10/amesh/amesh/main /amesh

ENTRYPOINT ["/amesh"]
