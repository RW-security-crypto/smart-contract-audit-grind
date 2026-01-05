// SimpleWallet.sol
pragma solidity ^0.8.0;
contract SimpleWallet {
    mapping(address => uint) public balances;
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }
}