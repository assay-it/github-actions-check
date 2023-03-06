FROM golang

## TODO: download binary
RUN set -eu \
  && curl -o /go/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 \
  && chmod +x /go/bin/jq \
  && go install github.com/assay-it/assay-it@v1.0.3

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
