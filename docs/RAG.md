- RAG (Retrieval-Augmented Generation) is an architecture that connects a large language model to external data sources before generating a response.
- A standard RAG pipeline executes a linear, three-step process:

1. Retrieve: Takes a user query, converts it into a vector embedding, and searches an external database (often a vector store) for the most semantically similar text chunks.
2. Augment: Injects those retrieved text chunks into the model's prompt context alongside the user's original question.
3. Generate: The LLM reads the enriched context and generates an answer grounded in that external data.

- The Limitation of Standard RAG. Traditional RAG is rigid and linear. It assumes a single search query will surface all the right information on the first attempt.
- If the retrieved data is irrelevant or incomplete, the model generates an answer anyway, often producing a subtle hallucination or failing to answer complex questions.
- A single search pass rarely captures all necessary context when the question requires multiple steps.
- Agentic RAG introduces an autonomous agent control loop to the retrieval process.
  - The agentic control loop (which repeats) has:
    - Planning, tool use, reflection and routing
- The LLM acts as an orchestrator that decides when, where, and how many times to retrieve information.

# Benefits of agentic RAG:

- `Multi-hop reasoning:` break multi-layered or complex queries into sub-queries and execute sequential retrieval.
- `Self-correction & reflection:` evaluate retrieved chunks for relevance before answering. If chunks are insufficient, it rewrites the search query and tries again.
  - Reflection means checking whether more data is needed.
- `Dynamic routing:` choose the best source for the job.

- A Claude model like Opus or Sonnet supplies the reasoning.
- Claude is an AI model; Claude Code is an agentic tool that runs on Claude.
- Claude Code is a CLI application.
