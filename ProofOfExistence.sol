//SPDX-License-Identifier:NONE

pragma solidity ^0.8.10;

contract ProofOfExistence1 {
    // state
    bytes32 public proof;

    // calculate and store the proof for a document
    // *transactional function*
    function notarize(string memory document) public {
        proof = sha256(bytes(document));
    }

    // helper function to get a document's sha256
    // *read-only function*
    function getHash(string memory document) public pure returns (bytes32) {
        return sha256(bytes(document));
    }
}
