FROM debian:stretch-slim

ENV NODECHAIN dcr
ENV NODEVERSION 1.2.1
ENV NODEURL https://github.com/decred/decred-binaries/releases/download/v1.2.1/decrediton-v1.2.1.tar.gz
ENV NODESHA256 a2535fc4d789486850ac66b1de3b45a013c937bfd8509e0396f1863fe41ed535


	ENV NODEPORT_P2P 9108
	ENV NODEPORT_RPC 9109
	ENV NODEPORT_P2PTESTNET 19108
	ENV NODEPORT_RPCTESTNET 19109


RUN groupadd -r "$NODECHAIN" && useradd -r -m -g "$NODECHAIN" "$NODECHAIN"

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends dialog ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

# install "$NODECHAIN" binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO "$NODECHAIN.tar.gz" "$NODEURL" \
	&& echo "$NODESHA256 $NODECHAIN.tar.gz" | sha256sum -c - \
	&& tar -xzvf "$NODECHAIN.tar.gz" -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV NODEDATA /data
RUN mkdir "$NODEDATA" \
	&& chown -R "$NODECHAIN:$NODECHAIN" "$NODEDATA" \
	&& ln -sfn "$NODEDATA" "/home/$NODECHAIN/.$NODECHAIN" \
	&& chown -h "$NODECHAIN:$NODECHAIN" "/home/$NODECHAIN/.$NODECHAIN"
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE "$NODEPORT_P2P" "$NODEPORT_RPC" "$NODEPORT_P2PTESTNET" "$NODEPORT_RPCTESTNET"

CMD ${NODECHAIN}d
