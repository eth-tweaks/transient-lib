// SPDX-License-Identifier: UNLICENSED
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
}