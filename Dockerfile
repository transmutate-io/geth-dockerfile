FROM golang:1.15.0-alpine3.12 AS builder

ENV GETH_VERSION "v1.9.20"

RUN apk add --no-cache make gcc musl-dev linux-headers git
RUN git clone https://github.com/ethereum/go-ethereum.git /src/geth
RUN cd /src/geth && \
    git checkout ${GETH_VERSION} && \
    make all

FROM alpine:3.12.0

RUN apk add --no-cache ca-certificates

COPY --from=builder /src/geth/build/bin/* /usr/local/bin/
COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]