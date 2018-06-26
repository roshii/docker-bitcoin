FROM debian:stretch-slim

ENV NODECHAIN bitcoin
ENV NODEVERSION 0.14.2
ENV NODEURL https://bitcoin.org/bin/bitcoin-core-0.14.2/bitcoin-0.14.2-x86_64-linux-gnu.tar.gz
ENV NODESHA256 20acc6d5d5e0c4140387bc3445b8b3244d74c1c509bd98f62b4ee63bec31a92b
ENV NODEASC_URL https://bitcoin.org/bin/bitcoin-core-0.14.2/SHA256SUMS.asc
ENV NODEPGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964

 
	ENV NODEPORT_P2P 8332
	ENV NODEPORT_RPC 8333
	ENV NODEPORT_P2PTESTNET 18332
	ENV NODEPORT_RPCTESTNET 18333


RUN groupadd -r "$NODECHAIN" && useradd -r -m -g "$NODECHAIN" "$NODECHAIN"

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

# install "$NODECHAIN" binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO "$NODECHAIN.tar.gz" "$NODEURL" \
	&& echo "$NODESHA256 $NODECHAIN.tar.gz" | sha256sum -c - \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys "$NODEPGP_KEY" \
	&& wget -qO "$NODECHAIN.asc $NODEASC_URL" \
	&& gpg --verify "$NODECHAIN.asc" \
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

CMD [""$NODECHAINd""]
