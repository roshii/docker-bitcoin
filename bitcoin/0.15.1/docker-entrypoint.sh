#!/bin/bash
set -e

if [[ "$1" == ""$NODECHAIN"-cli" || "$1" == ""$NODECHAIN"-tx" || "$1" == ""$NODECHAIN"d" || "$1" == "test_"$NODECHAIN"" ]]; then
	mkdir -p "$NODEDATA"

	if [[ ! -s "$NODEDATA/$NODECHAIN.conf" ]]; then
		cat <<-EOF > "$NODEDATA/$NODECHAIN.conf"
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=${$NODECHAIN_RPC_PASSWORD:-password}
		rpcuser=${$NODECHAIN_RPC_USER:-"$NODECHAIN"}
		EOF
		chown "$NODECHAIN:$NODECHAIN" "$NODEDATA/$NODECHAIN.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R "$NODECHAIN" "$NODEDATA"
	ln -sfn "$NODEDATA" "/home/$NODECHAIN/.$NODECHAIN"
	chown -h "$NODECHAIN:$NODECHAIN" "/home/$NODECHAIN/.$NODECHAIN"

	exec gosu "$NODECHAIN" "$@"
fi

exec "$@"
