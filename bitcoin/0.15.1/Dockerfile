FROM debian:stretch-slim

ENV NODE_CRYPTO bitcoin
ENV NODEVERSION 0.15.1
ENV NODEURL https://bitcoin.org/bin/bitcoin-core-0.15.1/bitcoin-0.15.1-x86_64-linux-gnu.tar.gz
ENV NODESHA256 387c2e12c67250892b0814f26a5a38f837ca8ab68c86af517f975a2a2710225b
ENV NODEASC_URL https://bitcoin.org/bin/bitcoin-core-0.15.1/SHA256SUMS.asc
ENV NODEPGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964

RUN groupadd -r "$NODE_CRYPTO" && useradd -r -m -g "$NODE_CRYPTO" "$NODE_CRYPTO"

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

# install "$NODE_CRYPTO" binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO "$NODE_CRYPTO.tar.gz" "$NODEURL" \
	&& echo "$NODESHA256 $NODE_CRYPTO.tar.gz" | sha256sum -c - \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys "$NODEPGP_KEY" \
	&& wget -qO "$NODE_CRYPTO.asc $NODEASC_URL" \
	&& gpg --verify "$NODE_CRYPTO.asc" \
	&& tar -xzvf "$NODE_CRYPTO.tar.gz" -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV NODEDATA /data
RUN mkdir "$NODEDATA" \
	&& chown -R "$NODE_CRYPTO:$NODE_CRYPTO" "$NODEDATA" \
	&& ln -sfn "$NODEDATA" "/home/$NODE_CRYPTO/.$NODE_CRYPTO" \
	&& chown -h "$NODE_CRYPTO:$NODE_CRYPTO" "/home/$NODE_CRYPTO/.$NODE_CRYPTO"
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8332 8333 18332 18333
CMD ["$NODE_CRYPTOd"]
