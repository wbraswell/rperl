#include <iostream>
using namespace std;

int main () {
    unsigned int uifoo = 5;
    unsigned int uibar = ~ uifoo;
    cout << "uifoo   = " << uifoo << endl;
    cout << "uibar   = " << uibar << endl;

    unsigned long int ulifoo = 5;
    unsigned long int ulibar = ~ ulifoo;
    cout << "ulifoo  = " << ulifoo << endl;
    cout << "ulibar  = " << ulibar << endl;

    unsigned long long int ullifoo = 5;
    unsigned long long int ullibar = ~ ullifoo;
    cout << "ullifoo = " << ullifoo << endl;
    cout << "ullibar = " << ullibar << endl;



    int ifoo = 5;
    int ibar = ~ ifoo;
    cout << "ifoo    = " << ifoo << endl;
    cout << "ibar    = " << ibar << endl;

    long int lifoo = 5;
    long int libar = ~ lifoo;
    cout << "lifoo   = " << lifoo << endl;
    cout << "libar   = " << libar << endl;

    long long int llifoo = 5;
    long long int llibar = ~ llifoo;
    cout << "llifoo  = " << llifoo << endl;
    cout << "llibar  = " << llibar << endl;

    return 0;
}
