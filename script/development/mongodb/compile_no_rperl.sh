reset
./link_no_rperl.sh
rm a.out
g++ --std=c++11 mongodb_insert_one_find_one.cpp $(pkg-config --cflags --libs libmongocxx) -Wl,-rpath,/usr/local/lib
