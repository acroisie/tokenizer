// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Acroisie42 is ERC20 {
    uint256 public requiredApprovals;
    address[] public signers;
    mapping(address => bool) public isSigner;
    mapping(uint256 => Transaction) public transactions;
    mapping(uint256 => mapping(address => bool)) public approvals;
    uint256 public transactionCount;

    enum TransactionType { TRANSFER, MINT, BURN }

    struct Transaction {
        address to;
        uint256 amount;
        bool executed;
        uint256 approvalCount;
        TransactionType txType;
    }

    event TransactionProposed(uint256 indexed txId, address indexed to, uint256 amount, TransactionType txType);
    event TransactionApproved(uint256 indexed txId, address indexed signer);
    event TransactionExecuted(uint256 indexed txId, address indexed to, uint256 amount, TransactionType txType);
    event LogSignerAdded(address indexed signer);

    modifier onlySigner() {
        require(isSigner[msg.sender], "Not an authorized signer");
        _;
    }

    constructor(address[] memory _signers, uint256 _requiredApprovals)
        ERC20("Acroisie42b", "ACR42b")
    {
        require(_signers.length >= _requiredApprovals, "Not enough signers");

        for (uint256 i = 0; i < _signers.length; i++) {
            isSigner[_signers[i]] = true;
            emit LogSignerAdded(_signers[i]);
        }
        signers = _signers;
        requiredApprovals = _requiredApprovals;

        uint256 startAmount = 8000 * 10 ** decimals();
        _mint(address(this), startAmount);
    }

    function proposeTransaction(address to, uint256 amount, TransactionType txType) external onlySigner {
        if (txType == TransactionType.TRANSFER) {
            require(balanceOf(address(this)) >= amount, "Insufficient funds in treasury.");
        }

        uint256 txId = transactionCount++;
        transactions[txId] = Transaction({
            to: to,
            amount: amount,
            executed: false,
            approvalCount: 0,
            txType: txType
        });

        emit TransactionProposed(txId, to, amount, txType);
    }

    function approveTransaction(uint256 txId) external onlySigner {
        require(transactions[txId].amount > 0, "Transaction does not exist.");
        require(!transactions[txId].executed, "Transaction already executed.");
        require(!approvals[txId][msg.sender], "Signer already approved.");

        approvals[txId][msg.sender] = true;
        transactions[txId].approvalCount++;

        emit TransactionApproved(txId, msg.sender);

        if (transactions[txId].approvalCount >= requiredApprovals) {
            executeTransaction(txId);
        }
    }

    function executeTransaction(uint256 txId) internal {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Transaction already executed.");
        require(txn.approvalCount >= requiredApprovals, "Not enough approvals.");

        txn.executed = true;

        if (txn.txType == TransactionType.TRANSFER) {
            _transfer(address(this), txn.to, txn.amount);
        } else if (txn.txType == TransactionType.MINT) {
            _mint(txn.to, txn.amount);
        } else if (txn.txType == TransactionType.BURN) {
            _burn(txn.to, txn.amount);
        }

        emit TransactionExecuted(txId, txn.to, txn.amount, txn.txType);
    }

    function treasuryBalance() external view returns (uint256) {
        return balanceOf(address(this));
    }
}
