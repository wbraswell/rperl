#include <stdio.h>
#include <math.h>

int main ()
{
    double fraction_part, integer_part;
    double ratio = -6.725 / 0.025;

    fraction_part = modf(ratio , &integer_part);
    printf ("%.18f = %.18f + %.18f \n", ratio, integer_part, fraction_part);

    printf ("int(ratio) = %d\n", int(ratio));
    printf ("int(integer_part) = %d\n", int(integer_part));
    printf ("int(fraction_part) = %d\n", int(fraction_part));
    return 0;
}
