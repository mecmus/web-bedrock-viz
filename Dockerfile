FROM ubuntu:20.04 as builder

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

FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y libpng16-16 libboost-program-options-dev cron && \
    rm -rf /var/cache/apt

COPY --from=builder /usr/local/share/bedrock-viz /usr/local/share/bedrock-viz
COPY --from=builder /usr/local/bin/bedrock-viz /usr/local/bin/

COPY map-update.sh /etc/cron.hourly/
RUN chmod +x /etc/cron.hourly/map-update.sh

ENTRYPOINT [ "cron -f" ]