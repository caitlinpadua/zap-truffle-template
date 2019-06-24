pragma solidity ^0.5.0;

contract ZapInterface{
    // Comment and uncomment functions that you do not need
    //event
    event Transfer(address indexed from, address indexed to, uint256 value);
    //COORD
    function addImmutableContract(string calldata contractName, address newAddress) external;
    function updateContract(string calldata contractName, address newAddress) external;
    function getContractName(uint index) public view returns (string memory);
    function getContract(string memory contractName) public view returns (address);
    function updateAllDependencies() external;
    
    //REGISTRY
    function initiateProvider(uint256, bytes32) public returns (bool);
    function initiateProviderCurve(bytes32, int256[] memory, address) public returns (bool);
    function setEndpointParams(bytes32, bytes32[] memory) public;
    function getEndpointParams(address, bytes32) public view returns (bytes32[]memory);
    function getProviderPublicKey(address) public view returns (uint256);
    function getProviderTitle(address) public view returns (bytes32);
    function setProviderParameter(bytes32, bytes32) public;
    function getProviderParameter(address, bytes32) public view returns (bytes32);
    function getAllProviderParams(address) public view returns (bytes32[] memory);
    function getProviderCurveLength(address, bytes32) public view returns (uint256);
    function getProviderCurve(address, bytes32) public view returns (int[] memory);
    function isProviderInitiated(address) public view returns (bool);
    function getAllOracles() external view returns (address[] memory);
    function getProviderEndpoints(address) public view returns (bytes32[] memory);
    function getEndpointBroker(address, bytes32) public view returns (address);
    
    //BONDAGE
    function bond(address, bytes32, uint256) external returns(uint256);
    function unbond(address, bytes32, uint256) external returns (uint256);
    function delegateBond(address, address, bytes32, uint256) external returns(uint256);
    function escrowDots(address, address, bytes32, uint256) external returns (bool);
    function releaseDots(address, address, bytes32, uint256) external returns (bool);
    function returnDots(address, address, bytes32, uint256) external returns (bool success);
    function calcZapForDots(address, bytes32, uint256) external view returns (uint256);
    function currentCostOfDot(address, bytes32, uint256) public view returns (uint256);
    function getDotsIssued(address, bytes32) public view returns (uint256);
    function getBoundDots(address, address, bytes32) public view returns (uint256);
    function getZapBound(address, bytes32) public view returns (uint256);
    function dotLimit( address, bytes32) public view returns (uint256);
    
    //DISPATCH
    function query(address, string calldata, bytes32, bytes32[] calldata) external returns (uint256); 
    function respond1(uint256, string calldata) external returns (bool);
    function respond2(uint256, string calldata, string calldata) external returns (bool);
    function respond3(uint256, string calldata, string calldata, string calldata) external returns (bool);
    function respond4(uint256, string calldata, string calldata, string calldata, string calldata) external returns (bool);
    function respondBytes32Array(uint256, bytes32[] calldata) external returns (bool);
    function respondIntArray(uint256,int[] calldata ) external returns (bool);
    function cancelQuery(uint256) external;
    
    // ARBITER
    function initiateSubscription(address, bytes32, bytes32[] memory, uint256, uint64) public;
    function getSubscription(address, address, bytes32) public view returns (uint64, uint96, uint96);
    function endSubscriptionProvider(address, bytes32) public;
    function endSubscriptionSubscriber(address, bytes32) public;
    function passParams(address receiver, bytes32 endpoint, bytes32[] memory params) public;
    
    // ZAPTOKEN
    function balanceOf(address who) public pure returns (uint256); 
    function transfer(address to, uint256 value) public returns (bool);
	function approve(address spender, uint256 value) public returns (bool);


}