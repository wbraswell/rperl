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
    our $VERSION = 0.003_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|foreach|\=\ sub\ \{|elsif|undef|while|else|\@_\;|our|for|\%\{|\@\{|if|\;|\]|\}|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("((\\n)|(\\t)|[^"\@\$\\])*((\\n)|(\\t))+((\\n)|(\\t)|[^"\@\$\\])*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
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
      /\G(==|!=|eq|ne)\s/gc and return ('OP12_COMPARE_EQ_NE', $1);
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
      /\G(abs;|accept;|atan2;|bind;|binmode;|bless;|break;|chmod;|chomp;|chop;|chown;|chr;|closedir;|cmp;|connect;|continue;|crypt;|dbmclose;|dbmopen;|default;|dump;|each;|endgrent;|endhostent;|endnetent;|endprotoent;|endpwent;|endservent;|eof;|evalbytes;|exec;|exp;|fc;|fcntl;|fileno;|flock;|fork;|format;|formline;|getc;|getgrent;|getgrgid;|getgrnam;|gethostbyaddr;|gethostent;|getlogin;|getnetbyaddr;|getnetent;|getpeername;|getppid;|getpriority;|getprotobynumber;|getprotoent;|getpwent;|getpwnam;|getpwuid;|getservbyname;|getservbyport;|getservent;|getsockname;|getsockopt;|given;|grep;|index;|ioctl;|join;|keys;|kill;|link;|listen;|local;|m;|map;|mkdir;|msgctl;|msgget;|msgrcv;|msgsnd;|opendir;|pack;|pipe;|pop;|pos;|prototype;|push;|q;|qq;|qr;|qx;|read;|readdir;|readline;|readpipe;|recv;|rename;|reset;|reverse;|rewinddir;|rindex;|s;|say;|seek;|seekdir;|select;|semctl;|semget;|semop;|send;|setgrent;|sethostent;|setnetent;|setpgrp;|setpriority;|setprotoent;|setpwent;|setservent;|setsockopt;|shift;|shmctl;|shmget;|shmread;|shmwrite;|shutdown;|socket;|socketpair;|sort;|splice;|split;|sprintf;|state;|study;|substr;|symlink;|syscall;|sysopen;|sysread;|sysseek;|system;|syswrite;|tell;|telldir;|tie;|tied;|time;|times;|tr;|truncate;|unless;|unlink;|unpack;|unshift;|untie;|until;|utime;|values;|vec;|wait;|waitpid;|wantarray;|warn;|when;|write;|y;)/gc and return ('OP01_NAMED_SCOLON', $1);
      /\G(abs\s|accept\s|atan2\s|bind\s|binmode\s|bless\s|break\s|chmod\s|chomp\s|chop\s|chown\s|chr\s|closedir\s|cmp\s|connect\s|continue\s|crypt\s|dbmclose\s|dbmopen\s|default\s|dump\s|each\s|endgrent\s|endhostent\s|endnetent\s|endprotoent\s|endpwent\s|endservent\s|eof\s|evalbytes\s|exec\s|exp\s|fc\s|fcntl\s|fileno\s|flock\s|fork\s|format\s|formline\s|getc\s|getgrent\s|getgrgid\s|getgrnam\s|gethostbyaddr\s|gethostent\s|getlogin\s|getnetbyaddr\s|getnetent\s|getpeername\s|getppid\s|getpriority\s|getprotobynumber\s|getprotoent\s|getpwent\s|getpwnam\s|getpwuid\s|getservbyname\s|getservbyport\s|getservent\s|getsockname\s|getsockopt\s|given\s|grep\s|index\s|ioctl\s|join\s|keys\s|kill\s|link\s|listen\s|local\s|m\s|map\s|mkdir\s|msgctl\s|msgget\s|msgrcv\s|msgsnd\s|opendir\s|pack\s|pipe\s|pop\s|pos\s|prototype\s|push\s|q\s|qq\s|qr\s|qx\s|read\s|readdir\s|readline\s|readpipe\s|recv\s|rename\s|reset\s|reverse\s|rewinddir\s|rindex\s|s\s|say\s|seek\s|seekdir\s|select\s|semctl\s|semget\s|semop\s|send\s|setgrent\s|sethostent\s|setnetent\s|setpgrp\s|setpriority\s|setprotoent\s|setpwent\s|setservent\s|setsockopt\s|shift\s|shmctl\s|shmget\s|shmread\s|shmwrite\s|shutdown\s|socket\s|socketpair\s|sort\s|splice\s|split\s|sprintf\s|state\s|study\s|substr\s|symlink\s|syscall\s|sysopen\s|sysread\s|sysseek\s|system\s|syswrite\s|tell\s|telldir\s|tie\s|tied\s|time\s|times\s|tr\s|truncate\s|unless\s|unlink\s|unpack\s|unshift\s|untie\s|until\s|utime\s|values\s|vec\s|wait\s|waitpid\s|wantarray\s|warn\s|when\s|write\s|y\s)/gc and return ('OP01_NAMED', $1);
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


#line 142 lib/RPerl/Grammar.pm

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
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'Method_71' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-27', 'STAR-28', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'PAREN-29' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'MethodArguments_75' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-30', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_76' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_77' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
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
  [ 'Operator_90' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'PAREN-31' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-32', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-33', ')', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_143' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_144' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_145' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_146' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_147' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_162' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_164' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_166' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_167' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_168' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_169' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_170' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_173' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_176' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_182' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_183' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_184' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_185' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_189' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_196' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_199' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_200' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_203' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_204' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_205' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_206' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_210' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_211' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_214' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_215' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_216' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_217' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_218' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_219' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_220' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_221' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_222' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_223' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_224' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_225' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_226' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_227' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_228' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_229' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_230' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_231' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_232' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_233' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_234' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_235' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_236' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_237' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_238' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_239' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_240' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_241' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_242' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_243' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_244' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_245' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_246' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_247' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_248' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_249' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_250' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_251' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_252' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_253' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_254' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'MethodOrSubroutine_76' => 76,
  'MethodOrSubroutine_77' => 77,
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
  '_PAREN' => 111,
  '_OPTIONAL' => 112,
  '_OPTIONAL' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpressionOrInput_143' => 143,
  'SubExpressionOrInput_144' => 144,
  'SubExpressionOrInput_145' => 145,
  'SubExpressionOrVarMod_146' => 146,
  'SubExpressionOrVarMod_147' => 147,
  '_PAREN' => 148,
  '_OPTIONAL' => 149,
  '_OPTIONAL' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  '_PAREN' => 156,
  '_STAR_LIST' => 157,
  '_STAR_LIST' => 158,
  '_PAREN' => 159,
  '_OPTIONAL' => 160,
  '_OPTIONAL' => 161,
  'Conditional_162' => 162,
  'Loop_163' => 163,
  'Loop_164' => 164,
  'Loop_165' => 165,
  'LoopFor_166' => 166,
  'LoopFor_167' => 167,
  'LoopForEach_168' => 168,
  'LoopWhile_169' => 169,
  'LoopWhile_170' => 170,
  '_PLUS_LIST' => 171,
  '_PLUS_LIST' => 172,
  'CodeBlock_173' => 173,
  '_STAR_LIST' => 174,
  '_STAR_LIST' => 175,
  'Variable_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableRetrieval_178' => 178,
  'VariableRetrieval_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableDeclaration_182' => 182,
  'VariableDeclaration_183' => 183,
  'VariableModification_184' => 184,
  'VariableModification_185' => 185,
  '_PAREN' => 186,
  '_STAR_LIST' => 187,
  '_STAR_LIST' => 188,
  'ListElements_189' => 189,
  'ListElement_190' => 190,
  'ListElement_191' => 191,
  'ListElement_192' => 192,
  'ListElement_193' => 193,
  '_OPTIONAL' => 194,
  '_OPTIONAL' => 195,
  'ArrayReference_196' => 196,
  '_OPTIONAL' => 197,
  '_OPTIONAL' => 198,
  'ArrayDereference_199' => 199,
  'ArrayDereference_200' => 200,
  '_OPTIONAL' => 201,
  '_OPTIONAL' => 202,
  'HashEntry_203' => 203,
  'HashEntry_204' => 204,
  'HashEntry_205' => 205,
  'HashEntryProperties_206' => 206,
  '_PAREN' => 207,
  '_STAR_LIST' => 208,
  '_STAR_LIST' => 209,
  'HashReference_210' => 210,
  'HashReference_211' => 211,
  '_OPTIONAL' => 212,
  '_OPTIONAL' => 213,
  'HashDereference_214' => 214,
  'HashDereference_215' => 215,
  'WordScoped_216' => 216,
  'WordScoped_217' => 217,
  'LoopLabel_218' => 218,
  'Type_219' => 219,
  'Type_220' => 220,
  'Type_221' => 221,
  'TypeInner_222' => 222,
  'TypeInnerProperties_223' => 223,
  'TypeInnerProperties_224' => 224,
  'TypeInnerConstant_225' => 225,
  'VariableOrLiteral_226' => 226,
  'VariableOrLiteral_227' => 227,
  'VarOrLitOrOpStrOrWord_228' => 228,
  'VarOrLitOrOpStrOrWord_229' => 229,
  'VarOrLitOrOpStrOrWord_230' => 230,
  'VariableSymbolOrSelf_231' => 231,
  'VariableSymbolOrSelf_232' => 232,
  'Literal_233' => 233,
  'Literal_234' => 234,
  'OpNamedScolonOrSubExp_235' => 235,
  'OpNamedScolonOrSubExp_236' => 236,
  'OpNamedScolonOrSubExp_237' => 237,
  'OpNamedScolonOrSubExpIn_238' => 238,
  'OpNamedScolonOrSubExpIn_239' => 239,
  'OpNamedScolonOrSubExpIn_240' => 240,
  'OpStringOrWord_241' => 241,
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
			"## no critic qw(" => 3,
			'USE_RPERL' => -20,
			'SHEBANG' => 1,
			"package" => -20
		},
		GOTOS => {
			'CompileUnit' => 5,
			'PAREN-1' => 6,
			'ModuleHeader' => 7,
			'OPTIONAL-9' => 2,
			'Program' => 8,
			'PLUS-2' => 9,
			'Critic' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"## no critic qw(" => 3,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 13
		},
		GOTOS => {
			'OPTIONAL-10' => 12
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 14
		},
		GOTOS => {
			'PLUS-16' => 15
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			'' => 16
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			"our" => -27,
			'USE' => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 20,
			"use constant" => -27
		},
		GOTOS => {
			'Class' => 19,
			'Module' => 18,
			'Package' => 21,
			'STAR-11' => 17
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 3,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 2,
			'Critic' => 4,
			'PAREN-1' => 22,
			'ModuleHeader' => 7
		}
	},
	{#State 10
		ACTIONS => {
			'USE_RPERL' => 23
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			"package" => 24
		}
	},
	{#State 13
		DEFAULT => -21
	},
	{#State 14
		DEFAULT => -39
	},
	{#State 15
		ACTIONS => {
			")" => 26,
			'WORD' => 25
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			"## no critic qw(" => 3,
			"our" => -29,
			'USE' => -29,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 28,
			'Critic' => 27
		}
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => -24
	},
	{#State 22
		DEFAULT => -2
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
		ACTIONS => {
			'WORD_SCOPED' => 30,
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
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			"use constant" => -31,
			'USE' => 36,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 37,
			'Include' => 35
		}
	},
	{#State 29
		DEFAULT => -216
	},
	{#State 30
		DEFAULT => -217
	},
	{#State 31
		ACTIONS => {
			")" => 38
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
			";" => 41
		}
	},
	{#State 35
		DEFAULT => -28
	},
	{#State 36
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 42
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 44,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 43,
			'PLUS-14' => 46,
			'Constant' => 45
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
			'USE_RPERL_AFTER' => 50
		},
		GOTOS => {
			'OPTIONAL-15' => 49
		}
	},
	{#State 40
		ACTIONS => {
			"for" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LPAREN' => -11,
			'MY' => -11,
			'WORD' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"if" => -11,
			"foreach" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LBRACE' => -11,
			'OP01_NAMED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'USE' => -11,
			"undef" => -11,
			"while" => -11,
			'WORD_UPPERCASE' => -11,
			'WORD_SCOPED' => -11,
			"## no critic qw(" => 3,
			'OP01_CLOSE' => -11,
			'OP01_OPEN' => -11,
			"\@{" => -11,
			"our" => -11,
			"use constant" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_PRINT' => -11,
			'SELF' => -11,
			'LBRACKET' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'LITERAL_STRING' => -11,
			"%{" => -11
		},
		GOTOS => {
			'Critic' => 52,
			'STAR-5' => 51
		}
	},
	{#State 41
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'OP01_QW' => 54,
			";" => 55
		}
	},
	{#State 43
		DEFAULT => -33
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 47
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 61,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 62
		}
	},
	{#State 48
		ACTIONS => {
			'USE' => 36
		},
		GOTOS => {
			'Include' => 63
		}
	},
	{#State 49
		ACTIONS => {
			"our" => 64
		}
	},
	{#State 50
		DEFAULT => -35
	},
	{#State 51
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"foreach" => -13,
			"if" => -13,
			'LPAREN' => -13,
			'MY' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"for" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LBRACE' => -13,
			"our" => -13,
			'OP01_CLOSE' => -13,
			'OP01_OPEN' => -13,
			"\@{" => -13,
			"while" => -13,
			"undef" => -13,
			'WORD_UPPERCASE' => -13,
			'USE' => 36,
			'WORD_SCOPED' => -13,
			"%{" => -13,
			'LITERAL_STRING' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'SELF' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"use constant" => -13,
			'OP01_PRINT' => -13,
			'LITERAL_NUMBER' => -13
		},
		GOTOS => {
			'STAR-6' => 65,
			'Include' => 66
		}
	},
	{#State 52
		DEFAULT => -8
	},
	{#State 53
		DEFAULT => -23
	},
	{#State 54
		ACTIONS => {
			";" => 67
		}
	},
	{#State 55
		DEFAULT => -41
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 57
		ACTIONS => {
			";" => 69
		}
	},
	{#State 58
		DEFAULT => -32
	},
	{#State 59
		DEFAULT => -221
	},
	{#State 60
		DEFAULT => -220
	},
	{#State 61
		DEFAULT => -219
	},
	{#State 62
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		}
	},
	{#State 63
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 71
		}
	},
	{#State 64
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 72
		}
	},
	{#State 65
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -15,
			'WORD' => -15,
			'LPAREN' => -15,
			'MY' => -15,
			'OP10_NAMED_UNARY' => -15,
			"for" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"foreach" => -15,
			"if" => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LBRACE' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			"while" => -15,
			"our" => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LBRACKET' => -15,
			'SELF' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_PRINT' => -15,
			"use constant" => 44,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			'CONSTANT_CALL_SCOPED' => -15
		},
		GOTOS => {
			'Constant' => 73,
			'STAR-7' => 74
		}
	},
	{#State 66
		DEFAULT => -10
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
		DEFAULT => -34
	},
	{#State 70
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 71
		ACTIONS => {
			"use constant" => -56,
			"## no critic qw(" => 3,
			'USE' => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'Critic' => 78,
			'STAR-22' => 79
		}
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_NAMED_VOID' => 120,
			'OP01_NAMED_SCOLON' => 112,
			"foreach" => -150,
			"if" => 114,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 108,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			"for" => -150,
			'OP10_NAMED_UNARY' => 106,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP19_LOOP_CONTROL' => 126,
			'OP19_LOOP_CONTROL_SCOLON' => 122,
			'LBRACE' => 123,
			"our" => 47,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			"undef" => 82,
			"while" => -150,
			'WORD_UPPERCASE' => 81,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 101,
			'LBRACKET' => 96,
			'SELF' => 95,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 94
		},
		GOTOS => {
			'WordScoped' => 131,
			'Operator' => 130,
			'HashDereference' => 125,
			'PAREN-36' => 100,
			'HashReference' => 99,
			'PLUS-8' => 97,
			'SubExpression' => 93,
			'Subroutine' => 91,
			'VariableModification' => 90,
			'ArrayDereference' => 119,
			'Statement' => 89,
			'VariableDeclaration' => 118,
			'Variable' => 116,
			'Conditional' => 88,
			'ArrayReference' => 115,
			'Expression' => 113,
			'VariableSymbolOrSelf' => 110,
			'OperatorVoid' => 109,
			'OPTIONAL-37' => 83,
			'Literal' => 84,
			'LoopLabel' => 105,
			'Operation' => 80
		}
	},
	{#State 75
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 132
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'Literal' => 133
		}
	},
	{#State 77
		ACTIONS => {
			"\@{" => -45,
			'OP01_OPEN' => -45,
			'OP01_CLOSE' => -45,
			'WORD_SCOPED' => -45,
			"undef" => -45,
			'WORD_UPPERCASE' => -45,
			"while" => -45,
			'LITERAL_STRING' => -45,
			"%{" => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'LBRACKET' => -45,
			'SELF' => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_PRINT' => -45,
			"}" => -45,
			'OP01_NAMED_VOID' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"foreach" => -45,
			"if" => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'WORD' => -45,
			'LPAREN' => -45,
			'MY' => -45,
			'OP10_NAMED_UNARY' => -45,
			"for" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP01_NAMED' => -45,
			'LPAREN_MY' => 134,
			'LBRACE' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 135,
			'OPTIONAL-17' => 136
		}
	},
	{#State 78
		DEFAULT => -53
	},
	{#State 79
		ACTIONS => {
			"use constant" => -58,
			"our hashref \$properties" => -58,
			'USE' => 36
		},
		GOTOS => {
			'STAR-23' => 137,
			'Include' => 138
		}
	},
	{#State 80
		DEFAULT => -17
	},
	{#State 81
		ACTIONS => {
			'LPAREN' => 139,
			'COLON' => -218
		}
	},
	{#State 82
		DEFAULT => -135
	},
	{#State 83
		ACTIONS => {
			"for" => 144,
			"foreach" => 140,
			"while" => 145
		},
		GOTOS => {
			'LoopForEach' => 142,
			'LoopFor' => 141,
			'LoopWhile' => 143,
			'Loop' => 146
		}
	},
	{#State 84
		DEFAULT => -136
	},
	{#State 85
		ACTIONS => {
			'FHREF_SYMBOL' => 147
		}
	},
	{#State 86
		ACTIONS => {
			'MY' => 148
		}
	},
	{#State 87
		ACTIONS => {
			'LBRACKET' => -198,
			'SELF' => 95,
			'MY' => 150,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'OPTIONAL-47' => 151,
			'Variable' => 149,
			'TypeInner' => 152,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 88
		DEFAULT => -151
	},
	{#State 89
		DEFAULT => -81
	},
	{#State 90
		ACTIONS => {
			";" => 153
		}
	},
	{#State 91
		DEFAULT => -14
	},
	{#State 92
		DEFAULT => -233
	},
	{#State 93
		ACTIONS => {
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167
		}
	},
	{#State 94
		ACTIONS => {
			'OP01_OPEN' => -113,
			'OP01_CLOSE' => -113,
			"\@{" => -113,
			'OP03_MATH_INC_DEC' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'ARGV' => -113,
			'OP10_NAMED_UNARY' => -113,
			"undef" => -113,
			'WORD' => -113,
			'WORD_UPPERCASE' => -113,
			'LPAREN' => -113,
			'MY' => -113,
			'WORD_SCOPED' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'FHREF_SYMBOL_BRACES' => 172,
			'CONSTANT_CALL_SCOPED' => -113,
			'STDOUT_STDERR' => 171,
			'OP01_QW' => -113,
			'OP01_NAMED' => -113,
			'VARIABLE_SYMBOL' => -113,
			"%{" => -113,
			'LITERAL_STRING' => -113,
			'OP05_LOGICAL_NEG' => -113,
			'LBRACE' => -113,
			'LITERAL_NUMBER' => -113,
			'LBRACKET' => -113,
			'SELF' => -113
		},
		GOTOS => {
			'PAREN-31' => 173,
			'OPTIONAL-32' => 174
		}
	},
	{#State 95
		DEFAULT => -232
	},
	{#State 96
		ACTIONS => {
			'SELF' => 95,
			'LBRACKET' => 96,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'MY' => 150,
			'LPAREN' => 107,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 106,
			"]" => -195,
			'OP03_MATH_INC_DEC' => 117,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87
		},
		GOTOS => {
			'ListElements' => 183,
			'TypeInner' => 184,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 182,
			'ListElement' => 178,
			'OPTIONAL-46' => 177,
			'Variable' => 176,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125
		}
	},
	{#State 97
		ACTIONS => {
			"while" => -150,
			'WORD_UPPERCASE' => 81,
			"undef" => 82,
			'WORD_SCOPED' => 30,
			'' => -18,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'LBRACKET' => 96,
			'SELF' => 95,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 94,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 101,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 108,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			"for" => -150,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED_VOID' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 112,
			"foreach" => -150,
			"if" => 114,
			'OP19_LOOP_CONTROL_SCOLON' => 122,
			'LBRACE' => 123,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP05_LOGICAL_NEG' => 129,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED' => 127,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'Expression' => 113,
			'ArrayReference' => 115,
			'Conditional' => 88,
			'Variable' => 116,
			'ArrayDereference' => 119,
			'VariableDeclaration' => 118,
			'Statement' => 89,
			'VariableModification' => 90,
			'Operation' => 186,
			'LoopLabel' => 105,
			'Literal' => 84,
			'OPTIONAL-37' => 83,
			'OperatorVoid' => 109,
			'VariableSymbolOrSelf' => 110,
			'HashReference' => 99,
			'PAREN-36' => 100,
			'HashDereference' => 125,
			'Operator' => 130,
			'WordScoped' => 131,
			'SubExpression' => 93
		}
	},
	{#State 98
		ACTIONS => {
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			")" => -115,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'MY' => 150,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'OP10_NAMED_UNARY' => 106,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86
		},
		GOTOS => {
			'Variable' => 176,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'OPTIONAL-33' => 188,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'ListElements' => 187,
			'TypeInner' => 184,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 182,
			'ListElement' => 178
		}
	},
	{#State 99
		DEFAULT => -140
	},
	{#State 100
		DEFAULT => -149
	},
	{#State 101
		DEFAULT => -130
	},
	{#State 102
		ACTIONS => {
			'LBRACE' => -213,
			'VARIABLE_SYMBOL' => 124,
			'MY' => 150,
			'SELF' => 95
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'TypeInner' => 190,
			'Variable' => 189,
			'OPTIONAL-51' => 191
		}
	},
	{#State 103
		DEFAULT => -234
	},
	{#State 104
		DEFAULT => -80
	},
	{#State 105
		ACTIONS => {
			'COLON' => 192
		}
	},
	{#State 106
		ACTIONS => {
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP23_LOGICAL_AND' => -99,
			'WORD_SCOPED' => 30,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			"\@{" => 87,
			'OP08_MATH_ADD_SUB' => -99,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'LITERAL_NUMBER' => 92,
			'OP15_LOGICAL_AND' => -99,
			"}" => -99,
			'LBRACKET' => 96,
			'SELF' => 95,
			'OP18_TERNARY' => -99,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP09_BITWISE_SHIFT' => -99,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP04_MATH_POW' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'OP06_REGEX_MATCH' => -99,
			'WORD' => 29,
			";" => -99,
			'LPAREN' => 107,
			'OP21_LIST_COMMA' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP07_STRING_REPEAT' => -99,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP17_LIST_RANGE' => -99,
			'LBRACE' => 123,
			'OP16_LOGICAL_OR' => -99,
			")" => -99,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_STRING_CAT' => -99,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'SubExpression' => 193,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130
		}
	},
	{#State 107
		ACTIONS => {
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_PRINT' => 196,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 194,
			'CONSTANT_CALL_SCOPED' => 101,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86
		},
		GOTOS => {
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 195
		}
	},
	{#State 108
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59,
			'TYPE_FHREF' => 197
		},
		GOTOS => {
			'Type' => 198
		}
	},
	{#State 109
		DEFAULT => -153
	},
	{#State 110
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 199
		}
	},
	{#State 111
		ACTIONS => {
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 200,
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125
		}
	},
	{#State 112
		DEFAULT => -79
	},
	{#State 113
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -134,
			";" => 201,
			'OP23_LOGICAL_AND' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP18_TERNARY' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP04_MATH_POW' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP08_STRING_CAT' => -134
		}
	},
	{#State 114
		ACTIONS => {
			'LPAREN' => 202
		}
	},
	{#State 115
		DEFAULT => -138
	},
	{#State 116
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 206,
			'OP23_LOGICAL_AND' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP03_MATH_INC_DEC' => 205,
			'OP07_STRING_REPEAT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP02_METHOD_THINARROW' => 204,
			")" => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP04_MATH_POW' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_STRING_CAT' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP18_TERNARY' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP19_VARIABLE_ASSIGN' => 203
		}
	},
	{#State 117
		ACTIONS => {
			'SELF' => 95,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Variable' => 207
		}
	},
	{#State 118
		DEFAULT => -154
	},
	{#State 119
		DEFAULT => -139
	},
	{#State 120
		ACTIONS => {
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'LPAREN' => 107,
			'MY' => 150,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29
		},
		GOTOS => {
			'SubExpression' => 182,
			'ListElement' => 178,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184,
			'ListElements' => 208,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176
		}
	},
	{#State 121
		ACTIONS => {
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY' => 106,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LBRACKET' => 96,
			'SELF' => 95
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 209,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175
		}
	},
	{#State 122
		DEFAULT => -122
	},
	{#State 123
		ACTIONS => {
			'SELF' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			"}" => 218,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'ENV' => 227,
			'OP24_LOGICAL_OR_XOR' => 231,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 229,
			'OP19_LOOP_CONTROL' => 228,
			'WORD' => 225,
			'OP23_LOGICAL_AND' => 215,
			'OP22_LOGICAL_NEG' => 226,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP10_NAMED_UNARY' => 224,
			'OP01_NAMED_VOID' => 223,
			'OP01_CLOSE' => 212,
			'OP07_STRING_REPEAT' => 221,
			'OP01_OPEN' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 211
		},
		GOTOS => {
			'HashDereference' => 230,
			'VarOrLitOrOpStrOrWord' => 233,
			'Variable' => 222,
			'HashEntry' => 214,
			'Literal' => 216,
			'OpStringOrWord' => 234,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 124
		DEFAULT => -231
	},
	{#State 125
		DEFAULT => -141
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
		ACTIONS => {
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'MY' => 150,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184,
			'ListElement' => 237,
			'SubExpression' => 238
		}
	},
	{#State 128
		DEFAULT => -118
	},
	{#State 129
		ACTIONS => {
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82
		},
		GOTOS => {
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 239
		}
	},
	{#State 130
		DEFAULT => -128
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 240,
			'OP02_METHOD_THINARROW_NEW' => 241
		}
	},
	{#State 132
		ACTIONS => {
			"\$TYPED_" => 242
		}
	},
	{#State 133
		ACTIONS => {
			";" => 243
		}
	},
	{#State 134
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 135
		DEFAULT => -44
	},
	{#State 136
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 245
		}
	},
	{#State 137
		ACTIONS => {
			"use constant" => 44,
			"our hashref \$properties" => 247
		},
		GOTOS => {
			'Properties' => 246,
			'Constant' => 248
		}
	},
	{#State 138
		DEFAULT => -55
	},
	{#State 139
		ACTIONS => {
			")" => 249
		}
	},
	{#State 140
		ACTIONS => {
			'MY' => 250
		}
	},
	{#State 141
		DEFAULT => -163
	},
	{#State 142
		DEFAULT => -164
	},
	{#State 143
		DEFAULT => -165
	},
	{#State 144
		ACTIONS => {
			'LPAREN_MY' => 251,
			'MY' => 252
		}
	},
	{#State 145
		ACTIONS => {
			'LPAREN_MY' => 253,
			'LPAREN' => 254
		}
	},
	{#State 146
		DEFAULT => -152
	},
	{#State 147
		DEFAULT => -86
	},
	{#State 148
		ACTIONS => {
			'TYPE_FHREF' => 255
		}
	},
	{#State 149
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 150
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 151
		ACTIONS => {
			'LBRACKET' => 96
		},
		GOTOS => {
			'ArrayReference' => 258
		}
	},
	{#State 152
		DEFAULT => -197
	},
	{#State 153
		DEFAULT => -155
	},
	{#State 154
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'OP10_NAMED_UNARY' => 106,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123
		},
		GOTOS => {
			'SubExpression' => 259,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176
		}
	},
	{#State 155
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123
		},
		GOTOS => {
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'HashReference' => 99,
			'Expression' => 175,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 260
		}
	},
	{#State 156
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LBRACKET' => 96,
			'SELF' => 95,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 261
		}
	},
	{#State 157
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'SubExpression' => 262,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 158
		ACTIONS => {
			'SELF' => 95,
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 92,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'VariableOrLiteral' => 264,
			'Variable' => 263,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 265
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85
		},
		GOTOS => {
			'SubExpression' => 266,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 267,
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115
		}
	},
	{#State 161
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101
		},
		GOTOS => {
			'SubExpression' => 268,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119
		}
	},
	{#State 162
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102
		},
		GOTOS => {
			'SubExpression' => 269,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 270
		}
	},
	{#State 164
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 271,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175
		}
	},
	{#State 165
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101
		},
		GOTOS => {
			'SubExpression' => 272,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176
		}
	},
	{#State 166
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 273
		}
	},
	{#State 167
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 274,
			'Variable' => 176,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'HashReference' => 99,
			'Expression' => 175,
			'HashDereference' => 125,
			'ArrayReference' => 115
		}
	},
	{#State 168
		ACTIONS => {
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 275
		}
	},
	{#State 169
		ACTIONS => {
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'SubExpression' => 276,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85
		},
		GOTOS => {
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 277
		}
	},
	{#State 171
		DEFAULT => -111
	},
	{#State 172
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'MY' => 150,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102
		},
		GOTOS => {
			'HashReference' => 99,
			'Expression' => 175,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'SubExpression' => 182,
			'ListElement' => 178,
			'ListElements' => 278,
			'TypeInner' => 184,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 173
		DEFAULT => -112
	},
	{#State 174
		ACTIONS => {
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'LPAREN' => 107,
			'MY' => 150,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'ListElements' => 279,
			'TypeInner' => 184,
			'SubExpression' => 182,
			'ListElement' => 178,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99
		}
	},
	{#State 175
		DEFAULT => -134
	},
	{#State 176
		ACTIONS => {
			'OP17_LIST_RANGE' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP03_MATH_INC_DEC' => 205,
			'OP21_LIST_COMMA' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP23_LOGICAL_AND' => -137,
			";" => -137,
			"]" => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP08_STRING_CAT' => -137,
			'OP04_MATH_POW' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP18_TERNARY' => -137,
			'OP02_METHOD_THINARROW' => 204,
			")" => -137,
			"}" => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP15_LOGICAL_AND' => -137
		}
	},
	{#State 177
		ACTIONS => {
			"]" => 280
		}
	},
	{#State 178
		DEFAULT => -188,
		GOTOS => {
			'STAR-45' => 281
		}
	},
	{#State 179
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'LPAREN' => 107,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 282,
			'Variable' => 176,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115
		}
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 139
		}
	},
	{#State 181
		DEFAULT => -193
	},
	{#State 182
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			")" => -190,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP21_LIST_COMMA' => -190,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			";" => -190,
			"]" => -190,
			'OP07_MATH_MULT_DIV_MOD' => 161
		}
	},
	{#State 183
		DEFAULT => -194
	},
	{#State 184
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'SubExpression' => 283,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 185
		DEFAULT => -192
	},
	{#State 186
		DEFAULT => -16
	},
	{#State 187
		DEFAULT => -114
	},
	{#State 188
		ACTIONS => {
			")" => 284
		}
	},
	{#State 189
		ACTIONS => {
			"}" => 285
		}
	},
	{#State 190
		DEFAULT => -212
	},
	{#State 191
		ACTIONS => {
			'LBRACE' => 123
		},
		GOTOS => {
			'HashReference' => 286
		}
	},
	{#State 192
		DEFAULT => -148
	},
	{#State 193
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_STRING_CAT' => 164,
			")" => -98,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -98,
			";" => -98,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -98
		}
	},
	{#State 194
		ACTIONS => {
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'ARGV' => 181,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'MY' => 150,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ListElement' => 287,
			'SubExpression' => 238,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184
		}
	},
	{#State 195
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			")" => 288
		}
	},
	{#State 196
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 289
		}
	},
	{#State 197
		ACTIONS => {
			'FHREF_SYMBOL' => 290
		}
	},
	{#State 198
		ACTIONS => {
			'VARIABLE_SYMBOL' => 291
		}
	},
	{#State 199
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP23_LOGICAL_AND' => -176,
			";" => -176,
			"]" => -176,
			'OP02_ARRAY_THINARROW' => 294,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP17_LIST_RANGE' => -176,
			'COLON' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP07_STRING_REPEAT' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP12_COMPARE_EQ_NE' => -176,
			'OP20_HASH_FATARROW' => -176,
			'OP02_METHOD_THINARROW' => -176,
			")" => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP16_LOGICAL_OR' => -176,
			"}" => -176,
			'OP08_STRING_CAT' => -176,
			'OP04_MATH_POW' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP13_BITWISE_AND' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP02_HASH_THINARROW' => 292,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP18_TERNARY' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 293
		}
	},
	{#State 200
		ACTIONS => {
			'OP21_LIST_COMMA' => -108,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			"]" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -108,
			";" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP15_LOGICAL_AND' => 154,
			"}" => -108,
			'OP16_LOGICAL_OR' => 163,
			")" => -108
		}
	},
	{#State 201
		DEFAULT => -78
	},
	{#State 202
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102
		},
		GOTOS => {
			'SubExpression' => 295,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'HashReference' => 99,
			'Expression' => 175,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131
		}
	},
	{#State 203
		ACTIONS => {
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'FHREF_SYMBOL_IN' => 296,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'STDIN' => 297,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 299,
			'SubExpressionOrInput' => 298,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'HashReference' => 99,
			'Expression' => 175
		}
	},
	{#State 204
		ACTIONS => {
			'LPAREN' => 300
		}
	},
	{#State 205
		DEFAULT => -88
	},
	{#State 206
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'SubExpression' => 301,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 207
		DEFAULT => -87
	},
	{#State 208
		ACTIONS => {
			";" => 302
		}
	},
	{#State 209
		ACTIONS => {
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			")" => 303,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP08_STRING_CAT' => 164,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170
		}
	},
	{#State 210
		DEFAULT => -254
	},
	{#State 211
		DEFAULT => -249
	},
	{#State 212
		DEFAULT => -253
	},
	{#State 213
		DEFAULT => -250
	},
	{#State 214
		DEFAULT => -209,
		GOTOS => {
			'STAR-50' => 304
		}
	},
	{#State 215
		DEFAULT => -242
	},
	{#State 216
		DEFAULT => -229
	},
	{#State 217
		DEFAULT => -247
	},
	{#State 218
		DEFAULT => -211
	},
	{#State 219
		DEFAULT => -256
	},
	{#State 220
		DEFAULT => -246
	},
	{#State 221
		DEFAULT => -251
	},
	{#State 222
		DEFAULT => -228
	},
	{#State 223
		DEFAULT => -255
	},
	{#State 224
		DEFAULT => -248
	},
	{#State 225
		DEFAULT => -257
	},
	{#State 226
		DEFAULT => -243
	},
	{#State 227
		DEFAULT => -205
	},
	{#State 228
		DEFAULT => -245
	},
	{#State 229
		DEFAULT => -252
	},
	{#State 230
		DEFAULT => -204
	},
	{#State 231
		DEFAULT => -241
	},
	{#State 232
		DEFAULT => -244
	},
	{#State 233
		ACTIONS => {
			'OP20_HASH_FATARROW' => 305
		}
	},
	{#State 234
		DEFAULT => -230
	},
	{#State 235
		DEFAULT => -218
	},
	{#State 236
		ACTIONS => {
			";" => 306
		}
	},
	{#State 237
		ACTIONS => {
			'OP21_LIST_COMMA' => 307
		}
	},
	{#State 238
		ACTIONS => {
			'OP17_LIST_RANGE' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP21_LIST_COMMA' => -190,
			";" => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP04_MATH_POW' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_STRING_CAT' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP18_TERNARY' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			")" => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => -83
		}
	},
	{#State 239
		ACTIONS => {
			'OP06_REGEX_MATCH' => -90,
			'OP23_LOGICAL_AND' => -90,
			";" => -90,
			"]" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			")" => -90,
			'OP16_LOGICAL_OR' => -90,
			"}" => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP18_TERNARY' => -90
		}
	},
	{#State 240
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 95,
			'LBRACKET' => 96,
			")" => -125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'ARGV' => 181,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'LPAREN' => 107,
			'MY' => 150,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'TypeInner' => 184,
			'ListElements' => 309,
			'SubExpression' => 182,
			'ListElement' => 178,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'OPTIONAL-34' => 308,
			'Expression' => 175
		}
	},
	{#State 241
		ACTIONS => {
			")" => 310
		}
	},
	{#State 242
		ACTIONS => {
			'WORD_UPPERCASE' => 311
		}
	},
	{#State 243
		DEFAULT => -43
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 312
		}
	},
	{#State 245
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 81,
			"while" => -150,
			"undef" => 82,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 94,
			"}" => 313,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 108,
			'OP10_NAMED_UNARY' => 106,
			"for" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP01_NAMED_VOID' => 120,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"foreach" => -150,
			"if" => 114,
			'OP01_NAMED_SCOLON' => 112,
			'LBRACE' => 123,
			'OP19_LOOP_CONTROL_SCOLON' => 122,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 127,
			'OP19_LOOP_CONTROL' => 126
		},
		GOTOS => {
			'SubExpression' => 93,
			'HashDereference' => 125,
			'PAREN-36' => 100,
			'HashReference' => 99,
			'WordScoped' => 131,
			'Operator' => 130,
			'Operation' => 314,
			'LoopLabel' => 105,
			'VariableSymbolOrSelf' => 110,
			'OperatorVoid' => 109,
			'Literal' => 84,
			'OPTIONAL-37' => 83,
			'ArrayReference' => 115,
			'Conditional' => 88,
			'Expression' => 113,
			'VariableModification' => 90,
			'VariableDeclaration' => 118,
			'ArrayDereference' => 119,
			'Statement' => 89,
			'Variable' => 116
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
			'OP19_VARIABLE_ASSIGN' => 316
		}
	},
	{#State 248
		DEFAULT => -57
	},
	{#State 249
		DEFAULT => -129
	},
	{#State 250
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 61,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 317
		}
	},
	{#State 251
		ACTIONS => {
			'TYPE_INTEGER' => 318
		}
	},
	{#State 252
		ACTIONS => {
			'TYPE_INTEGER' => 319
		}
	},
	{#State 253
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 61,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 320
		}
	},
	{#State 254
		ACTIONS => {
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'SubExpression' => 321,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176
		}
	},
	{#State 255
		ACTIONS => {
			'FHREF_SYMBOL' => 322
		}
	},
	{#State 256
		DEFAULT => -199
	},
	{#State 257
		ACTIONS => {
			"\$TYPED_" => 323
		}
	},
	{#State 258
		ACTIONS => {
			"}" => 324
		}
	},
	{#State 259
		ACTIONS => {
			";" => -104,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -104,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => -104,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP21_LIST_COMMA' => -104,
			"}" => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP15_LOGICAL_AND' => -104,
			")" => -104,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP08_STRING_CAT' => 164,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => 159,
			'OP24_LOGICAL_OR_XOR' => -104
		}
	},
	{#State 260
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => -102,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -102,
			")" => -102,
			'OP16_LOGICAL_OR' => -102,
			"}" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -102,
			";" => -102,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 161
		}
	},
	{#State 261
		ACTIONS => {
			'OP21_LIST_COMMA' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			"]" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP06_REGEX_MATCH' => -89,
			";" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			'OP08_STRING_CAT' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP04_MATH_POW' => 156,
			")" => -89,
			'OP16_LOGICAL_OR' => -89,
			"}" => -89,
			'OP15_LOGICAL_AND' => -89
		}
	},
	{#State 262
		ACTIONS => {
			")" => -100,
			'OP16_LOGICAL_OR' => -100,
			"}" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -100,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 156,
			"]" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -100,
			";" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => -100,
			'OP14_BITWISE_OR_XOR' => -100
		}
	},
	{#State 263
		DEFAULT => -226
	},
	{#State 264
		ACTIONS => {
			'COLON' => 325
		}
	},
	{#State 265
		DEFAULT => -227
	},
	{#State 266
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP07_STRING_REPEAT' => 170,
			'OP21_LIST_COMMA' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -97,
			";" => -97,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => -97,
			"}" => -97,
			'OP15_LOGICAL_AND' => -97,
			")" => -97
		}
	},
	{#State 267
		ACTIONS => {
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP21_LIST_COMMA' => -109,
			";" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -109,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP08_STRING_CAT' => 164,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP24_LOGICAL_OR_XOR' => -109,
			")" => -109,
			'OP15_LOGICAL_AND' => 154,
			"}" => -109,
			'OP16_LOGICAL_OR' => 163
		}
	},
	{#State 268
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -94,
			"]" => -94,
			";" => -94,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			")" => -94,
			"}" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP18_TERNARY' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_STRING_CAT' => -94
		}
	},
	{#State 269
		ACTIONS => {
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 166,
			";" => -95,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP07_STRING_REPEAT' => 170,
			'OP15_LOGICAL_AND' => -95,
			"}" => -95,
			'OP16_LOGICAL_OR' => -95,
			")" => -95,
			'OP08_STRING_CAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95
		}
	},
	{#State 270
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => 159,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			"}" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP15_LOGICAL_AND' => 154,
			")" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => -105,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => 166,
			";" => -105
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -96,
			";" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP08_STRING_CAT' => -96,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			"}" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			")" => -96
		}
	},
	{#State 272
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP21_LIST_COMMA' => -110,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -110,
			";" => -110,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP08_STRING_CAT' => 164,
			"}" => -110,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			")" => -110
		}
	},
	{#State 273
		DEFAULT => -92
	},
	{#State 274
		ACTIONS => {
			"]" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 166,
			";" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP17_LIST_RANGE' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			")" => -103,
			'OP16_LOGICAL_OR' => -103,
			"}" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -103,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157
		}
	},
	{#State 275
		ACTIONS => {
			'OP21_LIST_COMMA' => -106,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 167,
			"]" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 166,
			";" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			")" => -106,
			'OP15_LOGICAL_AND' => 154,
			"}" => -106,
			'OP16_LOGICAL_OR' => 163
		}
	},
	{#State 276
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => -101,
			";" => -101,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP16_LOGICAL_OR' => -101,
			"}" => -101,
			'OP15_LOGICAL_AND' => -101,
			")" => -101,
			'OP18_TERNARY' => -101,
			'OP09_BITWISE_SHIFT' => 159,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 277
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -93,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => -93,
			'OP08_STRING_CAT' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP18_TERNARY' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			")" => -93,
			"}" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP21_LIST_COMMA' => -93,
			";" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			"]" => -93
		}
	},
	{#State 278
		ACTIONS => {
			";" => 326
		}
	},
	{#State 279
		ACTIONS => {
			";" => 327
		}
	},
	{#State 280
		DEFAULT => -196
	},
	{#State 281
		ACTIONS => {
			";" => -189,
			"]" => -189,
			'OP21_LIST_COMMA' => 329,
			")" => -189
		},
		GOTOS => {
			'PAREN-44' => 328
		}
	},
	{#State 282
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			"]" => -83,
			";" => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP18_TERNARY' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP04_MATH_POW' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP08_STRING_CAT' => -83,
			'OP16_LOGICAL_OR' => -83,
			"}" => -83,
			'OP15_LOGICAL_AND' => -83,
			")" => -83
		}
	},
	{#State 283
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			")" => -191,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP21_LIST_COMMA' => -191,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			"]" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			";" => -191
		}
	},
	{#State 284
		ACTIONS => {
			";" => 330
		}
	},
	{#State 285
		DEFAULT => -214
	},
	{#State 286
		ACTIONS => {
			"}" => 331
		}
	},
	{#State 287
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 288
		DEFAULT => -142
	},
	{#State 289
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'LPAREN' => 107,
			'MY' => 150,
			"undef" => 82,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102
		},
		GOTOS => {
			'HashReference' => 99,
			'Expression' => 175,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'SubExpression' => 182,
			'ListElement' => 178,
			'TypeInner' => 184,
			'ListElements' => 333,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 290
		ACTIONS => {
			";" => 334
		}
	},
	{#State 291
		ACTIONS => {
			";" => 336,
			'OP19_VARIABLE_ASSIGN' => 335,
			'OP02_ARRAY_THINARROW' => 337
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'WORD' => 338,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'LPAREN' => 107,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87
		},
		GOTOS => {
			'SubExpression' => 339,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'Expression' => 175,
			'HashReference' => 99,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119
		}
	},
	{#State 293
		DEFAULT => -174
	},
	{#State 294
		ACTIONS => {
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			'WORD' => 29,
			"undef" => 82,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 340
		}
	},
	{#State 295
		ACTIONS => {
			")" => 341,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167
		}
	},
	{#State 296
		DEFAULT => -144
	},
	{#State 297
		DEFAULT => -145
	},
	{#State 298
		DEFAULT => -184
	},
	{#State 299
		ACTIONS => {
			")" => -143,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			";" => -143,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167
		}
	},
	{#State 300
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			")" => -127,
			'LBRACKET' => 96,
			'SELF' => 95,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_QW' => 185,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 150,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'SubExpression' => 182,
			'ListElement' => 178,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184,
			'OPTIONAL-35' => 342,
			'ListElements' => 343,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176
		}
	},
	{#State 301
		ACTIONS => {
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			")" => -185,
			'OP08_STRING_CAT' => 164,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			";" => -185,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170
		}
	},
	{#State 302
		DEFAULT => -120
	},
	{#State 303
		DEFAULT => -91
	},
	{#State 304
		ACTIONS => {
			"}" => 346,
			'OP21_LIST_COMMA' => 344
		},
		GOTOS => {
			'PAREN-49' => 345
		}
	},
	{#State 305
		ACTIONS => {
			'SELF' => -202,
			'LBRACKET' => -202,
			'LBRACE' => -202,
			'LITERAL_NUMBER' => -202,
			'OP05_LOGICAL_NEG' => -202,
			"%{" => -202,
			'LITERAL_STRING' => -202,
			'VARIABLE_SYMBOL' => -202,
			'OP01_NAMED' => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'OP22_LOGICAL_NEG' => -202,
			'WORD_SCOPED' => -202,
			'LPAREN' => -202,
			'MY' => 150,
			'WORD_UPPERCASE' => -202,
			"undef" => -202,
			'WORD' => -202,
			'OP10_NAMED_UNARY' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'OP03_MATH_INC_DEC' => -202,
			"\@{" => -202,
			'OP01_CLOSE' => -202,
			'OP01_OPEN' => -202
		},
		GOTOS => {
			'OPTIONAL-48' => 348,
			'TypeInner' => 347
		}
	},
	{#State 306
		DEFAULT => -123
	},
	{#State 307
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'MY' => 150,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 106,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_QW' => 185,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123
		},
		GOTOS => {
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184,
			'ListElements' => 349,
			'ListElement' => 178,
			'SubExpression' => 182
		}
	},
	{#State 308
		ACTIONS => {
			")" => 350
		}
	},
	{#State 309
		DEFAULT => -124
	},
	{#State 310
		DEFAULT => -133
	},
	{#State 311
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 351
		}
	},
	{#State 312
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 352
		}
	},
	{#State 313
		ACTIONS => {
			";" => 353
		}
	},
	{#State 314
		DEFAULT => -46
	},
	{#State 315
		ACTIONS => {
			"our" => 357,
			'LITERAL_NUMBER' => 354
		},
		GOTOS => {
			'MethodOrSubroutine' => 356,
			'Method' => 358,
			'Subroutine' => 355
		}
	},
	{#State 316
		ACTIONS => {
			'LBRACE' => 359
		}
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 360
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 361
		}
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 362
		}
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 363
		}
	},
	{#State 321
		ACTIONS => {
			")" => 364,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167
		}
	},
	{#State 322
		ACTIONS => {
			'OP21_LIST_COMMA' => 365
		}
	},
	{#State 323
		ACTIONS => {
			'OP01_CLOSE' => 212,
			'OP07_STRING_REPEAT' => 221,
			'OP08_MATH_ADD_SUB' => 211,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP01_OPEN' => 210,
			'OP01_NAMED_VOID' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP10_NAMED_UNARY' => 224,
			'WORD' => 225,
			'OP23_LOGICAL_AND' => 215,
			'OP22_LOGICAL_NEG' => 226,
			'OP24_LOGICAL_OR_XOR' => 231,
			'OP01_NAMED' => 229,
			'OP19_LOOP_CONTROL' => 228,
			'OP11_COMPARE_LT_GT' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			'OP01_PRINT' => 219
		},
		GOTOS => {
			'OpStringOrWord' => 366
		}
	},
	{#State 324
		DEFAULT => -200
	},
	{#State 325
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'SELF' => 95,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'VariableOrLiteral' => 367,
			'Variable' => 263,
			'Literal' => 265,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 326
		DEFAULT => -117
	},
	{#State 327
		DEFAULT => -116
	},
	{#State 328
		DEFAULT => -187
	},
	{#State 329
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'OP01_QW' => 185,
			'CONSTANT_CALL_SCOPED' => 101,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'ARGV' => 181,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'MY' => 150,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'TypeInner' => 184,
			'SubExpression' => 182,
			'ListElement' => 368,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175
		}
	},
	{#State 330
		DEFAULT => -119
	},
	{#State 331
		DEFAULT => -215
	},
	{#State 332
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'LPAREN' => 107,
			'MY' => 150,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'ARGV' => 181,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LBRACKET' => 96,
			'SELF' => 95,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_QW' => 185,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'TypeInner' => 184,
			'ListElements' => 369,
			'ListElement' => 178,
			'SubExpression' => 182,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Variable' => 176,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99
		}
	},
	{#State 333
		ACTIONS => {
			")" => 370
		}
	},
	{#State 334
		DEFAULT => -183
	},
	{#State 335
		ACTIONS => {
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'FHREF_SYMBOL_IN' => 296,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 374,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_CLOSE' => 85,
			'STDIN' => 297,
			'OP01_NAMED_SCOLON' => 373,
			'OP01_OPEN' => 86,
			"\@{" => 87
		},
		GOTOS => {
			'SubExpression' => 299,
			'SubExpressionOrInput' => 372,
			'Literal' => 84,
			'OpNamedScolonOrSubExpIn' => 371,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176
		}
	},
	{#State 336
		DEFAULT => -180
	},
	{#State 337
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'LPAREN' => 107,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LBRACKET' => 96,
			'SELF' => 95,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176,
			'SubExpression' => 375,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 338
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -216,
			"}" => 376,
			'LPAREN' => -216
		}
	},
	{#State 339
		ACTIONS => {
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP16_LOGICAL_OR' => 163,
			"}" => 377,
			'OP15_LOGICAL_AND' => 154
		}
	},
	{#State 340
		ACTIONS => {
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			"]" => 378,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159
		}
	},
	{#State 341
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 342
		ACTIONS => {
			")" => 381
		}
	},
	{#State 343
		DEFAULT => -126
	},
	{#State 344
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			'SELF' => 95,
			'OP24_LOGICAL_OR_XOR' => 231,
			'OP19_LOOP_CONTROL' => 228,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 229,
			'ENV' => 227,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP11_COMPARE_LT_GT' => 217,
			'OP10_NAMED_UNARY' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP23_LOGICAL_AND' => 215,
			'OP22_LOGICAL_NEG' => 226,
			'WORD' => 225,
			'OP07_STRING_REPEAT' => 221,
			'OP01_CLOSE' => 212,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP01_OPEN' => 210,
			'OP08_MATH_ADD_SUB' => 211,
			'OP01_NAMED_VOID' => 223
		},
		GOTOS => {
			'HashDereference' => 230,
			'Variable' => 222,
			'VarOrLitOrOpStrOrWord' => 233,
			'HashEntry' => 382,
			'Literal' => 216,
			'VariableSymbolOrSelf' => 110,
			'OpStringOrWord' => 234
		}
	},
	{#State 345
		DEFAULT => -208
	},
	{#State 346
		DEFAULT => -210
	},
	{#State 347
		DEFAULT => -201
	},
	{#State 348
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'LPAREN' => 107,
			'WORD' => 29,
			"undef" => 82,
			'WORD_UPPERCASE' => 180,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'SubExpression' => 383,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84
		}
	},
	{#State 349
		ACTIONS => {
			";" => 384
		}
	},
	{#State 350
		DEFAULT => -131
	},
	{#State 351
		DEFAULT => -225
	},
	{#State 352
		ACTIONS => {
			")" => 387,
			'OP21_LIST_COMMA' => 385
		},
		GOTOS => {
			'PAREN-19' => 386
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		ACTIONS => {
			";" => 388
		}
	},
	{#State 355
		DEFAULT => -77
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		ACTIONS => {
			'TYPE_METHOD' => 389,
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 62
		}
	},
	{#State 358
		DEFAULT => -76
	},
	{#State 359
		ACTIONS => {
			'OP01_OPEN' => 210,
			'OP08_MATH_ADD_SUB' => 211,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP07_STRING_REPEAT' => 221,
			'OP01_CLOSE' => 212,
			'OP01_NAMED_VOID' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP10_NAMED_UNARY' => 224,
			'WORD' => 225,
			'OP22_LOGICAL_NEG' => 226,
			'OP23_LOGICAL_AND' => 215,
			'OP01_NAMED' => 229,
			'OP19_LOOP_CONTROL' => 228,
			'OP24_LOGICAL_OR_XOR' => 231,
			'OP11_COMPARE_LT_GT' => 217,
			"}" => 392,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			'OP01_PRINT' => 219
		},
		GOTOS => {
			'OpStringOrWord' => 390,
			'HashEntryProperties' => 391
		}
	},
	{#State 360
		ACTIONS => {
			'LPAREN' => 393
		}
	},
	{#State 361
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 394
		}
	},
	{#State 362
		ACTIONS => {
			'LPAREN' => 395
		}
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 364
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 365
		ACTIONS => {
			'LITERAL_STRING' => 398
		}
	},
	{#State 366
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 399
		}
	},
	{#State 367
		DEFAULT => -107
	},
	{#State 368
		DEFAULT => -186
	},
	{#State 369
		ACTIONS => {
			")" => 400
		}
	},
	{#State 370
		DEFAULT => -82
	},
	{#State 371
		DEFAULT => -181
	},
	{#State 372
		ACTIONS => {
			";" => 401
		}
	},
	{#State 373
		DEFAULT => -238
	},
	{#State 374
		DEFAULT => -239
	},
	{#State 375
		ACTIONS => {
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP08_STRING_CAT' => 164,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			"]" => 402,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162
		}
	},
	{#State 376
		DEFAULT => -179
	},
	{#State 377
		DEFAULT => -178
	},
	{#State 378
		DEFAULT => -177
	},
	{#State 379
		DEFAULT => -158,
		GOTOS => {
			'STAR-39' => 403
		}
	},
	{#State 380
		ACTIONS => {
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'WORD_SCOPED' => 30,
			"while" => -150,
			'WORD_UPPERCASE' => 81,
			"undef" => 82,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 94,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_NAMED_VOID' => 120,
			'OP03_MATH_INC_DEC' => 117,
			"foreach" => -150,
			"if" => 114,
			'OP01_NAMED_SCOLON' => 112,
			'OP22_LOGICAL_NEG' => 111,
			'MY' => 108,
			'LPAREN' => 107,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 106,
			"for" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'LBRACE' => 123,
			'OP19_LOOP_CONTROL_SCOLON' => 122
		},
		GOTOS => {
			'VariableModification' => 90,
			'ArrayDereference' => 119,
			'VariableDeclaration' => 118,
			'Statement' => 89,
			'Variable' => 116,
			'ArrayReference' => 115,
			'Conditional' => 88,
			'Expression' => 113,
			'VariableSymbolOrSelf' => 110,
			'OperatorVoid' => 109,
			'OPTIONAL-37' => 83,
			'Literal' => 84,
			'Operation' => 404,
			'LoopLabel' => 105,
			'WordScoped' => 131,
			'Operator' => 130,
			'HashDereference' => 125,
			'PAREN-36' => 100,
			'HashReference' => 99,
			'PLUS-42' => 405,
			'SubExpression' => 93
		}
	},
	{#State 381
		DEFAULT => -132
	},
	{#State 382
		DEFAULT => -207
	},
	{#State 383
		ACTIONS => {
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP21_LIST_COMMA' => -203,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			"}" => -203,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154
		}
	},
	{#State 384
		DEFAULT => -121
	},
	{#State 385
		ACTIONS => {
			'MY' => 406
		}
	},
	{#State 386
		DEFAULT => -50
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 388
		DEFAULT => -61
	},
	{#State 389
		ACTIONS => {
			'VARIABLE_SYMBOL' => 408
		}
	},
	{#State 390
		ACTIONS => {
			'OP20_HASH_FATARROW' => 409
		}
	},
	{#State 391
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 410
		}
	},
	{#State 392
		ACTIONS => {
			";" => 411
		}
	},
	{#State 393
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 150,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_QW' => 185
		},
		GOTOS => {
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'HashReference' => 99,
			'Expression' => 175,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'TypeInner' => 184,
			'ListElements' => 412,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 182,
			'ListElement' => 178
		}
	},
	{#State 394
		ACTIONS => {
			'OP01_OPEN' => 86,
			'OP01_NAMED_SCOLON' => 415,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 413,
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'LPAREN' => 107,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LBRACKET' => 96,
			'SELF' => 95
		},
		GOTOS => {
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'OpNamedScolonOrSubExp' => 414,
			'SubExpression' => 416
		}
	},
	{#State 395
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102
		},
		GOTOS => {
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 417,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'WordScoped' => 131,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175
		}
	},
	{#State 396
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'LPAREN' => 107,
			'FHREF_SYMBOL_IN' => 296,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 86,
			'STDIN' => 297,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LBRACKET' => 96,
			'SELF' => 95,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'HashReference' => 99,
			'Expression' => 175,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'Variable' => 176,
			'SubExpression' => 299,
			'SubExpressionOrInput' => 418,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 397
		DEFAULT => -169
	},
	{#State 398
		ACTIONS => {
			'OP21_LIST_COMMA' => 419
		}
	},
	{#State 399
		DEFAULT => -222
	},
	{#State 400
		DEFAULT => -84
	},
	{#State 401
		DEFAULT => -240
	},
	{#State 402
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 403
		ACTIONS => {
			'MY' => -161,
			'LPAREN' => -161,
			'WORD' => -161,
			'OP22_LOGICAL_NEG' => -161,
			'OP10_NAMED_UNARY_SCOLON' => -161,
			"for" => -161,
			'OP10_NAMED_UNARY' => -161,
			'OP03_MATH_INC_DEC' => -161,
			'OP05_MATH_NEG_LPAREN' => -161,
			'OP01_NAMED_VOID' => -161,
			'OP01_NAMED_SCOLON' => -161,
			"if" => -161,
			"foreach" => -161,
			'OP19_LOOP_CONTROL_SCOLON' => -161,
			'LBRACE' => -161,
			'OP01_NAMED_VOID_SCOLON' => -161,
			'OP05_LOGICAL_NEG' => -161,
			"else" => 422,
			'OP19_LOOP_CONTROL' => -161,
			'VARIABLE_SYMBOL' => -161,
			'OP01_NAMED' => -161,
			"while" => -161,
			"undef" => -161,
			'WORD_UPPERCASE' => -161,
			'WORD_SCOPED' => -161,
			'' => -161,
			"elsif" => 425,
			'OP01_CLOSE' => -161,
			'OP01_OPEN' => -161,
			"\@{" => -161,
			'SELF' => -161,
			'LBRACKET' => -161,
			'OP01_NAMED_VOID_LPAREN' => -161,
			"}" => -161,
			'LITERAL_NUMBER' => -161,
			'OP01_PRINT' => -161,
			'LITERAL_STRING' => -161,
			"%{" => -161,
			'CONSTANT_CALL_SCOPED' => -161
		},
		GOTOS => {
			'OPTIONAL-41' => 424,
			'PAREN-38' => 421,
			'PAREN-40' => 423
		}
	},
	{#State 404
		DEFAULT => -172
	},
	{#State 405
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 81,
			"while" => -150,
			"undef" => 82,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_PRINT' => 94,
			"}" => 426,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 29,
			'LPAREN' => 107,
			'MY' => 108,
			'OP10_NAMED_UNARY' => 106,
			"for" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_NAMED_VOID' => 120,
			'OP03_MATH_INC_DEC' => 117,
			"if" => 114,
			"foreach" => -150,
			'OP01_NAMED_SCOLON' => 112,
			'LBRACE' => 123,
			'OP19_LOOP_CONTROL_SCOLON' => 122,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'VARIABLE_SYMBOL' => 124,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'Expression' => 113,
			'Conditional' => 88,
			'ArrayReference' => 115,
			'Variable' => 116,
			'VariableModification' => 90,
			'VariableDeclaration' => 118,
			'ArrayDereference' => 119,
			'Statement' => 89,
			'Operation' => 427,
			'LoopLabel' => 105,
			'VariableSymbolOrSelf' => 110,
			'OperatorVoid' => 109,
			'Literal' => 84,
			'OPTIONAL-37' => 83,
			'PAREN-36' => 100,
			'HashReference' => 99,
			'HashDereference' => 125,
			'WordScoped' => 131,
			'Operator' => 130,
			'SubExpression' => 93
		}
	},
	{#State 406
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD' => 61,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 428
		}
	},
	{#State 407
		ACTIONS => {
			"\@_;" => 429
		}
	},
	{#State 408
		ACTIONS => {
			"= sub {" => 430
		}
	},
	{#State 409
		ACTIONS => {
			'MY' => 432
		},
		GOTOS => {
			'TypeInnerProperties' => 431
		}
	},
	{#State 410
		ACTIONS => {
			'OP21_LIST_COMMA' => 434,
			"}" => 433
		},
		GOTOS => {
			'PAREN-25' => 435
		}
	},
	{#State 411
		DEFAULT => -66
	},
	{#State 412
		ACTIONS => {
			")" => 436
		}
	},
	{#State 413
		DEFAULT => -236
	},
	{#State 414
		ACTIONS => {
			'VARIABLE_SYMBOL' => 437
		}
	},
	{#State 415
		DEFAULT => -235
	},
	{#State 416
		ACTIONS => {
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			";" => 438,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158
		}
	},
	{#State 417
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP17_LIST_RANGE' => 439,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155
		}
	},
	{#State 418
		ACTIONS => {
			")" => 440
		}
	},
	{#State 419
		ACTIONS => {
			'LBRACKET' => 96,
			'SELF' => 95,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 106,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 441,
			'Variable' => 176,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125
		}
	},
	{#State 420
		ACTIONS => {
			"undef" => 442
		}
	},
	{#State 421
		DEFAULT => -157
	},
	{#State 422
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 423
		DEFAULT => -160
	},
	{#State 424
		DEFAULT => -162
	},
	{#State 425
		ACTIONS => {
			'LPAREN' => 444
		}
	},
	{#State 426
		DEFAULT => -173
	},
	{#State 427
		DEFAULT => -171
	},
	{#State 428
		ACTIONS => {
			'VARIABLE_SYMBOL' => 445
		}
	},
	{#State 429
		DEFAULT => -52
	},
	{#State 430
		ACTIONS => {
			"if" => -68,
			"foreach" => -68,
			'OP01_NAMED_SCOLON' => -68,
			'OP01_NAMED_VOID' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'OP10_NAMED_UNARY' => -68,
			"for" => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'WORD' => -68,
			'LPAREN' => -68,
			'MY' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'LBRACE' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'LPAREN_MY' => 448,
			"\@{" => -68,
			'OP01_OPEN' => -68,
			'OP01_CLOSE' => -68,
			'WORD_SCOPED' => -68,
			"while" => -68,
			"undef" => -68,
			'WORD_UPPERCASE' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'LITERAL_STRING' => -68,
			"%{" => -68,
			'LITERAL_NUMBER' => -68,
			'OP01_PRINT' => -68,
			"}" => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'LBRACKET' => -68,
			'SELF' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 447,
			'MethodArguments' => 446
		}
	},
	{#State 431
		DEFAULT => -206
	},
	{#State 432
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 449
		}
	},
	{#State 433
		ACTIONS => {
			";" => 450
		}
	},
	{#State 434
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 213,
			'OP10_NAMED_UNARY' => 224,
			'WORD' => 225,
			'OP22_LOGICAL_NEG' => 226,
			'OP23_LOGICAL_AND' => 215,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 211,
			'OP01_OPEN' => 210,
			'OP01_CLOSE' => 212,
			'OP07_STRING_REPEAT' => 221,
			'OP01_NAMED_VOID' => 223,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			'OP01_PRINT' => 219,
			'OP19_LOOP_CONTROL' => 228,
			'OP01_NAMED' => 229,
			'OP24_LOGICAL_OR_XOR' => 231,
			'OP11_COMPARE_LT_GT' => 217
		},
		GOTOS => {
			'HashEntryProperties' => 451,
			'OpStringOrWord' => 390
		}
	},
	{#State 435
		DEFAULT => -63
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 452
		}
	},
	{#State 437
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 453
		}
	},
	{#State 438
		DEFAULT => -237
	},
	{#State 439
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'OP10_NAMED_UNARY' => 106,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'SELF' => 95,
			'LBRACKET' => 96,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101
		},
		GOTOS => {
			'SubExpression' => 454,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 441
		ACTIONS => {
			'OP16_LOGICAL_OR' => 163,
			"}" => -85,
			'OP15_LOGICAL_AND' => 154,
			")" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP08_STRING_CAT' => 164,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			"]" => -85,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP07_STRING_REPEAT' => 170,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168
		}
	},
	{#State 442
		ACTIONS => {
			";" => 456
		}
	},
	{#State 443
		DEFAULT => -159
	},
	{#State 444
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'LBRACKET' => 96,
			'SELF' => 95,
			'CONSTANT_CALL_SCOPED' => 101,
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 457,
			'WordScoped' => 131,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Variable' => 176,
			'HashDereference' => 125,
			'ArrayReference' => 115,
			'Expression' => 175,
			'HashReference' => 99
		}
	},
	{#State 445
		DEFAULT => -49
	},
	{#State 446
		DEFAULT => -67
	},
	{#State 447
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 458
		}
	},
	{#State 448
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 459
		}
	},
	{#State 449
		ACTIONS => {
			"\$TYPED_" => 460
		}
	},
	{#State 450
		DEFAULT => -65
	},
	{#State 451
		DEFAULT => -62
	},
	{#State 452
		DEFAULT => -168
	},
	{#State 453
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 413,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_NAMED_SCOLON' => 415,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Variable' => 176,
			'SubExpression' => 416,
			'OpNamedScolonOrSubExp' => 461,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84
		}
	},
	{#State 454
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP04_MATH_POW' => 156,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => -106,
			")" => 462,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163
		}
	},
	{#State 455
		DEFAULT => -170
	},
	{#State 456
		DEFAULT => -182
	},
	{#State 457
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			")" => 463,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157
		}
	},
	{#State 458
		ACTIONS => {
			'WORD_SCOPED' => 30,
			"undef" => 82,
			"while" => -150,
			'WORD_UPPERCASE' => 81,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP01_NAMED_VOID_LPAREN' => 98,
			'LBRACKET' => 96,
			'SELF' => 95,
			'OP01_PRINT' => 94,
			'LITERAL_NUMBER' => 92,
			"}" => 465,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 29,
			'MY' => 108,
			'LPAREN' => 107,
			'OP10_NAMED_UNARY' => 106,
			"for" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP01_NAMED_VOID' => 120,
			'OP03_MATH_INC_DEC' => 117,
			"if" => 114,
			"foreach" => -150,
			'OP01_NAMED_SCOLON' => 112,
			'LBRACE' => 123,
			'OP19_LOOP_CONTROL_SCOLON' => 122,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED' => 127,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'HashDereference' => 125,
			'PAREN-36' => 100,
			'HashReference' => 99,
			'WordScoped' => 131,
			'Operator' => 130,
			'SubExpression' => 93,
			'Conditional' => 88,
			'ArrayReference' => 115,
			'Expression' => 113,
			'VariableModification' => 90,
			'ArrayDereference' => 119,
			'VariableDeclaration' => 118,
			'Statement' => 89,
			'Variable' => 116,
			'Operation' => 464,
			'LoopLabel' => 105,
			'OperatorVoid' => 109,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'OPTIONAL-37' => 83
		}
	},
	{#State 459
		ACTIONS => {
			'SELF' => 466
		}
	},
	{#State 460
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 217,
			'OP01_NAMED' => 229,
			'OP19_LOOP_CONTROL' => 228,
			'OP24_LOGICAL_OR_XOR' => 231,
			'OP01_PRINT' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 232,
			'OP01_NAMED_VOID' => 223,
			'OP01_OPEN' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 211,
			'OP07_STRING_REPEAT' => 221,
			'OP01_CLOSE' => 212,
			'OP23_LOGICAL_AND' => 215,
			'OP22_LOGICAL_NEG' => 226,
			'WORD' => 225,
			'OP10_NAMED_UNARY' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 213
		},
		GOTOS => {
			'OpStringOrWord' => 467
		}
	},
	{#State 461
		ACTIONS => {
			"\@{" => 87,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'LPAREN' => 107,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP05_LOGICAL_NEG' => 129,
			"%{" => 102,
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpressionOrVarMod' => 468,
			'SubExpression' => 469,
			'Variable' => 116,
			'WordScoped' => 131,
			'VariableModification' => 470,
			'ArrayDereference' => 119,
			'Operator' => 130,
			'Expression' => 175,
			'HashReference' => 99,
			'ArrayReference' => 115,
			'HashDereference' => 125
		}
	},
	{#State 462
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 471
		}
	},
	{#State 463
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 464
		DEFAULT => -69
	},
	{#State 465
		ACTIONS => {
			";" => 473
		}
	},
	{#State 466
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 474
		}
	},
	{#State 467
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 476,
			'OP19_VARIABLE_ASSIGN' => 475
		}
	},
	{#State 468
		ACTIONS => {
			")" => 477
		}
	},
	{#State 469
		ACTIONS => {
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP12_COMPARE_EQ_NE' => 169,
			")" => -146,
			'OP16_LOGICAL_OR' => 163,
			'OP15_LOGICAL_AND' => 154,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158
		}
	},
	{#State 470
		DEFAULT => -147
	},
	{#State 471
		DEFAULT => -166
	},
	{#State 472
		DEFAULT => -156
	},
	{#State 473
		DEFAULT => -71
	},
	{#State 474
		ACTIONS => {
			")" => 479,
			'OP21_LIST_COMMA' => 478
		},
		GOTOS => {
			'PAREN-29' => 480
		}
	},
	{#State 475
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 123,
			'SELF' => 95,
			'LBRACKET' => 96,
			'CONSTANT_CALL_SCOPED' => 101,
			'OP01_NAMED' => 179,
			'VARIABLE_SYMBOL' => 124,
			'OP05_LOGICAL_NEG' => 129,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 106,
			'LPAREN' => 107,
			'WORD' => 29,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 85,
			'OP01_OPEN' => 86,
			"\@{" => 87,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 121
		},
		GOTOS => {
			'WordScoped' => 131,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'Variable' => 176,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Expression' => 175,
			'HashReference' => 99,
			'VariableSymbolOrSelf' => 110,
			'Literal' => 84,
			'SubExpression' => 481
		}
	},
	{#State 476
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'OP01_NAMED' => 179,
			'CONSTANT_CALL_SCOPED' => 101,
			'LITERAL_STRING' => 103,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACE' => 123,
			'LITERAL_NUMBER' => 92,
			'LBRACKET' => 96,
			'SELF' => 95,
			"\@{" => 87,
			'OP01_OPEN' => 86,
			'OP01_CLOSE' => 85,
			'OP05_MATH_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 180,
			"undef" => 82,
			'WORD' => 29,
			'LPAREN' => 107
		},
		GOTOS => {
			'Variable' => 176,
			'Operator' => 130,
			'ArrayDereference' => 119,
			'WordScoped' => 131,
			'HashReference' => 99,
			'Expression' => 175,
			'ArrayReference' => 115,
			'HashDereference' => 125,
			'Literal' => 84,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 482
		}
	},
	{#State 477
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 483
		}
	},
	{#State 478
		ACTIONS => {
			'MY' => 484
		}
	},
	{#State 479
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 485
		}
	},
	{#State 480
		DEFAULT => -73
	},
	{#State 481
		ACTIONS => {
			'OP16_LOGICAL_OR' => 163,
			"}" => -223,
			'OP15_LOGICAL_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP18_TERNARY' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP21_LIST_COMMA' => -223,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP07_STRING_REPEAT' => 170,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 168
		}
	},
	{#State 482
		ACTIONS => {
			'OP17_LIST_RANGE' => 168,
			'OP14_BITWISE_OR_XOR' => 167,
			'OP07_STRING_REPEAT' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP08_MATH_ADD_SUB' => 162,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 166,
			"]" => 486,
			'OP07_MATH_MULT_DIV_MOD' => 161,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP24_LOGICAL_OR_XOR' => 165,
			'OP09_BITWISE_SHIFT' => 159,
			'OP18_TERNARY' => 158,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 163
		}
	},
	{#State 483
		DEFAULT => -167
	},
	{#State 484
		ACTIONS => {
			'WORD' => 61,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 487
		}
	},
	{#State 485
		ACTIONS => {
			"\@_;" => 488
		}
	},
	{#State 486
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 489
		}
	},
	{#State 487
		ACTIONS => {
			'VARIABLE_SYMBOL' => 490
		}
	},
	{#State 488
		DEFAULT => -75
	},
	{#State 489
		ACTIONS => {
			"undef" => 491
		}
	},
	{#State 490
		DEFAULT => -72
	},
	{#State 491
		DEFAULT => -224
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6971 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6978 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 6989 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6996 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7124 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7402 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7485 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7749 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7760 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7771 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7782 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7793 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7804 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7815 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7826 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7837 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7844 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7872 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7894 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7905 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7927 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7938 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7949 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7960 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7967 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7974 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7981 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7988 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8010 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8032 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8054 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8087 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8098 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8109 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8131 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8142 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8153 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8164 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8175 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8186 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8197 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8208 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8215 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8222 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8229 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8240 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8251 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8262 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8273 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8284 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8305 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8326 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_162
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8337 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8348 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8359 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8370 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8381 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8392 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_168
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8414 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 223 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8432 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 223 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8439 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8450 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8464 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8475 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8486 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8552 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8574 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8581 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8595 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8606 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8617 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8628 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8639 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8664 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8689 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8700 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8711 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8718 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8725 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8736 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8747 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8758 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_206
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8769 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8776 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8783 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8790 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8801 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8826 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8837 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8848 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8859 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8870 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8881 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8892 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8903 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8914 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8936 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8947 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_225
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8958 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8969 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8980 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_228
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8991 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_229
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9002 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9035 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9046 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9057 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_235
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9068 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9079 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9090 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_238
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9101 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9112 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9123 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_241
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9134 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_242
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9145 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9156 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9167 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9178 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9189 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9200 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9211 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9222 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9233 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9244 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9255 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9266 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9277 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9288 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9299 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9310 lib/RPerl/Grammar.pm
	]
],
#line 9313 lib/RPerl/Grammar.pm
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
         'MethodOrSubroutine_76', 
         'MethodOrSubroutine_77', 
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_128', 
         'Expression_129', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpressionOrInput_143', 
         'SubExpressionOrInput_144', 
         'SubExpressionOrInput_145', 
         'SubExpressionOrVarMod_146', 
         'SubExpressionOrVarMod_147', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_162', 
         'Loop_163', 
         'Loop_164', 
         'Loop_165', 
         'LoopFor_166', 
         'LoopFor_167', 
         'LoopForEach_168', 
         'LoopWhile_169', 
         'LoopWhile_170', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_173', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_176', 
         'VariableRetrieval_177', 
         'VariableRetrieval_178', 
         'VariableRetrieval_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableDeclaration_182', 
         'VariableDeclaration_183', 
         'VariableModification_184', 
         'VariableModification_185', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_189', 
         'ListElement_190', 
         'ListElement_191', 
         'ListElement_192', 
         'ListElement_193', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_196', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_199', 
         'ArrayDereference_200', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_203', 
         'HashEntry_204', 
         'HashEntry_205', 
         'HashEntryProperties_206', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_210', 
         'HashReference_211', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_214', 
         'HashDereference_215', 
         'WordScoped_216', 
         'WordScoped_217', 
         'LoopLabel_218', 
         'Type_219', 
         'Type_220', 
         'Type_221', 
         'TypeInner_222', 
         'TypeInnerProperties_223', 
         'TypeInnerProperties_224', 
         'TypeInnerConstant_225', 
         'VariableOrLiteral_226', 
         'VariableOrLiteral_227', 
         'VarOrLitOrOpStrOrWord_228', 
         'VarOrLitOrOpStrOrWord_229', 
         'VarOrLitOrOpStrOrWord_230', 
         'VariableSymbolOrSelf_231', 
         'VariableSymbolOrSelf_232', 
         'Literal_233', 
         'Literal_234', 
         'OpNamedScolonOrSubExp_235', 
         'OpNamedScolonOrSubExp_236', 
         'OpNamedScolonOrSubExp_237', 
         'OpNamedScolonOrSubExpIn_238', 
         'OpNamedScolonOrSubExpIn_239', 
         'OpNamedScolonOrSubExpIn_240', 
         'OpStringOrWord_241', 
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
         'OpStringOrWord_257', );
  $self;
}

