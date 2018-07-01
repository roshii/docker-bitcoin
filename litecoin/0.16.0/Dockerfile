FROM debian:stretch-slim

ENV CHAIN litecoin
ENV VERSION 0.16.0
ENV URL https://download.litecoin.org/litecoin-0.16.0/linux/litecoin-0.16.0-x86_64-linux-gnu.tar.gz
ENV SHA256 5a1dfaea8d70f4d0d61190061631d6ad40cb3662e7718660000c43f564c348e6
ENV PORT_P2P 9332
ENV PORT_RPC 9333
ENV PORT_P2PTESTNET 19332
ENV PORT_RPCTESTNET 19333
ENV DATA_FOLDER /data


	ENV DEFAULT_FOLDER /home/litecoin/.litecoin

RUN groupadd -r "$CHAIN" && useradd -r -m -g "$CHAIN" "$CHAIN"

RUN set -ex \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

# install node binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO "$CHAIN.tar.gz" "$URL" \
	&& echo "$SHA256 $CHAIN.tar.gz" | sha256sum -c - \
	&& tar -xzvf "$CHAIN.tar.gz" -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
RUN mkdir -p "$DATA_FOLDER" \
	&& mkdir -p "$DEFAULT_FOLDER" \
	&& chown -R "$CHAIN:$CHAIN" "$DATA_FOLDER" \
	&& ln -sfn "$DATA_FOLDER" "$DEFAULT_FOLDER" \
	&& chown -h "$CHAIN:$CHAIN" "$DEFAULT_FOLDER"
VOLUME "$DATA_FOLDER"


EXPOSE "$PORT_P2P" "$PORT_RPC" "$PORT_P2PTESTNET" "$PORT_RPCTESTNET"

	COPY docker-entrypoint.sh /entrypoint.sh
	ENTRYPOINT ["/entrypoint.sh"]
	CMD "$CHAIN"d
