pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/RefundVault.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';


/**
 * @title Karmo Crowdsale
 */
contract KarmoCrowdsale is CappedCrowdsale, RefundableCrowdsale {
    using SafeMath for uint256;

    uint256 public MINIMUM_TARGET = 20000 * 1 ether;
    uint256 public HARD_LIMIT = 100000 * 1 ether;
    uint256 public EXCHANGE_RATE = 26000;
    

    RefundVault public vault;

    function KarmoCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        address _wallet
    )
        RefundableCrowdsale(MINIMUM_TARGET)
        CappedCrowdsale(HARD_LIMIT)
        Crowdsale(_startTime, _endTime, EXCHANGE_RATE, _wallet)
    {
        vault = new RefundVault(wallet);
    }

    /**
     * Returns true if contributors can still contribute to the crowdsale.
     *
     * This method overrides the zeppelin capped crowdsale contract to allow 
     * limits on the gas price of a transaction, and to check whether the cap
     * has been reached.
     */
    function validPurchase() internal constant returns(bool) {
        require(tx.gasprice == 50);
        require(weiRaised.add(msg.value) <= cap);

        return super.validPurchase();
    }
}
