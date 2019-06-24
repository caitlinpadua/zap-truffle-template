//pragma solidity ^0.5.0;
pragma solidity > 0.4.21 < 0.6.0;
//Example of requiring zap contracts Registry
import "./zap/contracts/platform/registry/Registry.sol";
import "./ZapInterface.sol";
contract ExampleOracle  {
    event RecievedQuery(string query, bytes32 endpoint, bytes32[] params);


    ZapInterface dispatch;
    ZapInterface registry;

    address dispatchAddress;
    address registryAddress;

    bytes32 public spec1 = "ExampleEndpoint";
    int256[] curve1 = [1,1,1000000000];

    constructor(address _zapCoord) public{
        registryAddress = ZapInterface(_zapCoord).getContract("REGISTRY");
        registry = ZapInterface(registryAddress);
        dispatchAddress = ZapInterface(_zapCoord).getContract("DISPATCH");
        dispatch = ZapInterface(dispatchAddress);

        // initialize in registry
        bytes32 title = "TestOracle";

        registry.initiateProvider(12345, title);
        registry.initiateProviderCurve(spec1, curve1, address(0));
    }

    // middleware function for handling queries
    function receive(uint256 id, string calldata userQuery, bytes32 endpoint, bytes32[] calldata endpointParams, bool onchainSubscriber) external {
        emit RecievedQuery(userQuery, endpoint, endpointParams);
        endpoint1(id);
    }
    function endpoint1(uint256 id) public {
        dispatch.respond1(id, "Onchain Answer");
        // dispatch.respond2(id, "String1","String2");
        // dispatch.respond3(id, "String1","String2","String3");
        // dispatch.respond4(id, "String1","String2","String3","String4");

    }



}
