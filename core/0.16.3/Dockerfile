FROM debian:stretch-slim

RUN groupadd -r litecoin && useradd -r -m -g litecoin litecoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV LITECOIN_VERSION 0.16.3
ENV LITECOIN_URL https://download.litecoin.org/litecoin-0.16.3/linux/litecoin-0.16.3-x86_64-linux-gnu.tar.gz
ENV LITECOIN_SHA256 686d99d1746528648c2c54a1363d046436fd172beadaceea80bdc93043805994
ENV LITECOIN_ASC_URL https://download.litecoin.org/litecoin-0.16.3/linux/litecoin-0.16.3-linux-signatures.asc
ENV LITECOIN_PGP_KEY 

# install litecoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO litecoin.tar.gz "$LITECOIN_URL" \
	&& echo "$LITECOIN_SHA256 litecoin.tar.gz" | sha256sum -c - \
	&& gpg --keyserver pgp.mit.edu --recv-keys "$LITECOIN_PGP_KEY" \
	&& wget -qO litecoin.asc "$LITECOIN_ASC_URL" \
	&& gpg --verify litecoin.asc \
	&& tar -xzvf litecoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV LITECOIN_DATA /data
RUN mkdir "$LITECOIN_DATA" \
	&& chown -R litecoin:litecoin "$LITECOIN_DATA" \
	&& ln -sfn "$LITECOIN_DATA" /home/litecoin/.litecoin \
	&& chown -h litecoin:litecoin /home/litecoin/.litecoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9332 9333 19332 19333
CMD ["litecoind"]
