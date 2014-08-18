SV* my_function() { return(newSVpv("RETVAL FROM my_function()", 25)); }

class RPerl__Test__Inline_CPP_Debug
{
public:
    SV* my_method() { return my_function(); }
    RPerl__Test__Inline_CPP_Debug() {}
    ~RPerl__Test__Inline_CPP_Debug() {}
};
