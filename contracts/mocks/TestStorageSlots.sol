// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TestStorageSlots {
    uint public dummy;
    uint[] public arr;
    
    function testArray() external {
        arr.push(1);
        arr.push(2);
        uint256 slot;
        assembly {
            slot := arr.slot
        }
        slot = uint256(keccak256(abi.encode(slot)));
        
        uint256 result;
        assembly {
            result := sload(slot)
        }

        assert(result == 1);

        slot += 1;
        assembly {
            result := sload(slot)
        }

        assert(result == 2);
    }

    function testArrayOverflow() external {
        dummy = 555;

        uint256 slot;
        uint256 maxUint = type(uint).max;
        assembly {
            slot := arr.slot
            sstore(slot, maxUint)
        }

        slot = uint256(keccak256(abi.encode(slot)));
        uint slotOverflow = maxUint - slot + 1;
        
        assert(arr[slotOverflow] == 555);

        uint one;
        slotOverflow++;
        unchecked {
            one = slot + slotOverflow;
        }
        assert(one == 1);
    }
}