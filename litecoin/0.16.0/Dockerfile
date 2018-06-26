FROM debian:stretch-slim

ENV NODECHAIN litecoin
ENV NODEVERSION 0.16.0
ENV NODEURL https://download.litecoin.org/litecoin-0.16.0/linux/litecoin-0.16.0-x86_64-linux-gnu.tar.gz
ENV NODESHA256 5a1dfaea8d70f4d0d61190061631d6ad40cb3662e7718660000c43f564c348e6



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
