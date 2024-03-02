const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Transient Master", function () {

  before(async () => {
    [admin, alice, bob, charlie] = await ethers.getSigners();
    TransientMock = await ethers.getContractFactory("TransientMock");
  });

  describe("Slots allocation", function () {
    beforeEach(async () => {
      const TestStorageSlots = await ethers.getContractFactory("TestStorageSlots");
      testSlots = await TestStorageSlots.deploy();
    })

    it("Test array slot location", async () => {
      await testSlots.testArray();
    });

    it("Test array slot location with overflow", async () => {
      await testSlots.testArrayOverflow();
    });
  });

  describe("Static transient", function () {

    beforeEach(async () => {
      mock = await TransientMock.deploy();
    });
  
    it("base type variables", async () => {
      await mock.beforeCallback();
    });

    it("cast address", async () => {
      const correctAddress = "0xffffffffffffffffffffffffffffffffffffffff";
      const incorrectAddress = "0x10000000000000000000000000000000000000000";
      
      expect(
        (await mock.callStatic.testAddressRevert(correctAddress)).toLowerCase()
      ).to.equal(correctAddress);

      await expect(mock.testAddressRevert(incorrectAddress))
        .to.be.revertedWith("TM: address casting error");
    });

    it("cast bool", async () => {
      const correctBool = 1;
      const incorrectBool = 2;
      
      expect(
        await mock.callStatic.testBoolRevert(correctBool)
      ).to.equal(true);

      await expect(mock.testBoolRevert(incorrectBool))
        .to.be.revertedWith("TM: bool casting error");
    });

  });
});