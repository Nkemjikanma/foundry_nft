// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {DeployMoodNFT} from "../script/DeployMoodNFT.s.sol";

contract MoodNFTTest is Test {
    MoodNFT moodNFT;
    DeployMoodNFT deployMoodNFT;
    address public USER = makeAddr("USER");

    function setUp() public {
        deployMoodNFT = new DeployMoodNFT();
        moodNFT = deployMoodNFT.run();
    }

    function testViewTokenUri() public {
        vm.prank(USER);
        moodNFT.mintNFT(moodNFT.tokenURI(0));

        console2.log(moodNFT.tokenURI(0));
    }
}
