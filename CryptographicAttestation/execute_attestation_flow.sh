#!/usr/bin/env bash

echo "=========================================================="
echo "STAGING 1: Querying Enclave Simulator for Tokens..."
echo "=========================================================="
RAW_RESPONSE=$(curl -s -X GET "http://127.0.0.1:8000/api/v3/simulate/run-trilogy-demo")

# Extract the valid and invalid JSON structures using python helper parsing
VALID_PAYLOAD=$(echo $RAW_RESPONSE | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin)['valid_attestation_generated']))")
INVALID_PAYLOAD=$(echo $RAW_RESPONSE | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin)['policy_failed_attestation_generated']))")

echo -e "\n=========================================================="
echo "STAGING 2: Sending Valid Attest Token to Cryptographic Ingress"
echo "=========================================================="
curl -X POST "http://127.0.0.1:8000/api/v3/verifier/ingress" \
     -H "Content-Type: application/json" \
     -d "$VALID_PAYLOAD"

echo -e "\n\n=========================================================="
echo "STAGING 3: Sending Non-Compliant Attest Token (Triggers Edge Block)"
echo "=========================================================="
curl -X POST "http://127.0.0.1:8000/api/v3/verifier/ingress" \
     -H "Content-Type: application/json" \
     -d "$INVALID_PAYLOAD"
echo ""