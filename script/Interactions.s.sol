// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract MintBasicNFT is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    // install foundry devops package
    // forge install Cyfrin/foundry-devops --no-commit
    // function run() external {
    //     address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);

    //     mintNftOnContract(mostRecentlyDeployed);
    // }

    // function mintNftOnContract(address contractAddress) public {
    //     vm.startBroadcast();
    //     BasicNFT(contractAddress).mintNFT(PUG_URI);
    //     vm.stopBroadcast();
    // }

    //Fallback because the above way didn't work. So I manually passed the contract address

    function run() external {
        // Use the actual deployed contract address
        BasicNFT nft = BasicNFT(0x11208e1963F2B40815FB302C6C8e074eeD431D0f);

        vm.startBroadcast();
        nft.mintNFT(PUG_URI);
        vm.stopBroadcast();
    }
}

// forge install Cyfrin/foundry-devops --no-commit
