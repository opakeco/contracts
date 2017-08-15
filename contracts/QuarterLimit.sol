pragma solidity ^0.4.13;


contract QuarterLimit {
    uint256 public QUARTER_PERIOD = 90 days;

    uint256 public quarterlyLimit;
    uint256 public spentInCurrentQuarter;
    uint256 public lastQuarter;

    function QuarterLimit(uint256 _limit) {
        quarterlyLimit = _limit;
        lastQuarter = now;
    }

    function _setQuarterlyLimit(uint256 _newLimit) internal {
        quarterlyLimit = _newLimit;
    }

    function _resetSpentInCurrentQuarter() internal {
        spentInCurrentQuarter = 0;
    }

    function _startNewQuarter() internal {
        lastQuarter = now;
    }

    function _isWithinLimits(uint256 _value) internal returns (bool) {
        require(_value > 0);
        require(spentInCurrentQuarter + _value > spentInCurrentQuarter);

        // Reset spending limit if previous quarter has passed.
        if (now > (lastQuarter + QUARTER_PERIOD)) {
            _resetSpentInCurrentQuarter();
            _startNewQuarter();
        }

        if (spentInCurrentQuarter + _value <= quarterlyLimit) {
            spentInCurrentQuarter += _value;

            return true;
        }

        return false;
    }

    modifier isWithinQuarterlyLimits(uint256 _value) {
        require(_isWithinLimits(_value));
        _;
    }
}

