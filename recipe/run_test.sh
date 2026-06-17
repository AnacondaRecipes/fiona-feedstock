mkdir -p tests/data
cp test_data/coutwildrnp.zip tests/data
cp test_data/coutwildrnp.tar tests/data
cp test_data/coutwildrnp.json tests/data
cp -r tests /tmp/

pushd /tmp

skip_tests=()

# returned json with GDAL 3.13 has different whitespace formatting than previous version which fiona's tests
# assert exactly against. tests can be restored once resolved: https://github.com/Toblerity/Fiona/issues/1512
skip_tests+=(--deselect=tests/test_collection.py::test_open_kwargs)
skip_tests+=(--deselect=tests/test_subtypes.py::test_write_bool_subtype)

# known GeoJSON driver limitation, which since v3.13 also manifests itself as test failure. restore once fixed upstream.
# E Failed to remove datasource. fiona.errors.DatasetDeleteError: Driver does not support dataset removal operation
skip_tests+=(--deselect=tests/test_fio_rm.py::test_remove[GeoJSON])
skip_tests+=(--deselect=tests/test_remove.py::test_remove[GeoJSON-path-True])
skip_tests+=(--deselect=tests/test_remove.py::test_remove[GeoJSON-path-False])
skip_tests+=(--deselect=tests/test_remove.py::test_remove[GeoJSON-collection-True])
skip_tests+=(--deselect=tests/test_remove.py::test_remove[GeoJSON-collection-False])

$PYTHON -m pytest -s -rxs -v -m "not network"  -m "not wheel" "${skip_tests[@]}" tests
popd
$PYTHON -m pip check
fio --help
fio ls test_data/test.shp
fio info test_data/test.shp
