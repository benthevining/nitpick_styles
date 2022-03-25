SHELL := /bin/sh
.ONESHELL:
.SHELLFLAGS: -euo
.DEFAULT_GOAL: help
.NOTPARALLEL:
.POSIX:

PRECOMMIT ?= pre-commit
GIT ?= git

override REPO_ROOT = $(patsubst %/,%,$(strip $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

.PHONY: init
init:  ## Initializes the workspace and installs all dependencies
	@cd $(REPO_ROOT) && $(PRECOMMIT) install --install-hooks --overwrite && $(PRECOMMIT) install --install-hooks --overwrite --hook-type commit-msg

.PHONY: pc
pc:  ## Runs all pre-commit hooks over all files
	@cd $(REPO_ROOT) && $(GIT) add . && $(PRECOMMIT) run --all-files
