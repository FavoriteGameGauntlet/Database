include .env
export

DB_CONTAINER ?= fgg-db
DB_URL=postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable

.PHONY: update tables functions

tables:
	docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) -v ON_ERROR_STOP=1 -q < src/tables/00_schemas.sql
	for f in $$(find src/types -name '*.sql' | sort) $$(find src/tables -name '*.sql' ! -name '00_schemas.sql' | sort) $$(find src/seeds -name '*.sql' | sort); do \
		echo "== $$f"; \
		docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) -v ON_ERROR_STOP=1 -q < $$f || exit 1; \
	done

functions:
	for f in $$(find src/functions -name '*.sql' | sort); do \
		docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) -v ON_ERROR_STOP=1 -q < $$f || exit 1; \
	done

update:
	atlas migrate apply --dir file://migrations --url "$(DB_URL)"
	$(MAKE) functions
