ARG GO_VERSION=1.14.3
ARG ALPINE_VERSION=3.11

FROM tasslin/go:${GO_VERSION}-alpine${ALPINE_VERSION} AS builder

RUN apk --update add build-base git

WORKDIR /go/src/app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN go build -o ./app ./main.go

FROM tasslin/go:${GO_VERSION}-alpine${ALPINE_VERSION}

WORKDIR /go/src/app

COPY --from=builder /go/src/app/app .

CMD ./app;