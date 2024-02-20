// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./TransientMock.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract IntermediateMock {
    
    function callbackUint256() external view {
        TransientMock(msg.sender).getUint256();
    }
}