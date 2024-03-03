// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../libs/TransientMaster.sol";

contract TransientMasterMock {
    using TransientMaster for *;

    TransientMaster.Variable u;
    TransientMaster.Variable a;
    TransientMaster.Variable b;
    TransientMaster.Variable bts32;

    IntermediateMock callee;

    constructor() {
        callee = new IntermediateMock();
    }

    function beforeCallback() external {
        assert(u.getUint256() == 0);
        assert(a.getAddress() == address(0));
        assert(b.getBool() == false);
        assert(bts32.getBytes32() == bytes32(0));
        
        u.setUint256(5);
        a.setAddress(address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        b.setBool(true);
        bts32.setBytes32(keccak256("bytes32"));

        assert(u.getUint256() == 5);
        assert(a.getAddress() == address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        assert(b.getBool() == true);
        assert(bts32.getBytes32() == keccak256("bytes32"));

        callee.callback();
    }

    function afterCallback() external view {
        assert(u.getUint256() == 5);
        assert(a.getAddress() == address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF));
        assert(b.getBool() == true);
        assert(bts32.getBytes32() == keccak256("bytes32"));
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