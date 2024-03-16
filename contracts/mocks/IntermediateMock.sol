// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./TransientMasterMock.sol";

contract IntermediateMock {
    
    function callback() external view {
        TransientMasterMock(msg.sender).afterCallback();
    }
}