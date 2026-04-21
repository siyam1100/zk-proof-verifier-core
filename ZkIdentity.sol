// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Verifier.sol";

contract ZkIdentity {
    Verifier public immutable verifier;
    mapping(uint256 => bool) public nullifiers;

    constructor(address _verifier) {
        verifier = Verifier(_verifier);
    }

    function proveIdentity(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[1] memory input
    ) external {
        uint256 nullifierHash = input[0];
        require(!nullifiers[nullifierHash], "Proof already used");
        require(verifier.verifyProof(a, b, c, input), "Invalid ZK Proof");

        nullifiers[nullifierHash] = true;
        // Logic for successful anonymous verification
    }
}
