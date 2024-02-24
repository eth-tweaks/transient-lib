// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library TransientMaster {

    struct Variable {
        uint256 value;
    }

    function getUint256(Variable storage self) internal view returns (uint256 value) {
        value = tload(
            getSlot(self)
        );
    }

    function setUint256(Variable storage self, uint256 value) internal {
        tstore(
            getSlot(self),
            value
        );
    }

    function getAddress(Variable storage self) internal view returns (address value) {
        uint256 intermediate = getUint256(self);
        require(intermediate < (1 << 160), "TM: casting error");
        value = address(uint160(intermediate));
    }

    function setAddress(Variable storage self, address value) internal {
        setUint256(self, uint256(uint160(value)));
    }

    function getBool(Variable storage self) internal view returns (bool value) {
        uint256 intermediate = getUint256(self);
        require(intermediate < 2, "TM: casting error");
        value = intermediate == 1;
    }

    function setBool(Variable storage self, bool value) internal {
        setUint256(self, value ? 1 : 0);
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