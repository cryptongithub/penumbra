#!/bin/baif curl > /dev/null 2>&1; then
	echo ''
else
  sudo apt install curl -y
fi

clear && curl -s https://raw.githubusercontent.com/cryptongithub/init/main/logo.sh | bash && sleep 3

sudo apt update && sudo apt upgrade -y

sudo apt install make tar wget clang pkg-config libssl-dev jq build-essential -y

if git > /dev/null 2>&1; then
	echo ''
else
  sudo apt install git -y
fi


ADDRESS=$(cargo run --quiet --release --bin pcli addr list | grep -oP '(?<=penumbra).*')

echo -e '\n\e[42m==================================================\e[0m\n'
echo -e '\e[42mSAVE ALL DATA BELOW\e[0m'
echo -e '\n\e[42m==================================================\e[0m\n' && sleep 2

echo -e 'Address:'
echo 'penumbra'$ADDRESS
echo -e '\nWallet info and spend seed:'
cat /root/.local/share/pcli/penumbra_wallet.json && echo -e '\n'

echo -e '\n\e[42m==================================================\e[0m\n'
echo -e '\e[42mSAVE ALL DATA ABOVE\e[0m' 
echo -e '\n\e[42m==================================================\e[0m\n' && sleep 2
