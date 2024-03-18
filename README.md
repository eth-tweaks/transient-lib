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
      evmVersion: "cancun",
    },
  },
  networks: {
    hardhat: {
      hardfork: "cancun"
    },
  }
```

Import to solidity contract and declare transient variables as storage variables. It doesnt use storage, but serves as a syntax sugar that holds a slot number

```solidity
pragma solidity ^0.8.24;

import "transient-lib/contracts/libs/TransientVariables.sol";

contract ReentrancyProtection {
    using TransientVariables for *;

    TransientVariables.Bool reentrancyFlag;

    modifier noReentrant {
        require (reentransyFlag.get() == false, "Reentrancy is not allowed");
        reentransyFlag.set(true);
    }
}
```