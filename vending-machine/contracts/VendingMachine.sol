// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
// NOUMAN AHMAD
contract VendingMachine {
    // state variables
    address public owner;
    mapping (address => uint) public donutBalances;
    uint public donutPrice;  // New variable for donut price

    // set the owner as the address that deployed the contract
    // set the initial vending machine balance to 100
    // 2 ethereum price set kee initially....
    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
        donutPrice = 2 ether;  // Initial price
    }

// to return balance
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    // Let the owner restock the vending machine
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        donutBalances[address(this)] += amount;
    }

    // a lil dynamic pricing wala function....
    function setDonutPrice(uint _price) public {
        require(msg.sender == owner, "Only the owner can change the price");
        require(_price > 0, "Price must be greater than 0");
        donutPrice = _price;
    }

    // purchasing donutt
    function purchase(uint amount) public payable {
        require(msg.value >= amount * donutPrice, "Insufficient payment");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to complete this purchase");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}