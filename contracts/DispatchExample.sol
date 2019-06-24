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

/* Test Subscriber Client */
contract ExampleUser{


    ZapInterface dispatch;


    address dispatchAddress;
    event Results(string response1, string response2, string response3, string response4);

    constructor(address _zapCoord) public {

        dispatchAddress = ZapInterface(_zapCoord).getContract("DISPATCH");
        dispatch = ZapInterface(dispatchAddress);



    }

    // Choose the type of callback/data you expect
    function callback(uint256 id, bytes32[] calldata response) external {

    }
    function callback(uint256 id, int[] calldata response) external {

    }

    function callback(uint256 id, string calldata response1) external {
        emit Results(response1, "NOTAVAILABLE", "NOTAVAILABLE", "NOTAVAILABLE");
    }

    function callback(uint256 id, string calldata response1, string calldata response2) external {
        emit Results(response1, response2, "NOTAVAILABLE", "NOTAVAILABLE");
    }
    function callback(uint256 id, string calldata response1, string calldata response2, string calldata response3) external {
        emit Results(response1, response2, response3, "NOTAVAILABLE");
    }

    function callback(uint256 id, string calldata response1, string calldata response2, string calldata response3, string calldata response4) external {
        emit Results(response1, response2, response3, response4);
    }

    function testQuery(address oracleAddr, string calldata query, bytes32 specifier, bytes32[] calldata params) external returns (uint256) {
        uint256 id = dispatch.query(oracleAddr, query, specifier, params);
    }


    // attempts to cancel an existing query
    function cancelQuery(uint256 id) external {
        dispatch.cancelQuery(id);
    }

}
