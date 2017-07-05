########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.21.
#
# Copyright © 2006, 2007, 2008, 2009, 2010, 2011, 2012 Casiano Rodriguez-Leon.
# Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
# Parse::Yapp is Copyright © 1998, 1999, 2000, 2001, Francois Desarmenien.
# Parse::Yapp is Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
#        Don't edit this file, use source file 'lib/RPerl/Grammar.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package RPerl::Grammar;
use strict;

push @RPerl::Grammar::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 5 "lib/RPerl/Grammar.eyp"

    # [[[ HEADER ]]]
    use strict;
    use warnings;
    our $VERSION = 0.007_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\$TYPED_|\=\ sub\ \{|package|foreach|\@ARG\;|undef|elsif|while|else|for|our|if|\%\{|\@\{|\}|\;|\]|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use\s+)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('([^'\\]+|(?:\\\\)+)+')|("((\\n)|(\\t)|[^"\@\$\\])*((\\n)|(\\t))+((\\n)|(\\t)|[^"\@\$\\])*")|(q\{([^}\\]+|(?:\\\\)+)*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$self)/gc and return ('SELF', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer|unsigned_integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G((?:[a-zA-Z]\w*)+(?:::[a-zA-Z]\w*)*::method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)(?:::[a-zA-Z]\w*)*(?:::[A-Z0-9_]*)\(\))/gc and return ('CONSTANT_CALL_SCOPED', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(\@ARGV)/gc and return ('ARGV', $1);
      /\G(\%ENV)/gc and return ('ENV', $1);
      /\G(or|xor)\s/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)\s/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NEG', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next;|last;)/gc and return ('OP19_LOOP_CONTROL_SCOLON', $1);
      /\G(next|last|redo)\s/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|<=>|eq|ne|cmp)\s/gc and return ('OP12_COMPARE_EQ_NE', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(-A;|-B;|-C;|-M;|-O;|-R;|-S;|-T;|-W;|-X;|-b;|-c;|-d;|-e;|-f;|-g;|-k;|-l;|-o;|-p;|-r;|-s;|-t;|-u;|-w;|-x;|-z;|alarm;|caller;|chdir;|chroot;|cos;|defined;|delete;|do;|eval;|exists;|gethostbyname;|getnetbyname;|getpgrp;|getprotobyname;|glob;|gmtime;|goto;|hex;|int;|lc;|lcfirst;|length;|localtime;|lock;|log;|lstat;|oct;|ord;|quotemeta;|rand;|readlink;|ref;|require;|rmdir;|scalar;|sin;|sleep;|sqrt;|srand;|stat;|uc;|ucfirst;|umask;)/gc and return ('OP10_NAMED_UNARY_SCOLON', $1);
      /\G(-A\s|-B\s|-C\s|-M\s|-O\s|-R\s|-S\s|-T\s|-W\s|-X\s|-b\s|-c\s|-d\s|-e\s|-f\s|-g\s|-k\s|-l\s|-o\s|-p\s|-r\s|-s\s|-t\s|-u\s|-w\s|-x\s|-z\s|alarm\s|caller\s|chdir\s|chroot\s|cos\s|defined\s|delete\s|do\s|eval\s|exists\s|gethostbyname\s|getnetbyname\s|getpgrp\s|getprotobyname\s|glob\s|gmtime\s|goto\s|hex\s|int\s|lc\s|lcfirst\s|length\s|localtime\s|lock\s|log\s|lstat\s|oct\s|ord\s|quotemeta\s|rand\s|readlink\s|ref\s|require\s|rmdir\s|scalar\s|sin\s|sleep\s|sqrt\s|srand\s|stat\s|uc\s|ucfirst\s|umask\s)/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(\+=|-=|\*=|\/=|\.=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%|sse_mul|sse_div)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x)\s/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_BIND', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(\~\()/gc and return ('OP05_BITWISE_NEG_LPAREN', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->new\()/gc and return ('OP02_METHOD_THINARROW_NEW', $1);
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-\s|sse_add|sse_sub)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|le|ge|lt|gt)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\([^()]*\))/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(abs;|accept;|atan2;|bind;|binmode;|bless;|break;|chmod;|chomp;|chop;|chown;|chr;|closedir;|connect;|continue;|crypt;|dbmclose;|dbmopen;|default;|dump;|each;|endgrent;|endhostent;|endnetent;|endprotoent;|endpwent;|endservent;|eof;|evalbytes;|exec;|exp;|fc;|fcntl;|fileno;|flock;|fork;|format;|formline;|getc;|getgrent;|getgrgid;|getgrnam;|gethostbyaddr;|gethostent;|getlogin;|getnetbyaddr;|getnetent;|getpeername;|getppid;|getpriority;|getprotobynumber;|getprotoent;|getpwent;|getpwnam;|getpwuid;|getservbyname;|getservbyport;|getservent;|getsockname;|getsockopt;|given;|grep;|index;|ioctl;|join;|keys;|kill;|link;|listen;|local;|m;|map;|mkdir;|msgctl;|msgget;|msgrcv;|msgsnd;|opendir;|pack;|pipe;|pop;|pos;|prototype;|push;|q;|qq;|qr;|qx;|read;|readdir;|readline;|readpipe;|recv;|rename;|reset;|reverse;|rewinddir;|rindex;|s;|say;|seek;|seekdir;|select;|semctl;|semget;|semop;|send;|setgrent;|sethostent;|setnetent;|setpgrp;|setpriority;|setprotoent;|setpwent;|setservent;|setsockopt;|shift;|shmctl;|shmget;|shmread;|shmwrite;|shutdown;|socket;|socketpair;|sort;|splice;|split;|sprintf;|state;|study;|substr;|symlink;|syscall;|sysopen;|sysread;|sysseek;|system;|syswrite;|tell;|telldir;|tie;|tied;|time;|times;|tr;|truncate;|unless;|unlink;|unpack;|unshift;|untie;|until;|utime;|values;|vec;|wait;|waitpid;|wantarray;|warn;|when;|write;|y;)/gc and return ('OP01_NAMED_SCOLON', $1);
      /\G(abs\s|accept\s|atan2\s|bind\s|binmode\s|bless\s|break\s|chmod\s|chomp\s|chop\s|chown\s|chr\s|closedir\s|connect\s|continue\s|crypt\s|dbmclose\s|dbmopen\s|default\s|dump\s|each\s|endgrent\s|endhostent\s|endnetent\s|endprotoent\s|endpwent\s|endservent\s|eof\s|evalbytes\s|exec\s|exp\s|fc\s|fcntl\s|fileno\s|flock\s|fork\s|format\s|formline\s|getc\s|getgrent\s|getgrgid\s|getgrnam\s|gethostbyaddr\s|gethostent\s|getlogin\s|getnetbyaddr\s|getnetent\s|getpeername\s|getppid\s|getpriority\s|getprotobynumber\s|getprotoent\s|getpwent\s|getpwnam\s|getpwuid\s|getservbyname\s|getservbyport\s|getservent\s|getsockname\s|getsockopt\s|given\s|grep\s|index\s|ioctl\s|join\s|keys\s|kill\s|link\s|listen\s|local\s|m\s|map\s|mkdir\s|msgctl\s|msgget\s|msgrcv\s|msgsnd\s|opendir\s|pack\s|pipe\s|pop\s|pos\s|prototype\s|push\s|q\s|qq\s|qr\s|qx\s|read\s|readdir\s|readline\s|readpipe\s|recv\s|rename\s|reset\s|reverse\s|rewinddir\s|rindex\s|s\s|say\s|seek\s|seekdir\s|select\s|semctl\s|semget\s|semop\s|send\s|setgrent\s|sethostent\s|setnetent\s|setpgrp\s|setpriority\s|setprotoent\s|setpwent\s|setservent\s|setsockopt\s|shift\s|shmctl\s|shmget\s|shmread\s|shmwrite\s|shutdown\s|socket\s|socketpair\s|sort\s|splice\s|split\s|sprintf\s|state\s|study\s|substr\s|symlink\s|syscall\s|sysopen\s|sysread\s|sysseek\s|system\s|syswrite\s|tell\s|telldir\s|tie\s|tied\s|time\s|times\s|tr\s|truncate\s|unless\s|unlink\s|unpack\s|unshift\s|untie\s|until\s|utime\s|values\s|vec\s|wait\s|waitpid\s|wantarray\s|warn\s|when\s|write\s|y\s)/gc and return ('OP01_NAMED', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 149 lib/RPerl/Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@RPerl::Grammar::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.21',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'CompileUnit', '$end' ], 0 ],
  [ '_PAREN' => 'PAREN-1', [ 'ModuleHeader', 'Module' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PLUS-2', 'PAREN-1' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PAREN-1' ], 0 ],
  [ 'CompileUnit_4' => 'CompileUnit', [ 'Program' ], 0 ],
  [ 'CompileUnit_5' => 'CompileUnit', [ 'PLUS-2' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-4', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [ 'STAR-7', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'PLUS-8', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'Operation' ], 0 ],
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'USE_RPERL', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [ 'USE_RPERL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [  ], 0 ],
  [ 'ModuleHeader_23' => 'ModuleHeader', [ 'OPTIONAL-9', 'OPTIONAL-10', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_24' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_25' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [ 'STAR-12', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [ 'STAR-13', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'PLUS-14', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'Subroutine' ], 0 ],
  [ 'Package_34' => 'Package', [ 'STAR-11', 'STAR-12', 'STAR-13', 'PLUS-14', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [ 'USE_RPERL_AFTER' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [  ], 0 ],
  [ 'Header_37' => 'Header', [ 'use strict;', 'use warnings;', 'OPTIONAL-15', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-16', [ 'PLUS-16', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-16', [ 'WORD' ], 0 ],
  [ 'Critic_40' => 'Critic', [ '## no critic qw(', 'PLUS-16', ')' ], 0 ],
  [ 'Include_41' => 'Include', [ 'USE', 'WordScoped', ';' ], 0 ],
  [ 'Include_42' => 'Include', [ 'USE', 'WordScoped', 'OP01_QW', ';' ], 0 ],
  [ 'Constant_43' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [ 'STAR-18', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [  ], 0 ],
  [ 'Subroutine_48' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-17', 'STAR-18', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-20', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'SubroutineOrMethod' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ 'Class_61' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-21', 'STAR-22', 'STAR-23', 'Properties', 'STAR-24', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'PAREN-25' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ 'Properties_65' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'Method_71' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-27', 'STAR-28', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'PAREN-29' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'MethodArguments_75' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-30', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_76' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_77' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_78' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_79' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_80' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_81' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'PAREN-31' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-32', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-33', ')', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_124' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_134' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_143' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_144' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_145' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_146' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_147' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_148' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_163' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_164' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_167' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_168' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_169' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_170' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_171' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_174' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_177' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_180' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_182' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_183' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_184' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_185' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_186' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_190' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_194' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_197' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_200' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_201' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_204' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_205' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_207' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_211' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_212' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_215' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_216' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_217' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_218' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_219' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_220' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_221' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_222' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_223' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_224' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_225' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_226' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_227' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_228' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_229' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_230' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_231' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_232' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_233' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_234' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_235' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_236' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_237' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_238' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_239' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_240' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_241' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_242' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_243' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_244' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_245' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_246' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_247' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_248' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_249' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_250' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_251' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_252' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_253' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_254' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'WORD' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PAREN' => 1,
  '_PLUS_LIST' => 2,
  '_PLUS_LIST' => 3,
  'CompileUnit_4' => 4,
  'CompileUnit_5' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_STAR_LIST' => 8,
  '_STAR_LIST' => 9,
  '_STAR_LIST' => 10,
  '_STAR_LIST' => 11,
  '_STAR_LIST' => 12,
  '_STAR_LIST' => 13,
  '_STAR_LIST' => 14,
  '_STAR_LIST' => 15,
  '_PLUS_LIST' => 16,
  '_PLUS_LIST' => 17,
  'Program_18' => 18,
  '_OPTIONAL' => 19,
  '_OPTIONAL' => 20,
  '_OPTIONAL' => 21,
  '_OPTIONAL' => 22,
  'ModuleHeader_23' => 23,
  'Module_24' => 24,
  'Module_25' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_STAR_LIST' => 28,
  '_STAR_LIST' => 29,
  '_STAR_LIST' => 30,
  '_STAR_LIST' => 31,
  '_PLUS_LIST' => 32,
  '_PLUS_LIST' => 33,
  'Package_34' => 34,
  '_OPTIONAL' => 35,
  '_OPTIONAL' => 36,
  'Header_37' => 37,
  '_PLUS_LIST' => 38,
  '_PLUS_LIST' => 39,
  'Critic_40' => 40,
  'Include_41' => 41,
  'Include_42' => 42,
  'Constant_43' => 43,
  '_OPTIONAL' => 44,
  '_OPTIONAL' => 45,
  '_STAR_LIST' => 46,
  '_STAR_LIST' => 47,
  'Subroutine_48' => 48,
  '_PAREN' => 49,
  '_STAR_LIST' => 50,
  '_STAR_LIST' => 51,
  'SubroutineArguments_52' => 52,
  '_STAR_LIST' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'Class_61' => 61,
  '_PAREN' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  'Properties_65' => 65,
  'Properties_66' => 66,
  '_OPTIONAL' => 67,
  '_OPTIONAL' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  'Method_71' => 71,
  '_PAREN' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  'MethodArguments_75' => 75,
  'SubroutineOrMethod_76' => 76,
  'SubroutineOrMethod_77' => 77,
  'Operation_78' => 78,
  'Operation_79' => 79,
  'Operation_80' => 80,
  'Operation_81' => 81,
  'Operator_82' => 82,
  'Operator_83' => 83,
  'Operator_84' => 84,
  'Operator_85' => 85,
  'Operator_86' => 86,
  'Operator_87' => 87,
  'Operator_88' => 88,
  'Operator_89' => 89,
  'Operator_90' => 90,
  'Operator_91' => 91,
  'Operator_92' => 92,
  'Operator_93' => 93,
  'Operator_94' => 94,
  'Operator_95' => 95,
  'Operator_96' => 96,
  'Operator_97' => 97,
  'Operator_98' => 98,
  'Operator_99' => 99,
  'Operator_100' => 100,
  'Operator_101' => 101,
  'Operator_102' => 102,
  'Operator_103' => 103,
  'Operator_104' => 104,
  'Operator_105' => 105,
  'Operator_106' => 106,
  'Operator_107' => 107,
  'Operator_108' => 108,
  'Operator_109' => 109,
  'Operator_110' => 110,
  'Operator_111' => 111,
  '_PAREN' => 112,
  '_OPTIONAL' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  'OperatorVoid_124' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  'Expression_129' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'Expression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpression_143' => 143,
  'SubExpressionOrInput_144' => 144,
  'SubExpressionOrInput_145' => 145,
  'SubExpressionOrInput_146' => 146,
  'SubExpressionOrVarMod_147' => 147,
  'SubExpressionOrVarMod_148' => 148,
  '_PAREN' => 149,
  '_OPTIONAL' => 150,
  '_OPTIONAL' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  '_PAREN' => 157,
  '_STAR_LIST' => 158,
  '_STAR_LIST' => 159,
  '_PAREN' => 160,
  '_OPTIONAL' => 161,
  '_OPTIONAL' => 162,
  'Conditional_163' => 163,
  'Loop_164' => 164,
  'Loop_165' => 165,
  'Loop_166' => 166,
  'LoopFor_167' => 167,
  'LoopFor_168' => 168,
  'LoopForEach_169' => 169,
  'LoopWhile_170' => 170,
  'LoopWhile_171' => 171,
  '_PLUS_LIST' => 172,
  '_PLUS_LIST' => 173,
  'CodeBlock_174' => 174,
  '_STAR_LIST' => 175,
  '_STAR_LIST' => 176,
  'Variable_177' => 177,
  'VariableRetrieval_178' => 178,
  'VariableRetrieval_179' => 179,
  'VariableRetrieval_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableDeclaration_182' => 182,
  'VariableDeclaration_183' => 183,
  'VariableDeclaration_184' => 184,
  'VariableModification_185' => 185,
  'VariableModification_186' => 186,
  '_PAREN' => 187,
  '_STAR_LIST' => 188,
  '_STAR_LIST' => 189,
  'ListElements_190' => 190,
  'ListElement_191' => 191,
  'ListElement_192' => 192,
  'ListElement_193' => 193,
  'ListElement_194' => 194,
  '_OPTIONAL' => 195,
  '_OPTIONAL' => 196,
  'ArrayReference_197' => 197,
  '_OPTIONAL' => 198,
  '_OPTIONAL' => 199,
  'ArrayDereference_200' => 200,
  'ArrayDereference_201' => 201,
  '_OPTIONAL' => 202,
  '_OPTIONAL' => 203,
  'HashEntry_204' => 204,
  'HashEntry_205' => 205,
  'HashEntry_206' => 206,
  'HashEntryProperties_207' => 207,
  '_PAREN' => 208,
  '_STAR_LIST' => 209,
  '_STAR_LIST' => 210,
  'HashReference_211' => 211,
  'HashReference_212' => 212,
  '_OPTIONAL' => 213,
  '_OPTIONAL' => 214,
  'HashDereference_215' => 215,
  'HashDereference_216' => 216,
  'WordScoped_217' => 217,
  'WordScoped_218' => 218,
  'LoopLabel_219' => 219,
  'Type_220' => 220,
  'Type_221' => 221,
  'Type_222' => 222,
  'TypeInner_223' => 223,
  'TypeInnerProperties_224' => 224,
  'TypeInnerProperties_225' => 225,
  'TypeInnerConstant_226' => 226,
  'VariableOrLiteral_227' => 227,
  'VariableOrLiteral_228' => 228,
  'VarOrLitOrOpStrOrWord_229' => 229,
  'VarOrLitOrOpStrOrWord_230' => 230,
  'VarOrLitOrOpStrOrWord_231' => 231,
  'VariableSymbolOrSelf_232' => 232,
  'VariableSymbolOrSelf_233' => 233,
  'Literal_234' => 234,
  'Literal_235' => 235,
  'OpNamedScolonOrSubExp_236' => 236,
  'OpNamedScolonOrSubExp_237' => 237,
  'OpNamedScolonOrSubExp_238' => 238,
  'OpNamedScolonOrSubExpIn_239' => 239,
  'OpNamedScolonOrSubExpIn_240' => 240,
  'OpNamedScolonOrSubExpIn_241' => 241,
  'OpStringOrWord_242' => 242,
  'OpStringOrWord_243' => 243,
  'OpStringOrWord_244' => 244,
  'OpStringOrWord_245' => 245,
  'OpStringOrWord_246' => 246,
  'OpStringOrWord_247' => 247,
  'OpStringOrWord_248' => 248,
  'OpStringOrWord_249' => 249,
  'OpStringOrWord_250' => 250,
  'OpStringOrWord_251' => 251,
  'OpStringOrWord_252' => 252,
  'OpStringOrWord_253' => 253,
  'OpStringOrWord_254' => 254,
  'OpStringOrWord_255' => 255,
  'OpStringOrWord_256' => 256,
  'OpStringOrWord_257' => 257,
  'OpStringOrWord_258' => 258,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@ARG;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'our hashref $properties' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ARGV => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	ENV => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_IN => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	LPAREN_MY => { ISSEMANTIC => 1 },
	MY => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_SCOLON => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_LPAREN => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_SCOLON => { ISSEMANTIC => 1 },
	OP01_OPEN => { ISSEMANTIC => 1 },
	OP01_PRINT => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW_NEW => { ISSEMANTIC => 1 },
	OP03_MATH_INC_DEC => { ISSEMANTIC => 1 },
	OP04_MATH_POW => { ISSEMANTIC => 1 },
	OP05_BITWISE_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP05_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP05_MATH_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP06_REGEX_BIND => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP07_STRING_REPEAT => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY_SCOLON => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NE => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL_SCOLON => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN_BY => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	SELF => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	USE => { ISSEMANTIC => 1 },
	USE_RPERL => { ISSEMANTIC => 1 },
	USE_RPERL_AFTER => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER_ASSIGN => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	WORD_UPPERCASE => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"## no critic qw(" => 8,
			'SHEBANG' => 2,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'PAREN-1' => 3,
			'ModuleHeader' => 7,
			'Program' => 6,
			'PLUS-2' => 5,
			'CompileUnit' => 1,
			'Critic' => 4,
			'OPTIONAL-9' => 9
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 8,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 8,
			'' => -5,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'ModuleHeader' => 7,
			'PAREN-1' => 13,
			'OPTIONAL-9' => 9,
			'Critic' => 4
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			"use parent qw(" => 15,
			"## no critic qw(" => -27,
			'USE' => -27,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'Module' => 18,
			'Package' => 16,
			'Class' => 17,
			'STAR-11' => 14
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-16' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 22
		},
		GOTOS => {
			'OPTIONAL-10' => 21
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			'USE_RPERL' => 23
		}
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			"use constant" => -29,
			'USE' => -29,
			"our" => -29,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 24,
			'STAR-12' => 25
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		ACTIONS => {
			"package" => 31
		}
	},
	{#State 22
		DEFAULT => -21
	},
	{#State 23
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 33
		}
	},
	{#State 24
		DEFAULT => -26
	},
	{#State 25
		ACTIONS => {
			"use constant" => -31,
			'USE' => 34,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 36,
			'Include' => 35
		}
	},
	{#State 26
		DEFAULT => -218
	},
	{#State 27
		ACTIONS => {
			")" => 37
		}
	},
	{#State 28
		DEFAULT => -217
	},
	{#State 29
		DEFAULT => -38
	},
	{#State 30
		DEFAULT => -40
	},
	{#State 31
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use warnings;" => 39
		}
	},
	{#State 33
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 35
		DEFAULT => -28
	},
	{#State 36
		ACTIONS => {
			"our" => 43,
			"use constant" => 42
		},
		GOTOS => {
			'Subroutine' => 44,
			'Constant' => 46,
			'PLUS-14' => 45
		}
	},
	{#State 37
		ACTIONS => {
			";" => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 49
		},
		GOTOS => {
			'OPTIONAL-15' => 50
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_PRINT' => -11,
			'OP01_NAMED' => -11,
			'WORD' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LBRACE' => -11,
			'LBRACKET' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'SELF' => -11,
			'USE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			"while" => -11,
			'LITERAL_NUMBER' => -11,
			"use constant" => -11,
			"\@{" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"## no critic qw(" => 8,
			'MY' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"for" => -11,
			'LPAREN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'WORD_UPPERCASE' => -11,
			"foreach" => -11
		},
		GOTOS => {
			'Critic' => 51,
			'STAR-5' => 52
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 54,
			";" => 53
		}
	},
	{#State 42
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 58
		}
	},
	{#State 44
		DEFAULT => -33
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 61,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			'USE' => 34
		},
		GOTOS => {
			'Include' => 62
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		DEFAULT => -35
	},
	{#State 50
		ACTIONS => {
			"our" => 64
		}
	},
	{#State 51
		DEFAULT => -8
	},
	{#State 52
		ACTIONS => {
			"foreach" => -13,
			"our" => -13,
			'WORD_UPPERCASE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD_SCOPED' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LPAREN' => -13,
			"for" => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP01_NAMED_VOID' => -13,
			'MY' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"undef" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			"\@{" => -13,
			"while" => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'SELF' => -13,
			'USE' => 34,
			'LITERAL_STRING' => -13,
			'OP01_CLOSE' => -13,
			'LBRACKET' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"if" => -13,
			'LBRACE' => -13,
			'WORD' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13
		},
		GOTOS => {
			'Include' => 65,
			'STAR-6' => 66
		}
	},
	{#State 53
		DEFAULT => -41
	},
	{#State 54
		ACTIONS => {
			";" => 67
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 56
		DEFAULT => -222
	},
	{#State 57
		DEFAULT => -221
	},
	{#State 58
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 59
		DEFAULT => -220
	},
	{#State 60
		DEFAULT => -32
	},
	{#State 61
		ACTIONS => {
			";" => 70
		}
	},
	{#State 62
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 71
		}
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 72
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'VARIABLE_SYMBOL' => -15,
			'WORD' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'OP01_CLOSE' => -15,
			"if" => -15,
			'LBRACKET' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACE' => -15,
			'SELF' => -15,
			'LITERAL_STRING' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"use constant" => 42,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			"while" => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"undef" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED_VOID' => -15,
			"%{" => -15,
			'MY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for" => -15,
			'LPAREN' => -15,
			"foreach" => -15,
			'WORD_UPPERCASE' => -15,
			"our" => -15,
			'WORD_SCOPED' => -15,
			'OP10_NAMED_UNARY' => -15
		},
		GOTOS => {
			'STAR-7' => 73,
			'Constant' => 74
		}
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		ACTIONS => {
			'MY' => 75
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 70
		DEFAULT => -34
	},
	{#State 71
		ACTIONS => {
			"our hashref \$properties" => -56,
			"## no critic qw(" => 8,
			'USE' => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 79,
			'Critic' => 78
		}
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			"for" => -151,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			"foreach" => -151,
			'WORD_UPPERCASE' => 115,
			"our" => 43,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP01_NAMED_VOID_LPAREN' => 121,
			"%{" => 124,
			'MY' => 122,
			'OP01_NAMED_VOID_SCOLON' => 127,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 129,
			'OP01_NAMED_VOID' => 132,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			"while" => -151,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'OP01_NAMED' => 94,
			'OP01_PRINT' => 95,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			"if" => 104,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Subroutine' => 98,
			'OPTIONAL-37' => 123,
			'Variable' => 131,
			'Operator' => 100,
			'VariableModification' => 128,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 114,
			'OperatorVoid' => 86,
			'Operation' => 112,
			'SubExpression' => 113,
			'HashReference' => 111,
			'Expression' => 85,
			'PLUS-8' => 93,
			'WordScoped' => 90,
			'Conditional' => 89,
			'VariableDeclaration' => 107,
			'LoopLabel' => 108,
			'PAREN-36' => 106,
			'Statement' => 80,
			'Literal' => 83,
			'ArrayReference' => 82
		}
	},
	{#State 74
		DEFAULT => -12
	},
	{#State 75
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 133
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 134
		}
	},
	{#State 77
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"undef" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP01_NAMED_VOID' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP01_OPEN' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'LPAREN_MY' => 135,
			"%{" => -45,
			'MY' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'LPAREN' => -45,
			"for" => -45,
			'WORD_UPPERCASE' => -45,
			"foreach" => -45,
			'WORD_SCOPED' => -45,
			'OP10_NAMED_UNARY' => -45,
			'VARIABLE_SYMBOL' => -45,
			'WORD' => -45,
			'OP01_PRINT' => -45,
			'OP01_NAMED' => -45,
			"}" => -45,
			"if" => -45,
			'OP03_MATH_INC_DEC' => -45,
			'LBRACKET' => -45,
			'OP01_CLOSE' => -45,
			'LBRACE' => -45,
			'SELF' => -45,
			'LITERAL_STRING' => -45,
			"\@{" => -45,
			'LITERAL_NUMBER' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			"while" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 137,
			'SubroutineArguments' => 136
		}
	},
	{#State 78
		DEFAULT => -53
	},
	{#State 79
		ACTIONS => {
			"our hashref \$properties" => -58,
			"use constant" => -58,
			'USE' => 34
		},
		GOTOS => {
			'Include' => 138,
			'STAR-23' => 139
		}
	},
	{#State 80
		DEFAULT => -81
	},
	{#State 81
		DEFAULT => -235
	},
	{#State 82
		DEFAULT => -139
	},
	{#State 83
		DEFAULT => -137
	},
	{#State 84
		DEFAULT => -233
	},
	{#State 85
		ACTIONS => {
			'OP23_LOGICAL_AND' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP08_STRING_CAT' => -135,
			";" => 140,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP04_MATH_POW' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP18_TERNARY' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP06_REGEX_BIND' => -135
		}
	},
	{#State 86
		DEFAULT => -154
	},
	{#State 87
		ACTIONS => {
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			"%{" => 124,
			'LBRACE' => 99,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 141,
			'HashReference' => 111,
			'Expression' => 144,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100
		}
	},
	{#State 88
		DEFAULT => -131
	},
	{#State 89
		DEFAULT => -152
	},
	{#State 90
		ACTIONS => {
			'LPAREN' => 146,
			'OP02_METHOD_THINARROW_NEW' => 147
		}
	},
	{#State 91
		DEFAULT => -234
	},
	{#State 92
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 84,
			'LBRACKET' => -199,
			'MY' => 151
		},
		GOTOS => {
			'OPTIONAL-47' => 148,
			'Variable' => 150,
			'VariableSymbolOrSelf' => 114,
			'TypeInner' => 149
		}
	},
	{#State 93
		ACTIONS => {
			'OP01_PRINT' => 95,
			'OP01_NAMED' => 94,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'LBRACE' => 99,
			"if" => 104,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'LITERAL_STRING' => 81,
			'' => -18,
			'SELF' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			"while" => -151,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_LPAREN' => 121,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP01_NAMED_VOID_SCOLON' => 127,
			'OP19_LOOP_CONTROL' => 126,
			"%{" => 124,
			'MY' => 122,
			'OP01_NAMED_VOID' => 132,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 129,
			"for" => -151,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 115,
			"foreach" => -151
		},
		GOTOS => {
			'HashDereference' => 96,
			'Variable' => 131,
			'Operator' => 100,
			'VariableModification' => 128,
			'ArrayDereference' => 125,
			'OPTIONAL-37' => 123,
			'ArrayReference' => 82,
			'Literal' => 83,
			'PAREN-36' => 106,
			'LoopLabel' => 108,
			'VariableDeclaration' => 107,
			'Statement' => 80,
			'Conditional' => 89,
			'WordScoped' => 90,
			'Operation' => 152,
			'SubExpression' => 113,
			'VariableSymbolOrSelf' => 114,
			'OperatorVoid' => 86,
			'Expression' => 85,
			'HashReference' => 111
		}
	},
	{#State 94
		ACTIONS => {
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'MY' => 151,
			"%{" => 124,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'ARGV' => 153,
			'OP01_QW' => 156,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 157,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 155,
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'TypeInner' => 154
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => -114,
			'STDOUT_STDERR' => 158,
			'FHREF_SYMBOL_BRACES' => 160,
			'VARIABLE_SYMBOL' => -114,
			"undef" => -114,
			'OP05_MATH_NEG_LPAREN' => -114,
			'OP01_QW' => -114,
			'ARGV' => -114,
			'OP01_NAMED' => -114,
			'OP22_LOGICAL_NEG' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'LBRACKET' => -114,
			'OP01_CLOSE' => -114,
			'OP01_OPEN' => -114,
			'LBRACE' => -114,
			'MY' => -114,
			"%{" => -114,
			'SELF' => -114,
			'OP05_LOGICAL_NEG' => -114,
			'LPAREN' => -114,
			'LITERAL_STRING' => -114,
			'LITERAL_NUMBER' => -114,
			"\@{" => -114,
			'WORD_UPPERCASE' => -114,
			'CONSTANT_CALL_SCOPED' => -114,
			'OP05_BITWISE_NEG_LPAREN' => -114,
			'OP10_NAMED_UNARY' => -114,
			'WORD_SCOPED' => -114
		},
		GOTOS => {
			'PAREN-31' => 159,
			'OPTIONAL-32' => 161
		}
	},
	{#State 96
		DEFAULT => -142
	},
	{#State 97
		DEFAULT => -232
	},
	{#State 98
		DEFAULT => -14
	},
	{#State 99
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP23_LOGICAL_AND' => 175,
			'SELF' => 84,
			'OP08_MATH_ADD_SUB' => 173,
			'OP10_NAMED_UNARY' => 186,
			'OP11_COMPARE_LT_GT' => 172,
			'LITERAL_NUMBER' => 91,
			'OP01_PRINT' => 167,
			'OP07_STRING_REPEAT' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'OP22_LOGICAL_NEG' => 185,
			'OP01_NAMED' => 169,
			'ENV' => 170,
			"}" => 171,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP19_LOOP_CONTROL' => 181,
			"%{" => 124,
			'OP01_NAMED_VOID' => 178,
			'OP01_CLOSE' => 162,
			'OP01_OPEN' => 180
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 183,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 176,
			'HashDereference' => 166,
			'HashEntry' => 163,
			'Variable' => 179,
			'OpStringOrWord' => 182
		}
	},
	{#State 100
		DEFAULT => -129
	},
	{#State 101
		ACTIONS => {
			'FHREF_SYMBOL' => 187
		}
	},
	{#State 102
		ACTIONS => {
			'SELF' => 84,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 188
		}
	},
	{#State 103
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"]" => -196,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'ARGV' => 153,
			'OP01_QW' => 156,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120
		},
		GOTOS => {
			'ListElements' => 191,
			'TypeInner' => 154,
			'OPTIONAL-46' => 190,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 192,
			'Expression' => 144,
			'HashReference' => 111,
			'ListElement' => 189,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 193
		}
	},
	{#State 105
		ACTIONS => {
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"%{" => 124,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 196,
			'OP01_PRINT' => 195,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 194,
			'Expression' => 144,
			'HashReference' => 111,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 106
		DEFAULT => -150
	},
	{#State 107
		DEFAULT => -155
	},
	{#State 108
		ACTIONS => {
			'COLON' => 197
		}
	},
	{#State 109
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 198,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125
		}
	},
	{#State 110
		ACTIONS => {
			'OP04_MATH_POW' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP01_NAMED' => 145,
			'VARIABLE_SYMBOL' => 97,
			'OP08_STRING_CAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'WORD' => 28,
			'OP14_BITWISE_OR_XOR' => -100,
			'LBRACE' => 99,
			'OP06_REGEX_BIND' => -100,
			"]" => -100,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'LITERAL_STRING' => 81,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'SELF' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP08_MATH_ADD_SUB' => -100,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'OP11_COMPARE_LT_GT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP22_LOGICAL_NEG' => 116,
			";" => -100,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP21_LIST_COMMA' => -100,
			'OP15_LOGICAL_AND' => -100,
			"%{" => 124,
			'OP01_OPEN' => 129,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'OP16_LOGICAL_OR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 142,
			")" => -100
		},
		GOTOS => {
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83,
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 199,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143
		}
	},
	{#State 111
		DEFAULT => -141
	},
	{#State 112
		DEFAULT => -17
	},
	{#State 113
		ACTIONS => {
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202
		}
	},
	{#State 114
		DEFAULT => -176,
		GOTOS => {
			'STAR-43' => 217
		}
	},
	{#State 115
		ACTIONS => {
			'COLON' => -219,
			'LPAREN' => 218
		}
	},
	{#State 116
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 219,
			'Expression' => 144,
			'HashReference' => 111,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100
		}
	},
	{#State 117
		DEFAULT => -123
	},
	{#State 118
		DEFAULT => -80
	},
	{#State 119
		ACTIONS => {
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			"%{" => 124,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 220,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 111,
			'Expression' => 144
		}
	},
	{#State 120
		DEFAULT => -136
	},
	{#State 121
		ACTIONS => {
			'MY' => 151,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP01_QW' => 156,
			'ARGV' => 153,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			")" => -116,
			'WORD_UPPERCASE' => 142,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84
		},
		GOTOS => {
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 189,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'OPTIONAL-33' => 222,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 192,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'ListElements' => 221,
			'TypeInner' => 154
		}
	},
	{#State 122
		ACTIONS => {
			'WORD' => 59,
			'TYPE_FHREF' => 224,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 223
		}
	},
	{#State 123
		ACTIONS => {
			"foreach" => 227,
			"while" => 230,
			"for" => 225
		},
		GOTOS => {
			'Loop' => 229,
			'LoopForEach' => 231,
			'LoopWhile' => 226,
			'LoopFor' => 228
		}
	},
	{#State 124
		ACTIONS => {
			'LBRACE' => -214,
			'MY' => 151,
			'SELF' => 84,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Variable' => 232,
			'OPTIONAL-51' => 233,
			'TypeInner' => 234,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 125
		DEFAULT => -140
	},
	{#State 126
		ACTIONS => {
			'WORD_UPPERCASE' => 235
		},
		GOTOS => {
			'LoopLabel' => 236
		}
	},
	{#State 127
		DEFAULT => -119
	},
	{#State 128
		ACTIONS => {
			";" => 237
		}
	},
	{#State 129
		ACTIONS => {
			'MY' => 238
		}
	},
	{#State 130
		DEFAULT => -79
	},
	{#State 131
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 241,
			'OP09_BITWISE_SHIFT' => -138,
			")" => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP16_LOGICAL_OR' => -138,
			'OP19_VARIABLE_ASSIGN_BY' => 242,
			'OP12_COMPARE_EQ_NE' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP03_MATH_INC_DEC' => 239,
			'OP06_REGEX_BIND' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP19_VARIABLE_ASSIGN' => 240,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP08_STRING_CAT' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP18_TERNARY' => -138,
			'OP07_STRING_REPEAT' => -138,
			'OP04_MATH_POW' => -138
		}
	},
	{#State 132
		ACTIONS => {
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'ARGV' => 153,
			'OP01_QW' => 156,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 151,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'Expression' => 144,
			'HashReference' => 111,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 192,
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 189,
			'Variable' => 143,
			'ListElements' => 243,
			'TypeInner' => 154,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 133
		ACTIONS => {
			"\$TYPED_" => 244
		}
	},
	{#State 134
		ACTIONS => {
			";" => 245
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 59,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 246
		}
	},
	{#State 136
		DEFAULT => -44
	},
	{#State 137
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 247
		}
	},
	{#State 138
		DEFAULT => -55
	},
	{#State 139
		ACTIONS => {
			"use constant" => 42,
			"our hashref \$properties" => 249
		},
		GOTOS => {
			'Constant' => 250,
			'Properties' => 248
		}
	},
	{#State 140
		DEFAULT => -78
	},
	{#State 141
		ACTIONS => {
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP16_LOGICAL_OR' => 214,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP11_COMPARE_LT_GT' => 210,
			")" => 251,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207
		}
	},
	{#State 142
		ACTIONS => {
			'LPAREN' => 218
		}
	},
	{#State 143
		ACTIONS => {
			'OP21_LIST_COMMA' => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP08_STRING_CAT' => -138,
			";" => -138,
			"}" => -138,
			'OP18_TERNARY' => -138,
			'OP07_STRING_REPEAT' => -138,
			'OP04_MATH_POW' => -138,
			'OP03_MATH_INC_DEC' => 239,
			"]" => -138,
			'OP06_REGEX_BIND' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP12_COMPARE_EQ_NE' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP02_METHOD_THINARROW' => 241,
			'OP11_COMPARE_LT_GT' => -138,
			")" => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP16_LOGICAL_OR' => -138
		}
	},
	{#State 144
		DEFAULT => -135
	},
	{#State 145
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120
		},
		GOTOS => {
			'SubExpression' => 252,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 111,
			'Expression' => 144,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 146
		ACTIONS => {
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP01_QW' => 156,
			'ARGV' => 153,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			")" => -126,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ListElement' => 189,
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 192,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83,
			'OPTIONAL-34' => 253,
			'TypeInner' => 154,
			'ListElements' => 254
		}
	},
	{#State 147
		ACTIONS => {
			")" => 255
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACKET' => 103
		},
		GOTOS => {
			'ArrayReference' => 256
		}
	},
	{#State 149
		DEFAULT => -198
	},
	{#State 150
		ACTIONS => {
			"}" => 257
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 258
		}
	},
	{#State 152
		DEFAULT => -16
	},
	{#State 153
		DEFAULT => -194
	},
	{#State 154
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'LBRACE' => 99,
			"%{" => 124,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129
		},
		GOTOS => {
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 259,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 155
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			")" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP21_LIST_COMMA' => -191,
			'OP14_BITWISE_OR_XOR' => -83,
			";" => -83,
			'OP08_STRING_CAT' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP18_TERNARY' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP04_MATH_POW' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP15_LOGICAL_AND' => -83
		}
	},
	{#State 156
		DEFAULT => -193
	},
	{#State 157
		ACTIONS => {
			'OP21_LIST_COMMA' => 260
		}
	},
	{#State 158
		DEFAULT => -112
	},
	{#State 159
		DEFAULT => -113
	},
	{#State 160
		ACTIONS => {
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP01_QW' => 156,
			'ARGV' => 153,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 192,
			'HashReference' => 111,
			'Expression' => 144,
			'ListElement' => 189,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElements' => 261,
			'TypeInner' => 154,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 161
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'MY' => 151,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'ARGV' => 153,
			'OP01_QW' => 156,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'ListElements' => 262,
			'TypeInner' => 154,
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 189,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 192
		}
	},
	{#State 162
		DEFAULT => -254
	},
	{#State 163
		DEFAULT => -210,
		GOTOS => {
			'STAR-50' => 263
		}
	},
	{#State 164
		DEFAULT => -258
	},
	{#State 165
		DEFAULT => -251
	},
	{#State 166
		DEFAULT => -205
	},
	{#State 167
		DEFAULT => -257
	},
	{#State 168
		DEFAULT => -252
	},
	{#State 169
		DEFAULT => -253
	},
	{#State 170
		DEFAULT => -206
	},
	{#State 171
		DEFAULT => -212
	},
	{#State 172
		DEFAULT => -248
	},
	{#State 173
		DEFAULT => -250
	},
	{#State 174
		DEFAULT => -247
	},
	{#State 175
		DEFAULT => -243
	},
	{#State 176
		DEFAULT => -230
	},
	{#State 177
		DEFAULT => -242
	},
	{#State 178
		DEFAULT => -256
	},
	{#State 179
		DEFAULT => -229
	},
	{#State 180
		DEFAULT => -255
	},
	{#State 181
		DEFAULT => -246
	},
	{#State 182
		DEFAULT => -231
	},
	{#State 183
		ACTIONS => {
			'OP20_HASH_FATARROW' => 264
		}
	},
	{#State 184
		DEFAULT => -245
	},
	{#State 185
		DEFAULT => -244
	},
	{#State 186
		DEFAULT => -249
	},
	{#State 187
		DEFAULT => -86
	},
	{#State 188
		DEFAULT => -87
	},
	{#State 189
		DEFAULT => -189,
		GOTOS => {
			'STAR-45' => 265
		}
	},
	{#State 190
		ACTIONS => {
			"]" => 266
		}
	},
	{#State 191
		DEFAULT => -195
	},
	{#State 192
		ACTIONS => {
			")" => -191,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			"]" => -191,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			";" => -191,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -191,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204
		}
	},
	{#State 193
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"%{" => 124,
			'LBRACE' => 99
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 267,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 194
		ACTIONS => {
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			")" => 268,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202
		}
	},
	{#State 195
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 269
		}
	},
	{#State 196
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			"%{" => 124,
			'MY' => 151,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'ARGV' => 153,
			'OP01_QW' => 156,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28
		},
		GOTOS => {
			'ListElement' => 270,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 155,
			'HashReference' => 111,
			'Expression' => 144,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'TypeInner' => 154
		}
	},
	{#State 197
		DEFAULT => -149
	},
	{#State 198
		ACTIONS => {
			'OP23_LOGICAL_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP08_STRING_CAT' => -91,
			";" => -91,
			"}" => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP18_TERNARY' => -91,
			'OP04_MATH_POW' => 203,
			"]" => -91,
			'OP06_REGEX_BIND' => -91,
			'OP15_LOGICAL_AND' => -91
		}
	},
	{#State 199
		ACTIONS => {
			'OP23_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => -99,
			")" => -99,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			";" => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			"]" => -99,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -99
		}
	},
	{#State 200
		ACTIONS => {
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'SubExpression' => 271,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Expression' => 144,
			'HashReference' => 111,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90
		}
	},
	{#State 201
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'HashReference' => 111,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 272,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143
		}
	},
	{#State 202
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105
		},
		GOTOS => {
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 273,
			'Expression' => 144,
			'HashReference' => 111,
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82
		}
	},
	{#State 203
		ACTIONS => {
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102
		},
		GOTOS => {
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 274,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Expression' => 144,
			'HashReference' => 111,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83
		}
	},
	{#State 204
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'SELF' => 84,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Literal' => 275,
			'Variable' => 277,
			'VariableOrLiteral' => 276
		}
	},
	{#State 205
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Expression' => 144,
			'HashReference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 278,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143
		}
	},
	{#State 206
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 279
		}
	},
	{#State 207
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129
		},
		GOTOS => {
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 280,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 208
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			"%{" => 124,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'HashReference' => 111,
			'Expression' => 144,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 281,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 209
		ACTIONS => {
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84
		},
		GOTOS => {
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 282,
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82
		}
	},
	{#State 210
		ACTIONS => {
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			"%{" => 124,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 283,
			'HashReference' => 111,
			'Expression' => 144,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82
		}
	},
	{#State 211
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"%{" => 124,
			'LBRACE' => 99,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 284,
			'Expression' => 144,
			'HashReference' => 111
		}
	},
	{#State 212
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124
		},
		GOTOS => {
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83,
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 285,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143
		}
	},
	{#State 213
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'HashReference' => 111,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 286,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143
		}
	},
	{#State 214
		ACTIONS => {
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 287,
			'Expression' => 144,
			'HashReference' => 111
		}
	},
	{#State 215
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 288,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 289,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143
		}
	},
	{#State 217
		ACTIONS => {
			"]" => -177,
			'OP03_MATH_INC_DEC' => -177,
			'OP06_REGEX_BIND' => -177,
			'OP15_LOGICAL_AND' => -177,
			'OP19_VARIABLE_ASSIGN' => -177,
			'OP21_LIST_COMMA' => -177,
			'OP14_BITWISE_OR_XOR' => -177,
			";" => -177,
			'OP08_STRING_CAT' => -177,
			'OP07_MATH_MULT_DIV_MOD' => -177,
			'OP20_HASH_FATARROW' => -177,
			'OP18_TERNARY' => -177,
			'OP07_STRING_REPEAT' => -177,
			"}" => -177,
			'OP04_MATH_POW' => -177,
			'OP02_METHOD_THINARROW' => -177,
			'OP02_HASH_THINARROW' => 292,
			'OP09_BITWISE_SHIFT' => -177,
			")" => -177,
			'OP11_COMPARE_LT_GT' => -177,
			'OP17_LIST_RANGE' => -177,
			'OP08_MATH_ADD_SUB' => -177,
			'OP13_BITWISE_AND' => -177,
			'COLON' => -177,
			'OP02_ARRAY_THINARROW' => 291,
			'OP16_LOGICAL_OR' => -177,
			'OP19_VARIABLE_ASSIGN_BY' => -177,
			'OP12_COMPARE_EQ_NE' => -177,
			'OP23_LOGICAL_AND' => -177,
			'OP24_LOGICAL_OR_XOR' => -177
		},
		GOTOS => {
			'VariableRetrieval' => 290
		}
	},
	{#State 218
		ACTIONS => {
			")" => 293
		}
	},
	{#State 219
		ACTIONS => {
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			"}" => -109,
			";" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP21_LIST_COMMA' => -109,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			"]" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			")" => -109,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211
		}
	},
	{#State 220
		ACTIONS => {
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			")" => 294,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211
		}
	},
	{#State 221
		DEFAULT => -115
	},
	{#State 222
		ACTIONS => {
			")" => 295
		}
	},
	{#State 223
		ACTIONS => {
			'VARIABLE_SYMBOL' => 296
		}
	},
	{#State 224
		ACTIONS => {
			'FHREF_SYMBOL' => 297
		}
	},
	{#State 225
		ACTIONS => {
			'MY' => 299,
			'LPAREN_MY' => 298
		}
	},
	{#State 226
		DEFAULT => -166
	},
	{#State 227
		ACTIONS => {
			'MY' => 300
		}
	},
	{#State 228
		DEFAULT => -164
	},
	{#State 229
		DEFAULT => -153
	},
	{#State 230
		ACTIONS => {
			'LPAREN' => 302,
			'LPAREN_MY' => 301
		}
	},
	{#State 231
		DEFAULT => -165
	},
	{#State 232
		ACTIONS => {
			"}" => 303
		}
	},
	{#State 233
		ACTIONS => {
			'LBRACE' => 99
		},
		GOTOS => {
			'HashReference' => 304
		}
	},
	{#State 234
		DEFAULT => -213
	},
	{#State 235
		DEFAULT => -219
	},
	{#State 236
		ACTIONS => {
			";" => 305
		}
	},
	{#State 237
		DEFAULT => -156
	},
	{#State 238
		ACTIONS => {
			'TYPE_FHREF' => 306
		}
	},
	{#State 239
		DEFAULT => -88
	},
	{#State 240
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'FHREF_SYMBOL_IN' => 310,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'STDIN' => 309,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Operator' => 100,
			'SubExpressionOrInput' => 307,
			'WordScoped' => 90,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 308,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83
		}
	},
	{#State 241
		ACTIONS => {
			'LPAREN' => 311
		}
	},
	{#State 242
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			"%{" => 124,
			'LBRACE' => 99,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 312,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83
		}
	},
	{#State 243
		ACTIONS => {
			";" => 313
		}
	},
	{#State 244
		ACTIONS => {
			'WORD_UPPERCASE' => 314
		}
	},
	{#State 245
		DEFAULT => -43
	},
	{#State 246
		ACTIONS => {
			'VARIABLE_SYMBOL' => 315
		}
	},
	{#State 247
		ACTIONS => {
			"}" => 317,
			'OP01_NAMED' => 94,
			'OP01_PRINT' => 95,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"if" => 104,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			"while" => -151,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP01_NAMED_VOID_LPAREN' => 121,
			'MY' => 122,
			"%{" => 124,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_VOID_SCOLON' => 127,
			'OP01_OPEN' => 129,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_NAMED_VOID' => 132,
			"for" => -151,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			"foreach" => -151,
			'WORD_UPPERCASE' => 115
		},
		GOTOS => {
			'Statement' => 80,
			'LoopLabel' => 108,
			'VariableDeclaration' => 107,
			'PAREN-36' => 106,
			'Literal' => 83,
			'ArrayReference' => 82,
			'Expression' => 85,
			'HashReference' => 111,
			'VariableSymbolOrSelf' => 114,
			'OperatorVoid' => 86,
			'Operation' => 316,
			'SubExpression' => 113,
			'WordScoped' => 90,
			'Conditional' => 89,
			'HashDereference' => 96,
			'OPTIONAL-37' => 123,
			'ArrayDereference' => 125,
			'VariableModification' => 128,
			'Operator' => 100,
			'Variable' => 131
		}
	},
	{#State 248
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 318
		}
	},
	{#State 249
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 319
		}
	},
	{#State 250
		DEFAULT => -57
	},
	{#State 251
		DEFAULT => -90
	},
	{#State 252
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			")" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP18_TERNARY' => -83,
			'OP07_STRING_REPEAT' => -83,
			"}" => -83,
			'OP04_MATH_POW' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP21_LIST_COMMA' => -83,
			";" => -83,
			'OP08_STRING_CAT' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP15_LOGICAL_AND' => -83,
			"]" => -83
		}
	},
	{#State 253
		ACTIONS => {
			")" => 320
		}
	},
	{#State 254
		DEFAULT => -125
	},
	{#State 255
		DEFAULT => -134
	},
	{#State 256
		ACTIONS => {
			"}" => 321
		}
	},
	{#State 257
		DEFAULT => -200
	},
	{#State 258
		ACTIONS => {
			"\$TYPED_" => 322
		}
	},
	{#State 259
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			")" => -192,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			";" => -192,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP21_LIST_COMMA' => -192,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			"]" => -192
		}
	},
	{#State 260
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP01_QW' => 156,
			'ARGV' => 153,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124
		},
		GOTOS => {
			'TypeInner' => 154,
			'ListElements' => 323,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83,
			'SubExpression' => 192,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111,
			'Variable' => 143,
			'ListElement' => 189,
			'Operator' => 100,
			'WordScoped' => 90
		}
	},
	{#State 261
		ACTIONS => {
			";" => 324
		}
	},
	{#State 262
		ACTIONS => {
			";" => 325
		}
	},
	{#State 263
		ACTIONS => {
			'OP21_LIST_COMMA' => 327,
			"}" => 326
		},
		GOTOS => {
			'PAREN-49' => 328
		}
	},
	{#State 264
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -203,
			"\@{" => -203,
			'WORD_UPPERCASE' => -203,
			'LITERAL_NUMBER' => -203,
			'OP10_NAMED_UNARY' => -203,
			'WORD_SCOPED' => -203,
			'OP05_BITWISE_NEG_LPAREN' => -203,
			'OP05_LOGICAL_NEG' => -203,
			'SELF' => -203,
			'LITERAL_STRING' => -203,
			'LPAREN' => -203,
			'OP01_CLOSE' => -203,
			'OP01_OPEN' => -203,
			'LBRACKET' => -203,
			'OP03_MATH_INC_DEC' => -203,
			"%{" => -203,
			'MY' => 151,
			'LBRACE' => -203,
			"undef" => -203,
			'OP05_MATH_NEG_LPAREN' => -203,
			'VARIABLE_SYMBOL' => -203,
			'WORD' => -203,
			'OP01_NAMED' => -203,
			'OP22_LOGICAL_NEG' => -203
		},
		GOTOS => {
			'TypeInner' => 330,
			'OPTIONAL-48' => 329
		}
	},
	{#State 265
		ACTIONS => {
			"]" => -190,
			")" => -190,
			";" => -190,
			'OP21_LIST_COMMA' => 332
		},
		GOTOS => {
			'PAREN-44' => 331
		}
	},
	{#State 266
		DEFAULT => -197
	},
	{#State 267
		ACTIONS => {
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP11_COMPARE_LT_GT' => 210,
			")" => 333,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 268
		DEFAULT => -143
	},
	{#State 269
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'MY' => 151,
			"%{" => 124,
			'LBRACE' => 99,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 156,
			'ARGV' => 153
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'ListElements' => 334,
			'TypeInner' => 154,
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 189,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 192
		}
	},
	{#State 270
		ACTIONS => {
			'OP21_LIST_COMMA' => 335
		}
	},
	{#State 271
		ACTIONS => {
			"]" => -95,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP08_STRING_CAT' => -95,
			";" => -95,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			'OP09_BITWISE_SHIFT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP24_LOGICAL_OR_XOR' => -95
		}
	},
	{#State 272
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			'OP06_REGEX_BIND' => 206,
			"]" => -97,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => 205,
			"}" => -97,
			";" => -97,
			'OP08_STRING_CAT' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP21_LIST_COMMA' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => -97,
			'OP13_BITWISE_AND' => -97,
			")" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP23_LOGICAL_AND' => -97
		}
	},
	{#State 273
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			'OP06_REGEX_BIND' => 206,
			"]" => -104,
			'OP04_MATH_POW' => 203,
			"}" => -104,
			'OP18_TERNARY' => -104,
			'OP07_STRING_REPEAT' => 205,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			";" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => -104,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP12_COMPARE_EQ_NE' => 207
		}
	},
	{#State 274
		ACTIONS => {
			'OP23_LOGICAL_AND' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			")" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP08_STRING_CAT' => -89,
			";" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 203,
			"}" => -89,
			'OP18_TERNARY' => -89,
			'OP07_STRING_REPEAT' => -89,
			"]" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP06_REGEX_BIND' => -89
		}
	},
	{#State 275
		DEFAULT => -228
	},
	{#State 276
		ACTIONS => {
			'COLON' => 336
		}
	},
	{#State 277
		DEFAULT => -227
	},
	{#State 278
		ACTIONS => {
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			"]" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_BIND' => 206,
			";" => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => -94,
			'OP07_STRING_REPEAT' => -94,
			"}" => -94
		}
	},
	{#State 279
		DEFAULT => -93
	},
	{#State 280
		ACTIONS => {
			")" => -102,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => -102,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			"]" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP06_REGEX_BIND' => 206,
			";" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => -102,
			"}" => -102
		}
	},
	{#State 281
		ACTIONS => {
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			"]" => -110,
			'OP04_MATH_POW' => 203,
			"}" => -110,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			";" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -110,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP12_COMPARE_EQ_NE' => 207
		}
	},
	{#State 282
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -111,
			'OP04_MATH_POW' => 203,
			"}" => -111,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			"]" => -111,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -111,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216
		}
	},
	{#State 283
		ACTIONS => {
			'OP23_LOGICAL_AND' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -101,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			";" => -101,
			"}" => -101,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 203,
			"]" => -101,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -101
		}
	},
	{#State 284
		ACTIONS => {
			'OP18_TERNARY' => -98,
			'OP07_STRING_REPEAT' => 205,
			"}" => -98,
			'OP04_MATH_POW' => 203,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			";" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -98,
			"]" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP08_MATH_ADD_SUB' => 212,
			'OP16_LOGICAL_OR' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			")" => -98,
			'OP11_COMPARE_LT_GT' => -98
		}
	},
	{#State 285
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -96,
			")" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			"]" => -96,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => -96,
			'OP18_TERNARY' => -96,
			'OP07_STRING_REPEAT' => 205,
			"}" => -96,
			'OP04_MATH_POW' => 203
		}
	},
	{#State 286
		ACTIONS => {
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 203,
			"}" => -105,
			'OP18_TERNARY' => -105,
			'OP07_STRING_REPEAT' => 205,
			"]" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_BIND' => 206
		}
	},
	{#State 287
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 211,
			")" => -106,
			'OP11_COMPARE_LT_GT' => 210,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			"]" => -106,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => 202,
			";" => -106,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => -106,
			"}" => -106,
			'OP04_MATH_POW' => 203
		}
	},
	{#State 288
		ACTIONS => {
			'OP21_LIST_COMMA' => -107,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			";" => -107,
			"}" => -107,
			'OP18_TERNARY' => -107,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			"]" => -107,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP23_LOGICAL_AND' => -107,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -107,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP16_LOGICAL_OR' => 214
		}
	},
	{#State 289
		ACTIONS => {
			'OP17_LIST_RANGE' => -103,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => -103,
			"]" => -103,
			"}" => -103,
			'OP18_TERNARY' => -103,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			";" => -103
		}
	},
	{#State 290
		DEFAULT => -175
	},
	{#State 291
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			"%{" => 124,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 337,
			'Expression' => 144,
			'HashReference' => 111
		}
	},
	{#State 292
		ACTIONS => {
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 339,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 338,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 293
		DEFAULT => -130
	},
	{#State 294
		DEFAULT => -92
	},
	{#State 295
		ACTIONS => {
			";" => 340
		}
	},
	{#State 296
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343,
			'OP02_ARRAY_THINARROW' => 342,
			";" => 341
		}
	},
	{#State 297
		ACTIONS => {
			";" => 344
		}
	},
	{#State 298
		ACTIONS => {
			'TYPE_INTEGER' => 345
		}
	},
	{#State 299
		ACTIONS => {
			'TYPE_INTEGER' => 346
		}
	},
	{#State 300
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 347
		}
	},
	{#State 301
		ACTIONS => {
			'WORD' => 59,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 348
		}
	},
	{#State 302
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			"%{" => 124,
			'LBRACE' => 99,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 349,
			'HashReference' => 111,
			'Expression' => 144,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100
		}
	},
	{#State 303
		DEFAULT => -215
	},
	{#State 304
		ACTIONS => {
			"}" => 350
		}
	},
	{#State 305
		DEFAULT => -124
	},
	{#State 306
		ACTIONS => {
			'FHREF_SYMBOL' => 351
		}
	},
	{#State 307
		DEFAULT => -185
	},
	{#State 308
		ACTIONS => {
			")" => -144,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			";" => -144,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204
		}
	},
	{#State 309
		DEFAULT => -146
	},
	{#State 310
		DEFAULT => -145
	},
	{#State 311
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP01_QW' => 156,
			'ARGV' => 153,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 151,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			")" => -128,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 192,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'WordScoped' => 90,
			'OPTIONAL-35' => 352,
			'Variable' => 143,
			'ListElement' => 189,
			'TypeInner' => 154,
			'ListElements' => 353,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 312
		ACTIONS => {
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			";" => -186,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			")" => -186,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 313
		DEFAULT => -121
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 354
		}
	},
	{#State 315
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 355
		}
	},
	{#State 316
		DEFAULT => -46
	},
	{#State 317
		ACTIONS => {
			";" => 356
		}
	},
	{#State 318
		ACTIONS => {
			'LITERAL_NUMBER' => 357,
			"our" => 360
		},
		GOTOS => {
			'Method' => 358,
			'SubroutineOrMethod' => 361,
			'Subroutine' => 359
		}
	},
	{#State 319
		ACTIONS => {
			'LBRACE' => 362
		}
	},
	{#State 320
		DEFAULT => -132
	},
	{#State 321
		DEFAULT => -201
	},
	{#State 322
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP23_LOGICAL_AND' => 175,
			'OP08_MATH_ADD_SUB' => 173,
			'OP10_NAMED_UNARY' => 186,
			'OP11_COMPARE_LT_GT' => 172,
			'OP01_PRINT' => 167,
			'OP07_STRING_REPEAT' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'OP22_LOGICAL_NEG' => 185,
			'OP01_NAMED' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'WORD' => 164,
			'OP19_LOOP_CONTROL' => 181,
			'OP01_NAMED_VOID' => 178,
			'OP01_OPEN' => 180,
			'OP01_CLOSE' => 162
		},
		GOTOS => {
			'OpStringOrWord' => 363
		}
	},
	{#State 323
		ACTIONS => {
			";" => 364
		}
	},
	{#State 324
		DEFAULT => -118
	},
	{#State 325
		DEFAULT => -117
	},
	{#State 326
		DEFAULT => -211
	},
	{#State 327
		ACTIONS => {
			'WORD' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'VARIABLE_SYMBOL' => 97,
			'OP01_NAMED' => 169,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'ENV' => 170,
			'OP22_LOGICAL_NEG' => 185,
			'OP07_STRING_REPEAT' => 168,
			'OP01_PRINT' => 167,
			'OP01_CLOSE' => 162,
			'OP01_OPEN' => 180,
			'OP01_NAMED_VOID' => 178,
			"%{" => 124,
			'OP19_LOOP_CONTROL' => 181,
			'OP23_LOGICAL_AND' => 175,
			'SELF' => 84,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP24_LOGICAL_OR_XOR' => 177,
			'LITERAL_STRING' => 81,
			'OP11_COMPARE_LT_GT' => 172,
			'LITERAL_NUMBER' => 91,
			'OP10_NAMED_UNARY' => 186,
			'OP08_MATH_ADD_SUB' => 173
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'VarOrLitOrOpStrOrWord' => 183,
			'OpStringOrWord' => 182,
			'Variable' => 179,
			'HashEntry' => 365,
			'HashDereference' => 166,
			'Literal' => 176
		}
	},
	{#State 328
		DEFAULT => -209
	},
	{#State 329
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			"%{" => 124
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 366
		}
	},
	{#State 330
		DEFAULT => -202
	},
	{#State 331
		DEFAULT => -188
	},
	{#State 332
		ACTIONS => {
			'LBRACE' => 99,
			"%{" => 124,
			'MY' => 151,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP01_QW' => 156,
			'ARGV' => 153,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'TypeInner' => 154,
			'ListElement' => 367,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 192,
			'HashReference' => 111,
			'Expression' => 144
		}
	},
	{#State 333
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 368
		}
	},
	{#State 334
		ACTIONS => {
			")" => 370
		}
	},
	{#State 335
		ACTIONS => {
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP01_QW' => 156,
			'ARGV' => 153,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'HashReference' => 111,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'SubExpression' => 192,
			'WordScoped' => 90,
			'Operator' => 100,
			'ListElement' => 189,
			'Variable' => 143,
			'ListElements' => 371,
			'TypeInner' => 154,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 336
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'LITERAL_NUMBER' => 91,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Literal' => 275,
			'VariableOrLiteral' => 372,
			'Variable' => 277
		}
	},
	{#State 337
		ACTIONS => {
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			"]" => 373,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 338
		ACTIONS => {
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			"}" => 374,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 339
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -217,
			'LPAREN' => -217,
			"}" => 375
		}
	},
	{#State 340
		DEFAULT => -120
	},
	{#State 341
		DEFAULT => -181
	},
	{#State 342
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'LBRACE' => 99,
			"%{" => 124,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 376,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 343
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'FHREF_SYMBOL_IN' => 310,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP01_NAMED_SCOLON' => 379,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'STDIN' => 309,
			'VARIABLE_SYMBOL' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 378,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Variable' => 143,
			'OpNamedScolonOrSubExpIn' => 377,
			'SubExpressionOrInput' => 380,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 308,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111
		}
	},
	{#State 344
		DEFAULT => -184
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 346
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 347
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 349
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP11_COMPARE_LT_GT' => 210,
			")" => 385,
			'OP09_BITWISE_SHIFT' => 211,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206
		}
	},
	{#State 350
		DEFAULT => -216
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 386
		}
	},
	{#State 352
		ACTIONS => {
			")" => 387
		}
	},
	{#State 353
		DEFAULT => -127
	},
	{#State 354
		DEFAULT => -226
	},
	{#State 355
		ACTIONS => {
			'OP21_LIST_COMMA' => 389,
			")" => 390
		},
		GOTOS => {
			'PAREN-19' => 388
		}
	},
	{#State 356
		DEFAULT => -48
	},
	{#State 357
		ACTIONS => {
			";" => 391
		}
	},
	{#State 358
		DEFAULT => -77
	},
	{#State 359
		DEFAULT => -76
	},
	{#State 360
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'TYPE_METHOD' => 392,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 58
		}
	},
	{#State 361
		DEFAULT => -59
	},
	{#State 362
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'WORD' => 164,
			'OP01_PRINT' => 167,
			'OP07_STRING_REPEAT' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'OP22_LOGICAL_NEG' => 185,
			'OP01_NAMED' => 169,
			"}" => 394,
			'OP01_NAMED_VOID' => 178,
			'OP01_OPEN' => 180,
			'OP01_CLOSE' => 162,
			'OP19_LOOP_CONTROL' => 181,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP23_LOGICAL_AND' => 175,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP11_COMPARE_LT_GT' => 172,
			'OP08_MATH_ADD_SUB' => 173,
			'OP10_NAMED_UNARY' => 186
		},
		GOTOS => {
			'OpStringOrWord' => 395,
			'HashEntryProperties' => 393
		}
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 364
		DEFAULT => -122
	},
	{#State 365
		DEFAULT => -208
	},
	{#State 366
		ACTIONS => {
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			"}" => -204,
			'OP04_MATH_POW' => 203,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -204,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP16_LOGICAL_OR' => 214,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210
		}
	},
	{#State 367
		DEFAULT => -187
	},
	{#State 368
		DEFAULT => -159,
		GOTOS => {
			'STAR-39' => 397
		}
	},
	{#State 369
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			"while" => -151,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			'OP01_CLOSE' => 101,
			"if" => 104,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACE' => 99,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP01_NAMED' => 94,
			'OP01_PRINT' => 95,
			"foreach" => -151,
			'WORD_UPPERCASE' => 115,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 109,
			"for" => -151,
			'LPAREN' => 105,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 129,
			'OP01_NAMED_VOID' => 132,
			"%{" => 124,
			'MY' => 122,
			'OP01_NAMED_VOID_SCOLON' => 127,
			'OP19_LOOP_CONTROL' => 126,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP01_NAMED_VOID_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 117
		},
		GOTOS => {
			'HashDereference' => 96,
			'VariableModification' => 128,
			'Operator' => 100,
			'Variable' => 131,
			'OPTIONAL-37' => 123,
			'ArrayDereference' => 125,
			'PLUS-42' => 399,
			'ArrayReference' => 82,
			'Literal' => 83,
			'Statement' => 80,
			'PAREN-36' => 106,
			'VariableDeclaration' => 107,
			'LoopLabel' => 108,
			'Conditional' => 89,
			'WordScoped' => 90,
			'Expression' => 85,
			'HashReference' => 111,
			'SubExpression' => 113,
			'Operation' => 398,
			'OperatorVoid' => 86,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 370
		DEFAULT => -82
	},
	{#State 371
		ACTIONS => {
			")" => 400
		}
	},
	{#State 372
		DEFAULT => -108
	},
	{#State 373
		DEFAULT => -178
	},
	{#State 374
		DEFAULT => -179
	},
	{#State 375
		DEFAULT => -180
	},
	{#State 376
		ACTIONS => {
			"]" => 401,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 377
		DEFAULT => -182
	},
	{#State 378
		DEFAULT => -240
	},
	{#State 379
		DEFAULT => -239
	},
	{#State 380
		ACTIONS => {
			";" => 402
		}
	},
	{#State 381
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 382
		ACTIONS => {
			'LPAREN' => 404
		}
	},
	{#State 383
		ACTIONS => {
			'LPAREN' => 405
		}
	},
	{#State 384
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 385
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 407
		}
	},
	{#State 386
		ACTIONS => {
			'LITERAL_STRING' => 408
		}
	},
	{#State 387
		DEFAULT => -133
	},
	{#State 388
		DEFAULT => -50
	},
	{#State 389
		ACTIONS => {
			'MY' => 409
		}
	},
	{#State 390
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 391
		DEFAULT => -61
	},
	{#State 392
		ACTIONS => {
			'VARIABLE_SYMBOL' => 411
		}
	},
	{#State 393
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 412
		}
	},
	{#State 394
		ACTIONS => {
			";" => 413
		}
	},
	{#State 395
		ACTIONS => {
			'OP20_HASH_FATARROW' => 414
		}
	},
	{#State 396
		DEFAULT => -223
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => -162,
			'WORD' => -162,
			"}" => -162,
			'OP01_NAMED' => -162,
			'OP01_PRINT' => -162,
			'OP01_CLOSE' => -162,
			"if" => -162,
			'LBRACKET' => -162,
			'OP03_MATH_INC_DEC' => -162,
			'LBRACE' => -162,
			'SELF' => -162,
			'' => -162,
			"elsif" => 417,
			'LITERAL_STRING' => -162,
			'CONSTANT_CALL_SCOPED' => -162,
			"\@{" => -162,
			'LITERAL_NUMBER' => -162,
			"while" => -162,
			'OP05_BITWISE_NEG_LPAREN' => -162,
			'OP05_MATH_NEG_LPAREN' => -162,
			"undef" => -162,
			'OP10_NAMED_UNARY_SCOLON' => -162,
			'OP01_NAMED_VOID_LPAREN' => -162,
			'OP19_LOOP_CONTROL_SCOLON' => -162,
			'OP22_LOGICAL_NEG' => -162,
			"else" => 419,
			'OP01_NAMED_SCOLON' => -162,
			'OP01_OPEN' => -162,
			'OP01_NAMED_VOID' => -162,
			"%{" => -162,
			'MY' => -162,
			'OP19_LOOP_CONTROL' => -162,
			'OP01_NAMED_VOID_SCOLON' => -162,
			'OP05_LOGICAL_NEG' => -162,
			"for" => -162,
			'LPAREN' => -162,
			"foreach" => -162,
			'WORD_UPPERCASE' => -162,
			'WORD_SCOPED' => -162,
			'OP10_NAMED_UNARY' => -162
		},
		GOTOS => {
			'OPTIONAL-41' => 415,
			'PAREN-38' => 418,
			'PAREN-40' => 416
		}
	},
	{#State 398
		DEFAULT => -173
	},
	{#State 399
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => 121,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED_VOID' => 132,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 129,
			'OP01_NAMED_VOID_SCOLON' => 127,
			'OP19_LOOP_CONTROL' => 126,
			"%{" => 124,
			'MY' => 122,
			'OP05_LOGICAL_NEG' => 109,
			"for" => -151,
			'LPAREN' => 105,
			'WORD_UPPERCASE' => 115,
			"foreach" => -151,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP01_PRINT' => 95,
			"}" => 420,
			'OP01_NAMED' => 94,
			"if" => 104,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			"while" => -151
		},
		GOTOS => {
			'HashDereference' => 96,
			'ArrayDereference' => 125,
			'OPTIONAL-37' => 123,
			'Variable' => 131,
			'Operator' => 100,
			'VariableModification' => 128,
			'PAREN-36' => 106,
			'LoopLabel' => 108,
			'VariableDeclaration' => 107,
			'Statement' => 80,
			'ArrayReference' => 82,
			'Literal' => 83,
			'SubExpression' => 113,
			'Operation' => 421,
			'OperatorVoid' => 86,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 111,
			'Expression' => 85,
			'Conditional' => 89,
			'WordScoped' => 90
		}
	},
	{#State 400
		DEFAULT => -84
	},
	{#State 401
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 422
		}
	},
	{#State 402
		DEFAULT => -241
	},
	{#State 403
		ACTIONS => {
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED_SCOLON' => 425,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP10_NAMED_UNARY_SCOLON' => 426,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'SubExpression' => 423,
			'OpNamedScolonOrSubExp' => 424,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 111,
			'Expression' => 144
		}
	},
	{#State 404
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 427,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 405
		ACTIONS => {
			'ARGV' => 153,
			'OP01_QW' => 156,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'LBRACE' => 99,
			'MY' => 151,
			"%{" => 124,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88
		},
		GOTOS => {
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83,
			'TypeInner' => 154,
			'ListElements' => 428,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ListElement' => 189,
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 192,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 406
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'STDIN' => 309,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'FHREF_SYMBOL_IN' => 310,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92
		},
		GOTOS => {
			'Variable' => 143,
			'Operator' => 100,
			'SubExpressionOrInput' => 429,
			'WordScoped' => 90,
			'SubExpression' => 308,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83
		}
	},
	{#State 407
		DEFAULT => -170
	},
	{#State 408
		ACTIONS => {
			'OP21_LIST_COMMA' => 430
		}
	},
	{#State 409
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 431
		}
	},
	{#State 410
		ACTIONS => {
			"\@ARG;" => 432
		}
	},
	{#State 411
		ACTIONS => {
			"= sub {" => 433
		}
	},
	{#State 412
		ACTIONS => {
			"}" => 434,
			'OP21_LIST_COMMA' => 435
		},
		GOTOS => {
			'PAREN-25' => 436
		}
	},
	{#State 413
		DEFAULT => -66
	},
	{#State 414
		ACTIONS => {
			'MY' => 437
		},
		GOTOS => {
			'TypeInnerProperties' => 438
		}
	},
	{#State 415
		DEFAULT => -163
	},
	{#State 416
		DEFAULT => -161
	},
	{#State 417
		ACTIONS => {
			'LPAREN' => 439
		}
	},
	{#State 418
		DEFAULT => -158
	},
	{#State 419
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 440
		}
	},
	{#State 420
		DEFAULT => -174
	},
	{#State 421
		DEFAULT => -172
	},
	{#State 422
		ACTIONS => {
			"undef" => 441
		}
	},
	{#State 423
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			";" => 442,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204
		}
	},
	{#State 424
		ACTIONS => {
			'VARIABLE_SYMBOL' => 443
		}
	},
	{#State 425
		DEFAULT => -236
	},
	{#State 426
		DEFAULT => -237
	},
	{#State 427
		ACTIONS => {
			'OP16_LOGICAL_OR' => 214,
			'OP17_LIST_RANGE' => 444,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202
		}
	},
	{#State 428
		ACTIONS => {
			")" => 445
		}
	},
	{#State 429
		ACTIONS => {
			")" => 446
		}
	},
	{#State 430
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'HashReference' => 111,
			'Expression' => 144,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 447
		}
	},
	{#State 431
		ACTIONS => {
			'VARIABLE_SYMBOL' => 448
		}
	},
	{#State 432
		DEFAULT => -52
	},
	{#State 433
		ACTIONS => {
			'VARIABLE_SYMBOL' => -68,
			'WORD' => -68,
			"}" => -68,
			'OP01_NAMED' => -68,
			'OP01_PRINT' => -68,
			'OP01_CLOSE' => -68,
			"if" => -68,
			'LBRACKET' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LBRACE' => -68,
			'SELF' => -68,
			'LITERAL_STRING' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"\@{" => -68,
			'LITERAL_NUMBER' => -68,
			"while" => -68,
			'OP05_BITWISE_NEG_LPAREN' => -68,
			"undef" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP01_NAMED_SCOLON' => -68,
			'OP01_OPEN' => -68,
			'OP01_NAMED_VOID' => -68,
			"%{" => -68,
			'LPAREN_MY' => 450,
			'MY' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP05_LOGICAL_NEG' => -68,
			"for" => -68,
			'LPAREN' => -68,
			"foreach" => -68,
			'WORD_UPPERCASE' => -68,
			'WORD_SCOPED' => -68,
			'OP10_NAMED_UNARY' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 451,
			'MethodArguments' => 449
		}
	},
	{#State 434
		ACTIONS => {
			";" => 452
		}
	},
	{#State 435
		ACTIONS => {
			'OP01_PRINT' => 167,
			'OP01_NAMED' => 169,
			'OP22_LOGICAL_NEG' => 185,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'OP07_STRING_REPEAT' => 168,
			'WORD' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP19_LOOP_CONTROL' => 181,
			'OP01_NAMED_VOID' => 178,
			'OP01_CLOSE' => 162,
			'OP01_OPEN' => 180,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP10_NAMED_UNARY' => 186,
			'OP08_MATH_ADD_SUB' => 173,
			'OP11_COMPARE_LT_GT' => 172
		},
		GOTOS => {
			'HashEntryProperties' => 453,
			'OpStringOrWord' => 395
		}
	},
	{#State 436
		DEFAULT => -63
	},
	{#State 437
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 454
		}
	},
	{#State 438
		DEFAULT => -207
	},
	{#State 439
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124
		},
		GOTOS => {
			'SubExpression' => 455,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 144,
			'HashReference' => 111,
			'Variable' => 143,
			'Operator' => 100,
			'WordScoped' => 90,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83
		}
	},
	{#State 440
		DEFAULT => -160
	},
	{#State 441
		ACTIONS => {
			";" => 456
		}
	},
	{#State 442
		DEFAULT => -238
	},
	{#State 443
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 457
		}
	},
	{#State 444
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 458,
			'HashReference' => 111,
			'Expression' => 144,
			'Variable' => 143,
			'WordScoped' => 90,
			'Operator' => 100,
			'Literal' => 83,
			'HashDereference' => 96,
			'ArrayReference' => 82
		}
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 459
		}
	},
	{#State 446
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 460
		}
	},
	{#State 447
		ACTIONS => {
			"]" => -85,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			";" => -85,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 203,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			"}" => -85,
			")" => -85,
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85
		}
	},
	{#State 448
		DEFAULT => -49
	},
	{#State 449
		DEFAULT => -67
	},
	{#State 450
		ACTIONS => {
			'WORD' => 59,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 461
		}
	},
	{#State 451
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 462
		}
	},
	{#State 452
		DEFAULT => -65
	},
	{#State 453
		DEFAULT => -62
	},
	{#State 454
		ACTIONS => {
			"\$TYPED_" => 463
		}
	},
	{#State 455
		ACTIONS => {
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP08_STRING_CAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			'OP09_BITWISE_SHIFT' => 211,
			")" => 464,
			'OP11_COMPARE_LT_GT' => 210,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP16_LOGICAL_OR' => 214,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 456
		DEFAULT => -183
	},
	{#State 457
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP10_NAMED_UNARY' => 110,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LBRACE' => 99,
			"%{" => 124,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED_SCOLON' => 425,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'OP10_NAMED_UNARY_SCOLON' => 426
		},
		GOTOS => {
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'OpNamedScolonOrSubExp' => 465,
			'SubExpression' => 423
		}
	},
	{#State 458
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 202,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP18_TERNARY' => -107,
			'OP07_STRING_REPEAT' => 205,
			'OP04_MATH_POW' => 203,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => 211,
			")" => 466,
			'OP11_COMPARE_LT_GT' => 210,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 212,
			'OP13_BITWISE_AND' => 216,
			'OP16_LOGICAL_OR' => 214
		}
	},
	{#State 459
		DEFAULT => -169
	},
	{#State 460
		DEFAULT => -171
	},
	{#State 461
		ACTIONS => {
			'SELF' => 467
		}
	},
	{#State 462
		ACTIONS => {
			'SELF' => 84,
			'LITERAL_STRING' => 81,
			"\@{" => 92,
			'LITERAL_NUMBER' => 91,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			"while" => -151,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			'OP01_PRINT' => 95,
			'OP01_NAMED' => 94,
			"}" => 469,
			"if" => 104,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 109,
			"for" => -151,
			'LPAREN' => 105,
			'WORD_UPPERCASE' => 115,
			"foreach" => -151,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED_VOID_LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP10_NAMED_UNARY_SCOLON' => 118,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID' => 132,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 129,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_VOID_SCOLON' => 127,
			"%{" => 124,
			'MY' => 122
		},
		GOTOS => {
			'ArrayReference' => 82,
			'Literal' => 83,
			'PAREN-36' => 106,
			'LoopLabel' => 108,
			'VariableDeclaration' => 107,
			'Statement' => 80,
			'Conditional' => 89,
			'WordScoped' => 90,
			'Operation' => 468,
			'SubExpression' => 113,
			'OperatorVoid' => 86,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 85,
			'HashReference' => 111,
			'HashDereference' => 96,
			'Variable' => 131,
			'VariableModification' => 128,
			'Operator' => 100,
			'ArrayDereference' => 125,
			'OPTIONAL-37' => 123
		}
	},
	{#State 463
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 181,
			'OP01_NAMED_VOID' => 178,
			'OP01_OPEN' => 180,
			'OP01_CLOSE' => 162,
			'OP01_PRINT' => 167,
			'OP07_STRING_REPEAT' => 168,
			'OP01_NAMED' => 169,
			'OP19_LOOP_CONTROL_SCOLON' => 184,
			'OP22_LOGICAL_NEG' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'WORD' => 164,
			'OP08_MATH_ADD_SUB' => 173,
			'OP10_NAMED_UNARY' => 186,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP23_LOGICAL_AND' => 175
		},
		GOTOS => {
			'OpStringOrWord' => 470
		}
	},
	{#State 464
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 471
		}
	},
	{#State 465
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 88,
			'LITERAL_NUMBER' => 91,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			"%{" => 124,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'Expression' => 144,
			'HashReference' => 111,
			'SubExpression' => 474,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'VariableModification' => 472,
			'WordScoped' => 90,
			'Variable' => 131,
			'HashDereference' => 96,
			'ArrayReference' => 82,
			'Literal' => 83,
			'SubExpressionOrVarMod' => 473
		}
	},
	{#State 466
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 467
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 476
		}
	},
	{#State 468
		DEFAULT => -69
	},
	{#State 469
		ACTIONS => {
			";" => 477
		}
	},
	{#State 470
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 478,
			'OP19_VARIABLE_ASSIGN' => 479
		}
	},
	{#State 471
		DEFAULT => -157
	},
	{#State 472
		DEFAULT => -148
	},
	{#State 473
		ACTIONS => {
			")" => 480
		}
	},
	{#State 474
		ACTIONS => {
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204,
			'OP04_MATH_POW' => 203,
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210,
			")" => -147,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP16_LOGICAL_OR' => 214,
			'OP23_LOGICAL_AND' => 208,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 475
		DEFAULT => -167
	},
	{#State 476
		ACTIONS => {
			'OP21_LIST_COMMA' => 483,
			")" => 481
		},
		GOTOS => {
			'PAREN-29' => 482
		}
	},
	{#State 477
		DEFAULT => -71
	},
	{#State 478
		ACTIONS => {
			'SELF' => 84,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 105,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 142,
			"\@{" => 92,
			'CONSTANT_CALL_SCOPED' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 97,
			'OP05_MATH_NEG_LPAREN' => 119,
			"undef" => 120,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_OPEN' => 129,
			'OP01_CLOSE' => 101,
			'LBRACE' => 99,
			"%{" => 124
		},
		GOTOS => {
			'HashReference' => 111,
			'Expression' => 144,
			'SubExpression' => 484,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 125,
			'Operator' => 100,
			'WordScoped' => 90,
			'Variable' => 143,
			'ArrayReference' => 82,
			'HashDereference' => 96,
			'Literal' => 83
		}
	},
	{#State 479
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 145,
			"undef" => 120,
			'OP05_MATH_NEG_LPAREN' => 119,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 28,
			"%{" => 124,
			'LBRACE' => 99,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 129,
			'OP03_MATH_INC_DEC' => 102,
			'LBRACKET' => 103,
			'LITERAL_STRING' => 81,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 109,
			'SELF' => 84,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 87,
			'CONSTANT_CALL_SCOPED' => 88,
			"\@{" => 92,
			'WORD_UPPERCASE' => 142,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'WordScoped' => 90,
			'Operator' => 100,
			'Variable' => 143,
			'Expression' => 144,
			'HashReference' => 111,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 114,
			'SubExpression' => 485,
			'Literal' => 83,
			'ArrayReference' => 82,
			'HashDereference' => 96
		}
	},
	{#State 480
		ACTIONS => {
			'LBRACE' => 369
		},
		GOTOS => {
			'CodeBlock' => 486
		}
	},
	{#State 481
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 487
		}
	},
	{#State 482
		DEFAULT => -73
	},
	{#State 483
		ACTIONS => {
			'MY' => 488
		}
	},
	{#State 484
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 210,
			'OP09_BITWISE_SHIFT' => 211,
			'OP16_LOGICAL_OR' => 214,
			'OP13_BITWISE_AND' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP08_MATH_ADD_SUB' => 212,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			"]" => 489,
			'OP15_LOGICAL_AND' => 213,
			'OP06_REGEX_BIND' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP04_MATH_POW' => 203,
			'OP07_STRING_REPEAT' => 205,
			'OP18_TERNARY' => 204
		}
	},
	{#State 485
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 211,
			'OP11_COMPARE_LT_GT' => 210,
			'OP13_BITWISE_AND' => 216,
			'OP08_MATH_ADD_SUB' => 212,
			'OP17_LIST_RANGE' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP23_LOGICAL_AND' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP06_REGEX_BIND' => 206,
			'OP15_LOGICAL_AND' => 213,
			'OP14_BITWISE_OR_XOR' => 202,
			'OP21_LIST_COMMA' => -224,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_STRING_CAT' => 201,
			'OP18_TERNARY' => 204,
			'OP07_STRING_REPEAT' => 205,
			"}" => -224,
			'OP04_MATH_POW' => 203
		}
	},
	{#State 486
		DEFAULT => -168
	},
	{#State 487
		ACTIONS => {
			"\@ARG;" => 490
		}
	},
	{#State 488
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 491
		}
	},
	{#State 489
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 490
		DEFAULT => -75
	},
	{#State 491
		ACTIONS => {
			'VARIABLE_SYMBOL' => 493
		}
	},
	{#State 492
		ACTIONS => {
			"undef" => 494
		}
	},
	{#State 493
		DEFAULT => -72
	},
	{#State 494
		DEFAULT => -225
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7243 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7261 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7268 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7404 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7443 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7471 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7525 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_76
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_77
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7662 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7684 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7695 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7761 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7772 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7783 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7794 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7805 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7827 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7849 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7860 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7882 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7893 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7904 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7915 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7926 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7948 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7970 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7981 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7992 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8013 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8027 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8038 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8049 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8060 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8071 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8082 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8093 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8104 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8115 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8122 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8129 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8143 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8154 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8165 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8176 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8187 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8198 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8209 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8220 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8231 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8242 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8253 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8264 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8275 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8286 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8297 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8308 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8319 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8330 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_146
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8341 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8352 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_148
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8363 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8370 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8377 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8384 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8395 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8406 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8417 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8428 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8439 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8446 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8460 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8474 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8481 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_163
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8492 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8503 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8514 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8525 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8536 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8547 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8558 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8569 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_171
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8580 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8587 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8594 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_174
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8605 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8612 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8619 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_177
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8630 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8641 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8652 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_180
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8663 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8674 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8685 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8696 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_184
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8707 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8718 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_186
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8729 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8736 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8743 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8750 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_190
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8761 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8772 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8783 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8794 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8805 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8819 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_197
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8830 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8837 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8844 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8855 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_201
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8866 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8873 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8880 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8891 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8902 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8913 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_207
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8924 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8945 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8956 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_212
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8967 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8974 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8981 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8992 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_216
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9003 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9014 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9025 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9036 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9047 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9058 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9069 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_223
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9080 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9091 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_225
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9102 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_226
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9113 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9124 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_228
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9135 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_229
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9146 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9157 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_231
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9168 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9179 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_233
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9190 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9201 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_235
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9212 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9223 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9234 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_238
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9245 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9256 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9267 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_241
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9278 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_242
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9289 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9300 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9311 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9322 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9333 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9344 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9355 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9366 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9377 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9388 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9399 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9410 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9421 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9432 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9443 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9454 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9465 lib/RPerl/Grammar.pm
	]
],
#line 9468 lib/RPerl/Grammar.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         '_PAREN', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CompileUnit_4', 
         'CompileUnit_5', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_18', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ModuleHeader_23', 
         'Module_24', 
         'Module_25', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_34', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Header_37', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_40', 
         'Include_41', 
         'Include_42', 
         'Constant_43', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_48', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_52', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_61', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_65', 
         'Properties_66', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_71', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_75', 
         'SubroutineOrMethod_76', 
         'SubroutineOrMethod_77', 
         'Operation_78', 
         'Operation_79', 
         'Operation_80', 
         'Operation_81', 
         'Operator_82', 
         'Operator_83', 
         'Operator_84', 
         'Operator_85', 
         'Operator_86', 
         'Operator_87', 
         'Operator_88', 
         'Operator_89', 
         'Operator_90', 
         'Operator_91', 
         'Operator_92', 
         'Operator_93', 
         'Operator_94', 
         'Operator_95', 
         'Operator_96', 
         'Operator_97', 
         'Operator_98', 
         'Operator_99', 
         'Operator_100', 
         'Operator_101', 
         'Operator_102', 
         'Operator_103', 
         'Operator_104', 
         'Operator_105', 
         'Operator_106', 
         'Operator_107', 
         'Operator_108', 
         'Operator_109', 
         'Operator_110', 
         'Operator_111', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         'OperatorVoid_124', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_129', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'Expression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpression_143', 
         'SubExpressionOrInput_144', 
         'SubExpressionOrInput_145', 
         'SubExpressionOrInput_146', 
         'SubExpressionOrVarMod_147', 
         'SubExpressionOrVarMod_148', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_152', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_163', 
         'Loop_164', 
         'Loop_165', 
         'Loop_166', 
         'LoopFor_167', 
         'LoopFor_168', 
         'LoopForEach_169', 
         'LoopWhile_170', 
         'LoopWhile_171', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_174', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_177', 
         'VariableRetrieval_178', 
         'VariableRetrieval_179', 
         'VariableRetrieval_180', 
         'VariableDeclaration_181', 
         'VariableDeclaration_182', 
         'VariableDeclaration_183', 
         'VariableDeclaration_184', 
         'VariableModification_185', 
         'VariableModification_186', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_190', 
         'ListElement_191', 
         'ListElement_192', 
         'ListElement_193', 
         'ListElement_194', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_197', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_200', 
         'ArrayDereference_201', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_204', 
         'HashEntry_205', 
         'HashEntry_206', 
         'HashEntryProperties_207', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_211', 
         'HashReference_212', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_215', 
         'HashDereference_216', 
         'WordScoped_217', 
         'WordScoped_218', 
         'LoopLabel_219', 
         'Type_220', 
         'Type_221', 
         'Type_222', 
         'TypeInner_223', 
         'TypeInnerProperties_224', 
         'TypeInnerProperties_225', 
         'TypeInnerConstant_226', 
         'VariableOrLiteral_227', 
         'VariableOrLiteral_228', 
         'VarOrLitOrOpStrOrWord_229', 
         'VarOrLitOrOpStrOrWord_230', 
         'VarOrLitOrOpStrOrWord_231', 
         'VariableSymbolOrSelf_232', 
         'VariableSymbolOrSelf_233', 
         'Literal_234', 
         'Literal_235', 
         'OpNamedScolonOrSubExp_236', 
         'OpNamedScolonOrSubExp_237', 
         'OpNamedScolonOrSubExp_238', 
         'OpNamedScolonOrSubExpIn_239', 
         'OpNamedScolonOrSubExpIn_240', 
         'OpNamedScolonOrSubExpIn_241', 
         'OpStringOrWord_242', 
         'OpStringOrWord_243', 
         'OpStringOrWord_244', 
         'OpStringOrWord_245', 
         'OpStringOrWord_246', 
         'OpStringOrWord_247', 
         'OpStringOrWord_248', 
         'OpStringOrWord_249', 
         'OpStringOrWord_250', 
         'OpStringOrWord_251', 
         'OpStringOrWord_252', 
         'OpStringOrWord_253', 
         'OpStringOrWord_254', 
         'OpStringOrWord_255', 
         'OpStringOrWord_256', 
         'OpStringOrWord_257', 
         'OpStringOrWord_258', );
  $self;
}

