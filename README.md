# LangGraph Template

A Dev Container template for building AI agents using LangGraph and LangChain.

## Included

- Python 3.11
- LangGraph
- LangChain
- LangSmith
- LangChain OpenAI
- Jupyter support
- Corporate CA auto-detection
- VS Code Dev Containers support

## Prerequisites

- VS Code
- Dev Containers extension
- Docker or Podman

## Apply Template

```bash
devcontainer templates apply \
  --template-id ghcr.io/ArpitSharma805/langgraph-template/langgraph-template:latest \
  --workspace-folder .
```

## Open Container

1. Open project in VS Code
2. Run:

   Dev Containers: Reopen in Container

3. Wait for the build to finish

## First Use

Activate Python environment:

```bash
source .venv/bin/activate
```

Verify installation:

```bash
python -c "import langgraph; print('LangGraph installed')"
```

## Installed Packages

- langgraph
- langchain
- langchain-openai
- langsmith
- python-dotenv

## Customization

Additional packages can be added inside:

```text
.devcontainer/scripts/postCreateCommand.sh
```

or

```text
.devcontainer/Dockerfile
```


## Thanks