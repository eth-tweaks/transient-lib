// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library TransientMaster {

    struct Variable {
        uint256 dummy;
    }

    struct Array {
        uint256 dummy;
    }

    struct Mapping {
        uint256 dummy;
    }

    function getVariable(
        Array storage self, 
        uint256 index
    ) internal pure returns (Variable storage result) {
        uint256 resultSlot = calculateArraySlot(
            getSlot(self),
            index
        );

        assembly{
            result.slot := resultSlot
        }
    }

    function getArray(
        Array storage self, 
        uint256 index
    ) internal pure returns (Array storage result) {
        uint256 resultSlot = calculateArraySlot(
            getSlot(self),
            index
        );

        assembly{
            result.slot := resultSlot
        }
    }

    function length(Array storage self) internal view returns (uint256) {
        return tload(getSlot(self));
    }

    function pop(Array storage self) internal {
        uint256 l = length(self);
        require(l > 0, "TM: trying to pop empty array");
        l--;
        tstore(getSlot(self), l);
    }

    function resize(Array storage self, uint256 newLength) internal {
        tstore(getSlot(self), newLength);
    }

    function toUint256Memory(Array storage self) internal view returns(uint256[] memory result) {
        uint256 l = length(self);
        result = new uint256[](l);
        for (uint i = 0; i < l; i++) {
            TransientMaster.Variable storage v = getVariable(self, i);
            result[i] = getUint256(v);
        }
    }

    function getMapping(
        Array storage self, 
        uint256 index
    ) internal pure returns (Mapping storage result) {
        uint256 resultSlot = calculateArraySlot(
            getSlot(self),
            index
        );

        assembly{
            result.slot := resultSlot
        }
    }

    function getVariable(
        Mapping storage self,
        uint256 key
    ) internal pure returns (Variable storage result) {
        uint256 resultSlot = calculateMappingSlot(getSlot(self), key);
        
        assembly {
            result.slot := resultSlot
        }
    }

    function getVariable(
        Mapping storage self,
        address key
    ) internal pure returns (Variable storage result) {
        uint256 resultSlot = calculateMappingSlot(getSlot(self), uint256(uint160(key)));
        
        assembly {
            result.slot := resultSlot
        }
    }

    function getVariable(
        Mapping storage self,
        bytes32 key
    ) internal pure returns (Variable storage result) {
        uint256 resultSlot = calculateMappingSlot(getSlot(self), uint256(key));
        
        assembly {
            result.slot := resultSlot
        }
    }

    function getVariable(
        Mapping storage self,
        bool key
    ) internal pure returns (Variable storage result) {
        uint256 resultSlot = calculateMappingSlot(getSlot(self), key ? 1 : 0);
        
        assembly {
            result.slot := resultSlot
        }
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
        require(intermediate < (1 << 160), "TM: address casting error");
        value = address(uint160(intermediate));
    }

    function setAddress(Variable storage self, address value) internal {
        setUint256(self, uint256(uint160(value)));
    }

    function getBytes32(Variable storage self) internal view returns (bytes32 value) {
        uint256 intermediate = getUint256(self);
        value = bytes32(intermediate);
    }

    function setBytes32(Variable storage self, bytes32 value) internal {
        setUint256(self, uint256(value));
    }

    function getBool(Variable storage self) internal view returns (bool value) {
        uint256 intermediate = getUint256(self);
        require(intermediate < 2, "TM: bool casting error");
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

    function getSlot(Array storage self) private pure returns (uint256 slot) {
        assembly {
            slot := self.slot
        }
    }

    function getSlot(Mapping storage self) private pure returns (uint256 slot) {
        assembly {
            slot := self.slot
        }
    }

    function calculateArraySlot(uint256 slot, uint256 index) private pure returns (uint256 resultSlot) {
        unchecked {
            resultSlot = uint256(
                keccak256(
                    abi.encode(slot)
                )
            ) + index;
        }
    }

    function calculateMappingSlot(uint256 slot, uint256 key) private pure returns (uint256 resultSlot) {
        resultSlot = uint256(
            keccak256(
                abi.encode(key, slot)
            )
        );
    }
}