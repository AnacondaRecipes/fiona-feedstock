if not exist tests\data mkdir tests\data || exit 1
xcopy test_data\coutwildrnp.zip tests\data /s /e /y || exit 1
xcopy test_data\coutwildrnp.tar tests\data /s /e /y || exit 1
xcopy test_data\coutwildrnp.json tests\data /s /e /y || exit 1

%PYTHON% -m pytest -s -rxs -v -m "not network"  -m "not wheel" -k "not (test_listdir_zipmemoryfile)" tests
%PYTHON% -m pip check
fio --help
fio ls test_data/test.shp
fio info test_data/test.shp