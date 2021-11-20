FROM debian:buster-slim as builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake g++ git libboost-program-options-dev libpng++-dev zlib1g-dev

COPY ./bedrock-viz /bedrock-viz

RUN cd /bedrock-viz && \
    patch -p0 < patches/leveldb-1.22.patch && \
    patch -p0 < patches/pugixml-disable-install.patch && \
    mkdir -p build && cd build && \
    cmake .. && \
    make && \
    make install

FROM nginx

RUN apt-get update && \
    apt-get install -y libpng16-16 libboost-program-options-dev cron && \
    rm -rf /var/cache/apt

COPY --from=builder /usr/local/share/bedrock-viz /usr/local/share/bedrock-viz
COPY --from=builder /usr/local/bin/bedrock-viz /usr/local/bin/

COPY map-update.sh /
RUN chmod +x /map-update.sh

COPY startup.sh /
RUN chmod +x /startup.sh

COPY index.html /usr/share/nginx/html/index.html

ENTRYPOINT []
CMD ["/startup.sh"]