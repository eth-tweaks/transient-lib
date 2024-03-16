// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientMappings.sol";

contract TransientMappingsMock {
    using TransientMappings for *;

    TransientMappings.MappingAddressToUint256 balance;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(balance.get(tx.origin) == 0);
        
        balance.set(tx.origin, 1);

        assert(balance.get(tx.origin) == 1);

        balance.set(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF, 2);

        assert(balance.get(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF) == 2);

        balance.set(tx.origin, 3);

        assert(balance.get(tx.origin) == 3);

        callee.callback();
    }

    function afterCallback() external view {
        assert(balance.get(tx.origin) == 3);
    }
}