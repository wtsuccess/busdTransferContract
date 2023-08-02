import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import { config as dotenvConfig } from "dotenv";

dotenvConfig();
const { API_URL, PRIVATE_KEY } = process.env;
const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.18',
        settings: {
          optimizer: {
            enabled: false,
            runs: 200
          }
        }
      },
      {
        version: '0.8.0',
        settings: {
          optimizer: {
            enabled: false,
            runs: 200
          }
        }
      },
    ]
  },
  defaultNetwork: "bsc",
  networks: {
    hardhat: {},
    bsc: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: "XPA2KYAN6PEA686X3DQW7EEZJYCKM9IKSQ",
  },
};

export default config;
