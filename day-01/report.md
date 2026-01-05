# 🛡️ SimpleWallet Security Audit Project

## 📖 Overview
This repository contains a complete security audit of the SimpleWallet smart contract. The project demonstrates a common reentrancy vulnerability and the correct way to fix it.

## 🎯 Learning Objectives
- Understand reentrancy attacks in Ethereum smart contracts
- Learn the Checks-Effects-Interactions (CEI) pattern
- Practice writing exploit tests using Foundry
- Create professional security audit reports

## 🏗️ Project Structure
/
├── src/
│ └── SimpleWallet.sol # Main contract (vulnerable version)
├── test/
│ └── exploit.t.sol # Reentrancy exploit test
├── reports/
│ └── report.md # Complete security audit report
├── .github/
│ └── workflows/ # CI/CD workflows
└── README.md # This file

## 🔍 Security Findings

### 🚨 Critical Vulnerability
- **Type:** Reentrancy Attack
- **Location:** `withdraw` function, line 13
- **Risk:** Complete contract balance drainage
- **Solution:** Implement CEI pattern or use ReentrancyGuard

### 🧪 Exploit Test
The test in `exploit.t.sol` demonstrates how an attacker can:
1. Deposit 1 ETH into the contract
2. Withdraw all 3 ETH through reentrancy
3. Gain a net profit of 2 ETH

## 🛠️ Getting Started

### Prerequisites
- [Foundry](https://getfoundry.sh/) for testing
- Basic knowledge of Solidity and smart contract security

### Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/simplewallet-audit.git
cd simplewallet-audit

# Install Foundry (if not installed)
curl -L https://foundry.paradigm.xyz | bash

foundryup
Running Tests
# Run all tests
forge test

# Run with verbose output
forge test -vvv

# Run specific test
forge test --match-test testReentrancyAttack
📚 Key Lessons Learned
CEI Pattern is Crucial: Always follow Checks-Effects-Interactions

Automated Tools Aren't Enough: Manual code review is essential

Test Edge Cases: Write tests for attack scenarios

Use Security Libraries: OpenZeppelin provides battle-tested security solutions

🎯 Improved Secure Version
solidity
// SimpleWalletSecure.sol
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SimpleWalletSecure is ReentrancyGuard {
    mapping(address => uint) public balances;
    
    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }
    
    function withdraw(uint _amount) public nonReentrant {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
        
        emit Withdrawn(msg.sender, _amount);
    }
}
🔗 Resources & References
SWC Registry - SWC-107 (Reentrancy)

Ethereum Smart Contract Best Practices

OpenZeppelin Contracts Documentation

Foundry Book

Smart Contract Security Guidelines

🤝 Contributing
Found another issue? Please open an Issue or submit a Pull Request!

📝 License
This project is licensed under the MIT License - see the LICENSE file for details.

⭐ Star History
Track my learning journey through commit history and project improvements!

text

---

### 🚀 Recommended GitHub Setup:

1. **Create Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: SimpleWallet security audit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/simplewallet-audit.git
   git push -u origin main
Add GitHub Actions CI:
Create .github/workflows/test.yml:

yaml
name: Foundry Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: foundry-rs/foundry-toolchain@v1
        with:
          version: nightly
      - run: forge test
Badges to Add to README:

markdown
![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg)
![Solidity](https://img.shields.io/badge/Solidity-0.8.0-363636.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Tests](https://github.com/YOUR_USERNAME/simplewallet-audit/actions/workflows/test.yml/badge.svg)