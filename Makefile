include .env
export

PROD_URL=postgres://$(PROD_DB_USER):$(PROD_DB_PASSWORD)@$(PROD_DB_HOST):$(PROD_DB_PORT)/$(PROD_DB_NAME)?sslmode=disable

.PHONY: update tables

tables:
	docker exec -i fgg-db psql -U $(PROD_DB_USER) -d $(PROD_DB_NAME) -v ON_ERROR_STOP=1 -q < src/tables/00_schemas.sql
	for f in $$(find src/types -name '*.sql' | sort) $$(find src/tables -name '*.sql' ! -name '00_schemas.sql' | sort) $$(find src/seeds -name '*.sql' | sort); do \
		echo "== $$f"; \
		docker exec -i fgg-db psql -U $(PROD_DB_USER) -d $(PROD_DB_NAME) -v ON_ERROR_STOP=1 -q < $$f || exit 1; \
	done

update:
	atlas migrate apply --dir file://migrations --url "$(PROD_URL)"
	for f in $$(find src/functions -name '*.sql' | sort); do \
		docker exec -i fgg-db psql -U $(PROD_DB_USER) -d $(PROD_DB_NAME) -v ON_ERROR_STOP=1 < $$f; \
	done
