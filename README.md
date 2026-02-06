# flaskanetes

A minimal Flask app containerized for Kubernetes. Useful as a starting template or a quick deployment target for testing clusters, networking, ingress, etc.

## What's in it

- Flask app with a hello world page and a `/health` endpoint
- Dockerfile using [uv](https://github.com/astral-sh/uv) for fast, reproducible builds
- Gunicorn for production serving
- Pytest test suite

## Project structure

```
├── Dockerfile
├── pyproject.toml
├── src/
│   ├── main.py
│   └── templates/
│       └── index.html
└── tests/
    ├── conftest.py
    └── test_main.py
```

## Routes

| Route     | Description                          |
|-----------|--------------------------------------|
| `GET /`       | Renders the hello world page     |
| `GET /health` | Returns `{"status": "healthy"}` (200) |

## Running locally

Requires Python 3.11+ and [uv](https://docs.astral.sh/uv/getting-started/installation/).

```sh
uv sync
uv run flask --app src/main run
```

The app will be available at `http://localhost:5000`.

## Running with Docker

```sh
docker build -t flaskanetes .
docker run -p 5000:5000 flaskanetes
```

### Environment variables

| Variable    | Default | Description                  |
|-------------|---------|------------------------------|
| `PORT`      | `5000`  | Port for the Flask dev server |
| `WORKERS`   | `4`     | Gunicorn worker count         |
| `TIMEOUT`   | `120`   | Gunicorn request timeout (s)  |

## Tests

```sh
uv sync --dev
uv run pytest
```
