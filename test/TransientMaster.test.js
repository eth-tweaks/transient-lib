const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Transient Master", function () {

  before(async () => {
    [admin, alice, bob, charlie] = await ethers.getSigners();
    TransientMock = await ethers.getContractFactory("TransientMock");
  });

  describe("Static transient", function () {

    beforeEach(async () => {
      mock = await TransientMock.deploy();
    });
  
    it("uint256", async () => {
      await mock.setUint256();
    });
  });
});