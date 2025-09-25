const TicTacToe = artifacts.require("TicTacToe");

export default function(deployer) {
  deployer.deploy(TicTacToe);
};
