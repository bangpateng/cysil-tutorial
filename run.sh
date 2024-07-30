#!/bin/bash

if [ -z "$1" ]; then
  echo "Masukann: sh run.sh <alamat-evm-anda>"
  exit 1
fi

CLAIM_REWARD_ADDRESS=$1

rm -rf ~/cysic-verifier

cd ~
mkdir cysic-verifier

curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux > ~/cysic-verifier/verifier
curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so > ~/cysic-verifier/libzkp.so

cat <<EOF > ~/cysic-verifier/config.yaml
chain:
  endpoint: "testnet-node-1.prover.xyz:9090"
  chain_id: "cysicmint_9000-1"
  gas_coin: "cysic"
  gas_price: 10
claim_reward_address: "$CLAIM_REWARD_ADDRESS"

server:
  cysic_endpoint: "https://api-testnet.prover.xyz"
EOF

cd ~/cysic-verifier/
chmod +x ~/cysic-verifier/verifier

cat <<EOF > ~/cysic-verifier/start.sh

export LD_LIBRARY_PATH=.:~/miniconda3/lib:\$LD_LIBRARY_PATH
export CHAIN_ID=534352
./verifier
EOF

chmod +x ~/cysic-verifier/start.sh

~/cysic-verifier/start.sh
