// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {Test} from "forge-std/Test.sol";

import {CounterForTestingVerification} from "../src/CounterForTestingVerification.sol";

contract CounterForTestingVerificationTest is Test {
    CounterForTestingVerification public counter;

    function setUp() public {
        counter = new CounterForTestingVerification();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
