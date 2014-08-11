#!/usr/bin/perl

#use Inline config => build_noisy => 1;
use Inline config => using => 'ParseRecDescent' => build_noisy => 1;

use Inline C => <<'END_OF_C_CODE';
char* greetings_char(SV* name1, ...) {
    Inline_Stack_Vars;
    int i;
    SV* retval = newSVpv("", 0);
    for (i = 0; i < Inline_Stack_Items; i++)
    {
        retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//      print STDERRf("in greetings_char(), for() loop i = %d, have retval ='%s'\n", i, SvPV_nolen(retval));
    }
    return(SvPV_nolen(retval));
}
END_OF_C_CODE

print greetings_char("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");
