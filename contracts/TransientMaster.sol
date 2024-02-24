// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library TransientMaster {

    struct Variable {
        uint256 dummy;
    }

    struct Array {
        uint256 dummy;
    }

    function get(Variable storage self) internal view returns (uint256 value) {
        value = tload(
            getSlot(self)
        );
    }

    function set(Variable storage self, uint256 value) internal {
        tstore(
            getSlot(self),
            value
        );
    }

    function getAddress(Variable storage self) internal view returns (address value) {
        uint256 intermediate = get(self);
        require(intermediate < (1 << 160), "TM: casting error");
        value = address(uint160(intermediate));
    }

    function set(Variable storage self, address value) internal {
        set(self, uint256(uint160(value)));
    }

    function getBool(Variable storage self) internal view returns (bool value) {
        uint256 intermediate = get(self);
        require(intermediate < 2, "TM: casting error");
        value = intermediate == 1;
    }

    function set(Variable storage self, bool value) internal {
        set(self, value ? 1 : 0);
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