FROM python:3.12-slim

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y curl build-essential git && \
        apt-get clean

# Instalar o Poetry corretamente
RUN curl -sSL https://install.python-poetry.org | python3 - && \
        ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Copiar o projeto para dentro do container
COPY . /src
WORKDIR /src

# Instalar dependências (sem tentar empacotar o projeto)
RUN poetry install --no-root --no-interaction --no-ansi

# Expor a porta do Streamlit
EXPOSE 8501

# Comando para iniciar o Streamlit
CMD ["poetry", "run", "streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.enableCORS=false"]
