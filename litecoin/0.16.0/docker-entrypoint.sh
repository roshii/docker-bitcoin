#!/bin/bash
set -e

if [[ "$1" == ""$CHAIN"-cli" || "$1" == ""$CHAIN"-tx" || "$1" == ""$CHAIN"d" || "$1" == "test_"$CHAIN"" ]]; then
	mkdir -p "$DATA_FOLDER"

	if [[ ! -s "$DATA_FOLDER/$CHAIN.conf" ]]; then
		cat <<-EOF > "$DATA_FOLDER/$CHAIN.conf"
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=admin
		rpcuser=admin
		EOF
		chown "$CHAIN:$CHAIN" "$DATA_FOLDER/$CHAIN.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R "$CHAIN" "$DATA_FOLDER"
	ln -sfn "$DATA_FOLDER" "DEFAULT_FOLDER"
	chown -h "$CHAIN:$CHAIN" "DEFAULT_FOLDER"

	exec gosu "$CHAIN" "$@"
fi

exec "$@"
