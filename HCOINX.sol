pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint amount) external returns (bool);
    function transferFrom(address from, address to, uint amount) external returns (bool);
}

contract HCXXRoulette {
    address public owner;
    IERC20 public token;

    struct Bet {
        address player;
        uint amount;
        uint8 number;
    }

    Bet[] public bets;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _token) {
        owner = msg.sender;
        token = IERC20(_token);
    }

    function placeBet(uint8 number, uint amount) external {
        require(number <= 36, "Invalid number");

        token.transferFrom(msg.sender, address(this), amount);
        bets.push(Bet(msg.sender, amount, number));
    }

    function spin(uint winningNumber) external onlyOwner {
        for (uint i = 0; i < bets.length; i++) {
            if (bets[i].number == winningNumber) {
                token.transfer(bets[i].player, bets[i].amount * 36);
            }
        }

        delete bets;
    }
}
