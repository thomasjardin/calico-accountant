FROM golang:1.11.5 as builder
WORKDIR $GOPATH/src/github.com/thomasjardin/calico-accountant
COPY . $GOPATH/src/github.com/thomasjardin/calico-accountant
RUN make build

FROM alpine
LABEL maintainer="Jack Kleeman <jack@monzo.com>"
WORKDIR /root/
RUN apk --update add iptables
COPY --from=builder /go/src/github.com/thomasjardin/calico-accountant/calico-accountant /calico-accountant
