########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
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
    our $VERSION = 0.003_800;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach|\$TYPED_|\=\ sub\ \{|package|while|undef|elsif|else|for|\@_\;|our|if|\@\{|\%\{|\]|\;|\)|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use|require)/gc and return ('USE_OR_REQUIRE', $1);
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
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
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


#line 143 lib/RPerl/Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@RPerl::Grammar::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
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
  [ 'Include_41' => 'Include', [ 'USE_OR_REQUIRE', 'WordScoped', ';' ], 0 ],
  [ 'Include_42' => 'Include', [ 'USE_OR_REQUIRE', 'WordScoped', 'OP01_QW', ';' ], 0 ],
  [ 'Constant_43' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [ 'STAR-18', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [  ], 0 ],
  [ 'Subroutine_48' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-17', 'STAR-18', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-20', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ 'Class_61' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-21', 'STAR-22', 'STAR-23', 'Properties', 'STAR-24', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'PAREN-25' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ 'Properties_65' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ 'Properties_67' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'Method_72' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-27', 'STAR-28', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'PAREN-29' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'MethodArguments_76' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-30', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_77' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_78' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_79' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_80' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_81' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_82' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'PAREN-31' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-32', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-33', ')', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_124' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_125' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_134' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_135' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_143' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_144' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_145' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_146' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_147' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_148' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_149' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_164' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_168' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_169' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_170' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_171' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_172' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_175' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_178' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_180' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_181' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_182' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_183' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_184' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_186' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_191' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_194' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_195' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_198' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_201' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_202' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_205' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_207' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_208' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_212' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_213' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_216' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_217' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_218' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_220' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_221' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_222' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_223' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_224' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_225' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_226' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_227' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_228' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_229' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_230' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_231' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_232' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_233' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_234' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_235' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_236' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_237' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_238' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_239' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_240' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_241' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_242' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_243' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_244' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_245' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_246' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_247' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_248' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_249' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_250' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_251' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_252' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_253' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_254' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_259' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'Properties_67' => 67,
  '_OPTIONAL' => 68,
  '_OPTIONAL' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  'Method_72' => 72,
  '_PAREN' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'MethodArguments_76' => 76,
  'MethodOrSubroutine_77' => 77,
  'MethodOrSubroutine_78' => 78,
  'Operation_79' => 79,
  'Operation_80' => 80,
  'Operation_81' => 81,
  'Operation_82' => 82,
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
  'Operator_112' => 112,
  '_PAREN' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  'OperatorVoid_124' => 124,
  'OperatorVoid_125' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'Expression_134' => 134,
  'Expression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpression_143' => 143,
  'SubExpression_144' => 144,
  'SubExpressionOrInput_145' => 145,
  'SubExpressionOrInput_146' => 146,
  'SubExpressionOrInput_147' => 147,
  'SubExpressionOrVarMod_148' => 148,
  'SubExpressionOrVarMod_149' => 149,
  '_PAREN' => 150,
  '_OPTIONAL' => 151,
  '_OPTIONAL' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  'Statement_157' => 157,
  '_PAREN' => 158,
  '_STAR_LIST' => 159,
  '_STAR_LIST' => 160,
  '_PAREN' => 161,
  '_OPTIONAL' => 162,
  '_OPTIONAL' => 163,
  'Conditional_164' => 164,
  'Loop_165' => 165,
  'Loop_166' => 166,
  'Loop_167' => 167,
  'LoopFor_168' => 168,
  'LoopFor_169' => 169,
  'LoopForEach_170' => 170,
  'LoopWhile_171' => 171,
  'LoopWhile_172' => 172,
  '_PLUS_LIST' => 173,
  '_PLUS_LIST' => 174,
  'CodeBlock_175' => 175,
  '_STAR_LIST' => 176,
  '_STAR_LIST' => 177,
  'Variable_178' => 178,
  'VariableRetrieval_179' => 179,
  'VariableRetrieval_180' => 180,
  'VariableRetrieval_181' => 181,
  'VariableDeclaration_182' => 182,
  'VariableDeclaration_183' => 183,
  'VariableDeclaration_184' => 184,
  'VariableDeclaration_185' => 185,
  'VariableModification_186' => 186,
  'VariableModification_187' => 187,
  '_PAREN' => 188,
  '_STAR_LIST' => 189,
  '_STAR_LIST' => 190,
  'ListElements_191' => 191,
  'ListElement_192' => 192,
  'ListElement_193' => 193,
  'ListElement_194' => 194,
  'ListElement_195' => 195,
  '_OPTIONAL' => 196,
  '_OPTIONAL' => 197,
  'ArrayReference_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'ArrayDereference_201' => 201,
  'ArrayDereference_202' => 202,
  '_OPTIONAL' => 203,
  '_OPTIONAL' => 204,
  'HashEntry_205' => 205,
  'HashEntry_206' => 206,
  'HashEntry_207' => 207,
  'HashEntryProperties_208' => 208,
  '_PAREN' => 209,
  '_STAR_LIST' => 210,
  '_STAR_LIST' => 211,
  'HashReference_212' => 212,
  'HashReference_213' => 213,
  '_OPTIONAL' => 214,
  '_OPTIONAL' => 215,
  'HashDereference_216' => 216,
  'HashDereference_217' => 217,
  'WordScoped_218' => 218,
  'WordScoped_219' => 219,
  'LoopLabel_220' => 220,
  'Type_221' => 221,
  'Type_222' => 222,
  'Type_223' => 223,
  'TypeInner_224' => 224,
  'TypeInnerProperties_225' => 225,
  'TypeInnerProperties_226' => 226,
  'TypeInnerConstant_227' => 227,
  'VariableOrLiteral_228' => 228,
  'VariableOrLiteral_229' => 229,
  'VarOrLitOrOpStrOrWord_230' => 230,
  'VarOrLitOrOpStrOrWord_231' => 231,
  'VarOrLitOrOpStrOrWord_232' => 232,
  'VariableSymbolOrSelf_233' => 233,
  'VariableSymbolOrSelf_234' => 234,
  'Literal_235' => 235,
  'Literal_236' => 236,
  'OpNamedScolonOrSubExp_237' => 237,
  'OpNamedScolonOrSubExp_238' => 238,
  'OpNamedScolonOrSubExp_239' => 239,
  'OpNamedScolonOrSubExpIn_240' => 240,
  'OpNamedScolonOrSubExpIn_241' => 241,
  'OpNamedScolonOrSubExpIn_242' => 242,
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
  'OpStringOrWord_259' => 259,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
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
	OP06_REGEX_MATCH => { ISSEMANTIC => 1 },
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
	USE_OR_REQUIRE => { ISSEMANTIC => 1 },
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
			"package" => -20,
			'USE_RPERL' => -20,
			'SHEBANG' => 5,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'CompileUnit' => 9,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 3,
			'Program' => 7,
			'PLUS-2' => 6,
			'Critic' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-16' => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"use parent qw(" => 14,
			"## no critic qw(" => -27,
			"our" => -27,
			"use constant" => -27,
			'USE_OR_REQUIRE' => -27
		},
		GOTOS => {
			'STAR-11' => 16,
			'Class' => 15,
			'Package' => 13,
			'Module' => 12
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 17,
			'Critic' => 18
		}
	},
	{#State 6
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 1,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'Critic' => 2,
			'PAREN-1' => 19,
			'OPTIONAL-9' => 8
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 21
		},
		GOTOS => {
			'OPTIONAL-10' => 20
		}
	},
	{#State 9
		ACTIONS => {
			'' => 22
		}
	},
	{#State 10
		ACTIONS => {
			")" => 23,
			'WORD' => 24
		}
	},
	{#State 11
		DEFAULT => -39
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		DEFAULT => -24
	},
	{#State 14
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 15
		DEFAULT => -25
	},
	{#State 16
		ACTIONS => {
			'USE_OR_REQUIRE' => -29,
			"## no critic qw(" => 1,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 28,
			'Critic' => 29
		}
	},
	{#State 17
		ACTIONS => {
			'USE_RPERL' => 30
		}
	},
	{#State 18
		DEFAULT => -6
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		ACTIONS => {
			"package" => 31
		}
	},
	{#State 21
		DEFAULT => -21
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		DEFAULT => -40
	},
	{#State 24
		DEFAULT => -38
	},
	{#State 25
		ACTIONS => {
			")" => 32
		}
	},
	{#State 26
		DEFAULT => -218
	},
	{#State 27
		DEFAULT => -219
	},
	{#State 28
		ACTIONS => {
			'USE_OR_REQUIRE' => 34,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 33
		}
	},
	{#State 29
		DEFAULT => -26
	},
	{#State 30
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 31
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		DEFAULT => -28
	},
	{#State 34
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 42,
			"our" => 45
		},
		GOTOS => {
			'PLUS-14' => 41,
			'Constant' => 43,
			'Subroutine' => 44
		}
	},
	{#State 36
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'USE_OR_REQUIRE' => 34
		},
		GOTOS => {
			'Include' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 51,
			";" => 50
		}
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 52,
			"our" => 45
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'WORD_UPPERCASE' => 54
		}
	},
	{#State 43
		DEFAULT => -30
	},
	{#State 44
		DEFAULT => -33
	},
	{#State 45
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 57,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 46
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LBRACKET' => -11,
			'OP01_OPEN' => -11,
			'SELF' => -11,
			"use constant" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LPAREN' => -11,
			'LBRACE' => -11,
			"## no critic qw(" => 1,
			'CONSTANT_CALL_SCOPED' => -11,
			'MY' => -11,
			"our" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'USE_OR_REQUIRE' => -11,
			'OP01_PRINT' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'VARIABLE_SYMBOL' => -11,
			"for" => -11,
			"%{" => -11,
			'WORD' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			"undef" => -11,
			'OP01_CLOSE' => -11,
			"\@{" => -11,
			"if" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"while" => -11,
			"foreach" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'WORD_SCOPED' => -11
		},
		GOTOS => {
			'STAR-5' => 59,
			'Critic' => 60
		}
	},
	{#State 47
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 62
		},
		GOTOS => {
			'OPTIONAL-15' => 61
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 64
		}
	},
	{#State 50
		DEFAULT => -41
	},
	{#State 51
		ACTIONS => {
			";" => 65
		}
	},
	{#State 52
		ACTIONS => {
			";" => 66
		}
	},
	{#State 53
		DEFAULT => -32
	},
	{#State 54
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 56
		DEFAULT => -222
	},
	{#State 57
		DEFAULT => -221
	},
	{#State 58
		DEFAULT => -223
	},
	{#State 59
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LPAREN' => -13,
			'MY' => -13,
			"our" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use constant" => -13,
			'OP01_OPEN' => -13,
			'LBRACKET' => -13,
			'SELF' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LITERAL_NUMBER' => -13,
			"while" => -13,
			"if" => -13,
			"\@{" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_UPPERCASE' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_STRING' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'USE_OR_REQUIRE' => 34,
			'OP01_NAMED_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'WORD' => -13,
			"undef" => -13,
			"%{" => -13,
			"for" => -13,
			'OP01_CLOSE' => -13
		},
		GOTOS => {
			'STAR-6' => 69,
			'Include' => 70
		}
	},
	{#State 60
		DEFAULT => -8
	},
	{#State 61
		ACTIONS => {
			"our" => 71
		}
	},
	{#State 62
		DEFAULT => -35
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		ACTIONS => {
			"use constant" => -56,
			"## no critic qw(" => 1,
			'USE_OR_REQUIRE' => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 73,
			'Critic' => 72
		}
	},
	{#State 65
		DEFAULT => -42
	},
	{#State 66
		DEFAULT => -34
	},
	{#State 67
		ACTIONS => {
			'MY' => 74
		},
		GOTOS => {
			'TypeInnerConstant' => 75
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 76
		}
	},
	{#State 69
		ACTIONS => {
			"our" => -15,
			'MY' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			"use constant" => 42,
			'OP01_OPEN' => -15,
			'LBRACKET' => -15,
			'SELF' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_STRING' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID' => -15,
			"while" => -15,
			"\@{" => -15,
			"if" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'WORD' => -15,
			"undef" => -15,
			"for" => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED_SCOLON' => -15
		},
		GOTOS => {
			'STAR-7' => 77,
			'Constant' => 78
		}
	},
	{#State 70
		DEFAULT => -10
	},
	{#State 71
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 79
		}
	},
	{#State 72
		DEFAULT => -53
	},
	{#State 73
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE_OR_REQUIRE' => 34,
			"use constant" => -58
		},
		GOTOS => {
			'Include' => 80,
			'STAR-23' => 81
		}
	},
	{#State 74
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'TYPE_INTEGER' => 58,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 82
		}
	},
	{#State 75
		ACTIONS => {
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Literal' => 85
		}
	},
	{#State 76
		ACTIONS => {
			"while" => -45,
			"if" => -45,
			"\@{" => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			"foreach" => -45,
			'OP01_NAMED_VOID' => -45,
			'WORD_UPPERCASE' => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'WORD_SCOPED' => -45,
			'LITERAL_STRING' => -45,
			'OP01_NAMED' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP01_PRINT' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'WORD' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			"undef" => -45,
			"for" => -45,
			"%{" => -45,
			'OP01_CLOSE' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LPAREN_MY' => 86,
			'LPAREN' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'MY' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'LBRACE' => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP01_OPEN' => -45,
			'LBRACKET' => -45,
			'SELF' => -45,
			"}" => -45,
			'OP22_LOGICAL_NEG' => -45,
			'LITERAL_NUMBER' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 88,
			'OPTIONAL-17' => 87
		}
	},
	{#State 77
		ACTIONS => {
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			'OP01_NAMED_SCOLON' => 107,
			'OP01_CLOSE' => 111,
			"for" => -152,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 89,
			"foreach" => -152,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"if" => 92,
			"\@{" => 93,
			"while" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'OP01_NAMED' => 96,
			'LITERAL_STRING' => 83,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'WORD_UPPERCASE' => 100,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP19_LOOP_CONTROL' => 132,
			'OP10_NAMED_UNARY' => 133,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP01_NAMED_VOID_SCOLON' => 121,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			"our" => 45,
			'MY' => 124,
			'LPAREN' => 127
		},
		GOTOS => {
			'Subroutine' => 137,
			'Operator' => 112,
			'PAREN-36' => 136,
			'Conditional' => 109,
			'PLUS-8' => 110,
			'LoopLabel' => 139,
			'ArrayDereference' => 138,
			'OperatorVoid' => 104,
			'Literal' => 106,
			'Expression' => 101,
			'OPTIONAL-37' => 131,
			'VariableModification' => 108,
			'Statement' => 134,
			'Variable' => 98,
			'VariableSymbolOrSelf' => 123,
			'Operation' => 120,
			'VariableDeclaration' => 119,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 90,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 78
		DEFAULT => -12
	},
	{#State 79
		DEFAULT => -37
	},
	{#State 80
		DEFAULT => -55
	},
	{#State 81
		ACTIONS => {
			"use constant" => 42,
			"our hashref \$properties" => 140
		},
		GOTOS => {
			'Properties' => 141,
			'Constant' => 142
		}
	},
	{#State 82
		ACTIONS => {
			"\$TYPED_" => 143
		}
	},
	{#State 83
		DEFAULT => -236
	},
	{#State 84
		DEFAULT => -235
	},
	{#State 85
		ACTIONS => {
			";" => 144
		}
	},
	{#State 86
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 145
		}
	},
	{#State 87
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 146
		}
	},
	{#State 88
		DEFAULT => -44
	},
	{#State 89
		ACTIONS => {
			'OP01_QW' => 157,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'ARGV' => 148,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Variable' => 152,
			'Operator' => 112,
			'ListElements' => 155,
			'VariableSymbolOrSelf' => 123,
			'ListElement' => 147,
			'ArrayDereference' => 138,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'ArrayReference' => 95,
			'TypeInner' => 149
		}
	},
	{#State 90
		ACTIONS => {
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164
		}
	},
	{#State 91
		DEFAULT => -143
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 175
		}
	},
	{#State 93
		ACTIONS => {
			'SELF' => 130,
			'LBRACKET' => -200,
			'VARIABLE_SYMBOL' => 103,
			'MY' => 156
		},
		GOTOS => {
			'TypeInner' => 178,
			'OPTIONAL-47' => 176,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 177
		}
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 156,
			")" => -117,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'OP01_QW' => 157,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'ARGV' => 148,
			"%{" => 113,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'ArrayReference' => 95,
			'TypeInner' => 149,
			'OPTIONAL-33' => 179,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'SubExpression' => 154,
			'WordScoped' => 118,
			'HashReference' => 116,
			'ListElement' => 147,
			'ArrayDereference' => 138,
			'Operator' => 112,
			'ListElements' => 180,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 95
		DEFAULT => -140
	},
	{#State 96
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'OP01_QW' => 157,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'ARGV' => 148,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 182,
			'WordScoped' => 118,
			'SubExpression' => 181,
			'HashReference' => 116,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'TypeInner' => 149,
			'ArrayReference' => 95
		}
	},
	{#State 97
		DEFAULT => -124
	},
	{#State 98
		ACTIONS => {
			'OP13_BITWISE_AND' => -139,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP03_MATH_INC_DEC' => 184,
			")" => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP17_LIST_RANGE' => -139,
			'OP11_COMPARE_LT_GT' => -139,
			'OP08_MATH_ADD_SUB' => -139,
			'OP07_MATH_MULT_DIV_MOD' => -139,
			'OP02_METHOD_THINARROW' => 183,
			'OP18_TERNARY' => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			'OP15_LOGICAL_AND' => -139,
			'OP09_BITWISE_SHIFT' => -139,
			'OP19_VARIABLE_ASSIGN_BY' => 186,
			'OP08_STRING_CAT' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			'OP04_MATH_POW' => -139,
			'OP16_LOGICAL_OR' => -139,
			'OP19_VARIABLE_ASSIGN' => 185,
			'OP07_STRING_REPEAT' => -139
		}
	},
	{#State 99
		DEFAULT => -81
	},
	{#State 100
		ACTIONS => {
			'COLON' => -220,
			'LPAREN' => 187
		}
	},
	{#State 101
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP13_BITWISE_AND' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP18_TERNARY' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP08_STRING_CAT' => -136,
			";" => 188,
			'OP09_BITWISE_SHIFT' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP16_LOGICAL_OR' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP04_MATH_POW' => -136
		}
	},
	{#State 102
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 95,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 189,
			'HashReference' => 116
		}
	},
	{#State 103
		DEFAULT => -233
	},
	{#State 104
		DEFAULT => -155
	},
	{#State 105
		ACTIONS => {
			'ARGV' => -115,
			"%{" => -115,
			'OP05_BITWISE_NEG_LPAREN' => -115,
			'WORD' => -115,
			"undef" => -115,
			'OP22_LOGICAL_NEG' => -115,
			'LITERAL_NUMBER' => -115,
			'OP01_CLOSE' => -115,
			'OP10_NAMED_UNARY' => -115,
			'STDOUT_STDERR' => 191,
			'LBRACKET' => -115,
			'OP01_OPEN' => -115,
			'SELF' => -115,
			'VARIABLE_SYMBOL' => -115,
			'OP05_LOGICAL_NEG' => -115,
			'WORD_UPPERCASE' => -115,
			'LPAREN' => -115,
			'OP01_NAMED' => -115,
			'LITERAL_STRING' => -115,
			'LBRACE' => -115,
			'MY' => -115,
			'CONSTANT_CALL_SCOPED' => -115,
			'OP03_MATH_INC_DEC' => -115,
			'WORD_SCOPED' => -115,
			"\@{" => -115,
			'OP01_QW' => -115,
			'FHREF_SYMBOL_BRACES' => 193,
			'OP05_MATH_NEG_LPAREN' => -115
		},
		GOTOS => {
			'PAREN-31' => 190,
			'OPTIONAL-32' => 192
		}
	},
	{#State 106
		DEFAULT => -138
	},
	{#State 107
		DEFAULT => -80
	},
	{#State 108
		ACTIONS => {
			";" => 194
		}
	},
	{#State 109
		DEFAULT => -153
	},
	{#State 110
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 113,
			"for" => -152,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'VARIABLE_SYMBOL' => 103,
			'OP01_PRINT' => 105,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_NAMED_SCOLON' => 107,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'' => -18,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'WORD_UPPERCASE' => 100,
			"foreach" => -152,
			'OP01_NAMED_VOID' => 89,
			"if" => 92,
			"\@{" => 93,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"while" => -152,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP19_LOOP_CONTROL' => 132,
			'OP10_NAMED_UNARY' => 133,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 124,
			'OP03_MATH_INC_DEC' => 126,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP01_NAMED_VOID_SCOLON' => 121
		},
		GOTOS => {
			'VariableModification' => 108,
			'Statement' => 134,
			'OPTIONAL-37' => 131,
			'Expression' => 101,
			'Literal' => 106,
			'OperatorVoid' => 104,
			'LoopLabel' => 139,
			'ArrayDereference' => 138,
			'Operator' => 112,
			'PAREN-36' => 136,
			'Conditional' => 109,
			'ArrayReference' => 95,
			'VariableDeclaration' => 119,
			'HashDereference' => 91,
			'Operation' => 195,
			'HashReference' => 116,
			'SubExpression' => 90,
			'WordScoped' => 118,
			'Variable' => 98,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 111
		ACTIONS => {
			'FHREF_SYMBOL' => 196
		}
	},
	{#State 112
		DEFAULT => -130
	},
	{#State 113
		ACTIONS => {
			'LBRACE' => -215,
			'SELF' => 130,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 198,
			'TypeInner' => 199,
			'OPTIONAL-51' => 197
		}
	},
	{#State 114
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83
		},
		GOTOS => {
			'Variable' => 152,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 200,
			'ArrayReference' => 95
		}
	},
	{#State 115
		DEFAULT => -137
	},
	{#State 116
		DEFAULT => -142
	},
	{#State 117
		ACTIONS => {
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayDereference' => 138,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 201,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayReference' => 95
		}
	},
	{#State 118
		ACTIONS => {
			'LPAREN' => 202,
			'OP02_METHOD_THINARROW_NEW' => 203
		}
	},
	{#State 119
		DEFAULT => -156
	},
	{#State 120
		DEFAULT => -17
	},
	{#State 121
		DEFAULT => -120
	},
	{#State 122
		ACTIONS => {
			'OP01_NAMED_VOID' => 218,
			'OP08_MATH_ADD_SUB' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP11_COMPARE_LT_GT' => 216,
			'OP23_LOGICAL_AND' => 204,
			'OP01_NAMED' => 222,
			'LITERAL_STRING' => 83,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'ENV' => 206,
			'OP24_LOGICAL_OR_XOR' => 219,
			'OP01_OPEN' => 211,
			'OP07_STRING_REPEAT' => 210,
			'SELF' => 130,
			'OP01_PRINT' => 224,
			'VARIABLE_SYMBOL' => 103,
			'OP19_LOOP_CONTROL' => 209,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP10_NAMED_UNARY' => 208,
			'OP22_LOGICAL_NEG' => 214,
			'LITERAL_NUMBER' => 84,
			"}" => 213,
			'OP01_CLOSE' => 228,
			"%{" => 113,
			'WORD' => 227
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 212,
			'HashEntry' => 226,
			'Variable' => 220,
			'HashDereference' => 217,
			'Literal' => 225,
			'OpStringOrWord' => 207,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 123
		DEFAULT => -177,
		GOTOS => {
			'STAR-43' => 229
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'TYPE_FHREF' => 230,
			'WORD' => 57,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 231
		}
	},
	{#State 125
		DEFAULT => -132
	},
	{#State 126
		ACTIONS => {
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 232
		}
	},
	{#State 127
		ACTIONS => {
			'VARIABLE_SYMBOL' => 103,
			'OP01_PRINT' => 233,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP10_NAMED_UNARY' => 133,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'OP01_NAMED' => 234,
			'LITERAL_STRING' => 83,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayDereference' => 138,
			'HashReference' => 116,
			'SubExpression' => 235,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayReference' => 95
		}
	},
	{#State 128
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'ARGV' => 148,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			"]" => -197,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'ListElements' => 237,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ListElement' => 147,
			'ArrayDereference' => 138,
			'OPTIONAL-46' => 236,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'TypeInner' => 149
		}
	},
	{#State 129
		ACTIONS => {
			'MY' => 238
		}
	},
	{#State 130
		DEFAULT => -234
	},
	{#State 131
		ACTIONS => {
			"while" => 240,
			"for" => 241,
			"foreach" => 239
		},
		GOTOS => {
			'LoopWhile' => 243,
			'Loop' => 245,
			'LoopForEach' => 242,
			'LoopFor' => 244
		}
	},
	{#State 132
		ACTIONS => {
			'WORD_UPPERCASE' => 247
		},
		GOTOS => {
			'LoopLabel' => 246
		}
	},
	{#State 133
		ACTIONS => {
			'OP13_BITWISE_AND' => -101,
			'WORD_UPPERCASE' => 151,
			'OP24_LOGICAL_OR_XOR' => -101,
			'WORD_SCOPED' => 27,
			")" => -101,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			"\@{" => 93,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'LPAREN' => 127,
			"]" => -101,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'OP21_LIST_COMMA' => -101,
			'OP06_REGEX_MATCH' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP18_TERNARY' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			";" => -101,
			"}" => -101,
			'OP22_LOGICAL_NEG' => 135,
			'OP08_STRING_CAT' => -101,
			'LITERAL_NUMBER' => 84,
			'OP04_MATH_POW' => -101,
			'OP10_NAMED_UNARY' => 133,
			'OP16_LOGICAL_OR' => -101,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP07_STRING_REPEAT' => -101,
			'SELF' => 130
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 248,
			'WordScoped' => 118,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106
		}
	},
	{#State 134
		DEFAULT => -82
	},
	{#State 135
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'SubExpression' => 249,
			'WordScoped' => 118,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 136
		DEFAULT => -151
	},
	{#State 137
		DEFAULT => -14
	},
	{#State 138
		DEFAULT => -141
	},
	{#State 139
		ACTIONS => {
			'COLON' => 250
		}
	},
	{#State 140
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 251
		}
	},
	{#State 141
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 252
		}
	},
	{#State 142
		DEFAULT => -57
	},
	{#State 143
		ACTIONS => {
			'WORD_UPPERCASE' => 253
		}
	},
	{#State 144
		DEFAULT => -43
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 254
		}
	},
	{#State 146
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 132,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"}" => 255,
			'OP01_NAMED_VOID_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 126,
			'MY' => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED_SCOLON' => 107,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP01_PRINT' => 105,
			"%{" => 113,
			"for" => -152,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'OP01_CLOSE' => 111,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"\@{" => 93,
			"if" => 92,
			"while" => -152,
			'OP01_NAMED_VOID' => 89,
			"foreach" => -152,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'WORD_UPPERCASE' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 96,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'OperatorVoid' => 104,
			'Literal' => 106,
			'OPTIONAL-37' => 131,
			'Expression' => 101,
			'Statement' => 134,
			'VariableModification' => 108,
			'Conditional' => 109,
			'PAREN-36' => 136,
			'Operator' => 112,
			'ArrayDereference' => 138,
			'LoopLabel' => 139,
			'SubExpression' => 90,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Operation' => 256,
			'VariableDeclaration' => 119,
			'HashDereference' => 91,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 98
		}
	},
	{#State 147
		DEFAULT => -190,
		GOTOS => {
			'STAR-45' => 257
		}
	},
	{#State 148
		DEFAULT => -195
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 133
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 258,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106
		}
	},
	{#State 150
		DEFAULT => -136
	},
	{#State 151
		ACTIONS => {
			'LPAREN' => 187
		}
	},
	{#State 152
		ACTIONS => {
			'OP15_LOGICAL_AND' => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			'OP18_TERNARY' => -139,
			'OP02_METHOD_THINARROW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => -139,
			'OP11_COMPARE_LT_GT' => -139,
			'OP08_MATH_ADD_SUB' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP17_LIST_RANGE' => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP21_LIST_COMMA' => -139,
			'OP03_MATH_INC_DEC' => 184,
			")" => -139,
			"]" => -139,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP13_BITWISE_AND' => -139,
			'OP07_STRING_REPEAT' => -139,
			'OP16_LOGICAL_OR' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			'OP04_MATH_POW' => -139,
			'OP08_STRING_CAT' => -139,
			"}" => -139,
			";" => -139,
			'OP09_BITWISE_SHIFT' => -139
		}
	},
	{#State 153
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Variable' => 152,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 95,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 259
		}
	},
	{#State 154
		ACTIONS => {
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP21_LIST_COMMA' => -192,
			")" => -192,
			"]" => -192,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 167,
			";" => -192,
			'OP09_BITWISE_SHIFT' => 168
		}
	},
	{#State 155
		ACTIONS => {
			";" => 260
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 261
		}
	},
	{#State 157
		DEFAULT => -194
	},
	{#State 158
		ACTIONS => {
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 84,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'VariableOrLiteral' => 264,
			'Variable' => 262,
			'Literal' => 263
		}
	},
	{#State 159
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 265,
			'WordScoped' => 118,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 266,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 161
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 267
		}
	},
	{#State 162
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'SubExpression' => 268,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayReference' => 95
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133
		},
		GOTOS => {
			'ArrayReference' => 95,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 269,
			'HashReference' => 116,
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 164
		ACTIONS => {
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117
		},
		GOTOS => {
			'SubExpression' => 270,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138
		}
	},
	{#State 165
		ACTIONS => {
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP10_NAMED_UNARY' => 133,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'WordScoped' => 118,
			'SubExpression' => 271,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayReference' => 95
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 133,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106,
			'HashReference' => 116,
			'SubExpression' => 272,
			'WordScoped' => 118,
			'ArrayDereference' => 138,
			'Variable' => 152,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 167
		ACTIONS => {
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP10_NAMED_UNARY' => 133,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 273,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 168
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126
		},
		GOTOS => {
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 274,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 169
		ACTIONS => {
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 133,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'ArrayReference' => 95,
			'SubExpression' => 275,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152
		}
	},
	{#State 170
		ACTIONS => {
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117
		},
		GOTOS => {
			'ArrayReference' => 95,
			'WordScoped' => 118,
			'SubExpression' => 276,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152
		}
	},
	{#State 171
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashDereference' => 91,
			'Expression' => 150,
			'Literal' => 106,
			'HashReference' => 116,
			'SubExpression' => 277,
			'WordScoped' => 118,
			'ArrayDereference' => 138,
			'Variable' => 152,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 172
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP10_NAMED_UNARY' => 133,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'SubExpression' => 278,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'ArrayReference' => 95
		}
	},
	{#State 173
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP10_NAMED_UNARY' => 133,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 95,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'WordScoped' => 118,
			'SubExpression' => 279,
			'HashReference' => 116
		}
	},
	{#State 174
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayReference' => 95,
			'SubExpression' => 280,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 133,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'SubExpression' => 281,
			'WordScoped' => 118,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 176
		ACTIONS => {
			'LBRACKET' => 128
		},
		GOTOS => {
			'ArrayReference' => 282
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 283
		}
	},
	{#State 178
		DEFAULT => -199
	},
	{#State 179
		ACTIONS => {
			")" => 284
		}
	},
	{#State 180
		DEFAULT => -116
	},
	{#State 181
		ACTIONS => {
			'OP08_STRING_CAT' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			";" => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			'OP04_MATH_POW' => -84,
			")" => -84,
			'OP21_LIST_COMMA' => -192,
			'OP13_BITWISE_AND' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP18_TERNARY' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP23_LOGICAL_AND' => -84
		}
	},
	{#State 182
		ACTIONS => {
			'OP21_LIST_COMMA' => 285
		}
	},
	{#State 183
		ACTIONS => {
			'LPAREN' => 286
		}
	},
	{#State 184
		DEFAULT => -89
	},
	{#State 185
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'FHREF_SYMBOL_IN' => 287,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'STDIN' => 290,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayReference' => 95,
			'SubExpression' => 288,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'SubExpressionOrInput' => 289
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayReference' => 95,
			'WordScoped' => 118,
			'SubExpression' => 291,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91
		}
	},
	{#State 187
		ACTIONS => {
			")" => 292
		}
	},
	{#State 188
		DEFAULT => -79
	},
	{#State 189
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_STRING_REPEAT' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			";" => -92,
			"}" => -92,
			'OP08_STRING_CAT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			"]" => -92,
			")" => -92,
			'OP21_LIST_COMMA' => -92
		}
	},
	{#State 190
		DEFAULT => -114
	},
	{#State 191
		DEFAULT => -113
	},
	{#State 192
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			'ARGV' => 148,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'ListElements' => 293,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 147,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'TypeInner' => 149,
			'ArrayReference' => 95
		}
	},
	{#State 193
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 156,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'OP01_QW' => 157,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'ARGV' => 148,
			"%{" => 113,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'ListElement' => 147,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'ListElements' => 294,
			'Variable' => 152,
			'TypeInner' => 149,
			'ArrayReference' => 95,
			'SubExpression' => 154,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91
		}
	},
	{#State 194
		DEFAULT => -157
	},
	{#State 195
		DEFAULT => -16
	},
	{#State 196
		DEFAULT => -87
	},
	{#State 197
		ACTIONS => {
			'LBRACE' => 122
		},
		GOTOS => {
			'HashReference' => 295
		}
	},
	{#State 198
		ACTIONS => {
			"}" => 296
		}
	},
	{#State 199
		DEFAULT => -214
	},
	{#State 200
		ACTIONS => {
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP06_REGEX_MATCH' => 161,
			'OP15_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			")" => 297,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 201
		ACTIONS => {
			")" => 298,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174
		}
	},
	{#State 202
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			")" => -127,
			'WORD_SCOPED' => 27,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"%{" => 113,
			'ARGV' => 148,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128
		},
		GOTOS => {
			'TypeInner' => 149,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 154,
			'WordScoped' => 118,
			'HashDereference' => 91,
			'Expression' => 150,
			'OPTIONAL-34' => 300,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'ListElement' => 147,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ListElements' => 299
		}
	},
	{#State 203
		ACTIONS => {
			")" => 301
		}
	},
	{#State 204
		DEFAULT => -244
	},
	{#State 205
		DEFAULT => -251
	},
	{#State 206
		DEFAULT => -207
	},
	{#State 207
		DEFAULT => -232
	},
	{#State 208
		DEFAULT => -250
	},
	{#State 209
		DEFAULT => -247
	},
	{#State 210
		DEFAULT => -253
	},
	{#State 211
		DEFAULT => -256
	},
	{#State 212
		ACTIONS => {
			'OP20_HASH_FATARROW' => 302
		}
	},
	{#State 213
		DEFAULT => -213
	},
	{#State 214
		DEFAULT => -245
	},
	{#State 215
		DEFAULT => -252
	},
	{#State 216
		DEFAULT => -249
	},
	{#State 217
		DEFAULT => -206
	},
	{#State 218
		DEFAULT => -257
	},
	{#State 219
		DEFAULT => -243
	},
	{#State 220
		DEFAULT => -230
	},
	{#State 221
		DEFAULT => -246
	},
	{#State 222
		DEFAULT => -254
	},
	{#State 223
		DEFAULT => -248
	},
	{#State 224
		DEFAULT => -258
	},
	{#State 225
		DEFAULT => -231
	},
	{#State 226
		DEFAULT => -211,
		GOTOS => {
			'STAR-50' => 303
		}
	},
	{#State 227
		DEFAULT => -259
	},
	{#State 228
		DEFAULT => -255
	},
	{#State 229
		ACTIONS => {
			'OP08_STRING_CAT' => -178,
			'OP02_ARRAY_THINARROW' => 304,
			"}" => -178,
			";" => -178,
			'OP09_BITWISE_SHIFT' => -178,
			'OP19_VARIABLE_ASSIGN_BY' => -178,
			'OP07_STRING_REPEAT' => -178,
			'OP20_HASH_FATARROW' => -178,
			'OP16_LOGICAL_OR' => -178,
			'OP19_VARIABLE_ASSIGN' => -178,
			'OP12_COMPARE_EQ_NE' => -178,
			'OP02_HASH_THINARROW' => 306,
			'OP04_MATH_POW' => -178,
			'OP21_LIST_COMMA' => -178,
			")" => -178,
			'OP03_MATH_INC_DEC' => -178,
			'COLON' => -178,
			"]" => -178,
			'OP13_BITWISE_AND' => -178,
			'OP24_LOGICAL_OR_XOR' => -178,
			'OP18_TERNARY' => -178,
			'OP02_METHOD_THINARROW' => -178,
			'OP14_BITWISE_OR_XOR' => -178,
			'OP15_LOGICAL_AND' => -178,
			'OP08_MATH_ADD_SUB' => -178,
			'OP11_COMPARE_LT_GT' => -178,
			'OP07_MATH_MULT_DIV_MOD' => -178,
			'OP06_REGEX_MATCH' => -178,
			'OP23_LOGICAL_AND' => -178,
			'OP17_LIST_RANGE' => -178
		},
		GOTOS => {
			'VariableRetrieval' => 305
		}
	},
	{#State 230
		ACTIONS => {
			'FHREF_SYMBOL' => 307
		}
	},
	{#State 231
		ACTIONS => {
			'VARIABLE_SYMBOL' => 308
		}
	},
	{#State 232
		DEFAULT => -88
	},
	{#State 233
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 309
		}
	},
	{#State 234
		ACTIONS => {
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 156,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'ARGV' => 148,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 310,
			'WordScoped' => 118,
			'SubExpression' => 181,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'TypeInner' => 149,
			'ArrayReference' => 95
		}
	},
	{#State 235
		ACTIONS => {
			")" => 311,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174
		}
	},
	{#State 236
		ACTIONS => {
			"]" => 312
		}
	},
	{#State 237
		DEFAULT => -196
	},
	{#State 238
		ACTIONS => {
			'TYPE_FHREF' => 313
		}
	},
	{#State 239
		ACTIONS => {
			'MY' => 314
		}
	},
	{#State 240
		ACTIONS => {
			'LPAREN_MY' => 315,
			'LPAREN' => 316
		}
	},
	{#State 241
		ACTIONS => {
			'LPAREN_MY' => 317,
			'MY' => 318
		}
	},
	{#State 242
		DEFAULT => -166
	},
	{#State 243
		DEFAULT => -167
	},
	{#State 244
		DEFAULT => -165
	},
	{#State 245
		DEFAULT => -154
	},
	{#State 246
		ACTIONS => {
			";" => 319
		}
	},
	{#State 247
		DEFAULT => -220
	},
	{#State 248
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => 164,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -100,
			"}" => -100,
			'OP08_STRING_CAT' => 167,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_MATH_ADD_SUB' => 160,
			'OP15_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -100
		}
	},
	{#State 249
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => -110,
			'OP21_LIST_COMMA' => -110,
			")" => -110,
			"]" => -110,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 167,
			"}" => -110,
			";" => -110,
			'OP09_BITWISE_SHIFT' => 168
		}
	},
	{#State 250
		DEFAULT => -150
	},
	{#State 251
		ACTIONS => {
			'LBRACE' => 321,
			'VARIABLE_SYMBOL' => 320
		}
	},
	{#State 252
		ACTIONS => {
			"our" => 322,
			'LITERAL_NUMBER' => 323
		},
		GOTOS => {
			'Method' => 325,
			'MethodOrSubroutine' => 326,
			'Subroutine' => 324
		}
	},
	{#State 253
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 327
		}
	},
	{#State 254
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 328
		}
	},
	{#State 255
		ACTIONS => {
			";" => 329
		}
	},
	{#State 256
		DEFAULT => -46
	},
	{#State 257
		ACTIONS => {
			")" => -191,
			'OP21_LIST_COMMA' => 331,
			";" => -191,
			"]" => -191
		},
		GOTOS => {
			'PAREN-44' => 330
		}
	},
	{#State 258
		ACTIONS => {
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			"]" => -193,
			")" => -193,
			'OP21_LIST_COMMA' => -193,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -193,
			'OP08_STRING_CAT' => 167,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164
		}
	},
	{#State 259
		ACTIONS => {
			"}" => -84,
			'OP08_STRING_CAT' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			";" => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP04_MATH_POW' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			")" => -84,
			'OP21_LIST_COMMA' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP13_BITWISE_AND' => -84,
			"]" => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP18_TERNARY' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP06_REGEX_MATCH' => -84
		}
	},
	{#State 260
		DEFAULT => -122
	},
	{#State 261
		ACTIONS => {
			"\$TYPED_" => 332
		}
	},
	{#State 262
		DEFAULT => -228
	},
	{#State 263
		DEFAULT => -229
	},
	{#State 264
		ACTIONS => {
			'COLON' => 333
		}
	},
	{#State 265
		ACTIONS => {
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => -106,
			"]" => -106,
			")" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP18_TERNARY' => -106,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -106,
			"}" => -106,
			'OP08_STRING_CAT' => 167,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => -106,
			'OP07_STRING_REPEAT' => 164
		}
	},
	{#State 266
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => -97,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			")" => -97,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => -97,
			"}" => -97,
			";" => -97,
			'OP09_BITWISE_SHIFT' => -97
		}
	},
	{#State 267
		DEFAULT => -94
	},
	{#State 268
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => 172,
			"]" => -111,
			")" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP17_LIST_RANGE' => 163,
			'OP06_REGEX_MATCH' => 161,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP15_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -111,
			"}" => -111,
			'OP08_STRING_CAT' => 167,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164
		}
	},
	{#State 269
		ACTIONS => {
			")" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP13_BITWISE_AND' => 172,
			"]" => -108,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP15_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 161,
			"}" => -108,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -108,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166
		}
	},
	{#State 270
		ACTIONS => {
			")" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP18_TERNARY' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 161,
			"}" => -95,
			'OP08_STRING_CAT' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP04_MATH_POW' => 166
		}
	},
	{#State 271
		ACTIONS => {
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP18_TERNARY' => -107,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => -107,
			"]" => -107,
			")" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => -107,
			'OP07_STRING_REPEAT' => 164,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -107,
			"}" => -107,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 272
		ACTIONS => {
			'OP16_LOGICAL_OR' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => -90,
			"}" => -90,
			'OP08_STRING_CAT' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			";" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => -90,
			")" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP13_BITWISE_AND' => -90,
			"]" => -90
		}
	},
	{#State 273
		ACTIONS => {
			'OP08_STRING_CAT' => -98,
			"}" => -98,
			";" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP04_MATH_POW' => 166,
			'OP21_LIST_COMMA' => -98,
			")" => -98,
			"]" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP18_TERNARY' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => -98,
			'OP08_MATH_ADD_SUB' => 160,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 274
		ACTIONS => {
			'OP21_LIST_COMMA' => -99,
			")" => -99,
			"]" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => -99,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 167,
			"}" => -99,
			";" => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => -99
		}
	},
	{#State 275
		ACTIONS => {
			"]" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 172,
			'OP21_LIST_COMMA' => -105,
			")" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP06_REGEX_MATCH' => 161,
			'OP15_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP18_TERNARY' => -105,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -105,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			"}" => -105,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 276
		ACTIONS => {
			'OP17_LIST_RANGE' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 161,
			'OP15_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			")" => -102,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => -102,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => -102,
			";" => -102,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			"}" => -102
		}
	},
	{#State 277
		ACTIONS => {
			"}" => -96,
			'OP08_STRING_CAT' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP07_STRING_REPEAT' => 164,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP04_MATH_POW' => 166,
			")" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 278
		ACTIONS => {
			'OP13_BITWISE_AND' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			"]" => -104,
			")" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP18_TERNARY' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -104,
			"}" => -104,
			'OP08_STRING_CAT' => 167,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP16_LOGICAL_OR' => -104,
			'OP07_STRING_REPEAT' => 164
		}
	},
	{#State 279
		ACTIONS => {
			"]" => -112,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP21_LIST_COMMA' => -112,
			")" => -112,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			";" => -112,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			"}" => -112,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165
		}
	},
	{#State 280
		ACTIONS => {
			")" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			"]" => -103,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP18_TERNARY' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			"}" => -103,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP07_STRING_REPEAT' => 164,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 281
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			")" => 334,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163
		}
	},
	{#State 282
		ACTIONS => {
			"}" => 335
		}
	},
	{#State 283
		DEFAULT => -201
	},
	{#State 284
		ACTIONS => {
			";" => 336
		}
	},
	{#State 285
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 156,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'ARGV' => 148,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'ListElement' => 147,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ListElements' => 337,
			'TypeInner' => 149,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 154,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106
		}
	},
	{#State 286
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'ARGV' => 148,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			")" => -129,
			'OP03_MATH_INC_DEC' => 126,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_QW' => 157
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'ListElements' => 339,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'OPTIONAL-35' => 338,
			'ListElement' => 147,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'TypeInner' => 149,
			'ArrayReference' => 95
		}
	},
	{#State 287
		DEFAULT => -146
	},
	{#State 288
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -145,
			'OP08_STRING_CAT' => 167,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			")" => -145
		}
	},
	{#State 289
		DEFAULT => -186
	},
	{#State 290
		DEFAULT => -147
	},
	{#State 291
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -187,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			")" => -187,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162
		}
	},
	{#State 292
		DEFAULT => -131
	},
	{#State 293
		ACTIONS => {
			";" => 340
		}
	},
	{#State 294
		ACTIONS => {
			";" => 341
		}
	},
	{#State 295
		ACTIONS => {
			"}" => 342
		}
	},
	{#State 296
		DEFAULT => -216
	},
	{#State 297
		DEFAULT => -91
	},
	{#State 298
		DEFAULT => -93
	},
	{#State 299
		DEFAULT => -126
	},
	{#State 300
		ACTIONS => {
			")" => 343
		}
	},
	{#State 301
		DEFAULT => -135
	},
	{#State 302
		ACTIONS => {
			'WORD_UPPERCASE' => -204,
			'LPAREN' => -204,
			'CONSTANT_CALL_SCOPED' => -204,
			'MY' => 156,
			'WORD_SCOPED' => -204,
			'OP03_MATH_INC_DEC' => -204,
			'OP01_NAMED' => -204,
			'LITERAL_STRING' => -204,
			'LBRACE' => -204,
			"\@{" => -204,
			'OP05_MATH_NEG_LPAREN' => -204,
			'WORD' => -204,
			'OP05_BITWISE_NEG_LPAREN' => -204,
			"undef" => -204,
			"%{" => -204,
			'OP01_CLOSE' => -204,
			'OP22_LOGICAL_NEG' => -204,
			'LITERAL_NUMBER' => -204,
			'OP10_NAMED_UNARY' => -204,
			'VARIABLE_SYMBOL' => -204,
			'OP05_LOGICAL_NEG' => -204,
			'OP01_OPEN' => -204,
			'LBRACKET' => -204,
			'SELF' => -204
		},
		GOTOS => {
			'OPTIONAL-48' => 344,
			'TypeInner' => 345
		}
	},
	{#State 303
		ACTIONS => {
			"}" => 347,
			'OP21_LIST_COMMA' => 348
		},
		GOTOS => {
			'PAREN-49' => 346
		}
	},
	{#State 304
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 95,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'SubExpression' => 349,
			'WordScoped' => 118,
			'HashReference' => 116
		}
	},
	{#State 305
		DEFAULT => -176
	},
	{#State 306
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 351,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP10_NAMED_UNARY' => 133,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'HashReference' => 116,
			'SubExpression' => 350,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayDereference' => 138
		}
	},
	{#State 307
		ACTIONS => {
			";" => 352
		}
	},
	{#State 308
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 354,
			'OP19_VARIABLE_ASSIGN' => 355,
			";" => 353
		}
	},
	{#State 309
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'ARGV' => 148,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'ListElement' => 147,
			'ArrayDereference' => 138,
			'Variable' => 152,
			'ListElements' => 356,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 95,
			'TypeInner' => 149,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'HashReference' => 116,
			'SubExpression' => 154,
			'WordScoped' => 118
		}
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 357
		}
	},
	{#State 311
		DEFAULT => -144
	},
	{#State 312
		DEFAULT => -198
	},
	{#State 313
		ACTIONS => {
			'FHREF_SYMBOL' => 358
		}
	},
	{#State 314
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 359
		}
	},
	{#State 315
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 360
		}
	},
	{#State 316
		ACTIONS => {
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'OP10_NAMED_UNARY' => 133,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 361,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 317
		ACTIONS => {
			'TYPE_INTEGER' => 362
		}
	},
	{#State 318
		ACTIONS => {
			'TYPE_INTEGER' => 363
		}
	},
	{#State 319
		DEFAULT => -125
	},
	{#State 320
		ACTIONS => {
			";" => 364
		}
	},
	{#State 321
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP11_COMPARE_LT_GT' => 216,
			'OP08_MATH_ADD_SUB' => 205,
			'OP01_NAMED_VOID' => 218,
			'OP23_LOGICAL_AND' => 204,
			'OP01_NAMED' => 222,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP24_LOGICAL_OR_XOR' => 219,
			'OP01_PRINT' => 224,
			'OP01_OPEN' => 211,
			'OP07_STRING_REPEAT' => 210,
			'OP10_NAMED_UNARY' => 208,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP19_LOOP_CONTROL' => 209,
			'OP01_CLOSE' => 228,
			"}" => 367,
			'OP22_LOGICAL_NEG' => 214,
			'WORD' => 227
		},
		GOTOS => {
			'OpStringOrWord' => 366,
			'HashEntryProperties' => 365
		}
	},
	{#State 322
		ACTIONS => {
			'TYPE_METHOD' => 368,
			'WORD_SCOPED' => 56,
			'TYPE_INTEGER' => 58,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 323
		ACTIONS => {
			";" => 369
		}
	},
	{#State 324
		DEFAULT => -78
	},
	{#State 325
		DEFAULT => -77
	},
	{#State 326
		DEFAULT => -59
	},
	{#State 327
		DEFAULT => -227
	},
	{#State 328
		ACTIONS => {
			")" => 372,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-19' => 371
		}
	},
	{#State 329
		DEFAULT => -48
	},
	{#State 330
		DEFAULT => -189
	},
	{#State 331
		ACTIONS => {
			"\@{" => 93,
			'OP01_QW' => 157,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 156,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'ARGV' => 148,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'TypeInner' => 149,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'ListElement' => 373,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 332
		ACTIONS => {
			'OP10_NAMED_UNARY' => 208,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP19_LOOP_CONTROL' => 209,
			'OP01_PRINT' => 224,
			'OP07_STRING_REPEAT' => 210,
			'OP01_OPEN' => 211,
			'WORD' => 227,
			'OP01_CLOSE' => 228,
			'OP22_LOGICAL_NEG' => 214,
			'OP23_LOGICAL_AND' => 204,
			'OP11_COMPARE_LT_GT' => 216,
			'OP08_MATH_ADD_SUB' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP01_NAMED_VOID' => 218,
			'OP24_LOGICAL_OR_XOR' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP01_NAMED' => 222
		},
		GOTOS => {
			'OpStringOrWord' => 374
		}
	},
	{#State 333
		ACTIONS => {
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 84,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Literal' => 263,
			'VariableOrLiteral' => 375,
			'Variable' => 262
		}
	},
	{#State 334
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 335
		DEFAULT => -202
	},
	{#State 336
		DEFAULT => -121
	},
	{#State 337
		ACTIONS => {
			";" => 378
		}
	},
	{#State 338
		ACTIONS => {
			")" => 379
		}
	},
	{#State 339
		DEFAULT => -128
	},
	{#State 340
		DEFAULT => -118
	},
	{#State 341
		DEFAULT => -119
	},
	{#State 342
		DEFAULT => -217
	},
	{#State 343
		DEFAULT => -133
	},
	{#State 344
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 380,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 345
		DEFAULT => -203
	},
	{#State 346
		DEFAULT => -210
	},
	{#State 347
		DEFAULT => -212
	},
	{#State 348
		ACTIONS => {
			'WORD' => 227,
			"%{" => 113,
			'OP01_CLOSE' => 228,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 214,
			'OP10_NAMED_UNARY' => 208,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP19_LOOP_CONTROL' => 209,
			'VARIABLE_SYMBOL' => 103,
			'OP01_PRINT' => 224,
			'SELF' => 130,
			'OP07_STRING_REPEAT' => 210,
			'OP01_OPEN' => 211,
			'OP24_LOGICAL_OR_XOR' => 219,
			'ENV' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP01_NAMED' => 222,
			'LITERAL_STRING' => 83,
			'OP23_LOGICAL_AND' => 204,
			'OP11_COMPARE_LT_GT' => 216,
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP08_MATH_ADD_SUB' => 205,
			'OP01_NAMED_VOID' => 218
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'OpStringOrWord' => 207,
			'HashDereference' => 217,
			'Variable' => 220,
			'Literal' => 225,
			'VarOrLitOrOpStrOrWord' => 212,
			'HashEntry' => 381
		}
	},
	{#State 349
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP06_REGEX_MATCH' => 161,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			"]" => 382,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168
		}
	},
	{#State 350
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			"}" => 383,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 351
		ACTIONS => {
			"}" => 384,
			'OP02_METHOD_THINARROW_NEW' => -218,
			'LPAREN' => -218
		}
	},
	{#State 352
		DEFAULT => -185
	},
	{#State 353
		DEFAULT => -182
	},
	{#State 354
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			"%{" => 113,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'SubExpression' => 385,
			'WordScoped' => 118,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 138
		}
	},
	{#State 355
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 389,
			'OP05_MATH_NEG_LPAREN' => 117,
			'STDIN' => 290,
			"\@{" => 93,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'FHREF_SYMBOL_IN' => 287,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'OP01_NAMED_SCOLON' => 386
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 288,
			'HashDereference' => 91,
			'Expression' => 150,
			'SubExpressionOrInput' => 388,
			'Literal' => 106,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'OpNamedScolonOrSubExpIn' => 387,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayDereference' => 138
		}
	},
	{#State 356
		ACTIONS => {
			")" => 390
		}
	},
	{#State 357
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'ARGV' => 148,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP01_QW' => 157,
			"\@{" => 93
		},
		GOTOS => {
			'SubExpression' => 154,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'TypeInner' => 149,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'ListElements' => 391,
			'Variable' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 147
		}
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 392
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 394
		}
	},
	{#State 361
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			")" => 395,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 362
		ACTIONS => {
			'VARIABLE_SYMBOL' => 396
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 397
		}
	},
	{#State 364
		DEFAULT => -67
	},
	{#State 365
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 398
		}
	},
	{#State 366
		ACTIONS => {
			'OP20_HASH_FATARROW' => 399
		}
	},
	{#State 367
		ACTIONS => {
			";" => 400
		}
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 369
		DEFAULT => -61
	},
	{#State 370
		ACTIONS => {
			'MY' => 402
		}
	},
	{#State 371
		DEFAULT => -50
	},
	{#State 372
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 373
		DEFAULT => -188
	},
	{#State 374
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 375
		DEFAULT => -109
	},
	{#State 376
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 107,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			"%{" => 113,
			"for" => -152,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			'OP01_CLOSE' => 111,
			"\@{" => 93,
			"if" => 92,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"while" => -152,
			"foreach" => -152,
			'OP01_NAMED_VOID' => 89,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'WORD_UPPERCASE' => 100,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL' => 132,
			'OP10_NAMED_UNARY' => 133,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED_VOID_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'LBRACE' => 122,
			'MY' => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 90,
			'VariableDeclaration' => 119,
			'HashDereference' => 91,
			'Operation' => 406,
			'PLUS-42' => 405,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 98,
			'Statement' => 134,
			'VariableModification' => 108,
			'OPTIONAL-37' => 131,
			'Expression' => 101,
			'Literal' => 106,
			'OperatorVoid' => 104,
			'ArrayDereference' => 138,
			'LoopLabel' => 139,
			'PAREN-36' => 136,
			'Conditional' => 109,
			'Operator' => 112
		}
	},
	{#State 377
		DEFAULT => -160,
		GOTOS => {
			'STAR-39' => 407
		}
	},
	{#State 378
		DEFAULT => -123
	},
	{#State 379
		DEFAULT => -134
	},
	{#State 380
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			"}" => -205,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP21_LIST_COMMA' => -205,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163
		}
	},
	{#State 381
		DEFAULT => -209
	},
	{#State 382
		DEFAULT => -179
	},
	{#State 383
		DEFAULT => -180
	},
	{#State 384
		DEFAULT => -181
	},
	{#State 385
		ACTIONS => {
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			"]" => 408
		}
	},
	{#State 386
		DEFAULT => -240
	},
	{#State 387
		DEFAULT => -183
	},
	{#State 388
		ACTIONS => {
			";" => 409
		}
	},
	{#State 389
		DEFAULT => -241
	},
	{#State 390
		DEFAULT => -83
	},
	{#State 391
		ACTIONS => {
			")" => 410
		}
	},
	{#State 392
		ACTIONS => {
			'LITERAL_STRING' => 411
		}
	},
	{#State 393
		ACTIONS => {
			'LPAREN' => 412
		}
	},
	{#State 394
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 395
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 414
		}
	},
	{#State 396
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 397
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 398
		ACTIONS => {
			'OP21_LIST_COMMA' => 417,
			"}" => 419
		},
		GOTOS => {
			'PAREN-25' => 418
		}
	},
	{#State 399
		ACTIONS => {
			'MY' => 421
		},
		GOTOS => {
			'TypeInnerProperties' => 420
		}
	},
	{#State 400
		DEFAULT => -66
	},
	{#State 401
		ACTIONS => {
			"= sub {" => 422
		}
	},
	{#State 402
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'TYPE_INTEGER' => 58,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 423
		}
	},
	{#State 403
		ACTIONS => {
			"\@_;" => 424
		}
	},
	{#State 404
		DEFAULT => -224
	},
	{#State 405
		ACTIONS => {
			'OP10_NAMED_UNARY' => 133,
			'OP19_LOOP_CONTROL' => 132,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			"}" => 425,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED_VOID_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'MY' => 124,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'OP01_NAMED_SCOLON' => 107,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			'VARIABLE_SYMBOL' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			"for" => -152,
			'OP01_CLOSE' => 111,
			"while" => -152,
			"\@{" => 93,
			"if" => 92,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"foreach" => -152,
			'OP01_NAMED_VOID' => 89,
			'WORD_UPPERCASE' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 97
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashDereference' => 91,
			'VariableDeclaration' => 119,
			'Operation' => 426,
			'HashReference' => 116,
			'SubExpression' => 90,
			'WordScoped' => 118,
			'Variable' => 98,
			'VariableSymbolOrSelf' => 123,
			'Statement' => 134,
			'VariableModification' => 108,
			'Expression' => 101,
			'OPTIONAL-37' => 131,
			'OperatorVoid' => 104,
			'Literal' => 106,
			'LoopLabel' => 139,
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Conditional' => 109,
			'PAREN-36' => 136
		}
	},
	{#State 406
		DEFAULT => -174
	},
	{#State 407
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -163,
			'' => -163,
			'OP01_NAMED' => -163,
			'LITERAL_STRING' => -163,
			'WORD_SCOPED' => -163,
			'OP10_NAMED_UNARY_SCOLON' => -163,
			'WORD_UPPERCASE' => -163,
			'OP01_NAMED_VOID' => -163,
			"foreach" => -163,
			'OP01_NAMED_VOID_LPAREN' => -163,
			"if" => -163,
			"\@{" => -163,
			"while" => -163,
			'OP01_CLOSE' => -163,
			"%{" => -163,
			"for" => -163,
			"undef" => -163,
			'OP05_BITWISE_NEG_LPAREN' => -163,
			'WORD' => -163,
			'OP05_LOGICAL_NEG' => -163,
			'OP01_PRINT' => -163,
			'VARIABLE_SYMBOL' => -163,
			'OP01_NAMED_SCOLON' => -163,
			'LBRACE' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'MY' => -163,
			'CONSTANT_CALL_SCOPED' => -163,
			'LPAREN' => -163,
			'OP05_MATH_NEG_LPAREN' => -163,
			'OP01_NAMED_VOID_SCOLON' => -163,
			"else" => 430,
			'LITERAL_NUMBER' => -163,
			'OP22_LOGICAL_NEG' => -163,
			"}" => -163,
			"elsif" => 428,
			'SELF' => -163,
			'LBRACKET' => -163,
			'OP01_OPEN' => -163,
			'OP19_LOOP_CONTROL' => -163,
			'OP10_NAMED_UNARY' => -163
		},
		GOTOS => {
			'OPTIONAL-41' => 427,
			'PAREN-38' => 431,
			'PAREN-40' => 429
		}
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 432
		}
	},
	{#State 409
		DEFAULT => -242
	},
	{#State 410
		DEFAULT => -85
	},
	{#State 411
		ACTIONS => {
			'OP21_LIST_COMMA' => 433
		}
	},
	{#State 412
		ACTIONS => {
			'OP01_QW' => 157,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'MY' => 156,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'ARGV' => 148,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'ListElements' => 434,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123,
			'ListElement' => 147,
			'ArrayDereference' => 138,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'WordScoped' => 118,
			'SubExpression' => 154,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'TypeInner' => 149
		}
	},
	{#State 413
		ACTIONS => {
			"\@{" => 93,
			'STDIN' => 290,
			'OP05_MATH_NEG_LPAREN' => 117,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'FHREF_SYMBOL_IN' => 287,
			"%{" => 113,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayReference' => 95,
			'SubExpression' => 288,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'SubExpressionOrInput' => 435,
			'HashDereference' => 91,
			'Expression' => 150
		}
	},
	{#State 414
		DEFAULT => -171
	},
	{#State 415
		ACTIONS => {
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_NAMED_SCOLON' => 439,
			'OP10_NAMED_UNARY' => 133,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY_SCOLON' => 436,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'ArrayReference' => 95,
			'SubExpression' => 437,
			'WordScoped' => 118,
			'HashReference' => 116,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'OpNamedScolonOrSubExp' => 438,
			'Operator' => 112,
			'Variable' => 152
		}
	},
	{#State 416
		ACTIONS => {
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'CONSTANT_CALL_SCOPED' => 125,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			"%{" => 113,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			'OP10_NAMED_UNARY' => 133,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'WordScoped' => 118,
			'SubExpression' => 440,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91,
			'ArrayReference' => 95,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayDereference' => 138
		}
	},
	{#State 417
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP01_NAMED' => 222,
			'OP24_LOGICAL_OR_XOR' => 219,
			'OP08_MATH_ADD_SUB' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP11_COMPARE_LT_GT' => 216,
			'OP01_NAMED_VOID' => 218,
			'OP23_LOGICAL_AND' => 204,
			'OP01_CLOSE' => 228,
			'OP22_LOGICAL_NEG' => 214,
			'WORD' => 227,
			'OP01_PRINT' => 224,
			'OP07_STRING_REPEAT' => 210,
			'OP01_OPEN' => 211,
			'OP10_NAMED_UNARY' => 208,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP19_LOOP_CONTROL' => 209
		},
		GOTOS => {
			'OpStringOrWord' => 366,
			'HashEntryProperties' => 441
		}
	},
	{#State 418
		DEFAULT => -63
	},
	{#State 419
		ACTIONS => {
			";" => 442
		}
	},
	{#State 420
		DEFAULT => -208
	},
	{#State 421
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 57,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 443
		}
	},
	{#State 422
		ACTIONS => {
			'LPAREN_MY' => 445,
			'OP05_MATH_NEG_LPAREN' => -69,
			'OP01_NAMED_VOID_SCOLON' => -69,
			'LBRACE' => -69,
			'OP03_MATH_INC_DEC' => -69,
			'MY' => -69,
			'CONSTANT_CALL_SCOPED' => -69,
			'LPAREN' => -69,
			'SELF' => -69,
			'LBRACKET' => -69,
			'OP01_OPEN' => -69,
			'OP19_LOOP_CONTROL' => -69,
			'OP10_NAMED_UNARY' => -69,
			'LITERAL_NUMBER' => -69,
			'OP22_LOGICAL_NEG' => -69,
			"}" => -69,
			'OP01_NAMED_VOID' => -69,
			"foreach" => -69,
			'OP01_NAMED_VOID_LPAREN' => -69,
			"if" => -69,
			"\@{" => -69,
			"while" => -69,
			'OP19_LOOP_CONTROL_SCOLON' => -69,
			'OP01_NAMED' => -69,
			'LITERAL_STRING' => -69,
			'WORD_SCOPED' => -69,
			'OP10_NAMED_UNARY_SCOLON' => -69,
			'WORD_UPPERCASE' => -69,
			'OP01_PRINT' => -69,
			'OP05_LOGICAL_NEG' => -69,
			'VARIABLE_SYMBOL' => -69,
			'OP01_NAMED_SCOLON' => -69,
			'OP01_CLOSE' => -69,
			"%{" => -69,
			"for" => -69,
			"undef" => -69,
			'OP05_BITWISE_NEG_LPAREN' => -69,
			'WORD' => -69
		},
		GOTOS => {
			'OPTIONAL-27' => 446,
			'MethodArguments' => 444
		}
	},
	{#State 423
		ACTIONS => {
			'VARIABLE_SYMBOL' => 447
		}
	},
	{#State 424
		DEFAULT => -52
	},
	{#State 425
		DEFAULT => -175
	},
	{#State 426
		DEFAULT => -173
	},
	{#State 427
		DEFAULT => -164
	},
	{#State 428
		ACTIONS => {
			'LPAREN' => 448
		}
	},
	{#State 429
		DEFAULT => -162
	},
	{#State 430
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 449
		}
	},
	{#State 431
		DEFAULT => -159
	},
	{#State 432
		ACTIONS => {
			"undef" => 450
		}
	},
	{#State 433
		ACTIONS => {
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'OP10_NAMED_UNARY' => 133,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayReference' => 95,
			'WordScoped' => 118,
			'SubExpression' => 451,
			'HashReference' => 116,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152
		}
	},
	{#State 434
		ACTIONS => {
			")" => 452
		}
	},
	{#State 435
		ACTIONS => {
			")" => 453
		}
	},
	{#State 436
		DEFAULT => -238
	},
	{#State 437
		ACTIONS => {
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 163,
			'OP06_REGEX_MATCH' => 161,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			";" => 454,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 438
		ACTIONS => {
			'VARIABLE_SYMBOL' => 455
		}
	},
	{#State 439
		DEFAULT => -237
	},
	{#State 440
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 456,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 159,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 441
		DEFAULT => -62
	},
	{#State 442
		DEFAULT => -65
	},
	{#State 443
		ACTIONS => {
			"\$TYPED_" => 457
		}
	},
	{#State 444
		DEFAULT => -68
	},
	{#State 445
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 458
		}
	},
	{#State 446
		DEFAULT => -71,
		GOTOS => {
			'STAR-28' => 459
		}
	},
	{#State 447
		DEFAULT => -49
	},
	{#State 448
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 126,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 460,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112
		}
	},
	{#State 449
		DEFAULT => -161
	},
	{#State 450
		ACTIONS => {
			";" => 461
		}
	},
	{#State 451
		ACTIONS => {
			")" => -86,
			'OP21_LIST_COMMA' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP13_BITWISE_AND' => 172,
			"]" => -86,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP23_LOGICAL_AND' => -86,
			'OP17_LIST_RANGE' => 163,
			'OP06_REGEX_MATCH' => 161,
			"}" => -86,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			";" => -86,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174
		}
	},
	{#State 452
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 453
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 463
		}
	},
	{#State 454
		DEFAULT => -239
	},
	{#State 455
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 464
		}
	},
	{#State 456
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151,
			'SELF' => 130,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP10_NAMED_UNARY' => 133,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114
		},
		GOTOS => {
			'ArrayReference' => 95,
			'Literal' => 106,
			'HashDereference' => 91,
			'Expression' => 150,
			'WordScoped' => 118,
			'SubExpression' => 465,
			'HashReference' => 116,
			'ArrayDereference' => 138,
			'Operator' => 112,
			'Variable' => 152,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 457
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP01_NAMED' => 222,
			'OP23_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 215,
			'OP11_COMPARE_LT_GT' => 216,
			'OP08_MATH_ADD_SUB' => 205,
			'OP01_NAMED_VOID' => 218,
			'WORD' => 227,
			'OP01_CLOSE' => 228,
			'OP22_LOGICAL_NEG' => 214,
			'OP10_NAMED_UNARY' => 208,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP19_LOOP_CONTROL' => 209,
			'OP01_PRINT' => 224,
			'OP07_STRING_REPEAT' => 210,
			'OP01_OPEN' => 211
		},
		GOTOS => {
			'OpStringOrWord' => 466
		}
	},
	{#State 458
		ACTIONS => {
			'SELF' => 467
		}
	},
	{#State 459
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			'OP01_NAMED_VOID_SCOLON' => 121,
			'MY' => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 122,
			'LPAREN' => 127,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'OP19_LOOP_CONTROL' => 132,
			"}" => 468,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			"foreach" => -152,
			'OP01_NAMED_VOID' => 89,
			"while" => -152,
			"if" => 92,
			"\@{" => 93,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 83,
			'OP01_NAMED' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'WORD_UPPERCASE' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 99,
			'OP01_PRINT' => 105,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP01_NAMED_SCOLON' => 107,
			'OP01_CLOSE' => 111,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			"for" => -152
		},
		GOTOS => {
			'HashDereference' => 91,
			'VariableDeclaration' => 119,
			'Operation' => 469,
			'HashReference' => 116,
			'SubExpression' => 90,
			'WordScoped' => 118,
			'ArrayReference' => 95,
			'Variable' => 98,
			'VariableSymbolOrSelf' => 123,
			'OPTIONAL-37' => 131,
			'Expression' => 101,
			'Literal' => 106,
			'OperatorVoid' => 104,
			'Statement' => 134,
			'VariableModification' => 108,
			'Operator' => 112,
			'PAREN-36' => 136,
			'Conditional' => 109,
			'LoopLabel' => 139,
			'ArrayDereference' => 138
		}
	},
	{#State 460
		ACTIONS => {
			")" => 470,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP15_LOGICAL_AND' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174
		}
	},
	{#State 461
		DEFAULT => -184
	},
	{#State 462
		DEFAULT => -170
	},
	{#State 463
		DEFAULT => -172
	},
	{#State 464
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 436,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			"\@{" => 93,
			'OP05_MATH_NEG_LPAREN' => 117,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115,
			"%{" => 113,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP10_NAMED_UNARY' => 133,
			'OP01_NAMED_SCOLON' => 439,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130
		},
		GOTOS => {
			'OpNamedScolonOrSubExp' => 471,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 152,
			'Operator' => 112,
			'ArrayDereference' => 138,
			'HashReference' => 116,
			'WordScoped' => 118,
			'SubExpression' => 437,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'ArrayReference' => 95
		}
	},
	{#State 465
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NE' => 174,
			")" => 472,
			'OP13_BITWISE_AND' => 172,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => -108,
			'OP15_LOGICAL_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 466
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 473,
			'OP19_VARIABLE_ASSIGN' => 474
		}
	},
	{#State 467
		DEFAULT => -75,
		GOTOS => {
			'STAR-30' => 475
		}
	},
	{#State 468
		ACTIONS => {
			";" => 476
		}
	},
	{#State 469
		DEFAULT => -70
	},
	{#State 470
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 477
		}
	},
	{#State 471
		ACTIONS => {
			'SELF' => 130,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'OP05_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 103,
			'OP10_NAMED_UNARY' => 133,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			"undef" => 115,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'OP01_NAMED' => 153,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			'LPAREN' => 127,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 98,
			'Operator' => 112,
			'SubExpressionOrVarMod' => 480,
			'VariableModification' => 478,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 479,
			'WordScoped' => 118,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106
		}
	},
	{#State 472
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 481
		}
	},
	{#State 473
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 83,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'LBRACKET' => 128,
			'OP01_OPEN' => 129,
			'SELF' => 130,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 133,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 111,
			"%{" => 113,
			'WORD' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			"undef" => 115
		},
		GOTOS => {
			'ArrayReference' => 95,
			'Expression' => 150,
			'HashDereference' => 91,
			'Literal' => 106,
			'HashReference' => 116,
			'SubExpression' => 482,
			'WordScoped' => 118,
			'ArrayDereference' => 138,
			'Variable' => 152,
			'Operator' => 112,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 474
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 135,
			'LITERAL_NUMBER' => 84,
			'OP05_BITWISE_NEG_LPAREN' => 114,
			'WORD' => 26,
			"undef" => 115,
			"%{" => 113,
			'VARIABLE_SYMBOL' => 103,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 129,
			'LBRACKET' => 128,
			'SELF' => 130,
			'OP10_NAMED_UNARY' => 133,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 153,
			'LBRACE' => 122,
			'LITERAL_STRING' => 83,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 127,
			'OP05_MATH_NEG_LPAREN' => 117,
			"\@{" => 93
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 112,
			'Variable' => 152,
			'ArrayReference' => 95,
			'WordScoped' => 118,
			'SubExpression' => 483,
			'HashReference' => 116,
			'Literal' => 106,
			'Expression' => 150,
			'HashDereference' => 91
		}
	},
	{#State 475
		ACTIONS => {
			'OP21_LIST_COMMA' => 486,
			")" => 485
		},
		GOTOS => {
			'PAREN-29' => 484
		}
	},
	{#State 476
		DEFAULT => -72
	},
	{#State 477
		DEFAULT => -158
	},
	{#State 478
		DEFAULT => -149
	},
	{#State 479
		ACTIONS => {
			'OP15_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP18_TERNARY' => 158,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 161,
			")" => -148,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168
		}
	},
	{#State 480
		ACTIONS => {
			")" => 487
		}
	},
	{#State 481
		DEFAULT => -168
	},
	{#State 482
		ACTIONS => {
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 161,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			"]" => 488,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 164,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 483
		ACTIONS => {
			'OP15_LOGICAL_AND' => 159,
			'OP18_TERNARY' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP17_LIST_RANGE' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 161,
			'OP21_LIST_COMMA' => -225,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 172,
			'OP07_STRING_REPEAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 167,
			"}" => -225,
			'OP09_BITWISE_SHIFT' => 168
		}
	},
	{#State 484
		DEFAULT => -74
	},
	{#State 485
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 489
		}
	},
	{#State 486
		ACTIONS => {
			'MY' => 490
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 376
		},
		GOTOS => {
			'CodeBlock' => 491
		}
	},
	{#State 488
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 489
		ACTIONS => {
			"\@_;" => 493
		}
	},
	{#State 490
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 494
		}
	},
	{#State 491
		DEFAULT => -169
	},
	{#State 492
		ACTIONS => {
			"undef" => 495
		}
	},
	{#State 493
		DEFAULT => -76
	},
	{#State 494
		ACTIONS => {
			'VARIABLE_SYMBOL' => 496
		}
	},
	{#State 495
		DEFAULT => -226
	},
	{#State 496
		DEFAULT => -73
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7113 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7127 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7356 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7402 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7448 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7501 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7569 lib/RPerl/Grammar.pm
	],
	[#Rule Method_72
		 'Method', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7594 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_76
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7634 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7667 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7887 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7898 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7920 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7931 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7942 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7964 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7975 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7986 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7997 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8008 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8015 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8022 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8029 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8036 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8054 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8087 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8098 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8109 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_125
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8131 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8138 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8145 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8152 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8159 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8170 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8192 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8203 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8214 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_135
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8225 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8236 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8269 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8280 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8302 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8313 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_144
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_146
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8346 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_147
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_148
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8368 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_149
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8379 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8386 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8393 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8400 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8411 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8422 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8444 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8455 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8462 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8476 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8483 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8490 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8552 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_169
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_170
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8574 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_171
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8585 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_172
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8596 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8603 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8610 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_175
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8621 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8635 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_178
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8646 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8657 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_180
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8668 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_181
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8679 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8690 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8701 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_184
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8712 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8723 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_186
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8734 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8745 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8752 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8759 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8766 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_191
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8777 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8788 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8799 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8810 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8821 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8828 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8835 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8853 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8860 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_201
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8871 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_202
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8889 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8896 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8907 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8918 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_207
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8929 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_208
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8940 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8954 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8961 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_212
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8972 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_213
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8983 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8990 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8997 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_216
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9008 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_217
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9019 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9030 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9041 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_220
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9052 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9063 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9074 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9085 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_224
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9096 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_225
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9107 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_226
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9118 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_227
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9129 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_228
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9140 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_229
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9151 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9162 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_231
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9173 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_232
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9184 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_233
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9195 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_234
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9206 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_235
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9217 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_236
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9228 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9239 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_238
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9250 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_239
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9261 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9272 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_241
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9283 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_242
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9294 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9305 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9316 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9327 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9338 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9349 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9360 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9371 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9382 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9393 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9404 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9415 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9426 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9437 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9448 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9459 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9470 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_259
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9481 lib/RPerl/Grammar.pm
	]
],
#line 9484 lib/RPerl/Grammar.pm
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
         'Properties_67', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_72', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_76', 
         'MethodOrSubroutine_77', 
         'MethodOrSubroutine_78', 
         'Operation_79', 
         'Operation_80', 
         'Operation_81', 
         'Operation_82', 
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
         'Operator_112', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         'OperatorVoid_124', 
         'OperatorVoid_125', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'Expression_134', 
         'Expression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpression_143', 
         'SubExpression_144', 
         'SubExpressionOrInput_145', 
         'SubExpressionOrInput_146', 
         'SubExpressionOrInput_147', 
         'SubExpressionOrVarMod_148', 
         'SubExpressionOrVarMod_149', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         'Statement_157', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_164', 
         'Loop_165', 
         'Loop_166', 
         'Loop_167', 
         'LoopFor_168', 
         'LoopFor_169', 
         'LoopForEach_170', 
         'LoopWhile_171', 
         'LoopWhile_172', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_175', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_178', 
         'VariableRetrieval_179', 
         'VariableRetrieval_180', 
         'VariableRetrieval_181', 
         'VariableDeclaration_182', 
         'VariableDeclaration_183', 
         'VariableDeclaration_184', 
         'VariableDeclaration_185', 
         'VariableModification_186', 
         'VariableModification_187', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_191', 
         'ListElement_192', 
         'ListElement_193', 
         'ListElement_194', 
         'ListElement_195', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_201', 
         'ArrayDereference_202', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_205', 
         'HashEntry_206', 
         'HashEntry_207', 
         'HashEntryProperties_208', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_212', 
         'HashReference_213', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_216', 
         'HashDereference_217', 
         'WordScoped_218', 
         'WordScoped_219', 
         'LoopLabel_220', 
         'Type_221', 
         'Type_222', 
         'Type_223', 
         'TypeInner_224', 
         'TypeInnerProperties_225', 
         'TypeInnerProperties_226', 
         'TypeInnerConstant_227', 
         'VariableOrLiteral_228', 
         'VariableOrLiteral_229', 
         'VarOrLitOrOpStrOrWord_230', 
         'VarOrLitOrOpStrOrWord_231', 
         'VarOrLitOrOpStrOrWord_232', 
         'VariableSymbolOrSelf_233', 
         'VariableSymbolOrSelf_234', 
         'Literal_235', 
         'Literal_236', 
         'OpNamedScolonOrSubExp_237', 
         'OpNamedScolonOrSubExp_238', 
         'OpNamedScolonOrSubExp_239', 
         'OpNamedScolonOrSubExpIn_240', 
         'OpNamedScolonOrSubExpIn_241', 
         'OpNamedScolonOrSubExpIn_242', 
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
         'OpStringOrWord_258', 
         'OpStringOrWord_259', );
  $self;
}

