FROM debian:stretch-slim

ENV CHAIN dcr
ENV VERSION 1.2.1
ENV URL https://github.com/decred/decred-binaries/releases/download/v1.2.1/decrediton-v1.2.1.tar.gz
ENV SHA256 a2535fc4d789486850ac66b1de3b45a013c937bfd8509e0396f1863fe41ed535
ENV PORT_P2P 9108
ENV PORT_RPC 9109
ENV PORT_P2PTESTNET 19108
ENV PORT_RPCTESTNET 19109
ENV DATA_FOLDER /data


	ENV DEFAULT_FOLDER /home/.dcrd/data

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

	CMD usr/local/resources/bin/dcrd
