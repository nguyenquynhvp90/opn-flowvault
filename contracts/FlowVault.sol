// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FlowVault {

    mapping(address => uint256) public balances;

    uint256 public totalLocked;

    event Deposited(
        address indexed user,
        uint256 amount
    );

    event Withdrawn(
        address indexed user,
        uint256 amount
    );

    function deposit()
        external
        payable
    {
        require(
            msg.value > 0,
            "Invalid amount"
        );

        balances[msg.sender]+=msg.value;

        totalLocked+=msg.value;

        emit Deposited(
            msg.sender,
            msg.value
        );
    }

    function withdraw(
        uint256 amount
    )
        external
    {
        require(
            balances[msg.sender]
            >= amount,
            "Insufficient balance"
        );

        balances[msg.sender]-=amount;

        totalLocked-=amount;

        payable(
            msg.sender
        ).transfer(amount);

        emit Withdrawn(
            msg.sender,
            amount
        );
    }

    function myBalance()
        external
        view
        returns(uint256)
    {
        return balances[msg.sender];
    }
}
