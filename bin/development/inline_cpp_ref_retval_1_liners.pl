# retval F, same as t/namespace/06inherit.t
package F; use Inline CPP => 'class F { public: F() {} };' => namespace => ''; package main; print ref(F->new()), "\n";

# retval main::F, same as t/classes/06inherit.t
#package P; use Inline CPP => 'class P { public: P() {} };' => namespace => '' => classes => { 'P' => 'F'}; package main; print ref(F->new()), "\n";

# EXPERIMENTAL COMBINATIONS BELOW THIS LINE

# retval main::F
#package P; use Inline CPP => 'class P { public: P() {} };' => namespace => 'main' => classes => { 'P' => 'F'}; package main; print ref(F->new()), "\n";

# retval main::F
#package main; use Inline CPP => 'class P { public: P() {} };' => namespace => '' => classes => { 'P' => 'F'}; print ref(F->new()), "\n";

# retval main::F
#package main; use Inline CPP => 'class P { public: P() {} };' => classes => { 'P' => 'F'}; print ref(F->new()), "\n";

# retval main::F
#use Inline CPP => 'class P { public: P() {} };' => namespace => '' => classes => { 'P' => 'F'}; print ref(F->new()), "\n";

# retval main::F
#use Inline CPP => 'class P { public: P() {} };' => classes => { 'P' => 'F'}; print ref(F->new()), "\n";
