# pypi_pdm_template
a template for build python package to upload pypi repository bu using pdm



# init project

```powershell

pip install pdm --upgrade
pipx install pdm --upgrade

pdm init
pdm config --local  pypi.url "https://pypi.tuna.tsinghua.edu.cn/simple"
# pdm config --local pypi.url "https://test.pypi.org/simple"
# pdm config pypi.url https://pypi.tuna.tsinghua.edu.cn/simple
# pdm config pypi.extra.url "https://extra.pypi.org/simple"
pdm config --local pypi.extra.url "https://test.pypi.org/simple"

pdm add -dG test pytest pytest-cov
pdm add -dG lint pylint flake8 mypy
pdm add -dG format yapf isort black
pdm add -dG docs mkdocs
pdm plugin add pdm-publish

pdm list
pdm list --graph
pdm list pytest --graph

# 更新所有的 dev 依赖
pdm update -d

# 更新 dev 依赖下某个分组的某个包
pdm update -dG test pytest

如果你的依赖包有设置分组，还可以指定分组进行更新

pdm update -G format -G docs
也可以指定分组更新分组里的某个包

pdm update -G format yapf



```


## publish package

```powershell
config_path: "C:\Users\lgf\AppData\Local\pdm\pdm\config.toml"

pdm config repository.pypi.username "__token__"
pdm config repository.pypi.password "my-pypi-token"

pdm config repository.testpypi.username "__token__"
pdm config repository.testpypi.password "my-pypi-token"

pdm config repository.company.url "https://pypi.company.org/legacy/"
pdm config repository.company.ca_certs "/path/to/custom-cacerts.pem"


```
