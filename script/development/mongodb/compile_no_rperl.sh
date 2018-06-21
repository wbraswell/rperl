reset
./link_no_rperl.sh
rm a.out
#g++ --std=c++11 mongodb_insert_one_find_one.cpp $(pkg-config --cflags --libs libmongocxx) -Wl,-rpath,/usr/local/lib

#c++ --std=c++11 mongocxx_test.cpp -o mongocxx_test -I/usr/include/mongocxx/v_noabi -I/usr/include/bsoncxx/v_noabi/ -L/usr/lib -Wl,-rpath,/usr/lib -lmongocxx -lbsoncxx
g++ --std=c++11 mongodb_insert_one_find_one.cpp -o mongodb_insert_one_find_one -I/usr/include/mongocxx/v_noabi -I/usr/include/bsoncxx/v_noabi/ -L/usr/lib -Wl,-rpath,/usr/lib -lmongocxx -lbsoncxx
