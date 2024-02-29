# dbt_jaffle_docker

## Run on your local machine

Note: if you use windows, you should run this project using the WSL distro

* run `make docker-build` to pull the necessary images, start the local postgres DB, and instal libraries
* run `make docker-start` to start the container
* run `make dbt-shell` to end the command line within the dbt root folder (you can run here dbt commands)
* run `make docker-stop` to stop the running container

### Running Recce

Recce is installed within your container, you can follow here the [getting started](https://datarecce.io/docs/get-started/). The server can be started by running `recce server --port 8000 --host 127.0.0.1` in the dbt shell. The server should then be available at `localhost:8000`.