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

#line 2 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.002_302;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|\$TYPED_|package|foreach|while|elsif|undef|else|\@_\;|our|for|\%\{|if|\@\{|\]|\}|\;|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$self)/gc and return ('SELF', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
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
      /\G(next|last)\s/gc and return ('OP19_LOOP_CONTROL', $1);
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
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\([^()]*\))/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(abs;|accept;|atan2;|bind;|binmode;|bless;|break;|chmod;|chomp;|chop;|chown;|chr;|closedir;|cmp;|connect;|continue;|crypt;|dbmclose;|dbmopen;|default;|dump;|each;|endgrent;|endhostent;|endnetent;|endprotoent;|endpwent;|endservent;|eof;|evalbytes;|exec;|exp;|fc;|fcntl;|fileno;|flock;|fork;|format;|formline;|getc;|getgrent;|getgrgid;|getgrnam;|gethostbyaddr;|gethostent;|getlogin;|getnetbyaddr;|getnetent;|getpeername;|getppid;|getpriority;|getprotobynumber;|getprotoent;|getpwent;|getpwnam;|getpwuid;|getservbyname;|getservbyport;|getservent;|getsockname;|getsockopt;|given;|grep;|index;|ioctl;|join;|keys;|kill;|link;|listen;|local;|m;|map;|mkdir;|msgctl;|msgget;|msgrcv;|msgsnd;|opendir;|pack;|pipe;|pop;|pos;|prototype;|push;|q;|qq;|qr;|qx;|read;|readdir;|readline;|readpipe;|recv;|redo;|rename;|reset;|reverse;|rewinddir;|rindex;|s;|say;|seek;|seekdir;|select;|semctl;|semget;|semop;|send;|setgrent;|sethostent;|setnetent;|setpgrp;|setpriority;|setprotoent;|setpwent;|setservent;|setsockopt;|shift;|shmctl;|shmget;|shmread;|shmwrite;|shutdown;|socket;|socketpair;|sort;|splice;|split;|sprintf;|state;|study;|substr;|symlink;|syscall;|sysopen;|sysread;|sysseek;|system;|syswrite;|tell;|telldir;|tie;|tied;|time;|times;|tr;|truncate;|unless;|unlink;|unpack;|unshift;|untie;|until;|utime;|values;|vec;|wait;|waitpid;|wantarray;|warn;|when;|write;|y;)/gc and return ('OP01_NAMED_SCOLON', $1);
      /\G(abs\s|accept\s|atan2\s|bind\s|binmode\s|bless\s|break\s|chmod\s|chomp\s|chop\s|chown\s|chr\s|closedir\s|cmp\s|connect\s|continue\s|crypt\s|dbmclose\s|dbmopen\s|default\s|dump\s|each\s|endgrent\s|endhostent\s|endnetent\s|endprotoent\s|endpwent\s|endservent\s|eof\s|evalbytes\s|exec\s|exp\s|fc\s|fcntl\s|fileno\s|flock\s|fork\s|format\s|formline\s|getc\s|getgrent\s|getgrgid\s|getgrnam\s|gethostbyaddr\s|gethostent\s|getlogin\s|getnetbyaddr\s|getnetent\s|getpeername\s|getppid\s|getpriority\s|getprotobynumber\s|getprotoent\s|getpwent\s|getpwnam\s|getpwuid\s|getservbyname\s|getservbyport\s|getservent\s|getsockname\s|getsockopt\s|given\s|grep\s|index\s|ioctl\s|join\s|keys\s|kill\s|link\s|listen\s|local\s|m\s|map\s|mkdir\s|msgctl\s|msgget\s|msgrcv\s|msgsnd\s|opendir\s|pack\s|pipe\s|pop\s|pos\s|prototype\s|push\s|q\s|qq\s|qr\s|qx\s|read\s|readdir\s|readline\s|readpipe\s|recv\s|redo\s|rename\s|reset\s|reverse\s|rewinddir\s|rindex\s|s\s|say\s|seek\s|seekdir\s|select\s|semctl\s|semget\s|semop\s|send\s|setgrent\s|sethostent\s|setnetent\s|setpgrp\s|setpriority\s|setprotoent\s|setpwent\s|setservent\s|setsockopt\s|shift\s|shmctl\s|shmget\s|shmread\s|shmwrite\s|shutdown\s|socket\s|socketpair\s|sort\s|splice\s|split\s|sprintf\s|state\s|study\s|substr\s|symlink\s|syscall\s|sysopen\s|sysread\s|sysseek\s|system\s|syswrite\s|tell\s|telldir\s|tie\s|tied\s|time\s|times\s|tr\s|truncate\s|unless\s|unlink\s|unpack\s|unshift\s|untie\s|until\s|utime\s|values\s|vec\s|wait\s|waitpid\s|wantarray\s|warn\s|when\s|write\s|y\s)/gc and return ('OP01_NAMED', $1);
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


