const BigNumber =web3.BigNumber;

const expect = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .expect;

const ZapDB = artifacts.require("Database");
const ZapCoor = artifacts.require("ZapCoordinator");
const Bondage = artifacts.require("Bondage");
const Dispatch = artifacts.require("Dispatch");
const ZapToken = artifacts.require("ZapToken");
const Registry = artifacts.require("Registry");
const Cost = artifacts.require("CurrentCost")

contract("Template",async (accounts)=>{
  let zapdb,zapcoor,token,registry,cost,bondage,dispatch;
  before(async function deployContract() {

    /***Deploy zap contrracts ***/
    zapdb = await ZapDB.new();
    zapcoor = await ZapCoor.new();
    await zapdb.transferOwnership(zapcoor.address);
    await zapcoor.addImmutableContract('DATABASE', zapdb.address);

    token = await ZapToken.new();
    await zapcoor.addImmutableContract('ZAP_TOKEN', token.address);

    registry = await Registry.new(zapcoor.address);
    await zapcoor.updateContract('REGISTRY', registry.address);

    cost = await Cost.new(zapcoor.address);
    await zapcoor.updateContract('CURRENT_COST', cost.address);

    bondage = await Bondage.new(zapcoor.address);
    await zapcoor.updateContract('BONDAGE', bondage.address);

    dispatch = await Dispatch.new(zapcoor.address);
    await zapcoor.updateContract('DISPATCH', dispatch.address);

    await zapcoor.updateAllDependencies();
  })
})