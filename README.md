
StakingContract
StakingContract is a simple contract written in Solidity for staking ERC20 tokens.

Features
Stake any amount of a specified ERC20 token.
Withdraw staked tokens at any time.
Check the balance of staked tokens for any account.
How to Use
Setup
Initialize the contract with the address of the ERC20 token to be staked.

solidity
Copy code
constructor(IERC20 _stakingToken) {
    stakingToken = _stakingToken;
}
Staking Tokens
To stake tokens, call the stake function with the amount to be staked.

solidity
Copy code
function stake(uint256 amount) public {
    // Transfer staking tokens to this contract for staking
    stakingToken.transferFrom(msg.sender, address(this), amount);

    
}
This function will transfer the staking tokens from the sender to the contract and update the sender's staking balance. A 'Staked' event will be emitted on successful staking.

Withdrawing Staked Tokens
To withdraw staked tokens, call the withdraw function with the amount to be withdrawn.

solidity
Copy code
function withdraw(uint256 amount) public {
    require(amount <= _balances[msg.sender], "Cannot withdraw more than the current staking balance");

   
    _balances[msg.sender] -= amount;

    // Transfer staking tokens back to staker
    stakingToken.transfer(msg.sender, amount);

    emit Withdrawn(msg.sender, amount);
}
This function will update the sender's staking balance and transfer the specified amount of staking tokens back to the sender. A 'Withdrawn' event will be emitted on successful withdrawal.

Checking Staking Balance
To check the staking balance of any account, call the balanceOf function with the address of the account.

solidity
Copy code
function balanceOf(address account) public view returns (uint256) {
    return _balances[account];
}
Events
Staked(address indexed user, uint256 amount) - Emitted when a user stakes tokens.
Withdrawn(address indexed user, uint256 amount) - Emitted when a user withdraws their staked tokens.
