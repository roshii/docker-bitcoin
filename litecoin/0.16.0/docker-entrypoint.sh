#!/bin/bash
set -e

if [[ "$1" == "bitcoind" || "$1" == "litecoind" ]]; then

	mkdir -p "$DATA_FOLDER"
	
	if [[ ! -s "$DATA_FOLDER/$CONFIG.conf" && ("$CHAIN" == "bitcoin" || "$CHAIN" == "litecoin") ]]; then
		cat <<-EOF > "$DATA_FOLDER/$CONFIG.conf"
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=admin
		rpcuser=admin
		EOF
		chown "$CHAIN:$CHAIN" "$DATA_FOLDER/$CHAIN.conf"
	elif [[ ! -s "$DATA_FOLDER/$CONFIG.conf" && "$CHAIN" == "dcr" ]]; then
		cat <<-EOF > "$DATA_FOLDER/$CONFIG.conf"
		rpcpass=admin
		rpcuser=admin
		EOF
		chown "$CHAIN:$CHAIN" "$DATA_FOLDER/$CONFIG.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R "$CHAIN" "$DATA_FOLDER"
	ln -sfn "$DATA_FOLDER" "$DEFAULT_FOLDER"
	chown -h "$CHAIN:$CHAIN" "$DEFAULT_FOLDER"

	exec gosu "$CHAIN" "$@"
fi

exec "$@"
