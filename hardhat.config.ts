import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ignition";
import "@nomicfoundation/hardhat-verify";

import dotenv from "dotenv";
dotenv.config();

const {
  TESTNET_ALCHEMY_RPC_URL,
  TESTNET_WALLET_PRIVATE_KEY,
  TESTNET_ETHSCAN_API_KEY,
} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  defaultNetwork: "sepolia",
  networks: {
    sepolia: {
      url: TESTNET_ALCHEMY_RPC_URL,
      accounts: [`0x${TESTNET_WALLET_PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: TESTNET_ETHSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  },
};

export default config;
