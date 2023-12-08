// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import { Errors } from "../utils/Errors.sol";

// kinds of raffles draw
    // one with a daily deadline
    // one with a monthly deadline
    // one with a yearly deadline 

contract Raffle {

    enum KindOf {
        daily,
        monthly,
        yearly
    }
    enum State {
        open,
        closed
    }
    
    KindOf immutable Type;
    State immutable state;
    uint256 deposit;
    address[] players;

    constructor(uint8 create_type, uint256 _deposit){
        if(create_type == 0){
            Type = KindOf.daily;
        }else if (create_type == 1){
            Type = KindOf.monthly;
        }else{
            Type = KindOf.yearly;
        }
        deposit = _deposit;
        state = State.open;
    }

    function buyIn() payable external {
        if(msg.value < deposit){
            revert Errors.Raffle_Insufficient_Buyin_Amount();
        }
        if(state != State.open){
            revert Errors.Raffle_Has_Closed();
        }
        players.push(msg.sender);
    }
    
}