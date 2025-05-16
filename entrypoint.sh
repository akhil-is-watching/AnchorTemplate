#!/bin/sh

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 21.7.0
nvm use 21.7.0
npm install -g yarn

git clone https://github.com/akhil-is-watching/AnchorTemplate.git
cd AnchorTemplate
npm install
anchor build
anchor test

tail -f /dev/null