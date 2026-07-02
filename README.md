# Project Aegis-Semantic: Perimeter Defense for Agentic Interbank Networks

An architectural blueprint and Proof-of-Concept (PoC) demonstrating **Systemic Semantic Contamination** in autonomous financial agent networks, and the implementation of a first-generation **Semantic Firewall**.

Reference material for the blog post: *"The Semantic Infection: Why API Gateways are Blind to Agentic Corruption."*

---

## 1. Product Requirement Document (PRD) & Architectural Spec

### 1.1 Objective & Context
In an ecosystem where autonomous AI agents orchestrate interbank workflows (e.g., asset-backed lending, collateral valuation), agents communicate via natural language reasoning chains embedded inside structured payloads. 
Traditional perimeter defenses (WAFs, API Gateways) validate *syntax* (JSON schemas, tokens, rate limits) but are blind to *semantics* (logical corruption, hallucinated risk vectors, adversarial prompt injection). 

**Project Aegis-Semantic** defines the specification for a gateway proxy layer capable of intercepting, parsing, and verifying the cognitive logic of a payload's context window before it alters downstream application state.

### 1.2 Core Requirements
* **Zero-Trust Semantic Ingress:** Every natural language string passed into institutional boundary windows must be evaluated for policy compliance, alignment drift, and logical validity.
* **Syntactic-Semantic Decoupling:** Structural validation (Schema, Auth) remains offloaded to legacy gateways (e.g., Kong, Apigee). Semantic validation must run asynchronously or inline as a secondary policy enforcement point (PEP).
* **Deterministic Fallbacks:** If a semantic evaluation fails or returns a low-confidence score, the transaction must be gracefully degraded or routed to human-in-the-loop (HITL) review rather than throwing a hard system exception that could trigger network freezes.

---

## 2. Technical Architecture

Traditional API Gateways evaluate payloads deterministically. The Semantic Firewall introduces an evaluation pipeline that grades unstructured data against an institutional Policy Matrix.

[ Incoming Request ]
│
▼
┌───────────────┐
│ Legacy Gateway│ ──► Validates Schema, TLS, JWT, Rate Limits (PASS)
└───────┬───────┘
│
▼
┌───────────────┐
│   Semantic    │
│   Firewall    │ ──► Extracts context_payload -> Evaluates Cognitive Bias/Risk
└───────┬───────┘
│
├───► [FAIL] ──► Route to Human-In-The-Loop / Quarantine Ledger
│
└───► [PASS] ──► Inject to Core Autonomous Ledger Agent


### The Evaluation Matrix

| Vector | Focus Layer | Tooling Class | Target Latency |
| :--- | :--- | :--- | :--- |
| **Syntactic Verification** | JSON/XML Struct, Regex | Traditional API Gateway | < 5ms |
| **Semantic Integrity** | Logical Validity, Contagion Risk | Guardrail LLM / Small Language Model (SLM) | 150ms - 400ms |

---

## 3. Proof of Concept (PoC)

This repository contains a FastAPI-based implementation demonstrating the exact failure mode described in the article, alongside a mitigation prototype.

### How to Run the Sandbox

1. Clone the repository and install dependencies:
```bash
pip install fastapi uvicorn pydantic openai
```

2. Export API Keys & Set ENV Variables
```bash
export OPENAI_API_KEY="your-api-key"
```

3. Run the application
```bash
uvicorn main:app --reload
```

4. Quick Bash script to demonstrate Code
```bash
exploit_test.sh (A Quick Bash Script to Demonstrate the Code)
```

