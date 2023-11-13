ifeq ($(OS), Windows_NT)
run:
	python main.py

install: pyproject.toml
	pdm install

lint:
	python -m flake8

fix:
	python -m yapf -ir main.py ./tests ./pypi_pdm_template

test:
	python -m pytest

build:
	pdm build

publish:
	pdm publish

.PHONY: clean
clean:
	if exist "./build" rd /s /q build
	if exist "./dist" rd /s /q dist
	if exist "./.pdm-build" rd /s /q .pdm-build
	if exist "./__pycache__" rd /s /q __pycache__
	if exist "./.pytest_cache" rd /s /q .pytest_cache
	if exist "./.mypy_cache" rd /s /q .mypy_cache
	if exist "./pypi_pdm_template.egg-info" rd /s /q pypi_pdm_template.egg-info

else
run:
	python3 main.py

install: pyproject.toml
	pdm install

lint:
	python3 -m flake8

fix:
	python3 -m yapf -ir main.py ./tests ./pypi_pdm_template

test:
	python3 -m pytest

build:
	pdm build

publish:
	pdm publish

.PHONY: clean
clean:
	rm -rf build
	rm -rf dist
	rm -rf .pdm-build
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf pypi_pdm_template.egg-info

endif
