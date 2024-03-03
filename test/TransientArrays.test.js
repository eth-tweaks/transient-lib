const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Transient Arrays", function () {

  before(async () => {
    [admin, alice, bob, charlie] = await ethers.getSigners();
    TransientArraysMock = await ethers.getContractFactory("TransientArraysMock");
  });

  describe("ArrayUint256", function () {

    beforeEach(async () => {
      mock = await TransientArraysMock.deploy();
    });
  
    it("base type arrays", async () => {
      let r = await mock.callStatic.beforeCallback();

      expect(r).to.deep.equal([3]);
      await mock.beforeCallback();
    });
  });
});