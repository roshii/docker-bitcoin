FROM debian:stretch-slim

ENV CHAIN bitcoin
ENV VERSION 0.16.1
ENV URL https://bitcoin.org/bin/bitcoin-core-0.16.1/bitcoin-0.16.1-x86_64-linux-gnu.tar.gz
ENV SHA256 10b31d17351ff4c7929cf955e4d24a2398b0ce91509f707faf8596940c12432a

ENV ASC_URL https://bitcoin.org/bin/bitcoin-core-0.16.1/SHA256SUMS.asc
ENV PGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964
ENV KEY_SERVER keyserver.ubuntu.com

ENV PORT_P2P 8332
ENV PORT_RPC 8333
ENV PORT_P2PTESTNET 18332
ENV PORT_RPCTESTNET 18333

ENV DATA_FOLDER /data

	ENV DEFAULT_FOLDER "/home/$CHAIN/.$CHAIN"
	ENV CONFIG "$CHAIN"


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
	&& gpg --keyserver "$KEY_SERVER" --recv-keys "$PGP_KEY" \
	&& wget -qO "$CHAIN.asc" "$ASC_URL" \
	&& gpg --verify "$CHAIN.asc" \
	&& tar -xzvf "$CHAIN.tar.gz" -C /usr/local --strip-components=1 --exclude=*-qt --exclude=*.pak \
	&& rm -rf /tmp/*

# create data directory
RUN mkdir -p "$DATA_FOLDER" \
#	&& mkdir -p "$DEFAULT_FOLDER" \
	&& chown -R "$CHAIN:$CHAIN" "$DATA_FOLDER" \
	&& ln -sfn "$DATA_FOLDER" "$DEFAULT_FOLDER" \
	&& chown -h "$CHAIN:$CHAIN" "$DEFAULT_FOLDER"
VOLUME "$DATA_FOLDER"

EXPOSE "$PORT_P2P" "$PORT_RPC" "$PORT_P2PTESTNET" "$PORT_RPCTESTNET"

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD "$CHAIN"d