#line 260 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar parse-only tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
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
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_75 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_76 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_77 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_78 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_79 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_80 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_81 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_82 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_83 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_84 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_85 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_86 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> OP03_MATH_INC_DEC Variable
Operator_88 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> Variable OP03_MATH_INC_DEC
Operator_89 => 'RPerl::Operation::Expression::Operator::Math::Power',                   # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_90 => 'RPerl::Operation::Expression::Operator::Logical::Negation',             # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_91 => 'RPerl::Operation::Expression::Operator::Math::Negative',                # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_92 => 'RPerl::Operation::Expression::Operator::RegularExpression',             # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_93 => 'RPerl::Operation::Expression::Operator::String::Repeat',                # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_94 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',    # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',             # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::String::Concatenate',           # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_98 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY
Operator_100 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan', # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',       # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                 # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',               # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::List::Range',                  # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Ternary',                      # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::Negation',            # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_110 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_117 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_121 => 'RPerl::Operation::Expression::Operator::Named',                    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_122 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_123 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_128 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_129 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_130 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_131 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_132 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_133 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_134 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_135 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_138 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_140 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_141 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_142 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_143 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_144 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_145 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_146 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_147 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_151 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_152 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_153 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_154 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_155 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_162 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_163 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_164 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_165 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_166 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_167 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_168 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_169 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_170 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_173 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_176 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_177 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_178 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_179 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_182 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_183 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_184 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_185 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_189 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_190 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_191 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_192 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_193 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_196 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_199 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_200 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_203 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_205 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_206 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_210 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_211 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_214 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_215 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_216 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_217 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_218 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_219 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_220 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_221 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_222 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_223 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_224 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_225 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_226 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_227 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_228 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_229 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_230 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_231 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_232 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_233 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_234 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_235 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_236 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_237 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_238 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_239 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_240 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_241 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_242 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_243 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_244 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_245 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_246 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_247 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_248 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_249 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_250 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_251 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_252 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_253 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_254 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_255 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}

=for None

=cut


#line 9777 lib/RPerl/Grammar.pm



1;
