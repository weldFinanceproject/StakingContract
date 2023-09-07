// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StakingContract {

    // The token being staked
    IERC20 public stakingToken;

    // Info of each user that stakes tokens (staking balance).
    mapping (address => uint256) private _balances;

    // Event emitted when a user stakes tokens
    event Staked(address indexed user, uint256 amount);

    // Event emitted when a user withdraws their staked tokens
    event Withdrawn(address indexed user, uint256 amount);

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
    }

    function stake(uint256 amount) public {
        // Transfer staking tokens to this contract for staking
        stakingToken.transferFrom(msg.sender, address(this), amount);

        // Update staking balance
        _balances[msg.sender] += amount;

        emit Staked(msg.sender, amount);
    }

    function withdraw(uint256 amount) public {
        require(amount <= _balances[msg.sender], "Cannot withdraw more than the current staking balance");

        // Update staking balance
        _balances[msg.sender] -= amount;

        // Transfer staking tokens back to staker
        stakingToken.transfer(msg.sender, amount);

        emit Withdrawn(msg.sender, amount);
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
}
