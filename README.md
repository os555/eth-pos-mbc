# Ethereum Proof-of-Stake 

This repository provides a docker-compose file to run a fully-functional, local development network for Ethereum with proof-of-stake enabled. This configuration uses [Lighthouse](https://github.com/sigp/lighthouse) as a consensus client and [Reth](https://github.com/paradigmxyz/reth) for execution. **It starts from proof-of-stake** and does not go through the Ethereum merge.

This sets up a single node development network with 64 deterministically-generated validator keys to drive the creation of blocks in an Ethereum proof-of-stake chain. Here's how it works:

1. We initialize a Reth, execution development node from a genesis config
2. We initialize a Lighthouse beacon chain, proof-of-stake development node from a genesis config

The development net is fully functional and allows for the deployment of smart contracts and all the features that also come with the Prysm consensus client such as its rich set of APIs for retrieving data from the blockchain. This development net is a great way to understand the internals of Ethereum proof-of-stake and to mess around with the different settings that make the system possible.

## Using

First, install Docker. Then, run:

```
git clone https://github.com/os555/eth-pos-mbc && cd eth-pos-mbc
./generate_genesis_data.sh
openssl rand -hex 32 | tr -d "\n" > ./config/metadata/jwtsecret
docker compose up -d
```

You will see the following (assuming your project directory is `eth-pos-mbc`):

```
$ docker compose up -d
[+] Running 5/5
 ✔ Network eth-pos-mbc_default        Created 
 ✔ Container eth-pos-mbc-init-reth-1    Started 
 ✔ Container eth-pos-mbc-reth-1         Started 
 ✔ Container eth-pos-mbc-beacon-1       Started 
 ✔ Container eth-pos-mbc-validator-1    Started 

```

Each time you restart, you can wipe the old data using `./clean.sh`.

Next, you can inspect the logs of the different services launched. 

```
 docker compose logs -f --tail 30 reth
```

# Available Features

- Starts from the deneb Ethereum hard fork
- The network launches with a [Validator Deposit Contract](https://github.com/ethereum/consensus-specs/blob/dev/solidity_deposit_contract/deposit_contract.sol) deployed at address `0x5454545454545454545454545454545454545454`. This can be used to onboard new validators into the network by depositing 32 ETH into the contract
- The default account used in the Reth node is address `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` which comes seeded with ETH for use in the network. This can be used to send transactions, deploy contracts, and more
- The default account, `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` is also set as the fee recipient for transaction fees proposed validators in Lighthouse. This address will be receiving the fees of all proposer activity
- The Reth JSON-RPC API is available at http://localhost:9545 (accessible from your host machine)
- The Lighthouse client also exposes a gRPC API at http://beacon:5052
![Screenshot 2567-11-22 at 21 42 10](https://github.com/user-attachments/assets/46dd4a21-d51d-4c62-87e9-88e22cac1b77)


