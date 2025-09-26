# Blockchain Tic-Tac-Toe

A fully decentralized **Tic-Tac-Toe** game that runs on the **Ethereum blockchain**.  
This project is built from scratch with **Solidity** smart contracts and a complete front-end powered by **Truffle**, **Web3.js**, and **MetaMask**.  
It demonstrates the entire process of developing, deploying, and interacting with blockchain-based games.

---

## Features
- **On-chain gameplay** – All game data is stored on the Ethereum blockchain, ensuring transparency and immutability.  
- **Economic incentives** – Players can stake Ether and receive rewards when they win.  
- **End-to-end development** – Includes Solidity smart contracts, Truffle testing, and a responsive front-end.  
- **Decentralized experience** – Players connect with MetaMask and interact directly in the browser.

---

## Tech Stack
- **Smart Contract**: Solidity  
- **Framework**: Truffle  
- **Local Blockchain**: Ganache  
- **Front End**: Web3.js, HTML, JavaScript, Bootstrap  
- **Wallet**: MetaMask  

---

## How To Run This Game
To run this game you and your opponent need access to the same blockchain. Either install MetaMask and choose the right network, or start your own blockchain node with go-ethereum or parity and connect to it.

---

## How To Install from the Repository
1. Install Git
2. and NodeJS (including NPM) on Your Computer
3. Open a Terminal/Command Line
4. `cd blocktactoe`
5. `npm install`
6. `npm install -g truffle`
7. `npm install -g ganache-cli`
8. Open Ganache: `ganache-cli`
9. Open a second Terminal/Command Line in the same folder and type in
10. `truffle migrate` to deploy the smart contracts on Ganache
11. `npm run dev` to start the webpack dev server
12. Then open your browser

---

## Acknowledgments

Special thanks to `Ravinder Deol` and `Thomas Wiesner` for their excellent instruction in the Udemy course.
Their teaching and guidance provided the foundation and inspiration for this project.

This project was built with the help of amazing open-source tools, including Truffle, Ganache, Web3.js, and Webpack.
Many thanks to the developers and maintainers of these projects for making decentralized application development possible.
