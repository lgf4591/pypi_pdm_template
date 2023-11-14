.ONESHELL:
.SILENT:
.SHELLFLAGS := -c
.DEFAULT_GOAL = 

project_name = $(notdir $(CURDIR))


# learn: https://www.bilibili.com/video/BV1xC4y1d7Xs?p=5&vd_source=6cecd1f17a6c0ef08a944dd92199a516
clean_dirs = build dist __pycache__ .pdm-build .pytest_cache .mypy_cache __pypackages__


.PHONY: all git lint fix test install build publish clean check demo debug release
ifeq ($(OS), Windows_NT)
SHELL = cmd
python_exec = python
full_version=$(shell findstr "__version__" $(project_name)\__init__.py)
# full_version = $(shell powershell -noprofile -c Get-Content $(project_name)/__init__.py | findstr "__version__")
full_toml_version = $(shell findstr "version" pyproject.toml)
# full_toml_project_name = $(shell findstr "name" pyproject.toml)
full_toml_project_name = $(shell powershell -noprofile -c 'findstr "name" pyproject.toml | Select -First 1')
# full_toml_project_name = $(shell powershell -noprofile -c 'Get-Content pyproject.toml | Select-String "name" | Select -First 1') # BUG: 用这个方法居然显示不相等???


clean:
	if exist $(project_name).egg-info rd /s /q $(project_name).egg-info
	for %%i in ($(clean_dirs)) do ( if exist %%i rd /s /q %%i )

else
SHELL = bash
python_exec = python3
full_version = $(shell cat $(project_name)/__init__.py | grep "__version__")
full_toml_version = $(shell cat pyproject.toml | grep "version")
full_toml_project_name = $(shell cat pyproject.toml | grep "name" | head -n 1)

clean:
	rm -rf $(project_name).egg-info
	for dir in $(clean_dirs); do \
		rm -rf $$dir; \
	done

endif


version = $(subst ',,$(subst __version__ = ,,$(full_version)))
tomal_version = $(subst ",,$(subst version = ,,$(full_toml_version)))
toml_project_name = $(subst ",,$(subst name = ,,$(full_toml_project_name)))


ifeq ($(project_name), $(toml_project_name))
	project_name_check = "project name check pass."
else
	project_name_check = "project name check fail! the config toml file's project name: $(toml_project_name) is not equal project name : $(project_name) "
endif

ifeq ($(version), $(tomal_version))
	version_check = "project version check pass."
else
	version_check = "project version check fail! the package version '$(project_name)/__init__.py' : $(version) is not equal config toml file's version: $(tomal_version)"
endif

ifneq ($(wildcard $(project_name)),)
    package_name_check = "package folder name check pass."
else
    package_name_check = "package folder name check fail! please create or rename package folder name as: $(project_name)"
endif




debug:
	echo $(toml_project_name)

check:
	echo $(project_name_check)
	echo $(version_check)
	echo $(package_name_check)

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

git:
	git add .
	git commit -m "release v$(version)"
	git push
	git tag v$(version) -m "release v$(version)"
	git push origin v$(version)


all: clean check lint fix test publish clean
release: clean check lint fix test git
