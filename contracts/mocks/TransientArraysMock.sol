// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientArrays.sol";

contract TransientArraysMock {
    using TransientArrays for *;

    TransientArrays.ArrayUint256 u;
    TransientArrays.ArrayAddress a;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external returns (uint256[] memory, address[] memory) {
        assert(u.length() == 0);
        assert(a.length() == 0);
        
        u.push(5);
        a.push(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);

        assert(u.length() == 1);
        assert(u.get(0) == 5);
        assert(a.length() == 1);
        assert(a.get(0) == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);

        u.push(7);
        a.push(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

        assert(u.length() == 2);
        assert(u.get(0) == 5);
        assert(u.get(1) == 7);
        assert(a.length() == 2);
        assert(a.get(0) == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        assert(a.get(1) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

        u.set(0, 3);
        a.set(0, 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);

        assert(u.length() == 2);
        assert(u.get(0) == 3);
        assert(u.get(1) == 7);
        assert(a.length() == 2);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
        assert(a.get(1) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

        u.pop();
        a.pop();

        assert(u.length() == 1);
        assert(u.get(0) == 3);
        assert(a.length() == 1);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);

        callee.callback();

        return (u.toMemory(), a.toMemory());
    }

    function afterCallback() external view {
        assert(u.length() == 1);
        assert(u.get(0) == 3);

        assert(a.length() == 1);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
    }
}