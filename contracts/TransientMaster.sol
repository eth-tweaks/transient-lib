// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library TransientMaster {
    
    struct Uint256 {
        uint256 value;
    }

    struct Variable {
        uint256 value;
    }

    function getUint256(Variable storage self) internal view returns (uint256 value) {
        assembly {
            value := sload(self.slot)
        }
    }

    function setUint256(Uint256 storage self, uint256 value) internal {
        assembly {
            sstore(self.slot, value)
        }
    }


    function get(Uint256 storage self) internal view returns (uint256 value) {
        assembly {
            value := tload(self.slot)
        }
    }

    function set(Uint256 storage self, uint256 value) internal {
        assembly {
            tstore(self.slot, value)
        }
    }

    function tload(uint256 slot) private view returns (uint256 value) {
        assembly {
            value := tload(slot)
        }
    }

    function tstore(uint256 slot, uint256 value) private {
        assembly {
            tstore(slot, value)
        }
    }

    function getSlot(Variable storage self) private pure returns (uint256 slot) {
        assembly {
            slot := self.slot
        }
    }
}