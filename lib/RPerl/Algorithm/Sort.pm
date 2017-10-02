
#sub uninherited {
#    { my string $RETURN_TYPE };
#    ( my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Sort::uninherited(), received $person = ' . $person . ', TROUSERS' . "\n");

#    return 'Sort::uninherited() ROCKS! PERLOPS_PERLTYPES';
#}

1;    # end of class

# DISABLED
# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
#RPerl::diag("WAZZUP FROM Sort.pm\n");
#inherited('FAKESELF', "Spidey");
#RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
#RPerl::Algorithm::Sort->inherited("Mary Jane");

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
#uninherited('Doc Oc');
#RPerl::Algorithm::Sort::uninherited("Doctor Octavius");
#RPerl::Algorithm::Sort->uninherited("Mad Scientist");  # ignores "Mad Scientist"
#RPerl::diag("LATERZ FROM Sort.pm\n");
