const snarkjs = require("snarkjs");
const fs = require("fs");

async function generateAndSendProof(inputData, verifierContract) {
    // 1. Generate Proof locally
    const { proof, publicSignals } = await snarkjs.groth16.fullProve(
        inputData, 
        "circuit.wasm", 
        "circuit_final.zkey"
    );

    // 2. Format for Solidity
    const calldata = await snarkjs.groth16.exportSolidityCallData(proof, publicSignals);
    const argv = JSON.parse("[" + calldata + "]");

    // 3. Submit to Blockchain
    const tx = await verifierContract.verifyProof(...argv);
    console.log("Verification result:", tx);
}

module.exports = { generateAndSendProof };
