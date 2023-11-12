

Remove-Item -LiteralPath "dist" -Force -Recurse
Remove-Item -LiteralPath "build" -Force -Recurse
Remove-Item -LiteralPath "pypi_pdm_template.egg-info" -Force -Recurse
pdm build
