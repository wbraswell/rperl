#include <iostream>
using namespace std;

int main () {
    unsigned long int ufoo = 5;
    unsigned long int ubar = ~ ufoo;
    cout << "ufoo = " << ufoo << endl;
    cout << "ubar = " << ubar << endl;

    long int sfoo = 5;
    long int sbar = ~ sfoo;
    cout << "sfoo = " << sfoo << endl;
    cout << "sbar = " << sbar << endl;
    return 0;
}
