# Library for custom transient storage types

## Installation

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

    TransientVariables.Bool isReentrant;

    modifier noReentrant {
        require (isReentrant.get() == false, "Reentrancy is not allowed");
        reentransyFlag.set(true);
    }
}
```

## TransientVariables.sol

At this moment the library supports 4 static types:

```
TransientVariables.Uint256 for transient uint256
TransientVariables.Address for transient address
TransientVariables.Bytes32 for transient bytes32
TransientVariables.Bool for transient boolean
```

Use them via setters and getters

```solidity
variable.set(value);
value = variable.get;
```

## TransientArrays.sol

Only arrays of the abovementioned static types are supported:

```
TransientArrays.ArrayUint256 for array of uint256
TransientArrays.ArrayAddress for array of address
TransientArrays.ArrayBytes32 for array of bytes32
TransientArrays.ArrayBool for array of boolean
```

They are accessed by the following methods:

```solidity
arr.length() // Returns the length of the array
arr.set(index, value); // Sets value on index. Reverts on out-of-bounds
value = arr.get(index); // Gets value by index. Reverts on out-of-bounds
arr.push(value);  // Pushes a new value to the end of the array
arr.pop(); // Pops the last value from the end of the array. Reverts on empty array
arraytype[] memory arr1 = arr.toMemory(); // Writes array to memory
```

## TransientMappings.sol