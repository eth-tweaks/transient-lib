// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library TransientMaster {
    
    struct Uint256 {
        uint256 value;
    }

    function get(Uint256 storage self) internal view returns (uint256 value) {
        assembly {
            value := sload(self.slot)
        }
    }

    function set(Uint256 storage self, uint256 value) internal {
        assembly {
            sstore(self.slot, value)
        }
    }
}