FROM alpine:edge
LABEL maintainer "Kazushi (Jam) Marukawa <jam@pobox.com>"

# Google OR-Tools
ENV ORTOOLS https://github.com/google/or-tools/releases/download/v9.3/or-tools_amd64_flatzinc_alpine-edge_v9.3.10497.tar.gz

RUN apk add --no-cache ca-certificates curl su-exec tar libstdc++
WORKDIR /usr/local
RUN curl -L ${ORTOOLS} -o ortools.tar.gz && \
    tar --strip-components 1 -xf ortools.tar.gz && \
    rm ortools.tar.gz

COPY entrypoint.sh /fzn-or-tools/entrypoint.sh
COPY fzn-or-tools.sh /fzn-or-tools/fzn-or-tools.sh
WORKDIR /work

ENTRYPOINT ["/fzn-or-tools/entrypoint.sh"]
