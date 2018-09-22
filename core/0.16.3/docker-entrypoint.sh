#!/bin/bash
set -e

if [[ "$1" == "litecoin-cli" || "$1" == "litecoin-tx" || "$1" == "litecoind" || "$1" == "test_litecoin" ]]; then
	mkdir -p "$LITECOIN_DATA"

	if [[ ! -s "$LITECOIN_DATA/litecoin.conf" ]]; then
		cat <<-EOF > "$LITECOIN_DATA/litecoin.conf"
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=${LITECOIN_RPC_PASSWORD:-password}
		rpcuser=${LITECOIN_RPC_USER:-litecoin}
		EOF
		chown litecoin:litecoin "$LITECOIN_DATA/litecoin.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R litecoin "$LITECOIN_DATA"
	ln -sfn "$LITECOIN_DATA" /home/litecoin/.litecoin
	chown -h litecoin:litecoin /home/litecoin/.litecoin

	exec gosu litecoin "$@"
fi

exec "$@"
