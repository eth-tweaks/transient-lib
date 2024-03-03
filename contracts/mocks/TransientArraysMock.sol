// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientArrays.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract TransientArraysMock {
    using TransientArrays for *;

    TransientArrays.ArrayUint256 u;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external returns (uint256[] memory) {
        assert(u.length() == 0);
        
        u.push(5);

        assert(u.length() == 1);
        assert(u.get(0) == 5);

        u.push(7);

        assert(u.length() == 2);
        assert(u.get(0) == 5);
        assert(u.get(1) == 7);

        u.set(0, 3);

        assert(u.length() == 2);
        assert(u.get(0) == 3);
        assert(u.get(1) == 7);

        u.pop();

        assert(u.length() == 1);
        assert(u.get(0) == 3);

        callee.callback();

        return u.toMemory();
    }

    function afterCallback() external view {
        assert(u.length() == 1);
        assert(u.get(0) == 3);
    }
}