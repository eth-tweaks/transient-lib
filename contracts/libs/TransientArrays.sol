// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TransientMaster.sol";

library TransientArrays {
    using TransientMaster for *;

    struct ArrayUint256 {
        uint256 dummy;
    }

    struct ArrayAddress {
        uint256 dummy;
    }

    struct ArrayBool {
        uint256 dummy;
    }

    struct ArrayBytes32 {
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

    function set(ArrayAddress storage v, uint256 index, address value) internal {
        TransientMaster.Array storage arr = ArrayAddressToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        arr.getVariable(index).setAddress(value);
    }

    function get(ArrayAddress storage v, uint256 index) internal view returns (address value) {
        TransientMaster.Array storage arr = ArrayAddressToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        value = arr.getVariable(index).getAddress();
    }

    function push(ArrayAddress storage v, address value) internal {
        TransientMaster.Array storage arr = ArrayAddressToArray(v);
        uint256 l = arr.length();
        arr.resize(l + 1);
        arr.getVariable(l).setAddress(value);
    }

    function pop(ArrayAddress storage v) internal {
        TransientMaster.Array storage arr = ArrayAddressToArray(v);
        arr.pop();
    }

    function length(ArrayAddress storage v) internal view returns (uint256) {
        return ArrayAddressToArray(v).length();
    }

    function toMemory(ArrayAddress storage v) internal view returns (address[] memory r) {
        uint256[] memory temp = ArrayAddressToArray(v).toUint256Memory();
        assembly {
            r := temp
        }
    }

    function ArrayAddressToArray(
        ArrayAddress storage v
    ) private pure returns(TransientMaster.Array storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(ArrayBool storage v, uint256 index, bool value) internal {
        TransientMaster.Array storage arr = ArrayBoolToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        arr.getVariable(index).setBool(value);
    }

    function get(ArrayBool storage v, uint256 index) internal view returns (bool value) {
        TransientMaster.Array storage arr = ArrayBoolToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        value = arr.getVariable(index).getBool();
    }

    function push(ArrayBool storage v, bool value) internal {
        TransientMaster.Array storage arr = ArrayBoolToArray(v);
        uint256 l = arr.length();
        arr.resize(l + 1);
        arr.getVariable(l).setBool(value);
    }

    function pop(ArrayBool storage v) internal {
        TransientMaster.Array storage arr = ArrayBoolToArray(v);
        arr.pop();
    }

    function length(ArrayBool storage v) internal view returns (uint256) {
        return ArrayBoolToArray(v).length();
    }

    function toMemory(ArrayBool storage v) internal view returns (bool[] memory r) {
        uint256[] memory temp = ArrayBoolToArray(v).toUint256Memory();
        assembly {
            r := temp
        }
    }

    function ArrayBoolToArray(
        ArrayBool storage v
    ) private pure returns(TransientMaster.Array storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(ArrayBytes32 storage v, uint256 index, bytes32 value) internal {
        TransientMaster.Array storage arr = ArrayBytes32ToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        arr.getVariable(index).setBytes32(value);
    }

    function get(ArrayBytes32 storage v, uint256 index) internal view returns (bytes32 value) {
        TransientMaster.Array storage arr = ArrayBytes32ToArray(v);
        require(index < arr.length(), "TA: out of bounds");
        value = arr.getVariable(index).getBytes32();
    }

    function push(ArrayBytes32 storage v, bytes32 value) internal {
        TransientMaster.Array storage arr = ArrayBytes32ToArray(v);
        uint256 l = arr.length();
        arr.resize(l + 1);
        arr.getVariable(l).setBytes32(value);
    }

    function pop(ArrayBytes32 storage v) internal {
        TransientMaster.Array storage arr = ArrayBytes32ToArray(v);
        arr.pop();
    }

    function length(ArrayBytes32 storage v) internal view returns (uint256) {
        return ArrayBytes32ToArray(v).length();
    }

    function toMemory(ArrayBytes32 storage v) internal view returns (bytes32[] memory r) {
        uint256[] memory temp = ArrayBytes32ToArray(v).toUint256Memory();
        assembly {
            r := temp
        }
    }

    function ArrayBytes32ToArray(
        ArrayBytes32 storage v
    ) private pure returns(TransientMaster.Array storage r) {
        assembly {
            r.slot := v.slot
        }
    }
}