#line 264 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run `script/development/grammar_recompile.sh`
# 3. Run `perl t/12_parse.t` for new & existing grammar parse-only tests, if errors goto step 1
# 4. Inspect updates from Grammar.output file, note starting & finishing & increment numbers if any rule numbers have changed
# 5. Run `scripts/development/grammar_increment.pl START FINISH INCREMENT` if you have numbers from step 4, repeat if needed
# 6. Copy updates from Grammar.output file into this file with now-unique numbers, below this line only
# 7. Run `script/development/grammar_recompile.sh` again
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
Include_41 => 'RPerl::CompileUnit::Include',                                # Include -> USE_OR_REQUIRE WordScoped ';'
Include_42 => 'RPerl::CompileUnit::Include',                                # Include -> USE_OR_REQUIRE WordScoped OP01_QW ';'
Constant_43 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_48 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Properties_67 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN VARIABLE_SYMBOL ';'
Method_72 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_76 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_77 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_78 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_79 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_80 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_81 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_82 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_83 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_84 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_85 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_86 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_87 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_88 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_89 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_90 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_91 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_92 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_93 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_94 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_95 => 'RPerl::Operation::Expression::Operator::String::Repeat',                    # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo',  # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract',           # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_98 => 'RPerl::Operation::Expression::Operator::String::Concatenate',               # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                    # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_100 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY
Operator_102 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',     # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',           # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                     # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                   # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_108 => 'RPerl::Operation::Expression::Operator::List::Range',                      # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Ternary',                          # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_110 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_111 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_112 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_121 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_122 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_123 => 'RPerl::Operation::Expression::Operator::Named',                        # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_124 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_125 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_130 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_131 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_132 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_133 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_134 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_135 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_136 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_138 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_140 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_141 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_142 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_143 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_144 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_145 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_146 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_147 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_148 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_149 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_153 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_154 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_155 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_156 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_157 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_164 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_165 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_166 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_167 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_168 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_169 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_170 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_171 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_172 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_175 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_178 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_179 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_180 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_181 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_182 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_183 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_184 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_185 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_186 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_187 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_191 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_192 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_193 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_194 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_195 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_198 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_201 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_202 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_205 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_206 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_207 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_208 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_212 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_213 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_216 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_217 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_218 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_219 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_220 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_221 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_222 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_223 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_224 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_225 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_226 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_227 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_228 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_229 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_230 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_231 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_232 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_233 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_234 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_235 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_236 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_237 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_238 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_239 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_240 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_241 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_242 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_243 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_244 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_245 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_246 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_247 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_248 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_249 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_250 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_251 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_252 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_253 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_254 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_255 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_258 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_259 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 9955 lib/RPerl/Grammar.pm



1;
