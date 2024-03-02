const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Transient Variables", function () {

  before(async () => {
    [admin, alice, bob, charlie] = await ethers.getSigners();
    TransientVariablesMock = await ethers.getContractFactory("TransientVariablesMock");
  });

  describe("Uint256", function () {

    beforeEach(async () => {
      mock = await TransientVariablesMock.deploy();
    });
  
    it("base type variables", async () => {
      await mock.beforeCallback();
    });
  });
});