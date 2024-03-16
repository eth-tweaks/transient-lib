// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientArrays.sol";

contract TransientArraysMock {
    using TransientArrays for *;

    TransientArrays.ArrayUint256 u;
    TransientArrays.ArrayAddress a;
    TransientArrays.ArrayBool b;
    TransientArrays.ArrayBytes32 bts32;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external returns (
        uint256[] memory, 
        address[] memory, 
        bool[] memory,
        bytes32[] memory
    ) {
        assert(u.length() == 0);
        assert(a.length() == 0);
        assert(b.length() == 0);
        assert(bts32.length() == 0);
        
        u.push(5);
        a.push(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        b.push(true);
        bts32.push(keccak256("1"));

        assert(u.length() == 1);
        assert(u.get(0) == 5);
        assert(a.length() == 1);
        assert(a.get(0) == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        assert(b.get(0) == true);
        assert(bts32.get(0) == keccak256("1"));

        u.push(7);
        a.push(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        b.push(false);
        bts32.push(keccak256("2"));

        assert(u.length() == 2);
        assert(u.get(0) == 5);
        assert(u.get(1) == 7);
        assert(a.length() == 2);
        assert(a.get(0) == 0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);
        assert(a.get(1) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        assert(b.length() == 2);
        assert(b.get(0) == true);
        assert(b.get(1) == false);
        assert(bts32.length() == 2);
        assert(bts32.get(0) == keccak256("1"));
        assert(bts32.get(1) == keccak256("2"));

        u.set(0, 3);
        a.set(0, 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
        b.set(0, false);
        bts32.set(0, keccak256("3"));

        assert(u.length() == 2);
        assert(u.get(0) == 3);
        assert(u.get(1) == 7);
        assert(a.length() == 2);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
        assert(a.get(1) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        assert(b.length() == 2);
        assert(b.get(0) == false);
        assert(b.get(1) == false);
        assert(bts32.length() == 2);
        assert(bts32.get(0) == keccak256("3"));
        assert(bts32.get(1) == keccak256("2"));

        u.pop();
        a.pop();
        b.pop();
        bts32.pop();

        assert(u.length() == 1);
        assert(u.get(0) == 3);
        assert(a.length() == 1);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
        assert(b.length() == 1);
        assert(b.get(0) == false);
        assert(bts32.length() == 1);
        assert(bts32.get(0) == keccak256("3"));

        callee.callback();

        return (u.toMemory(), a.toMemory(), b.toMemory(), bts32.toMemory());
    }

    function afterCallback() external view {
        assert(u.length() == 1);
        assert(u.get(0) == 3);

        assert(a.length() == 1);
        assert(a.get(0) == 0xDDdDddDdDdddDDddDDddDDDDdDdDDdDDdDDDDDDd);
 
        assert(b.length() == 1);
        assert(b.get(0) == false);

        assert(bts32.length() == 1);
        assert(bts32.get(0) == keccak256("3"));
   }
}