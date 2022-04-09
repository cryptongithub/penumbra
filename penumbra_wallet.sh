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

sudo rm -r /root/.local/share/pcli/penumbra_wallet.json && sudo rm -rf /root/.local/share/penumbra-testnet-archive/

rm -rf $HOME/penumbra && git clone https://github.com/penumbra-zone/penumbra

cd penumbra && git checkout 006-orthosie

cd $HOME/penumbra && cargo build --release --bin pcli 

cd $HOME/penumbra &&  cargo run --quiet --release --bin pcli wallet generate

ADDRESS=$(cargo run --quiet --release --bin pcli addr list | grep -oP '(?<=penumbra).*')

echo -e '\n\e[42m==================================================\e[0m\n'
echo -e '\e[42mSAVE ALL DATA BELOW\e[0m'
echo -e '\n\e[42m==================================================\e[0m\n' && sleep 2

echo -e '\nAddress:'
echo 'penumbra'$ADDRESS
echo -e '\nWallet info and spend seed:'
cat /root/.local/share/pcli/penumbra_wallet.json && echo -e '\n'

echo -e '\n\e[42m==================================================\e[0m\n'
echo -e '\e[42mSAVE ALL DATA ABOVE\e[0m' 
echo -e '\n\e[42m==================================================\e[0m\n' && sleep 2
