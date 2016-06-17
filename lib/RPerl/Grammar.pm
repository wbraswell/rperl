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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|foreach|\$TYPED_|\=\ sub\ \{|while|elsif|undef|else|\@_\;|our|for|\@\{|if|\%\{|\]|\)|\;|\})}gc and return ($1, $1);

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
			"## no critic qw(" => 5,
			"package" => -20,
			'SHEBANG' => 2,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Critic' => 9,
			'PAREN-1' => 7,
			'ModuleHeader' => 8,
			'Program' => 3,
			'OPTIONAL-9' => 4,
			'PLUS-2' => 6,
			'CompileUnit' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 5,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => 14,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 13
		}
	},
	{#State 5
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-16' => 15
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 5,
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 17,
			'OPTIONAL-9' => 4,
			'ModuleHeader' => 8,
			'Critic' => 9
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			"use parent qw(" => 20,
			'USE_OR_REQUIRE' => -27,
			"## no critic qw(" => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Package' => 18,
			'Module' => 19,
			'STAR-11' => 21,
			'Class' => 22
		}
	},
	{#State 9
		DEFAULT => -19
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
		ACTIONS => {
			"package" => 24
		}
	},
	{#State 14
		DEFAULT => -21
	},
	{#State 15
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 16
		DEFAULT => -39
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 21
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			'USE_OR_REQUIRE' => -29,
			"## no critic qw(" => 5
		},
		GOTOS => {
			'Critic' => 30,
			'STAR-12' => 31
		}
	},
	{#State 22
		DEFAULT => -25
	},
	{#State 23
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 32
		}
	},
	{#State 24
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 34
		}
	},
	{#State 25
		DEFAULT => -38
	},
	{#State 26
		DEFAULT => -40
	},
	{#State 27
		DEFAULT => -219
	},
	{#State 28
		ACTIONS => {
			")" => 35
		}
	},
	{#State 29
		DEFAULT => -218
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			"use constant" => -31,
			"our" => -31,
			'USE_OR_REQUIRE' => 38
		},
		GOTOS => {
			'Include' => 37,
			'STAR-13' => 36
		}
	},
	{#State 32
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use warnings;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			";" => 41
		}
	},
	{#State 35
		ACTIONS => {
			";" => 42
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 45,
			"our" => 43
		},
		GOTOS => {
			'PLUS-14' => 46,
			'Constant' => 47,
			'Subroutine' => 44
		}
	},
	{#State 37
		DEFAULT => -28
	},
	{#State 38
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 39
		ACTIONS => {
			"while" => -11,
			'LITERAL_STRING' => -11,
			"## no critic qw(" => 5,
			'WORD_UPPERCASE' => -11,
			'OP01_OPEN' => -11,
			'LBRACKET' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"%{" => -11,
			'OP01_PRINT' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			"for" => -11,
			"undef" => -11,
			'VARIABLE_SYMBOL' => -11,
			'SELF' => -11,
			"foreach" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"\@{" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"if" => -11,
			'WORD' => -11,
			'LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'USE_OR_REQUIRE' => -11,
			'MY' => -11,
			"use constant" => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'STAR-5' => 49,
			'Critic' => 50
		}
	},
	{#State 40
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 52
		},
		GOTOS => {
			'OPTIONAL-15' => 51
		}
	},
	{#State 41
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'USE_OR_REQUIRE' => 38
		},
		GOTOS => {
			'Include' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 44
		DEFAULT => -33
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'LITERAL_NUMBER' => 61,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 47
		DEFAULT => -30
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 62,
			";" => 63
		}
	},
	{#State 49
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_PRINT' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"for" => -13,
			"undef" => -13,
			'VARIABLE_SYMBOL' => -13,
			"foreach" => -13,
			'SELF' => -13,
			'LITERAL_STRING' => -13,
			"while" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_OPEN' => -13,
			'LBRACKET' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED_VOID' => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			"\@{" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD' => -13,
			"if" => -13,
			'LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'USE_OR_REQUIRE' => 38,
			'MY' => -13,
			"use constant" => -13,
			'LBRACE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 64,
			'Include' => 65
		}
	},
	{#State 50
		DEFAULT => -8
	},
	{#State 51
		ACTIONS => {
			"our" => 66
		}
	},
	{#State 52
		DEFAULT => -35
	},
	{#State 53
		DEFAULT => -23
	},
	{#State 54
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 67
		}
	},
	{#State 55
		DEFAULT => -222
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 57
		DEFAULT => -223
	},
	{#State 58
		DEFAULT => -221
	},
	{#State 59
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
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
		ACTIONS => {
			";" => 71
		}
	},
	{#State 63
		DEFAULT => -41
	},
	{#State 64
		ACTIONS => {
			'WORD' => -15,
			"if" => -15,
			'LPAREN' => -15,
			"\@{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'MY' => -15,
			'LBRACE' => -15,
			"use constant" => 45,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED' => -15,
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_PRINT' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"%{" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'VARIABLE_SYMBOL' => -15,
			'SELF' => -15,
			"foreach" => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			"while" => -15,
			'LITERAL_STRING' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"our" => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD_SCOPED' => -15,
			'OP01_OPEN' => -15,
			'LBRACKET' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'Constant' => 72,
			'STAR-7' => 73
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 74
		}
	},
	{#State 67
		ACTIONS => {
			'USE_OR_REQUIRE' => -56,
			"## no critic qw(" => 5,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-22' => 76
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 69
		ACTIONS => {
			'MY' => 78
		},
		GOTOS => {
			'TypeInnerConstant' => 79
		}
	},
	{#State 70
		DEFAULT => -34
	},
	{#State 71
		DEFAULT => -42
	},
	{#State 72
		DEFAULT => -12
	},
	{#State 73
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 129,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP03_MATH_INC_DEC' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP22_LOGICAL_NEG' => 113,
			'MY' => 117,
			'LBRACE' => 118,
			"\@{" => 107,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD' => 29,
			"if" => 109,
			'LPAREN' => 112,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'CONSTANT_CALL_SCOPED' => 105,
			"our" => 43,
			'OP01_NAMED_VOID' => 104,
			'WORD_SCOPED' => 27,
			"while" => -152,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 97,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			"foreach" => -152,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_LPAREN' => 83,
			'OP19_LOOP_CONTROL' => 82,
			'OP01_PRINT' => 85,
			"for" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayReference' => 128,
			'Statement' => 131,
			'HashReference' => 103,
			'VariableModification' => 106,
			'VariableDeclaration' => 132,
			'Expression' => 119,
			'LoopLabel' => 120,
			'Literal' => 94,
			'Variable' => 96,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'OperatorVoid' => 98,
			'Operation' => 99,
			'PAREN-36' => 89,
			'OPTIONAL-37' => 115,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'Subroutine' => 116,
			'ArrayDereference' => 110,
			'Conditional' => 84,
			'SubExpression' => 87,
			'PLUS-8' => 111
		}
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"use constant" => -58,
			'USE_OR_REQUIRE' => 38,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'STAR-23' => 133,
			'Include' => 134
		}
	},
	{#State 77
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -45,
			'OP01_NAMED_SCOLON' => -45,
			"}" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP01_CLOSE' => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP01_NAMED' => -45,
			'LPAREN_MY' => 137,
			'OP22_LOGICAL_NEG' => -45,
			'LBRACE' => -45,
			'MY' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			"\@{" => -45,
			'LPAREN' => -45,
			'WORD' => -45,
			"if" => -45,
			'LBRACKET' => -45,
			'OP01_OPEN' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'WORD_SCOPED' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP01_NAMED_VOID' => -45,
			"while" => -45,
			'LITERAL_STRING' => -45,
			'WORD_UPPERCASE' => -45,
			"undef" => -45,
			'SELF' => -45,
			"foreach" => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"%{" => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			"for" => -45,
			'OP01_PRINT' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 136,
			'OPTIONAL-17' => 135
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 138
		}
	},
	{#State 79
		ACTIONS => {
			'LITERAL_STRING' => 95,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 139
		}
	},
	{#State 80
		ACTIONS => {
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => -215,
			'SELF' => 93
		},
		GOTOS => {
			'Variable' => 142,
			'VariableSymbolOrSelf' => 114,
			'OPTIONAL-51' => 140,
			'TypeInner' => 143
		}
	},
	{#State 81
		DEFAULT => -235
	},
	{#State 82
		ACTIONS => {
			'WORD_UPPERCASE' => 144
		},
		GOTOS => {
			'LoopLabel' => 145
		}
	},
	{#State 83
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 95,
			'OP01_QW' => 147,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			")" => -117,
			'SELF' => 93,
			'LBRACE' => 118,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'ARGV' => 150,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29
		},
		GOTOS => {
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 103,
			'ListElements' => 156,
			'Literal' => 94,
			'Expression' => 149,
			'ListElement' => 148,
			'HashDereference' => 123,
			'OPTIONAL-33' => 155,
			'WordScoped' => 124,
			'Variable' => 152,
			'ArrayDereference' => 110,
			'TypeInner' => 154,
			'SubExpression' => 153
		}
	},
	{#State 84
		DEFAULT => -153
	},
	{#State 85
		ACTIONS => {
			'WORD' => -115,
			'OP05_BITWISE_NEG_LPAREN' => -115,
			'LPAREN' => -115,
			"\@{" => -115,
			'ARGV' => -115,
			'LITERAL_NUMBER' => -115,
			'STDOUT_STDERR' => 158,
			"%{" => -115,
			'VARIABLE_SYMBOL' => -115,
			'MY' => -115,
			'SELF' => -115,
			'LBRACE' => -115,
			'OP22_LOGICAL_NEG' => -115,
			"undef" => -115,
			'WORD_UPPERCASE' => -115,
			'OP10_NAMED_UNARY' => -115,
			'OP01_NAMED' => -115,
			'OP01_CLOSE' => -115,
			'FHREF_SYMBOL_BRACES' => 159,
			'OP03_MATH_INC_DEC' => -115,
			'LITERAL_STRING' => -115,
			'OP01_QW' => -115,
			'CONSTANT_CALL_SCOPED' => -115,
			'WORD_SCOPED' => -115,
			'OP05_LOGICAL_NEG' => -115,
			'OP01_OPEN' => -115,
			'LBRACKET' => -115,
			'OP05_MATH_NEG_LPAREN' => -115
		},
		GOTOS => {
			'OPTIONAL-32' => 160,
			'PAREN-31' => 157
		}
	},
	{#State 86
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 103,
			'Expression' => 149,
			'Literal' => 94,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'ArrayDereference' => 110,
			'SubExpression' => 161
		}
	},
	{#State 87
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP18_TERNARY' => 177,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166
		}
	},
	{#State 88
		DEFAULT => -124
	},
	{#State 89
		DEFAULT => -151
	},
	{#State 90
		DEFAULT => -130
	},
	{#State 91
		DEFAULT => -137
	},
	{#State 92
		DEFAULT => -233
	},
	{#State 93
		DEFAULT => -234
	},
	{#State 94
		DEFAULT => -138
	},
	{#State 95
		DEFAULT => -236
	},
	{#State 96
		ACTIONS => {
			'OP13_BITWISE_AND' => -139,
			'OP07_MATH_MULT_DIV_MOD' => -139,
			")" => -139,
			'OP09_BITWISE_SHIFT' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP04_MATH_POW' => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP17_LIST_RANGE' => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			'OP19_VARIABLE_ASSIGN' => 179,
			'OP18_TERNARY' => -139,
			'OP08_STRING_CAT' => -139,
			'OP02_METHOD_THINARROW' => 180,
			'OP08_MATH_ADD_SUB' => -139,
			'OP15_LOGICAL_AND' => -139,
			'OP11_COMPARE_LT_GT' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP19_VARIABLE_ASSIGN_BY' => 182,
			'OP03_MATH_INC_DEC' => 181,
			'OP16_LOGICAL_OR' => -139,
			'OP07_STRING_REPEAT' => -139
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 183,
			'COLON' => -220
		}
	},
	{#State 98
		DEFAULT => -155
	},
	{#State 99
		DEFAULT => -17
	},
	{#State 100
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			"]" => -197,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			'SELF' => 93,
			'LBRACE' => 118,
			"\@{" => 107,
			'ARGV' => 150,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_CLOSE' => 127
		},
		GOTOS => {
			'HashReference' => 103,
			'ListElements' => 185,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'OPTIONAL-46' => 184,
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'SubExpression' => 153,
			'ListElement' => 148,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124
		}
	},
	{#State 101
		ACTIONS => {
			'MY' => 186
		}
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 187,
			'ArrayDereference' => 110
		}
	},
	{#State 103
		DEFAULT => -142
	},
	{#State 104
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			"\@{" => 107,
			'ARGV' => 150,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127
		},
		GOTOS => {
			'HashReference' => 103,
			'ListElements' => 188,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'SubExpression' => 153,
			'ListElement' => 148,
			'Expression' => 149,
			'Literal' => 94,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152
		}
	},
	{#State 105
		DEFAULT => -132
	},
	{#State 106
		ACTIONS => {
			";" => 189
		}
	},
	{#State 107
		ACTIONS => {
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			'LBRACKET' => -200
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 191,
			'OPTIONAL-47' => 192,
			'TypeInner' => 190
		}
	},
	{#State 108
		DEFAULT => -120
	},
	{#State 109
		ACTIONS => {
			'LPAREN' => 193
		}
	},
	{#State 110
		DEFAULT => -141
	},
	{#State 111
		ACTIONS => {
			"foreach" => -152,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			"for" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_PRINT' => 85,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 82,
			'OP01_NAMED_VOID_LPAREN' => 83,
			"%{" => 80,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_VOID' => 104,
			'CONSTANT_CALL_SCOPED' => 105,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 95,
			"while" => -152,
			'LBRACE' => 118,
			'MY' => 117,
			'' => -18,
			'OP22_LOGICAL_NEG' => 113,
			'LPAREN' => 112,
			"if" => 109,
			'WORD' => 29,
			'OP01_NAMED_VOID_SCOLON' => 108,
			"\@{" => 107,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_NAMED_SCOLON' => 129,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'Operation' => 194,
			'OperatorVoid' => 98,
			'WordScoped' => 124,
			'Variable' => 96,
			'HashDereference' => 123,
			'Expression' => 119,
			'Literal' => 94,
			'LoopLabel' => 120,
			'VariableDeclaration' => 132,
			'VariableModification' => 106,
			'HashReference' => 103,
			'Statement' => 131,
			'ArrayReference' => 128,
			'SubExpression' => 87,
			'ArrayDereference' => 110,
			'Conditional' => 84,
			'OPTIONAL-37' => 115,
			'Operator' => 90,
			'PAREN-36' => 89,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 112
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 195,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP01_PRINT' => 197,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'SubExpression' => 196,
			'Expression' => 149,
			'Literal' => 94,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'HashReference' => 103,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 113
		ACTIONS => {
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'SubExpression' => 198,
			'ArrayDereference' => 110,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149
		}
	},
	{#State 114
		DEFAULT => -177,
		GOTOS => {
			'STAR-43' => 199
		}
	},
	{#State 115
		ACTIONS => {
			"while" => 200,
			"foreach" => 203,
			"for" => 201
		},
		GOTOS => {
			'Loop' => 205,
			'LoopWhile' => 202,
			'LoopFor' => 206,
			'LoopForEach' => 204
		}
	},
	{#State 116
		DEFAULT => -14
	},
	{#State 117
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 55,
			'TYPE_FHREF' => 208
		},
		GOTOS => {
			'Type' => 207
		}
	},
	{#State 118
		ACTIONS => {
			'OP01_CLOSE' => 209,
			'OP10_NAMED_UNARY' => 212,
			'OP01_NAMED' => 211,
			'OP07_STRING_REPEAT' => 210,
			'LITERAL_STRING' => 95,
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 225,
			'OP01_NAMED_VOID' => 226,
			'OP01_OPEN' => 227,
			"}" => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'WORD' => 218,
			'OP01_PRINT' => 229,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 230,
			"%{" => 80,
			'OP23_LOGICAL_AND' => 219,
			'SELF' => 93,
			'ENV' => 231,
			'VARIABLE_SYMBOL' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 233,
			'OP22_LOGICAL_NEG' => 220
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 214,
			'Variable' => 222,
			'HashEntry' => 216,
			'Literal' => 223,
			'OpStringOrWord' => 224,
			'VarOrLitOrOpStrOrWord' => 232
		}
	},
	{#State 119
		ACTIONS => {
			'OP18_TERNARY' => -136,
			'OP08_STRING_CAT' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			";" => 234,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP16_LOGICAL_OR' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP13_BITWISE_AND' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP04_MATH_POW' => -136
		}
	},
	{#State 120
		ACTIONS => {
			'COLON' => 235
		}
	},
	{#State 121
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 236
		}
	},
	{#State 122
		DEFAULT => -81
	},
	{#State 123
		DEFAULT => -143
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 238,
			'OP02_METHOD_THINARROW_NEW' => 237
		}
	},
	{#State 125
		ACTIONS => {
			'LBRACE' => 118,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP22_LOGICAL_NEG' => 113,
			")" => -101,
			'LPAREN' => 112,
			'OP06_REGEX_MATCH' => -101,
			'WORD' => 29,
			'OP04_MATH_POW' => -101,
			"\@{" => 107,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP05_MATH_NEG_LPAREN' => 130,
			"}" => -101,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP07_STRING_REPEAT' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP03_MATH_INC_DEC' => 121,
			'SELF' => 93,
			"]" => -101,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP17_LIST_RANGE' => -101,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'OP09_BITWISE_SHIFT' => -101,
			'WORD_SCOPED' => 27,
			'OP18_TERNARY' => -101,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP11_COMPARE_LT_GT' => -101,
			";" => -101,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP14_BITWISE_OR_XOR' => -101,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP12_COMPARE_EQ_NE' => -101
		},
		GOTOS => {
			'SubExpression' => 239,
			'ArrayDereference' => 110,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Expression' => 149,
			'Literal' => 94,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128
		}
	},
	{#State 126
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_CLOSE' => 127,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			"\@{" => 107,
			'ARGV' => 150,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			'LBRACE' => 118,
			'SELF' => 93
		},
		GOTOS => {
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'SubExpression' => 240,
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'ListElement' => 241,
			'Literal' => 94,
			'Expression' => 149
		}
	},
	{#State 127
		ACTIONS => {
			'FHREF_SYMBOL' => 242
		}
	},
	{#State 128
		DEFAULT => -140
	},
	{#State 129
		DEFAULT => -80
	},
	{#State 130
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107
		},
		GOTOS => {
			'Literal' => 94,
			'Expression' => 149,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'ArrayDereference' => 110,
			'SubExpression' => 243,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103
		}
	},
	{#State 131
		DEFAULT => -82
	},
	{#State 132
		DEFAULT => -156
	},
	{#State 133
		ACTIONS => {
			"our hashref \$properties" => 245,
			"use constant" => 45
		},
		GOTOS => {
			'Properties' => 246,
			'Constant' => 244
		}
	},
	{#State 134
		DEFAULT => -55
	},
	{#State 135
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 247
		}
	},
	{#State 136
		DEFAULT => -44
	},
	{#State 137
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 55,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 248
		}
	},
	{#State 138
		ACTIONS => {
			"\$TYPED_" => 249
		}
	},
	{#State 139
		ACTIONS => {
			";" => 250
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACE' => 118
		},
		GOTOS => {
			'HashReference' => 251
		}
	},
	{#State 141
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 252
		}
	},
	{#State 142
		ACTIONS => {
			"}" => 253
		}
	},
	{#State 143
		DEFAULT => -214
	},
	{#State 144
		DEFAULT => -220
	},
	{#State 145
		ACTIONS => {
			";" => 254
		}
	},
	{#State 146
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 255,
			'ArrayDereference' => 110
		}
	},
	{#State 147
		DEFAULT => -194
	},
	{#State 148
		DEFAULT => -190,
		GOTOS => {
			'STAR-45' => 256
		}
	},
	{#State 149
		DEFAULT => -136
	},
	{#State 150
		DEFAULT => -195
	},
	{#State 151
		ACTIONS => {
			'LPAREN' => 183
		}
	},
	{#State 152
		ACTIONS => {
			'OP16_LOGICAL_OR' => -139,
			'OP07_STRING_REPEAT' => -139,
			'OP03_MATH_INC_DEC' => 181,
			'OP24_LOGICAL_OR_XOR' => -139,
			'OP12_COMPARE_EQ_NE' => -139,
			'OP02_METHOD_THINARROW' => 180,
			'OP08_STRING_CAT' => -139,
			'OP15_LOGICAL_AND' => -139,
			'OP08_MATH_ADD_SUB' => -139,
			'OP11_COMPARE_LT_GT' => -139,
			'OP18_TERNARY' => -139,
			"}" => -139,
			'OP14_BITWISE_OR_XOR' => -139,
			";" => -139,
			'OP17_LIST_RANGE' => -139,
			'OP06_REGEX_MATCH' => -139,
			'OP23_LOGICAL_AND' => -139,
			'OP04_MATH_POW' => -139,
			'OP09_BITWISE_SHIFT' => -139,
			'OP21_LIST_COMMA' => -139,
			"]" => -139,
			")" => -139,
			'OP13_BITWISE_AND' => -139,
			'OP07_MATH_MULT_DIV_MOD' => -139
		}
	},
	{#State 153
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP14_BITWISE_OR_XOR' => 178,
			";" => -192,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP18_TERNARY' => 177,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			")" => -192,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			"]" => -192,
			'OP21_LIST_COMMA' => -192
		}
	},
	{#State 154
		ACTIONS => {
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'SubExpression' => 257,
			'ArrayDereference' => 110,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128
		}
	},
	{#State 155
		ACTIONS => {
			")" => 258
		}
	},
	{#State 156
		DEFAULT => -116
	},
	{#State 157
		DEFAULT => -114
	},
	{#State 158
		DEFAULT => -113
	},
	{#State 159
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'ARGV' => 150,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'SubExpression' => 153,
			'ListElement' => 148,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'HashReference' => 103,
			'ListElements' => 259,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90
		}
	},
	{#State 160
		ACTIONS => {
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'ARGV' => 150,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'ListElement' => 148,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'TypeInner' => 154,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'ListElements' => 260,
			'HashReference' => 103
		}
	},
	{#State 161
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			")" => 261,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165
		}
	},
	{#State 162
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 262
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 263,
			'ArrayDereference' => 110,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 164
		ACTIONS => {
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'SubExpression' => 264,
			'ArrayDereference' => 110,
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'Literal' => 94,
			'Expression' => 149,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128
		}
	},
	{#State 165
		ACTIONS => {
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 265,
			'ArrayDereference' => 110,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 166
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 266,
			'ArrayDereference' => 110
		}
	},
	{#State 167
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'SubExpression' => 267,
			'Literal' => 94,
			'Expression' => 149,
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashReference' => 103,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90
		}
	},
	{#State 168
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127
		},
		GOTOS => {
			'SubExpression' => 268,
			'ArrayDereference' => 110,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Expression' => 149,
			'Literal' => 94,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128
		}
	},
	{#State 169
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91
		},
		GOTOS => {
			'HashReference' => 103,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 110,
			'SubExpression' => 269,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124
		}
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100
		},
		GOTOS => {
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103,
			'Expression' => 149,
			'Literal' => 94,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'ArrayDereference' => 110,
			'SubExpression' => 270
		}
	},
	{#State 171
		ACTIONS => {
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125
		},
		GOTOS => {
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 271,
			'ArrayDereference' => 110
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Literal' => 94,
			'Expression' => 149,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Variable' => 152,
			'ArrayDereference' => 110,
			'SubExpression' => 272,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 103
		}
	},
	{#State 173
		ACTIONS => {
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 273,
			'ArrayDereference' => 110,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 174
		ACTIONS => {
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125
		},
		GOTOS => {
			'Literal' => 94,
			'Expression' => 149,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'ArrayDereference' => 110,
			'SubExpression' => 274,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103
		}
	},
	{#State 175
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'SubExpression' => 275,
			'Literal' => 94,
			'Expression' => 149,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashReference' => 103,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90
		}
	},
	{#State 176
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107
		},
		GOTOS => {
			'Expression' => 149,
			'Literal' => 94,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'ArrayDereference' => 110,
			'SubExpression' => 276,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 103
		}
	},
	{#State 177
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LITERAL_STRING' => 95,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'VariableOrLiteral' => 277,
			'Literal' => 279,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 278
		}
	},
	{#State 178
		ACTIONS => {
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 280,
			'ArrayDereference' => 110,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 179
		ACTIONS => {
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'STDIN' => 283,
			'OP22_LOGICAL_NEG' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'FHREF_SYMBOL_IN' => 284,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpressionOrInput' => 281,
			'SubExpression' => 282,
			'ArrayDereference' => 110,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 285
		}
	},
	{#State 181
		DEFAULT => -89
	},
	{#State 182
		ACTIONS => {
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_CLOSE' => 127,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'SubExpression' => 286,
			'ArrayDereference' => 110,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Literal' => 94,
			'Expression' => 149,
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128
		}
	},
	{#State 183
		ACTIONS => {
			")" => 287
		}
	},
	{#State 184
		ACTIONS => {
			"]" => 288
		}
	},
	{#State 185
		DEFAULT => -196
	},
	{#State 186
		ACTIONS => {
			'TYPE_FHREF' => 289
		}
	},
	{#State 187
		ACTIONS => {
			'OP18_TERNARY' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_STRING_REPEAT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP21_LIST_COMMA' => -92,
			"]" => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP13_BITWISE_AND' => -92,
			")" => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 164
		}
	},
	{#State 188
		ACTIONS => {
			";" => 290
		}
	},
	{#State 189
		DEFAULT => -157
	},
	{#State 190
		DEFAULT => -199
	},
	{#State 191
		ACTIONS => {
			"}" => 291
		}
	},
	{#State 192
		ACTIONS => {
			'LBRACKET' => 100
		},
		GOTOS => {
			'ArrayReference' => 292
		}
	},
	{#State 193
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91
		},
		GOTOS => {
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Variable' => 152,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 293,
			'ArrayDereference' => 110,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 194
		DEFAULT => -16
	},
	{#State 195
		ACTIONS => {
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'ARGV' => 150,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'SubExpression' => 240,
			'ArrayDereference' => 110,
			'TypeInner' => 154,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'ListElement' => 294
		}
	},
	{#State 196
		ACTIONS => {
			")" => 295,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175
		}
	},
	{#State 197
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 296
		}
	},
	{#State 198
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => -110,
			'OP21_LIST_COMMA' => -110,
			"]" => -110,
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => -110,
			'OP04_MATH_POW' => 164,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			";" => -110,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -110,
			'OP18_TERNARY' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167
		}
	},
	{#State 199
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -178,
			'OP24_LOGICAL_OR_XOR' => -178,
			'OP03_MATH_INC_DEC' => -178,
			'OP19_VARIABLE_ASSIGN_BY' => -178,
			'OP02_ARRAY_THINARROW' => 299,
			'OP20_HASH_FATARROW' => -178,
			'OP16_LOGICAL_OR' => -178,
			'OP07_STRING_REPEAT' => -178,
			";" => -178,
			'COLON' => -178,
			"}" => -178,
			'OP14_BITWISE_OR_XOR' => -178,
			'OP18_TERNARY' => -178,
			'OP19_VARIABLE_ASSIGN' => -178,
			'OP02_METHOD_THINARROW' => -178,
			'OP08_STRING_CAT' => -178,
			'OP08_MATH_ADD_SUB' => -178,
			'OP15_LOGICAL_AND' => -178,
			'OP11_COMPARE_LT_GT' => -178,
			'OP09_BITWISE_SHIFT' => -178,
			'OP23_LOGICAL_AND' => -178,
			'OP04_MATH_POW' => -178,
			'OP06_REGEX_MATCH' => -178,
			'OP17_LIST_RANGE' => -178,
			'OP07_MATH_MULT_DIV_MOD' => -178,
			'OP13_BITWISE_AND' => -178,
			")" => -178,
			'OP02_HASH_THINARROW' => 297,
			'OP21_LIST_COMMA' => -178,
			"]" => -178
		},
		GOTOS => {
			'VariableRetrieval' => 298
		}
	},
	{#State 200
		ACTIONS => {
			'LPAREN' => 301,
			'LPAREN_MY' => 300
		}
	},
	{#State 201
		ACTIONS => {
			'MY' => 302,
			'LPAREN_MY' => 303
		}
	},
	{#State 202
		DEFAULT => -167
	},
	{#State 203
		ACTIONS => {
			'MY' => 304
		}
	},
	{#State 204
		DEFAULT => -166
	},
	{#State 205
		DEFAULT => -154
	},
	{#State 206
		DEFAULT => -165
	},
	{#State 207
		ACTIONS => {
			'VARIABLE_SYMBOL' => 305
		}
	},
	{#State 208
		ACTIONS => {
			'FHREF_SYMBOL' => 306
		}
	},
	{#State 209
		DEFAULT => -255
	},
	{#State 210
		DEFAULT => -253
	},
	{#State 211
		DEFAULT => -254
	},
	{#State 212
		DEFAULT => -250
	},
	{#State 213
		DEFAULT => -243
	},
	{#State 214
		DEFAULT => -206
	},
	{#State 215
		DEFAULT => -251
	},
	{#State 216
		DEFAULT => -211,
		GOTOS => {
			'STAR-50' => 307
		}
	},
	{#State 217
		DEFAULT => -213
	},
	{#State 218
		DEFAULT => -259
	},
	{#State 219
		DEFAULT => -244
	},
	{#State 220
		DEFAULT => -245
	},
	{#State 221
		DEFAULT => -248
	},
	{#State 222
		DEFAULT => -230
	},
	{#State 223
		DEFAULT => -231
	},
	{#State 224
		DEFAULT => -232
	},
	{#State 225
		DEFAULT => -249
	},
	{#State 226
		DEFAULT => -257
	},
	{#State 227
		DEFAULT => -256
	},
	{#State 228
		DEFAULT => -246
	},
	{#State 229
		DEFAULT => -258
	},
	{#State 230
		DEFAULT => -247
	},
	{#State 231
		DEFAULT => -207
	},
	{#State 232
		ACTIONS => {
			'OP20_HASH_FATARROW' => 308
		}
	},
	{#State 233
		DEFAULT => -252
	},
	{#State 234
		DEFAULT => -79
	},
	{#State 235
		DEFAULT => -150
	},
	{#State 236
		DEFAULT => -88
	},
	{#State 237
		ACTIONS => {
			")" => 309
		}
	},
	{#State 238
		ACTIONS => {
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'ARGV' => 150,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			")" => -127,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100
		},
		GOTOS => {
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'ListElements' => 311,
			'HashReference' => 103,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'ListElement' => 148,
			'SubExpression' => 153,
			'OPTIONAL-34' => 310,
			'ArrayDereference' => 110,
			'TypeInner' => 154
		}
	},
	{#State 239
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"}" => -100,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => -100,
			")" => -100
		}
	},
	{#State 240
		ACTIONS => {
			'OP18_TERNARY' => -84,
			'OP08_STRING_CAT' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			";" => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP21_LIST_COMMA' => -192,
			'OP13_BITWISE_AND' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			")" => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP04_MATH_POW' => -84
		}
	},
	{#State 241
		ACTIONS => {
			'OP21_LIST_COMMA' => 312
		}
	},
	{#State 242
		DEFAULT => -87
	},
	{#State 243
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => 313,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP18_TERNARY' => 177,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 176
		}
	},
	{#State 244
		DEFAULT => -57
	},
	{#State 245
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 314
		}
	},
	{#State 246
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 315
		}
	},
	{#State 247
		ACTIONS => {
			"foreach" => -152,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			"for" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_PRINT' => 85,
			"%{" => 80,
			'OP01_NAMED_VOID_LPAREN' => 83,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_VOID' => 104,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 97,
			"while" => -152,
			'LITERAL_STRING' => 95,
			'LBRACE' => 118,
			'MY' => 117,
			'OP22_LOGICAL_NEG' => 113,
			'LPAREN' => 112,
			"if" => 109,
			'WORD' => 29,
			'OP01_NAMED_VOID_SCOLON' => 108,
			"\@{" => 107,
			'OP05_MATH_NEG_LPAREN' => 130,
			"}" => 317,
			'OP01_NAMED_SCOLON' => 129,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY' => 125,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'Expression' => 119,
			'LoopLabel' => 120,
			'Literal' => 94,
			'WordScoped' => 124,
			'Variable' => 96,
			'HashDereference' => 123,
			'OperatorVoid' => 98,
			'Operation' => 316,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Statement' => 131,
			'VariableDeclaration' => 132,
			'VariableModification' => 106,
			'Conditional' => 84,
			'ArrayDereference' => 110,
			'SubExpression' => 87,
			'VariableSymbolOrSelf' => 114,
			'PAREN-36' => 89,
			'OPTIONAL-37' => 115,
			'Operator' => 90
		}
	},
	{#State 248
		ACTIONS => {
			'VARIABLE_SYMBOL' => 318
		}
	},
	{#State 249
		ACTIONS => {
			'WORD_UPPERCASE' => 319
		}
	},
	{#State 250
		DEFAULT => -43
	},
	{#State 251
		ACTIONS => {
			"}" => 320
		}
	},
	{#State 252
		ACTIONS => {
			"\$TYPED_" => 321
		}
	},
	{#State 253
		DEFAULT => -216
	},
	{#State 254
		DEFAULT => -125
	},
	{#State 255
		ACTIONS => {
			'OP15_LOGICAL_AND' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP08_STRING_CAT' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			'OP18_TERNARY' => -84,
			"}" => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			";" => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP21_LIST_COMMA' => -84,
			"]" => -84,
			")" => -84,
			'OP13_BITWISE_AND' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP04_MATH_POW' => -84,
			'OP09_BITWISE_SHIFT' => -84
		}
	},
	{#State 256
		ACTIONS => {
			")" => -191,
			";" => -191,
			"]" => -191,
			'OP21_LIST_COMMA' => 322
		},
		GOTOS => {
			'PAREN-44' => 323
		}
	},
	{#State 257
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP18_TERNARY' => 177,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 176,
			";" => -193,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP21_LIST_COMMA' => -193,
			"]" => -193,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => -193
		}
	},
	{#State 258
		ACTIONS => {
			";" => 324
		}
	},
	{#State 259
		ACTIONS => {
			";" => 325
		}
	},
	{#State 260
		ACTIONS => {
			";" => 326
		}
	},
	{#State 261
		DEFAULT => -91
	},
	{#State 262
		DEFAULT => -94
	},
	{#State 263
		ACTIONS => {
			'OP18_TERNARY' => 177,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -111,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			")" => -111,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 164
		}
	},
	{#State 264
		ACTIONS => {
			'OP06_REGEX_MATCH' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP04_MATH_POW' => 164,
			'OP21_LIST_COMMA' => -90,
			"]" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			")" => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP08_STRING_CAT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			";" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			"}" => -90
		}
	},
	{#State 265
		ACTIONS => {
			'OP17_LIST_RANGE' => -104,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			")" => -104,
			'OP13_BITWISE_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP16_LOGICAL_OR' => -104,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => -104,
			'OP18_TERNARY' => -104,
			"}" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			";" => -104
		}
	},
	{#State 266
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => -107,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => -107,
			"}" => -107,
			'OP14_BITWISE_OR_XOR' => 178,
			";" => -107,
			'OP17_LIST_RANGE' => -107,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP21_LIST_COMMA' => -107,
			"]" => -107,
			")" => -107,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174
		}
	},
	{#State 267
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP07_STRING_REPEAT' => -95,
			";" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			")" => -95,
			'OP21_LIST_COMMA' => -95,
			"]" => -95
		}
	},
	{#State 268
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			"]" => -112,
			'OP21_LIST_COMMA' => -112,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => -112,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP18_TERNARY' => 177,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			";" => -112,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -112
		}
	},
	{#State 269
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => -106,
			'OP07_STRING_REPEAT' => 167,
			"}" => -106,
			'OP14_BITWISE_OR_XOR' => 178,
			";" => -106,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => -106,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => -106,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => -106,
			'OP06_REGEX_MATCH' => 162,
			")" => -106,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP21_LIST_COMMA' => -106,
			"]" => -106
		}
	},
	{#State 270
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP07_STRING_REPEAT' => 167,
			"}" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP08_STRING_CAT' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'OP18_TERNARY' => -97,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP06_REGEX_MATCH' => 162,
			")" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			"]" => -97,
			'OP21_LIST_COMMA' => -97
		}
	},
	{#State 271
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			";" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => -98,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -98,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 162,
			")" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			"]" => -98,
			'OP21_LIST_COMMA' => -98
		}
	},
	{#State 272
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP18_TERNARY' => -108,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			";" => -108,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -108,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -108,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => -108
		}
	},
	{#State 273
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP04_MATH_POW' => 164,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP07_STRING_REPEAT' => 167,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99
		}
	},
	{#State 274
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -96,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			")" => -96,
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP07_STRING_REPEAT' => 167,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			"}" => -96,
			'OP18_TERNARY' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP08_STRING_CAT' => -96,
			'OP15_LOGICAL_AND' => -96
		}
	},
	{#State 275
		ACTIONS => {
			'OP21_LIST_COMMA' => -103,
			"]" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => -103,
			")" => -103,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -103,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -103,
			'OP18_TERNARY' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			";" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			"}" => -103,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 276
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP07_STRING_REPEAT' => 167,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			"}" => -102,
			'OP18_TERNARY' => -102,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => -102,
			")" => -102,
			"]" => -102,
			'OP21_LIST_COMMA' => -102
		}
	},
	{#State 277
		ACTIONS => {
			'COLON' => 327
		}
	},
	{#State 278
		DEFAULT => -228
	},
	{#State 279
		DEFAULT => -229
	},
	{#State 280
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP15_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => -105,
			"}" => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP21_LIST_COMMA' => -105,
			"]" => -105,
			")" => -105,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174
		}
	},
	{#State 281
		DEFAULT => -186
	},
	{#State 282
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 178,
			";" => -145,
			'OP11_COMPARE_LT_GT' => 176,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 177,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			")" => -145,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 283
		DEFAULT => -147
	},
	{#State 284
		DEFAULT => -146
	},
	{#State 285
		ACTIONS => {
			"\@{" => 107,
			'ARGV' => 150,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			")" => -129,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP01_CLOSE' => 127,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ListElements' => 329,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'TypeInner' => 154,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Expression' => 149,
			'Literal' => 94,
			'OPTIONAL-35' => 328,
			'ListElement' => 148
		}
	},
	{#State 286
		ACTIONS => {
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			")" => -187,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP14_BITWISE_OR_XOR' => 178,
			";" => -187,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177
		}
	},
	{#State 287
		DEFAULT => -131
	},
	{#State 288
		DEFAULT => -198
	},
	{#State 289
		ACTIONS => {
			'FHREF_SYMBOL' => 330
		}
	},
	{#State 290
		DEFAULT => -122
	},
	{#State 291
		DEFAULT => -201
	},
	{#State 292
		ACTIONS => {
			"}" => 331
		}
	},
	{#State 293
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => 332,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP18_TERNARY' => 177,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 176,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168
		}
	},
	{#State 294
		ACTIONS => {
			'OP21_LIST_COMMA' => 333
		}
	},
	{#State 295
		DEFAULT => -144
	},
	{#State 296
		ACTIONS => {
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'ARGV' => 150,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'LITERAL_STRING' => 95,
			'OP01_QW' => 147,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'ListElements' => 334,
			'HashReference' => 103,
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'ListElement' => 148,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 153,
			'TypeInner' => 154,
			'ArrayDereference' => 110
		}
	},
	{#State 297
		ACTIONS => {
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'SELF' => 93,
			'LBRACE' => 118,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 335,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 336,
			'ArrayDereference' => 110,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103
		}
	},
	{#State 298
		DEFAULT => -176
	},
	{#State 299
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80
		},
		GOTOS => {
			'SubExpression' => 337,
			'ArrayDereference' => 110,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Expression' => 149,
			'Literal' => 94,
			'HashReference' => 103,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128
		}
	},
	{#State 300
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 338
		}
	},
	{#State 301
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91
		},
		GOTOS => {
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'SubExpression' => 339,
			'ArrayDereference' => 110,
			'HashDereference' => 123,
			'Variable' => 152,
			'WordScoped' => 124,
			'Expression' => 149,
			'Literal' => 94
		}
	},
	{#State 302
		ACTIONS => {
			'TYPE_INTEGER' => 340
		}
	},
	{#State 303
		ACTIONS => {
			'TYPE_INTEGER' => 341
		}
	},
	{#State 304
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 342
		}
	},
	{#State 305
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 343,
			'OP19_VARIABLE_ASSIGN' => 344,
			";" => 345
		}
	},
	{#State 306
		ACTIONS => {
			";" => 346
		}
	},
	{#State 307
		ACTIONS => {
			"}" => 348,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-49' => 347
		}
	},
	{#State 308
		ACTIONS => {
			"\@{" => -204,
			"%{" => -204,
			'LITERAL_NUMBER' => -204,
			'WORD' => -204,
			'LPAREN' => -204,
			'OP05_BITWISE_NEG_LPAREN' => -204,
			'OP22_LOGICAL_NEG' => -204,
			"undef" => -204,
			'MY' => 141,
			'VARIABLE_SYMBOL' => -204,
			'LBRACE' => -204,
			'SELF' => -204,
			'OP03_MATH_INC_DEC' => -204,
			'LITERAL_STRING' => -204,
			'OP01_NAMED' => -204,
			'OP10_NAMED_UNARY' => -204,
			'WORD_UPPERCASE' => -204,
			'OP01_CLOSE' => -204,
			'OP01_OPEN' => -204,
			'LBRACKET' => -204,
			'OP05_LOGICAL_NEG' => -204,
			'OP05_MATH_NEG_LPAREN' => -204,
			'CONSTANT_CALL_SCOPED' => -204,
			'WORD_SCOPED' => -204
		},
		GOTOS => {
			'OPTIONAL-48' => 350,
			'TypeInner' => 351
		}
	},
	{#State 309
		DEFAULT => -135
	},
	{#State 310
		ACTIONS => {
			")" => 352
		}
	},
	{#State 311
		DEFAULT => -126
	},
	{#State 312
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP01_QW' => 147,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'ARGV' => 150,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			'SELF' => 93,
			'LBRACE' => 118
		},
		GOTOS => {
			'ListElement' => 148,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'SubExpression' => 153,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103,
			'ListElements' => 353
		}
	},
	{#State 313
		DEFAULT => -93
	},
	{#State 314
		ACTIONS => {
			'LBRACE' => 354,
			'VARIABLE_SYMBOL' => 355
		}
	},
	{#State 315
		ACTIONS => {
			"our" => 356,
			'LITERAL_NUMBER' => 357
		},
		GOTOS => {
			'Subroutine' => 359,
			'SubroutineOrMethod' => 358,
			'Method' => 360
		}
	},
	{#State 316
		DEFAULT => -46
	},
	{#State 317
		ACTIONS => {
			";" => 361
		}
	},
	{#State 318
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 362
		}
	},
	{#State 319
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 320
		DEFAULT => -217
	},
	{#State 321
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP07_STRING_REPEAT' => 210,
			'OP01_NAMED' => 211,
			'OP10_NAMED_UNARY' => 212,
			'OP01_CLOSE' => 209,
			'OP01_OPEN' => 227,
			'OP11_COMPARE_LT_GT' => 225,
			'OP01_NAMED_VOID' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP23_LOGICAL_AND' => 219,
			'OP19_LOOP_CONTROL' => 230,
			'OP01_PRINT' => 229,
			'WORD' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'OP22_LOGICAL_NEG' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 233
		},
		GOTOS => {
			'OpStringOrWord' => 364
		}
	},
	{#State 322
		ACTIONS => {
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'ARGV' => 150,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'HashReference' => 103,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 110,
			'TypeInner' => 154,
			'SubExpression' => 153,
			'Literal' => 94,
			'Expression' => 149,
			'ListElement' => 365,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152
		}
	},
	{#State 323
		DEFAULT => -189
	},
	{#State 324
		DEFAULT => -121
	},
	{#State 325
		DEFAULT => -119
	},
	{#State 326
		DEFAULT => -118
	},
	{#State 327
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LITERAL_STRING' => 95,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 278,
			'VariableOrLiteral' => 366,
			'Literal' => 279
		}
	},
	{#State 328
		ACTIONS => {
			")" => 367
		}
	},
	{#State 329
		DEFAULT => -128
	},
	{#State 330
		ACTIONS => {
			'OP21_LIST_COMMA' => 368
		}
	},
	{#State 331
		DEFAULT => -202
	},
	{#State 332
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 333
		ACTIONS => {
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'ARGV' => 150,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_QW' => 147,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103,
			'ListElements' => 371,
			'ListElement' => 148,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'TypeInner' => 154,
			'ArrayDereference' => 110,
			'SubExpression' => 153
		}
	},
	{#State 334
		ACTIONS => {
			")" => 372
		}
	},
	{#State 335
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -218,
			"}" => 373,
			'LPAREN' => -218
		}
	},
	{#State 336
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => 374,
			'OP18_TERNARY' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176
		}
	},
	{#State 337
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			"]" => 375
		}
	},
	{#State 338
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 339
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => 377,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP18_TERNARY' => 177,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167
		}
	},
	{#State 340
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 343
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112
		},
		GOTOS => {
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'HashReference' => 103,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'ArrayDereference' => 110,
			'SubExpression' => 381
		}
	},
	{#State 344
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 113,
			'STDIN' => 283,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'FHREF_SYMBOL_IN' => 284,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_NAMED_SCOLON' => 384,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 383,
			'LITERAL_STRING' => 95,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127
		},
		GOTOS => {
			'HashReference' => 103,
			'OpNamedScolonOrSubExpIn' => 385,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 110,
			'SubExpression' => 282,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpressionOrInput' => 382,
			'Variable' => 152,
			'HashDereference' => 123,
			'WordScoped' => 124
		}
	},
	{#State 345
		DEFAULT => -182
	},
	{#State 346
		DEFAULT => -185
	},
	{#State 347
		DEFAULT => -210
	},
	{#State 348
		DEFAULT => -212
	},
	{#State 349
		ACTIONS => {
			'OP01_OPEN' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP01_NAMED_VOID' => 226,
			'OP11_COMPARE_LT_GT' => 225,
			'LITERAL_STRING' => 95,
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_CLOSE' => 209,
			'OP10_NAMED_UNARY' => 212,
			'OP01_NAMED' => 211,
			'OP07_STRING_REPEAT' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 233,
			'OP22_LOGICAL_NEG' => 220,
			'SELF' => 93,
			'ENV' => 231,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 230,
			'OP23_LOGICAL_AND' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'WORD' => 218,
			'OP01_PRINT' => 229
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 232,
			'Literal' => 223,
			'OpStringOrWord' => 224,
			'HashEntry' => 386,
			'HashDereference' => 214,
			'Variable' => 222,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 350
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 387,
			'ArrayDereference' => 110
		}
	},
	{#State 351
		DEFAULT => -203
	},
	{#State 352
		DEFAULT => -133
	},
	{#State 353
		ACTIONS => {
			";" => 388
		}
	},
	{#State 354
		ACTIONS => {
			'OP07_STRING_REPEAT' => 210,
			'OP01_NAMED' => 211,
			'OP10_NAMED_UNARY' => 212,
			'OP01_CLOSE' => 209,
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_NAMED_VOID' => 226,
			'OP11_COMPARE_LT_GT' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			"}" => 389,
			'OP01_OPEN' => 227,
			'OP01_PRINT' => 229,
			'WORD' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'OP23_LOGICAL_AND' => 219,
			'OP19_LOOP_CONTROL' => 230,
			'OP22_LOGICAL_NEG' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 233
		},
		GOTOS => {
			'HashEntryProperties' => 391,
			'OpStringOrWord' => 390
		}
	},
	{#State 355
		ACTIONS => {
			";" => 392
		}
	},
	{#State 356
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 55,
			'TYPE_METHOD' => 393
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 357
		ACTIONS => {
			";" => 394
		}
	},
	{#State 358
		DEFAULT => -59
	},
	{#State 359
		DEFAULT => -77
	},
	{#State 360
		DEFAULT => -78
	},
	{#State 361
		DEFAULT => -48
	},
	{#State 362
		ACTIONS => {
			'OP21_LIST_COMMA' => 395,
			")" => 396
		},
		GOTOS => {
			'PAREN-19' => 397
		}
	},
	{#State 363
		DEFAULT => -227
	},
	{#State 364
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 398
		}
	},
	{#State 365
		DEFAULT => -188
	},
	{#State 366
		DEFAULT => -109
	},
	{#State 367
		DEFAULT => -134
	},
	{#State 368
		ACTIONS => {
			'LITERAL_STRING' => 399
		}
	},
	{#State 369
		DEFAULT => -160,
		GOTOS => {
			'STAR-39' => 400
		}
	},
	{#State 370
		ACTIONS => {
			'LITERAL_STRING' => 95,
			"while" => -152,
			'WORD_UPPERCASE' => 97,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP01_NAMED_VOID' => 104,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_LPAREN' => 83,
			'OP19_LOOP_CONTROL' => 82,
			"%{" => 80,
			'OP01_PRINT' => 85,
			"for" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			"foreach" => -152,
			'OP03_MATH_INC_DEC' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY' => 125,
			'OP01_CLOSE' => 127,
			'OP01_NAMED_SCOLON' => 129,
			'OP05_MATH_NEG_LPAREN' => 130,
			"\@{" => 107,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD' => 29,
			"if" => 109,
			'LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 113,
			'MY' => 117,
			'LBRACE' => 118
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'Conditional' => 84,
			'SubExpression' => 87,
			'OPTIONAL-37' => 115,
			'Operator' => 90,
			'PAREN-36' => 89,
			'VariableSymbolOrSelf' => 114,
			'PLUS-42' => 402,
			'LoopLabel' => 120,
			'Expression' => 119,
			'Literal' => 94,
			'HashDereference' => 123,
			'Variable' => 96,
			'WordScoped' => 124,
			'OperatorVoid' => 98,
			'Operation' => 401,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Statement' => 131,
			'VariableModification' => 106,
			'VariableDeclaration' => 132
		}
	},
	{#State 371
		ACTIONS => {
			")" => 403
		}
	},
	{#State 372
		DEFAULT => -83
	},
	{#State 373
		DEFAULT => -181
	},
	{#State 374
		DEFAULT => -180
	},
	{#State 375
		DEFAULT => -179
	},
	{#State 376
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 378
		ACTIONS => {
			'LPAREN' => 406
		}
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 408
		}
	},
	{#State 381
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 176,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 177,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			"]" => 409,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 382
		ACTIONS => {
			";" => 410
		}
	},
	{#State 383
		DEFAULT => -241
	},
	{#State 384
		DEFAULT => -240
	},
	{#State 385
		DEFAULT => -183
	},
	{#State 386
		DEFAULT => -209
	},
	{#State 387
		ACTIONS => {
			'OP18_TERNARY' => 177,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -205,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP21_LIST_COMMA' => -205,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164
		}
	},
	{#State 388
		DEFAULT => -123
	},
	{#State 389
		ACTIONS => {
			";" => 411
		}
	},
	{#State 390
		ACTIONS => {
			'OP20_HASH_FATARROW' => 412
		}
	},
	{#State 391
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 413
		}
	},
	{#State 392
		DEFAULT => -67
	},
	{#State 393
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 394
		DEFAULT => -61
	},
	{#State 395
		ACTIONS => {
			'MY' => 415
		}
	},
	{#State 396
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 397
		DEFAULT => -50
	},
	{#State 398
		DEFAULT => -224
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 417
		}
	},
	{#State 400
		ACTIONS => {
			'LITERAL_STRING' => -163,
			"while" => -163,
			'WORD_UPPERCASE' => -163,
			'LBRACKET' => -163,
			'OP01_OPEN' => -163,
			'OP05_LOGICAL_NEG' => -163,
			'CONSTANT_CALL_SCOPED' => -163,
			'OP01_NAMED_VOID' => -163,
			'WORD_SCOPED' => -163,
			"else" => 420,
			'LITERAL_NUMBER' => -163,
			'OP01_NAMED_VOID_LPAREN' => -163,
			"%{" => -163,
			'OP19_LOOP_CONTROL' => -163,
			"elsif" => 422,
			'OP01_PRINT' => -163,
			'OP19_LOOP_CONTROL_SCOLON' => -163,
			"for" => -163,
			'OP05_BITWISE_NEG_LPAREN' => -163,
			"undef" => -163,
			'VARIABLE_SYMBOL' => -163,
			"foreach" => -163,
			'SELF' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP10_NAMED_UNARY_SCOLON' => -163,
			'OP01_NAMED' => -163,
			'OP10_NAMED_UNARY' => -163,
			'OP01_CLOSE' => -163,
			'OP01_NAMED_SCOLON' => -163,
			"}" => -163,
			'OP05_MATH_NEG_LPAREN' => -163,
			"\@{" => -163,
			'OP01_NAMED_VOID_SCOLON' => -163,
			'WORD' => -163,
			"if" => -163,
			'LPAREN' => -163,
			'OP22_LOGICAL_NEG' => -163,
			'' => -163,
			'MY' => -163,
			'LBRACE' => -163
		},
		GOTOS => {
			'PAREN-38' => 421,
			'OPTIONAL-41' => 419,
			'PAREN-40' => 418
		}
	},
	{#State 401
		DEFAULT => -174
	},
	{#State 402
		ACTIONS => {
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 95,
			"while" => -152,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_VOID' => 104,
			'CONSTANT_CALL_SCOPED' => 105,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"for" => -152,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP01_PRINT' => 85,
			'OP01_NAMED_VOID_LPAREN' => 83,
			'OP19_LOOP_CONTROL' => 82,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"foreach" => -152,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121,
			'OP05_MATH_NEG_LPAREN' => 130,
			"}" => 423,
			'OP01_NAMED_SCOLON' => 129,
			'LPAREN' => 112,
			"if" => 109,
			'WORD' => 29,
			'OP01_NAMED_VOID_SCOLON' => 108,
			"\@{" => 107,
			'LBRACE' => 118,
			'MY' => 117,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'Operation' => 424,
			'OperatorVoid' => 98,
			'WordScoped' => 124,
			'Variable' => 96,
			'HashDereference' => 123,
			'Literal' => 94,
			'LoopLabel' => 120,
			'Expression' => 119,
			'VariableModification' => 106,
			'VariableDeclaration' => 132,
			'HashReference' => 103,
			'Statement' => 131,
			'ArrayReference' => 128,
			'SubExpression' => 87,
			'Conditional' => 84,
			'ArrayDereference' => 110,
			'VariableSymbolOrSelf' => 114,
			'OPTIONAL-37' => 115,
			'Operator' => 90,
			'PAREN-36' => 89
		}
	},
	{#State 403
		DEFAULT => -85
	},
	{#State 404
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'FHREF_SYMBOL_IN' => 284,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'STDIN' => 283,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'SubExpression' => 282,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpressionOrInput' => 425,
			'HashDereference' => 123,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashReference' => 103,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 405
		DEFAULT => -171
	},
	{#State 406
		ACTIONS => {
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105
		},
		GOTOS => {
			'HashReference' => 103,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayDereference' => 110,
			'SubExpression' => 426,
			'Expression' => 149,
			'Literal' => 94,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152
		}
	},
	{#State 407
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_NAMED_SCOLON' => 428,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP10_NAMED_UNARY_SCOLON' => 429,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Expression' => 149,
			'Literal' => 94,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'ArrayDereference' => 110,
			'SubExpression' => 430,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'OpNamedScolonOrSubExp' => 427,
			'HashReference' => 103
		}
	},
	{#State 408
		ACTIONS => {
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'LITERAL_STRING' => 95,
			'OP01_QW' => 147,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'ARGV' => 150,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			'MY' => 141,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'ListElements' => 431,
			'HashReference' => 103,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'ListElement' => 148,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 153,
			'TypeInner' => 154,
			'ArrayDereference' => 110
		}
	},
	{#State 409
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 432
		}
	},
	{#State 410
		DEFAULT => -242
	},
	{#State 411
		DEFAULT => -66
	},
	{#State 412
		ACTIONS => {
			'MY' => 434
		},
		GOTOS => {
			'TypeInnerProperties' => 433
		}
	},
	{#State 413
		ACTIONS => {
			"}" => 437,
			'OP21_LIST_COMMA' => 436
		},
		GOTOS => {
			'PAREN-25' => 435
		}
	},
	{#State 414
		ACTIONS => {
			"= sub {" => 438
		}
	},
	{#State 415
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 55,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 439
		}
	},
	{#State 416
		ACTIONS => {
			"\@_;" => 440
		}
	},
	{#State 417
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100
		},
		GOTOS => {
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 441,
			'ArrayDereference' => 110
		}
	},
	{#State 418
		DEFAULT => -162
	},
	{#State 419
		DEFAULT => -164
	},
	{#State 420
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 421
		DEFAULT => -159
	},
	{#State 422
		ACTIONS => {
			'LPAREN' => 443
		}
	},
	{#State 423
		DEFAULT => -175
	},
	{#State 424
		DEFAULT => -173
	},
	{#State 425
		ACTIONS => {
			")" => 444
		}
	},
	{#State 426
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP17_LIST_RANGE' => 445,
			'OP06_REGEX_MATCH' => 162,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168
		}
	},
	{#State 427
		ACTIONS => {
			'VARIABLE_SYMBOL' => 446
		}
	},
	{#State 428
		DEFAULT => -237
	},
	{#State 429
		DEFAULT => -238
	},
	{#State 430
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 178,
			";" => 447,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174
		}
	},
	{#State 431
		ACTIONS => {
			")" => 448
		}
	},
	{#State 432
		ACTIONS => {
			"undef" => 449
		}
	},
	{#State 433
		DEFAULT => -208
	},
	{#State 434
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 450
		}
	},
	{#State 435
		DEFAULT => -63
	},
	{#State 436
		ACTIONS => {
			'OP01_CLOSE' => 209,
			'OP01_NAMED' => 211,
			'OP10_NAMED_UNARY' => 212,
			'OP07_STRING_REPEAT' => 210,
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP08_MATH_ADD_SUB' => 215,
			'OP01_NAMED_VOID' => 226,
			'OP11_COMPARE_LT_GT' => 225,
			'OP01_OPEN' => 227,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'WORD' => 218,
			'OP01_PRINT' => 229,
			'OP19_LOOP_CONTROL' => 230,
			'OP23_LOGICAL_AND' => 219,
			'OP07_MATH_MULT_DIV_MOD' => 233,
			'OP22_LOGICAL_NEG' => 220
		},
		GOTOS => {
			'OpStringOrWord' => 390,
			'HashEntryProperties' => 451
		}
	},
	{#State 437
		ACTIONS => {
			";" => 452
		}
	},
	{#State 438
		ACTIONS => {
			'LPAREN_MY' => 455,
			'OP22_LOGICAL_NEG' => -69,
			'LBRACE' => -69,
			'MY' => -69,
			'OP01_NAMED_VOID_SCOLON' => -69,
			"\@{" => -69,
			'LPAREN' => -69,
			'WORD' => -69,
			"if" => -69,
			'OP05_MATH_NEG_LPAREN' => -69,
			'OP01_NAMED_SCOLON' => -69,
			"}" => -69,
			'OP10_NAMED_UNARY_SCOLON' => -69,
			'OP03_MATH_INC_DEC' => -69,
			'OP01_CLOSE' => -69,
			'OP10_NAMED_UNARY' => -69,
			'OP01_NAMED' => -69,
			"undef" => -69,
			"foreach" => -69,
			'SELF' => -69,
			'VARIABLE_SYMBOL' => -69,
			'OP01_NAMED_VOID_LPAREN' => -69,
			"%{" => -69,
			'LITERAL_NUMBER' => -69,
			'OP19_LOOP_CONTROL' => -69,
			'OP19_LOOP_CONTROL_SCOLON' => -69,
			"for" => -69,
			'OP05_BITWISE_NEG_LPAREN' => -69,
			'OP01_PRINT' => -69,
			'OP05_LOGICAL_NEG' => -69,
			'OP01_OPEN' => -69,
			'LBRACKET' => -69,
			'WORD_SCOPED' => -69,
			'CONSTANT_CALL_SCOPED' => -69,
			'OP01_NAMED_VOID' => -69,
			'LITERAL_STRING' => -69,
			"while" => -69,
			'WORD_UPPERCASE' => -69
		},
		GOTOS => {
			'OPTIONAL-27' => 453,
			'MethodArguments' => 454
		}
	},
	{#State 439
		ACTIONS => {
			'VARIABLE_SYMBOL' => 456
		}
	},
	{#State 440
		DEFAULT => -52
	},
	{#State 441
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			"]" => -86,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			")" => -86,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP18_TERNARY' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 176,
			";" => -86,
			'OP14_BITWISE_OR_XOR' => 178,
			"}" => -86
		}
	},
	{#State 442
		DEFAULT => -161
	},
	{#State 443
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			"%{" => 80,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'HashReference' => 103,
			'ArrayReference' => 128,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayDereference' => 110,
			'SubExpression' => 457,
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123
		}
	},
	{#State 444
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 458
		}
	},
	{#State 445
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'VARIABLE_SYMBOL' => 92,
			'SELF' => 93,
			'LBRACE' => 118,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			'WORD' => 29,
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 130,
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127
		},
		GOTOS => {
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 459,
			'ArrayDereference' => 110
		}
	},
	{#State 446
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 460
		}
	},
	{#State 447
		DEFAULT => -239
	},
	{#State 448
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 461
		}
	},
	{#State 449
		ACTIONS => {
			";" => 462
		}
	},
	{#State 450
		ACTIONS => {
			"\$TYPED_" => 463
		}
	},
	{#State 451
		DEFAULT => -62
	},
	{#State 452
		DEFAULT => -65
	},
	{#State 453
		DEFAULT => -71,
		GOTOS => {
			'STAR-28' => 464
		}
	},
	{#State 454
		DEFAULT => -68
	},
	{#State 455
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 465
		}
	},
	{#State 456
		DEFAULT => -49
	},
	{#State 457
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP04_MATH_POW' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			")" => 466,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP18_TERNARY' => 177,
			'OP11_COMPARE_LT_GT' => 176,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 178
		}
	},
	{#State 458
		DEFAULT => -172
	},
	{#State 459
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			")" => 467,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP18_TERNARY' => -108,
			'OP14_BITWISE_OR_XOR' => 178
		}
	},
	{#State 460
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_NAMED_SCOLON' => 428,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP10_NAMED_UNARY_SCOLON' => 429,
			'OP03_MATH_INC_DEC' => 121,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107
		},
		GOTOS => {
			'Expression' => 149,
			'Literal' => 94,
			'WordScoped' => 124,
			'Variable' => 152,
			'HashDereference' => 123,
			'ArrayDereference' => 110,
			'SubExpression' => 430,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'OpNamedScolonOrSubExp' => 468,
			'HashReference' => 103
		}
	},
	{#State 461
		DEFAULT => -170
	},
	{#State 462
		DEFAULT => -184
	},
	{#State 463
		ACTIONS => {
			'OP01_CLOSE' => 209,
			'OP07_STRING_REPEAT' => 210,
			'OP01_NAMED' => 211,
			'OP10_NAMED_UNARY' => 212,
			'OP12_COMPARE_EQ_NE' => 221,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_NAMED_VOID' => 226,
			'OP11_COMPARE_LT_GT' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP01_OPEN' => 227,
			'OP19_LOOP_CONTROL_SCOLON' => 228,
			'OP01_PRINT' => 229,
			'WORD' => 218,
			'OP19_LOOP_CONTROL' => 230,
			'OP23_LOGICAL_AND' => 219,
			'OP07_MATH_MULT_DIV_MOD' => 233,
			'OP22_LOGICAL_NEG' => 220
		},
		GOTOS => {
			'OpStringOrWord' => 469
		}
	},
	{#State 464
		ACTIONS => {
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 95,
			"while" => -152,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_VOID' => 104,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"for" => -152,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'OP01_PRINT' => 85,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_LPAREN' => 83,
			"%{" => 80,
			'OP19_LOOP_CONTROL' => 82,
			"foreach" => -152,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP01_CLOSE' => 127,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 126,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121,
			'OP05_MATH_NEG_LPAREN' => 130,
			"}" => 470,
			'OP01_NAMED_SCOLON' => 129,
			'LPAREN' => 112,
			"if" => 109,
			'WORD' => 29,
			'OP01_NAMED_VOID_SCOLON' => 108,
			"\@{" => 107,
			'LBRACE' => 118,
			'MY' => 117,
			'OP22_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'ArrayReference' => 128,
			'Statement' => 131,
			'HashReference' => 103,
			'VariableDeclaration' => 132,
			'VariableModification' => 106,
			'Expression' => 119,
			'LoopLabel' => 120,
			'Literal' => 94,
			'Variable' => 96,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'OperatorVoid' => 98,
			'Operation' => 471,
			'OPTIONAL-37' => 115,
			'PAREN-36' => 89,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 110,
			'Conditional' => 84,
			'SubExpression' => 87
		}
	},
	{#State 465
		ACTIONS => {
			'SELF' => 472
		}
	},
	{#State 466
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 473
		}
	},
	{#State 467
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 474
		}
	},
	{#State 468
		ACTIONS => {
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_CLOSE' => 127,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 125,
			'OP01_NAMED' => 146,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_OPEN' => 101,
			'LBRACKET' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'LITERAL_NUMBER' => 81,
			"%{" => 80,
			"\@{" => 107,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			'WORD' => 29,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'Literal' => 94,
			'Expression' => 149,
			'Variable' => 96,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'SubExpressionOrVarMod' => 475,
			'ArrayDereference' => 110,
			'SubExpression' => 477,
			'ArrayReference' => 128,
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'HashReference' => 103,
			'VariableModification' => 476
		}
	},
	{#State 469
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 479,
			'OP19_VARIABLE_ASSIGN' => 478
		}
	},
	{#State 470
		ACTIONS => {
			";" => 480
		}
	},
	{#State 471
		DEFAULT => -70
	},
	{#State 472
		DEFAULT => -75,
		GOTOS => {
			'STAR-30' => 481
		}
	},
	{#State 473
		DEFAULT => -158
	},
	{#State 474
		DEFAULT => -168
	},
	{#State 475
		ACTIONS => {
			")" => 482
		}
	},
	{#State 476
		DEFAULT => -149
	},
	{#State 477
		ACTIONS => {
			")" => -148,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 176,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP18_TERNARY' => 177,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 167,
			'OP16_LOGICAL_OR' => 166
		}
	},
	{#State 478
		ACTIONS => {
			'LPAREN' => 112,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'WORD' => 29,
			"%{" => 80,
			'LITERAL_NUMBER' => 81,
			"\@{" => 107,
			'LBRACE' => 118,
			'SELF' => 93,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 91,
			'OP22_LOGICAL_NEG' => 113,
			'OP01_CLOSE' => 127,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 95,
			'OP03_MATH_INC_DEC' => 121,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Operator' => 90,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Variable' => 152,
			'Expression' => 149,
			'Literal' => 94,
			'SubExpression' => 483,
			'ArrayDereference' => 110
		}
	},
	{#State 479
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 105,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 125,
			'WORD_UPPERCASE' => 151,
			'OP01_CLOSE' => 127,
			'OP03_MATH_INC_DEC' => 121,
			'LITERAL_STRING' => 95,
			'VARIABLE_SYMBOL' => 92,
			'LBRACE' => 118,
			'SELF' => 93,
			'OP22_LOGICAL_NEG' => 113,
			"undef" => 91,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 86,
			'LPAREN' => 112,
			"\@{" => 107,
			'LITERAL_NUMBER' => 81,
			"%{" => 80
		},
		GOTOS => {
			'Operator' => 90,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 128,
			'HashReference' => 103,
			'Variable' => 152,
			'WordScoped' => 124,
			'HashDereference' => 123,
			'Literal' => 94,
			'Expression' => 149,
			'SubExpression' => 484,
			'ArrayDereference' => 110
		}
	},
	{#State 480
		DEFAULT => -72
	},
	{#State 481
		ACTIONS => {
			")" => 485,
			'OP21_LIST_COMMA' => 487
		},
		GOTOS => {
			'PAREN-29' => 486
		}
	},
	{#State 482
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 488
		}
	},
	{#State 483
		ACTIONS => {
			'OP21_LIST_COMMA' => -225,
			'OP13_BITWISE_AND' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			'OP11_COMPARE_LT_GT' => 176,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 177,
			"}" => -225,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175
		}
	},
	{#State 484
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_STRING_CAT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 176,
			'OP18_TERNARY' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => 163,
			'OP04_MATH_POW' => 164,
			'OP09_BITWISE_SHIFT' => 173,
			"]" => 489,
			'OP07_MATH_MULT_DIV_MOD' => 174,
			'OP13_BITWISE_AND' => 165
		}
	},
	{#State 485
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 490
		}
	},
	{#State 486
		DEFAULT => -74
	},
	{#State 487
		ACTIONS => {
			'MY' => 491
		}
	},
	{#State 488
		DEFAULT => -169
	},
	{#State 489
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 490
		ACTIONS => {
			"\@_;" => 493
		}
	},
	{#State 491
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 494
		}
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
