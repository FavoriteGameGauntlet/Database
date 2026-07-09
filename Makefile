include .env
export

PROD_URL=postgres://$(PROD_DB_USER):$(PROD_DB_PASSWORD)@$(PROD_DB_HOST):$(PROD_DB_PORT)/$(PROD_DB_NAME)?sslmode=disable

.PHONY: update

update:
	atlas migrate apply --dir file://migrations --url "$(PROD_URL)"
	for f in $$(find src/functions -name '*.sql' | sort); do \
		docker exec -i fgg-db psql -U $(PROD_DB_USER) -d $(PROD_DB_NAME) -v ON_ERROR_STOP=1 < $$f; \
	done
