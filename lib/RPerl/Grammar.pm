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
    our $VERSION = 0.008_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|foreach|\$TYPED_|package|undef|while|elsif|\@ARG\;|else|our|for|\%\{|if|\@\{|\;|\)|\]|\})}gc and return ($1, $1);

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
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_134' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_135' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-36', ')' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_143' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_144' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_145' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_146' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_147' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_148' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_149' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_150' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OPTIONAL-38', 'Loop' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_158' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'PAREN-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Conditional_165' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-40', 'OPTIONAL-42' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_168' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_169' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_170' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_171' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_172' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_173' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_176' => 'CodeBlock', [ 'LBRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_179' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_180' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_181' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_182' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_183' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_184' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_186' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_188' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'ListElements_192' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_194' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_195' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_196' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayReference_199' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-47', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayDereference_202' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_203' => 'ArrayDereference', [ '@{', 'OPTIONAL-48', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-49', 'SubExpression' ], 0 ],
  [ 'HashEntry_207' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_208' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_209' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [ 'STAR-51', 'PAREN-50' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [  ], 0 ],
  [ 'HashReference_213' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-51', '}' ], 0 ],
  [ 'HashReference_214' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'HashDereference_217' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_218' => 'HashDereference', [ '%{', 'OPTIONAL-52', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_220' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_221' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_222' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_223' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_224' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_225' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_226' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_227' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_228' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_229' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_230' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_231' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_232' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_233' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_234' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_235' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_236' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_237' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_238' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_239' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_240' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_241' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_242' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_243' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_244' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_245' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_246' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_247' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_248' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_249' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_250' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_251' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_252' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_253' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_254' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_259' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_260' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'Expression_134' => 134,
  'Expression_135' => 135,
  'Expression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpression_143' => 143,
  'SubExpression_144' => 144,
  'SubExpression_145' => 145,
  'SubExpressionOrInput_146' => 146,
  'SubExpressionOrInput_147' => 147,
  'SubExpressionOrInput_148' => 148,
  'SubExpressionOrVarMod_149' => 149,
  'SubExpressionOrVarMod_150' => 150,
  '_PAREN' => 151,
  '_OPTIONAL' => 152,
  '_OPTIONAL' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  'Statement_157' => 157,
  'Statement_158' => 158,
  '_PAREN' => 159,
  '_STAR_LIST' => 160,
  '_STAR_LIST' => 161,
  '_PAREN' => 162,
  '_OPTIONAL' => 163,
  '_OPTIONAL' => 164,
  'Conditional_165' => 165,
  'Loop_166' => 166,
  'Loop_167' => 167,
  'Loop_168' => 168,
  'LoopFor_169' => 169,
  'LoopFor_170' => 170,
  'LoopForEach_171' => 171,
  'LoopWhile_172' => 172,
  'LoopWhile_173' => 173,
  '_PLUS_LIST' => 174,
  '_PLUS_LIST' => 175,
  'CodeBlock_176' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  'Variable_179' => 179,
  'VariableRetrieval_180' => 180,
  'VariableRetrieval_181' => 181,
  'VariableRetrieval_182' => 182,
  'VariableDeclaration_183' => 183,
  'VariableDeclaration_184' => 184,
  'VariableDeclaration_185' => 185,
  'VariableDeclaration_186' => 186,
  'VariableModification_187' => 187,
  'VariableModification_188' => 188,
  '_PAREN' => 189,
  '_STAR_LIST' => 190,
  '_STAR_LIST' => 191,
  'ListElements_192' => 192,
  'ListElement_193' => 193,
  'ListElement_194' => 194,
  'ListElement_195' => 195,
  'ListElement_196' => 196,
  '_OPTIONAL' => 197,
  '_OPTIONAL' => 198,
  'ArrayReference_199' => 199,
  '_OPTIONAL' => 200,
  '_OPTIONAL' => 201,
  'ArrayDereference_202' => 202,
  'ArrayDereference_203' => 203,
  '_OPTIONAL' => 204,
  '_OPTIONAL' => 205,
  'HashEntry_206' => 206,
  'HashEntry_207' => 207,
  'HashEntry_208' => 208,
  'HashEntryProperties_209' => 209,
  '_PAREN' => 210,
  '_STAR_LIST' => 211,
  '_STAR_LIST' => 212,
  'HashReference_213' => 213,
  'HashReference_214' => 214,
  '_OPTIONAL' => 215,
  '_OPTIONAL' => 216,
  'HashDereference_217' => 217,
  'HashDereference_218' => 218,
  'WordScoped_219' => 219,
  'WordScoped_220' => 220,
  'LoopLabel_221' => 221,
  'Type_222' => 222,
  'Type_223' => 223,
  'Type_224' => 224,
  'TypeInner_225' => 225,
  'TypeInnerProperties_226' => 226,
  'TypeInnerProperties_227' => 227,
  'TypeInnerConstant_228' => 228,
  'VariableOrLiteral_229' => 229,
  'VariableOrLiteral_230' => 230,
  'VarOrLitOrOpStrOrWord_231' => 231,
  'VarOrLitOrOpStrOrWord_232' => 232,
  'VarOrLitOrOpStrOrWord_233' => 233,
  'VariableSymbolOrSelf_234' => 234,
  'VariableSymbolOrSelf_235' => 235,
  'Literal_236' => 236,
  'Literal_237' => 237,
  'OpNamedScolonOrSubExp_238' => 238,
  'OpNamedScolonOrSubExp_239' => 239,
  'OpNamedScolonOrSubExp_240' => 240,
  'OpNamedScolonOrSubExpIn_241' => 241,
  'OpNamedScolonOrSubExpIn_242' => 242,
  'OpNamedScolonOrSubExpIn_243' => 243,
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
  'OpStringOrWord_259' => 259,
  'OpStringOrWord_260' => 260,
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
			'SHEBANG' => 2,
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 6,
			'PLUS-2' => 3,
			'CompileUnit' => 5,
			'Program' => 7,
			'Critic' => 9,
			'ModuleHeader' => 8
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => 10,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 11
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 13,
			'OPTIONAL-3' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"package" => -20,
			'' => -5,
			'USE_RPERL' => -20,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'PAREN-1' => 14,
			'OPTIONAL-9' => 1,
			'ModuleHeader' => 8,
			'Critic' => 9
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 15
		},
		GOTOS => {
			'PLUS-16' => 16
		}
	},
	{#State 5
		ACTIONS => {
			'' => 17
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			'USE' => -27,
			"use constant" => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 22,
			"our" => -27
		},
		GOTOS => {
			'Module' => 19,
			'Package' => 21,
			'Class' => 20,
			'STAR-11' => 18
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -21
	},
	{#State 11
		ACTIONS => {
			"package" => 23
		}
	},
	{#State 12
		ACTIONS => {
			'USE_RPERL' => 24
		}
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => -39
	},
	{#State 16
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		ACTIONS => {
			'USE' => -29,
			"use constant" => -29,
			"## no critic qw(" => 4,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 27,
			'Critic' => 28
		}
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => -25
	},
	{#State 21
		DEFAULT => -24
	},
	{#State 22
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 23
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 24
		ACTIONS => {
			"use strict;" => 34
		},
		GOTOS => {
			'Header' => 33
		}
	},
	{#State 25
		DEFAULT => -38
	},
	{#State 26
		DEFAULT => -40
	},
	{#State 27
		ACTIONS => {
			"our" => -31,
			'USE' => 35,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 37,
			'Include' => 36
		}
	},
	{#State 28
		DEFAULT => -26
	},
	{#State 29
		ACTIONS => {
			")" => 38
		}
	},
	{#State 30
		DEFAULT => -219
	},
	{#State 31
		DEFAULT => -220
	},
	{#State 32
		ACTIONS => {
			";" => 39
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
			"use warnings;" => 41
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'WordScoped' => 42
		}
	},
	{#State 36
		DEFAULT => -28
	},
	{#State 37
		ACTIONS => {
			"our" => 45,
			"use constant" => 46
		},
		GOTOS => {
			'Constant' => 43,
			'PLUS-14' => 44,
			'Subroutine' => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			"use strict;" => 34
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'USE' => -11,
			"\@{" => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_PRINT' => -11,
			'LBRACE' => -11,
			'OP01_OPEN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LITERAL_NUMBER' => -11,
			"undef" => -11,
			"while" => -11,
			'SELF' => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			'WORD_SCOPED' => -11,
			"foreach" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"%{" => -11,
			'MY' => -11,
			'WORD' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LBRACKET' => -11,
			'WORD_UPPERCASE' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LPAREN' => -11,
			"## no critic qw(" => 4,
			"use constant" => -11,
			"for" => -11,
			'OP01_NAMED_SCOLON' => -11
		},
		GOTOS => {
			'STAR-5' => 51,
			'Critic' => 50
		}
	},
	{#State 41
		ACTIONS => {
			'USE_RPERL_AFTER' => 52,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 53
		}
	},
	{#State 42
		ACTIONS => {
			";" => 54,
			'OP01_QW' => 55
		}
	},
	{#State 43
		DEFAULT => -30
	},
	{#State 44
		ACTIONS => {
			"our" => 45,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'WORD_UPPERCASE' => 62
		}
	},
	{#State 47
		DEFAULT => -33
	},
	{#State 48
		ACTIONS => {
			'USE' => 35
		},
		GOTOS => {
			'Include' => 63
		}
	},
	{#State 49
		DEFAULT => -23
	},
	{#State 50
		DEFAULT => -8
	},
	{#State 51
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"for" => -13,
			"use constant" => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACKET' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'WORD' => -13,
			'MY' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"undef" => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_OPEN' => -13,
			'LBRACE' => -13,
			'OP01_PRINT' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"foreach" => -13,
			'WORD_SCOPED' => -13,
			"our" => -13,
			'LITERAL_STRING' => -13,
			'SELF' => -13,
			"while" => -13,
			"if" => -13,
			'OP01_CLOSE' => -13,
			"\@{" => -13,
			'USE' => 35,
			'OP05_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13
		},
		GOTOS => {
			'STAR-6' => 65,
			'Include' => 64
		}
	},
	{#State 52
		DEFAULT => -35
	},
	{#State 53
		ACTIONS => {
			"our" => 66
		}
	},
	{#State 54
		DEFAULT => -41
	},
	{#State 55
		ACTIONS => {
			";" => 67
		}
	},
	{#State 56
		DEFAULT => -32
	},
	{#State 57
		ACTIONS => {
			";" => 68
		}
	},
	{#State 58
		DEFAULT => -224
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 60
		DEFAULT => -223
	},
	{#State 61
		DEFAULT => -222
	},
	{#State 62
		ACTIONS => {
			'OP20_HASH_FATARROW' => 70
		}
	},
	{#State 63
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 71
		}
	},
	{#State 64
		DEFAULT => -10
	},
	{#State 65
		ACTIONS => {
			"foreach" => -15,
			'WORD_SCOPED' => -15,
			"our" => -15,
			'LITERAL_STRING' => -15,
			'SELF' => -15,
			"while" => -15,
			"undef" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LBRACE' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"if" => -15,
			'OP01_CLOSE' => -15,
			"\@{" => -15,
			'OP01_NAMED_SCOLON' => -15,
			"for" => -15,
			"use constant" => 46,
			'LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACKET' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'WORD' => -15,
			"%{" => -15,
			'MY' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP10_NAMED_UNARY' => -15,
			'VARIABLE_SYMBOL' => -15
		},
		GOTOS => {
			'Constant' => 73,
			'STAR-7' => 72
		}
	},
	{#State 66
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 74
		}
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		DEFAULT => -34
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 70
		ACTIONS => {
			'MY' => 77
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 71
		ACTIONS => {
			"## no critic qw(" => 4,
			"use constant" => -56,
			"our hashref \$properties" => -56,
			'USE' => -56
		},
		GOTOS => {
			'STAR-22' => 78,
			'Critic' => 79
		}
	},
	{#State 72
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 123,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 129,
			'OP01_CLOSE' => 131,
			"if" => 132,
			"while" => -153,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			"our" => 45,
			"foreach" => -153,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_PRINT' => 116,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'MY' => 93,
			"%{" => 94,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED_VOID' => 102,
			'OP01_NAMED' => 103,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 81,
			"for" => -153,
			'OP01_NAMED_SCOLON' => 85,
			'WORD_UPPERCASE' => 88,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'LoopLabel' => 87,
			'VariableDeclaration' => 92,
			'HashDereference' => 119,
			'HashReference' => 91,
			'Conditional' => 90,
			'SubExpression' => 82,
			'Operation' => 110,
			'PAREN-37' => 107,
			'Subroutine' => 80,
			'WordScoped' => 109,
			'Literal' => 86,
			'Expression' => 113,
			'Operator' => 84,
			'OperatorVoid' => 112,
			'Variable' => 130,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'OPTIONAL-38' => 96,
			'ArrayDereference' => 122,
			'Statement' => 128,
			'VariableModification' => 98,
			'PLUS-8' => 125
		}
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		ACTIONS => {
			'MY' => -45,
			"%{" => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'LBRACKET' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			'WORD' => -45,
			'OP01_NAMED' => -45,
			'OP01_NAMED_VOID' => -45,
			'OP10_NAMED_UNARY' => -45,
			'VARIABLE_SYMBOL' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'LPAREN' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP01_NAMED_SCOLON' => -45,
			"for" => -45,
			'WORD_UPPERCASE' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'LPAREN_MY' => 133,
			'OP01_NAMED_VOID_LPAREN' => -45,
			"}" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			"\@{" => -45,
			'OP01_CLOSE' => -45,
			"if" => -45,
			'LITERAL_STRING' => -45,
			'SELF' => -45,
			"while" => -45,
			'WORD_SCOPED' => -45,
			"foreach" => -45,
			'LBRACE' => -45,
			'OP01_PRINT' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"undef" => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_OPEN' => -45,
			'OP05_MATH_NEG_LPAREN' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 135,
			'OPTIONAL-17' => 134
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 111,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'Literal' => 136
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 137
		}
	},
	{#State 78
		ACTIONS => {
			"our hashref \$properties" => -58,
			"use constant" => -58,
			'USE' => 35
		},
		GOTOS => {
			'Include' => 138,
			'STAR-23' => 139
		}
	},
	{#State 79
		DEFAULT => -53
	},
	{#State 80
		DEFAULT => -14
	},
	{#State 81
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 140,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_PRINT' => 145,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'SubExpression' => 141,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 82
		ACTIONS => {
			'OP23_LOGICAL_AND' => 161,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP11_COMPARE_LT_GT' => 146,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 83
		ACTIONS => {
			'WORD_UPPERCASE' => 163
		},
		GOTOS => {
			'LoopLabel' => 164
		}
	},
	{#State 84
		DEFAULT => -131
	},
	{#State 85
		DEFAULT => -79
	},
	{#State 86
		DEFAULT => -139
	},
	{#State 87
		ACTIONS => {
			'COLON' => 165
		}
	},
	{#State 88
		ACTIONS => {
			'COLON' => -221,
			'LPAREN' => 166
		}
	},
	{#State 89
		ACTIONS => {
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			"%{" => 94,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 168
		}
	},
	{#State 90
		DEFAULT => -154
	},
	{#State 91
		DEFAULT => -143
	},
	{#State 92
		DEFAULT => -157
	},
	{#State 93
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 61,
			'TYPE_INTEGER' => 58,
			'TYPE_FHREF' => 169
		},
		GOTOS => {
			'Type' => 170
		}
	},
	{#State 94
		ACTIONS => {
			'LBRACE' => -216,
			'SELF' => 108,
			'VARIABLE_SYMBOL' => 100,
			'MY' => 174
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 106,
			'OPTIONAL-52' => 173,
			'TypeInner' => 171,
			'Variable' => 172
		}
	},
	{#State 95
		DEFAULT => -123
	},
	{#State 96
		ACTIONS => {
			"while" => 176,
			"for" => 179,
			"foreach" => 175
		},
		GOTOS => {
			'LoopForEach' => 181,
			'LoopWhile' => 178,
			'Loop' => 177,
			'LoopFor' => 180
		}
	},
	{#State 97
		ACTIONS => {
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'ARGV' => 182,
			"%{" => 94,
			'MY' => 174,
			'OP01_QW' => 185,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			"]" => -198,
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 183,
			'ListElement' => 188,
			'ListElements' => 186,
			'Operator' => 84,
			'Expression' => 144,
			'OPTIONAL-47' => 184,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'TypeInner' => 187,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 98
		ACTIONS => {
			";" => 189
		}
	},
	{#State 99
		ACTIONS => {
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"%{" => 94,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127
		},
		GOTOS => {
			'SubExpression' => 190,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91
		}
	},
	{#State 100
		DEFAULT => -234
	},
	{#State 101
		ACTIONS => {
			'OP06_REGEX_BIND' => -100,
			'OP18_TERNARY' => -100,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP01_NAMED' => 167,
			'OP07_STRING_REPEAT' => -100,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP08_STRING_CAT' => -100,
			"%{" => 94,
			'OP23_LOGICAL_AND' => -100,
			'OP22_LOGICAL_NEG' => 89,
			'OP17_LIST_RANGE' => -100,
			'WORD_UPPERCASE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP04_MATH_POW' => -100,
			'LPAREN' => 81,
			'OP01_CLOSE' => 131,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 127,
			'OP13_BITWISE_AND' => -100,
			"}" => -100,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			";" => -100,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP14_BITWISE_OR_XOR' => -100,
			")" => -100,
			'OP03_MATH_INC_DEC' => 115,
			'OP09_BITWISE_SHIFT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'LBRACE' => 114,
			'OP12_COMPARE_EQ_NE' => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP15_LOGICAL_AND' => -100,
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'OP16_LOGICAL_OR' => -100,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 191,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'ArrayReference' => 104
		}
	},
	{#State 102
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"%{" => 94,
			'ARGV' => 182,
			'MY' => 174,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30
		},
		GOTOS => {
			'ListElements' => 192,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'ListElement' => 188,
			'SubExpression' => 183,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'TypeInner' => 187
		}
	},
	{#State 103
		ACTIONS => {
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'MY' => 174,
			'ARGV' => 182,
			"%{" => 94,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_QW' => 185,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 193,
			'ListElement' => 194
		}
	},
	{#State 104
		DEFAULT => -141
	},
	{#State 105
		DEFAULT => -133
	},
	{#State 106
		DEFAULT => -178,
		GOTOS => {
			'STAR-44' => 195
		}
	},
	{#State 107
		DEFAULT => -152
	},
	{#State 108
		DEFAULT => -235
	},
	{#State 109
		ACTIONS => {
			'LPAREN' => 196,
			'OP02_METHOD_THINARROW_NEW' => 197
		}
	},
	{#State 110
		DEFAULT => -17
	},
	{#State 111
		DEFAULT => -237
	},
	{#State 112
		DEFAULT => -156
	},
	{#State 113
		ACTIONS => {
			'OP13_BITWISE_AND' => -137,
			'OP08_STRING_CAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP06_REGEX_BIND' => -137,
			'OP18_TERNARY' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP04_MATH_POW' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			";" => 198
		}
	},
	{#State 114
		ACTIONS => {
			'OP01_PRINT' => 200,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 201,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 208,
			'OP01_OPEN' => 203,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP19_LOOP_CONTROL' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP12_COMPARE_EQ_NE' => 204,
			'OP01_NAMED_VOID' => 214,
			'OP10_NAMED_UNARY' => 215,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 217,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_CLOSE' => 206,
			"}" => 207,
			"%{" => 94,
			'OP23_LOGICAL_AND' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'ENV' => 220,
			'WORD' => 222,
			'OP07_STRING_REPEAT' => 223
		},
		GOTOS => {
			'HashEntry' => 221,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 202,
			'Literal' => 212,
			'OpStringOrWord' => 209,
			'Variable' => 205,
			'VarOrLitOrOpStrOrWord' => 210
		}
	},
	{#State 115
		ACTIONS => {
			'VARIABLE_SYMBOL' => 100,
			'SELF' => 108
		},
		GOTOS => {
			'Variable' => 224,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 116
		ACTIONS => {
			'LBRACE' => -114,
			'WORD_UPPERCASE' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'LITERAL_NUMBER' => -114,
			'OP22_LOGICAL_NEG' => -114,
			"undef" => -114,
			'OP01_QW' => -114,
			'OP05_MATH_NEG_LPAREN' => -114,
			'OP01_OPEN' => -114,
			'LPAREN' => -114,
			'SELF' => -114,
			'LITERAL_STRING' => -114,
			'WORD_SCOPED' => -114,
			'OP10_NAMED_UNARY' => -114,
			'VARIABLE_SYMBOL' => -114,
			'OP01_NAMED' => -114,
			"\@{" => -114,
			'FHREF_SYMBOL_BRACES' => 228,
			'CONSTANT_CALL_SCOPED' => -114,
			'OP01_CLOSE' => -114,
			'MY' => -114,
			'ARGV' => -114,
			"%{" => -114,
			'LBRACKET' => -114,
			'WORD' => -114,
			'STDOUT_STDERR' => 225,
			'OP05_LOGICAL_NEG' => -114,
			'OP05_BITWISE_NEG_LPAREN' => -114
		},
		GOTOS => {
			'OPTIONAL-32' => 226,
			'PAREN-31' => 227
		}
	},
	{#State 117
		DEFAULT => -236
	},
	{#State 118
		DEFAULT => -138
	},
	{#State 119
		DEFAULT => -144
	},
	{#State 120
		ACTIONS => {
			'MY' => 229
		}
	},
	{#State 121
		ACTIONS => {
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			"%{" => 94
		},
		GOTOS => {
			'Variable' => 143,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'SubExpression' => 230,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84
		}
	},
	{#State 122
		DEFAULT => -142
	},
	{#State 123
		DEFAULT => -119
	},
	{#State 124
		ACTIONS => {
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			"%{" => 94,
			'MY' => 174,
			'ARGV' => 182,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			")" => -116
		},
		GOTOS => {
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'OPTIONAL-33' => 232,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'ListElement' => 188,
			'SubExpression' => 183,
			'ListElements' => 231,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143
		}
	},
	{#State 125
		ACTIONS => {
			'OP01_CLOSE' => 131,
			"if" => 132,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP01_NAMED_VOID_SCOLON' => 123,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LBRACE' => 114,
			'OP01_PRINT' => 116,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			"foreach" => -153,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			"while" => -153,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_NAMED' => 103,
			'OP01_NAMED_VOID' => 102,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'LBRACKET' => 97,
			'' => -18,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'MY' => 93,
			"%{" => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_UPPERCASE' => 88,
			'OP01_NAMED_SCOLON' => 85,
			"for" => -153,
			'LPAREN' => 81,
			'OP19_LOOP_CONTROL' => 83
		},
		GOTOS => {
			'LoopLabel' => 87,
			'VariableDeclaration' => 92,
			'HashReference' => 91,
			'HashDereference' => 119,
			'Conditional' => 90,
			'SubExpression' => 82,
			'Operation' => 233,
			'WordScoped' => 109,
			'PAREN-37' => 107,
			'Literal' => 86,
			'Expression' => 113,
			'OperatorVoid' => 112,
			'Operator' => 84,
			'Variable' => 130,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'OPTIONAL-38' => 96,
			'ArrayDereference' => 122,
			'Statement' => 128,
			'VariableModification' => 98
		}
	},
	{#State 126
		DEFAULT => -80
	},
	{#State 127
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED' => 167,
			"\@{" => 129
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'Variable' => 143,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 234
		}
	},
	{#State 128
		DEFAULT => -81
	},
	{#State 129
		ACTIONS => {
			'LBRACKET' => -201,
			'MY' => 174,
			'SELF' => 108,
			'VARIABLE_SYMBOL' => 100
		},
		GOTOS => {
			'OPTIONAL-48' => 235,
			'Variable' => 237,
			'TypeInner' => 236,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 130
		ACTIONS => {
			'OP13_BITWISE_AND' => -140,
			'OP08_STRING_CAT' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP07_STRING_REPEAT' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP06_REGEX_BIND' => -140,
			'OP18_TERNARY' => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP12_COMPARE_EQ_NE' => -140,
			'OP15_LOGICAL_AND' => -140,
			'OP02_METHOD_THINARROW' => 240,
			'OP04_MATH_POW' => -140,
			'OP19_VARIABLE_ASSIGN_BY' => 239,
			'OP11_COMPARE_LT_GT' => -140,
			'OP09_BITWISE_SHIFT' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			")" => -140,
			'OP17_LIST_RANGE' => -140,
			'OP03_MATH_INC_DEC' => 238,
			'OP08_MATH_ADD_SUB' => -140,
			'OP19_VARIABLE_ASSIGN' => 241
		}
	},
	{#State 131
		ACTIONS => {
			'FHREF_SYMBOL' => 242
		}
	},
	{#State 132
		ACTIONS => {
			'LPAREN' => 243
		}
	},
	{#State 133
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 134
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 245
		}
	},
	{#State 135
		DEFAULT => -44
	},
	{#State 136
		ACTIONS => {
			";" => 246
		}
	},
	{#State 137
		ACTIONS => {
			"\$TYPED_" => 247
		}
	},
	{#State 138
		DEFAULT => -55
	},
	{#State 139
		ACTIONS => {
			"our hashref \$properties" => 248,
			"use constant" => 46
		},
		GOTOS => {
			'Constant' => 249,
			'Properties' => 250
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_QW' => 185,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"%{" => 94,
			'MY' => 174,
			'ARGV' => 182,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99
		},
		GOTOS => {
			'Variable' => 143,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'ListElement' => 251,
			'SubExpression' => 193,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86
		}
	},
	{#State 141
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			")" => 252,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156
		}
	},
	{#State 142
		ACTIONS => {
			'LPAREN' => 166
		}
	},
	{#State 143
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			")" => -140,
			'OP03_MATH_INC_DEC' => 238,
			'OP08_MATH_ADD_SUB' => -140,
			'OP17_LIST_RANGE' => -140,
			'OP11_COMPARE_LT_GT' => -140,
			";" => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP02_METHOD_THINARROW' => 240,
			'OP04_MATH_POW' => -140,
			"]" => -140,
			'OP21_LIST_COMMA' => -140,
			'OP15_LOGICAL_AND' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP12_COMPARE_EQ_NE' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP18_TERNARY' => -140,
			'OP06_REGEX_BIND' => -140,
			"}" => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP08_STRING_CAT' => -140,
			'OP13_BITWISE_AND' => -140,
			'OP07_STRING_REPEAT' => -140
		}
	},
	{#State 144
		DEFAULT => -137
	},
	{#State 145
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 253
		}
	},
	{#State 146
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100
		},
		GOTOS => {
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 254,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86
		}
	},
	{#State 147
		ACTIONS => {
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"%{" => 94,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'SubExpression' => 255,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"%{" => 94,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'SubExpression' => 256,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91
		}
	},
	{#State 149
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			"%{" => 94
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 257
		}
	},
	{#State 150
		ACTIONS => {
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			"%{" => 94
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 258,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104
		}
	},
	{#State 151
		ACTIONS => {
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"%{" => 94,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 259,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayReference' => 104
		}
	},
	{#State 152
		ACTIONS => {
			"%{" => 94,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120
		},
		GOTOS => {
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'SubExpression' => 260,
			'ArrayDereference' => 122,
			'WordScoped' => 109
		}
	},
	{#State 153
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			"%{" => 94,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'SubExpression' => 261,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'Variable' => 143
		}
	},
	{#State 154
		ACTIONS => {
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			"%{" => 94
		},
		GOTOS => {
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'SubExpression' => 262,
			'ArrayDereference' => 122,
			'WordScoped' => 109
		}
	},
	{#State 155
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'WORD_SCOPED' => 31,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"%{" => 94,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayReference' => 104,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 263
		}
	},
	{#State 156
		ACTIONS => {
			"%{" => 94,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			'LBRACKET' => 97,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 264,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119
		}
	},
	{#State 157
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			"%{" => 94
		},
		GOTOS => {
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 265,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86
		}
	},
	{#State 158
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 266
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'SELF' => 108,
			'VARIABLE_SYMBOL' => 100,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'VariableOrLiteral' => 269,
			'Variable' => 268,
			'Literal' => 267,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 160
		ACTIONS => {
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			"%{" => 94
		},
		GOTOS => {
			'Variable' => 143,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 270,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86
		}
	},
	{#State 161
		ACTIONS => {
			"%{" => 94,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118
		},
		GOTOS => {
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 271,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'WORD_SCOPED' => 31,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			"%{" => 94,
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86,
			'SubExpression' => 272,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143
		}
	},
	{#State 163
		DEFAULT => -221
	},
	{#State 164
		ACTIONS => {
			";" => 273
		}
	},
	{#State 165
		DEFAULT => -151
	},
	{#State 166
		ACTIONS => {
			")" => 274
		}
	},
	{#State 167
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"%{" => 94,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 275,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'ArrayReference' => 104
		}
	},
	{#State 168
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			'OP07_STRING_REPEAT' => 162,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			")" => -109,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			";" => -109,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP21_LIST_COMMA' => -109,
			"]" => -109,
			'OP04_MATH_POW' => 156
		}
	},
	{#State 169
		ACTIONS => {
			'FHREF_SYMBOL' => 276
		}
	},
	{#State 170
		ACTIONS => {
			'VARIABLE_SYMBOL' => 277
		}
	},
	{#State 171
		DEFAULT => -215
	},
	{#State 172
		ACTIONS => {
			"}" => 278
		}
	},
	{#State 173
		ACTIONS => {
			'LBRACE' => 114
		},
		GOTOS => {
			'HashReference' => 279
		}
	},
	{#State 174
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 280
		}
	},
	{#State 175
		ACTIONS => {
			'MY' => 281
		}
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 282,
			'LPAREN_MY' => 283
		}
	},
	{#State 177
		DEFAULT => -155
	},
	{#State 178
		DEFAULT => -168
	},
	{#State 179
		ACTIONS => {
			'LPAREN_MY' => 285,
			'MY' => 284
		}
	},
	{#State 180
		DEFAULT => -166
	},
	{#State 181
		DEFAULT => -167
	},
	{#State 182
		DEFAULT => -196
	},
	{#State 183
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 149,
			")" => -193,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP08_MATH_ADD_SUB' => 147,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -193,
			'OP16_LOGICAL_OR' => 150,
			"]" => -193,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -193,
			'OP15_LOGICAL_AND' => 152,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP23_LOGICAL_AND' => 161,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 184
		ACTIONS => {
			"]" => 286
		}
	},
	{#State 185
		DEFAULT => -195
	},
	{#State 186
		DEFAULT => -197
	},
	{#State 187
		ACTIONS => {
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			"%{" => 94
		},
		GOTOS => {
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'SubExpression' => 287,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'Variable' => 143
		}
	},
	{#State 188
		DEFAULT => -191,
		GOTOS => {
			'STAR-46' => 288
		}
	},
	{#State 189
		DEFAULT => -158
	},
	{#State 190
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 147,
			")" => 289,
			'OP17_LIST_RANGE' => 154,
			'OP09_BITWISE_SHIFT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 146,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 161,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP24_LOGICAL_OR_XOR' => 157
		}
	},
	{#State 191
		ACTIONS => {
			";" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			")" => -99,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => -99,
			'OP08_MATH_ADD_SUB' => 147,
			'OP15_LOGICAL_AND' => -99,
			'OP04_MATH_POW' => 156,
			"]" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP18_TERNARY' => -99,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => -99,
			"}" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 192
		ACTIONS => {
			";" => 290
		}
	},
	{#State 193
		ACTIONS => {
			'OP07_STRING_REPEAT' => -83,
			'OP08_STRING_CAT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP18_TERNARY' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -193,
			'OP16_LOGICAL_OR' => -83,
			";" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			")" => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP17_LIST_RANGE' => -83
		}
	},
	{#State 194
		ACTIONS => {
			'OP21_LIST_COMMA' => 291
		}
	},
	{#State 195
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -179,
			'OP07_MATH_MULT_DIV_MOD' => -179,
			"]" => -179,
			'OP19_VARIABLE_ASSIGN_BY' => -179,
			'OP02_METHOD_THINARROW' => -179,
			'OP21_LIST_COMMA' => -179,
			'OP04_MATH_POW' => -179,
			'OP15_LOGICAL_AND' => -179,
			'OP02_HASH_THINARROW' => 293,
			'OP16_LOGICAL_OR' => -179,
			'OP20_HASH_FATARROW' => -179,
			";" => -179,
			'OP14_BITWISE_OR_XOR' => -179,
			'OP17_LIST_RANGE' => -179,
			")" => -179,
			'OP09_BITWISE_SHIFT' => -179,
			'OP03_MATH_INC_DEC' => -179,
			'OP08_MATH_ADD_SUB' => -179,
			'OP11_COMPARE_LT_GT' => -179,
			'OP19_VARIABLE_ASSIGN' => -179,
			'OP07_STRING_REPEAT' => -179,
			'COLON' => -179,
			'OP08_STRING_CAT' => -179,
			'OP13_BITWISE_AND' => -179,
			"}" => -179,
			'OP02_ARRAY_THINARROW' => 292,
			'OP23_LOGICAL_AND' => -179,
			'OP06_REGEX_BIND' => -179,
			'OP18_TERNARY' => -179,
			'OP24_LOGICAL_OR_XOR' => -179
		},
		GOTOS => {
			'VariableRetrieval' => 294
		}
	},
	{#State 196
		ACTIONS => {
			'ARGV' => 182,
			"%{" => 94,
			'MY' => 174,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			")" => -126,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP01_QW' => 185,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120
		},
		GOTOS => {
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'Variable' => 143,
			'OPTIONAL-34' => 296,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'ListElements' => 295,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 183,
			'ListElement' => 188
		}
	},
	{#State 197
		ACTIONS => {
			")" => -130,
			'LBRACE' => 114
		},
		GOTOS => {
			'HashReference' => 297,
			'OPTIONAL-36' => 298
		}
	},
	{#State 198
		DEFAULT => -78
	},
	{#State 199
		DEFAULT => -252
	},
	{#State 200
		DEFAULT => -259
	},
	{#State 201
		DEFAULT => -250
	},
	{#State 202
		DEFAULT => -207
	},
	{#State 203
		DEFAULT => -257
	},
	{#State 204
		DEFAULT => -249
	},
	{#State 205
		DEFAULT => -231
	},
	{#State 206
		DEFAULT => -256
	},
	{#State 207
		DEFAULT => -214
	},
	{#State 208
		DEFAULT => -246
	},
	{#State 209
		DEFAULT => -233
	},
	{#State 210
		ACTIONS => {
			'OP20_HASH_FATARROW' => 299
		}
	},
	{#State 211
		DEFAULT => -248
	},
	{#State 212
		DEFAULT => -232
	},
	{#State 213
		DEFAULT => -253
	},
	{#State 214
		DEFAULT => -258
	},
	{#State 215
		DEFAULT => -251
	},
	{#State 216
		DEFAULT => -244
	},
	{#State 217
		DEFAULT => -255
	},
	{#State 218
		DEFAULT => -245
	},
	{#State 219
		DEFAULT => -247
	},
	{#State 220
		DEFAULT => -208
	},
	{#State 221
		DEFAULT => -212,
		GOTOS => {
			'STAR-51' => 300
		}
	},
	{#State 222
		DEFAULT => -260
	},
	{#State 223
		DEFAULT => -254
	},
	{#State 224
		DEFAULT => -87
	},
	{#State 225
		DEFAULT => -112
	},
	{#State 226
		ACTIONS => {
			'MY' => 174,
			'ARGV' => 182,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'ListElements' => 301,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'ListElement' => 188,
			'SubExpression' => 183,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'Variable' => 143
		}
	},
	{#State 227
		DEFAULT => -113
	},
	{#State 228
		ACTIONS => {
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'ARGV' => 182,
			"%{" => 94,
			'MY' => 174,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'ListElement' => 188,
			'SubExpression' => 183,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'ListElements' => 302,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 229
		ACTIONS => {
			'TYPE_FHREF' => 303
		}
	},
	{#State 230
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 146,
			'OP09_BITWISE_SHIFT' => 149,
			")" => 304,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP23_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 231
		DEFAULT => -115
	},
	{#State 232
		ACTIONS => {
			")" => 305
		}
	},
	{#State 233
		DEFAULT => -16
	},
	{#State 234
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP06_REGEX_BIND' => -91,
			'OP18_TERNARY' => -91,
			'OP08_STRING_CAT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			")" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP04_MATH_POW' => 156,
			"]" => -91,
			'OP21_LIST_COMMA' => -91
		}
	},
	{#State 235
		ACTIONS => {
			'LBRACKET' => 97
		},
		GOTOS => {
			'ArrayReference' => 306
		}
	},
	{#State 236
		DEFAULT => -200
	},
	{#State 237
		ACTIONS => {
			"}" => 307
		}
	},
	{#State 238
		DEFAULT => -88
	},
	{#State 239
		ACTIONS => {
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			"%{" => 94,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 308,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91
		}
	},
	{#State 240
		ACTIONS => {
			'LPAREN' => 309
		}
	},
	{#State 241
		ACTIONS => {
			'STDIN' => 312,
			'FHREF_SYMBOL_IN' => 311,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101
		},
		GOTOS => {
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 310,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86,
			'Variable' => 143,
			'SubExpressionOrInput' => 313,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91
		}
	},
	{#State 242
		DEFAULT => -86
	},
	{#State 243
		ACTIONS => {
			"%{" => 94,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'Variable' => 143,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 314
		}
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 315
		}
	},
	{#State 245
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'OP01_PRINT' => 116,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			"while" => -153,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			"foreach" => -153,
			"\@{" => 129,
			"if" => 132,
			'OP01_CLOSE' => 131,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP01_NAMED_VOID_SCOLON' => 123,
			"}" => 316,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'WORD_UPPERCASE' => 88,
			'OP22_LOGICAL_NEG' => 89,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 81,
			'OP01_NAMED_SCOLON' => 85,
			"for" => -153,
			'OP01_NAMED' => 103,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED_VOID' => 102,
			'OP10_NAMED_UNARY' => 101,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			"%{" => 94,
			'MY' => 93,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97
		},
		GOTOS => {
			'PAREN-37' => 107,
			'WordScoped' => 109,
			'Operation' => 317,
			'SubExpression' => 82,
			'Expression' => 113,
			'OperatorVoid' => 112,
			'Operator' => 84,
			'Literal' => 86,
			'LoopLabel' => 87,
			'HashReference' => 91,
			'Conditional' => 90,
			'HashDereference' => 119,
			'VariableDeclaration' => 92,
			'ArrayDereference' => 122,
			'OPTIONAL-38' => 96,
			'VariableModification' => 98,
			'Statement' => 128,
			'Variable' => 130,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106
		}
	},
	{#State 246
		DEFAULT => -43
	},
	{#State 247
		ACTIONS => {
			'WORD_UPPERCASE' => 318
		}
	},
	{#State 248
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 319
		}
	},
	{#State 249
		DEFAULT => -57
	},
	{#State 250
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 320
		}
	},
	{#State 251
		ACTIONS => {
			'OP21_LIST_COMMA' => 321
		}
	},
	{#State 252
		DEFAULT => -145
	},
	{#State 253
		ACTIONS => {
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP01_QW' => 185,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'MY' => 174,
			"%{" => 94,
			'ARGV' => 182,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'Variable' => 143,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'ListElements' => 322,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 183,
			'ListElement' => 188,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144
		}
	},
	{#State 254
		ACTIONS => {
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => -101,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			";" => -101,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP15_LOGICAL_AND' => -101,
			"]" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 156,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 255
		ACTIONS => {
			'OP04_MATH_POW' => 156,
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -96,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP07_STRING_REPEAT' => 162,
			"}" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => -96,
			'OP18_TERNARY' => -96,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => -96
		}
	},
	{#State 256
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 156,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 149,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -104
		}
	},
	{#State 257
		ACTIONS => {
			'OP23_LOGICAL_AND' => -98,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP06_REGEX_BIND' => 158,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			"]" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 156,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP11_COMPARE_LT_GT' => -98,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP08_MATH_ADD_SUB' => 147,
			";" => -98
		}
	},
	{#State 258
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			'OP06_REGEX_BIND' => 158,
			"}" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 162,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => -106,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -106,
			'OP16_LOGICAL_OR' => -106,
			"]" => -106,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => 152,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 259
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP06_REGEX_BIND' => 158,
			"}" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			")" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP04_MATH_POW' => 156,
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 260
		ACTIONS => {
			")" => -105,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => -105,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP04_MATH_POW' => 156,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP18_TERNARY' => -105,
			'OP06_REGEX_BIND' => 158,
			"}" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 261
		ACTIONS => {
			'OP16_LOGICAL_OR' => -103,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP15_LOGICAL_AND' => -103,
			"]" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 146,
			'OP17_LIST_RANGE' => -103,
			")" => -103,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => -103,
			";" => -103,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => -103,
			'OP23_LOGICAL_AND' => -103,
			"}" => -103,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => -103
		}
	},
	{#State 262
		ACTIONS => {
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_STRING_REPEAT' => 162,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -107,
			"}" => -107,
			";" => -107,
			'OP11_COMPARE_LT_GT' => 146,
			")" => -107,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			"]" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP16_LOGICAL_OR' => 150
		}
	},
	{#State 263
		ACTIONS => {
			";" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			")" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP21_LIST_COMMA' => -95,
			"]" => -95,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_STRING_REPEAT' => 162,
			"}" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP13_BITWISE_AND' => -95
		}
	},
	{#State 264
		ACTIONS => {
			")" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			"]" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP18_TERNARY' => -89,
			'OP06_REGEX_BIND' => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP07_STRING_REPEAT' => -89
		}
	},
	{#State 265
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			"}" => -111,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			"]" => -111,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -111,
			'OP15_LOGICAL_AND' => 152,
			'OP17_LIST_RANGE' => 154,
			")" => -111,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -111
		}
	},
	{#State 266
		DEFAULT => -93
	},
	{#State 267
		DEFAULT => -230
	},
	{#State 268
		DEFAULT => -229
	},
	{#State 269
		ACTIONS => {
			'COLON' => 323
		}
	},
	{#State 270
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_STRING_CAT' => -97,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			'OP07_STRING_REPEAT' => 162,
			'OP11_COMPARE_LT_GT' => -97,
			'OP17_LIST_RANGE' => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP08_MATH_ADD_SUB' => 147,
			";" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP15_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 156,
			"]" => -97,
			'OP21_LIST_COMMA' => -97
		}
	},
	{#State 271
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			"]" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP08_MATH_ADD_SUB' => 147,
			")" => -110,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP09_BITWISE_SHIFT' => 149,
			'OP11_COMPARE_LT_GT' => 146,
			";" => -110,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			"}" => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159
		}
	},
	{#State 272
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -94,
			")" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			";" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			"]" => -94,
			'OP04_MATH_POW' => 156,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP06_REGEX_BIND' => 158,
			'OP23_LOGICAL_AND' => -94,
			"}" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_STRING_REPEAT' => -94
		}
	},
	{#State 273
		DEFAULT => -124
	},
	{#State 274
		DEFAULT => -132
	},
	{#State 275
		ACTIONS => {
			";" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			")" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP15_LOGICAL_AND' => -83,
			"]" => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP18_TERNARY' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP08_STRING_CAT' => -83,
			'OP23_LOGICAL_AND' => -83,
			"}" => -83
		}
	},
	{#State 276
		ACTIONS => {
			";" => 324
		}
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 326,
			'OP02_ARRAY_THINARROW' => 327,
			";" => 325
		}
	},
	{#State 278
		DEFAULT => -217
	},
	{#State 279
		ACTIONS => {
			"}" => 328
		}
	},
	{#State 280
		ACTIONS => {
			"\$TYPED_" => 329
		}
	},
	{#State 281
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 330
		}
	},
	{#State 282
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			"%{" => 94
		},
		GOTOS => {
			'Variable' => 143,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'SubExpression' => 331,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84
		}
	},
	{#State 283
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 332
		}
	},
	{#State 284
		ACTIONS => {
			'TYPE_INTEGER' => 333
		}
	},
	{#State 285
		ACTIONS => {
			'TYPE_INTEGER' => 334
		}
	},
	{#State 286
		DEFAULT => -199
	},
	{#State 287
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			"]" => -194,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -194,
			'OP16_LOGICAL_OR' => 150,
			";" => -194,
			'OP11_COMPARE_LT_GT' => 146,
			")" => -194,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 162,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 161,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP24_LOGICAL_OR_XOR' => 157
		}
	},
	{#State 288
		ACTIONS => {
			")" => -192,
			";" => -192,
			'OP21_LIST_COMMA' => 336,
			"]" => -192
		},
		GOTOS => {
			'PAREN-45' => 335
		}
	},
	{#State 289
		DEFAULT => -90
	},
	{#State 290
		DEFAULT => -121
	},
	{#State 291
		ACTIONS => {
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP01_QW' => 185,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'MY' => 174,
			'ARGV' => 182,
			"%{" => 94,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131
		},
		GOTOS => {
			'ListElements' => 337,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 183,
			'ListElement' => 188,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'Variable' => 143,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'TypeInner' => 187,
			'ArrayReference' => 104
		}
	},
	{#State 292
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'WORD_SCOPED' => 31,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97
		},
		GOTOS => {
			'Variable' => 143,
			'ArrayReference' => 104,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 338,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86
		}
	},
	{#State 293
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACKET' => 97,
			'WORD' => 340,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'Variable' => 143,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 339
		}
	},
	{#State 294
		DEFAULT => -177
	},
	{#State 295
		DEFAULT => -125
	},
	{#State 296
		ACTIONS => {
			")" => 341
		}
	},
	{#State 297
		DEFAULT => -129
	},
	{#State 298
		ACTIONS => {
			")" => 342
		}
	},
	{#State 299
		ACTIONS => {
			"%{" => -205,
			'MY' => 174,
			'WORD' => -205,
			'OP05_LOGICAL_NEG' => -205,
			'OP05_BITWISE_NEG_LPAREN' => -205,
			'LBRACKET' => -205,
			'VARIABLE_SYMBOL' => -205,
			'OP10_NAMED_UNARY' => -205,
			"\@{" => -205,
			'OP01_NAMED' => -205,
			'OP01_CLOSE' => -205,
			'CONSTANT_CALL_SCOPED' => -205,
			'SELF' => -205,
			'LPAREN' => -205,
			'LITERAL_STRING' => -205,
			'WORD_SCOPED' => -205,
			'OP03_MATH_INC_DEC' => -205,
			'LBRACE' => -205,
			'WORD_UPPERCASE' => -205,
			'OP05_MATH_NEG_LPAREN' => -205,
			'OP01_OPEN' => -205,
			'OP22_LOGICAL_NEG' => -205,
			'LITERAL_NUMBER' => -205,
			"undef" => -205
		},
		GOTOS => {
			'OPTIONAL-49' => 344,
			'TypeInner' => 343
		}
	},
	{#State 300
		ACTIONS => {
			"}" => 346,
			'OP21_LIST_COMMA' => 347
		},
		GOTOS => {
			'PAREN-50' => 345
		}
	},
	{#State 301
		ACTIONS => {
			";" => 348
		}
	},
	{#State 302
		ACTIONS => {
			";" => 349
		}
	},
	{#State 303
		ACTIONS => {
			'FHREF_SYMBOL' => 350
		}
	},
	{#State 304
		DEFAULT => -92
	},
	{#State 305
		ACTIONS => {
			";" => 351
		}
	},
	{#State 306
		ACTIONS => {
			"}" => 352
		}
	},
	{#State 307
		DEFAULT => -202
	},
	{#State 308
		ACTIONS => {
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			";" => -188,
			'OP09_BITWISE_SHIFT' => 149,
			")" => -188,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => 154,
			'OP11_COMPARE_LT_GT' => 146,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 150
		}
	},
	{#State 309
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'OP01_QW' => 185,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			")" => -128,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			'MY' => 174,
			'ARGV' => 182,
			"%{" => 94
		},
		GOTOS => {
			'ArrayReference' => 104,
			'TypeInner' => 187,
			'OPTIONAL-35' => 353,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 183,
			'ListElement' => 188,
			'ListElements' => 354
		}
	},
	{#State 310
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 146,
			")" => -146,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			";" => -146
		}
	},
	{#State 311
		DEFAULT => -147
	},
	{#State 312
		DEFAULT => -148
	},
	{#State 313
		DEFAULT => -187
	},
	{#State 314
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 147,
			")" => 355,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP11_COMPARE_LT_GT' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP23_LOGICAL_AND' => 161,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 315
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 356
		}
	},
	{#State 316
		ACTIONS => {
			";" => 357
		}
	},
	{#State 317
		DEFAULT => -46
	},
	{#State 318
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 319
		ACTIONS => {
			'LBRACE' => 359
		}
	},
	{#State 320
		ACTIONS => {
			"our" => 361,
			'LITERAL_NUMBER' => 360
		},
		GOTOS => {
			'Method' => 362,
			'SubroutineOrMethod' => 364,
			'Subroutine' => 363
		}
	},
	{#State 321
		ACTIONS => {
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'LBRACKET' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			"%{" => 94,
			'ARGV' => 182,
			'MY' => 174,
			"undef" => 118,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108
		},
		GOTOS => {
			'Variable' => 143,
			'TypeInner' => 187,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'ListElement' => 188,
			'SubExpression' => 183,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'ListElements' => 365,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86
		}
	},
	{#State 322
		ACTIONS => {
			")" => 366
		}
	},
	{#State 323
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 111,
			'VARIABLE_SYMBOL' => 100,
			'SELF' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 106,
			'Literal' => 267,
			'Variable' => 268,
			'VariableOrLiteral' => 367
		}
	},
	{#State 324
		DEFAULT => -186
	},
	{#State 325
		DEFAULT => -183
	},
	{#State 326
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 368,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'STDIN' => 312,
			'FHREF_SYMBOL_IN' => 311,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_SCOLON' => 371,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81
		},
		GOTOS => {
			'OpNamedScolonOrSubExpIn' => 369,
			'ArrayReference' => 104,
			'SubExpressionOrInput' => 370,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 310
		}
	},
	{#State 327
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167
		},
		GOTOS => {
			'Variable' => 143,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 372,
			'Expression' => 144,
			'Operator' => 84,
			'Literal' => 86
		}
	},
	{#State 328
		DEFAULT => -218
	},
	{#State 329
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP19_LOOP_CONTROL' => 211,
			'OP22_LOGICAL_NEG' => 208,
			'OP01_OPEN' => 203,
			'OP01_PRINT' => 200,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 201,
			'OP07_STRING_REPEAT' => 223,
			'WORD' => 222,
			'OP23_LOGICAL_AND' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP01_CLOSE' => 206,
			'OP10_NAMED_UNARY' => 215,
			'OP01_NAMED_VOID' => 214,
			'OP01_NAMED' => 217,
			'OP24_LOGICAL_OR_XOR' => 216
		},
		GOTOS => {
			'OpStringOrWord' => 373
		}
	},
	{#State 330
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 331
		ACTIONS => {
			'OP23_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP17_LIST_RANGE' => 154,
			'OP09_BITWISE_SHIFT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 147,
			")" => 375,
			'OP11_COMPARE_LT_GT' => 146
		}
	},
	{#State 332
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 333
		ACTIONS => {
			'VARIABLE_SYMBOL' => 377
		}
	},
	{#State 334
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 335
		DEFAULT => -190
	},
	{#State 336
		ACTIONS => {
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP01_QW' => 185,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'MY' => 174,
			"%{" => 94,
			'ARGV' => 182,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 183,
			'ListElement' => 379,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'Variable' => 143,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'TypeInner' => 187
		}
	},
	{#State 337
		ACTIONS => {
			";" => 380
		}
	},
	{#State 338
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 147,
			'OP11_COMPARE_LT_GT' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			"]" => 381,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152
		}
	},
	{#State 339
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 146,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP09_BITWISE_SHIFT' => 149,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 150,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => 161,
			"}" => 382,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153
		}
	},
	{#State 340
		ACTIONS => {
			'LPAREN' => -219,
			"}" => 383,
			'OP02_METHOD_THINARROW_NEW' => -219
		}
	},
	{#State 341
		DEFAULT => -134
	},
	{#State 342
		DEFAULT => -136
	},
	{#State 343
		DEFAULT => -204
	},
	{#State 344
		ACTIONS => {
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"%{" => 94,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131
		},
		GOTOS => {
			'ArrayReference' => 104,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 384
		}
	},
	{#State 345
		DEFAULT => -211
	},
	{#State 346
		DEFAULT => -213
	},
	{#State 347
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP23_LOGICAL_AND' => 218,
			"%{" => 94,
			'OP07_STRING_REPEAT' => 223,
			'WORD' => 222,
			'ENV' => 220,
			'OP01_NAMED' => 217,
			'OP24_LOGICAL_OR_XOR' => 216,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 215,
			'OP01_NAMED_VOID' => 214,
			'OP01_CLOSE' => 206,
			'OP19_LOOP_CONTROL' => 211,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP12_COMPARE_EQ_NE' => 204,
			'OP11_COMPARE_LT_GT' => 201,
			'OP01_PRINT' => 200,
			'OP08_MATH_ADD_SUB' => 199,
			'OP01_OPEN' => 203,
			'OP22_LOGICAL_NEG' => 208,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'HashEntry' => 385,
			'Literal' => 212,
			'HashDereference' => 202,
			'VariableSymbolOrSelf' => 106,
			'OpStringOrWord' => 209,
			'Variable' => 205,
			'VarOrLitOrOpStrOrWord' => 210
		}
	},
	{#State 348
		DEFAULT => -117
	},
	{#State 349
		DEFAULT => -118
	},
	{#State 350
		ACTIONS => {
			'OP21_LIST_COMMA' => 386
		}
	},
	{#State 351
		DEFAULT => -120
	},
	{#State 352
		DEFAULT => -203
	},
	{#State 353
		ACTIONS => {
			")" => 387
		}
	},
	{#State 354
		DEFAULT => -127
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 356
		ACTIONS => {
			'OP21_LIST_COMMA' => 390,
			")" => 391
		},
		GOTOS => {
			'PAREN-19' => 392
		}
	},
	{#State 357
		DEFAULT => -48
	},
	{#State 358
		DEFAULT => -228
	},
	{#State 359
		ACTIONS => {
			'OP10_NAMED_UNARY' => 215,
			'OP01_NAMED_VOID' => 214,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_NAMED' => 217,
			'OP01_CLOSE' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			"}" => 393,
			'OP23_LOGICAL_AND' => 218,
			'OP07_STRING_REPEAT' => 223,
			'WORD' => 222,
			'OP01_PRINT' => 200,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 201,
			'OP01_OPEN' => 203,
			'OP22_LOGICAL_NEG' => 208,
			'OP19_LOOP_CONTROL' => 211,
			'OP12_COMPARE_EQ_NE' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 213
		},
		GOTOS => {
			'OpStringOrWord' => 394,
			'HashEntryProperties' => 395
		}
	},
	{#State 360
		ACTIONS => {
			";" => 396
		}
	},
	{#State 361
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'TYPE_METHOD' => 397,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 362
		DEFAULT => -77
	},
	{#State 363
		DEFAULT => -76
	},
	{#State 364
		DEFAULT => -59
	},
	{#State 365
		ACTIONS => {
			")" => 398
		}
	},
	{#State 366
		DEFAULT => -82
	},
	{#State 367
		DEFAULT => -108
	},
	{#State 368
		DEFAULT => -242
	},
	{#State 369
		DEFAULT => -184
	},
	{#State 370
		ACTIONS => {
			";" => 399
		}
	},
	{#State 371
		DEFAULT => -241
	},
	{#State 372
		ACTIONS => {
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP04_MATH_POW' => 156,
			"]" => 400,
			'OP15_LOGICAL_AND' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 149,
			'OP11_COMPARE_LT_GT' => 146
		}
	},
	{#State 373
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 374
		ACTIONS => {
			'LPAREN' => 402
		}
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 376
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 405
		}
	},
	{#State 378
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 379
		DEFAULT => -189
	},
	{#State 380
		DEFAULT => -122
	},
	{#State 381
		DEFAULT => -180
	},
	{#State 382
		DEFAULT => -181
	},
	{#State 383
		DEFAULT => -182
	},
	{#State 384
		ACTIONS => {
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => 161,
			"}" => -206,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -206,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 146,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154
		}
	},
	{#State 385
		DEFAULT => -210
	},
	{#State 386
		ACTIONS => {
			'LITERAL_STRING' => 407
		}
	},
	{#State 387
		DEFAULT => -135
	},
	{#State 388
		ACTIONS => {
			'WORD_SCOPED' => 31,
			"foreach" => -153,
			"while" => -153,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_PRINT' => 116,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'OP05_LOGICAL_NEG' => 127,
			'OP01_NAMED_VOID_SCOLON' => 123,
			'OP01_NAMED_VOID_LPAREN' => 124,
			"if" => 132,
			'OP01_CLOSE' => 131,
			"\@{" => 129,
			"for" => -153,
			'OP01_NAMED_SCOLON' => 85,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 81,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_UPPERCASE' => 88,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			"%{" => 94,
			'MY' => 93,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED_VOID' => 102,
			'OP01_NAMED' => 103
		},
		GOTOS => {
			'VariableDeclaration' => 92,
			'HashDereference' => 119,
			'Conditional' => 90,
			'HashReference' => 91,
			'LoopLabel' => 87,
			'OperatorVoid' => 112,
			'Expression' => 113,
			'Operator' => 84,
			'Literal' => 86,
			'SubExpression' => 82,
			'Operation' => 408,
			'WordScoped' => 109,
			'PAREN-37' => 107,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 130,
			'PLUS-43' => 409,
			'Statement' => 128,
			'VariableModification' => 98,
			'ArrayDereference' => 122,
			'OPTIONAL-38' => 96
		}
	},
	{#State 389
		DEFAULT => -161,
		GOTOS => {
			'STAR-40' => 410
		}
	},
	{#State 390
		ACTIONS => {
			'MY' => 411
		}
	},
	{#State 391
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 392
		DEFAULT => -50
	},
	{#State 393
		ACTIONS => {
			";" => 413
		}
	},
	{#State 394
		ACTIONS => {
			'OP20_HASH_FATARROW' => 414
		}
	},
	{#State 395
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 415
		}
	},
	{#State 396
		DEFAULT => -61
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => 416
		}
	},
	{#State 398
		DEFAULT => -84
	},
	{#State 399
		DEFAULT => -243
	},
	{#State 400
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 401
		DEFAULT => -225
	},
	{#State 402
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_QW' => 185,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			'ARGV' => 182,
			'MY' => 174,
			"%{" => 94,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101
		},
		GOTOS => {
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'TypeInner' => 187,
			'Variable' => 143,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'ListElements' => 418,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 183,
			'ListElement' => 188
		}
	},
	{#State 403
		DEFAULT => -172
	},
	{#State 404
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 311,
			'WORD_SCOPED' => 31,
			'STDIN' => 312,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129
		},
		GOTOS => {
			'Variable' => 143,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'SubExpressionOrInput' => 419,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 310,
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84
		}
	},
	{#State 405
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100
		},
		GOTOS => {
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'SubExpression' => 420,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143
		}
	},
	{#State 406
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_SCOLON' => 424,
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'WORD' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 422,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			"%{" => 94
		},
		GOTOS => {
			'OpNamedScolonOrSubExp' => 421,
			'ArrayReference' => 104,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'SubExpression' => 423,
			'WordScoped' => 109,
			'ArrayDereference' => 122
		}
	},
	{#State 407
		ACTIONS => {
			'OP21_LIST_COMMA' => 425
		}
	},
	{#State 408
		DEFAULT => -175
	},
	{#State 409
		ACTIONS => {
			"for" => -153,
			'OP01_NAMED_SCOLON' => 85,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 81,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_UPPERCASE' => 88,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'MY' => 93,
			"%{" => 94,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED_VOID' => 102,
			'OP01_NAMED' => 103,
			'WORD_SCOPED' => 31,
			"foreach" => -153,
			"while" => -153,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_PRINT' => 116,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'OP05_LOGICAL_NEG' => 127,
			'OP01_NAMED_VOID_SCOLON' => 123,
			"}" => 426,
			'OP01_NAMED_VOID_LPAREN' => 124,
			"if" => 132,
			'OP01_CLOSE' => 131,
			"\@{" => 129
		},
		GOTOS => {
			'LoopLabel' => 87,
			'HashDereference' => 119,
			'Conditional' => 90,
			'HashReference' => 91,
			'VariableDeclaration' => 92,
			'PAREN-37' => 107,
			'WordScoped' => 109,
			'Operation' => 427,
			'SubExpression' => 82,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 113,
			'OperatorVoid' => 112,
			'Variable' => 130,
			'VariableSymbolOrSelf' => 106,
			'ArrayReference' => 104,
			'OPTIONAL-38' => 96,
			'ArrayDereference' => 122,
			'VariableModification' => 98,
			'Statement' => 128
		}
	},
	{#State 410
		ACTIONS => {
			'WORD' => -164,
			'OP05_BITWISE_NEG_LPAREN' => -164,
			'' => -164,
			'LBRACKET' => -164,
			'OP19_LOOP_CONTROL_SCOLON' => -164,
			"%{" => -164,
			'MY' => -164,
			'CONSTANT_CALL_SCOPED' => -164,
			'OP01_NAMED_VOID' => -164,
			'OP10_NAMED_UNARY' => -164,
			'VARIABLE_SYMBOL' => -164,
			'OP01_NAMED' => -164,
			"for" => -164,
			'OP01_NAMED_SCOLON' => -164,
			'OP19_LOOP_CONTROL' => -164,
			'LPAREN' => -164,
			"elsif" => 431,
			'OP22_LOGICAL_NEG' => -164,
			"else" => 429,
			'WORD_UPPERCASE' => -164,
			'OP10_NAMED_UNARY_SCOLON' => -164,
			'OP05_LOGICAL_NEG' => -164,
			'OP01_NAMED_VOID_SCOLON' => -164,
			"}" => -164,
			'OP01_NAMED_VOID_LPAREN' => -164,
			'OP01_CLOSE' => -164,
			"if" => -164,
			"\@{" => -164,
			'WORD_SCOPED' => -164,
			"foreach" => -164,
			"while" => -164,
			'SELF' => -164,
			'LITERAL_STRING' => -164,
			'OP05_MATH_NEG_LPAREN' => -164,
			'OP01_OPEN' => -164,
			'LITERAL_NUMBER' => -164,
			"undef" => -164,
			'OP01_PRINT' => -164,
			'OP03_MATH_INC_DEC' => -164,
			'LBRACE' => -164
		},
		GOTOS => {
			'PAREN-39' => 432,
			'OPTIONAL-42' => 430,
			'PAREN-41' => 428
		}
	},
	{#State 411
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 433
		}
	},
	{#State 412
		ACTIONS => {
			"\@ARG;" => 434
		}
	},
	{#State 413
		DEFAULT => -66
	},
	{#State 414
		ACTIONS => {
			'MY' => 436
		},
		GOTOS => {
			'TypeInnerProperties' => 435
		}
	},
	{#State 415
		ACTIONS => {
			"}" => 437,
			'OP21_LIST_COMMA' => 439
		},
		GOTOS => {
			'PAREN-25' => 438
		}
	},
	{#State 416
		ACTIONS => {
			"= sub {" => 440
		}
	},
	{#State 417
		ACTIONS => {
			"undef" => 441
		}
	},
	{#State 418
		ACTIONS => {
			")" => 442
		}
	},
	{#State 419
		ACTIONS => {
			")" => 443
		}
	},
	{#State 420
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 444,
			'OP11_COMPARE_LT_GT' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 445
		}
	},
	{#State 422
		DEFAULT => -239
	},
	{#State 423
		ACTIONS => {
			";" => 446,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 146,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP07_STRING_REPEAT' => 162,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 161
		}
	},
	{#State 424
		DEFAULT => -238
	},
	{#State 425
		ACTIONS => {
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			"%{" => 94
		},
		GOTOS => {
			'ArrayReference' => 104,
			'HashReference' => 91,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 143,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'SubExpression' => 447,
			'ArrayDereference' => 122,
			'WordScoped' => 109
		}
	},
	{#State 426
		DEFAULT => -176
	},
	{#State 427
		DEFAULT => -174
	},
	{#State 428
		DEFAULT => -163
	},
	{#State 429
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 448
		}
	},
	{#State 430
		DEFAULT => -165
	},
	{#State 431
		ACTIONS => {
			'LPAREN' => 449
		}
	},
	{#State 432
		DEFAULT => -160
	},
	{#State 433
		ACTIONS => {
			'VARIABLE_SYMBOL' => 450
		}
	},
	{#State 434
		DEFAULT => -52
	},
	{#State 435
		DEFAULT => -209
	},
	{#State 436
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 451
		}
	},
	{#State 437
		ACTIONS => {
			";" => 452
		}
	},
	{#State 438
		DEFAULT => -63
	},
	{#State 439
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP12_COMPARE_EQ_NE' => 204,
			'OP19_LOOP_CONTROL' => 211,
			'OP01_OPEN' => 203,
			'OP22_LOGICAL_NEG' => 208,
			'OP08_MATH_ADD_SUB' => 199,
			'OP01_PRINT' => 200,
			'OP11_COMPARE_LT_GT' => 201,
			'WORD' => 222,
			'OP07_STRING_REPEAT' => 223,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP01_CLOSE' => 206,
			'OP10_NAMED_UNARY' => 215,
			'OP01_NAMED_VOID' => 214,
			'OP01_NAMED' => 217,
			'OP24_LOGICAL_OR_XOR' => 216
		},
		GOTOS => {
			'OpStringOrWord' => 394,
			'HashEntryProperties' => 453
		}
	},
	{#State 440
		ACTIONS => {
			'LITERAL_STRING' => -68,
			'SELF' => -68,
			"while" => -68,
			'WORD_SCOPED' => -68,
			"foreach" => -68,
			'LBRACE' => -68,
			'OP01_PRINT' => -68,
			'OP03_MATH_INC_DEC' => -68,
			"undef" => -68,
			'LITERAL_NUMBER' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP01_OPEN' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			"}" => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			"\@{" => -68,
			'OP01_CLOSE' => -68,
			"if" => -68,
			'LPAREN' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED_SCOLON' => -68,
			"for" => -68,
			'WORD_UPPERCASE' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'LPAREN_MY' => 454,
			'MY' => -68,
			"%{" => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'LBRACKET' => -68,
			'OP05_BITWISE_NEG_LPAREN' => -68,
			'WORD' => -68,
			'OP01_NAMED' => -68,
			'OP01_NAMED_VOID' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP10_NAMED_UNARY' => -68,
			'CONSTANT_CALL_SCOPED' => -68
		},
		GOTOS => {
			'MethodArguments' => 456,
			'OPTIONAL-27' => 455
		}
	},
	{#State 441
		ACTIONS => {
			";" => 457
		}
	},
	{#State 442
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 458
		}
	},
	{#State 443
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 459
		}
	},
	{#State 444
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACKET' => 97,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			"%{" => 94,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 460,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'Variable' => 143,
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'ArrayReference' => 104
		}
	},
	{#State 445
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 461
		}
	},
	{#State 446
		DEFAULT => -240
	},
	{#State 447
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP07_STRING_REPEAT' => 162,
			'OP11_COMPARE_LT_GT' => 146,
			'OP17_LIST_RANGE' => 154,
			")" => -85,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			";" => -85,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP21_LIST_COMMA' => -85,
			"]" => -85,
			'OP04_MATH_POW' => 156
		}
	},
	{#State 448
		DEFAULT => -162
	},
	{#State 449
		ACTIONS => {
			'LPAREN' => 81,
			'SELF' => 108,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 118,
			"%{" => 94,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'LBRACKET' => 97,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 462,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'Variable' => 143
		}
	},
	{#State 450
		DEFAULT => -49
	},
	{#State 451
		ACTIONS => {
			"\$TYPED_" => 463
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
			'WORD_SCOPED' => 60,
			'WORD' => 61,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 464
		}
	},
	{#State 455
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 465
		}
	},
	{#State 456
		DEFAULT => -67
	},
	{#State 457
		DEFAULT => -185
	},
	{#State 458
		DEFAULT => -171
	},
	{#State 459
		DEFAULT => -173
	},
	{#State 460
		ACTIONS => {
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			")" => 466,
			'OP09_BITWISE_SHIFT' => 149,
			'OP08_MATH_ADD_SUB' => 147,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => -107,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP18_TERNARY' => -107,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => -107
		}
	},
	{#State 461
		ACTIONS => {
			"%{" => 94,
			'LBRACKET' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 422,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP01_CLOSE' => 131,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_SCOLON' => 424,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'OP03_MATH_INC_DEC' => 115,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 423,
			'Operator' => 84,
			'Expression' => 144,
			'Literal' => 86,
			'Variable' => 143,
			'ArrayReference' => 104,
			'OpNamedScolonOrSubExp' => 467,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91
		}
	},
	{#State 462
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP11_COMPARE_LT_GT' => 146,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 147,
			")" => 468,
			'OP09_BITWISE_SHIFT' => 149,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156
		}
	},
	{#State 463
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_NAMED' => 217,
			'OP10_NAMED_UNARY' => 215,
			'OP01_NAMED_VOID' => 214,
			'OP01_CLOSE' => 206,
			'OP23_LOGICAL_AND' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'WORD' => 222,
			'OP07_STRING_REPEAT' => 223,
			'OP11_COMPARE_LT_GT' => 201,
			'OP08_MATH_ADD_SUB' => 199,
			'OP01_PRINT' => 200,
			'OP22_LOGICAL_NEG' => 208,
			'OP01_OPEN' => 203,
			'OP19_LOOP_CONTROL' => 211,
			'OP12_COMPARE_EQ_NE' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 213
		},
		GOTOS => {
			'OpStringOrWord' => 469
		}
	},
	{#State 464
		ACTIONS => {
			'SELF' => 470
		}
	},
	{#State 465
		ACTIONS => {
			'OP01_PRINT' => 116,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			"while" => -153,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'WORD_SCOPED' => 31,
			"foreach" => -153,
			"\@{" => 129,
			"if" => 132,
			'OP01_CLOSE' => 131,
			'OP01_NAMED_VOID_LPAREN' => 124,
			"}" => 471,
			'OP01_NAMED_VOID_SCOLON' => 123,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 126,
			'WORD_UPPERCASE' => 88,
			'OP22_LOGICAL_NEG' => 89,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 81,
			'OP01_NAMED_SCOLON' => 85,
			"for" => -153,
			'OP01_NAMED' => 103,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			'OP01_NAMED_VOID' => 102,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			"%{" => 94,
			'MY' => 93,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97
		},
		GOTOS => {
			'Operator' => 84,
			'OperatorVoid' => 112,
			'Expression' => 113,
			'Literal' => 86,
			'SubExpression' => 82,
			'Operation' => 472,
			'PAREN-37' => 107,
			'WordScoped' => 109,
			'VariableDeclaration' => 92,
			'HashReference' => 91,
			'Conditional' => 90,
			'HashDereference' => 119,
			'LoopLabel' => 87,
			'Statement' => 128,
			'VariableModification' => 98,
			'ArrayDereference' => 122,
			'OPTIONAL-38' => 96,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 106,
			'Variable' => 130
		}
	},
	{#State 466
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 473
		}
	},
	{#State 467
		ACTIONS => {
			'SELF' => 108,
			'LPAREN' => 81,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 31,
			'OP03_MATH_INC_DEC' => 115,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 142,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 117,
			"undef" => 118,
			"%{" => 94,
			'WORD' => 30,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'LBRACKET' => 97,
			'VARIABLE_SYMBOL' => 100,
			'OP10_NAMED_UNARY' => 101,
			"\@{" => 129,
			'OP01_NAMED' => 167,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131
		},
		GOTOS => {
			'Variable' => 130,
			'VariableSymbolOrSelf' => 106,
			'HashDereference' => 119,
			'HashReference' => 91,
			'ArrayReference' => 104,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 474,
			'VariableModification' => 476,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'SubExpressionOrVarMod' => 475
		}
	},
	{#State 468
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 477
		}
	},
	{#State 469
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 478,
			'OP02_ARRAY_THINARROW' => 479
		}
	},
	{#State 470
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 480
		}
	},
	{#State 471
		ACTIONS => {
			";" => 481
		}
	},
	{#State 472
		DEFAULT => -69
	},
	{#State 473
		DEFAULT => -169
	},
	{#State 474
		ACTIONS => {
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 161,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 146,
			")" => -149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP08_MATH_ADD_SUB' => 147
		}
	},
	{#State 475
		ACTIONS => {
			")" => 482
		}
	},
	{#State 476
		DEFAULT => -150
	},
	{#State 477
		DEFAULT => -159
	},
	{#State 478
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'OP05_LOGICAL_NEG' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'WORD' => 30,
			'LBRACKET' => 97,
			"%{" => 94,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 120,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'LPAREN' => 81,
			'SELF' => 108
		},
		GOTOS => {
			'WordScoped' => 109,
			'ArrayDereference' => 122,
			'SubExpression' => 483,
			'Literal' => 86,
			'Operator' => 84,
			'Expression' => 144,
			'Variable' => 143,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayReference' => 104
		}
	},
	{#State 479
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 30,
			'LBRACKET' => 97,
			"%{" => 94,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_CLOSE' => 131,
			'OP01_NAMED' => 167,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 101,
			'VARIABLE_SYMBOL' => 100,
			'WORD_SCOPED' => 31,
			'LITERAL_STRING' => 111,
			'SELF' => 108,
			'LPAREN' => 81,
			'OP01_OPEN' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			"undef" => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_UPPERCASE' => 142,
			'LBRACE' => 114
		},
		GOTOS => {
			'Literal' => 86,
			'Expression' => 144,
			'Operator' => 84,
			'ArrayDereference' => 122,
			'WordScoped' => 109,
			'SubExpression' => 484,
			'VariableSymbolOrSelf' => 106,
			'HashReference' => 91,
			'HashDereference' => 119,
			'ArrayReference' => 104,
			'Variable' => 143
		}
	},
	{#State 480
		ACTIONS => {
			")" => 487,
			'OP21_LIST_COMMA' => 485
		},
		GOTOS => {
			'PAREN-29' => 486
		}
	},
	{#State 481
		DEFAULT => -71
	},
	{#State 482
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 488
		}
	},
	{#State 483
		ACTIONS => {
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 156,
			'OP21_LIST_COMMA' => -226,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP07_STRING_REPEAT' => 162,
			'OP23_LOGICAL_AND' => 161,
			"}" => -226,
			'OP08_STRING_CAT' => 160,
			'OP13_BITWISE_AND' => 153,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_BIND' => 158,
			'OP24_LOGICAL_OR_XOR' => 157
		}
	},
	{#State 484
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP12_COMPARE_EQ_NE' => 151,
			'OP15_LOGICAL_AND' => 152,
			"]" => 489,
			'OP04_MATH_POW' => 156,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 146,
			'OP08_MATH_ADD_SUB' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 162,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 161,
			'OP06_REGEX_BIND' => 158,
			'OP18_TERNARY' => 159,
			'OP24_LOGICAL_OR_XOR' => 157
		}
	},
	{#State 485
		ACTIONS => {
			'MY' => 490
		}
	},
	{#State 486
		DEFAULT => -73
	},
	{#State 487
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 491
		}
	},
	{#State 488
		DEFAULT => -170
	},
	{#State 489
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 490
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 493
		}
	},
	{#State 491
		ACTIONS => {
			"\@ARG;" => 494
		}
	},
	{#State 492
		ACTIONS => {
			"undef" => 495
		}
	},
	{#State 493
		ACTIONS => {
			'VARIABLE_SYMBOL' => 496
		}
	},
	{#State 494
		DEFAULT => -75
	},
	{#State 495
		DEFAULT => -227
	},
	{#State 496
		DEFAULT => -72
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7157 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7446 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7520 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7613 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_76
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7624 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_77
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7646 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7657 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7679 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7690 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7701 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7723 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7756 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7767 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7778 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7789 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7800 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7811 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7822 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7833 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7844 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7855 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7866 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7877 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7888 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7899 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7910 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7921 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7932 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7943 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7954 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7965 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7976 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7987 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7998 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8009 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8016 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8023 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8030 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8037 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8044 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8055 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8066 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8077 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8088 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8099 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8110 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8121 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8132 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8139 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8146 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8153 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8160 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8167 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8174 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8185 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8196 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8207 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8218 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_135
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8229 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8240 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8251 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8262 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8273 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8284 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8295 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8306 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8317 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_144
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8328 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_145
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8339 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_146
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8350 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_147
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8361 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_148
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8372 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_149
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8383 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_150
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8415 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8426 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8437 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8448 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8459 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8470 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8477 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8484 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8491 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8498 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8505 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8512 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_165
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8523 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8545 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_168
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_169
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8567 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_170
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8578 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_171
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8589 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_172
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8600 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_173
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8611 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8618 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8625 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_176
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8643 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8650 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_179
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8661 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_180
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8672 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_181
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8683 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8694 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8705 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_184
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8716 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8727 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8738 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8749 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8760 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8767 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8774 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8781 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8792 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8803 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8814 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8825 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_196
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8843 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8850 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_199
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8875 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_202
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8886 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_203
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8897 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8904 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8911 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8922 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_207
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8933 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8944 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_209
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8955 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8976 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_213
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8987 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_214
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8998 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9005 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9012 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_217
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9023 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_218
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9034 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9045 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_220
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9056 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_221
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9067 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9078 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9089 lib/RPerl/Grammar.pm
	],
	[#Rule Type_224
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9100 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_225
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9111 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_226
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9122 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_227
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9133 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_228
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9144 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_229
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9155 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_230
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9166 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_231
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9177 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_232
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9188 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_233
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9199 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_234
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9210 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_235
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9221 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_236
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9232 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_237
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9243 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_238
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9254 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_239
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9265 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_240
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9276 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_241
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9287 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_242
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9298 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_243
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9309 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9320 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9331 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9342 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9353 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9364 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9375 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9386 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9397 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9408 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9419 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9430 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9441 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9452 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9463 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9474 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_259
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9485 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_260
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9496 lib/RPerl/Grammar.pm
	]
],
#line 9499 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'Expression_134', 
         'Expression_135', 
         'Expression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpression_143', 
         'SubExpression_144', 
         'SubExpression_145', 
         'SubExpressionOrInput_146', 
         'SubExpressionOrInput_147', 
         'SubExpressionOrInput_148', 
         'SubExpressionOrVarMod_149', 
         'SubExpressionOrVarMod_150', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         'Statement_157', 
         'Statement_158', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_165', 
         'Loop_166', 
         'Loop_167', 
         'Loop_168', 
         'LoopFor_169', 
         'LoopFor_170', 
         'LoopForEach_171', 
         'LoopWhile_172', 
         'LoopWhile_173', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_176', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_179', 
         'VariableRetrieval_180', 
         'VariableRetrieval_181', 
         'VariableRetrieval_182', 
         'VariableDeclaration_183', 
         'VariableDeclaration_184', 
         'VariableDeclaration_185', 
         'VariableDeclaration_186', 
         'VariableModification_187', 
         'VariableModification_188', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_192', 
         'ListElement_193', 
         'ListElement_194', 
         'ListElement_195', 
         'ListElement_196', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_199', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_202', 
         'ArrayDereference_203', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_206', 
         'HashEntry_207', 
         'HashEntry_208', 
         'HashEntryProperties_209', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_213', 
         'HashReference_214', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_217', 
         'HashDereference_218', 
         'WordScoped_219', 
         'WordScoped_220', 
         'LoopLabel_221', 
         'Type_222', 
         'Type_223', 
         'Type_224', 
         'TypeInner_225', 
         'TypeInnerProperties_226', 
         'TypeInnerProperties_227', 
         'TypeInnerConstant_228', 
         'VariableOrLiteral_229', 
         'VariableOrLiteral_230', 
         'VarOrLitOrOpStrOrWord_231', 
         'VarOrLitOrOpStrOrWord_232', 
         'VarOrLitOrOpStrOrWord_233', 
         'VariableSymbolOrSelf_234', 
         'VariableSymbolOrSelf_235', 
         'Literal_236', 
         'Literal_237', 
         'OpNamedScolonOrSubExp_238', 
         'OpNamedScolonOrSubExp_239', 
         'OpNamedScolonOrSubExp_240', 
         'OpNamedScolonOrSubExpIn_241', 
         'OpNamedScolonOrSubExpIn_242', 
         'OpNamedScolonOrSubExpIn_243', 
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
         'OpStringOrWord_258', 
         'OpStringOrWord_259', 
         'OpStringOrWord_260', );
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
# 6.  Copy updates from Grammar.output file into this file with now-unique numbers, below this line only, if not-automatically-generated rules have been added
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
Expression_131 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_132 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_133 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_134 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_135 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_136 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-36 ')'
SubExpression_137 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_138 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_140 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_141 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_142 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_143 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_144 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_145 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_146 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_147 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_148 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_149 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_150 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_154 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_155 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_156 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_157 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_158 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_165 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_166 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_167 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_168 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_169 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_170 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_171 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_172 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_173 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_176 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_179 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_180 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_181 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_182 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_183 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_184 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_185 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_186 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_187 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_188 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_192 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_193 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_194 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_195 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_196 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_199 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_202 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_203 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_206 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_207 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_208 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_209 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_213 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_214 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_217 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_218 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_219 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_220 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_221 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_222 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_223 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_224 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_225 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_226 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_227 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_228 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_229 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_230 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_231 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_232 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_233 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_234 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_235 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_236 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_237 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_238 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_239 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_240 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_241 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_242 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_243 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_244 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_245 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_246 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_247 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_248 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_249 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_250 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_251 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_252 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_253 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_254 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_255 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_258 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_259 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_260 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 9971 lib/RPerl/Grammar.pm



1;