#line 262 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1.  Update grammar code in this file, above this line only
# 2.  Run `script/development/grammar_recompile.sh`
# 3.  Run `perl t/12_parse.t` for new & existing grammar parse-only tests, if errors goto step 1
# 4.  Inspect updates from Grammar.output file, note starting & finishing & increment/decrement numbers if any rule numbers have changed
# 5a. Run `scripts/development/grammar_increment.pl START FINISH INCREMENT` if rules added from step 4, repeat if needed
# 5b. Run `scripts/development/grammar_decrement.pl START FINISH DECREMENT` if rules deleted from step 4, repeat if needed
# 6.  Copy updates from Grammar.output file into this file with now-unique numbers, below this line only, if rules added
# 7.  Run `script/development/grammar_recompile.sh` again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',                             # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',                              # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG OPTIONAL-3 USE_RPERL Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_23 => 'RPerl::CompileUnit::Module::Header',                    # ModuleHeader -> OPTIONAL-9 OPTIONAL-10 'package' WordScoped ';' Header
Module_24 => 'RPerl::CompileUnit::Module::Package',                         # Module -> Package
Module_25 => 'RPerl::CompileUnit::Module::Class::Generator',                # Module -> Class
Package_34 => 'RPerl::CompileUnit::Module::Package',                        # Package -> STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_37 => 'RPerl::NonGenerator',                                         # Header -> 'use strict;' 'use warnings;' OPTIONAL-15 'our' VERSION_NUMBER_ASSIGN
Critic_40 => 'RPerl::CompileUnit::Critic',                                  # Critic -> '## no critic qw(' PLUS-14 ')'
Include_41 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped ';'
Include_42 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OP01_QW ';'
Constant_43 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_48 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_75 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@ARG;'
SubroutineOrMethod_76 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_77 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
Operation_78 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_79 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_80 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_81 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_82 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_83 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_84 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_85 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_86 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_87 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_88 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_89 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_90 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_91 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_92 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_93 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
Operator_94 => 'RPerl::Operation::Expression::Operator::String::Repeat',                    # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo',  # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract',           # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::String::Concatenate',               # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_98 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                    # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY SubExpression
Operator_100 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY
Operator_101 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',     # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',           # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                     # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                   # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::List::Range',                      # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_108 => 'RPerl::Operation::Expression::Operator::Ternary',                          # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_109 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_110 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_111 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_117 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_121 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_122 => 'RPerl::Operation::Expression::Operator::Named',                        # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_123 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_124 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_129 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_130 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_131 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_132 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_133 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_134 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_135 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_138 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_139 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_140 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_141 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_142 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_143 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_144 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_145 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_146 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_147 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_148 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_152 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_153 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_154 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_155 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_156 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_163 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_164 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_165 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_166 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_167 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_168 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_169 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_170 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_171 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_174 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_177 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_178 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_179 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_180 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_182 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_183 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_184 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_185 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_186 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_190 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_191 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_192 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_193 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_194 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_197 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_200 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_201 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_204 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_205 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_206 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_207 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_211 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_212 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_215 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_216 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_217 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_218 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_219 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_220 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_221 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_222 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_223 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_224 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_225 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_226 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_227 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_228 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_229 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_230 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_231 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_232 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_233 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_234 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_235 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_236 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_237 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_238 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_239 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_240 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_241 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_242 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_243 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_244 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_245 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_246 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_247 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_248 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_249 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_250 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_251 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_252 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_253 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_254 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_255 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_258 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 9938 lib/RPerl/Grammar.pm



1;
