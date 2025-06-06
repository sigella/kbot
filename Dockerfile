FROM --platform=linux/${TARGETARCH} quay.io/projectquay/golang:1.24 AS builder
WORKDIR /go/src/app
COPY . .
ARG TARGETARCH
RUN make build TARGETARCH=${TARGETARCH}

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["./kbot"]
