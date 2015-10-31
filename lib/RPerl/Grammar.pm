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
    our $VERSION = 0.002_301;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|package|\$TYPED_|foreach|undef|while|elsif|else|for|our|\@_\;|\@\{|if|\%\{|\]|\)|\}|\;)}gc and return ($1, $1);

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
			'SHEBANG' => 4,
			'USE_RPERL' => -20,
			"## no critic qw(" => 1,
			"package" => -20
		},
		GOTOS => {
			'CompileUnit' => 7,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 9,
			'PLUS-2' => 3,
			'Critic' => 2,
			'Program' => 5,
			'PAREN-1' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-16' => 11
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => -20,
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'PAREN-1' => 12,
			'Critic' => 2,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 9
		}
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 13,
			'OPTIONAL-3' => 14
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'' => 15
		}
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => 17,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 16
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => -27,
			'USE' => -27,
			"use constant" => -27,
			"use parent qw(" => 21,
			"our" => -27
		},
		GOTOS => {
			'Class' => 19,
			'Package' => 22,
			'STAR-11' => 20,
			'Module' => 18
		}
	},
	{#State 10
		DEFAULT => -39
	},
	{#State 11
		ACTIONS => {
			")" => 24,
			'WORD' => 23
		}
	},
	{#State 12
		DEFAULT => -2
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		ACTIONS => {
			"package" => 26
		}
	},
	{#State 17
		DEFAULT => -21
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		ACTIONS => {
			"use constant" => -29,
			'USE' => -29,
			"## no critic qw(" => 1,
			"our" => -29
		},
		GOTOS => {
			'Critic' => 27,
			'STAR-12' => 28
		}
	},
	{#State 21
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 22
		DEFAULT => -24
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 33
		}
	},
	{#State 26
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 34
		}
	},
	{#State 27
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			'USE' => 37,
			"use constant" => -31,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 36
		}
	},
	{#State 29
		ACTIONS => {
			")" => 38
		}
	},
	{#State 30
		DEFAULT => -217
	},
	{#State 31
		DEFAULT => -216
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
		ACTIONS => {
			"use constant" => 44,
			"our" => 46
		},
		GOTOS => {
			'PLUS-14' => 43,
			'Constant' => 45,
			'Subroutine' => 42
		}
	},
	{#State 36
		DEFAULT => -28
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'USE_RPERL_AFTER' => 50,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"use constant" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"## no critic qw(" => 1,
			'SELF' => -11,
			"for" => -11,
			"\@{" => -11,
			"undef" => -11,
			'USE' => -11,
			'MY' => -11,
			'WORD' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"foreach" => -11,
			"while" => -11,
			"our" => -11,
			'LPAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_UPPERCASE' => -11,
			"if" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'LBRACKET' => -11
		},
		GOTOS => {
			'Critic' => 51,
			'STAR-5' => 52
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
		DEFAULT => -33
	},
	{#State 43
		ACTIONS => {
			'LITERAL_NUMBER' => 54,
			"our" => 46
		},
		GOTOS => {
			'Subroutine' => 55
		}
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
			'WORD' => 59,
			'TYPE_INTEGER' => 60,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 47
		ACTIONS => {
			";" => 62,
			'OP01_QW' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'USE' => 37
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
		DEFAULT => -8
	},
	{#State 52
		ACTIONS => {
			'MY' => -13,
			'WORD' => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED' => -13,
			'USE' => 37,
			"undef" => -13,
			'SELF' => -13,
			"\@{" => -13,
			"for" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"use constant" => -13,
			'LBRACE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'WORD_UPPERCASE' => -13,
			"if" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LPAREN' => -13,
			"while" => -13,
			"our" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_PRINT' => -13,
			'WORD_SCOPED' => -13,
			"%{" => -13,
			'OP05_LOGICAL_NEG' => -13
		},
		GOTOS => {
			'Include' => 65,
			'STAR-6' => 66
		}
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
		DEFAULT => -32
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 58
		DEFAULT => -220
	},
	{#State 59
		DEFAULT => -219
	},
	{#State 60
		DEFAULT => -221
	},
	{#State 61
		ACTIONS => {
			";" => 70
		}
	},
	{#State 62
		DEFAULT => -41
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
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'WORD' => -15,
			'MY' => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED' => -15,
			'SELF' => -15,
			"\@{" => -15,
			"for" => -15,
			"undef" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 44,
			'LBRACE' => -15,
			'OP01_CLOSE' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'LBRACKET' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_UPPERCASE' => -15,
			"if" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"foreach" => -15,
			"while" => -15,
			"our" => -15,
			'LPAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'WORD_SCOPED' => -15,
			"%{" => -15
		},
		GOTOS => {
			'STAR-7' => 73,
			'Constant' => 74
		}
	},
	{#State 67
		DEFAULT => -34
	},
	{#State 68
		ACTIONS => {
			'MY' => 76
		},
		GOTOS => {
			'TypeInnerConstant' => 75
		}
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 70
		DEFAULT => -42
	},
	{#State 71
		ACTIONS => {
			"our hashref \$properties" => -56,
			"## no critic qw(" => 1,
			'USE' => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 78,
			'Critic' => 79
		}
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"our" => 46,
			"while" => -150,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => 127,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_PRINT' => 123,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED_VOID_SCOLON' => 126,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 130,
			'LBRACKET' => 108,
			'OP01_NAMED_SCOLON' => 114,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 119,
			"if" => 118,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'LITERAL_STRING' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'OP01_CLOSE' => 99,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP01_NAMED_VOID' => 106,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 83,
			'WORD' => 31,
			'MY' => 84,
			"undef" => 86,
			"\@{" => 89,
			"for" => -150,
			'SELF' => 88
		},
		GOTOS => {
			'Expression' => 103,
			'LoopLabel' => 100,
			'Subroutine' => 101,
			'WordScoped' => 131,
			'Conditional' => 105,
			'Variable' => 104,
			'Statement' => 122,
			'PLUS-8' => 91,
			'ArrayDereference' => 93,
			'Operation' => 98,
			'VariableModification' => 124,
			'PAREN-36' => 113,
			'OPTIONAL-37' => 85,
			'VariableSymbolOrSelf' => 87,
			'OperatorVoid' => 90,
			'VariableDeclaration' => 115,
			'HashReference' => 109,
			'SubExpression' => 80,
			'Literal' => 110,
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111
		}
	},
	{#State 74
		DEFAULT => -12
	},
	{#State 75
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'Literal' => 132
		}
	},
	{#State 76
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 133
		}
	},
	{#State 77
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"foreach" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_PRINT' => -45,
			'OP10_NAMED_UNARY' => -45,
			'LPAREN' => -45,
			"while" => -45,
			"}" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'WORD_SCOPED' => -45,
			"%{" => -45,
			'LBRACKET' => -45,
			"if" => -45,
			'WORD_UPPERCASE' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP01_CLOSE' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LBRACE' => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'LITERAL_STRING' => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_NAMED_VOID' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'MY' => -45,
			'WORD' => -45,
			'OP01_NAMED' => -45,
			'OP01_OPEN' => -45,
			"\@{" => -45,
			'LPAREN_MY' => 135,
			"for" => -45,
			'SELF' => -45,
			"undef" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 134,
			'SubroutineArguments' => 136
		}
	},
	{#State 78
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 37,
			"use constant" => -58
		},
		GOTOS => {
			'STAR-23' => 137,
			'Include' => 138
		}
	},
	{#State 79
		DEFAULT => -53
	},
	{#State 80
		ACTIONS => {
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 81
		DEFAULT => -141
	},
	{#State 82
		ACTIONS => {
			'MY' => 156
		}
	},
	{#State 83
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"undef" => 86,
			'MY' => 162,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'ARGV' => 164,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121
		},
		GOTOS => {
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 161,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'ListElement' => 165,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81
		}
	},
	{#State 84
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 60,
			'WORD' => 59,
			'TYPE_FHREF' => 168
		},
		GOTOS => {
			'Type' => 167
		}
	},
	{#State 85
		ACTIONS => {
			"for" => 169,
			"foreach" => 173,
			"while" => 174
		},
		GOTOS => {
			'LoopWhile' => 171,
			'Loop' => 172,
			'LoopForEach' => 170,
			'LoopFor' => 175
		}
	},
	{#State 86
		DEFAULT => -135
	},
	{#State 87
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 176
		}
	},
	{#State 88
		DEFAULT => -232
	},
	{#State 89
		ACTIONS => {
			'LBRACKET' => -198,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'MY' => 162
		},
		GOTOS => {
			'Variable' => 177,
			'VariableSymbolOrSelf' => 87,
			'OPTIONAL-47' => 179,
			'TypeInner' => 178
		}
	},
	{#State 90
		DEFAULT => -153
	},
	{#State 91
		ACTIONS => {
			"undef" => 86,
			"for" => -150,
			"\@{" => 89,
			'SELF' => 88,
			'MY' => 84,
			'WORD' => 31,
			'OP01_NAMED' => 83,
			'OP01_OPEN' => 82,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP01_NAMED_VOID' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'' => -18,
			'LITERAL_STRING' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_NAMED_SCOLON' => 114,
			"if" => 118,
			'WORD_UPPERCASE' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 116,
			'LBRACKET' => 108,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 130,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			"while" => -150,
			'OP03_MATH_INC_DEC' => 128,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => 127,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_PRINT' => 123
		},
		GOTOS => {
			'OPTIONAL-37' => 85,
			'PAREN-36' => 113,
			'VariableDeclaration' => 115,
			'OperatorVoid' => 90,
			'VariableSymbolOrSelf' => 87,
			'Literal' => 110,
			'SubExpression' => 80,
			'HashReference' => 109,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'LoopLabel' => 100,
			'Expression' => 103,
			'Variable' => 104,
			'Conditional' => 105,
			'WordScoped' => 131,
			'ArrayDereference' => 93,
			'Statement' => 122,
			'VariableModification' => 124,
			'Operation' => 180
		}
	},
	{#State 92
		DEFAULT => -234
	},
	{#State 93
		DEFAULT => -139
	},
	{#State 94
		DEFAULT => -80
	},
	{#State 95
		ACTIONS => {
			'WORD' => 185,
			'ENV' => 182,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 107,
			'SELF' => 88,
			"}" => 183,
			'VARIABLE_SYMBOL' => 116,
			"%{" => 129
		},
		GOTOS => {
			'Literal' => 181,
			'HashEntry' => 186,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 188,
			'VariableOrLiteralOrWord' => 187,
			'HashDereference' => 184
		}
	},
	{#State 96
		ACTIONS => {
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 189,
			'HashReference' => 109,
			'Literal' => 110,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 97
		DEFAULT => -122
	},
	{#State 98
		DEFAULT => -17
	},
	{#State 99
		ACTIONS => {
			'FHREF_SYMBOL' => 190
		}
	},
	{#State 100
		ACTIONS => {
			'COLON' => 191
		}
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		DEFAULT => -130
	},
	{#State 103
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP18_TERNARY' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP04_MATH_POW' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			";" => 192,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP08_STRING_CAT' => -134,
			'OP09_BITWISE_SHIFT' => -134
		}
	},
	{#State 104
		ACTIONS => {
			'OP23_LOGICAL_AND' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			")" => -137,
			'OP03_MATH_INC_DEC' => 195,
			'OP08_STRING_CAT' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP18_TERNARY' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP04_MATH_POW' => -137,
			'OP19_VARIABLE_ASSIGN' => 193,
			'OP11_COMPARE_LT_GT' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 194,
			'OP13_BITWISE_AND' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP02_METHOD_THINARROW' => 196,
			'OP08_MATH_ADD_SUB' => -137,
			'OP06_REGEX_MATCH' => -137
		}
	},
	{#State 105
		DEFAULT => -151
	},
	{#State 106
		ACTIONS => {
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			"undef" => 86,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 108,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'MY' => 162,
			'WORD' => 31
		},
		GOTOS => {
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ListElement' => 198,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'ListElements' => 199
		}
	},
	{#State 107
		DEFAULT => -233
	},
	{#State 108
		ACTIONS => {
			"]" => -195,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'LBRACKET' => 108,
			'MY' => 162,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'ListElement' => 198,
			'Operator' => 112,
			'OPTIONAL-46' => 200,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'Literal' => 110,
			'SubExpression' => 197,
			'HashReference' => 109,
			'Variable' => 158,
			'ListElements' => 201,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 109
		DEFAULT => -140
	},
	{#State 110
		DEFAULT => -136
	},
	{#State 111
		DEFAULT => -138
	},
	{#State 112
		DEFAULT => -128
	},
	{#State 113
		DEFAULT => -149
	},
	{#State 114
		DEFAULT => -79
	},
	{#State 115
		DEFAULT => -154
	},
	{#State 116
		DEFAULT => -231
	},
	{#State 117
		ACTIONS => {
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'HashReference' => 109,
			'SubExpression' => 202,
			'Literal' => 110,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 118
		ACTIONS => {
			'LPAREN' => 203
		}
	},
	{#State 119
		ACTIONS => {
			'COLON' => -218,
			'LPAREN' => 204
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'OP07_STRING_REPEAT' => -99,
			"\@{" => 89,
			'SELF' => 88,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_CLOSE' => 99,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'LITERAL_STRING' => 92,
			'OP23_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'LITERAL_NUMBER' => 107,
			"]" => -99,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP15_LOGICAL_AND' => -99,
			'OP13_BITWISE_AND' => -99,
			'LBRACKET' => 108,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'VARIABLE_SYMBOL' => 116,
			'OP06_REGEX_MATCH' => -99,
			'WORD_UPPERCASE' => 166,
			'OP08_MATH_ADD_SUB' => -99,
			'OP22_LOGICAL_NEG' => 117,
			'OP09_BITWISE_SHIFT' => -99,
			'OP08_STRING_CAT' => -99,
			'OP03_MATH_INC_DEC' => 128,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP10_NAMED_UNARY' => 120,
			'OP21_LIST_COMMA' => -99,
			'LPAREN' => 121,
			"}" => -99,
			'OP05_LOGICAL_NEG' => 130,
			'OP04_MATH_POW' => -99,
			'WORD_SCOPED' => 30,
			"%{" => 129
		},
		GOTOS => {
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 205,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158
		}
	},
	{#State 121
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 208,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_PRINT' => 206,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 207,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 122
		DEFAULT => -81
	},
	{#State 123
		ACTIONS => {
			'WORD_UPPERCASE' => -113,
			'OP22_LOGICAL_NEG' => -113,
			"\@{" => -113,
			'SELF' => -113,
			'FHREF_SYMBOL_BRACES' => 210,
			'VARIABLE_SYMBOL' => -113,
			'OP01_QW' => -113,
			"undef" => -113,
			'WORD' => -113,
			'MY' => -113,
			'OP01_NAMED' => -113,
			'OP01_OPEN' => -113,
			'STDOUT_STDERR' => 209,
			'LBRACKET' => -113,
			'LITERAL_NUMBER' => -113,
			'OP05_LOGICAL_NEG' => -113,
			'WORD_SCOPED' => -113,
			'ARGV' => -113,
			"%{" => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			'OP03_MATH_INC_DEC' => -113,
			'OP01_CLOSE' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'LBRACE' => -113,
			'OP10_NAMED_UNARY' => -113,
			'LPAREN' => -113,
			'LITERAL_STRING' => -113
		},
		GOTOS => {
			'OPTIONAL-32' => 212,
			'PAREN-31' => 211
		}
	},
	{#State 124
		ACTIONS => {
			";" => 213
		}
	},
	{#State 125
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			")" => -115,
			'OP03_MATH_INC_DEC' => 128,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 108,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'MY' => 162,
			"undef" => 86,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166
		},
		GOTOS => {
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'ListElements' => 215,
			'Literal' => 110,
			'OPTIONAL-33' => 214,
			'SubExpression' => 197,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'ListElement' => 198,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81
		}
	},
	{#State 126
		DEFAULT => -118
	},
	{#State 127
		ACTIONS => {
			'WORD_UPPERCASE' => 217
		},
		GOTOS => {
			'LoopLabel' => 216
		}
	},
	{#State 128
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88
		},
		GOTOS => {
			'Variable' => 218,
			'VariableSymbolOrSelf' => 87
		}
	},
	{#State 129
		ACTIONS => {
			'SELF' => 88,
			'MY' => 162,
			'LBRACE' => -213,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'TypeInner' => 221,
			'OPTIONAL-51' => 219,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 220
		}
	},
	{#State 130
		ACTIONS => {
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 116,
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95
		},
		GOTOS => {
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Literal' => 110,
			'SubExpression' => 222,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81
		}
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 224,
			'OP02_METHOD_THINARROW_NEW' => 223
		}
	},
	{#State 132
		ACTIONS => {
			";" => 225
		}
	},
	{#State 133
		ACTIONS => {
			"\$TYPED_" => 226
		}
	},
	{#State 134
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 227
		}
	},
	{#State 135
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 59,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 228
		}
	},
	{#State 136
		DEFAULT => -44
	},
	{#State 137
		ACTIONS => {
			"our hashref \$properties" => 231,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 229,
			'Properties' => 230
		}
	},
	{#State 138
		DEFAULT => -55
	},
	{#State 139
		ACTIONS => {
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 108,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31
		},
		GOTOS => {
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'SubExpression' => 232,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86
		},
		GOTOS => {
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 233,
			'HashReference' => 109,
			'Literal' => 110
		}
	},
	{#State 141
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 234,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'Expression' => 157,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'SubExpression' => 235,
			'HashReference' => 109,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 143
		ACTIONS => {
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 236,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'Expression' => 157,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87
		}
	},
	{#State 144
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 237
		}
	},
	{#State 145
		ACTIONS => {
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 238,
			'HashReference' => 109,
			'Literal' => 110
		}
	},
	{#State 146
		ACTIONS => {
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 239,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 147
		ACTIONS => {
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'SubExpression' => 240,
			'HashReference' => 109,
			'Literal' => 110,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111
		}
	},
	{#State 148
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86
		},
		GOTOS => {
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 241,
			'HashReference' => 109,
			'Literal' => 110,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 149
		ACTIONS => {
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 166,
			"undef" => 86
		},
		GOTOS => {
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 242,
			'ArrayDereference' => 93
		}
	},
	{#State 150
		ACTIONS => {
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 243,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'Expression' => 157,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87
		}
	},
	{#State 151
		ACTIONS => {
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			"undef" => 86,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'SubExpression' => 244,
			'HashReference' => 109,
			'Literal' => 110,
			'ArrayDereference' => 93
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Variable' => 245,
			'VariableSymbolOrSelf' => 87,
			'VariableOrLiteral' => 246,
			'Literal' => 247
		}
	},
	{#State 153
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'SubExpression' => 248,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 154
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			"undef" => 86
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'SubExpression' => 249,
			'HashReference' => 109,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'Expression' => 157,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87
		}
	},
	{#State 155
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86
		},
		GOTOS => {
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 250,
			'HashReference' => 109,
			'Literal' => 110
		}
	},
	{#State 156
		ACTIONS => {
			'TYPE_FHREF' => 251
		}
	},
	{#State 157
		DEFAULT => -134
	},
	{#State 158
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 196,
			'OP06_REGEX_MATCH' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP18_TERNARY' => -137,
			"]" => -137,
			'OP04_MATH_POW' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			"}" => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP03_MATH_INC_DEC' => 195,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			";" => -137,
			")" => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP08_STRING_CAT' => -137
		}
	},
	{#State 159
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			"undef" => 86,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Literal' => 110,
			'SubExpression' => 252,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81
		}
	},
	{#State 160
		DEFAULT => -192
	},
	{#State 161
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP21_LIST_COMMA' => -190,
			'OP09_BITWISE_SHIFT' => -83,
			'OP08_STRING_CAT' => -83,
			")" => -83,
			";" => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP04_MATH_POW' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP18_TERNARY' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP11_COMPARE_LT_GT' => -83
		}
	},
	{#State 162
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 253
		}
	},
	{#State 163
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 254,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'Expression' => 157,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131
		}
	},
	{#State 164
		DEFAULT => -193
	},
	{#State 165
		ACTIONS => {
			'OP21_LIST_COMMA' => 255
		}
	},
	{#State 166
		ACTIONS => {
			'LPAREN' => 204
		}
	},
	{#State 167
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 168
		ACTIONS => {
			'FHREF_SYMBOL' => 257
		}
	},
	{#State 169
		ACTIONS => {
			'MY' => 258,
			'LPAREN_MY' => 259
		}
	},
	{#State 170
		DEFAULT => -164
	},
	{#State 171
		DEFAULT => -165
	},
	{#State 172
		DEFAULT => -152
	},
	{#State 173
		ACTIONS => {
			'MY' => 260
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN_MY' => 262,
			'LPAREN' => 261
		}
	},
	{#State 175
		DEFAULT => -163
	},
	{#State 176
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -176,
			'OP08_STRING_CAT' => -176,
			'OP03_MATH_INC_DEC' => -176,
			")" => -176,
			";" => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP02_ARRAY_THINARROW' => 264,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP20_HASH_FATARROW' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP21_LIST_COMMA' => -176,
			"}" => -176,
			'OP12_COMPARE_EQ_NE' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			"]" => -176,
			'OP04_MATH_POW' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP18_TERNARY' => -176,
			'OP02_HASH_THINARROW' => 263,
			'COLON' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP13_BITWISE_AND' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP07_STRING_REPEAT' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP02_METHOD_THINARROW' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 265
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 178
		DEFAULT => -197
	},
	{#State 179
		ACTIONS => {
			'LBRACKET' => 108
		},
		GOTOS => {
			'ArrayReference' => 267
		}
	},
	{#State 180
		DEFAULT => -16
	},
	{#State 181
		DEFAULT => -229
	},
	{#State 182
		DEFAULT => -205
	},
	{#State 183
		DEFAULT => -211
	},
	{#State 184
		DEFAULT => -204
	},
	{#State 185
		DEFAULT => -230
	},
	{#State 186
		DEFAULT => -209,
		GOTOS => {
			'STAR-50' => 268
		}
	},
	{#State 187
		ACTIONS => {
			'OP20_HASH_FATARROW' => 269
		}
	},
	{#State 188
		DEFAULT => -228
	},
	{#State 189
		ACTIONS => {
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP04_MATH_POW' => 139,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			")" => 270,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141
		}
	},
	{#State 190
		DEFAULT => -86
	},
	{#State 191
		DEFAULT => -148
	},
	{#State 192
		DEFAULT => -78
	},
	{#State 193
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'STDIN' => 274,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'FHREF_SYMBOL_IN' => 271,
			'SELF' => 88,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpressionOrInput' => 273,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 272,
			'Literal' => 110
		}
	},
	{#State 194
		ACTIONS => {
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'SubExpression' => 275,
			'HashReference' => 109,
			'ArrayDereference' => 93
		}
	},
	{#State 195
		DEFAULT => -88
	},
	{#State 196
		ACTIONS => {
			'LPAREN' => 276
		}
	},
	{#State 197
		ACTIONS => {
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			";" => -190,
			")" => -190,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -190,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			"]" => -190,
			'OP04_MATH_POW' => 139
		}
	},
	{#State 198
		DEFAULT => -188,
		GOTOS => {
			'STAR-45' => 277
		}
	},
	{#State 199
		ACTIONS => {
			";" => 278
		}
	},
	{#State 200
		ACTIONS => {
			"]" => 279
		}
	},
	{#State 201
		DEFAULT => -194
	},
	{#State 202
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP04_MATH_POW' => 139,
			"]" => -108,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP16_LOGICAL_OR' => 143,
			'OP14_BITWISE_OR_XOR' => 142,
			")" => -108,
			";" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140
		}
	},
	{#State 203
		ACTIONS => {
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 280,
			'ArrayDereference' => 93
		}
	},
	{#State 204
		ACTIONS => {
			")" => 281
		}
	},
	{#State 205
		ACTIONS => {
			'OP21_LIST_COMMA' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			")" => -98,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			'OP04_MATH_POW' => 139,
			'OP12_COMPARE_EQ_NE' => -98,
			"}" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 206
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 282
		}
	},
	{#State 207
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP14_BITWISE_OR_XOR' => 142,
			")" => 283,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP04_MATH_POW' => 139,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149
		}
	},
	{#State 208
		ACTIONS => {
			'LBRACKET' => 108,
			'MY' => 162,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'ARGV' => 164,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'ListElement' => 284,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 161,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157
		}
	},
	{#State 209
		DEFAULT => -111
	},
	{#State 210
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'MY' => 162,
			'WORD' => 31,
			'LBRACKET' => 108,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 166,
			"undef" => 86,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'ARGV' => 164
		},
		GOTOS => {
			'Variable' => 158,
			'ListElements' => 285,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ListElement' => 198,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'SubExpression' => 197,
			'HashReference' => 109,
			'Literal' => 110
		}
	},
	{#State 211
		DEFAULT => -112
	},
	{#State 212
		ACTIONS => {
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'LBRACKET' => 108,
			'MY' => 162,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99
		},
		GOTOS => {
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 197,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'ListElement' => 198,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'ListElements' => 286,
			'Variable' => 158
		}
	},
	{#State 213
		DEFAULT => -155
	},
	{#State 214
		ACTIONS => {
			")" => 287
		}
	},
	{#State 215
		DEFAULT => -114
	},
	{#State 216
		ACTIONS => {
			";" => 288
		}
	},
	{#State 217
		DEFAULT => -218
	},
	{#State 218
		DEFAULT => -87
	},
	{#State 219
		ACTIONS => {
			'LBRACE' => 95
		},
		GOTOS => {
			'HashReference' => 289
		}
	},
	{#State 220
		ACTIONS => {
			"}" => 290
		}
	},
	{#State 221
		DEFAULT => -212
	},
	{#State 222
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP18_TERNARY' => -90,
			'OP04_MATH_POW' => 139,
			"]" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			"}" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			";" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP09_BITWISE_SHIFT' => -90
		}
	},
	{#State 223
		ACTIONS => {
			")" => 291
		}
	},
	{#State 224
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			")" => -125,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'MY' => 162,
			'WORD' => 31,
			"undef" => 86,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166
		},
		GOTOS => {
			'Variable' => 158,
			'ListElements' => 292,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'OPTIONAL-34' => 293,
			'ListElement' => 198,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110
		}
	},
	{#State 225
		DEFAULT => -43
	},
	{#State 226
		ACTIONS => {
			'WORD_UPPERCASE' => 294
		}
	},
	{#State 227
		ACTIONS => {
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			"while" => -150,
			'OP03_MATH_INC_DEC' => 128,
			'OP19_LOOP_CONTROL' => 127,
			"foreach" => -150,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_PRINT' => 123,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			"}" => 296,
			'OP05_LOGICAL_NEG' => 130,
			'LBRACKET' => 108,
			'OP01_NAMED_SCOLON' => 114,
			'WORD_UPPERCASE' => 119,
			"if" => 118,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP01_NAMED_VOID' => 106,
			'WORD' => 31,
			'MY' => 84,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 83,
			"undef" => 86,
			'SELF' => 88,
			"for" => -150,
			"\@{" => 89
		},
		GOTOS => {
			'VariableModification' => 124,
			'Operation' => 295,
			'ArrayDereference' => 93,
			'Statement' => 122,
			'Conditional' => 105,
			'Variable' => 104,
			'WordScoped' => 131,
			'LoopLabel' => 100,
			'Expression' => 103,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'HashReference' => 109,
			'SubExpression' => 80,
			'Literal' => 110,
			'VariableDeclaration' => 115,
			'VariableSymbolOrSelf' => 87,
			'OperatorVoid' => 90,
			'PAREN-36' => 113,
			'OPTIONAL-37' => 85
		}
	},
	{#State 228
		ACTIONS => {
			'VARIABLE_SYMBOL' => 297
		}
	},
	{#State 229
		DEFAULT => -57
	},
	{#State 230
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 298
		}
	},
	{#State 231
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 232
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP04_MATH_POW' => 139,
			"]" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			"}" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP08_STRING_CAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			")" => -89,
			";" => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 233
		ACTIONS => {
			";" => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			"}" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP18_TERNARY' => -97,
			"]" => -97,
			'OP04_MATH_POW' => 139,
			'OP13_BITWISE_AND' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 234
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -96,
			"}" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP18_TERNARY' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP04_MATH_POW' => 139,
			"]" => -96,
			")" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP08_STRING_CAT' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP21_LIST_COMMA' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			")" => -103,
			";" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP17_LIST_RANGE' => -103,
			'OP18_TERNARY' => -103,
			'OP04_MATH_POW' => 139,
			"]" => -103,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -103
		}
	},
	{#State 236
		ACTIONS => {
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			")" => -105,
			";" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP04_MATH_POW' => 139,
			"]" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP18_TERNARY' => -105,
			'OP11_COMPARE_LT_GT' => 150,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 237
		DEFAULT => -92
	},
	{#State 238
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP23_LOGICAL_AND' => -95,
			")" => -95,
			";" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP08_STRING_CAT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95,
			"]" => -95,
			'OP04_MATH_POW' => 139,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95
		}
	},
	{#State 239
		ACTIONS => {
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			")" => -104,
			'OP14_BITWISE_OR_XOR' => 142,
			";" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -104,
			'OP04_MATH_POW' => 139,
			"]" => -104,
			'OP18_TERNARY' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 240
		ACTIONS => {
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 150,
			"]" => -102,
			'OP04_MATH_POW' => 139,
			'OP17_LIST_RANGE' => -102,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => -102,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP21_LIST_COMMA' => -102
		}
	},
	{#State 241
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP23_LOGICAL_AND' => -94,
			")" => -94,
			";" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP08_STRING_CAT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP18_TERNARY' => -94,
			"]" => -94,
			'OP04_MATH_POW' => 139,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP11_COMPARE_LT_GT' => -94
		}
	},
	{#State 242
		ACTIONS => {
			'OP21_LIST_COMMA' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP23_LOGICAL_AND' => -101,
			")" => -101,
			";" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP17_LIST_RANGE' => -101,
			'OP18_TERNARY' => -101,
			"]" => -101,
			'OP04_MATH_POW' => 139,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -101,
			'OP11_COMPARE_LT_GT' => 150,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 243
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP21_LIST_COMMA' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			";" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP04_MATH_POW' => 139,
			"]" => -100,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -100,
			'OP12_COMPARE_EQ_NE' => -100
		}
	},
	{#State 244
		ACTIONS => {
			'OP21_LIST_COMMA' => -106,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => -106,
			")" => -106,
			";" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => -106,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 139,
			"]" => -106,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -106,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 245
		DEFAULT => -226
	},
	{#State 246
		ACTIONS => {
			'COLON' => 300
		}
	},
	{#State 247
		DEFAULT => -227
	},
	{#State 248
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			")" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			";" => -110,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			"]" => -110,
			'OP04_MATH_POW' => 139,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -110,
			'OP11_COMPARE_LT_GT' => 150
		}
	},
	{#State 249
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			")" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => 143,
			'OP21_LIST_COMMA' => -109,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -109,
			'OP11_COMPARE_LT_GT' => 150,
			"]" => -109,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151
		}
	},
	{#State 250
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -93,
			"}" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			"]" => -93,
			'OP04_MATH_POW' => 139,
			'OP17_LIST_RANGE' => -93,
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP08_STRING_CAT' => -93,
			";" => -93,
			")" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP07_STRING_REPEAT' => -93
		}
	},
	{#State 251
		ACTIONS => {
			'FHREF_SYMBOL' => 301
		}
	},
	{#State 252
		ACTIONS => {
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP21_LIST_COMMA' => -191,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			")" => -191,
			'OP24_LOGICAL_OR_XOR' => 153,
			";" => -191,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP04_MATH_POW' => 139,
			"]" => -191,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 253
		ACTIONS => {
			"\$TYPED_" => 302
		}
	},
	{#State 254
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP04_MATH_POW' => -83,
			"]" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP18_TERNARY' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			"}" => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP08_STRING_CAT' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			")" => -83,
			";" => -83,
			'OP14_BITWISE_OR_XOR' => -83
		}
	},
	{#State 255
		ACTIONS => {
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'MY' => 162,
			'LBRACKET' => 108,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'ARGV' => 164
		},
		GOTOS => {
			'Expression' => 157,
			'ListElements' => 303,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ListElement' => 198
		}
	},
	{#State 256
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 304,
			";" => 306,
			'OP02_ARRAY_THINARROW' => 305
		}
	},
	{#State 257
		ACTIONS => {
			";" => 307
		}
	},
	{#State 258
		ACTIONS => {
			'TYPE_INTEGER' => 308
		}
	},
	{#State 259
		ACTIONS => {
			'TYPE_INTEGER' => 309
		}
	},
	{#State 260
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 59,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 310
		}
	},
	{#State 261
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'SubExpression' => 311,
			'HashReference' => 109,
			'Literal' => 110
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 59,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 312
		}
	},
	{#State 263
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"undef" => 86,
			'WORD' => 314,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120
		},
		GOTOS => {
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 313,
			'Literal' => 110
		}
	},
	{#State 264
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 315,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 265
		DEFAULT => -174
	},
	{#State 266
		DEFAULT => -199
	},
	{#State 267
		ACTIONS => {
			"}" => 316
		}
	},
	{#State 268
		ACTIONS => {
			"}" => 318,
			'OP21_LIST_COMMA' => 317
		},
		GOTOS => {
			'PAREN-49' => 319
		}
	},
	{#State 269
		ACTIONS => {
			'LITERAL_STRING' => -202,
			'OP10_NAMED_UNARY' => -202,
			'LPAREN' => -202,
			'LBRACE' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'OP01_CLOSE' => -202,
			'OP03_MATH_INC_DEC' => -202,
			"%{" => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'WORD_SCOPED' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'LITERAL_NUMBER' => -202,
			'LBRACKET' => -202,
			'OP01_OPEN' => -202,
			'OP01_NAMED' => -202,
			'WORD' => -202,
			'MY' => 162,
			"undef" => -202,
			'VARIABLE_SYMBOL' => -202,
			"\@{" => -202,
			'OP22_LOGICAL_NEG' => -202,
			'SELF' => -202,
			'WORD_UPPERCASE' => -202
		},
		GOTOS => {
			'OPTIONAL-48' => 321,
			'TypeInner' => 320
		}
	},
	{#State 270
		DEFAULT => -91
	},
	{#State 271
		DEFAULT => -144
	},
	{#State 272
		ACTIONS => {
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			")" => -143,
			";" => -143,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP04_MATH_POW' => 139,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149
		}
	},
	{#State 273
		DEFAULT => -184
	},
	{#State 274
		DEFAULT => -145
	},
	{#State 275
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP04_MATH_POW' => 139,
			")" => -185,
			";" => -185,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143
		}
	},
	{#State 276
		ACTIONS => {
			"undef" => 86,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'OP01_QW' => 160,
			'VARIABLE_SYMBOL' => 116,
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'MY' => 162,
			'WORD' => 31,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'ARGV' => 164,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			")" => -127,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96
		},
		GOTOS => {
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'ListElements' => 323,
			'Variable' => 158,
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110,
			'TypeInner' => 159,
			'OPTIONAL-35' => 322,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ListElement' => 198,
			'HashDereference' => 81,
			'ArrayReference' => 111
		}
	},
	{#State 277
		ACTIONS => {
			'OP21_LIST_COMMA' => 325,
			"]" => -189,
			";" => -189,
			")" => -189
		},
		GOTOS => {
			'PAREN-44' => 324
		}
	},
	{#State 278
		DEFAULT => -120
	},
	{#State 279
		DEFAULT => -196
	},
	{#State 280
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP04_MATH_POW' => 139,
			")" => 326,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148
		}
	},
	{#State 281
		DEFAULT => -129
	},
	{#State 282
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'MY' => 162,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'ARGV' => 164,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'Operator' => 112,
			'ListElement' => 198,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'ListElements' => 327,
			'Expression' => 157
		}
	},
	{#State 283
		DEFAULT => -142
	},
	{#State 284
		ACTIONS => {
			'OP21_LIST_COMMA' => 328
		}
	},
	{#State 285
		ACTIONS => {
			";" => 329
		}
	},
	{#State 286
		ACTIONS => {
			";" => 330
		}
	},
	{#State 287
		ACTIONS => {
			";" => 331
		}
	},
	{#State 288
		DEFAULT => -123
	},
	{#State 289
		ACTIONS => {
			"}" => 332
		}
	},
	{#State 290
		DEFAULT => -214
	},
	{#State 291
		DEFAULT => -133
	},
	{#State 292
		DEFAULT => -124
	},
	{#State 293
		ACTIONS => {
			")" => 333
		}
	},
	{#State 294
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 334
		}
	},
	{#State 295
		DEFAULT => -46
	},
	{#State 296
		ACTIONS => {
			";" => 335
		}
	},
	{#State 297
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 336
		}
	},
	{#State 298
		ACTIONS => {
			'LITERAL_NUMBER' => 337,
			"our" => 340
		},
		GOTOS => {
			'Subroutine' => 338,
			'Method' => 339,
			'MethodOrSubroutine' => 341
		}
	},
	{#State 299
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 300
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 87,
			'Variable' => 245,
			'Literal' => 247,
			'VariableOrLiteral' => 343
		}
	},
	{#State 301
		ACTIONS => {
			'OP21_LIST_COMMA' => 344
		}
	},
	{#State 302
		ACTIONS => {
			'WORD' => 345
		}
	},
	{#State 303
		ACTIONS => {
			";" => 346
		}
	},
	{#State 304
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'FHREF_SYMBOL_IN' => 271,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY_SCOLON' => 349,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'STDIN' => 274,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP01_NAMED_SCOLON' => 350,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 272,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'OpNamedScolonOrSubExpIn' => 348,
			'Expression' => 157,
			'SubExpressionOrInput' => 347,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131
		}
	},
	{#State 305
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'HashReference' => 109,
			'SubExpression' => 351,
			'Literal' => 110,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158
		}
	},
	{#State 306
		DEFAULT => -180
	},
	{#State 307
		DEFAULT => -183
	},
	{#State 308
		ACTIONS => {
			'VARIABLE_SYMBOL' => 352
		}
	},
	{#State 309
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 310
		ACTIONS => {
			'VARIABLE_SYMBOL' => 354
		}
	},
	{#State 311
		ACTIONS => {
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			")" => 355,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 312
		ACTIONS => {
			'VARIABLE_SYMBOL' => 356
		}
	},
	{#State 313
		ACTIONS => {
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => 357,
			'OP11_COMPARE_LT_GT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 314
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -216,
			"}" => 358,
			'LPAREN' => -216
		}
	},
	{#State 315
		ACTIONS => {
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			"]" => 359,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP14_BITWISE_OR_XOR' => 142
		}
	},
	{#State 316
		DEFAULT => -200
	},
	{#State 317
		ACTIONS => {
			'SELF' => 88,
			'WORD' => 185,
			'LITERAL_NUMBER' => 107,
			'VARIABLE_SYMBOL' => 116,
			"%{" => 129,
			'ENV' => 182,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 187,
			'HashDereference' => 184,
			'Variable' => 188,
			'VariableSymbolOrSelf' => 87,
			'HashEntry' => 360,
			'Literal' => 181
		}
	},
	{#State 318
		DEFAULT => -210
	},
	{#State 319
		DEFAULT => -208
	},
	{#State 320
		DEFAULT => -201
	},
	{#State 321
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'SubExpression' => 361,
			'HashReference' => 109,
			'Literal' => 110,
			'ArrayDereference' => 93
		}
	},
	{#State 322
		ACTIONS => {
			")" => 362
		}
	},
	{#State 323
		DEFAULT => -126
	},
	{#State 324
		DEFAULT => -187
	},
	{#State 325
		ACTIONS => {
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'LBRACKET' => 108,
			'MY' => 162,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99
		},
		GOTOS => {
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'ListElement' => 363,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'HashReference' => 109,
			'SubExpression' => 197,
			'Literal' => 110,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 326
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 364
		}
	},
	{#State 327
		ACTIONS => {
			")" => 366
		}
	},
	{#State 328
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD' => 31,
			'MY' => 162,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			"undef" => 86
		},
		GOTOS => {
			'Literal' => 110,
			'SubExpression' => 197,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'ListElement' => 198,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Expression' => 157,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'ListElements' => 367
		}
	},
	{#State 329
		DEFAULT => -117
	},
	{#State 330
		DEFAULT => -116
	},
	{#State 331
		DEFAULT => -119
	},
	{#State 332
		DEFAULT => -215
	},
	{#State 333
		DEFAULT => -131
	},
	{#State 334
		DEFAULT => -225
	},
	{#State 335
		DEFAULT => -48
	},
	{#State 336
		ACTIONS => {
			")" => 368,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-19' => 369
		}
	},
	{#State 337
		ACTIONS => {
			";" => 371
		}
	},
	{#State 338
		DEFAULT => -77
	},
	{#State 339
		DEFAULT => -76
	},
	{#State 340
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_METHOD' => 372,
			'TYPE_INTEGER' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 341
		DEFAULT => -59
	},
	{#State 342
		ACTIONS => {
			"}" => 375,
			'WORD' => 373
		},
		GOTOS => {
			'HashEntryProperties' => 374
		}
	},
	{#State 343
		DEFAULT => -107
	},
	{#State 344
		ACTIONS => {
			'LITERAL_STRING' => 376
		}
	},
	{#State 345
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 346
		DEFAULT => -121
	},
	{#State 347
		ACTIONS => {
			";" => 378
		}
	},
	{#State 348
		DEFAULT => -181
	},
	{#State 349
		DEFAULT => -239
	},
	{#State 350
		DEFAULT => -238
	},
	{#State 351
		ACTIONS => {
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP04_MATH_POW' => 139,
			"]" => 379,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 352
		ACTIONS => {
			'LPAREN' => 380
		}
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 381
		}
	},
	{#State 354
		ACTIONS => {
			'LPAREN' => 382
		}
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 356
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 384
		}
	},
	{#State 357
		DEFAULT => -178
	},
	{#State 358
		DEFAULT => -179
	},
	{#State 359
		DEFAULT => -177
	},
	{#State 360
		DEFAULT => -207
	},
	{#State 361
		ACTIONS => {
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP21_LIST_COMMA' => -203,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -203,
			'OP04_MATH_POW' => 139,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144
		}
	},
	{#State 362
		DEFAULT => -132
	},
	{#State 363
		DEFAULT => -186
	},
	{#State 364
		DEFAULT => -158,
		GOTOS => {
			'STAR-39' => 385
		}
	},
	{#State 365
		ACTIONS => {
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 83,
			'MY' => 84,
			'WORD' => 31,
			"\@{" => 89,
			"for" => -150,
			'SELF' => 88,
			"undef" => 86,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'OP01_NAMED_VOID' => 106,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			"if" => 118,
			'WORD_UPPERCASE' => 119,
			'OP01_NAMED_SCOLON' => 114,
			'OP01_PRINT' => 123,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => 127,
			'OP03_MATH_INC_DEC' => 128,
			"while" => -150,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 130,
			"%{" => 129,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'PAREN-36' => 113,
			'OPTIONAL-37' => 85,
			'VariableDeclaration' => 115,
			'VariableSymbolOrSelf' => 87,
			'OperatorVoid' => 90,
			'HashReference' => 109,
			'SubExpression' => 80,
			'Literal' => 110,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'LoopLabel' => 100,
			'Expression' => 103,
			'PLUS-42' => 386,
			'Variable' => 104,
			'Conditional' => 105,
			'WordScoped' => 131,
			'ArrayDereference' => 93,
			'Statement' => 122,
			'VariableModification' => 124,
			'Operation' => 387
		}
	},
	{#State 366
		DEFAULT => -82
	},
	{#State 367
		ACTIONS => {
			")" => 388
		}
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 389
		}
	},
	{#State 369
		DEFAULT => -50
	},
	{#State 370
		ACTIONS => {
			'MY' => 390
		}
	},
	{#State 371
		DEFAULT => -61
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 373
		ACTIONS => {
			'OP20_HASH_FATARROW' => 392
		}
	},
	{#State 374
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 393
		}
	},
	{#State 375
		ACTIONS => {
			";" => 394
		}
	},
	{#State 376
		ACTIONS => {
			'OP21_LIST_COMMA' => 395
		}
	},
	{#State 377
		DEFAULT => -222
	},
	{#State 378
		DEFAULT => -240
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 380
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'VARIABLE_SYMBOL' => 116,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'Expression' => 157,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Literal' => 110,
			'SubExpression' => 397,
			'HashReference' => 109,
			'ArrayDereference' => 93,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81
		}
	},
	{#State 381
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 399,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_NAMED_SCOLON' => 401,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 108,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'WORD' => 31
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 398,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157,
			'OpNamedScolonOrSubExp' => 400
		}
	},
	{#State 382
		ACTIONS => {
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 160,
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'LBRACKET' => 108,
			'WORD' => 31,
			'MY' => 162,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD_SCOPED' => 30,
			'ARGV' => 164,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99
		},
		GOTOS => {
			'Operator' => 112,
			'ListElement' => 198,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'SubExpression' => 197,
			'HashReference' => 109,
			'Literal' => 110,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'ListElements' => 402,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 383
		DEFAULT => -169
	},
	{#State 384
		ACTIONS => {
			'WORD_UPPERCASE' => 166,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 116,
			"undef" => 86,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'STDIN' => 274,
			'LBRACE' => 95,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'LITERAL_STRING' => 92,
			'FHREF_SYMBOL_IN' => 271
		},
		GOTOS => {
			'SubExpressionOrInput' => 403,
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 272
		}
	},
	{#State 385
		ACTIONS => {
			'LBRACKET' => -161,
			"elsif" => 404,
			'OP01_NAMED_SCOLON' => -161,
			"else" => 405,
			'OP22_LOGICAL_NEG' => -161,
			'WORD_UPPERCASE' => -161,
			"if" => -161,
			'VARIABLE_SYMBOL' => -161,
			'OP10_NAMED_UNARY' => -161,
			'LPAREN' => -161,
			"while" => -161,
			"foreach" => -161,
			'OP19_LOOP_CONTROL' => -161,
			'OP03_MATH_INC_DEC' => -161,
			'OP01_PRINT' => -161,
			'OP01_NAMED_VOID_LPAREN' => -161,
			'OP01_NAMED_VOID_SCOLON' => -161,
			"%{" => -161,
			'WORD_SCOPED' => -161,
			'OP05_LOGICAL_NEG' => -161,
			"}" => -161,
			'OP01_NAMED' => -161,
			'OP01_OPEN' => -161,
			'MY' => -161,
			'WORD' => -161,
			"undef" => -161,
			"\@{" => -161,
			'SELF' => -161,
			"for" => -161,
			'' => -161,
			'OP10_NAMED_UNARY_SCOLON' => -161,
			'LITERAL_STRING' => -161,
			'OP19_LOOP_CONTROL_SCOLON' => -161,
			'OP01_CLOSE' => -161,
			'LBRACE' => -161,
			'OP05_MATH_NEG_LPAREN' => -161,
			'CONSTANT_CALL_SCOPED' => -161,
			'OP01_NAMED_VOID' => -161,
			'LITERAL_NUMBER' => -161
		},
		GOTOS => {
			'PAREN-40' => 408,
			'PAREN-38' => 406,
			'OPTIONAL-41' => 407
		}
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'OP01_NAMED_VOID' => 106,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 83,
			'WORD' => 31,
			'MY' => 84,
			'SELF' => 88,
			"for" => -150,
			"\@{" => 89,
			"undef" => 86,
			'OP01_PRINT' => 123,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => 127,
			'OP03_MATH_INC_DEC' => 128,
			"while" => -150,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'OP05_LOGICAL_NEG' => 130,
			"}" => 410,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			'WORD_UPPERCASE' => 119,
			"if" => 118,
			'OP01_NAMED_SCOLON' => 114
		},
		GOTOS => {
			'OperatorVoid' => 90,
			'VariableSymbolOrSelf' => 87,
			'VariableDeclaration' => 115,
			'OPTIONAL-37' => 85,
			'PAREN-36' => 113,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'SubExpression' => 80,
			'HashReference' => 109,
			'WordScoped' => 131,
			'Variable' => 104,
			'Conditional' => 105,
			'Expression' => 103,
			'LoopLabel' => 100,
			'Operation' => 409,
			'VariableModification' => 124,
			'Statement' => 122,
			'ArrayDereference' => 93
		}
	},
	{#State 387
		DEFAULT => -172
	},
	{#State 388
		DEFAULT => -84
	},
	{#State 389
		ACTIONS => {
			"\@_;" => 411
		}
	},
	{#State 390
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 60,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 391
		ACTIONS => {
			"= sub {" => 413
		}
	},
	{#State 392
		ACTIONS => {
			'MY' => 414
		},
		GOTOS => {
			'TypeInnerProperties' => 415
		}
	},
	{#State 393
		ACTIONS => {
			'OP21_LIST_COMMA' => 416,
			"}" => 417
		},
		GOTOS => {
			'PAREN-25' => 418
		}
	},
	{#State 394
		DEFAULT => -66
	},
	{#State 395
		ACTIONS => {
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			"undef" => 86,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 116,
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31
		},
		GOTOS => {
			'Variable' => 158,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Expression' => 157,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'SubExpression' => 419,
			'HashReference' => 109
		}
	},
	{#State 396
		ACTIONS => {
			"undef" => 420
		}
	},
	{#State 397
		ACTIONS => {
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 421,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143
		}
	},
	{#State 398
		ACTIONS => {
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			";" => 422,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147
		}
	},
	{#State 399
		DEFAULT => -236
	},
	{#State 400
		ACTIONS => {
			'VARIABLE_SYMBOL' => 423
		}
	},
	{#State 401
		DEFAULT => -235
	},
	{#State 402
		ACTIONS => {
			")" => 424
		}
	},
	{#State 403
		ACTIONS => {
			")" => 425
		}
	},
	{#State 404
		ACTIONS => {
			'LPAREN' => 426
		}
	},
	{#State 405
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 427
		}
	},
	{#State 406
		DEFAULT => -157
	},
	{#State 407
		DEFAULT => -162
	},
	{#State 408
		DEFAULT => -160
	},
	{#State 409
		DEFAULT => -171
	},
	{#State 410
		DEFAULT => -173
	},
	{#State 411
		DEFAULT => -52
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 428
		}
	},
	{#State 413
		ACTIONS => {
			"for" => -68,
			'LPAREN_MY' => 431,
			'SELF' => -68,
			"\@{" => -68,
			"undef" => -68,
			'OP01_OPEN' => -68,
			'OP01_NAMED' => -68,
			'MY' => -68,
			'WORD' => -68,
			'OP01_NAMED_VOID' => -68,
			'LITERAL_NUMBER' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'LBRACE' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_CLOSE' => -68,
			'LITERAL_STRING' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'WORD_UPPERCASE' => -68,
			"if" => -68,
			'OP01_NAMED_SCOLON' => -68,
			'LBRACKET' => -68,
			'OP05_LOGICAL_NEG' => -68,
			"}" => -68,
			"%{" => -68,
			'WORD_SCOPED' => -68,
			'OP01_PRINT' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			"foreach" => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP03_MATH_INC_DEC' => -68,
			"while" => -68,
			'OP10_NAMED_UNARY' => -68,
			'LPAREN' => -68
		},
		GOTOS => {
			'MethodArguments' => 429,
			'OPTIONAL-27' => 430
		}
	},
	{#State 414
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 60,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 432
		}
	},
	{#State 415
		DEFAULT => -206
	},
	{#State 416
		ACTIONS => {
			'WORD' => 373
		},
		GOTOS => {
			'HashEntryProperties' => 433
		}
	},
	{#State 417
		ACTIONS => {
			";" => 434
		}
	},
	{#State 418
		DEFAULT => -63
	},
	{#State 419
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP06_REGEX_MATCH' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 141,
			")" => -85,
			";" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP23_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => 143,
			'OP21_LIST_COMMA' => -85,
			"}" => -85,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 150,
			"]" => -85,
			'OP04_MATH_POW' => 139,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151
		}
	},
	{#State 420
		ACTIONS => {
			";" => 435
		}
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Operator' => 112,
			'ArrayDereference' => 93,
			'Literal' => 110,
			'SubExpression' => 436,
			'HashReference' => 109,
			'Variable' => 158,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Expression' => 157
		}
	},
	{#State 422
		DEFAULT => -237
	},
	{#State 423
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 437
		}
	},
	{#State 424
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 438
		}
	},
	{#State 425
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 439
		}
	},
	{#State 426
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'LITERAL_STRING' => 92,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 120,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			"\@{" => 89,
			"undef" => 86,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Operator' => 112,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'SubExpression' => 440,
			'HashReference' => 109,
			'Literal' => 110,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 427
		DEFAULT => -159
	},
	{#State 428
		DEFAULT => -49
	},
	{#State 429
		DEFAULT => -67
	},
	{#State 430
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 441
		}
	},
	{#State 431
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 442
		}
	},
	{#State 432
		ACTIONS => {
			"\$TYPED_" => 443
		}
	},
	{#State 433
		DEFAULT => -62
	},
	{#State 434
		DEFAULT => -65
	},
	{#State 435
		DEFAULT => -182
	},
	{#State 436
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -106,
			'OP04_MATH_POW' => 139,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => -106,
			")" => 444,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => -106,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148
		}
	},
	{#State 437
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 30,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 399,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 89,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			"undef" => 86,
			'OP01_NAMED_SCOLON' => 401,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'LBRACKET' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'Variable' => 158,
			'Expression' => 157,
			'OpNamedScolonOrSubExp' => 445,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'SubExpression' => 398,
			'HashReference' => 109,
			'ArrayDereference' => 93
		}
	},
	{#State 438
		DEFAULT => -168
	},
	{#State 439
		DEFAULT => -170
	},
	{#State 440
		ACTIONS => {
			'OP04_MATH_POW' => 139,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 142,
			")" => 446,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP07_STRING_REPEAT' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 147
		}
	},
	{#State 441
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP01_NAMED_VOID' => 106,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY_SCOLON' => 94,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 97,
			'OP01_CLOSE' => 99,
			"undef" => 86,
			"for" => -150,
			'SELF' => 88,
			"\@{" => 89,
			'WORD' => 31,
			'MY' => 84,
			'OP01_NAMED' => 83,
			'OP01_OPEN' => 82,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			"}" => 448,
			'OP05_LOGICAL_NEG' => 130,
			"while" => -150,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_PRINT' => 123,
			'OP03_MATH_INC_DEC' => 128,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => 127,
			'OP01_NAMED_SCOLON' => 114,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 119,
			"if" => 118,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Variable' => 104,
			'Conditional' => 105,
			'WordScoped' => 131,
			'LoopLabel' => 100,
			'Expression' => 103,
			'VariableModification' => 124,
			'Operation' => 447,
			'ArrayDereference' => 93,
			'Statement' => 122,
			'VariableDeclaration' => 115,
			'VariableSymbolOrSelf' => 87,
			'OperatorVoid' => 90,
			'PAREN-36' => 113,
			'OPTIONAL-37' => 85,
			'HashDereference' => 81,
			'ArrayReference' => 111,
			'Operator' => 112,
			'HashReference' => 109,
			'SubExpression' => 80,
			'Literal' => 110
		}
	},
	{#State 442
		ACTIONS => {
			'SELF' => 449
		}
	},
	{#State 443
		ACTIONS => {
			'WORD' => 450
		}
	},
	{#State 444
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 451
		}
	},
	{#State 445
		ACTIONS => {
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 163,
			"undef" => 86,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 116,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LITERAL_STRING' => 92,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 130
		},
		GOTOS => {
			'Expression' => 157,
			'Variable' => 104,
			'VariableSymbolOrSelf' => 87,
			'WordScoped' => 131,
			'ArrayDereference' => 93,
			'SubExpressionOrVarMod' => 454,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 453,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'VariableModification' => 452,
			'Operator' => 112
		}
	},
	{#State 446
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 447
		DEFAULT => -69
	},
	{#State 448
		ACTIONS => {
			";" => 456
		}
	},
	{#State 449
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 457
		}
	},
	{#State 450
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 459,
			'OP19_VARIABLE_ASSIGN' => 458
		}
	},
	{#State 451
		DEFAULT => -166
	},
	{#State 452
		DEFAULT => -147
	},
	{#State 453
		ACTIONS => {
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP04_MATH_POW' => 139,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP16_LOGICAL_OR' => 143,
			'OP23_LOGICAL_AND' => 154,
			")" => -146,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 454
		ACTIONS => {
			")" => 460
		}
	},
	{#State 455
		DEFAULT => -156
	},
	{#State 456
		DEFAULT => -71
	},
	{#State 457
		ACTIONS => {
			")" => 463,
			'OP21_LIST_COMMA' => 462
		},
		GOTOS => {
			'PAREN-29' => 461
		}
	},
	{#State 458
		ACTIONS => {
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117,
			'SELF' => 88,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 108,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			'WORD' => 31,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 129,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP01_CLOSE' => 99,
			'OP03_MATH_INC_DEC' => 128
		},
		GOTOS => {
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 464,
			'ArrayDereference' => 93,
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157
		}
	},
	{#State 459
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'OP10_NAMED_UNARY' => 120,
			'LPAREN' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_CLOSE' => 99,
			'WORD_SCOPED' => 30,
			"%{" => 129,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_LOGICAL_NEG' => 130,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 108,
			'WORD' => 31,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 82,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 116,
			'WORD_UPPERCASE' => 166,
			'SELF' => 88,
			"\@{" => 89,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'WordScoped' => 131,
			'VariableSymbolOrSelf' => 87,
			'Variable' => 158,
			'Expression' => 157,
			'Operator' => 112,
			'ArrayReference' => 111,
			'HashDereference' => 81,
			'Literal' => 110,
			'HashReference' => 109,
			'SubExpression' => 465,
			'ArrayDereference' => 93
		}
	},
	{#State 460
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 466
		}
	},
	{#State 461
		DEFAULT => -73
	},
	{#State 462
		ACTIONS => {
			'MY' => 467
		}
	},
	{#State 463
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 468
		}
	},
	{#State 464
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP17_LIST_RANGE' => 151,
			'OP18_TERNARY' => 152,
			'OP04_MATH_POW' => 139,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -223,
			'OP21_LIST_COMMA' => -223,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140
		}
	},
	{#State 465
		ACTIONS => {
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 144,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP23_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 143,
			'OP11_COMPARE_LT_GT' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP18_TERNARY' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP04_MATH_POW' => 139,
			"]" => 469
		}
	},
	{#State 466
		DEFAULT => -167
	},
	{#State 467
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 59,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 470
		}
	},
	{#State 468
		ACTIONS => {
			"\@_;" => 471
		}
	},
	{#State 469
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 472
		}
	},
	{#State 470
		ACTIONS => {
			'VARIABLE_SYMBOL' => 473
		}
	},
	{#State 471
		DEFAULT => -75
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
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6786 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7652 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7659 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7702 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7713 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7735 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7746 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7768 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7782 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7807 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7862 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7873 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7895 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7906 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7917 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7928 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7939 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7950 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7961 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7983 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7994 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8005 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8016 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8023 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8030 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8037 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8048 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8059 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8092 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8113 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8127 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8134 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_162
		 'Conditional', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8145 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8156 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8167 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8178 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 10,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8189 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 12,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8200 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_168
		 'LoopForEach', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8211 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8222 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8233 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8240 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8272 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8294 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8305 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8316 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8327 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8338 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8349 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8360 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8371 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8382 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8389 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8396 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8414 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8436 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8447 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8465 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8472 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8483 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8490 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8526 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8533 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8544 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8555 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8566 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_206
		 'HashEntryProperties', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8577 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8584 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8591 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8598 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8609 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8627 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8634 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8645 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8667 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8678 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8689 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8700 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8711 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8722 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8733 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8744 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8755 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_225
		 'TypeInnerConstant', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8766 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8777 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8788 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8799 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_229
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8810 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_230
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8821 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8832 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8843 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8854 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8865 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_235
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8876 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8887 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8898 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_238
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8909 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8920 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

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

#line 233 "lib/RPerl/Grammar.eyp"


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
