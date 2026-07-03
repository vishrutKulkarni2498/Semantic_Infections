# Project Aegis-Hybrid: Multi-Layered Semantic Firewall for Autonomous Banking

A reference implementation of a hybrid **Semantic Firewall** architecture for interbank agentic workflows. This sandbox demonstrates the combination of **Probabilistic Ingress Guardrailing** (using an LLM/SLM classifier) and **Deterministic State Compilation** at the transaction boundary.

Reference material for the blog post: *"The Semantic Firewall: Engineering the Defense for Interbank Networks."*

---

## 1. Architectural Blueprint

The architecture mitigates semantic contamination by decoupling the *reasoning workspace* from the *execution ledger*.

        [ Incoming Semantic Payload ]
        │
        ▼
        ┌──────────────────────┐
        │ Ingress Guardrail    │  ◄─── [Layer 1: Probabilistic Shield]
        │ (Fast SLM Classifier)│       Drops obvious jailbreaks/malicious intent.
        └──────────┬───────────┘
        │ (PASS)
        ▼
        ┌──────────────────────┐
        │ Internal Agent Bank  │  ◄─── [Layer 2: Cognitive Processing]
        │ (Reasoning Engine)   │       Ingests context, processes alternative data.
        └──────────┬───────────┘
        │
        ▼ (Compiles natural language into strict State Schema)
        ┌──────────────────────┐
        │ Deterministic Gate   │  ◄─── [Layer 3: The Hard Stop]
        │ (Zero-AI Rule Engine)│       Validates structural invariants & risk thresholds.
        └──────────┬───────────┘
        │ (PASS)
        ▼
        [ Ledger Mutation ]

### Key Metrics & Tradeoffs
* **Ingress Shield Latency:** ~40-150ms (optimized SLM or edge classifier).
* **Final Gate Latency:** < 1ms (Zero-AI compiled schema check).
* **Failure Model:** Fails closed if the compiled state vector violates systemic risk limits, regardless of what the LLM reasons.

---

## 2. Getting Started

### Prerequisites
* Python 3.10+
* An OpenAI API Key (configured as an environment variable)

### Installation
```bash
pip install fastapi uvicorn pydantic openai
export OPENAI_API_KEY="your-api-key"
```