#line 141 lib/RPerl/Grammar.pm

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
  [ 'HashEntry_203' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_204' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_205' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_206' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
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
  [ 'TypeInner_222' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_223' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_224' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_225' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_226' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_227' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_228' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_229' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_230' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
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
  'VariableOrLiteralOrWord_228' => 228,
  'VariableOrLiteralOrWord_229' => 229,
  'VariableOrLiteralOrWord_230' => 230,
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
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 1,
			'SHEBANG' => 5
		},
		GOTOS => {
			'CompileUnit' => 3,
			'ModuleHeader' => 2,
			'PLUS-2' => 9,
			'PAREN-1' => 8,
			'OPTIONAL-9' => 6,
			'Critic' => 7,
			'Program' => 4
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
		ACTIONS => {
			"use parent qw(" => 12,
			"our" => -27,
			'USE' => -27,
			"## no critic qw(" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Class' => 14,
			'Module' => 13,
			'STAR-11' => 16,
			'Package' => 15
		}
	},
	{#State 3
		ACTIONS => {
			'' => 17
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'Critic' => 18,
			'OPTIONAL-3' => 19
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => 21,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 20
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			'USE_RPERL' => -20,
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'ModuleHeader' => 2,
			'PAREN-1' => 22,
			'OPTIONAL-9' => 6,
			'Critic' => 7
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 24,
			")" => 23
		}
	},
	{#State 11
		DEFAULT => -39
	},
	{#State 12
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -25
	},
	{#State 15
		DEFAULT => -24
	},
	{#State 16
		ACTIONS => {
			"our" => -29,
			'USE' => -29,
			"## no critic qw(" => 1,
			"use constant" => -29
		},
		GOTOS => {
			'Critic' => 28,
			'STAR-12' => 29
		}
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		DEFAULT => -6
	},
	{#State 19
		ACTIONS => {
			'USE_RPERL' => 30
		}
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
		DEFAULT => -2
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
		DEFAULT => -217
	},
	{#State 27
		DEFAULT => -216
	},
	{#State 28
		DEFAULT => -26
	},
	{#State 29
		ACTIONS => {
			'USE' => 33,
			"use constant" => -31,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 34
		}
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
			'WORD' => 27,
			'WORD_SCOPED' => 26
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
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			"use constant" => 43,
			"our" => 41
		},
		GOTOS => {
			'PLUS-14' => 42,
			'Constant' => 45,
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
			'USE' => 33
		},
		GOTOS => {
			'Include' => 49
		}
	},
	{#State 40
		ACTIONS => {
			";" => 50,
			'OP01_QW' => 51
		}
	},
	{#State 41
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD_SCOPED' => 53,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 41
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 44
		DEFAULT => -33
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			"use constant" => -11,
			"if" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"for" => -11,
			'LBRACE' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'WORD_SCOPED' => -11,
			'WORD_UPPERCASE' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID' => -11,
			"foreach" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"our" => -11,
			'OP01_OPEN' => -11,
			"## no critic qw(" => 1,
			'SELF' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_PRINT' => -11,
			'MY' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"undef" => -11,
			'LPAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED' => -11,
			'USE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"\@{" => -11,
			'LITERAL_STRING' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD' => -11,
			'VARIABLE_SYMBOL' => -11,
			"while" => -11,
			'LBRACKET' => -11,
			'OP01_NAMED_SCOLON' => -11
		},
		GOTOS => {
			'STAR-5' => 60,
			'Critic' => 59
		}
	},
	{#State 47
		ACTIONS => {
			'USE_RPERL_AFTER' => 62,
			"our" => -36
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
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 53
		DEFAULT => -220
	},
	{#State 54
		DEFAULT => -221
	},
	{#State 55
		DEFAULT => -219
	},
	{#State 56
		ACTIONS => {
			";" => 67
		}
	},
	{#State 57
		DEFAULT => -32
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 59
		DEFAULT => -8
	},
	{#State 60
		ACTIONS => {
			'OP01_PRINT' => -13,
			'SELF' => -13,
			'OP01_OPEN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'MY' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"foreach" => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"our" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'WORD_UPPERCASE' => -13,
			"%{" => -13,
			'LBRACE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED_VOID' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"for" => -13,
			"if" => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'VARIABLE_SYMBOL' => -13,
			"while" => -13,
			'WORD' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'USE' => 33,
			"\@{" => -13,
			'OP01_NAMED' => -13,
			"undef" => -13,
			'LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13
		},
		GOTOS => {
			'Include' => 70,
			'STAR-6' => 69
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
			"## no critic qw(" => 1,
			'USE' => -56,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 72,
			'Critic' => 73
		}
	},
	{#State 65
		DEFAULT => -42
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 67
		DEFAULT => -34
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
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"our" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"foreach" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'MY' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			'SELF' => -15,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"for" => -15,
			"if" => -15,
			"use constant" => 43,
			'OP01_NAMED_VOID' => -15,
			'WORD_UPPERCASE' => -15,
			"%{" => -15,
			'LBRACE' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LBRACKET' => -15,
			'VARIABLE_SYMBOL' => -15,
			"while" => -15,
			'OP01_NAMED' => -15,
			"undef" => -15,
			'OP10_NAMED_UNARY' => -15,
			'LPAREN' => -15,
			"\@{" => -15,
			'OP03_MATH_INC_DEC' => -15
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
		ACTIONS => {
			"use constant" => -58,
			'USE' => 33,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'STAR-23' => 81,
			'Include' => 80
		}
	},
	{#State 73
		DEFAULT => -53
	},
	{#State 74
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -45,
			'LITERAL_STRING' => -45,
			'WORD' => -45,
			'VARIABLE_SYMBOL' => -45,
			"while" => -45,
			'LBRACKET' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'LPAREN_MY' => 84,
			"undef" => -45,
			'LPAREN' => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP01_NAMED' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"\@{" => -45,
			'LITERAL_NUMBER' => -45,
			"foreach" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP01_CLOSE' => -45,
			"}" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'SELF' => -45,
			'OP01_OPEN' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP01_PRINT' => -45,
			'MY' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP22_LOGICAL_NEG' => -45,
			"if" => -45,
			"for" => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'LBRACE' => -45,
			'WORD_SCOPED' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'WORD_UPPERCASE' => -45,
			"%{" => -45,
			'OP01_NAMED_VOID' => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 82,
			'SubroutineArguments' => 83
		}
	},
	{#State 75
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD_SCOPED' => 53,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 85
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'Literal' => 88
		}
	},
	{#State 77
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 103,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			"foreach" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 101,
			"our" => 41,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'OP19_LOOP_CONTROL' => 114,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_PRINT' => 112,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 111,
			'OP22_LOGICAL_NEG' => 107,
			"if" => 90,
			"for" => -150,
			'OP01_NAMED_VOID_LPAREN' => 89,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"%{" => 93,
			'WORD_UPPERCASE' => 96,
			'OP01_NAMED_VOID' => 92,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			"while" => -150,
			'VARIABLE_SYMBOL' => 137,
			'LBRACKET' => 135,
			'OP01_NAMED_SCOLON' => 136,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 118,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124
		},
		GOTOS => {
			'SubExpression' => 106,
			'Operator' => 134,
			'ArrayReference' => 108,
			'PAREN-36' => 109,
			'VariableModification' => 113,
			'Subroutine' => 115,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'VariableDeclaration' => 102,
			'OPTIONAL-37' => 104,
			'LoopLabel' => 129,
			'HashReference' => 132,
			'Variable' => 131,
			'Conditional' => 133,
			'Operation' => 91,
			'Literal' => 125,
			'PLUS-8' => 94,
			'HashDereference' => 95,
			'OperatorVoid' => 127,
			'Expression' => 98,
			'Statement' => 119,
			'VariableSymbolOrSelf' => 123
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
			"our hashref \$properties" => 140,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 139,
			'Constant' => 141
		}
	},
	{#State 82
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 142
		}
	},
	{#State 83
		DEFAULT => -44
	},
	{#State 84
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55,
			'WORD_SCOPED' => 53
		},
		GOTOS => {
			'Type' => 143
		}
	},
	{#State 85
		ACTIONS => {
			"\$TYPED_" => 144
		}
	},
	{#State 86
		DEFAULT => -233
	},
	{#State 87
		DEFAULT => -234
	},
	{#State 88
		ACTIONS => {
			";" => 145
		}
	},
	{#State 89
		ACTIONS => {
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_QW' => 152,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			")" => -115,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120
		},
		GOTOS => {
			'OPTIONAL-33' => 148,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ListElement' => 153,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'SubExpression' => 157,
			'Operator' => 134,
			'ArrayReference' => 108,
			'ListElements' => 155,
			'TypeInner' => 149
		}
	},
	{#State 90
		ACTIONS => {
			'LPAREN' => 158
		}
	},
	{#State 91
		DEFAULT => -17
	},
	{#State 92
		ACTIONS => {
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_QW' => 152,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			"\@{" => 124,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'ListElement' => 153,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayReference' => 108,
			'SubExpression' => 157,
			'Operator' => 134,
			'TypeInner' => 149,
			'ListElements' => 159,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 93
		ACTIONS => {
			'SELF' => 117,
			'LBRACE' => -213,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156
		},
		GOTOS => {
			'OPTIONAL-51' => 160,
			'TypeInner' => 161,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 94
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124,
			'OP01_NAMED' => 118,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'LBRACKET' => 135,
			'OP01_NAMED_SCOLON' => 136,
			"while" => -150,
			'VARIABLE_SYMBOL' => 137,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'' => -18,
			"%{" => 93,
			'WORD_UPPERCASE' => 96,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 92,
			"for" => -150,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"if" => 90,
			'OP01_PRINT' => 112,
			'OP19_LOOP_CONTROL' => 114,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 111,
			'OP01_CLOSE' => 105,
			'OP01_NAMED_VOID_SCOLON' => 103,
			'LITERAL_NUMBER' => 86,
			"foreach" => -150,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 101
		},
		GOTOS => {
			'Operation' => 163,
			'HashDereference' => 95,
			'Literal' => 125,
			'Expression' => 98,
			'OperatorVoid' => 127,
			'Statement' => 119,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 108,
			'SubExpression' => 106,
			'Operator' => 134,
			'PAREN-36' => 109,
			'VariableModification' => 113,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'VariableDeclaration' => 102,
			'LoopLabel' => 129,
			'OPTIONAL-37' => 104,
			'Conditional' => 133,
			'Variable' => 131,
			'HashReference' => 132
		}
	},
	{#State 95
		DEFAULT => -141
	},
	{#State 96
		ACTIONS => {
			'LPAREN' => 164,
			'COLON' => -218
		}
	},
	{#State 97
		DEFAULT => -130
	},
	{#State 98
		ACTIONS => {
			'OP15_LOGICAL_AND' => -134,
			'OP06_REGEX_MATCH' => -134,
			";" => 165,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP08_STRING_CAT' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP18_TERNARY' => -134,
			'OP04_MATH_POW' => -134,
			'OP11_COMPARE_LT_GT' => -134
		}
	},
	{#State 99
		ACTIONS => {
			'SELF' => 117,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 137,
			'LITERAL_NUMBER' => 86,
			'WORD' => 168,
			'LITERAL_STRING' => 87,
			'ENV' => 170,
			"}" => 171
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 172,
			'HashEntry' => 167,
			'HashDereference' => 173,
			'VariableSymbolOrSelf' => 123,
			'Literal' => 169,
			'Variable' => 166
		}
	},
	{#State 100
		DEFAULT => -122
	},
	{#State 101
		DEFAULT => -80
	},
	{#State 102
		DEFAULT => -154
	},
	{#State 103
		DEFAULT => -118
	},
	{#State 104
		ACTIONS => {
			"for" => 174,
			"while" => 180,
			"foreach" => 176
		},
		GOTOS => {
			'Loop' => 177,
			'LoopFor' => 175,
			'LoopForEach' => 179,
			'LoopWhile' => 178
		}
	},
	{#State 105
		ACTIONS => {
			'FHREF_SYMBOL' => 181
		}
	},
	{#State 106
		ACTIONS => {
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 186,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 107
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 199
		}
	},
	{#State 108
		DEFAULT => -138
	},
	{#State 109
		DEFAULT => -149
	},
	{#State 110
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'SubExpression' => 200,
			'Operator' => 134,
			'ArrayReference' => 108
		}
	},
	{#State 111
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD_SCOPED' => 53,
			'WORD' => 55,
			'TYPE_FHREF' => 202
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 112
		ACTIONS => {
			'OP01_QW' => -113,
			'LITERAL_NUMBER' => -113,
			'WORD' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'LITERAL_STRING' => -113,
			'OP01_CLOSE' => -113,
			'VARIABLE_SYMBOL' => -113,
			'MY' => -113,
			'OP05_LOGICAL_NEG' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'LBRACKET' => -113,
			'FHREF_SYMBOL_BRACES' => 205,
			'SELF' => -113,
			'OP01_OPEN' => -113,
			'ARGV' => -113,
			"undef" => -113,
			'OP10_NAMED_UNARY' => -113,
			'LPAREN' => -113,
			'OP01_NAMED' => -113,
			"\@{" => -113,
			'LBRACE' => -113,
			'WORD_SCOPED' => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			'STDOUT_STDERR' => 203,
			'WORD_UPPERCASE' => -113,
			'OP03_MATH_INC_DEC' => -113,
			"%{" => -113
		},
		GOTOS => {
			'OPTIONAL-32' => 204,
			'PAREN-31' => 206
		}
	},
	{#State 113
		ACTIONS => {
			";" => 207
		}
	},
	{#State 114
		ACTIONS => {
			'WORD_UPPERCASE' => 208
		},
		GOTOS => {
			'LoopLabel' => 209
		}
	},
	{#State 115
		DEFAULT => -14
	},
	{#State 116
		ACTIONS => {
			'MY' => 210
		}
	},
	{#State 117
		DEFAULT => -232
	},
	{#State 118
		ACTIONS => {
			'OP01_QW' => 152,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'ARGV' => 154,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146,
			"\@{" => 124,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93
		},
		GOTOS => {
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'TypeInner' => 149,
			'Operator' => 134,
			'SubExpression' => 212,
			'ArrayReference' => 108,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ListElement' => 211,
			'ArrayDereference' => 128
		}
	},
	{#State 119
		DEFAULT => -81
	},
	{#State 120
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP18_TERNARY' => -99,
			")" => -99,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'OP08_MATH_ADD_SUB' => -99,
			'OP22_LOGICAL_NEG' => 107,
			"]" => -99,
			'OP05_LOGICAL_NEG' => 110,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => -99,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			"}" => -99,
			'OP08_STRING_CAT' => -99,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			'OP04_MATH_POW' => -99,
			'OP01_NAMED' => 146,
			'OP13_BITWISE_AND' => -99,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LBRACKET' => 135,
			'OP23_LOGICAL_AND' => -99,
			'VARIABLE_SYMBOL' => 137,
			'OP21_LIST_COMMA' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP15_LOGICAL_AND' => -99,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'OP06_REGEX_MATCH' => -99,
			";" => -99,
			'OP16_LOGICAL_OR' => -99
		},
		GOTOS => {
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'Operator' => 134,
			'SubExpression' => 213,
			'ArrayReference' => 108,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128
		}
	},
	{#State 121
		ACTIONS => {
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP01_PRINT' => 215,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_NAMED' => 216,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99
		},
		GOTOS => {
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'SubExpression' => 214,
			'Operator' => 134,
			'ArrayReference' => 108
		}
	},
	{#State 122
		DEFAULT => -135
	},
	{#State 123
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 217
		}
	},
	{#State 124
		ACTIONS => {
			'LBRACKET' => -198,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'SELF' => 117
		},
		GOTOS => {
			'TypeInner' => 218,
			'OPTIONAL-47' => 219,
			'Variable' => 220,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 125
		DEFAULT => -136
	},
	{#State 126
		ACTIONS => {
			'VARIABLE_SYMBOL' => 137,
			'SELF' => 117
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 221
		}
	},
	{#State 127
		DEFAULT => -153
	},
	{#State 128
		DEFAULT => -139
	},
	{#State 129
		ACTIONS => {
			'COLON' => 222
		}
	},
	{#State 130
		ACTIONS => {
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135
		},
		GOTOS => {
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128,
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 223
		}
	},
	{#State 131
		ACTIONS => {
			'OP08_STRING_CAT' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP02_METHOD_THINARROW' => 226,
			'OP23_LOGICAL_AND' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP19_VARIABLE_ASSIGN' => 225,
			'OP13_BITWISE_AND' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 227,
			'OP08_MATH_ADD_SUB' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP04_MATH_POW' => -137,
			")" => -137,
			'OP03_MATH_INC_DEC' => 224,
			'OP18_TERNARY' => -137
		}
	},
	{#State 132
		DEFAULT => -140
	},
	{#State 133
		DEFAULT => -151
	},
	{#State 134
		DEFAULT => -128
	},
	{#State 135
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			'OP01_QW' => 152,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			"]" => -195,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 124
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'ListElement' => 153,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 157,
			'ListElements' => 228,
			'TypeInner' => 149,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'OPTIONAL-46' => 229
		}
	},
	{#State 136
		DEFAULT => -79
	},
	{#State 137
		DEFAULT => -231
	},
	{#State 138
		ACTIONS => {
			'LPAREN' => 230,
			'OP02_METHOD_THINARROW_NEW' => 231
		}
	},
	{#State 139
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 232
		}
	},
	{#State 140
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 233
		}
	},
	{#State 141
		DEFAULT => -57
	},
	{#State 142
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 101,
			"}" => 234,
			'OP01_CLOSE' => 105,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"foreach" => -150,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 111,
			'OP01_PRINT' => 112,
			'OP19_LOOP_CONTROL' => 114,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			"for" => -150,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"if" => 90,
			'OP01_NAMED_VOID' => 92,
			"%{" => 93,
			'WORD_UPPERCASE' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'OP01_NAMED_SCOLON' => 136,
			'LBRACKET' => 135,
			"while" => -150,
			'VARIABLE_SYMBOL' => 137,
			'OP01_NAMED' => 118,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126
		},
		GOTOS => {
			'VariableModification' => 113,
			'WordScoped' => 138,
			'SubExpression' => 106,
			'Operator' => 134,
			'ArrayReference' => 108,
			'PAREN-36' => 109,
			'LoopLabel' => 129,
			'OPTIONAL-37' => 104,
			'HashReference' => 132,
			'Variable' => 131,
			'Conditional' => 133,
			'ArrayDereference' => 128,
			'VariableDeclaration' => 102,
			'Literal' => 125,
			'HashDereference' => 95,
			'OperatorVoid' => 127,
			'Expression' => 98,
			'Operation' => 235,
			'VariableSymbolOrSelf' => 123,
			'Statement' => 119
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 236
		}
	},
	{#State 144
		ACTIONS => {
			'WORD_UPPERCASE' => 237
		}
	},
	{#State 145
		DEFAULT => -43
	},
	{#State 146
		ACTIONS => {
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122
		},
		GOTOS => {
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 238,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 147
		ACTIONS => {
			")" => -137,
			'OP03_MATH_INC_DEC' => 224,
			'OP18_TERNARY' => -137,
			'OP04_MATH_POW' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP02_METHOD_THINARROW' => 226,
			"]" => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP15_LOGICAL_AND' => -137,
			";" => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			"}" => -137,
			'OP08_STRING_CAT' => -137
		}
	},
	{#State 148
		ACTIONS => {
			")" => 239
		}
	},
	{#State 149
		ACTIONS => {
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'SubExpression' => 240,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 150
		DEFAULT => -134
	},
	{#State 151
		ACTIONS => {
			'LPAREN' => 164
		}
	},
	{#State 152
		DEFAULT => -192
	},
	{#State 153
		DEFAULT => -188,
		GOTOS => {
			'STAR-45' => 241
		}
	},
	{#State 154
		DEFAULT => -193
	},
	{#State 155
		DEFAULT => -114
	},
	{#State 156
		ACTIONS => {
			'WORD_SCOPED' => 53,
			'WORD' => 55,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 242
		}
	},
	{#State 157
		ACTIONS => {
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			";" => -190,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP07_STRING_REPEAT' => 184,
			"]" => -190,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP23_LOGICAL_AND' => 192,
			'OP21_LIST_COMMA' => -190,
			'OP17_LIST_RANGE' => 193,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			")" => -190
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			"\@{" => 124,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'SubExpression' => 243,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138
		}
	},
	{#State 159
		ACTIONS => {
			";" => 244
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACE' => 99
		},
		GOTOS => {
			'HashReference' => 245
		}
	},
	{#State 161
		DEFAULT => -212
	},
	{#State 162
		ACTIONS => {
			"}" => 246
		}
	},
	{#State 163
		DEFAULT => -16
	},
	{#State 164
		ACTIONS => {
			")" => 247
		}
	},
	{#State 165
		DEFAULT => -78
	},
	{#State 166
		DEFAULT => -228
	},
	{#State 167
		DEFAULT => -209,
		GOTOS => {
			'STAR-50' => 248
		}
	},
	{#State 168
		DEFAULT => -230
	},
	{#State 169
		DEFAULT => -229
	},
	{#State 170
		DEFAULT => -205
	},
	{#State 171
		DEFAULT => -211
	},
	{#State 172
		ACTIONS => {
			'OP20_HASH_FATARROW' => 249
		}
	},
	{#State 173
		DEFAULT => -204
	},
	{#State 174
		ACTIONS => {
			'MY' => 250,
			'LPAREN_MY' => 251
		}
	},
	{#State 175
		DEFAULT => -163
	},
	{#State 176
		ACTIONS => {
			'MY' => 252
		}
	},
	{#State 177
		DEFAULT => -152
	},
	{#State 178
		DEFAULT => -165
	},
	{#State 179
		DEFAULT => -164
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 253,
			'LPAREN_MY' => 254
		}
	},
	{#State 181
		DEFAULT => -86
	},
	{#State 182
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'SELF' => 117,
			'VARIABLE_SYMBOL' => 137
		},
		GOTOS => {
			'VariableOrLiteral' => 257,
			'Variable' => 256,
			'VariableSymbolOrSelf' => 123,
			'Literal' => 255
		}
	},
	{#State 183
		ACTIONS => {
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'SubExpression' => 258,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95
		}
	},
	{#State 184
		ACTIONS => {
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			"\@{" => 124,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 259,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128
		}
	},
	{#State 185
		ACTIONS => {
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121
		},
		GOTOS => {
			'Operator' => 134,
			'SubExpression' => 260,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135
		},
		GOTOS => {
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'Operator' => 134,
			'SubExpression' => 261,
			'ArrayReference' => 108,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128
		}
	},
	{#State 187
		ACTIONS => {
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 134,
			'SubExpression' => 262,
			'ArrayReference' => 108,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95
		}
	},
	{#State 188
		ACTIONS => {
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137
		},
		GOTOS => {
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'SubExpression' => 263,
			'Operator' => 134,
			'ArrayReference' => 108,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128
		}
	},
	{#State 189
		ACTIONS => {
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP01_CLOSE' => 105,
			"\@{" => 124,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 264,
			'Operator' => 134
		}
	},
	{#State 190
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 265,
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_CLOSE' => 105,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'Operator' => 134,
			'SubExpression' => 266,
			'ArrayReference' => 108,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95
		}
	},
	{#State 192
		ACTIONS => {
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 267,
			'Operator' => 134
		}
	},
	{#State 193
		ACTIONS => {
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			"\@{" => 124,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99
		},
		GOTOS => {
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 268,
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ArrayDereference' => 128,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 194
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146,
			"\@{" => 124,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 269,
			'Operator' => 134,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128
		}
	},
	{#State 195
		ACTIONS => {
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			"\@{" => 124,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'ArrayReference' => 108,
			'SubExpression' => 270,
			'Operator' => 134,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147
		}
	},
	{#State 196
		ACTIONS => {
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"\@{" => 124
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 271,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 197
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 272
		}
	},
	{#State 198
		ACTIONS => {
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'Operator' => 134,
			'SubExpression' => 273,
			'ArrayReference' => 108
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => -108,
			'OP17_LIST_RANGE' => 193,
			'OP14_BITWISE_OR_XOR' => 185,
			"]" => -108,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			";" => -108,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP08_STRING_CAT' => 186,
			"}" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP09_BITWISE_SHIFT' => 195,
			'OP04_MATH_POW' => 190,
			")" => -108,
			'OP18_TERNARY' => 182,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 200
		ACTIONS => {
			'OP23_LOGICAL_AND' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			"]" => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			"}" => -90,
			";" => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP18_TERNARY' => -90,
			")" => -90,
			'OP04_MATH_POW' => 190,
			'OP13_BITWISE_AND' => -90,
			'OP08_MATH_ADD_SUB' => -90
		}
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 274
		}
	},
	{#State 202
		ACTIONS => {
			'FHREF_SYMBOL' => 275
		}
	},
	{#State 203
		DEFAULT => -111
	},
	{#State 204
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'ARGV' => 154,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP01_QW' => 152
		},
		GOTOS => {
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 157,
			'ListElements' => 276,
			'TypeInner' => 149,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayDereference' => 128,
			'ListElement' => 153,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147
		}
	},
	{#State 205
		ACTIONS => {
			"\@{" => 124,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_QW' => 152,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ListElement' => 153,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'Operator' => 134,
			'SubExpression' => 157,
			'ArrayReference' => 108,
			'ListElements' => 277,
			'TypeInner' => 149
		}
	},
	{#State 206
		DEFAULT => -112
	},
	{#State 207
		DEFAULT => -155
	},
	{#State 208
		DEFAULT => -218
	},
	{#State 209
		ACTIONS => {
			";" => 278
		}
	},
	{#State 210
		ACTIONS => {
			'TYPE_FHREF' => 279
		}
	},
	{#State 211
		ACTIONS => {
			'OP21_LIST_COMMA' => 280
		}
	},
	{#State 212
		ACTIONS => {
			'OP08_STRING_CAT' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP15_LOGICAL_AND' => -83,
			";" => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP21_LIST_COMMA' => -190,
			'OP13_BITWISE_AND' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP04_MATH_POW' => -83,
			'OP18_TERNARY' => -83,
			")" => -83
		}
	},
	{#State 213
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP15_LOGICAL_AND' => -98,
			";" => -98,
			'OP06_REGEX_MATCH' => 197,
			"}" => -98,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP09_BITWISE_SHIFT' => 195,
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			"]" => -98,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -98,
			'OP04_MATH_POW' => 190,
			")" => -98,
			'OP18_TERNARY' => -98,
			'OP11_COMPARE_LT_GT' => -98
		}
	},
	{#State 214
		ACTIONS => {
			'OP23_LOGICAL_AND' => 192,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP17_LIST_RANGE' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP11_COMPARE_LT_GT' => 189,
			'OP18_TERNARY' => 182,
			")" => 281,
			'OP04_MATH_POW' => 190,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183
		}
	},
	{#State 215
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 282
		}
	},
	{#State 216
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP01_CLOSE' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 152
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'ListElement' => 283,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 212,
			'TypeInner' => 149,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 217
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -176,
			'OP04_MATH_POW' => -176,
			'OP03_MATH_INC_DEC' => -176,
			")" => -176,
			'OP18_TERNARY' => -176,
			'OP02_HASH_THINARROW' => 286,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP13_BITWISE_AND' => -176,
			'OP02_ARRAY_THINARROW' => 284,
			'OP08_MATH_ADD_SUB' => -176,
			'OP02_METHOD_THINARROW' => -176,
			"]" => -176,
			'OP07_STRING_REPEAT' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP20_HASH_FATARROW' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			"}" => -176,
			'OP08_STRING_CAT' => -176,
			'COLON' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP12_COMPARE_EQ_NE' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP06_REGEX_MATCH' => -176,
			";" => -176
		},
		GOTOS => {
			'VariableRetrieval' => 285
		}
	},
	{#State 218
		DEFAULT => -197
	},
	{#State 219
		ACTIONS => {
			'LBRACKET' => 135
		},
		GOTOS => {
			'ArrayReference' => 287
		}
	},
	{#State 220
		ACTIONS => {
			"}" => 288
		}
	},
	{#State 221
		DEFAULT => -87
	},
	{#State 222
		DEFAULT => -148
	},
	{#State 223
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 189,
			")" => 289,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP17_LIST_RANGE' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187
		}
	},
	{#State 224
		DEFAULT => -88
	},
	{#State 225
		ACTIONS => {
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'STDIN' => 293,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'FHREF_SYMBOL_IN' => 290,
			'SELF' => 117,
			'OP01_OPEN' => 116
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 291,
			'Operator' => 134,
			'VariableSymbolOrSelf' => 123,
			'SubExpressionOrInput' => 292,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128
		}
	},
	{#State 226
		ACTIONS => {
			'LPAREN' => 294
		}
	},
	{#State 227
		ACTIONS => {
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_CLOSE' => 105,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'SubExpression' => 295,
			'Operator' => 134,
			'ArrayReference' => 108
		}
	},
	{#State 228
		DEFAULT => -194
	},
	{#State 229
		ACTIONS => {
			"]" => 296
		}
	},
	{#State 230
		ACTIONS => {
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_QW' => 152,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'ARGV' => 154,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 126,
			")" => -125,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'OPTIONAL-34' => 298,
			'ListElement' => 153,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 157,
			'ListElements' => 297,
			'TypeInner' => 149
		}
	},
	{#State 231
		ACTIONS => {
			")" => 299
		}
	},
	{#State 232
		ACTIONS => {
			'LITERAL_NUMBER' => 302,
			"our" => 301
		},
		GOTOS => {
			'MethodOrSubroutine' => 304,
			'Subroutine' => 300,
			'Method' => 303
		}
	},
	{#State 233
		ACTIONS => {
			'LBRACE' => 305
		}
	},
	{#State 234
		ACTIONS => {
			";" => 306
		}
	},
	{#State 235
		DEFAULT => -46
	},
	{#State 236
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 307
		}
	},
	{#State 237
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 308
		}
	},
	{#State 238
		ACTIONS => {
			'OP13_BITWISE_AND' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP18_TERNARY' => -83,
			")" => -83,
			'OP04_MATH_POW' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			"}" => -83,
			'OP08_STRING_CAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			";" => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			"]" => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP17_LIST_RANGE' => -83
		}
	},
	{#State 239
		ACTIONS => {
			";" => 309
		}
	},
	{#State 240
		ACTIONS => {
			'OP21_LIST_COMMA' => -191,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			"]" => -191,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP06_REGEX_MATCH' => 197,
			";" => -191,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -191,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 241
		ACTIONS => {
			")" => -189,
			";" => -189,
			'OP21_LIST_COMMA' => 310,
			"]" => -189
		},
		GOTOS => {
			'PAREN-44' => 311
		}
	},
	{#State 242
		ACTIONS => {
			"\$TYPED_" => 312
		}
	},
	{#State 243
		ACTIONS => {
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP17_LIST_RANGE' => 193,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 186,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP11_COMPARE_LT_GT' => 189,
			")" => 313,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183
		}
	},
	{#State 244
		DEFAULT => -120
	},
	{#State 245
		ACTIONS => {
			"}" => 314
		}
	},
	{#State 246
		DEFAULT => -214
	},
	{#State 247
		DEFAULT => -129
	},
	{#State 248
		ACTIONS => {
			"}" => 316,
			'OP21_LIST_COMMA' => 317
		},
		GOTOS => {
			'PAREN-49' => 315
		}
	},
	{#State 249
		ACTIONS => {
			'WORD' => -202,
			'LITERAL_NUMBER' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'LITERAL_STRING' => -202,
			'OP01_CLOSE' => -202,
			'OP22_LOGICAL_NEG' => -202,
			'LBRACKET' => -202,
			'MY' => 156,
			'VARIABLE_SYMBOL' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'SELF' => -202,
			'OP01_OPEN' => -202,
			'OP01_NAMED' => -202,
			"undef" => -202,
			'OP10_NAMED_UNARY' => -202,
			'LPAREN' => -202,
			"\@{" => -202,
			'WORD_UPPERCASE' => -202,
			"%{" => -202,
			'OP03_MATH_INC_DEC' => -202,
			'LBRACE' => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'WORD_SCOPED' => -202
		},
		GOTOS => {
			'TypeInner' => 318,
			'OPTIONAL-48' => 319
		}
	},
	{#State 250
		ACTIONS => {
			'TYPE_INTEGER' => 320
		}
	},
	{#State 251
		ACTIONS => {
			'TYPE_INTEGER' => 321
		}
	},
	{#State 252
		ACTIONS => {
			'WORD' => 55,
			'WORD_SCOPED' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 322
		}
	},
	{#State 253
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			"\@{" => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 323
		}
	},
	{#State 254
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD_SCOPED' => 53,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 324
		}
	},
	{#State 255
		DEFAULT => -227
	},
	{#State 256
		DEFAULT => -226
	},
	{#State 257
		ACTIONS => {
			'COLON' => 325
		}
	},
	{#State 258
		ACTIONS => {
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP18_TERNARY' => -95,
			")" => -95,
			'OP04_MATH_POW' => 190,
			'OP09_BITWISE_SHIFT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			"}" => -95,
			'OP08_STRING_CAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			";" => -95,
			'OP06_REGEX_MATCH' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP07_STRING_REPEAT' => 184,
			"]" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP17_LIST_RANGE' => -95
		}
	},
	{#State 259
		ACTIONS => {
			"]" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP08_STRING_CAT' => -93,
			"}" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP06_REGEX_MATCH' => 197,
			";" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -93,
			")" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP08_MATH_ADD_SUB' => -93
		}
	},
	{#State 260
		ACTIONS => {
			'OP15_LOGICAL_AND' => -103,
			";" => -103,
			'OP06_REGEX_MATCH' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -103,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 195,
			"}" => -103,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP23_LOGICAL_AND' => -103,
			"]" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP07_STRING_REPEAT' => 184,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP18_TERNARY' => -103,
			")" => -103,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189
		}
	},
	{#State 261
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -96,
			")" => -96,
			'OP18_TERNARY' => -96,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => -96,
			";" => -96,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP08_STRING_CAT' => -96,
			"}" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP23_LOGICAL_AND' => -96,
			"]" => -96,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => -96
		}
	},
	{#State 262
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -94,
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 197,
			";" => -94,
			"}" => -94,
			'OP08_STRING_CAT' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			"]" => -94,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -94
		}
	},
	{#State 263
		ACTIONS => {
			'OP17_LIST_RANGE' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			"]" => -101,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP15_LOGICAL_AND' => -101,
			";" => -101,
			'OP06_REGEX_MATCH' => 197,
			"}" => -101,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -101
		}
	},
	{#State 264
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -100,
			'OP04_MATH_POW' => 190,
			")" => -100,
			'OP18_TERNARY' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => -100,
			'OP08_STRING_CAT' => 186,
			"}" => -100,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP07_STRING_REPEAT' => 184,
			"]" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100
		}
	},
	{#State 265
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			"]" => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			";" => -89,
			'OP06_REGEX_MATCH' => -89,
			"}" => -89,
			'OP08_STRING_CAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 266
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP23_LOGICAL_AND' => -102,
			"]" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 184,
			";" => -102,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			"}" => -102,
			")" => -102,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -102
		}
	},
	{#State 267
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			")" => -109,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			";" => -109,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -109,
			"}" => -109,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => 193,
			'OP21_LIST_COMMA' => -109,
			'OP23_LOGICAL_AND' => -109,
			"]" => -109,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185
		}
	},
	{#State 268
		ACTIONS => {
			'OP08_STRING_CAT' => 186,
			"}" => -106,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP06_REGEX_MATCH' => 197,
			";" => -106,
			'OP15_LOGICAL_AND' => 196,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => undef,
			'OP21_LIST_COMMA' => -106,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -106,
			")" => -106
		}
	},
	{#State 269
		ACTIONS => {
			'OP18_TERNARY' => 182,
			")" => -110,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP17_LIST_RANGE' => 193,
			'OP21_LIST_COMMA' => -110,
			'OP23_LOGICAL_AND' => 192,
			"]" => -110,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP06_REGEX_MATCH' => 197,
			";" => -110,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_STRING_CAT' => 186,
			"}" => -110
		}
	},
	{#State 270
		ACTIONS => {
			'OP21_LIST_COMMA' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP15_LOGICAL_AND' => -97,
			";" => -97,
			'OP06_REGEX_MATCH' => 197,
			"}" => -97,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -97,
			")" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => -97
		}
	},
	{#State 271
		ACTIONS => {
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			")" => -104,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 190,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			"}" => -104,
			'OP06_REGEX_MATCH' => 197,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP14_BITWISE_OR_XOR' => 185,
			"]" => -104,
			'OP07_STRING_REPEAT' => 184,
			'OP21_LIST_COMMA' => -104,
			'OP17_LIST_RANGE' => -104
		}
	},
	{#State 272
		DEFAULT => -92
	},
	{#State 273
		ACTIONS => {
			'OP17_LIST_RANGE' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP14_BITWISE_OR_XOR' => 185,
			"]" => -105,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP15_LOGICAL_AND' => 196,
			";" => -105,
			'OP06_REGEX_MATCH' => 197,
			"}" => -105,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -105,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 274
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 326,
			";" => 327,
			'OP19_VARIABLE_ASSIGN' => 328
		}
	},
	{#State 275
		ACTIONS => {
			";" => 329
		}
	},
	{#State 276
		ACTIONS => {
			";" => 330
		}
	},
	{#State 277
		ACTIONS => {
			";" => 331
		}
	},
	{#State 278
		DEFAULT => -123
	},
	{#State 279
		ACTIONS => {
			'FHREF_SYMBOL' => 332
		}
	},
	{#State 280
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'ARGV' => 154,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			'OP01_QW' => 152
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'ListElement' => 153,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 157,
			'TypeInner' => 149,
			'ListElements' => 333
		}
	},
	{#State 281
		DEFAULT => -142
	},
	{#State 282
		ACTIONS => {
			"\@{" => 124,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'ARGV' => 154,
			'OP01_QW' => 152,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ListElements' => 334,
			'TypeInner' => 149,
			'ArrayReference' => 108,
			'SubExpression' => 157,
			'Operator' => 134,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128,
			'ListElement' => 153
		}
	},
	{#State 283
		ACTIONS => {
			'OP21_LIST_COMMA' => 335
		}
	},
	{#State 284
		ACTIONS => {
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 146,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 336,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 285
		DEFAULT => -174
	},
	{#State 286
		ACTIONS => {
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD' => 338,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_OPEN' => 116,
			'SELF' => 117
		},
		GOTOS => {
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'Operator' => 134,
			'SubExpression' => 337,
			'ArrayReference' => 108,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 287
		ACTIONS => {
			"}" => 339
		}
	},
	{#State 288
		DEFAULT => -199
	},
	{#State 289
		DEFAULT => -91
	},
	{#State 290
		DEFAULT => -144
	},
	{#State 291
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			";" => -143,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP17_LIST_RANGE' => 193,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP23_LOGICAL_AND' => 192,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			")" => -143,
			'OP11_COMPARE_LT_GT' => 189
		}
	},
	{#State 292
		DEFAULT => -184
	},
	{#State 293
		DEFAULT => -145
	},
	{#State 294
		ACTIONS => {
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'ARGV' => 154,
			'OP01_QW' => 152,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			"\@{" => 124,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			")" => -127,
			"%{" => 93,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146
		},
		GOTOS => {
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'OPTIONAL-35' => 341,
			'Literal' => 125,
			'TypeInner' => 149,
			'ListElements' => 340,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 157,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128,
			'ListElement' => 153
		}
	},
	{#State 295
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP23_LOGICAL_AND' => 192,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP06_REGEX_MATCH' => 197,
			";" => -185,
			'OP15_LOGICAL_AND' => 196,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			")" => -185,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 296
		DEFAULT => -196
	},
	{#State 297
		DEFAULT => -124
	},
	{#State 298
		ACTIONS => {
			")" => 342
		}
	},
	{#State 299
		DEFAULT => -133
	},
	{#State 300
		DEFAULT => -77
	},
	{#State 301
		ACTIONS => {
			'TYPE_METHOD' => 343,
			'WORD_SCOPED' => 53,
			'WORD' => 55,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 302
		ACTIONS => {
			";" => 344
		}
	},
	{#State 303
		DEFAULT => -76
	},
	{#State 304
		DEFAULT => -59
	},
	{#State 305
		ACTIONS => {
			"}" => 347,
			'WORD' => 345
		},
		GOTOS => {
			'HashEntryProperties' => 346
		}
	},
	{#State 306
		DEFAULT => -48
	},
	{#State 307
		ACTIONS => {
			")" => 348,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-19' => 350
		}
	},
	{#State 308
		DEFAULT => -225
	},
	{#State 309
		DEFAULT => -119
	},
	{#State 310
		ACTIONS => {
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'ARGV' => 154,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_QW' => 152
		},
		GOTOS => {
			'TypeInner' => 149,
			'SubExpression' => 157,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'ListElement' => 351,
			'ArrayDereference' => 128,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 311
		DEFAULT => -187
	},
	{#State 312
		ACTIONS => {
			'WORD' => 352
		}
	},
	{#State 313
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 354
		}
	},
	{#State 314
		DEFAULT => -215
	},
	{#State 315
		DEFAULT => -208
	},
	{#State 316
		DEFAULT => -210
	},
	{#State 317
		ACTIONS => {
			'SELF' => 117,
			"%{" => 93,
			'ENV' => 170,
			'WORD' => 168,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 137
		},
		GOTOS => {
			'Literal' => 169,
			'VariableSymbolOrSelf' => 123,
			'HashEntry' => 355,
			'HashDereference' => 173,
			'Variable' => 166,
			'VariableOrLiteralOrWord' => 172
		}
	},
	{#State 318
		DEFAULT => -201
	},
	{#State 319
		ACTIONS => {
			'OP01_NAMED' => 146,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 124,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 356,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 357
		}
	},
	{#State 321
		ACTIONS => {
			'VARIABLE_SYMBOL' => 358
		}
	},
	{#State 322
		ACTIONS => {
			'VARIABLE_SYMBOL' => 359
		}
	},
	{#State 323
		ACTIONS => {
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			")" => 360,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189
		}
	},
	{#State 324
		ACTIONS => {
			'VARIABLE_SYMBOL' => 361
		}
	},
	{#State 325
		ACTIONS => {
			'VARIABLE_SYMBOL' => 137,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'SELF' => 117
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Literal' => 255,
			'VariableOrLiteral' => 362,
			'Variable' => 256
		}
	},
	{#State 326
		ACTIONS => {
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP01_CLOSE' => 105,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122
		},
		GOTOS => {
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'Operator' => 134,
			'SubExpression' => 363,
			'ArrayReference' => 108,
			'Variable' => 147,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 327
		DEFAULT => -180
	},
	{#State 328
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 367,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'FHREF_SYMBOL_IN' => 290,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'STDIN' => 293,
			'OP10_NAMED_UNARY_SCOLON' => 365,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121
		},
		GOTOS => {
			'SubExpression' => 291,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'SubExpressionOrInput' => 366,
			'OpNamedScolonOrSubExpIn' => 364,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132
		}
	},
	{#State 329
		DEFAULT => -183
	},
	{#State 330
		DEFAULT => -116
	},
	{#State 331
		DEFAULT => -117
	},
	{#State 332
		ACTIONS => {
			'OP21_LIST_COMMA' => 368
		}
	},
	{#State 333
		ACTIONS => {
			";" => 369
		}
	},
	{#State 334
		ACTIONS => {
			")" => 370
		}
	},
	{#State 335
		ACTIONS => {
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'OP01_QW' => 152,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'ARGV' => 154,
			'VARIABLE_SYMBOL' => 137,
			'MY' => 156,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'ArrayDereference' => 128,
			'ListElement' => 153,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 157,
			'Operator' => 134,
			'TypeInner' => 149,
			'ListElements' => 371
		}
	},
	{#State 336
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			"]" => 372,
			'OP23_LOGICAL_AND' => 192,
			'OP17_LIST_RANGE' => 193,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP11_COMPARE_LT_GT' => 189,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183
		}
	},
	{#State 337
		ACTIONS => {
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			"}" => 373
		}
	},
	{#State 338
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -216,
			'LPAREN' => -216,
			"}" => 374
		}
	},
	{#State 339
		DEFAULT => -200
	},
	{#State 340
		DEFAULT => -126
	},
	{#State 341
		ACTIONS => {
			")" => 375
		}
	},
	{#State 342
		DEFAULT => -131
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 344
		DEFAULT => -61
	},
	{#State 345
		ACTIONS => {
			'OP20_HASH_FATARROW' => 377
		}
	},
	{#State 346
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 378
		}
	},
	{#State 347
		ACTIONS => {
			";" => 379
		}
	},
	{#State 348
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 349
		ACTIONS => {
			'MY' => 381
		}
	},
	{#State 350
		DEFAULT => -50
	},
	{#State 351
		DEFAULT => -186
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 382
		}
	},
	{#State 353
		ACTIONS => {
			'OP01_NAMED_VOID' => 92,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 96,
			"%{" => 93,
			"if" => 90,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"for" => -150,
			'MY' => 111,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP19_LOOP_CONTROL' => 114,
			'OP01_PRINT' => 112,
			'OP10_NAMED_UNARY_SCOLON' => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'LITERAL_NUMBER' => 86,
			"foreach" => -150,
			'OP01_CLOSE' => 105,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 118,
			'VARIABLE_SYMBOL' => 137,
			"while" => -150,
			'LBRACKET' => 135,
			'OP01_NAMED_SCOLON' => 136,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 125,
			'PLUS-42' => 384,
			'Expression' => 98,
			'OperatorVoid' => 127,
			'Operation' => 383,
			'VariableSymbolOrSelf' => 123,
			'Statement' => 119,
			'VariableModification' => 113,
			'WordScoped' => 138,
			'ArrayReference' => 108,
			'SubExpression' => 106,
			'Operator' => 134,
			'PAREN-36' => 109,
			'OPTIONAL-37' => 104,
			'LoopLabel' => 129,
			'Conditional' => 133,
			'HashReference' => 132,
			'Variable' => 131,
			'ArrayDereference' => 128,
			'VariableDeclaration' => 102
		}
	},
	{#State 354
		DEFAULT => -158,
		GOTOS => {
			'STAR-39' => 385
		}
	},
	{#State 355
		DEFAULT => -207
	},
	{#State 356
		ACTIONS => {
			'OP21_LIST_COMMA' => -203,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			"}" => -203,
			'OP08_STRING_CAT' => 186,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 357
		ACTIONS => {
			'LPAREN' => 386
		}
	},
	{#State 358
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 387
		}
	},
	{#State 359
		ACTIONS => {
			'LPAREN' => 388
		}
	},
	{#State 360
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 361
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 390
		}
	},
	{#State 362
		DEFAULT => -107
	},
	{#State 363
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP07_STRING_REPEAT' => 184,
			"]" => 391,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP23_LOGICAL_AND' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 364
		DEFAULT => -181
	},
	{#State 365
		DEFAULT => -239
	},
	{#State 366
		ACTIONS => {
			";" => 392
		}
	},
	{#State 367
		DEFAULT => -238
	},
	{#State 368
		ACTIONS => {
			'LITERAL_STRING' => 393
		}
	},
	{#State 369
		DEFAULT => -121
	},
	{#State 370
		DEFAULT => -82
	},
	{#State 371
		ACTIONS => {
			")" => 394
		}
	},
	{#State 372
		DEFAULT => -177
	},
	{#State 373
		DEFAULT => -178
	},
	{#State 374
		DEFAULT => -179
	},
	{#State 375
		DEFAULT => -132
	},
	{#State 376
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 377
		ACTIONS => {
			'MY' => 396
		},
		GOTOS => {
			'TypeInnerProperties' => 397
		}
	},
	{#State 378
		ACTIONS => {
			"}" => 399,
			'OP21_LIST_COMMA' => 398
		},
		GOTOS => {
			'PAREN-25' => 400
		}
	},
	{#State 379
		DEFAULT => -66
	},
	{#State 380
		ACTIONS => {
			"\@_;" => 401
		}
	},
	{#State 381
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55,
			'WORD_SCOPED' => 53
		},
		GOTOS => {
			'Type' => 402
		}
	},
	{#State 382
		DEFAULT => -222
	},
	{#State 383
		DEFAULT => -172
	},
	{#State 384
		ACTIONS => {
			"while" => -150,
			'VARIABLE_SYMBOL' => 137,
			'OP01_NAMED_SCOLON' => 136,
			'LBRACKET' => 135,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED' => 118,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 111,
			'OP22_LOGICAL_NEG' => 107,
			'OP19_LOOP_CONTROL' => 114,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_PRINT' => 112,
			'OP10_NAMED_UNARY_SCOLON' => 101,
			"}" => 404,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'OP01_CLOSE' => 105,
			'OP01_NAMED_VOID_SCOLON' => 103,
			'LITERAL_NUMBER' => 86,
			"foreach" => -150,
			'OP01_NAMED_VOID' => 92,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"%{" => 93,
			'WORD_UPPERCASE' => 96,
			"if" => 90,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"for" => -150
		},
		GOTOS => {
			'Statement' => 119,
			'VariableSymbolOrSelf' => 123,
			'Operation' => 403,
			'OperatorVoid' => 127,
			'Expression' => 98,
			'Literal' => 125,
			'HashDereference' => 95,
			'VariableDeclaration' => 102,
			'ArrayDereference' => 128,
			'Variable' => 131,
			'HashReference' => 132,
			'Conditional' => 133,
			'LoopLabel' => 129,
			'OPTIONAL-37' => 104,
			'PAREN-36' => 109,
			'SubExpression' => 106,
			'Operator' => 134,
			'ArrayReference' => 108,
			'WordScoped' => 138,
			'VariableModification' => 113
		}
	},
	{#State 385
		ACTIONS => {
			"undef" => -161,
			'OP10_NAMED_UNARY' => -161,
			'LPAREN' => -161,
			'OP01_NAMED' => -161,
			"elsif" => 405,
			"\@{" => -161,
			'OP03_MATH_INC_DEC' => -161,
			'WORD' => -161,
			'LITERAL_STRING' => -161,
			'OP05_MATH_NEG_LPAREN' => -161,
			'VARIABLE_SYMBOL' => -161,
			"while" => -161,
			'OP01_NAMED_SCOLON' => -161,
			'LBRACKET' => -161,
			"if" => -161,
			'OP01_NAMED_VOID_LPAREN' => -161,
			"for" => -161,
			'OP01_NAMED_VOID' => -161,
			'LBRACE' => -161,
			'WORD_SCOPED' => -161,
			'CONSTANT_CALL_SCOPED' => -161,
			'WORD_UPPERCASE' => -161,
			"%{" => -161,
			'' => -161,
			"}" => -161,
			'OP10_NAMED_UNARY_SCOLON' => -161,
			'OP19_LOOP_CONTROL_SCOLON' => -161,
			"else" => 409,
			'LITERAL_NUMBER' => -161,
			"foreach" => -161,
			'OP01_NAMED_VOID_SCOLON' => -161,
			'OP01_CLOSE' => -161,
			'MY' => -161,
			'OP05_LOGICAL_NEG' => -161,
			'OP22_LOGICAL_NEG' => -161,
			'OP01_OPEN' => -161,
			'SELF' => -161,
			'OP19_LOOP_CONTROL' => -161,
			'OP01_PRINT' => -161
		},
		GOTOS => {
			'PAREN-40' => 407,
			'OPTIONAL-41' => 408,
			'PAREN-38' => 406
		}
	},
	{#State 386
		ACTIONS => {
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 124,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 410,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 387
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => 412,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 135,
			'OP01_NAMED_SCOLON' => 411,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Expression' => 150,
			'OpNamedScolonOrSubExp' => 414,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'Operator' => 134,
			'SubExpression' => 413,
			'ArrayReference' => 108,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 388
		ACTIONS => {
			'OP01_QW' => 152,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 156,
			'VARIABLE_SYMBOL' => 137,
			'ARGV' => 154,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			"\@{" => 124,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ListElement' => 153,
			'ArrayDereference' => 128,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'Operator' => 134,
			'SubExpression' => 157,
			'ArrayReference' => 108,
			'ListElements' => 415,
			'TypeInner' => 149
		}
	},
	{#State 389
		DEFAULT => -169
	},
	{#State 390
		ACTIONS => {
			"\@{" => 124,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_NAMED' => 146,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'VARIABLE_SYMBOL' => 137,
			'FHREF_SYMBOL_IN' => 290,
			'OP05_LOGICAL_NEG' => 110,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'STDIN' => 293,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'SubExpression' => 291,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'SubExpressionOrInput' => 416,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147
		}
	},
	{#State 391
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 392
		DEFAULT => -240
	},
	{#State 393
		ACTIONS => {
			'OP21_LIST_COMMA' => 418
		}
	},
	{#State 394
		DEFAULT => -84
	},
	{#State 395
		ACTIONS => {
			'WORD' => -68,
			'LITERAL_STRING' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'LBRACKET' => -68,
			'OP01_NAMED_SCOLON' => -68,
			'VARIABLE_SYMBOL' => -68,
			"while" => -68,
			'OP01_NAMED' => -68,
			"undef" => -68,
			'OP10_NAMED_UNARY' => -68,
			'LPAREN' => -68,
			'LPAREN_MY' => 419,
			"\@{" => -68,
			'OP03_MATH_INC_DEC' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			"}" => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			'LITERAL_NUMBER' => -68,
			"foreach" => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP01_CLOSE' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'MY' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_PRINT' => -68,
			'SELF' => -68,
			'OP01_OPEN' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			"for" => -68,
			"if" => -68,
			'OP01_NAMED_VOID' => -68,
			'WORD_UPPERCASE' => -68,
			"%{" => -68,
			'LBRACE' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'WORD_SCOPED' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 420,
			'MethodArguments' => 421
		}
	},
	{#State 396
		ACTIONS => {
			'WORD' => 55,
			'WORD_SCOPED' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 422
		}
	},
	{#State 397
		DEFAULT => -206
	},
	{#State 398
		ACTIONS => {
			'WORD' => 345
		},
		GOTOS => {
			'HashEntryProperties' => 423
		}
	},
	{#State 399
		ACTIONS => {
			";" => 424
		}
	},
	{#State 400
		DEFAULT => -63
	},
	{#State 401
		DEFAULT => -52
	},
	{#State 402
		ACTIONS => {
			'VARIABLE_SYMBOL' => 425
		}
	},
	{#State 403
		DEFAULT => -171
	},
	{#State 404
		DEFAULT => -173
	},
	{#State 405
		ACTIONS => {
			'LPAREN' => 426
		}
	},
	{#State 406
		DEFAULT => -157
	},
	{#State 407
		DEFAULT => -160
	},
	{#State 408
		DEFAULT => -162
	},
	{#State 409
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 427
		}
	},
	{#State 410
		ACTIONS => {
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			'OP08_STRING_CAT' => 186,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 192,
			'OP17_LIST_RANGE' => 428
		}
	},
	{#State 411
		DEFAULT => -235
	},
	{#State 412
		DEFAULT => -236
	},
	{#State 413
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP06_REGEX_MATCH' => 197,
			";" => 429,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 414
		ACTIONS => {
			'VARIABLE_SYMBOL' => 430
		}
	},
	{#State 415
		ACTIONS => {
			")" => 431
		}
	},
	{#State 416
		ACTIONS => {
			")" => 432
		}
	},
	{#State 417
		ACTIONS => {
			"undef" => 433
		}
	},
	{#State 418
		ACTIONS => {
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			"\@{" => 124,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayDereference' => 128,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150,
			'ArrayReference' => 108,
			'SubExpression' => 434,
			'Operator' => 134
		}
	},
	{#State 419
		ACTIONS => {
			'WORD_SCOPED' => 53,
			'WORD' => 55,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 435
		}
	},
	{#State 420
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 436
		}
	},
	{#State 421
		DEFAULT => -67
	},
	{#State 422
		ACTIONS => {
			"\$TYPED_" => 437
		}
	},
	{#State 423
		DEFAULT => -62
	},
	{#State 424
		DEFAULT => -65
	},
	{#State 425
		DEFAULT => -49
	},
	{#State 426
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124
		},
		GOTOS => {
			'SubExpression' => 438,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'WordScoped' => 138,
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132
		}
	},
	{#State 427
		DEFAULT => -159
	},
	{#State 428
		ACTIONS => {
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			'OP01_NAMED' => 146,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"undef" => 122,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'OP01_CLOSE' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'Variable' => 147,
			'HashReference' => 132,
			'ArrayReference' => 108,
			'Operator' => 134,
			'SubExpression' => 439,
			'HashDereference' => 95,
			'Literal' => 125,
			'WordScoped' => 138,
			'Expression' => 150
		}
	},
	{#State 429
		DEFAULT => -237
	},
	{#State 430
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 440
		}
	},
	{#State 431
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 441
		}
	},
	{#State 432
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 433
		ACTIONS => {
			";" => 443
		}
	},
	{#State 434
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP04_MATH_POW' => 190,
			")" => -85,
			'OP18_TERNARY' => 182,
			'OP11_COMPARE_LT_GT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			";" => -85,
			"}" => -85,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => 195,
			'OP21_LIST_COMMA' => -85,
			'OP17_LIST_RANGE' => 193,
			'OP14_BITWISE_OR_XOR' => 185,
			"]" => -85,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -85
		}
	},
	{#State 435
		ACTIONS => {
			'SELF' => 444
		}
	},
	{#State 436
		ACTIONS => {
			"\@{" => 124,
			'OP03_MATH_INC_DEC' => 126,
			'OP01_NAMED' => 118,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			'OP01_NAMED_SCOLON' => 136,
			'LBRACKET' => 135,
			"while" => -150,
			'VARIABLE_SYMBOL' => 137,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 130,
			'OP01_NAMED_VOID' => 92,
			"%{" => 93,
			'WORD_UPPERCASE' => 96,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACE' => 99,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"for" => -150,
			"if" => 90,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'MY' => 111,
			'OP01_PRINT' => 112,
			'OP19_LOOP_CONTROL' => 114,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 101,
			"}" => 445,
			'OP01_NAMED_VOID_SCOLON' => 103,
			'OP01_CLOSE' => 105,
			"foreach" => -150,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 98,
			'OperatorVoid' => 127,
			'Operation' => 446,
			'VariableSymbolOrSelf' => 123,
			'Statement' => 119,
			'VariableModification' => 113,
			'WordScoped' => 138,
			'SubExpression' => 106,
			'Operator' => 134,
			'ArrayReference' => 108,
			'PAREN-36' => 109,
			'OPTIONAL-37' => 104,
			'LoopLabel' => 129,
			'Variable' => 131,
			'HashReference' => 132,
			'Conditional' => 133,
			'ArrayDereference' => 128,
			'VariableDeclaration' => 102
		}
	},
	{#State 437
		ACTIONS => {
			'WORD' => 447
		}
	},
	{#State 438
		ACTIONS => {
			'OP18_TERNARY' => 182,
			")" => 448,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186
		}
	},
	{#State 439
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => 186,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP23_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP07_STRING_REPEAT' => 184,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 191,
			'OP08_MATH_ADD_SUB' => 183,
			'OP11_COMPARE_LT_GT' => 189,
			")" => 449,
			'OP18_TERNARY' => -106,
			'OP04_MATH_POW' => 190
		}
	},
	{#State 440
		ACTIONS => {
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146,
			'LBRACE' => 99,
			'WORD_SCOPED' => 26,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 151,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			"\@{" => 124,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'OP10_NAMED_UNARY_SCOLON' => 412,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_NAMED_SCOLON' => 411,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135
		},
		GOTOS => {
			'ArrayDereference' => 128,
			'VariableSymbolOrSelf' => 123,
			'HashReference' => 132,
			'Variable' => 147,
			'Operator' => 134,
			'SubExpression' => 413,
			'ArrayReference' => 108,
			'Literal' => 125,
			'HashDereference' => 95,
			'Expression' => 150,
			'OpNamedScolonOrSubExp' => 450,
			'WordScoped' => 138
		}
	},
	{#State 441
		DEFAULT => -168
	},
	{#State 442
		DEFAULT => -170
	},
	{#State 443
		DEFAULT => -182
	},
	{#State 444
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 451
		}
	},
	{#State 445
		ACTIONS => {
			";" => 452
		}
	},
	{#State 446
		DEFAULT => -69
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 454,
			'OP02_ARRAY_THINARROW' => 453
		}
	},
	{#State 448
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 449
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 456
		}
	},
	{#State 450
		ACTIONS => {
			"undef" => 122,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED' => 146,
			"\@{" => 124,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_STRING' => 87,
			'WORD' => 27,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'SELF' => 117,
			'OP01_OPEN' => 116
		},
		GOTOS => {
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'VariableModification' => 457,
			'SubExpression' => 458,
			'Operator' => 134,
			'ArrayReference' => 108,
			'HashReference' => 132,
			'Variable' => 131,
			'VariableSymbolOrSelf' => 123,
			'SubExpressionOrVarMod' => 459,
			'ArrayDereference' => 128
		}
	},
	{#State 451
		ACTIONS => {
			")" => 460,
			'OP21_LIST_COMMA' => 461
		},
		GOTOS => {
			'PAREN-29' => 462
		}
	},
	{#State 452
		DEFAULT => -71
	},
	{#State 453
		ACTIONS => {
			'OP01_NAMED' => 146,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"undef" => 122,
			"%{" => 93,
			'OP03_MATH_INC_DEC' => 126,
			'WORD_UPPERCASE' => 151,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'LBRACE' => 99,
			"\@{" => 124,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 130,
			'LITERAL_NUMBER' => 86,
			'WORD' => 27,
			'LITERAL_STRING' => 87,
			'OP01_OPEN' => 116,
			'SELF' => 117,
			'LBRACKET' => 135,
			'OP22_LOGICAL_NEG' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'VARIABLE_SYMBOL' => 137
		},
		GOTOS => {
			'SubExpression' => 463,
			'Operator' => 134,
			'ArrayReference' => 108,
			'Expression' => 150,
			'WordScoped' => 138,
			'Literal' => 125,
			'HashDereference' => 95,
			'ArrayDereference' => 128,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123
		}
	},
	{#State 454
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 130,
			'WORD' => 27,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 137,
			'OP05_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG' => 107,
			'LBRACKET' => 135,
			'SELF' => 117,
			'OP01_OPEN' => 116,
			"undef" => 122,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP01_NAMED' => 146,
			"\@{" => 124,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 151,
			'OP03_MATH_INC_DEC' => 126,
			"%{" => 93
		},
		GOTOS => {
			'WordScoped' => 138,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 125,
			'ArrayReference' => 108,
			'SubExpression' => 464,
			'Operator' => 134,
			'HashReference' => 132,
			'Variable' => 147,
			'VariableSymbolOrSelf' => 123,
			'ArrayDereference' => 128
		}
	},
	{#State 455
		DEFAULT => -156
	},
	{#State 456
		DEFAULT => -166
	},
	{#State 457
		DEFAULT => -147
	},
	{#State 458
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP09_BITWISE_SHIFT' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -146,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191
		}
	},
	{#State 459
		ACTIONS => {
			")" => 465
		}
	},
	{#State 460
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 466
		}
	},
	{#State 461
		ACTIONS => {
			'MY' => 467
		}
	},
	{#State 462
		DEFAULT => -73
	},
	{#State 463
		ACTIONS => {
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 198,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => 193,
			'OP23_LOGICAL_AND' => 192,
			'OP07_STRING_REPEAT' => 184,
			"]" => 468,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 189
		}
	},
	{#State 464
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 182,
			'OP11_COMPARE_LT_GT' => 189,
			'OP08_MATH_ADD_SUB' => 183,
			'OP13_BITWISE_AND' => 191,
			'OP17_LIST_RANGE' => 193,
			'OP21_LIST_COMMA' => -223,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 185,
			'OP23_LOGICAL_AND' => 192,
			'OP12_COMPARE_EQ_NE' => 188,
			'OP16_LOGICAL_OR' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP06_REGEX_MATCH' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP08_STRING_CAT' => 186,
			"}" => -223,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 195
		}
	},
	{#State 465
		ACTIONS => {
			'LBRACE' => 353
		},
		GOTOS => {
			'CodeBlock' => 469
		}
	},
	{#State 466
		ACTIONS => {
			"\@_;" => 470
		}
	},
	{#State 467
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD_SCOPED' => 53,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 471
		}
	},
	{#State 468
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 472
		}
	},
	{#State 469
		DEFAULT => -167
	},
	{#State 470
		DEFAULT => -75
	},
	{#State 471
		ACTIONS => {
			'VARIABLE_SYMBOL' => 473
		}
	},
	{#State 472
		ACTIONS => {
			"undef" => 474
		}
	},
	{#State 473
		DEFAULT => -72
	},
	{#State 474
		DEFAULT => -224
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6786 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7652 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7659 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7702 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7713 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7735 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7746 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7768 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7782 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7807 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7862 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7873 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7895 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7906 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7917 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7928 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7939 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7950 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7961 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7983 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7994 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8005 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8016 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8023 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8030 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8037 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8048 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8059 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8092 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8113 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8127 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8134 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_162
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8145 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8156 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8167 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8178 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8189 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8200 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_168
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8211 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8222 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8233 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8240 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8272 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8294 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8305 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8316 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8327 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8338 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8349 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8360 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8371 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8382 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8389 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8396 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8414 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8436 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8447 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8465 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8472 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8483 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8490 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8526 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8533 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8544 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8555 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8566 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_206
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8577 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8584 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8591 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8598 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8609 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8627 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8634 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8645 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8667 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8678 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8689 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8700 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8711 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8722 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8733 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8744 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8755 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_225
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8766 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8777 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8788 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8799 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_229
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8810 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_230
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8821 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8832 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8843 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8854 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8865 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_235
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8876 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8887 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8898 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_238
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8909 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8920 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8931 lib/RPerl/Grammar.pm
	]
],
#line 8934 lib/RPerl/Grammar.pm
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
         'VariableOrLiteralOrWord_228', 
         'VariableOrLiteralOrWord_229', 
         'VariableOrLiteralOrWord_230', 
         'VariableSymbolOrSelf_231', 
         'VariableSymbolOrSelf_232', 
         'Literal_233', 
         'Literal_234', 
         'OpNamedScolonOrSubExp_235', 
         'OpNamedScolonOrSubExp_236', 
         'OpNamedScolonOrSubExp_237', 
         'OpNamedScolonOrSubExpIn_238', 
         'OpNamedScolonOrSubExpIn_239', 
         'OpNamedScolonOrSubExpIn_240', );
  $self;
}

#line 232 "lib/RPerl/Grammar.eyp"


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
Properties_65 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
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
HashEntry_203 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_205 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_206 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
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
TypeInner_222 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerProperties_223 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_224 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_225 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_226 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_227 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_228 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_229 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_230 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
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
};

    1;
}

=for None

=cut


#line 9362 lib/RPerl/Grammar.pm



1;
