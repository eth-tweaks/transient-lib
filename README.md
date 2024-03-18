# Library for custom transient storage types

# Installation

Install with:

```shell
npm i transient-lib
```

To test in hardhat set target to "cancun" both in compiler and evm block in `hardhat.config.js`:

```js
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
      evmVersion: "cancun",
    },
  },
  networks: {
    hardhat: {
      hardfork: "cancun"
    },
  }
```