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
    our $VERSION = 0.003_810;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\=\ sub\ \{|foreach|\$TYPED_|elsif|while|undef|else|for|our|\@_\;|\%\{|if|\@\{|\}|\]|\)|\;)}gc and return ($1, $1);

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
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'SubroutineOrMethod' ], 0 ],
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
  [ 'SubroutineOrMethod_77' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_78' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
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
  'SubroutineOrMethod_77' => 77,
  'SubroutineOrMethod_78' => 78,
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
			"## no critic qw(" => 6,
			'USE_RPERL' => -20,
			"package" => -20,
			'SHEBANG' => 4
		},
		GOTOS => {
			'Program' => 7,
			'ModuleHeader' => 1,
			'PAREN-1' => 5,
			'Critic' => 9,
			'PLUS-2' => 3,
			'OPTIONAL-9' => 8,
			'CompileUnit' => 2
		}
	},
	{#State 1
		ACTIONS => {
			"use parent qw(" => 12,
			'USE_OR_REQUIRE' => -27,
			"our" => -27,
			"## no critic qw(" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 14,
			'Package' => 11,
			'Class' => 10,
			'Module' => 13
		}
	},
	{#State 2
		ACTIONS => {
			'' => 15
		}
	},
	{#State 3
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 6,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 1,
			'PAREN-1' => 16,
			'Critic' => 9,
			'OPTIONAL-9' => 8
		}
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'OPTIONAL-3' => 18,
			'Critic' => 17
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'WORD' => 19
		},
		GOTOS => {
			'PLUS-16' => 20
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
			'OPTIONAL-10' => 22
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -25
	},
	{#State 11
		DEFAULT => -24
	},
	{#State 12
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"use constant" => -29,
			"## no critic qw(" => 6,
			"our" => -29,
			'USE_OR_REQUIRE' => -29
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-12' => 27
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		ACTIONS => {
			'USE_RPERL' => 28
		}
	},
	{#State 19
		DEFAULT => -39
	},
	{#State 20
		ACTIONS => {
			'WORD' => 30,
			")" => 29
		}
	},
	{#State 21
		DEFAULT => -21
	},
	{#State 22
		ACTIONS => {
			"package" => 31
		}
	},
	{#State 23
		DEFAULT => -218
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		DEFAULT => -219
	},
	{#State 26
		DEFAULT => -26
	},
	{#State 27
		ACTIONS => {
			"use constant" => -31,
			'USE_OR_REQUIRE' => 34,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 33
		}
	},
	{#State 28
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 29
		DEFAULT => -40
	},
	{#State 30
		DEFAULT => -38
	},
	{#State 31
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 23
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
			'WORD' => 23,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 35
		ACTIONS => {
			"our" => 44,
			"use constant" => 42
		},
		GOTOS => {
			'Subroutine' => 43,
			'Constant' => 45,
			'PLUS-14' => 41
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
			"our" => 44
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
		DEFAULT => -33
	},
	{#State 44
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			'OP01_NAMED_VOID' => -11,
			"\@{" => -11,
			"while" => -11,
			"our" => -11,
			'LITERAL_NUMBER' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"foreach" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LBRACKET' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED' => -11,
			'OP01_CLOSE' => -11,
			'WORD_SCOPED' => -11,
			"## no critic qw(" => 6,
			"if" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"undef" => -11,
			'LPAREN' => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LBRACE' => -11,
			"use constant" => -11,
			'WORD' => -11,
			"%{" => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP01_OPEN' => -11,
			'SELF' => -11,
			'OP10_NAMED_UNARY' => -11,
			'MY' => -11,
			"for" => -11,
			'OP01_NAMED_SCOLON' => -11,
			'USE_OR_REQUIRE' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'LITERAL_STRING' => -11
		},
		GOTOS => {
			'Critic' => 59,
			'STAR-5' => 60
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
		DEFAULT => -222
	},
	{#State 56
		DEFAULT => -223
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		DEFAULT => -221
	},
	{#State 59
		DEFAULT => -8
	},
	{#State 60
		ACTIONS => {
			'VARIABLE_SYMBOL' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID' => -13,
			"our" => -13,
			"while" => -13,
			"\@{" => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"if" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"undef" => -13,
			'OP01_PRINT' => -13,
			'LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			'WORD_SCOPED' => -13,
			'OP01_CLOSE' => -13,
			'WORD' => -13,
			"use constant" => -13,
			"%{" => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			"for" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'USE_OR_REQUIRE' => 34,
			'OP19_LOOP_CONTROL' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'OP01_OPEN' => -13,
			'SELF' => -13,
			'MY' => -13,
			'OP10_NAMED_UNARY' => -13
		},
		GOTOS => {
			'STAR-6' => 70,
			'Include' => 69
		}
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
			"our hashref \$properties" => -56,
			'USE_OR_REQUIRE' => -56,
			"use constant" => -56,
			"## no critic qw(" => 6
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
			'MY' => 75
		},
		GOTOS => {
			'TypeInnerConstant' => 74
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 76
		}
	},
	{#State 69
		DEFAULT => -10
	},
	{#State 70
		ACTIONS => {
			'VARIABLE_SYMBOL' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"foreach" => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"our" => -15,
			"\@{" => -15,
			"while" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"if" => -15,
			'OP01_PRINT' => -15,
			'LPAREN' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED' => -15,
			'WORD_SCOPED' => -15,
			'OP01_CLOSE' => -15,
			"use constant" => 42,
			'WORD' => -15,
			"%{" => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LBRACE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_SCOLON' => -15,
			"for" => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'MY' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_OPEN' => -15,
			'SELF' => -15
		},
		GOTOS => {
			'STAR-7' => 78,
			'Constant' => 77
		}
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
			"use constant" => -58,
			'USE_OR_REQUIRE' => 34
		},
		GOTOS => {
			'Include' => 81,
			'STAR-23' => 80
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Literal' => 84
		}
	},
	{#State 75
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 85
		}
	},
	{#State 76
		ACTIONS => {
			'VARIABLE_SYMBOL' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			"foreach" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'LBRACKET' => -45,
			'OP01_NAMED_VOID' => -45,
			"while" => -45,
			"\@{" => -45,
			'LITERAL_NUMBER' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'OP05_LOGICAL_NEG' => -45,
			"if" => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			"undef" => -45,
			'OP01_PRINT' => -45,
			'LPAREN' => -45,
			'OP01_NAMED' => -45,
			'WORD_UPPERCASE' => -45,
			'WORD_SCOPED' => -45,
			'OP01_CLOSE' => -45,
			'WORD' => -45,
			"%{" => -45,
			"}" => -45,
			'LPAREN_MY' => 87,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			'LBRACE' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"for" => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'LITERAL_STRING' => -45,
			'SELF' => -45,
			'OP01_OPEN' => -45,
			'MY' => -45,
			'OP10_NAMED_UNARY' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 86,
			'OPTIONAL-17' => 88
		}
	},
	{#State 77
		DEFAULT => -12
	},
	{#State 78
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'LITERAL_STRING' => 82,
			'OP19_LOOP_CONTROL' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 90,
			"for" => -152,
			'MY' => 94,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'WORD' => 23,
			"%{" => 102,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP01_PRINT' => 119,
			'LPAREN' => 120,
			"undef" => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP01_NAMED_VOID_LPAREN' => 112,
			"if" => 116,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP01_NAMED' => 123,
			'WORD_UPPERCASE' => 122,
			'OP01_NAMED_VOID_SCOLON' => 129,
			'LBRACKET' => 130,
			'VARIABLE_SYMBOL' => 126,
			"foreach" => -152,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 83,
			"our" => 44,
			"\@{" => 133,
			"while" => -152,
			'OP01_NAMED_VOID' => 135
		},
		GOTOS => {
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 93,
			'ArrayReference' => 124,
			'PAREN-36' => 118,
			'Conditional' => 113,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'PLUS-8' => 117,
			'OperatorVoid' => 115,
			'Variable' => 107,
			'Literal' => 139,
			'Statement' => 109,
			'Subroutine' => 134,
			'VariableDeclaration' => 132,
			'LoopLabel' => 136,
			'HashReference' => 105,
			'OPTIONAL-37' => 104,
			'ArrayDereference' => 131,
			'VariableModification' => 101,
			'Operation' => 127,
			'Expression' => 100
		}
	},
	{#State 79
		DEFAULT => -37
	},
	{#State 80
		ACTIONS => {
			"use constant" => 42,
			"our hashref \$properties" => 141
		},
		GOTOS => {
			'Constant' => 140,
			'Properties' => 142
		}
	},
	{#State 81
		DEFAULT => -55
	},
	{#State 82
		DEFAULT => -236
	},
	{#State 83
		DEFAULT => -235
	},
	{#State 84
		ACTIONS => {
			";" => 143
		}
	},
	{#State 85
		ACTIONS => {
			"\$TYPED_" => 144
		}
	},
	{#State 86
		DEFAULT => -44
	},
	{#State 87
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 145
		}
	},
	{#State 88
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 146
		}
	},
	{#State 89
		ACTIONS => {
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'SubExpression' => 149,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 90
		DEFAULT => -80
	},
	{#State 91
		DEFAULT => -81
	},
	{#State 92
		ACTIONS => {
			'WORD_UPPERCASE' => 152
		},
		GOTOS => {
			'LoopLabel' => 153
		}
	},
	{#State 93
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161
		}
	},
	{#State 94
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56,
			'TYPE_FHREF' => 171
		},
		GOTOS => {
			'Type' => 172
		}
	},
	{#State 95
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'LITERAL_STRING' => 82,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => -101,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP23_LOGICAL_AND' => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			"}" => -101,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => -101,
			'WORD' => 23,
			"%{" => 102,
			'OP04_MATH_POW' => -101,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP24_LOGICAL_OR_XOR' => -101,
			'LPAREN' => 120,
			'OP15_LOGICAL_AND' => -101,
			"undef" => 121,
			'OP08_MATH_ADD_SUB' => -101,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP13_BITWISE_AND' => -101,
			";" => -101,
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP11_COMPARE_LT_GT' => -101,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'LBRACKET' => 130,
			'OP09_BITWISE_SHIFT' => -101,
			"\@{" => 133,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'SubExpression' => 173,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98
		}
	},
	{#State 96
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 175,
			'LPAREN' => 174
		}
	},
	{#State 97
		DEFAULT => -234
	},
	{#State 98
		DEFAULT => -130
	},
	{#State 99
		ACTIONS => {
			'MY' => 176
		}
	},
	{#State 100
		ACTIONS => {
			'OP23_LOGICAL_AND' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP17_LIST_RANGE' => -136,
			";" => 177,
			'OP13_BITWISE_AND' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP16_LOGICAL_OR' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP04_MATH_POW' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP18_TERNARY' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP08_STRING_CAT' => -136
		}
	},
	{#State 101
		ACTIONS => {
			";" => 178
		}
	},
	{#State 102
		ACTIONS => {
			'SELF' => 97,
			'MY' => 180,
			'LBRACE' => -215,
			'VARIABLE_SYMBOL' => 126
		},
		GOTOS => {
			'TypeInner' => 181,
			'OPTIONAL-51' => 182,
			'Variable' => 179,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133
		},
		GOTOS => {
			'Variable' => 151,
			'Literal' => 139,
			'WordScoped' => 96,
			'Operator' => 98,
			'SubExpression' => 183,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 104
		ACTIONS => {
			"foreach" => 185,
			"while" => 186,
			"for" => 189
		},
		GOTOS => {
			'LoopFor' => 184,
			'Loop' => 187,
			'LoopWhile' => 188,
			'LoopForEach' => 190
		}
	},
	{#State 105
		DEFAULT => -142
	},
	{#State 106
		ACTIONS => {
			'VARIABLE_SYMBOL' => 126,
			'OP07_STRING_REPEAT' => 211,
			"%{" => 102,
			'WORD' => 210,
			'OP12_COMPARE_EQ_NE' => 212,
			"}" => 213,
			'OP01_NAMED_VOID' => 200,
			'LITERAL_NUMBER' => 83,
			'OP24_LOGICAL_OR_XOR' => 214,
			'OP22_LOGICAL_NEG' => 204,
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'OP01_PRINT' => 193,
			'LITERAL_STRING' => 82,
			'OP19_LOOP_CONTROL' => 205,
			'OP01_NAMED' => 195,
			'OP08_MATH_ADD_SUB' => 196,
			'ENV' => 206,
			'OP01_CLOSE' => 198,
			'OP10_NAMED_UNARY' => 209,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 197,
			'SELF' => 97,
			'OP01_OPEN' => 208
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 201,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 191,
			'OpStringOrWord' => 194,
			'HashEntry' => 199,
			'Variable' => 215,
			'Literal' => 202
		}
	},
	{#State 107
		ACTIONS => {
			'OP15_LOGICAL_AND' => -139,
			'OP16_LOGICAL_OR' => -139,
			'OP07_MATH_MULT_DIV_MOD' => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			'OP19_VARIABLE_ASSIGN' => 216,
			'OP11_COMPARE_LT_GT' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP08_MATH_ADD_SUB' => -139,
			'OP13_BITWISE_AND' => -139,
			'OP17_LIST_RANGE' => -139,
			'OP04_MATH_POW' => -139,
			")" => -139,
			'OP19_VARIABLE_ASSIGN_BY' => 217,
			'OP08_STRING_CAT' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			'OP18_TERNARY' => -139,
			'OP07_STRING_REPEAT' => -139,
			'OP03_MATH_INC_DEC' => 218,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP09_BITWISE_SHIFT' => -139,
			'OP02_METHOD_THINARROW' => 219
		}
	},
	{#State 108
		ACTIONS => {
			'VARIABLE_SYMBOL' => 126,
			'SELF' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 220
		}
	},
	{#State 109
		DEFAULT => -82
	},
	{#State 110
		DEFAULT => -124
	},
	{#State 111
		DEFAULT => -143
	},
	{#State 112
		ACTIONS => {
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			")" => -117,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'MY' => 180,
			'WORD_SCOPED' => 25,
			'ARGV' => 222,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120
		},
		GOTOS => {
			'ListElement' => 225,
			'ArrayDereference' => 131,
			'ListElements' => 223,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'TypeInner' => 227,
			'Variable' => 151,
			'OPTIONAL-33' => 224,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 221
		}
	},
	{#State 113
		DEFAULT => -153
	},
	{#State 114
		DEFAULT => -177,
		GOTOS => {
			'STAR-43' => 228
		}
	},
	{#State 115
		DEFAULT => -155
	},
	{#State 116
		ACTIONS => {
			'LPAREN' => 229
		}
	},
	{#State 117
		ACTIONS => {
			'LPAREN' => 120,
			'OP01_PRINT' => 119,
			"undef" => 121,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"if" => 116,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 123,
			'' => -18,
			'WORD_UPPERCASE' => 122,
			'LBRACKET' => 130,
			'OP01_NAMED_VOID_SCOLON' => 129,
			'CONSTANT_CALL_SCOPED' => 128,
			"foreach" => -152,
			'VARIABLE_SYMBOL' => 126,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"while" => -152,
			"\@{" => 133,
			'OP01_NAMED_VOID' => 135,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'OP19_LOOP_CONTROL' => 92,
			'OP01_NAMED_SCOLON' => 90,
			'OP22_LOGICAL_NEG' => 89,
			"for" => -152,
			'OP10_NAMED_UNARY' => 95,
			'MY' => 94,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"%{" => 102,
			'WORD' => 23,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Operation' => 230,
			'VariableModification' => 101,
			'Expression' => 100,
			'Literal' => 139,
			'Variable' => 107,
			'Statement' => 109,
			'VariableDeclaration' => 132,
			'LoopLabel' => 136,
			'OPTIONAL-37' => 104,
			'HashReference' => 105,
			'PAREN-36' => 118,
			'Conditional' => 113,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'OperatorVoid' => 115,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 93,
			'ArrayReference' => 124
		}
	},
	{#State 118
		DEFAULT => -151
	},
	{#State 119
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => -115,
			'LBRACKET' => -115,
			'WORD' => -115,
			"%{" => -115,
			'FHREF_SYMBOL_BRACES' => 234,
			'VARIABLE_SYMBOL' => -115,
			'CONSTANT_CALL_SCOPED' => -115,
			'LITERAL_NUMBER' => -115,
			'OP05_MATH_NEG_LPAREN' => -115,
			'LBRACE' => -115,
			'OP01_QW' => -115,
			'OP03_MATH_INC_DEC' => -115,
			'OP05_LOGICAL_NEG' => -115,
			'STDOUT_STDERR' => 232,
			"\@{" => -115,
			"undef" => -115,
			'LITERAL_STRING' => -115,
			'LPAREN' => -115,
			'OP22_LOGICAL_NEG' => -115,
			'SELF' => -115,
			'OP01_OPEN' => -115,
			'MY' => -115,
			'ARGV' => -115,
			'WORD_SCOPED' => -115,
			'OP10_NAMED_UNARY' => -115,
			'OP01_CLOSE' => -115,
			'WORD_UPPERCASE' => -115,
			'OP01_NAMED' => -115
		},
		GOTOS => {
			'OPTIONAL-32' => 231,
			'PAREN-31' => 233
		}
	},
	{#State 120
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 235,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP01_PRINT' => 236,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102
		},
		GOTOS => {
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 237,
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 121
		DEFAULT => -137
	},
	{#State 122
		ACTIONS => {
			'LPAREN' => 238,
			'COLON' => -220
		}
	},
	{#State 123
		ACTIONS => {
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'ARGV' => 222,
			'MY' => 180,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_QW' => 226,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'ListElement' => 239,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'Operator' => 98,
			'WordScoped' => 96,
			'TypeInner' => 227,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 240
		}
	},
	{#State 124
		DEFAULT => -140
	},
	{#State 125
		ACTIONS => {
			'FHREF_SYMBOL' => 241
		}
	},
	{#State 126
		DEFAULT => -233
	},
	{#State 127
		DEFAULT => -17
	},
	{#State 128
		DEFAULT => -132
	},
	{#State 129
		DEFAULT => -120
	},
	{#State 130
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"]" => -197,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'MY' => 180,
			'WORD_SCOPED' => 25,
			'ARGV' => 222
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'ListElements' => 243,
			'HashReference' => 105,
			'OPTIONAL-46' => 242,
			'ArrayReference' => 124,
			'SubExpression' => 221,
			'Operator' => 98,
			'WordScoped' => 96,
			'Literal' => 139,
			'TypeInner' => 227,
			'Variable' => 151
		}
	},
	{#State 131
		DEFAULT => -141
	},
	{#State 132
		DEFAULT => -156
	},
	{#State 133
		ACTIONS => {
			'LBRACKET' => -200,
			'MY' => 180,
			'SELF' => 97,
			'VARIABLE_SYMBOL' => 126
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'OPTIONAL-47' => 246,
			'TypeInner' => 244,
			'Variable' => 245
		}
	},
	{#State 134
		DEFAULT => -14
	},
	{#State 135
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP01_QW' => 226,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'ARGV' => 222,
			'MY' => 180,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 221,
			'Operator' => 98,
			'WordScoped' => 96,
			'Literal' => 139,
			'Variable' => 151,
			'TypeInner' => 227,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'ListElements' => 247
		}
	},
	{#State 136
		ACTIONS => {
			'COLON' => 248
		}
	},
	{#State 137
		ACTIONS => {
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 249
		}
	},
	{#State 138
		ACTIONS => {
			"\@{" => 133,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 250,
			'Operator' => 98,
			'WordScoped' => 96,
			'Literal' => 139,
			'Variable' => 151
		}
	},
	{#State 139
		DEFAULT => -138
	},
	{#State 140
		DEFAULT => -57
	},
	{#State 141
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 251
		}
	},
	{#State 142
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 252
		}
	},
	{#State 143
		DEFAULT => -43
	},
	{#State 144
		ACTIONS => {
			'WORD_UPPERCASE' => 253
		}
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 254
		}
	},
	{#State 146
		ACTIONS => {
			"undef" => 121,
			'OP01_PRINT' => 119,
			'LPAREN' => 120,
			"if" => 116,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP01_NAMED' => 123,
			'WORD_UPPERCASE' => 122,
			'OP01_NAMED_VOID_SCOLON' => 129,
			'LBRACKET' => 130,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"foreach" => -152,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_NAMED_VOID' => 135,
			"\@{" => 133,
			"while" => -152,
			'OP19_LOOP_CONTROL' => 92,
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'LITERAL_STRING' => 82,
			"for" => -152,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 90,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'MY' => 94,
			'OP10_NAMED_UNARY' => 95,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"%{" => 102,
			'WORD' => 23,
			"}" => 255,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108
		},
		GOTOS => {
			'VariableDeclaration' => 132,
			'LoopLabel' => 136,
			'HashReference' => 105,
			'OPTIONAL-37' => 104,
			'Variable' => 107,
			'Literal' => 139,
			'Statement' => 109,
			'Operation' => 256,
			'VariableModification' => 101,
			'Expression' => 100,
			'ArrayDereference' => 131,
			'SubExpression' => 93,
			'ArrayReference' => 124,
			'Operator' => 98,
			'WordScoped' => 96,
			'Conditional' => 113,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'OperatorVoid' => 115,
			'PAREN-36' => 118
		}
	},
	{#State 147
		ACTIONS => {
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 257
		}
	},
	{#State 148
		ACTIONS => {
			'LPAREN' => 238
		}
	},
	{#State 149
		ACTIONS => {
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -110,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			";" => -110,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			"]" => -110,
			'OP08_MATH_ADD_SUB' => 168,
			'OP04_MATH_POW' => 158,
			"}" => -110,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			")" => -110,
			'OP08_STRING_CAT' => 157,
			'OP21_LIST_COMMA' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 150
		DEFAULT => -136
	},
	{#State 151
		ACTIONS => {
			'OP16_LOGICAL_OR' => -139,
			'OP15_LOGICAL_AND' => -139,
			'OP07_MATH_MULT_DIV_MOD' => -139,
			'OP11_COMPARE_LT_GT' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			'OP13_BITWISE_AND' => -139,
			";" => -139,
			"]" => -139,
			'OP17_LIST_RANGE' => -139,
			'OP08_MATH_ADD_SUB' => -139,
			'OP04_MATH_POW' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			"}" => -139,
			'OP18_TERNARY' => -139,
			'OP07_STRING_REPEAT' => -139,
			")" => -139,
			'OP08_STRING_CAT' => -139,
			'OP21_LIST_COMMA' => -139,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP03_MATH_INC_DEC' => 218,
			'OP09_BITWISE_SHIFT' => -139,
			'OP02_METHOD_THINARROW' => 219
		}
	},
	{#State 152
		DEFAULT => -220
	},
	{#State 153
		ACTIONS => {
			";" => 258
		}
	},
	{#State 154
		ACTIONS => {
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 259
		}
	},
	{#State 155
		ACTIONS => {
			'VARIABLE_SYMBOL' => 126,
			'LITERAL_STRING' => 82,
			'LITERAL_NUMBER' => 83,
			'SELF' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Literal' => 262,
			'Variable' => 260,
			'VariableOrLiteral' => 261
		}
	},
	{#State 156
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 263,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'SubExpression' => 264,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 158
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 151,
			'Literal' => 139,
			'WordScoped' => 96,
			'Operator' => 98,
			'SubExpression' => 265,
			'ArrayReference' => 124,
			'HashReference' => 105
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148
		},
		GOTOS => {
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 266,
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'ArrayDereference' => 131
		}
	},
	{#State 160
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102
		},
		GOTOS => {
			'Variable' => 151,
			'Literal' => 139,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 267,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111
		}
	},
	{#State 161
		ACTIONS => {
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"%{" => 102,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133
		},
		GOTOS => {
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 268,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139
		}
	},
	{#State 162
		ACTIONS => {
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			"\@{" => 133
		},
		GOTOS => {
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 269,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 163
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 270
		}
	},
	{#State 164
		ACTIONS => {
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98,
			'SubExpression' => 271,
			'ArrayReference' => 124,
			'HashReference' => 105
		}
	},
	{#State 165
		ACTIONS => {
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP22_LOGICAL_NEG' => 89,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121
		},
		GOTOS => {
			'SubExpression' => 272,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Variable' => 151,
			'Literal' => 139,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 166
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133
		},
		GOTOS => {
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 273,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151
		}
	},
	{#State 167
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99
		},
		GOTOS => {
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 274,
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 168
		ACTIONS => {
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'SubExpression' => 275,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98
		}
	},
	{#State 169
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 151,
			'Literal' => 139,
			'WordScoped' => 96,
			'Operator' => 98,
			'SubExpression' => 276,
			'ArrayReference' => 124,
			'HashReference' => 105
		}
	},
	{#State 170
		ACTIONS => {
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Variable' => 151,
			'Literal' => 139,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 277,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111
		}
	},
	{#State 171
		ACTIONS => {
			'FHREF_SYMBOL' => 278
		}
	},
	{#State 172
		ACTIONS => {
			'VARIABLE_SYMBOL' => 279
		}
	},
	{#State 173
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			"]" => -100,
			'OP13_BITWISE_AND' => -100,
			";" => -100,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => 154,
			"}" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => -100,
			")" => -100,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 174
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 128,
			")" => -127,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'OP22_LOGICAL_NEG' => 89,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'MY' => 180,
			'ARGV' => 222,
			'SELF' => 97,
			'OP01_OPEN' => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'OPTIONAL-34' => 281,
			'HashDereference' => 111,
			'Expression' => 150,
			'ListElements' => 280,
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'SubExpression' => 221,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'Literal' => 139,
			'Variable' => 151,
			'TypeInner' => 227,
			'Operator' => 98,
			'WordScoped' => 96
		}
	},
	{#State 175
		ACTIONS => {
			")" => 282
		}
	},
	{#State 176
		ACTIONS => {
			'TYPE_FHREF' => 283
		}
	},
	{#State 177
		DEFAULT => -79
	},
	{#State 178
		DEFAULT => -157
	},
	{#State 179
		ACTIONS => {
			"}" => 284
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 285
		}
	},
	{#State 181
		DEFAULT => -214
	},
	{#State 182
		ACTIONS => {
			'LBRACE' => 106
		},
		GOTOS => {
			'HashReference' => 286
		}
	},
	{#State 183
		ACTIONS => {
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			")" => 287,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158
		}
	},
	{#State 184
		DEFAULT => -165
	},
	{#State 185
		ACTIONS => {
			'MY' => 288
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 289,
			'LPAREN_MY' => 290
		}
	},
	{#State 187
		DEFAULT => -154
	},
	{#State 188
		DEFAULT => -167
	},
	{#State 189
		ACTIONS => {
			'LPAREN_MY' => 292,
			'MY' => 291
		}
	},
	{#State 190
		DEFAULT => -166
	},
	{#State 191
		DEFAULT => -206
	},
	{#State 192
		DEFAULT => -246
	},
	{#State 193
		DEFAULT => -258
	},
	{#State 194
		DEFAULT => -232
	},
	{#State 195
		DEFAULT => -254
	},
	{#State 196
		DEFAULT => -251
	},
	{#State 197
		DEFAULT => -249
	},
	{#State 198
		DEFAULT => -255
	},
	{#State 199
		DEFAULT => -211,
		GOTOS => {
			'STAR-50' => 293
		}
	},
	{#State 200
		DEFAULT => -257
	},
	{#State 201
		ACTIONS => {
			'OP20_HASH_FATARROW' => 294
		}
	},
	{#State 202
		DEFAULT => -231
	},
	{#State 203
		DEFAULT => -252
	},
	{#State 204
		DEFAULT => -245
	},
	{#State 205
		DEFAULT => -247
	},
	{#State 206
		DEFAULT => -207
	},
	{#State 207
		DEFAULT => -244
	},
	{#State 208
		DEFAULT => -256
	},
	{#State 209
		DEFAULT => -250
	},
	{#State 210
		DEFAULT => -259
	},
	{#State 211
		DEFAULT => -253
	},
	{#State 212
		DEFAULT => -248
	},
	{#State 213
		DEFAULT => -213
	},
	{#State 214
		DEFAULT => -243
	},
	{#State 215
		DEFAULT => -230
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'FHREF_SYMBOL_IN' => 298,
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 83,
			'OP22_LOGICAL_NEG' => 89,
			'STDIN' => 297,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'OP01_OPEN' => 99,
			'SELF' => 97
		},
		GOTOS => {
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 296,
			'SubExpressionOrInput' => 295,
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 217
		ACTIONS => {
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 299,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150
		}
	},
	{#State 218
		DEFAULT => -89
	},
	{#State 219
		ACTIONS => {
			'LPAREN' => 300
		}
	},
	{#State 220
		DEFAULT => -88
	},
	{#State 221
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 167,
			";" => -192,
			'OP17_LIST_RANGE' => 166,
			"]" => -192,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			")" => -192,
			'OP21_LIST_COMMA' => -192,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154
		}
	},
	{#State 222
		DEFAULT => -195
	},
	{#State 223
		DEFAULT => -116
	},
	{#State 224
		ACTIONS => {
			")" => 301
		}
	},
	{#State 225
		DEFAULT => -190,
		GOTOS => {
			'STAR-45' => 302
		}
	},
	{#State 226
		DEFAULT => -194
	},
	{#State 227
		ACTIONS => {
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'Variable' => 151,
			'Literal' => 139,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 303,
			'HashReference' => 105,
			'ArrayReference' => 124
		}
	},
	{#State 228
		ACTIONS => {
			'OP15_LOGICAL_AND' => -178,
			'OP16_LOGICAL_OR' => -178,
			'OP02_HASH_THINARROW' => 304,
			'OP07_MATH_MULT_DIV_MOD' => -178,
			'OP19_VARIABLE_ASSIGN' => -178,
			'OP14_BITWISE_OR_XOR' => -178,
			'OP06_REGEX_MATCH' => -178,
			'OP11_COMPARE_LT_GT' => -178,
			'OP23_LOGICAL_AND' => -178,
			'OP08_MATH_ADD_SUB' => -178,
			'COLON' => -178,
			'OP13_BITWISE_AND' => -178,
			";" => -178,
			'OP20_HASH_FATARROW' => -178,
			"]" => -178,
			'OP17_LIST_RANGE' => -178,
			'OP02_ARRAY_THINARROW' => 305,
			'OP04_MATH_POW' => -178,
			")" => -178,
			'OP19_VARIABLE_ASSIGN_BY' => -178,
			'OP08_STRING_CAT' => -178,
			'OP21_LIST_COMMA' => -178,
			'OP12_COMPARE_EQ_NE' => -178,
			"}" => -178,
			'OP07_STRING_REPEAT' => -178,
			'OP18_TERNARY' => -178,
			'OP03_MATH_INC_DEC' => -178,
			'OP24_LOGICAL_OR_XOR' => -178,
			'OP09_BITWISE_SHIFT' => -178,
			'OP02_METHOD_THINARROW' => -178
		},
		GOTOS => {
			'VariableRetrieval' => 306
		}
	},
	{#State 229
		ACTIONS => {
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			"%{" => 102,
			'WORD' => 23,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 307
		}
	},
	{#State 230
		DEFAULT => -16
	},
	{#State 231
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"\@{" => 133,
			'OP01_QW' => 226,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'OP22_LOGICAL_NEG' => 89,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'MY' => 180,
			'ARGV' => 222,
			'SELF' => 97,
			'OP01_OPEN' => 99
		},
		GOTOS => {
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139,
			'TypeInner' => 227,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 221,
			'ListElement' => 225,
			'ArrayDereference' => 131,
			'ListElements' => 308,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 232
		DEFAULT => -113
	},
	{#State 233
		DEFAULT => -114
	},
	{#State 234
		ACTIONS => {
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"%{" => 102,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP01_QW' => 226,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 25,
			'MY' => 180,
			'ARGV' => 222,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148
		},
		GOTOS => {
			'SubExpression' => 221,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'Literal' => 139,
			'Variable' => 151,
			'TypeInner' => 227,
			'Operator' => 98,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ListElements' => 309,
			'ArrayDereference' => 131,
			'ListElement' => 225
		}
	},
	{#State 235
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP01_QW' => 226,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'ARGV' => 222,
			'MY' => 180,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'ListElement' => 310,
			'ArrayDereference' => 131,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139,
			'TypeInner' => 227,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 240
		}
	},
	{#State 236
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 311
		}
	},
	{#State 237
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			")" => 312,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165
		}
	},
	{#State 238
		ACTIONS => {
			")" => 313
		}
	},
	{#State 239
		ACTIONS => {
			'OP21_LIST_COMMA' => 314
		}
	},
	{#State 240
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			'OP04_MATH_POW' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			'OP18_TERNARY' => -84,
			'OP07_STRING_REPEAT' => -84,
			")" => -84,
			'OP08_STRING_CAT' => -84,
			'OP21_LIST_COMMA' => -192,
			'OP11_COMPARE_LT_GT' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			";" => -84,
			'OP13_BITWISE_AND' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84
		}
	},
	{#State 241
		DEFAULT => -87
	},
	{#State 242
		ACTIONS => {
			"]" => 315
		}
	},
	{#State 243
		DEFAULT => -196
	},
	{#State 244
		DEFAULT => -199
	},
	{#State 245
		ACTIONS => {
			"}" => 316
		}
	},
	{#State 246
		ACTIONS => {
			'LBRACKET' => 130
		},
		GOTOS => {
			'ArrayReference' => 317
		}
	},
	{#State 247
		ACTIONS => {
			";" => 318
		}
	},
	{#State 248
		DEFAULT => -150
	},
	{#State 249
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			")" => 319,
			'OP08_STRING_CAT' => 157,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP12_COMPARE_EQ_NE' => 156
		}
	},
	{#State 250
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP07_STRING_REPEAT' => -92,
			"}" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			")" => -92,
			'OP08_STRING_CAT' => -92,
			'OP04_MATH_POW' => 158,
			"]" => -92,
			'OP17_LIST_RANGE' => -92,
			";" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP15_LOGICAL_AND' => -92
		}
	},
	{#State 251
		ACTIONS => {
			'LBRACE' => 321,
			'VARIABLE_SYMBOL' => 320
		}
	},
	{#State 252
		ACTIONS => {
			"our" => 323,
			'LITERAL_NUMBER' => 322
		},
		GOTOS => {
			'Method' => 325,
			'Subroutine' => 324,
			'SubroutineOrMethod' => 326
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
			'OP09_BITWISE_SHIFT' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP08_STRING_CAT' => -84,
			")" => -84,
			'OP21_LIST_COMMA' => -84,
			"}" => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			'OP18_TERNARY' => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP04_MATH_POW' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP13_BITWISE_AND' => -84,
			";" => -84,
			'OP17_LIST_RANGE' => -84,
			"]" => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP16_LOGICAL_OR' => -84
		}
	},
	{#State 258
		DEFAULT => -125
	},
	{#State 259
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			";" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP08_STRING_CAT' => -95,
			")" => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP18_TERNARY' => -95,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95
		}
	},
	{#State 260
		DEFAULT => -228
	},
	{#State 261
		ACTIONS => {
			'COLON' => 330
		}
	},
	{#State 262
		DEFAULT => -229
	},
	{#State 263
		ACTIONS => {
			'OP15_LOGICAL_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			"]" => -103,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			")" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -103,
			'OP18_TERNARY' => -103,
			'OP07_STRING_REPEAT' => 154,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 264
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98,
			";" => -98,
			"]" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 163,
			"}" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => -98,
			")" => -98,
			'OP08_STRING_CAT' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => -98,
			'OP24_LOGICAL_OR_XOR' => -98
		}
	},
	{#State 265
		ACTIONS => {
			'OP16_LOGICAL_OR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			"]" => -90,
			'OP17_LIST_RANGE' => -90,
			";" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP04_MATH_POW' => 158,
			'OP07_STRING_REPEAT' => -90,
			'OP18_TERNARY' => -90,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP21_LIST_COMMA' => -90,
			")" => -90,
			'OP08_STRING_CAT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP09_BITWISE_SHIFT' => -90
		}
	},
	{#State 266
		ACTIONS => {
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 167,
			";" => -112,
			"]" => -112,
			'OP17_LIST_RANGE' => 166,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			")" => -112,
			'OP21_LIST_COMMA' => -112,
			"}" => -112,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154
		}
	},
	{#State 267
		ACTIONS => {
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP04_MATH_POW' => 158,
			'OP12_COMPARE_EQ_NE' => -96,
			"}" => -96,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => -96,
			")" => -96,
			'OP08_STRING_CAT' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => -96
		}
	},
	{#State 268
		ACTIONS => {
			'OP21_LIST_COMMA' => -107,
			'OP08_STRING_CAT' => 157,
			")" => -107,
			'OP18_TERNARY' => -107,
			'OP07_STRING_REPEAT' => 154,
			"}" => -107,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => -107,
			'OP08_MATH_ADD_SUB' => 168,
			"]" => -107,
			'OP17_LIST_RANGE' => -107,
			";" => -107,
			'OP13_BITWISE_AND' => 167,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 169
		}
	},
	{#State 269
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			")" => -111,
			'OP21_LIST_COMMA' => -111,
			"}" => -111,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -111,
			'OP13_BITWISE_AND' => 167,
			"]" => -111,
			'OP17_LIST_RANGE' => 166,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -111
		}
	},
	{#State 270
		DEFAULT => -94
	},
	{#State 271
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 168,
			"]" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP13_BITWISE_AND' => -99,
			";" => -99,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_STRING_CAT' => 157,
			")" => -99,
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 154,
			"}" => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP04_MATH_POW' => 158
		}
	},
	{#State 272
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 156,
			"}" => -106,
			'OP18_TERNARY' => -106,
			'OP07_STRING_REPEAT' => 154,
			")" => -106,
			'OP08_STRING_CAT' => 157,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 158,
			";" => -106,
			'OP13_BITWISE_AND' => 167,
			"]" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => -106,
			'OP15_LOGICAL_AND' => -106
		}
	},
	{#State 273
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			")" => -108,
			'OP21_LIST_COMMA' => -108,
			"}" => -108,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => -108,
			'OP07_STRING_REPEAT' => 154,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -108,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => undef,
			"]" => -108,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 274
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			"]" => -104,
			'OP17_LIST_RANGE' => -104,
			";" => -104,
			'OP13_BITWISE_AND' => -104,
			'OP04_MATH_POW' => 158,
			'OP21_LIST_COMMA' => -104,
			'OP08_STRING_CAT' => 157,
			")" => -104,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => -104,
			"}" => -104,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 275
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => -97,
			")" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			"}" => -97,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => 154,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'OP13_BITWISE_AND' => -97,
			";" => -97,
			'OP17_LIST_RANGE' => -97,
			"]" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 160
		}
	},
	{#State 276
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			")" => -102,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => -102,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 163,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => -102,
			";" => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 160
		}
	},
	{#State 277
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_STRING_CAT' => 157,
			")" => -105,
			'OP21_LIST_COMMA' => -105,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => -105,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 167,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			"]" => -105,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 278
		ACTIONS => {
			";" => 331
		}
	},
	{#State 279
		ACTIONS => {
			";" => 334,
			'OP02_ARRAY_THINARROW' => 332,
			'OP19_VARIABLE_ASSIGN' => 333
		}
	},
	{#State 280
		DEFAULT => -126
	},
	{#State 281
		ACTIONS => {
			")" => 335
		}
	},
	{#State 282
		DEFAULT => -135
	},
	{#State 283
		ACTIONS => {
			'FHREF_SYMBOL' => 336
		}
	},
	{#State 284
		DEFAULT => -216
	},
	{#State 285
		ACTIONS => {
			"\$TYPED_" => 337
		}
	},
	{#State 286
		ACTIONS => {
			"}" => 338
		}
	},
	{#State 287
		DEFAULT => -91
	},
	{#State 288
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 339
		}
	},
	{#State 289
		ACTIONS => {
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP22_LOGICAL_NEG' => 89,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			"\@{" => 133
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'Literal' => 139,
			'Variable' => 151,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 340,
			'HashReference' => 105,
			'ArrayReference' => 124
		}
	},
	{#State 290
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 341
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_INTEGER' => 342
		}
	},
	{#State 292
		ACTIONS => {
			'TYPE_INTEGER' => 343
		}
	},
	{#State 293
		ACTIONS => {
			"}" => 345,
			'OP21_LIST_COMMA' => 344
		},
		GOTOS => {
			'PAREN-49' => 346
		}
	},
	{#State 294
		ACTIONS => {
			"%{" => -204,
			'WORD' => -204,
			'CONSTANT_CALL_SCOPED' => -204,
			'VARIABLE_SYMBOL' => -204,
			'OP05_BITWISE_NEG_LPAREN' => -204,
			'LBRACKET' => -204,
			"\@{" => -204,
			'LITERAL_NUMBER' => -204,
			'LBRACE' => -204,
			'OP03_MATH_INC_DEC' => -204,
			'OP05_LOGICAL_NEG' => -204,
			'OP05_MATH_NEG_LPAREN' => -204,
			'OP22_LOGICAL_NEG' => -204,
			"undef" => -204,
			'LITERAL_STRING' => -204,
			'LPAREN' => -204,
			'OP01_NAMED' => -204,
			'WORD_UPPERCASE' => -204,
			'OP01_OPEN' => -204,
			'SELF' => -204,
			'OP10_NAMED_UNARY' => -204,
			'OP01_CLOSE' => -204,
			'WORD_SCOPED' => -204,
			'MY' => 180
		},
		GOTOS => {
			'TypeInner' => 347,
			'OPTIONAL-48' => 348
		}
	},
	{#State 295
		DEFAULT => -186
	},
	{#State 296
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 167,
			";" => -145,
			'OP17_LIST_RANGE' => 166,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP08_STRING_CAT' => 157,
			")" => -145,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP04_MATH_POW' => 158
		}
	},
	{#State 297
		DEFAULT => -147
	},
	{#State 298
		DEFAULT => -146
	},
	{#State 299
		ACTIONS => {
			";" => -187,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			")" => -187,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158
		}
	},
	{#State 300
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'ARGV' => 222,
			'MY' => 180,
			'WORD' => 23,
			"%{" => 102,
			")" => -129,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'ListElements' => 349,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'Operator' => 98,
			'OPTIONAL-35' => 350,
			'WordScoped' => 96,
			'TypeInner' => 227,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 221
		}
	},
	{#State 301
		ACTIONS => {
			";" => 351
		}
	},
	{#State 302
		ACTIONS => {
			"]" => -191,
			";" => -191,
			'OP21_LIST_COMMA' => 352,
			")" => -191
		},
		GOTOS => {
			'PAREN-44' => 353
		}
	},
	{#State 303
		ACTIONS => {
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP21_LIST_COMMA' => -193,
			")" => -193,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			"]" => -193,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			";" => -193,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 304
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"%{" => 102,
			'WORD' => 354,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'LITERAL_NUMBER' => 83,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP22_LOGICAL_NEG' => 89,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148
		},
		GOTOS => {
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'SubExpression' => 355,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98
		}
	},
	{#State 305
		ACTIONS => {
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			"\@{" => 133,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128
		},
		GOTOS => {
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 356,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150
		}
	},
	{#State 306
		DEFAULT => -176
	},
	{#State 307
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP08_STRING_CAT' => 157,
			")" => 357,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159
		}
	},
	{#State 308
		ACTIONS => {
			";" => 358
		}
	},
	{#State 309
		ACTIONS => {
			";" => 359
		}
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 360
		}
	},
	{#State 311
		ACTIONS => {
			"\@{" => 133,
			'LBRACE' => 106,
			'OP01_QW' => 226,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'MY' => 180,
			'ARGV' => 222,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'SubExpression' => 221,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'TypeInner' => 227,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ListElements' => 361,
			'ListElement' => 225,
			'ArrayDereference' => 131
		}
	},
	{#State 312
		DEFAULT => -144
	},
	{#State 313
		DEFAULT => -131
	},
	{#State 314
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'ARGV' => 222,
			'WORD_SCOPED' => 25,
			'MY' => 180,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP01_QW' => 226,
			'LBRACE' => 106
		},
		GOTOS => {
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 221,
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'TypeInner' => 227,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'ListElements' => 362
		}
	},
	{#State 315
		DEFAULT => -198
	},
	{#State 316
		DEFAULT => -201
	},
	{#State 317
		ACTIONS => {
			"}" => 363
		}
	},
	{#State 318
		DEFAULT => -122
	},
	{#State 319
		DEFAULT => -93
	},
	{#State 320
		ACTIONS => {
			";" => 364
		}
	},
	{#State 321
		ACTIONS => {
			'OP07_STRING_REPEAT' => 211,
			'WORD' => 210,
			'OP12_COMPARE_EQ_NE' => 212,
			"}" => 365,
			'OP01_NAMED_VOID' => 200,
			'OP24_LOGICAL_OR_XOR' => 214,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP22_LOGICAL_NEG' => 204,
			'OP19_LOOP_CONTROL' => 205,
			'OP01_PRINT' => 193,
			'OP01_NAMED' => 195,
			'OP08_MATH_ADD_SUB' => 196,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 197,
			'OP01_OPEN' => 208,
			'OP10_NAMED_UNARY' => 209,
			'OP01_CLOSE' => 198
		},
		GOTOS => {
			'HashEntryProperties' => 366,
			'OpStringOrWord' => 367
		}
	},
	{#State 322
		ACTIONS => {
			";" => 368
		}
	},
	{#State 323
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'TYPE_METHOD' => 369,
			'WORD_SCOPED' => 55,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 324
		DEFAULT => -77
	},
	{#State 325
		DEFAULT => -78
	},
	{#State 326
		DEFAULT => -59
	},
	{#State 327
		DEFAULT => -227
	},
	{#State 328
		ACTIONS => {
			'OP21_LIST_COMMA' => 370,
			")" => 371
		},
		GOTOS => {
			'PAREN-19' => 372
		}
	},
	{#State 329
		DEFAULT => -48
	},
	{#State 330
		ACTIONS => {
			'VARIABLE_SYMBOL' => 126,
			'SELF' => 97,
			'LITERAL_NUMBER' => 83,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'VariableOrLiteral' => 373,
			'Literal' => 262,
			'Variable' => 260
		}
	},
	{#State 331
		DEFAULT => -185
	},
	{#State 332
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'Operator' => 98,
			'WordScoped' => 96,
			'Variable' => 151,
			'Literal' => 139,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 374
		}
	},
	{#State 333
		ACTIONS => {
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'FHREF_SYMBOL_IN' => 298,
			'LBRACKET' => 130,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'STDIN' => 297,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 378,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP10_NAMED_UNARY_SCOLON' => 377
		},
		GOTOS => {
			'OpNamedScolonOrSubExpIn' => 376,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'Variable' => 151,
			'Literal' => 139,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpressionOrInput' => 375,
			'SubExpression' => 296,
			'HashReference' => 105,
			'ArrayReference' => 124
		}
	},
	{#State 334
		DEFAULT => -182
	},
	{#State 335
		DEFAULT => -133
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 379
		}
	},
	{#State 337
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP22_LOGICAL_NEG' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'OP01_PRINT' => 193,
			'OP19_LOOP_CONTROL' => 205,
			'OP01_NAMED' => 195,
			'OP08_MATH_ADD_SUB' => 196,
			'OP10_NAMED_UNARY' => 209,
			'OP01_CLOSE' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 197,
			'OP01_OPEN' => 208,
			'OP07_STRING_REPEAT' => 211,
			'WORD' => 210,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP01_NAMED_VOID' => 200,
			'OP24_LOGICAL_OR_XOR' => 214
		},
		GOTOS => {
			'OpStringOrWord' => 380
		}
	},
	{#State 338
		DEFAULT => -217
	},
	{#State 339
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 340
		ACTIONS => {
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			")" => 382,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 344
		ACTIONS => {
			'OP01_CLOSE' => 198,
			'OP10_NAMED_UNARY' => 209,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 197,
			'OP01_OPEN' => 208,
			'SELF' => 97,
			'OP01_NAMED' => 195,
			'OP08_MATH_ADD_SUB' => 196,
			'ENV' => 206,
			'OP01_PRINT' => 193,
			'LITERAL_STRING' => 82,
			'OP19_LOOP_CONTROL' => 205,
			'OP22_LOGICAL_NEG' => 204,
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'LITERAL_NUMBER' => 83,
			'OP24_LOGICAL_OR_XOR' => 214,
			'OP01_NAMED_VOID' => 200,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP12_COMPARE_EQ_NE' => 212
		},
		GOTOS => {
			'HashDereference' => 191,
			'VariableSymbolOrSelf' => 114,
			'VarOrLitOrOpStrOrWord' => 201,
			'OpStringOrWord' => 194,
			'Variable' => 215,
			'HashEntry' => 386,
			'Literal' => 202
		}
	},
	{#State 345
		DEFAULT => -212
	},
	{#State 346
		DEFAULT => -210
	},
	{#State 347
		DEFAULT => -203
	},
	{#State 348
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 387,
			'WordScoped' => 96,
			'Operator' => 98,
			'Literal' => 139,
			'Variable' => 151,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 349
		DEFAULT => -128
	},
	{#State 350
		ACTIONS => {
			")" => 388
		}
	},
	{#State 351
		DEFAULT => -121
	},
	{#State 352
		ACTIONS => {
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'ARGV' => 222,
			'MY' => 180,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LBRACE' => 106,
			'OP01_QW' => 226,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			"\@{" => 133,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128
		},
		GOTOS => {
			'ListElement' => 389,
			'ArrayDereference' => 131,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 139,
			'Variable' => 151,
			'TypeInner' => 227,
			'WordScoped' => 96,
			'Operator' => 98,
			'SubExpression' => 221,
			'ArrayReference' => 124,
			'HashReference' => 105
		}
	},
	{#State 353
		DEFAULT => -189
	},
	{#State 354
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -218,
			"}" => 390,
			'LPAREN' => -218
		}
	},
	{#State 355
		ACTIONS => {
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			"}" => 391,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167
		}
	},
	{#State 356
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP17_LIST_RANGE' => 166,
			"]" => 392,
			'OP13_BITWISE_AND' => 167,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159
		}
	},
	{#State 357
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 394
		}
	},
	{#State 358
		DEFAULT => -118
	},
	{#State 359
		DEFAULT => -119
	},
	{#State 360
		ACTIONS => {
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'MY' => 180,
			'WORD_SCOPED' => 25,
			'ARGV' => 222,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'ListElement' => 225,
			'ListElements' => 395,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'Operator' => 98,
			'WordScoped' => 96,
			'TypeInner' => 227,
			'Literal' => 139,
			'Variable' => 151,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'SubExpression' => 221
		}
	},
	{#State 361
		ACTIONS => {
			")" => 396
		}
	},
	{#State 362
		ACTIONS => {
			";" => 397
		}
	},
	{#State 363
		DEFAULT => -202
	},
	{#State 364
		DEFAULT => -67
	},
	{#State 365
		ACTIONS => {
			";" => 398
		}
	},
	{#State 366
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 399
		}
	},
	{#State 367
		ACTIONS => {
			'OP20_HASH_FATARROW' => 400
		}
	},
	{#State 368
		DEFAULT => -61
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 370
		ACTIONS => {
			'MY' => 402
		}
	},
	{#State 371
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 372
		DEFAULT => -50
	},
	{#State 373
		DEFAULT => -109
	},
	{#State 374
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			"]" => 404,
			'OP13_BITWISE_AND' => 167,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160
		}
	},
	{#State 375
		ACTIONS => {
			";" => 405
		}
	},
	{#State 376
		DEFAULT => -183
	},
	{#State 377
		DEFAULT => -241
	},
	{#State 378
		DEFAULT => -240
	},
	{#State 379
		ACTIONS => {
			'LITERAL_STRING' => 406
		}
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 381
		ACTIONS => {
			'LPAREN' => 408
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 409
		}
	},
	{#State 383
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 384
		ACTIONS => {
			'LPAREN' => 411
		}
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 386
		DEFAULT => -209
	},
	{#State 387
		ACTIONS => {
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			'OP04_MATH_POW' => 158,
			'OP21_LIST_COMMA' => -205,
			'OP08_STRING_CAT' => 157,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			"}" => -205,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 388
		DEFAULT => -134
	},
	{#State 389
		DEFAULT => -188
	},
	{#State 390
		DEFAULT => -181
	},
	{#State 391
		DEFAULT => -180
	},
	{#State 392
		DEFAULT => -179
	},
	{#State 393
		ACTIONS => {
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'WORD' => 23,
			"%{" => 102,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'MY' => 94,
			'OP10_NAMED_UNARY' => 95,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 90,
			"for" => -152,
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'LITERAL_STRING' => 82,
			'OP19_LOOP_CONTROL' => 92,
			"\@{" => 133,
			"while" => -152,
			'OP01_NAMED_VOID' => 135,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"foreach" => -152,
			'LBRACKET' => 130,
			'OP01_NAMED_VOID_SCOLON' => 129,
			'OP01_NAMED' => 123,
			'WORD_UPPERCASE' => 122,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP01_NAMED_VOID_LPAREN' => 112,
			"if" => 116,
			'OP01_PRINT' => 119,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'Variable' => 107,
			'Literal' => 139,
			'PLUS-42' => 414,
			'Statement' => 109,
			'VariableDeclaration' => 132,
			'LoopLabel' => 136,
			'HashReference' => 105,
			'OPTIONAL-37' => 104,
			'ArrayDereference' => 131,
			'Operation' => 413,
			'VariableModification' => 101,
			'Expression' => 100,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 93,
			'ArrayReference' => 124,
			'PAREN-36' => 118,
			'VariableSymbolOrSelf' => 114,
			'Conditional' => 113,
			'HashDereference' => 111,
			'OperatorVoid' => 115
		}
	},
	{#State 394
		DEFAULT => -160,
		GOTOS => {
			'STAR-39' => 415
		}
	},
	{#State 395
		ACTIONS => {
			")" => 416
		}
	},
	{#State 396
		DEFAULT => -83
	},
	{#State 397
		DEFAULT => -123
	},
	{#State 398
		DEFAULT => -66
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 418,
			"}" => 417
		},
		GOTOS => {
			'PAREN-25' => 419
		}
	},
	{#State 400
		ACTIONS => {
			'MY' => 420
		},
		GOTOS => {
			'TypeInnerProperties' => 421
		}
	},
	{#State 401
		ACTIONS => {
			"= sub {" => 422
		}
	},
	{#State 402
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 58
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
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 425
		}
	},
	{#State 405
		DEFAULT => -242
	},
	{#State 406
		ACTIONS => {
			'OP21_LIST_COMMA' => 426
		}
	},
	{#State 407
		DEFAULT => -224
	},
	{#State 408
		ACTIONS => {
			"\@{" => 133,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP01_QW' => 226,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'MY' => 180,
			'ARGV' => 222,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'ListElement' => 225,
			'ArrayDereference' => 131,
			'ListElements' => 427,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'WordScoped' => 96,
			'Operator' => 98,
			'TypeInner' => 227,
			'Variable' => 151,
			'Literal' => 139,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 221
		}
	},
	{#State 409
		DEFAULT => -171
	},
	{#State 410
		ACTIONS => {
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102,
			'LBRACKET' => 130,
			'FHREF_SYMBOL_IN' => 298,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'STDIN' => 297,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131,
			'SubExpressionOrInput' => 428,
			'SubExpression' => 296,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'Literal' => 139,
			'Variable' => 151,
			'Operator' => 98,
			'WordScoped' => 96
		}
	},
	{#State 411
		ACTIONS => {
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133
		},
		GOTOS => {
			'SubExpression' => 429,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'Literal' => 139,
			'Variable' => 151,
			'Operator' => 98,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131
		}
	},
	{#State 412
		ACTIONS => {
			'WORD' => 23,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 431,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY_SCOLON' => 430,
			'LPAREN' => 120,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'Variable' => 151,
			'Literal' => 139,
			'OpNamedScolonOrSubExp' => 433,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 432,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150
		}
	},
	{#State 413
		DEFAULT => -174
	},
	{#State 414
		ACTIONS => {
			'WORD' => 23,
			"%{" => 102,
			"}" => 434,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			"for" => -152,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 90,
			'OP19_LOOP_CONTROL' => 92,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'MY' => 94,
			'OP10_NAMED_UNARY' => 95,
			'VARIABLE_SYMBOL' => 126,
			"foreach" => -152,
			'CONSTANT_CALL_SCOPED' => 128,
			'LBRACKET' => 130,
			'OP01_NAMED_VOID_SCOLON' => 129,
			'OP01_NAMED_VOID' => 135,
			"while" => -152,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			"if" => 116,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"undef" => 121,
			'OP01_PRINT' => 119,
			'LPAREN' => 120,
			'WORD_UPPERCASE' => 122,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125
		},
		GOTOS => {
			'OperatorVoid' => 115,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'Conditional' => 113,
			'PAREN-36' => 118,
			'ArrayReference' => 124,
			'SubExpression' => 93,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 100,
			'Operation' => 435,
			'VariableModification' => 101,
			'ArrayDereference' => 131,
			'HashReference' => 105,
			'OPTIONAL-37' => 104,
			'LoopLabel' => 136,
			'VariableDeclaration' => 132,
			'Statement' => 109,
			'Literal' => 139,
			'Variable' => 107
		}
	},
	{#State 415
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => -163,
			"}" => -163,
			'WORD' => -163,
			"%{" => -163,
			'OP03_MATH_INC_DEC' => -163,
			'LBRACE' => -163,
			'OP10_NAMED_UNARY_SCOLON' => -163,
			"else" => 436,
			'LITERAL_STRING' => -163,
			'OP19_LOOP_CONTROL' => -163,
			'OP01_NAMED_SCOLON' => -163,
			'OP22_LOGICAL_NEG' => -163,
			"for" => -163,
			'OP10_NAMED_UNARY' => -163,
			'MY' => -163,
			'OP01_OPEN' => -163,
			'SELF' => -163,
			'LBRACKET' => -163,
			'OP01_NAMED_VOID_SCOLON' => -163,
			'CONSTANT_CALL_SCOPED' => -163,
			"foreach" => -163,
			'VARIABLE_SYMBOL' => -163,
			'OP05_LOGICAL_NEG' => -163,
			"elsif" => 439,
			'OP05_MATH_NEG_LPAREN' => -163,
			'LITERAL_NUMBER' => -163,
			"\@{" => -163,
			"while" => -163,
			'OP01_NAMED_VOID' => -163,
			'LPAREN' => -163,
			'OP01_PRINT' => -163,
			"undef" => -163,
			'OP19_LOOP_CONTROL_SCOLON' => -163,
			'OP01_NAMED_VOID_LPAREN' => -163,
			"if" => -163,
			'OP01_CLOSE' => -163,
			'WORD_SCOPED' => -163,
			'OP01_NAMED' => -163,
			'' => -163,
			'WORD_UPPERCASE' => -163
		},
		GOTOS => {
			'PAREN-38' => 438,
			'OPTIONAL-41' => 440,
			'PAREN-40' => 437
		}
	},
	{#State 416
		DEFAULT => -85
	},
	{#State 417
		ACTIONS => {
			";" => 441
		}
	},
	{#State 418
		ACTIONS => {
			'OP01_NAMED' => 195,
			'OP08_MATH_ADD_SUB' => 196,
			'OP23_LOGICAL_AND' => 207,
			'OP01_OPEN' => 208,
			'OP11_COMPARE_LT_GT' => 197,
			'OP10_NAMED_UNARY' => 209,
			'OP01_CLOSE' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'OP22_LOGICAL_NEG' => 204,
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP19_LOOP_CONTROL' => 205,
			'OP01_PRINT' => 193,
			'OP01_NAMED_VOID' => 200,
			'OP24_LOGICAL_OR_XOR' => 214,
			'WORD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP12_COMPARE_EQ_NE' => 212
		},
		GOTOS => {
			'HashEntryProperties' => 442,
			'OpStringOrWord' => 367
		}
	},
	{#State 419
		DEFAULT => -63
	},
	{#State 420
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 443
		}
	},
	{#State 421
		DEFAULT => -208
	},
	{#State 422
		ACTIONS => {
			'OP01_OPEN' => -69,
			'SELF' => -69,
			'OP10_NAMED_UNARY' => -69,
			'MY' => -69,
			"for" => -69,
			'OP01_NAMED_SCOLON' => -69,
			'OP22_LOGICAL_NEG' => -69,
			'OP19_LOOP_CONTROL' => -69,
			'OP10_NAMED_UNARY_SCOLON' => -69,
			'LITERAL_STRING' => -69,
			'OP03_MATH_INC_DEC' => -69,
			'LBRACE' => -69,
			'LPAREN_MY' => 445,
			"}" => -69,
			'WORD' => -69,
			"%{" => -69,
			'OP05_BITWISE_NEG_LPAREN' => -69,
			'WORD_UPPERCASE' => -69,
			'OP01_NAMED' => -69,
			'OP01_CLOSE' => -69,
			'WORD_SCOPED' => -69,
			"if" => -69,
			'OP01_NAMED_VOID_LPAREN' => -69,
			'OP19_LOOP_CONTROL_SCOLON' => -69,
			"undef" => -69,
			'LPAREN' => -69,
			'OP01_PRINT' => -69,
			'OP01_NAMED_VOID' => -69,
			"while" => -69,
			"\@{" => -69,
			'LITERAL_NUMBER' => -69,
			'OP05_LOGICAL_NEG' => -69,
			'OP05_MATH_NEG_LPAREN' => -69,
			"foreach" => -69,
			'CONSTANT_CALL_SCOPED' => -69,
			'VARIABLE_SYMBOL' => -69,
			'OP01_NAMED_VOID_SCOLON' => -69,
			'LBRACKET' => -69
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
		ACTIONS => {
			"undef" => 448
		}
	},
	{#State 426
		ACTIONS => {
			"\@{" => 133,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			"%{" => 102,
			'WORD' => 23,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95,
			'WORD_SCOPED' => 25,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121
		},
		GOTOS => {
			'SubExpression' => 449,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Variable' => 151,
			'Literal' => 139,
			'WordScoped' => 96,
			'Operator' => 98,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 427
		ACTIONS => {
			")" => 450
		}
	},
	{#State 428
		ACTIONS => {
			")" => 451
		}
	},
	{#State 429
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 452,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159
		}
	},
	{#State 430
		DEFAULT => -238
	},
	{#State 431
		DEFAULT => -237
	},
	{#State 432
		ACTIONS => {
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP17_LIST_RANGE' => 166,
			";" => 453,
			'OP13_BITWISE_AND' => 167,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 433
		ACTIONS => {
			'VARIABLE_SYMBOL' => 454
		}
	},
	{#State 434
		DEFAULT => -175
	},
	{#State 435
		DEFAULT => -173
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 437
		DEFAULT => -162
	},
	{#State 438
		DEFAULT => -159
	},
	{#State 439
		ACTIONS => {
			'LPAREN' => 456
		}
	},
	{#State 440
		DEFAULT => -164
	},
	{#State 441
		DEFAULT => -65
	},
	{#State 442
		DEFAULT => -62
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
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 58
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
			";" => 460
		}
	},
	{#State 449
		ACTIONS => {
			'OP04_MATH_POW' => 158,
			'OP21_LIST_COMMA' => -86,
			'OP08_STRING_CAT' => 157,
			")" => -86,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			"}" => -86,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => 164,
			'OP15_LOGICAL_AND' => 165,
			'OP16_LOGICAL_OR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP23_LOGICAL_AND' => -86,
			'OP11_COMPARE_LT_GT' => 169,
			'OP08_MATH_ADD_SUB' => 168,
			'OP17_LIST_RANGE' => 166,
			"]" => -86,
			";" => -86,
			'OP13_BITWISE_AND' => 167
		}
	},
	{#State 450
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 461
		}
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 452
		ACTIONS => {
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 89,
			"undef" => 121,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 111,
			'Expression' => 150,
			'ArrayDereference' => 131,
			'SubExpression' => 463,
			'HashReference' => 105,
			'ArrayReference' => 124,
			'Literal' => 139,
			'Variable' => 151,
			'Operator' => 98,
			'WordScoped' => 96
		}
	},
	{#State 453
		DEFAULT => -239
	},
	{#State 454
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 464
		}
	},
	{#State 455
		DEFAULT => -161
	},
	{#State 456
		ACTIONS => {
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'VariableSymbolOrSelf' => 114,
			'Expression' => 150,
			'HashDereference' => 111,
			'Variable' => 151,
			'Literal' => 139,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 465,
			'HashReference' => 105,
			'ArrayReference' => 124
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 205,
			'OP01_PRINT' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 203,
			'OP19_LOOP_CONTROL_SCOLON' => 192,
			'OP22_LOGICAL_NEG' => 204,
			'OP11_COMPARE_LT_GT' => 197,
			'OP01_OPEN' => 208,
			'OP23_LOGICAL_AND' => 207,
			'OP01_CLOSE' => 198,
			'OP10_NAMED_UNARY' => 209,
			'OP08_MATH_ADD_SUB' => 196,
			'OP01_NAMED' => 195,
			'OP12_COMPARE_EQ_NE' => 212,
			'WORD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP24_LOGICAL_OR_XOR' => 214,
			'OP01_NAMED_VOID' => 200
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
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 90,
			"for" => -152,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY_SCOLON' => 91,
			'OP19_LOOP_CONTROL' => 92,
			'MY' => 94,
			'OP10_NAMED_UNARY' => 95,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			"%{" => 102,
			'WORD' => 23,
			"}" => 469,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP01_NAMED_VOID_LPAREN' => 112,
			"if" => 116,
			'OP01_PRINT' => 119,
			'LPAREN' => 120,
			"undef" => 121,
			'WORD_UPPERCASE' => 122,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			"foreach" => -152,
			'LBRACKET' => 130,
			'OP01_NAMED_VOID_SCOLON' => 129,
			"\@{" => 133,
			"while" => -152,
			'OP01_NAMED_VOID' => 135,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'ArrayDereference' => 131,
			'Operation' => 468,
			'VariableModification' => 101,
			'Expression' => 100,
			'Literal' => 139,
			'Variable' => 107,
			'Statement' => 109,
			'VariableDeclaration' => 132,
			'LoopLabel' => 136,
			'HashReference' => 105,
			'OPTIONAL-37' => 104,
			'PAREN-36' => 118,
			'VariableSymbolOrSelf' => 114,
			'Conditional' => 113,
			'HashDereference' => 111,
			'OperatorVoid' => 115,
			'Operator' => 98,
			'WordScoped' => 96,
			'SubExpression' => 93,
			'ArrayReference' => 124
		}
	},
	{#State 460
		DEFAULT => -184
	},
	{#State 461
		DEFAULT => -170
	},
	{#State 462
		DEFAULT => -172
	},
	{#State 463
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => -108,
			'OP07_STRING_REPEAT' => 154,
			'OP08_STRING_CAT' => 157,
			")" => 470,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => -108,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170
		}
	},
	{#State 464
		ACTIONS => {
			"%{" => 102,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			"\@{" => 133,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP22_LOGICAL_NEG' => 89,
			'OP01_NAMED_SCOLON' => 431,
			"undef" => 121,
			'LPAREN' => 120,
			'OP10_NAMED_UNARY_SCOLON' => 430,
			'LITERAL_STRING' => 82,
			'WORD_UPPERCASE' => 148,
			'OP01_NAMED' => 147,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 125,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'SubExpression' => 432,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'OpNamedScolonOrSubExp' => 471,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98,
			'Expression' => 150,
			'HashDereference' => 111,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 465
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164,
			'OP04_MATH_POW' => 158,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP08_STRING_CAT' => 157,
			")" => 472,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163,
			'OP13_BITWISE_AND' => 167,
			'OP17_LIST_RANGE' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 160
		}
	},
	{#State 466
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 473,
			'OP02_ARRAY_THINARROW' => 474
		}
	},
	{#State 467
		DEFAULT => -75,
		GOTOS => {
			'STAR-30' => 475
		}
	},
	{#State 468
		DEFAULT => -70
	},
	{#State 469
		ACTIONS => {
			";" => 476
		}
	},
	{#State 470
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 477
		}
	},
	{#State 471
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'VARIABLE_SYMBOL' => 126,
			'CONSTANT_CALL_SCOPED' => 128,
			'WORD' => 23,
			"%{" => 102,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpressionOrVarMod' => 478,
			'SubExpression' => 479,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 107,
			'Literal' => 139,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'VariableModification' => 480,
			'ArrayDereference' => 131
		}
	},
	{#State 472
		ACTIONS => {
			'LBRACE' => 393
		},
		GOTOS => {
			'CodeBlock' => 481
		}
	},
	{#State 473
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'LBRACKET' => 130,
			'WORD' => 23,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'LITERAL_NUMBER' => 83,
			'OP05_LOGICAL_NEG' => 138,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 133,
			"undef" => 121,
			'LPAREN' => 120,
			'LITERAL_STRING' => 82,
			'OP22_LOGICAL_NEG' => 89,
			'SELF' => 97,
			'OP01_OPEN' => 99,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148
		},
		GOTOS => {
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131,
			'SubExpression' => 482,
			'ArrayReference' => 124,
			'HashReference' => 105,
			'Literal' => 139,
			'Variable' => 151,
			'WordScoped' => 96,
			'Operator' => 98
		}
	},
	{#State 474
		ACTIONS => {
			'LBRACE' => 106,
			'OP05_LOGICAL_NEG' => 138,
			'OP03_MATH_INC_DEC' => 108,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 83,
			"\@{" => 133,
			'LBRACKET' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 103,
			'CONSTANT_CALL_SCOPED' => 128,
			'VARIABLE_SYMBOL' => 126,
			'WORD' => 23,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 125,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 99,
			'SELF' => 97,
			'OP01_NAMED' => 147,
			'WORD_UPPERCASE' => 148,
			'LITERAL_STRING' => 82,
			'LPAREN' => 120,
			"undef" => 121,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'ArrayReference' => 124,
			'HashReference' => 105,
			'SubExpression' => 483,
			'WordScoped' => 96,
			'Operator' => 98,
			'Variable' => 151,
			'Literal' => 139,
			'HashDereference' => 111,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 131
		}
	},
	{#State 475
		ACTIONS => {
			")" => 485,
			'OP21_LIST_COMMA' => 486
		},
		GOTOS => {
			'PAREN-29' => 484
		}
	},
	{#State 476
		DEFAULT => -72
	},
	{#State 477
		DEFAULT => -168
	},
	{#State 478
		ACTIONS => {
			")" => 487
		}
	},
	{#State 479
		ACTIONS => {
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			'OP08_MATH_ADD_SUB' => 168,
			'OP04_MATH_POW' => 158,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 154,
			'OP12_COMPARE_EQ_NE' => 156,
			")" => -148,
			'OP08_STRING_CAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 480
		DEFAULT => -149
	},
	{#State 481
		DEFAULT => -158
	},
	{#State 482
		ACTIONS => {
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			"}" => -225,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP21_LIST_COMMA' => -225,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP17_LIST_RANGE' => 166,
			'OP13_BITWISE_AND' => 167,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 169,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 483
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP15_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 167,
			"]" => 488,
			'OP17_LIST_RANGE' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			'OP11_COMPARE_LT_GT' => 169,
			'OP23_LOGICAL_AND' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 170,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 154,
			'OP18_TERNARY' => 155,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP24_LOGICAL_OR_XOR' => 159
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
			'LBRACE' => 393
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
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56,
			'WORD' => 58
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
	[#Rule SubroutineOrMethod_77
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_78
		 'SubroutineOrMethod', 1,
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
         'SubroutineOrMethod_77', 
         'SubroutineOrMethod_78', 
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
SubroutineOrMethod_77 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_78 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
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
