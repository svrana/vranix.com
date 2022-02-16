SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

DISTRIBUTION_ID:=E3JXHZWSBF3SG3
BUCKET_NAME:=vranix.com-cdn

DATE 		:= $(shell date +"%a %b %d %T %Y")
UNAME_S 	:= $(shell uname -s | tr A-Z a-z)

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[/.a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build website
	HUGO_ENV=production hugo --gc --minify

.PHONY: serve
serve: ## Run the hugo server to see changes as you make them
	@hugo server -D

.PHONY: deploy
deploy: build ## Deploy to AWS
	# Copy over pages - not static js/img/css/downloads
	aws s3 sync --acl "public-read" --sse "AES256" public/ s3://${BUCKET_NAME} --exclude 'post'
	aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths /index.html / /page/*



