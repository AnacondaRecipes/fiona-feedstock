mkdir -p tests/data
cp test_data/coutwildrnp.zip tests/data
cp test_data/coutwildrnp.tar tests/data
cp test_data/coutwildrnp.json tests/data
cp -r tests /tmp/

pushd /tmp

# Skip test_open_repr and test_open_s3 because of the following errors:
# - test_open_repr: fiona.errors.DriverError: Failed to open dataset (flags=68): /vsizip//private/tmp/tests/data/coutwildrnp.zip/coutwildrnp.shp
# - test_open_s3: fiona.errors.DriverError: Failed to open dataset (flags=68): /vsizip/vsis3/fiona-testing/coutwildrnp.zip
$PYTHON -m pytest -s -rxs -v -m "not network"  -m "not wheel" -k "not (test_listdir_zipmemoryfile or test_open_repr or test_open_s3)" tests
popd
$PYTHON -m pip check
fio --help
fio ls test_data/test.shp
fio info test_data/test.shp
