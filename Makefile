.ONESHELL:
.SILENT:
.SHELLFLAGS := -c
.DEFAULT_GOAL = 

# learn: https://www.bilibili.com/video/BV1xC4y1d7Xs?p=5&vd_source=6cecd1f17a6c0ef08a944dd92199a516
clean_dirs = build dist __pycache__ pypi_pdm_template.egg-info .pdm-build .pytest_cache .mypy_cache __pypackages__

.PHONY: all lint fix test install build publish clean
ifeq ($(OS), Windows_NT)
SHELL = cmd
python_exec = python

clean:
	for %%i in ($(clean_dirs)) do ( if exist %%i rd /s /q %%i )

else
SHELL = bash
python_exec = python3

clean:
	for dir in $(clean_dirs); do \
		rm -rf $$dir; \
	done

endif



run:
	@echo this is $(OS) system, the shell is $(SHELL).
	$(python_exec) main.py

lint:
	$(python_exec) -m flake8

fix:
	$(python_exec) -m yapf -ir main.py ./tests ./pypi_pdm_template

test:
	$(python_exec) -m pytest

install:
	pdm install

build:
	pdm build

publish:
	pdm publish

all: clean lint fix test build
