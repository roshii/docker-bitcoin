FROM debian:stretch-slim

ENV NODECHAIN bitcoin
ENV NODEVERSION 0.14.2-uasfsegwit0.3
ENV NODEURL https://uasf.bitcoinreminder.com/core-0.14.2-uasfsegwit0.3/bitcoin-0.14.2-bip148_segwit0.3-x86_64-linux-gnu.tar.gz
ENV NODESHA256 668ba1ae6d54307878e1e02d396b96e0bb3829b71735cb1992910cadf861db1f
ENV NODEASC_URL https://uasf.bitcoinreminder.com/core-0.14.2-uasfsegwit0.3/SHA256SUMS.asc
ENV NODEPGP_KEY E463A93F5F3117EEDE6C7316BD02942421F4889F



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
