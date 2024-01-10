mkdir -p tests/data
cp test_data/coutwildrnp.zip tests/data
cp test_data/coutwildrnp.tar tests/data
cp test_data/coutwildrnp.json tests/data
cp -r tests /tmp/

pushd /tmp

$PYTHON -m pytest -s -rxs -v -m "not network"  -m "not wheel" -k "not (test_listdir_zipmemoryfile)" tests
popd
$PYTHON -m pip check
fio --help
fio ls test_data/test.shp
fio info test_data/test.shp
