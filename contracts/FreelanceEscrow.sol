// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FreelanceEscrow {
    address public client;
    address public freelancer;
    uint256 public jobAmount;
    bool public jobStarted;
    bool public jobCompleted;

    constructor(address _freelancer) payable {
        require(msg.value > 0, "Must fund the escrow");
        client = msg.sender;
        freelancer = _freelancer;
        jobAmount = msg.value;
        jobStarted = false;
        jobCompleted = false;
    }

    modifier onlyClient() {
        require(msg.sender == client, "Only client allowed");
        _;
    }

    modifier onlyFreelancer() {
        require(msg.sender == freelancer, "Only freelancer allowed");
        _;
    }

    function startJob() external onlyClient {
        require(!jobStarted, "Job already started");
        jobStarted = true;
    }

    function completeJob() external onlyFreelancer {
        require(jobStarted, "Job not started");
        require(!jobCompleted, "Already completed");
        jobCompleted = true;
    }

    function releasePayment() external onlyClient {
        require(jobCompleted, "Job not completed");
        payable(freelancer).transfer(jobAmount);
    }
}
