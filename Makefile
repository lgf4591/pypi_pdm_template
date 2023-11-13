.ONESHELL:
.SHELLFLAGS := -c

clean_dirs = build dist __pycache__ pypi_pdm_template.egg-info .pdm-build .pytest_cache .mypy_cache

ifeq ($(OS), Windows_NT)
SHELL = cmd
python_exec = python

.PHONY: clean
clean:
	for %%dir in ($(clean_dirs)) do ( if exist %%dir rd /s /q %%dir )

else
SHELL = bash
python_exec = python3

.PHONY: clean
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

install: pyproject.toml
	pdm install

build:
	pdm build

publish:
	pdm publish
