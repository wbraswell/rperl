#include <iostream>
using namespace std;

int main () {

// g++ warning: unknown escape sequence: '\040' [enabled by default]
//    cout << "\ " << endl;
    cout << "\\n" << endl;
//    cout << "\\\ " << endl;
    cout << "\\\\n" << endl;
//    cout << "\\\\\ " << endl;
    cout << "\\\\\\n" << endl;
//    cout << "\\\\\\\ " << endl;
    cout << "\\\\\\\\n" << endl;

    return 0;
}

