// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TransientMaster.sol";

library TransientMappings {
    using TransientMaster for *;

    struct MappingAddressToUint256 {
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

}