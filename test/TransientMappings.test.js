const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Transient Mappings", function () {

  before(async () => {
    [admin, alice, bob, charlie] = await ethers.getSigners();
    TransientMappingsMock = await ethers.getContractFactory("TransientMappingsMock");
  });

  describe("Mappings", function () {

    beforeEach(async () => {
      mock = await TransientMappingsMock.deploy();
    });
  
    it("base type mappings", async () => {
      await mock.beforeCallback();
    });
  });
});