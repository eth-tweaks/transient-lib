// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./TransientMasterMock.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract IntermediateMock {
    
    function callback() external view {
        TransientMasterMock(msg.sender).afterCallback();
    }
}