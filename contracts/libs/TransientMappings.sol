// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TransientMaster.sol";

library TransientMappings {
    using TransientMaster for *;

    struct MappingAddressToUint256 {
        uint256 dummy;
    }

    struct MappingAddressToBytes32 {
        uint256 dummy;
    }

    struct MappingBytes32ToBool {
        uint256 dummy;
    }

    function set(
        MappingAddressToUint256 storage self,
        address key,
        uint256 value
    ) internal {
        TransientMaster.Mapping storage m = MappingAddressUint256ToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        v.setUint256(value);
    }

    function get(
        MappingAddressToUint256 storage self,
        address key
    ) internal view returns (uint256 value) {
        TransientMaster.Mapping storage m = MappingAddressUint256ToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        value = v.getUint256();
    }

    function MappingAddressUint256ToMapping(
        MappingAddressToUint256 storage v
    ) private pure returns(TransientMaster.Mapping storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(
        MappingAddressToBytes32 storage self,
        address key,
        bytes32 value
    ) internal {
        TransientMaster.Mapping storage m = MappingAddressBytes32ToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        v.setBytes32(value);
    }

    function get(
        MappingAddressToBytes32 storage self,
        address key
    ) internal view returns (bytes32 value) {
        TransientMaster.Mapping storage m = MappingAddressBytes32ToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        value = v.getBytes32();
    }


    function MappingAddressBytes32ToMapping(
        MappingAddressToBytes32 storage v
    ) private pure returns(TransientMaster.Mapping storage r) {
        assembly {
            r.slot := v.slot
        }
    }

    function set(
        MappingBytes32ToBool storage self,
        bytes32 key,
        bool value
    ) internal {
        TransientMaster.Mapping storage m = MappingBytes32BoolToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        v.setBool(value);
    }

    function get(
        MappingBytes32ToBool storage self,
        bytes32 key
    ) internal view returns (bool value) {
        TransientMaster.Mapping storage m = MappingBytes32BoolToMapping(self);
        TransientMaster.Variable storage v = m.getVariable(key);
        value = v.getBool();
    }


    function MappingBytes32BoolToMapping(
        MappingBytes32ToBool storage v
    ) private pure returns(TransientMaster.Mapping storage r) {
        assembly {
            r.slot := v.slot
        }
    }
}