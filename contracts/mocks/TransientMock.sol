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
        
        u.setUint256(5);
        a.setAddress(address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        b.setBool(true);

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
        u.setUint256(value);
    }

    function testAddressRevert(uint256 value) external returns(address) {
        u.setUint256(value);
        return u.getAddress();
    }

    function testBoolRevert(uint256 value) external returns(bool) {
        u.setUint256(value);
        return u.getBool();
    }
}