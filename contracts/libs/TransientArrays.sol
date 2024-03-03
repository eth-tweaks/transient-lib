// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./TransientMaster.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library TransientArrays {
    using TransientMaster for *;

    struct ArrayUint256 {
        uint256 dummy;
    }

    function set(ArrayUint256 storage v, uint256 index, uint256 value) internal {
        TransientMaster.Array storage arr = ArrayUint256ToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        arr.getVariable(index).setUint256(value);
    }

    function get(ArrayUint256 storage v, uint256 index) internal view returns (uint256 value) {
        TransientMaster.Array storage arr = ArrayUint256ToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        value = arr.getVariable(index).getUint256();
    }

    function push(ArrayUint256 storage v, uint256 value) internal {
        TransientMaster.Array storage arr = ArrayUint256ToArray(v);
        uint256 l = arr.length();
        arr.resize(l + 1);
        arr.getVariable(l).setUint256(value);
    }

    function pop(ArrayUint256 storage v) internal {
        TransientMaster.Array storage arr = ArrayUint256ToArray(v);
        arr.pop();
    }

    function length(ArrayUint256 storage v) internal view returns (uint256) {
        return ArrayUint256ToArray(v).length();
    }

    function toMemory(ArrayUint256 storage v) internal view returns (uint256[] memory r) {
        return ArrayUint256ToArray(v).toUint256Memory();
    }

    function ArrayUint256ToArray(
        ArrayUint256 storage v
    ) private pure returns(TransientMaster.Array storage r) {
        assembly {
            r.slot := v.slot
        }
    }
}
