#!/bin/bash
set -e

<<<<<<< HEAD
if [[ "$1" == "bitcoind" || "$1" == "litecoind" ]]; then

	mkdir -p "$DATA_FOLDER"
	
	if [[ ! -s "$DATA_FOLDER/$CONFIG.conf" && ("$CHAIN" == "bitcoin" || "$CHAIN" == "litecoin") ]]; then
		cat <<-EOF > "$DATA_FOLDER/$CONFIG.conf"
=======
if [[ "$1" == ""$NODECHAIN"-cli" || "$1" == ""$NODECHAIN"-tx" || "$1" == ""$NODECHAIN"d" || "$1" == "test_"$NODECHAIN"" ]]; then
	mkdir -p "$NODEDATA"

	if [[ ! -s "$NODEDATA/$NODECHAIN.conf" ]]; then
		cat <<-EOF > "$NODEDATA/$NODECHAIN.conf"
>>>>>>> master
		printtoconsole=1
		rpcallowip=::/0
		rpcpassword=admin
		rpcuser=admin
		EOF
<<<<<<< HEAD
		chown "$CHAIN:$CHAIN" "$DATA_FOLDER/$CHAIN.conf"
	elif [[ ! -s "$DATA_FOLDER/$CONFIG.conf" && "$CHAIN" == "dcr" ]]; then
		cat <<-EOF > "$DATA_FOLDER/$CONFIG.conf"
		rpcpass=admin
		rpcuser=admin
		EOF
		chown "$CHAIN:$CHAIN" "$DATA_FOLDER/$CONFIG.conf"
=======
		chown "$NODECHAIN:$NODECHAIN" "$NODEDATA/$NODECHAIN.conf"
>>>>>>> master
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
<<<<<<< HEAD
	chown -R "$CHAIN" "$DATA_FOLDER"
	ln -sfn "$DATA_FOLDER" "$DEFAULT_FOLDER"
	chown -h "$CHAIN:$CHAIN" "$DEFAULT_FOLDER"

	exec gosu "$CHAIN" "$@"
=======
	chown -R "$NODECHAIN" "$NODEDATA"
	ln -sfn "$NODEDATA" "/home/$NODECHAIN/.$NODECHAIN"
	chown -h "$NODECHAIN:$NODECHAIN" "/home/$NODECHAIN/.$NODECHAIN"

	exec gosu "$NODECHAIN" "$@"
>>>>>>> master
fi

exec "$@"
