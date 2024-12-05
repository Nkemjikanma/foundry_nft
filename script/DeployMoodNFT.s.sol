// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory sadSVG = vm.readFile("./images/mood/sad.svg");
        string memory happySVG = vm.readFile("./images/mood/happy.svg");

        vm.startBroadcast();

        MoodNFT moodNFT = new MoodNFT(
            svgToImageURI(sadSVG),
            svgToImageURI(happySVG)
        );

        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg_xml;base64,";
        string memory svgEncoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, svgEncoded));
    }
}
