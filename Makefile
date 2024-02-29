help:
	@echo "Makefile Help"
	@echo ""
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


##############################
# DBT Runner container       #
##############################
docker-build:  ## build the docker image
	docker-compose build --force-rm

docker-start: ## start the docker container
	docker-compose -f docker-compose.yml up -d

docker-stop:  ## stops the running docker service
	docker-compose -f docker-compose.yml down -v

dbt-shell:  ## open a terminal session in the DBT runner container
	@docker exec -it \
		--workdir /dbt-runner/jaffle_shop \
		dbt-jaffle-runner \
		/bin/bash