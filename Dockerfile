FROM golang

RUN go get github.com/assay-it/assay
COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]