FROM python:3.12-slim

RUN apt-get update && apt-get install -y curl build-essential git && \
        curl -sSL https://install.python-poetry.org | python3 - && \
        ln -s /root/.local/bin/poetry /usr/local/bin/poetry

COPY . /src
WORKDIR /src

RUN poetry install --no-root

EXPOSE 8501

CMD ["poetry", "run", "streamlit", "run", "app.py", "--server.port=8501"]
