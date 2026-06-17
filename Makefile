include .env
export

.PHONY: dev diff apply

DEV_URL=jdbc:postgresql://$(DEV_DB_HOST):$(DEV_DB_PORT)/$(DEV_DB_NAME)
PROD_URL=jdbc:postgresql://$(PROD_DB_HOST):$(PROD_DB_PORT)/$(PROD_DB_NAME)

dev:
	docker compose up -d fgg-db-dev
	liquibase --url=$(DEV_URL) --username=$(DEV_DB_USER) --password=$(DEV_DB_PASSWORD) update

diff:
	liquibase --defaults-file=liquibase.diff.properties \
		--url=$(PROD_URL) --username=$(PROD_DB_USER) --password=$(PROD_DB_PASSWORD) \
		--referenceUrl=$(DEV_URL) --referenceUsername=$(DEV_DB_USER) --referencePassword=$(DEV_DB_PASSWORD) \
		diffChangelog --changelog-file=migrations/diff.xml

apply:
	liquibase --defaults-file=liquibase.diff.properties \
		--url=$(PROD_URL) --username=$(PROD_DB_USER) --password=$(PROD_DB_PASSWORD) \
		--changelog-file=migrations/diff.xml update
