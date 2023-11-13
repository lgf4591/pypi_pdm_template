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
# full_version=$(shell findstr "__version__" pypi_pdm_template\__init__.py)
full_version = $(shell powershell -noprofile -c Get-Content pypi_pdm_template/__init__.py | findstr "__version__")

clean:
	for %%i in ($(clean_dirs)) do ( if exist %%i rd /s /q %%i )

else
SHELL = bash
python_exec = python3
full_version = $(shell cat pypi_pdm_template/__init__.py | grep "__version__")

clean:
	for dir in $(clean_dirs); do \
		rm -rf $$dir; \
	done

endif


version = $(subst ',,$(subst __version__ = ,,$(full_version)))

demo:
	echo $(version)

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

release:
	git add .
	git commit -m "release v$(version)"
	git push
	git tag v$(version) -m "release v$(version)"
	git push origin v$(version)


all: clean lint fix test build
