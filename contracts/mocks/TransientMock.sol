// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./IntermediateMock.sol";
import "../TransientMaster.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract TransientMock {
    using TransientMaster for *;

    IntermediateMock callee;
    TransientMaster.Uint256 uint256Value;

    constructor() {
        callee = new IntermediateMock();
    }

    function setUint256() external {
        assert(uint256Value.get() == 0);
        uint256Value.set(5);
        assert(uint256Value.get() == 5);

        callee.callbackUint256();
    }

    function getUint256() external view {
        assert(uint256Value.get() == 5);
    }
}