// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientVariables.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract TransientVariablesMock {
    using TransientVariables for *;

    TransientVariables.Uint256 u;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(u.get() == 0);
        
        u.set(5);

        assert(u.get() == 5);

        callee.callback();
    }

    function afterCallback() external view {
        assert(u.get() == 5);
    }
}