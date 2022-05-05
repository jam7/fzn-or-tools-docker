FROM alpine:edge
LABEL maintainer "Kazushi (Jam) Marukawa <jam@pobox.com>"

# Google OR-Tools
ENV ORTOOLS https://github.com/google/or-tools/releases/download/v9.3/or-tools_amd64_flatzinc_alpine-edge_v9.3.10497.tar.gz

RUN apk add --no-cache ca-certificates curl su-exec tar libstdc++
WORKDIR /usr/local
# This binary distribution loose hard link, so making hard link by hand
RUN curl -L ${ORTOOLS} -o ortools.tar.gz && \
    tar --strip-components 1 -xf ortools.tar.gz && \
    rm ortools.tar.gz && \
    rm -rf examples && \
    cd lib && \
    rm libflatzinc.so libflatzinc.so.9 && \
    ln libflatzinc.so.9.3.10497 libflatzinc.so && \
    ln libflatzinc.so.9.3.10497 libflatzinc.so.9 && \
    rm libortools.so libortools.so.9 && \
    ln libortools.so.9.3.10497 libortools.so && \
    ln libortools.so.9.3.10497 libortools.so.9

COPY entrypoint.sh /fzn-or-tools/entrypoint.sh
COPY fzn-or-tools.sh /fzn-or-tools/fzn-or-tools.sh
WORKDIR /work

ENTRYPOINT ["/fzn-or-tools/entrypoint.sh"]
