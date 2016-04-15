// MUST COMPILE USING g++ -std=c++11
#include <iostream>
#include <limits>

using namespace std;

int main () {
 
    cout.precision(100);
    cout << "have std::numeric_limits<double>::digits10 = " << std::numeric_limits<double>::digits10 << endl;
    cout << "have std::numeric_limits<double>::max_digits10 = " << std::numeric_limits<double>::max_digits10 << endl;

    double dfoo = 5.123456789123456789 / 0.987654321987654321;
    long double ldfoo = 5.123456789123456789 / 0.987654321987654321;
    cout << " dfoo = " << dfoo << endl;
    cout << "ldfoo = " << ldfoo << endl;

    return 0;
}
