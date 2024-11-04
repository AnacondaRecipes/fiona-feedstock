:: Replace "-lgdal_i" with "-lgdal" if building with libgdal version greater than 3.0.2
%PYTHON% setup.py build_ext -I"%LIBRARY_INC%" -lgdal -L"%LIBRARY_LIB%" install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1
