:: There is no `gdal-config` on Windows so we need figure it out from gdalinfo
for /F "USEBACKQ tokens=2 delims=, " %%F in (`gdalinfo --version`) do (
set GDAL_VERSION=%%F
)
if errorlevel 1 exit 1
echo "set GDAL_VERSION=%GDAL_VERSION%"

%PYTHON% -m pip install --no-deps --no-use-pep517 --ignore-installed . ^
                        --global-option=build_ext ^
                        --global-option="-I%LIBRARY_INC%" ^
                        --global-option="-L%LIBRARY_LIB%" ^
                        --global-option="-lgdal"
if errorlevel 1 exit 1
