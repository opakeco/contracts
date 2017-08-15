pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';


/**
 * @title KarmoCrowdsale
 */
contract KarmoCrowdsale is CappedCrowdsale {
    using SafeMath for uint256;

    uint HARD_LIMIT = 100000;

    function KarmoCrowdsale() {
        super.CappedCrowdsale(HARD_LIMIT);
    }

    /**
     * Returns true if contributors can still contribute to the crowdsale.
     *
     * This method overrides the zeppelin capped crowdsale contract to allow
     * limits on the gas price of a transaction.
     */
    function validPurchase() internal constant returns(bool) {
        require(tx.gasprice == 50);

        return super.validPurchase();
    }
}
