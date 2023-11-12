

$folders= "dist", "build", ".pdm-build", "__pycache__", ".mypy_cache", ".pytest_cache", "pypi_pdm_template.egg-info"
foreach ($folder in $folders)  
{  
  Remove-Item -LiteralPath $folder -Force -Recurse -ErrorAction SilentlyContinue
}
