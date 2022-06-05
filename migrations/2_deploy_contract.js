const FundMe = artifacts.require('FundMe')

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(FundMe)
  await FundMe.deployed()
}