# Jupyterlab_dev repo

Repositório com Dockefile para criação de imagem de ambiente JupyterLab em um OS Debian 9 com instalação do driver **ODBC Driver 17 for SQL Server** para rodar aplicações python (3.6) com conexão com banco SQL SERVER via biblioteca pyodbc.

## Ambiente via Docker

Inicialmente é necessário a instalação do Docker Desktop e a criação de uma conta no Docker Hub

Após a instalação, rodar o comando abaixo para criar a imagem

```bash
docker build -t <nome-da-imagem>:<tag> .
```

E para criar container, rodá-lo em seu terminal (excluido automaticamente ao sair do container):

```bash
docker run -it --rm -p 8888:8888 <nome-da-imagem>:<tag>
```

Com o container criado, acessar jupyterlab via: http://localhost:8888/, token para acesso definido dentro do Dockefile no parâmetro **JUPYTER_TOKEN**

Para interagir com o container, ele já deve estar ativo, e rodar o comando:

```bash
docker exec -it  <nome-container> bash
```
