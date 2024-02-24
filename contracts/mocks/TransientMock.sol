// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../TransientMaster.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract TransientMock {
    using TransientMaster for *;

    TransientMaster.Variable u;
    TransientMaster.Variable a;
    TransientMaster.Variable b;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(u.getUint256() == 0);
        assert(a.getAddress() == address(0));
        assert(b.getBool() == false);
        
        u.set(5);
        a.set(address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        b.set(true);

        assert(u.getUint256() == 5);
        assert(a.getAddress() == address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        assert(b.getBool() == true);

        callee.callback();
    }

    function afterCallback() external view {
        assert(u.getUint256() == 5);
        assert(a.getAddress() == address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        assert(b.getBool() == true);
    }

    function setUint(uint256 value) external {
        u.set(value);
    }

    function testAddressRevert(uint256 value) external returns(address) {
        u.set(value);
        return u.getAddress();
    }

    function testBoolRevert(uint256 value) external returns(bool) {
        u.set(value);
        return u.getBool();
    }
}