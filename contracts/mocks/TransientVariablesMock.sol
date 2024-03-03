// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientVariables.sol";

contract TransientVariablesMock {
    using TransientVariables for *;

    TransientVariables.Uint256 u;
    TransientVariables.Address a;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(u.get() == 0);
        assert(a.get() == address(0));
        
        u.set(5);
        a.set(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);

        assert(u.get() == 5);
        assert(a.get() == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);

        callee.callback();
    }

    function afterCallback() external view {
        assert(u.get() == 5);
        assert(a.get() == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
    }
}