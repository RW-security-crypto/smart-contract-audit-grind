//SPDX-License-Identifier:MIT;
pragma solidity ^0.8.20;

contract RewardPool {
    address public owner;
    uint256 public totalpoolbalance;
    uint256 public userReward;
    mapping(address => bool) public hasclaimed;
    uint256 public totalclaimers;
    event Rewardclaimed(address indexed user, uint256 amount , uint256 timestamp);
    event poolFunded(address indexed funder, uint256 amount);
    constructor(){
        owner=msg.sender;
    }
    function fundPool() public payable {
        totalpoolbalance += msg.value;
        emit poolFunded(msg.sender, msg.value);
    }
      function setRewardAmount(uint256 _newReward) public {
        userReward = _newReward;
    }
    function claimReward() public{
        require(!hasclaimed[msg.sender], "you are already claimed");
        require(totalpoolbalance >=userReward,"no enogh Fund");
        hasclaimed[msg.sender]=true;
        totalclaimers ++;

        //send reward
        (bool success, )=msg.sender.call{value:userRewared}("");
        require(success , "reward sending fail");
        totalpoolbalance = address(this).balance;

        emit Rewardclaimed(msg.sender , userReward,block.timestamp);
    }
}