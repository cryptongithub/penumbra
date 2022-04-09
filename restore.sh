#!/bin/bash

if curl > /dev/null 2>&1; then
	echo ''
else
  sudo apt install curl -y
fi

clear && curl -s https://raw.githubusercontent.com/cryptongithub/init/main/logo.sh | bash && sleep 3

sudo apt update && sudo apt upgrade -y

sudo apt install make git tar wget clang pkg-config libssl-dev jq build-essential -y

if cargo > /dev/null 2>&1; then
	echo ''
else
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

source ~/.cargo/env 

rm -rf $HOME/penumbra && git clone https://github.com/penumbra-zone/penumbra

cd $HOME/penumbra && git checkout 006-orthosie

cargo build --release --bin pcli

sudo rm -r /root/.local/share/pcli/penumbra_wallet.json && sudo rm -rf /root/.local/share/penumbra-testnet-archive/

echo -e '\e[40m\e[92m' && read -p "Enter spend seed: " SPENDSEED && echo -e '\e[0m'

cd $HOME/penumbra && cargo run --quiet --release --bin pcli wallet import $SPENDSEED 

SPENDSEED=

cd $HOME/penumbra && cargo run --quiet --release --bin pcli wallet reset

export RUST_LOG=info

cd $HOME/penumbra && cargo run --quiet --release --bin pcli sync

cd $HOME/penumbra && cargo run --quiet --release --bin pcli balance
