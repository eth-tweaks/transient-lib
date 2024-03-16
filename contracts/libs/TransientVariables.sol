// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TransientMaster.sol";

library TransientVariables {
    using TransientMaster for *;

    struct Uint256 {
        uint256 dummy;
    }

    struct Address {
        uint256 dummy;
    }

    struct Bool {
        uint256 dummy;
    }

    struct Bytes32 {
        uint256 dummy;
    }

    function set(Uint256 storage v, uint256 value) internal {
        Uint256ToVariable(v).setUint256(value);
    }

    function get(Uint256 storage v) internal view returns (uint256 value) {
        value = Uint256ToVariable(v).getUint256();
    }

    function Uint256ToVariable(
        Uint256 storage v
    ) private pure returns(TransientMaster.Variable storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(Address storage v, address value) internal {
        AddressToVariable(v).setAddress(value);
    }

    function get(Address storage v) internal view returns (address value) {
        value = AddressToVariable(v).getAddress();
    }

    function AddressToVariable(
        Address storage v
    ) private pure returns(TransientMaster.Variable storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(Bool storage v, bool value) internal {
        BoolToVariable(v).setBool(value);
    }

    function get(Bool storage v) internal view returns (bool value) {
        value = BoolToVariable(v).getBool();
    }

    function BoolToVariable(
        Bool storage v
    ) private pure returns(TransientMaster.Variable storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(Bytes32 storage v, bytes32 value) internal {
        Bytes32ToVariable(v).setBytes32(value);
    }

    function get(Bytes32 storage v) internal view returns (bytes32 value) {
        value = Bytes32ToVariable(v).getBytes32();
    }

    function Bytes32ToVariable(
        Bytes32 storage v
    ) private pure returns(TransientMaster.Variable storage r) {
        assembly {
            r.slot := v.slot
        }
    }
}