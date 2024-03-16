// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientVariables.sol";

contract TransientVariablesMock {
    using TransientVariables for *;

    TransientVariables.Uint256 u;
    TransientVariables.Address a;
    TransientVariables.Bool b;
    TransientVariables.Bytes32 bts32;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(u.get() == 0);
        assert(a.get() == address(0));
        assert(b.get() == false);
        assert(bts32.get() == bytes32(0));
        
        u.set(5);
        a.set(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        b.set(true);
        bts32.set(keccak256("Bytes32"));

        assert(u.get() == 5);
        assert(a.get() == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        assert(b.get() == true);
        assert(bts32.get() == keccak256("Bytes32"));

        callee.callback();
    }

    function afterCallback() external view {
        assert(u.get() == 5);
        assert(a.get() == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        assert(b.get() == true);
        assert(bts32.get() == keccak256("Bytes32"));
    }
}