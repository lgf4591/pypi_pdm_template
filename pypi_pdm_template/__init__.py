# coding=utf-8
# this allows to use "from utils import conversion" in __main__.py
import os
import sys

sys.path.append(
    os.path.dirname(os.path.realpath(__file__))
)  # https://stackoverflow.com/questions/16981921/relative-imports-in-python-3
sys.path.append(os.path.dirname(os.path.realpath(__file__ + '/gui')))
sys.path.append(os.path.dirname(os.path.realpath(__file__ + '/utils')))

__version__ = '0.1.0'
__description__ = 'a template for build python package to upload pypi repository bu using pdm'
__author__ = 'lgf4591'
__author_email__ = 'lgf4591@outlook.com'
__url__ = 'https://github.com/lgf4591/pypi_pdm_template'
__license__ = 'MIT License'
