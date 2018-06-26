FROM debian:stretch-slim

ENV NODECHAIN bitcoin
ENV NODEVERSION 0.11.2
ENV NODEURL https://bitcoin.org/bin/bitcoin-core-0.11.2/bitcoin-0.11.2-linux64.tar.gz
ENV NODESHA256 2fc13c64fd10b7f75aa93d1f1df78f353a02cca62e17f9ffd106527da2e8b908
ENV NODEASC_URL https://bitcoin.org/bin/bitcoin-core-0.11.2/SHA256SUMS.asc
ENV NODEPGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964



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

EXPOSE "$NODEPORTS"

CMD [""$NODECHAINd""]
