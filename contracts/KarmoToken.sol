pragma solidity ^0.4.13;

import "zeppelin-solidity/contracts/token/StandardToken.sol";


/**
 * @title Karmo Token
 * @dev The Karmo token source contract; allows karmo tokens to be burned.
 */
contract KarmoToken is StandardToken {
    string public name = "Karmo";
    string public symbol = "KRM";
    uint public decimals = 0;
    uint public INITIAL_SUPPLY = 4000000000;

    function KarmoToken() {
        totalSupply = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
    }

    function burn(uint value) {
        require(value > 0);

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(value);

        totalSupply = totalSupply.sub(value);
        Burn(burner, value);
    }

    event Burn(address indexed burner, uint indexed value);
}

