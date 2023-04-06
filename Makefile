lint:
	@docker compose run --rm lint

test:
	@docker compose run --rm tests
	@echo "run 'make clean' to stop and remove test containers"

clean:
	@docker compose down

.DEFAULT_GOAL: test

.PHONY: lint test clean