// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientMappings.sol";

contract TransientMappingsMock {
    using TransientMappings for *;

    TransientMappings.MappingAddressToUint256 balance;
    TransientMappings.MappingAddressToBytes32 hashes;
    TransientMappings.MappingBytes32ToBool nullifiers;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(balance.get(tx.origin) == 0);
        assert(hashes.get(tx.origin) == bytes32(0));
        assert(nullifiers.get(keccak256("1")) == false);
        
        balance.set(tx.origin, 1);
        hashes.set(tx.origin, keccak256("1"));
        nullifiers.set(keccak256("1"), true);

        assert(balance.get(tx.origin) == 1);
        assert(hashes.get(tx.origin) == keccak256("1"));
        assert(nullifiers.get(keccak256("1")) == true);

        balance.set(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF, 2);
        hashes.set(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF, keccak256("2"));
        nullifiers.set(keccak256("2"), true);

        assert(balance.get(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF) == 2);
        assert(hashes.get(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF) == keccak256("2"));
        assert(nullifiers.get(keccak256("2")) == true);

        balance.set(tx.origin, 3);
        hashes.set(tx.origin, keccak256("3"));
        nullifiers.set(keccak256("1"), false);

        assert(balance.get(tx.origin) == 3);
        assert(hashes.get(tx.origin) == keccak256("3"));
        assert(nullifiers.get(keccak256("1")) == false);

        callee.callback();
    }

    function afterCallback() external view {
        assert(balance.get(tx.origin) == 3);
        assert(hashes.get(tx.origin) == keccak256("3"));
        assert(nullifiers.get(keccak256("2")) == true);
        assert(nullifiers.get(keccak256("1")) == false);
    }
}