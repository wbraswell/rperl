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
    our $VERSION = 0.002_601;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|\=\ sub\ \{|foreach|elsif|while|undef|else|for|our|\@_\;|\@\{|\%\{|if|\)|\;|\]|\})}gc and return ($1, $1);

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
			"package" => -20,
			'SHEBANG' => 4,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 2,
			'Program' => 1,
			'ModuleHeader' => 8,
			'CompileUnit' => 9,
			'PLUS-2' => 7,
			'PAREN-1' => 5,
			'Critic' => 6
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 11
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-16' => 13
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 3,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'Critic' => 15,
			'OPTIONAL-3' => 14
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 3,
			"package" => -20,
			'' => -5,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'ModuleHeader' => 8,
			'PAREN-1' => 16,
			'Critic' => 6,
			'OPTIONAL-9' => 2
		}
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => -27,
			"use constant" => -27,
			"our" => -27,
			"use parent qw(" => 19,
			'USE' => -27
		},
		GOTOS => {
			'Module' => 18,
			'Class' => 17,
			'Package' => 21,
			'STAR-11' => 20
		}
	},
	{#State 9
		ACTIONS => {
			'' => 22
		}
	},
	{#State 10
		ACTIONS => {
			"package" => 23
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -39
	},
	{#State 13
		ACTIONS => {
			")" => 24,
			'WORD' => 25
		}
	},
	{#State 14
		ACTIONS => {
			'USE_RPERL' => 26
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		ACTIONS => {
			'USE' => -29,
			"## no critic qw(" => 3,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 31,
			'Critic' => 30
		}
	},
	{#State 21
		DEFAULT => -24
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		DEFAULT => -38
	},
	{#State 26
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 34
		}
	},
	{#State 27
		DEFAULT => -216
	},
	{#State 28
		DEFAULT => -217
	},
	{#State 29
		ACTIONS => {
			")" => 35
		}
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			'USE' => 37,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 36,
			'Include' => 38
		}
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use warnings;" => 40
		}
	},
	{#State 34
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 41
		}
	},
	{#State 35
		ACTIONS => {
			";" => 42
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 44,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 43,
			'PLUS-14' => 45,
			'Constant' => 46
		}
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 38
		DEFAULT => -28
	},
	{#State 39
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'USE_RPERL_AFTER' => 51,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 50
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			'VARIABLE_SYMBOL' => -11,
			"## no critic qw(" => 3,
			'OP10_NAMED_UNARY' => -11,
			'LBRACKET' => -11,
			'LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_CLOSE' => -11,
			'MY' => -11,
			'USE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"\@{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"while" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_OPEN' => -11,
			'SELF' => -11,
			'OP01_PRINT' => -11,
			"use constant" => -11,
			'OP01_NAMED_VOID' => -11,
			"if" => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			'LBRACE' => -11,
			'WORD_SCOPED' => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"undef" => -11,
			"for" => -11,
			"foreach" => -11
		},
		GOTOS => {
			'Critic' => 53,
			'STAR-5' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'USE' => 37
		},
		GOTOS => {
			'Include' => 54
		}
	},
	{#State 43
		DEFAULT => -33
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 63,
			";" => 62
		}
	},
	{#State 49
		DEFAULT => -23
	},
	{#State 50
		ACTIONS => {
			"our" => 64
		}
	},
	{#State 51
		DEFAULT => -35
	},
	{#State 52
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'LBRACE' => -13,
			'WORD' => -13,
			'WORD_SCOPED' => -13,
			"if" => -13,
			'LITERAL_STRING' => -13,
			"our" => -13,
			'OP01_NAMED_VOID' => -13,
			"for" => -13,
			"foreach" => -13,
			'LITERAL_NUMBER' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"undef" => -13,
			'OP01_CLOSE' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD_UPPERCASE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_OPEN' => -13,
			'OP01_PRINT' => -13,
			'SELF' => -13,
			"use constant" => -13,
			"\@{" => -13,
			"while" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'USE' => 37,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'MY' => -13
		},
		GOTOS => {
			'Include' => 65,
			'STAR-6' => 66
		}
	},
	{#State 53
		DEFAULT => -8
	},
	{#State 54
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 67
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 56
		ACTIONS => {
			";" => 69
		}
	},
	{#State 57
		DEFAULT => -32
	},
	{#State 58
		DEFAULT => -221
	},
	{#State 59
		DEFAULT => -219
	},
	{#State 60
		DEFAULT => -220
	},
	{#State 61
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		}
	},
	{#State 62
		DEFAULT => -41
	},
	{#State 63
		ACTIONS => {
			";" => 71
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
			'OP01_NAMED_VOID' => -15,
			"our" => -15,
			'LITERAL_STRING' => -15,
			"if" => -15,
			'LBRACE' => -15,
			'WORD' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"foreach" => -15,
			"for" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LBRACKET' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'MY' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"while" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			'OP01_PRINT' => -15,
			"use constant" => 44,
			'SELF' => -15
		},
		GOTOS => {
			'Constant' => 74,
			'STAR-7' => 73
		}
	},
	{#State 67
		ACTIONS => {
			"our hashref \$properties" => -56,
			'USE' => -56,
			"## no critic qw(" => 3,
			"use constant" => -56
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-22' => 76
		}
	},
	{#State 68
		ACTIONS => {
			'MY' => 77
		},
		GOTOS => {
			'TypeInnerConstant' => 78
		}
	},
	{#State 69
		DEFAULT => -34
	},
	{#State 70
		ACTIONS => {
			"= sub {" => 79
		}
	},
	{#State 71
		DEFAULT => -42
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			'MY' => 105,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 99,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_PRINT' => 102,
			'WORD_UPPERCASE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			'OP19_LOOP_CONTROL' => 94,
			"%{" => 93,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'LPAREN' => 81,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			"foreach" => -150,
			"for" => -150,
			'OP01_NAMED_VOID' => 121,
			'LITERAL_STRING' => 124,
			"our" => 47,
			"if" => 123,
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'OP01_NAMED' => 120,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED_SCOLON' => 115
		},
		GOTOS => {
			'HashReference' => 125,
			'Literal' => 91,
			'Statement' => 122,
			'SubExpression' => 126,
			'Conditional' => 87,
			'VariableModification' => 119,
			'Expression' => 85,
			'Subroutine' => 118,
			'OPTIONAL-37' => 117,
			'ArrayReference' => 80,
			'Operation' => 82,
			'Operator' => 114,
			'VariableDeclaration' => 112,
			'Variable' => 129,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 106,
			'OperatorVoid' => 107,
			'PAREN-36' => 108,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'PLUS-8' => 98,
			'LoopLabel' => 96
		}
	},
	{#State 74
		DEFAULT => -12
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 37,
			"use constant" => -58
		},
		GOTOS => {
			'Include' => 133,
			'STAR-23' => 132
		}
	},
	{#State 77
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 134
		}
	},
	{#State 78
		ACTIONS => {
			'LITERAL_NUMBER' => 130,
			'LITERAL_STRING' => 124
		},
		GOTOS => {
			'Literal' => 135
		}
	},
	{#State 79
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_NAMED' => -45,
			'WORD_SCOPED' => -45,
			'WORD' => -45,
			'LBRACE' => -45,
			"if" => -45,
			'LITERAL_STRING' => -45,
			'OP01_NAMED_VOID' => -45,
			'LPAREN_MY' => 138,
			"for" => -45,
			"foreach" => -45,
			"}" => -45,
			"undef" => -45,
			'OP03_MATH_INC_DEC' => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_CLOSE' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'LPAREN' => -45,
			'OP10_NAMED_UNARY' => -45,
			'LBRACKET' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"%{" => -45,
			'VARIABLE_SYMBOL' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'WORD_UPPERCASE' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'SELF' => -45,
			'OP01_PRINT' => -45,
			'OP01_OPEN' => -45,
			"\@{" => -45,
			'OP05_LOGICAL_NEG' => -45,
			"while" => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'MY' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 136,
			'OPTIONAL-17' => 137
		}
	},
	{#State 80
		DEFAULT => -138
	},
	{#State 81
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_OPEN' => 103,
			'OP01_PRINT' => 144,
			'SELF' => 101,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED' => 140,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'SubExpression' => 139
		}
	},
	{#State 82
		DEFAULT => -17
	},
	{#State 83
		ACTIONS => {
			'FHREF_SYMBOL' => 145
		}
	},
	{#State 84
		ACTIONS => {
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 146,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 125,
			'Variable' => 141,
			'Literal' => 91,
			'HashDereference' => 106
		}
	},
	{#State 85
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP18_TERNARY' => -134,
			";" => 148,
			'OP08_MATH_ADD_SUB' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP08_STRING_CAT' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP04_MATH_POW' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP17_LIST_RANGE' => -134
		}
	},
	{#State 86
		DEFAULT => -130
	},
	{#State 87
		DEFAULT => -151
	},
	{#State 88
		ACTIONS => {
			'LPAREN' => 149,
			'COLON' => -218
		}
	},
	{#State 89
		DEFAULT => -118
	},
	{#State 90
		ACTIONS => {
			'OP13_BITWISE_AND' => -99,
			'OP07_STRING_REPEAT' => -99,
			'OP04_MATH_POW' => -99,
			'OP06_REGEX_MATCH' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP10_NAMED_UNARY' => 90,
			";" => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'LBRACKET' => 92,
			'OP16_LOGICAL_OR' => -99,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			")" => -99,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP09_BITWISE_SHIFT' => -99,
			"]" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'LPAREN' => 81,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP23_LOGICAL_AND' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP08_STRING_CAT' => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'LITERAL_STRING' => 124,
			'OP21_LIST_COMMA' => -99,
			'OP01_NAMED' => 147,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'OP24_LOGICAL_OR_XOR' => -99,
			'LBRACE' => 113
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114,
			'HashReference' => 125,
			'Variable' => 141,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 150,
			'HashDereference' => 106
		}
	},
	{#State 91
		DEFAULT => -136
	},
	{#State 92
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'MY' => 157,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_QW' => 152,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			"]" => -195,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'TypeInner' => 156,
			'Operator' => 114,
			'ArrayReference' => 80,
			'OPTIONAL-46' => 153,
			'SubExpression' => 155,
			'ListElements' => 158,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'HashDereference' => 106
		}
	},
	{#State 93
		ACTIONS => {
			'VARIABLE_SYMBOL' => 95,
			'SELF' => 101,
			'LBRACE' => -213,
			'MY' => 157
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'TypeInner' => 161,
			'Variable' => 160,
			'OPTIONAL-51' => 159
		}
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 162
		},
		GOTOS => {
			'LoopLabel' => 163
		}
	},
	{#State 95
		DEFAULT => -231
	},
	{#State 96
		ACTIONS => {
			'COLON' => 164
		}
	},
	{#State 97
		ACTIONS => {
			'MY' => 157,
			'LBRACKET' => -198,
			'SELF' => 101,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'OPTIONAL-47' => 165,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 167,
			'TypeInner' => 166
		}
	},
	{#State 98
		ACTIONS => {
			"for" => -150,
			"foreach" => -150,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'OP01_NAMED_SCOLON' => 115,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED' => 120,
			'OP01_NAMED_VOID' => 121,
			"if" => 123,
			'LITERAL_STRING' => 124,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_PRINT' => 102,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'MY' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'' => -18,
			'LPAREN' => 81,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'WORD_UPPERCASE' => 88,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'OP19_LOOP_CONTROL' => 94,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'HashDereference' => 106,
			'OperatorVoid' => 107,
			'PAREN-36' => 108,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 129,
			'VariableDeclaration' => 112,
			'LoopLabel' => 96,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Conditional' => 87,
			'SubExpression' => 126,
			'Statement' => 122,
			'Literal' => 91,
			'HashReference' => 125,
			'Operator' => 114,
			'ArrayReference' => 80,
			'Operation' => 168,
			'OPTIONAL-37' => 117,
			'Expression' => 85,
			'VariableModification' => 119
		}
	},
	{#State 99
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93
		},
		GOTOS => {
			'HashDereference' => 106,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 169,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143
		}
	},
	{#State 100
		ACTIONS => {
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 170,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 101
		DEFAULT => -232
	},
	{#State 102
		ACTIONS => {
			'MY' => -113,
			'OP03_MATH_INC_DEC' => -113,
			'LITERAL_NUMBER' => -113,
			"undef" => -113,
			'OP01_QW' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'OP05_LOGICAL_NEG' => -113,
			"\@{" => -113,
			'FHREF_SYMBOL_BRACES' => 172,
			'OP01_OPEN' => -113,
			'SELF' => -113,
			'WORD_UPPERCASE' => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			'VARIABLE_SYMBOL' => -113,
			"%{" => -113,
			'LBRACKET' => -113,
			'LITERAL_STRING' => -113,
			'ARGV' => -113,
			'OP10_NAMED_UNARY' => -113,
			'LBRACE' => -113,
			'STDOUT_STDERR' => 171,
			'LPAREN' => -113,
			'WORD' => -113,
			'WORD_SCOPED' => -113,
			'OP01_NAMED' => -113,
			'OP01_CLOSE' => -113,
			'OP22_LOGICAL_NEG' => -113
		},
		GOTOS => {
			'PAREN-31' => 174,
			'OPTIONAL-32' => 173
		}
	},
	{#State 103
		ACTIONS => {
			'MY' => 175
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 176,
			'OP02_METHOD_THINARROW_NEW' => 177
		}
	},
	{#State 105
		ACTIONS => {
			'TYPE_FHREF' => 178,
			'WORD' => 59,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 106
		DEFAULT => -141
	},
	{#State 107
		DEFAULT => -153
	},
	{#State 108
		DEFAULT => -149
	},
	{#State 109
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 180
		}
	},
	{#State 110
		DEFAULT => -122
	},
	{#State 111
		DEFAULT => -80
	},
	{#State 112
		DEFAULT => -154
	},
	{#State 113
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 191,
			'ENV' => 192,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP23_LOGICAL_AND' => 182,
			'LITERAL_NUMBER' => 130,
			'OP07_STRING_REPEAT' => 194,
			"}" => 185,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP01_PRINT' => 198,
			'SELF' => 101,
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_OPEN' => 197,
			'OP01_NAMED_VOID' => 187,
			'LITERAL_STRING' => 124,
			'OP08_MATH_ADD_SUB' => 200,
			'OP10_NAMED_UNARY' => 203,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'OP19_LOOP_CONTROL' => 199,
			'OP24_LOGICAL_OR_XOR' => 188,
			'WORD' => 189,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'OP01_NAMED' => 190
		},
		GOTOS => {
			'Literal' => 201,
			'HashEntry' => 202,
			'Variable' => 183,
			'VariableSymbolOrSelf' => 109,
			'VarOrLitOrOpStrOrWord' => 181,
			'OpStringOrWord' => 184,
			'HashDereference' => 193
		}
	},
	{#State 114
		DEFAULT => -128
	},
	{#State 115
		DEFAULT => -79
	},
	{#State 116
		ACTIONS => {
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_QW' => 152,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'WORD_UPPERCASE' => 142,
			")" => -115,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'HashDereference' => 106,
			'ListElements' => 207,
			'OPTIONAL-33' => 206,
			'SubExpression' => 155,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 114,
			'ArrayReference' => 80,
			'WordScoped' => 104,
			'Expression' => 143,
			'TypeInner' => 156,
			'ArrayDereference' => 127,
			'ListElement' => 151
		}
	},
	{#State 117
		ACTIONS => {
			"for" => 211,
			"while" => 214,
			"foreach" => 212
		},
		GOTOS => {
			'LoopFor' => 208,
			'LoopWhile' => 213,
			'Loop' => 210,
			'LoopForEach' => 209
		}
	},
	{#State 118
		DEFAULT => -14
	},
	{#State 119
		ACTIONS => {
			";" => 215
		}
	},
	{#State 120
		ACTIONS => {
			'MY' => 157,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_QW' => 152,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'ListElement' => 217,
			'TypeInner' => 156,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 216,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'HashDereference' => 106
		}
	},
	{#State 121
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_QW' => 152,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'MY' => 157,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'TypeInner' => 156,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'HashReference' => 125,
			'Variable' => 141,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 218,
			'SubExpression' => 155
		}
	},
	{#State 122
		DEFAULT => -81
	},
	{#State 123
		ACTIONS => {
			'LPAREN' => 219
		}
	},
	{#State 124
		DEFAULT => -234
	},
	{#State 125
		DEFAULT => -140
	},
	{#State 126
		ACTIONS => {
			'OP13_BITWISE_AND' => 222,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => 232,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP06_REGEX_MATCH' => 223,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 236
		}
	},
	{#State 127
		DEFAULT => -139
	},
	{#State 128
		DEFAULT => -135
	},
	{#State 129
		ACTIONS => {
			'OP07_STRING_REPEAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP03_MATH_INC_DEC' => 238,
			'OP04_MATH_POW' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP19_VARIABLE_ASSIGN' => 237,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_STRING_CAT' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP18_TERNARY' => -137,
			'OP02_METHOD_THINARROW' => 240,
			'OP08_MATH_ADD_SUB' => -137,
			")" => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 239,
			'OP24_LOGICAL_OR_XOR' => -137
		}
	},
	{#State 130
		DEFAULT => -233
	},
	{#State 131
		ACTIONS => {
			'VARIABLE_SYMBOL' => 95,
			'SELF' => 101
		},
		GOTOS => {
			'Variable' => 241,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 132
		ACTIONS => {
			"our hashref \$properties" => 244,
			"use constant" => 44
		},
		GOTOS => {
			'Properties' => 243,
			'Constant' => 242
		}
	},
	{#State 133
		DEFAULT => -55
	},
	{#State 134
		ACTIONS => {
			"\$TYPED_" => 245
		}
	},
	{#State 135
		ACTIONS => {
			";" => 246
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
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 60,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 248
		}
	},
	{#State 139
		ACTIONS => {
			'OP13_BITWISE_AND' => 222,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => 232,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			")" => 249,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 236
		}
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_QW' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 216,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'Operator' => 114,
			'ArrayReference' => 80,
			'WordScoped' => 104,
			'Expression' => 143,
			'ListElement' => 250,
			'ArrayDereference' => 127,
			'TypeInner' => 156
		}
	},
	{#State 141
		ACTIONS => {
			"}" => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP08_STRING_CAT' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP03_MATH_INC_DEC' => 238,
			'OP23_LOGICAL_AND' => -137,
			'OP04_MATH_POW' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			"]" => -137,
			")" => -137,
			'OP18_TERNARY' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			";" => -137,
			'OP02_METHOD_THINARROW' => 240,
			'OP16_LOGICAL_OR' => -137
		}
	},
	{#State 142
		ACTIONS => {
			'LPAREN' => 149
		}
	},
	{#State 143
		DEFAULT => -134
	},
	{#State 144
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 251
		}
	},
	{#State 145
		DEFAULT => -86
	},
	{#State 146
		ACTIONS => {
			")" => -108,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -108,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP21_LIST_COMMA' => -108,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -108,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234
		}
	},
	{#State 147
		ACTIONS => {
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'SubExpression' => 252
		}
	},
	{#State 148
		DEFAULT => -78
	},
	{#State 149
		ACTIONS => {
			")" => 253
		}
	},
	{#State 150
		ACTIONS => {
			'OP15_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 221,
			"}" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => -98,
			")" => -98,
			'OP18_TERNARY' => -98,
			";" => -98,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => -98,
			"]" => -98
		}
	},
	{#State 151
		DEFAULT => -188,
		GOTOS => {
			'STAR-45' => 254
		}
	},
	{#State 152
		DEFAULT => -192
	},
	{#State 153
		ACTIONS => {
			"]" => 255
		}
	},
	{#State 154
		DEFAULT => -193
	},
	{#State 155
		ACTIONS => {
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			")" => -190,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -190,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -190,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP21_LIST_COMMA' => -190
		}
	},
	{#State 156
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayReference' => 80,
			'Operator' => 114,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 256,
			'HashDereference' => 106
		}
	},
	{#State 157
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 158
		DEFAULT => -194
	},
	{#State 159
		ACTIONS => {
			'LBRACE' => 113
		},
		GOTOS => {
			'HashReference' => 258
		}
	},
	{#State 160
		ACTIONS => {
			"}" => 259
		}
	},
	{#State 161
		DEFAULT => -212
	},
	{#State 162
		DEFAULT => -218
	},
	{#State 163
		ACTIONS => {
			";" => 260
		}
	},
	{#State 164
		DEFAULT => -148
	},
	{#State 165
		ACTIONS => {
			'LBRACKET' => 92
		},
		GOTOS => {
			'ArrayReference' => 261
		}
	},
	{#State 166
		DEFAULT => -197
	},
	{#State 167
		ACTIONS => {
			"}" => 262
		}
	},
	{#State 168
		DEFAULT => -16
	},
	{#State 169
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			")" => 263,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232
		}
	},
	{#State 170
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -90,
			";" => -90,
			'OP18_TERNARY' => -90,
			'OP16_LOGICAL_OR' => -90,
			")" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			"]" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP08_STRING_CAT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90
		}
	},
	{#State 171
		DEFAULT => -111
	},
	{#State 172
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'OP01_QW' => 152,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'MY' => 157,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'TypeInner' => 156,
			'ArrayDereference' => 127,
			'ListElement' => 151,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 264,
			'SubExpression' => 155
		}
	},
	{#State 173
		ACTIONS => {
			'MY' => 157,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			'OP01_QW' => 152,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'TypeInner' => 156,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'SubExpression' => 155,
			'ListElements' => 265
		}
	},
	{#State 174
		DEFAULT => -112
	},
	{#State 175
		ACTIONS => {
			'TYPE_FHREF' => 266
		}
	},
	{#State 176
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_QW' => 152,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'MY' => 157,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			")" => -125,
			'WORD_UPPERCASE' => 142,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93
		},
		GOTOS => {
			'ArrayReference' => 80,
			'OPTIONAL-34' => 267,
			'Operator' => 114,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'TypeInner' => 156,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'SubExpression' => 155,
			'ListElements' => 268
		}
	},
	{#State 177
		ACTIONS => {
			")" => 269
		}
	},
	{#State 178
		ACTIONS => {
			'FHREF_SYMBOL' => 270
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 271
		}
	},
	{#State 180
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			"]" => -176,
			'OP20_HASH_FATARROW' => -176,
			'COLON' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP02_HASH_THINARROW' => 274,
			")" => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			";" => -176,
			'OP02_METHOD_THINARROW' => -176,
			'OP02_ARRAY_THINARROW' => 273,
			'OP18_TERNARY' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			"}" => -176,
			'OP08_STRING_CAT' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP12_COMPARE_EQ_NE' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP04_MATH_POW' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP07_STRING_REPEAT' => -176,
			'OP13_BITWISE_AND' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 272
		}
	},
	{#State 181
		ACTIONS => {
			'OP20_HASH_FATARROW' => 275
		}
	},
	{#State 182
		DEFAULT => -242
	},
	{#State 183
		DEFAULT => -228
	},
	{#State 184
		DEFAULT => -230
	},
	{#State 185
		DEFAULT => -211
	},
	{#State 186
		DEFAULT => -247
	},
	{#State 187
		DEFAULT => -255
	},
	{#State 188
		DEFAULT => -241
	},
	{#State 189
		DEFAULT => -257
	},
	{#State 190
		DEFAULT => -252
	},
	{#State 191
		DEFAULT => -246
	},
	{#State 192
		DEFAULT => -205
	},
	{#State 193
		DEFAULT => -204
	},
	{#State 194
		DEFAULT => -251
	},
	{#State 195
		DEFAULT => -244
	},
	{#State 196
		DEFAULT => -250
	},
	{#State 197
		DEFAULT => -254
	},
	{#State 198
		DEFAULT => -256
	},
	{#State 199
		DEFAULT => -245
	},
	{#State 200
		DEFAULT => -249
	},
	{#State 201
		DEFAULT => -229
	},
	{#State 202
		DEFAULT => -209,
		GOTOS => {
			'STAR-50' => 276
		}
	},
	{#State 203
		DEFAULT => -248
	},
	{#State 204
		DEFAULT => -253
	},
	{#State 205
		DEFAULT => -243
	},
	{#State 206
		ACTIONS => {
			")" => 277
		}
	},
	{#State 207
		DEFAULT => -114
	},
	{#State 208
		DEFAULT => -163
	},
	{#State 209
		DEFAULT => -164
	},
	{#State 210
		DEFAULT => -152
	},
	{#State 211
		ACTIONS => {
			'MY' => 279,
			'LPAREN_MY' => 278
		}
	},
	{#State 212
		ACTIONS => {
			'MY' => 280
		}
	},
	{#State 213
		DEFAULT => -165
	},
	{#State 214
		ACTIONS => {
			'LPAREN_MY' => 281,
			'LPAREN' => 282
		}
	},
	{#State 215
		DEFAULT => -155
	},
	{#State 216
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP21_LIST_COMMA' => -190,
			'OP09_BITWISE_SHIFT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			")" => -83,
			'OP18_TERNARY' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			";" => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_STRING_CAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP04_MATH_POW' => -83,
			'OP23_LOGICAL_AND' => -83
		}
	},
	{#State 217
		ACTIONS => {
			'OP21_LIST_COMMA' => 283
		}
	},
	{#State 218
		ACTIONS => {
			";" => 284
		}
	},
	{#State 219
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'SubExpression' => 285,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'HashDereference' => 106,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80
		}
	},
	{#State 220
		ACTIONS => {
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'SubExpression' => 286,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 221
		ACTIONS => {
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'HashReference' => 125,
			'Variable' => 141,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 287
		}
	},
	{#State 222
		ACTIONS => {
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128
		},
		GOTOS => {
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 288,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 223
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 289
		}
	},
	{#State 224
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 290,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 225
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93
		},
		GOTOS => {
			'HashDereference' => 106,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 291,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 226
		ACTIONS => {
			'OP01_OPEN' => 103,
			'SELF' => 101,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86
		},
		GOTOS => {
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 292,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 227
		ACTIONS => {
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 293,
			'HashDereference' => 106
		}
	},
	{#State 228
		ACTIONS => {
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97
		},
		GOTOS => {
			'Variable' => 141,
			'HashReference' => 125,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 294,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 229
		ACTIONS => {
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 295
		}
	},
	{#State 230
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 296,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 106
		}
	},
	{#State 231
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 297,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143
		}
	},
	{#State 232
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 298,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'HashReference' => 125,
			'Literal' => 91,
			'HashDereference' => 106
		}
	},
	{#State 233
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'HashReference' => 125,
			'Variable' => 141,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 299
		}
	},
	{#State 234
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'SubExpression' => 300,
			'HashDereference' => 106
		}
	},
	{#State 235
		ACTIONS => {
			'SELF' => 101,
			'LITERAL_STRING' => 124,
			'LITERAL_NUMBER' => 130,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Literal' => 301,
			'Variable' => 303,
			'VariableOrLiteral' => 302
		}
	},
	{#State 236
		ACTIONS => {
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'SubExpression' => 304
		}
	},
	{#State 237
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'STDIN' => 307,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'SELF' => 101,
			'FHREF_SYMBOL_IN' => 306,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131
		},
		GOTOS => {
			'HashDereference' => 106,
			'Variable' => 141,
			'HashReference' => 125,
			'Literal' => 91,
			'SubExpressionOrInput' => 305,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 308,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 238
		DEFAULT => -88
	},
	{#State 239
		ACTIONS => {
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 309,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143
		}
	},
	{#State 240
		ACTIONS => {
			'LPAREN' => 310
		}
	},
	{#State 241
		DEFAULT => -87
	},
	{#State 242
		DEFAULT => -57
	},
	{#State 243
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 311
		}
	},
	{#State 244
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 245
		ACTIONS => {
			'WORD_UPPERCASE' => 313
		}
	},
	{#State 246
		DEFAULT => -43
	},
	{#State 247
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LPAREN' => 81,
			'OP19_LOOP_CONTROL' => 94,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'WORD_UPPERCASE' => 88,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_PRINT' => 102,
			"\@{" => 97,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'MY' => 105,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED' => 120,
			'OP01_NAMED_SCOLON' => 115,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			"if" => 123,
			'LITERAL_STRING' => 124,
			'OP01_NAMED_VOID' => 121,
			"for" => -150,
			"}" => 314,
			"foreach" => -150,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128
		},
		GOTOS => {
			'VariableDeclaration' => 112,
			'Variable' => 129,
			'VariableSymbolOrSelf' => 109,
			'OperatorVoid' => 107,
			'HashDereference' => 106,
			'PAREN-36' => 108,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'LoopLabel' => 96,
			'Literal' => 91,
			'HashReference' => 125,
			'Statement' => 122,
			'SubExpression' => 126,
			'Conditional' => 87,
			'VariableModification' => 119,
			'Expression' => 85,
			'OPTIONAL-37' => 117,
			'Operation' => 315,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 248
		ACTIONS => {
			'VARIABLE_SYMBOL' => 316
		}
	},
	{#State 249
		DEFAULT => -142
	},
	{#State 250
		ACTIONS => {
			'OP21_LIST_COMMA' => 317
		}
	},
	{#State 251
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_QW' => 152,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'MY' => 157,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'TypeInner' => 156,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 318,
			'SubExpression' => 155
		}
	},
	{#State 252
		ACTIONS => {
			'OP21_LIST_COMMA' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			"]" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP18_TERNARY' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			";" => -83,
			'OP16_LOGICAL_OR' => -83,
			")" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_STRING_CAT' => -83,
			"}" => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP04_MATH_POW' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP17_LIST_RANGE' => -83
		}
	},
	{#State 253
		DEFAULT => -129
	},
	{#State 254
		ACTIONS => {
			")" => -189,
			"]" => -189,
			'OP21_LIST_COMMA' => 320,
			";" => -189
		},
		GOTOS => {
			'PAREN-44' => 319
		}
	},
	{#State 255
		DEFAULT => -196
	},
	{#State 256
		ACTIONS => {
			")" => -191,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -191,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -191,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP21_LIST_COMMA' => -191,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233
		}
	},
	{#State 257
		ACTIONS => {
			"\$TYPED_" => 321
		}
	},
	{#State 258
		ACTIONS => {
			"}" => 322
		}
	},
	{#State 259
		DEFAULT => -214
	},
	{#State 260
		DEFAULT => -123
	},
	{#State 261
		ACTIONS => {
			"}" => 323
		}
	},
	{#State 262
		DEFAULT => -199
	},
	{#State 263
		DEFAULT => -91
	},
	{#State 264
		ACTIONS => {
			";" => 324
		}
	},
	{#State 265
		ACTIONS => {
			";" => 325
		}
	},
	{#State 266
		ACTIONS => {
			'FHREF_SYMBOL' => 326
		}
	},
	{#State 267
		ACTIONS => {
			")" => 327
		}
	},
	{#State 268
		DEFAULT => -124
	},
	{#State 269
		DEFAULT => -133
	},
	{#State 270
		ACTIONS => {
			";" => 328
		}
	},
	{#State 271
		ACTIONS => {
			";" => 331,
			'OP02_ARRAY_THINARROW' => 330,
			'OP19_VARIABLE_ASSIGN' => 329
		}
	},
	{#State 272
		DEFAULT => -174
	},
	{#State 273
		ACTIONS => {
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 332,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'HashDereference' => 106
		}
	},
	{#State 274
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 333,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 334
		}
	},
	{#State 275
		ACTIONS => {
			"undef" => -202,
			'OP03_MATH_INC_DEC' => -202,
			'LITERAL_NUMBER' => -202,
			'MY' => 157,
			'SELF' => -202,
			'OP01_OPEN' => -202,
			"\@{" => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP10_NAMED_UNARY' => -202,
			'LITERAL_STRING' => -202,
			'LBRACKET' => -202,
			"%{" => -202,
			'VARIABLE_SYMBOL' => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'WORD_UPPERCASE' => -202,
			'OP22_LOGICAL_NEG' => -202,
			'OP01_CLOSE' => -202,
			'OP01_NAMED' => -202,
			'WORD_SCOPED' => -202,
			'WORD' => -202,
			'LPAREN' => -202,
			'LBRACE' => -202
		},
		GOTOS => {
			'TypeInner' => 335,
			'OPTIONAL-48' => 336
		}
	},
	{#State 276
		ACTIONS => {
			'OP21_LIST_COMMA' => 338,
			"}" => 337
		},
		GOTOS => {
			'PAREN-49' => 339
		}
	},
	{#State 277
		ACTIONS => {
			";" => 340
		}
	},
	{#State 278
		ACTIONS => {
			'TYPE_INTEGER' => 341
		}
	},
	{#State 279
		ACTIONS => {
			'TYPE_INTEGER' => 342
		}
	},
	{#State 280
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 59,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 343
		}
	},
	{#State 281
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 344
		}
	},
	{#State 282
		ACTIONS => {
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'HashDereference' => 106,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 345
		}
	},
	{#State 283
		ACTIONS => {
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_QW' => 152,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'MY' => 157
		},
		GOTOS => {
			'HashDereference' => 106,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 346,
			'SubExpression' => 155,
			'ArrayReference' => 80,
			'Operator' => 114,
			'TypeInner' => 156,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143
		}
	},
	{#State 284
		DEFAULT => -120
	},
	{#State 285
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			")" => 347,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 222,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => 232,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP06_REGEX_MATCH' => 223
		}
	},
	{#State 286
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			"]" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93,
			'OP18_TERNARY' => -93,
			";" => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP16_LOGICAL_OR' => -93,
			"}" => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP08_STRING_CAT' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP04_MATH_POW' => 221
		}
	},
	{#State 287
		ACTIONS => {
			'OP18_TERNARY' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			")" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			"]" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP08_STRING_CAT' => -89,
			"}" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89
		}
	},
	{#State 288
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -102,
			'OP16_LOGICAL_OR' => -102,
			")" => -102,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			"}" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => -102,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -102,
			'OP12_COMPARE_EQ_NE' => 224
		}
	},
	{#State 289
		DEFAULT => -92
	},
	{#State 290
		ACTIONS => {
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			"}" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP17_LIST_RANGE' => -101,
			'OP06_REGEX_MATCH' => 223,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			"]" => -101,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -101,
			'OP18_TERNARY' => -101,
			'OP16_LOGICAL_OR' => -101,
			")" => -101
		}
	},
	{#State 291
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_STRING_CAT' => -94,
			"}" => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP06_REGEX_MATCH' => 223,
			'OP21_LIST_COMMA' => -94,
			"]" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			";" => -94,
			'OP18_TERNARY' => -94,
			'OP16_LOGICAL_OR' => -94,
			")" => -94
		}
	},
	{#State 292
		ACTIONS => {
			")" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP18_TERNARY' => -105,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -105,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233
		}
	},
	{#State 293
		ACTIONS => {
			'OP08_STRING_CAT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP13_BITWISE_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP06_REGEX_MATCH' => 223,
			'OP15_LOGICAL_AND' => -95,
			"]" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP18_TERNARY' => -95,
			")" => -95
		}
	},
	{#State 294
		ACTIONS => {
			")" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP18_TERNARY' => -97,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			"]" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP08_STRING_CAT' => 234
		}
	},
	{#State 295
		ACTIONS => {
			'OP21_LIST_COMMA' => -103,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP18_TERNARY' => -103,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -103,
			'OP16_LOGICAL_OR' => -103,
			")" => -103,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			"}" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -103,
			'OP04_MATH_POW' => 221,
			'OP15_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -103,
			'OP12_COMPARE_EQ_NE' => 224
		}
	},
	{#State 296
		ACTIONS => {
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -109,
			'OP15_LOGICAL_AND' => 232,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -109,
			'OP16_LOGICAL_OR' => 226,
			")" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			"]" => -109,
			'OP24_LOGICAL_OR_XOR' => -109
		}
	},
	{#State 297
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			"]" => -106,
			")" => -106,
			'OP18_TERNARY' => -106,
			";" => -106,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => 226,
			"}" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP15_LOGICAL_AND' => 232,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -106
		}
	},
	{#State 298
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -104,
			'OP14_BITWISE_OR_XOR' => 229,
			")" => -104,
			'OP18_TERNARY' => -104,
			";" => -104,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => -104,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => -104,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -104,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 299
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -100,
			'OP16_LOGICAL_OR' => -100,
			")" => -100,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => -100,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => 221,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => -100
		}
	},
	{#State 300
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => -96,
			'OP04_MATH_POW' => 221,
			"}" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => -96,
			'OP08_STRING_CAT' => -96,
			")" => -96,
			'OP18_TERNARY' => -96,
			";" => -96,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			"]" => -96
		}
	},
	{#State 301
		DEFAULT => -227
	},
	{#State 302
		ACTIONS => {
			'COLON' => 348
		}
	},
	{#State 303
		DEFAULT => -226
	},
	{#State 304
		ACTIONS => {
			'OP15_LOGICAL_AND' => 232,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			"}" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			")" => -110,
			'OP18_TERNARY' => 235,
			";" => -110,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => 226,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP09_BITWISE_SHIFT' => 228,
			"]" => -110,
			'OP14_BITWISE_OR_XOR' => 229
		}
	},
	{#State 305
		DEFAULT => -184
	},
	{#State 306
		DEFAULT => -144
	},
	{#State 307
		DEFAULT => -145
	},
	{#State 308
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			")" => -143,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			";" => -143
		}
	},
	{#State 309
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			")" => -185,
			'OP18_TERNARY' => 235,
			";" => -185,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => 226,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => 232,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230
		}
	},
	{#State 310
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_QW' => 152,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'MY' => 157,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			")" => -127,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'SubExpression' => 155,
			'ListElements' => 350,
			'ArrayReference' => 80,
			'OPTIONAL-35' => 349,
			'Operator' => 114,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'TypeInner' => 156,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 311
		ACTIONS => {
			"our" => 355,
			'LITERAL_NUMBER' => 353
		},
		GOTOS => {
			'Subroutine' => 354,
			'MethodOrSubroutine' => 352,
			'Method' => 351
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 356
		}
	},
	{#State 313
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 314
		ACTIONS => {
			";" => 358
		}
	},
	{#State 315
		DEFAULT => -46
	},
	{#State 316
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 359
		}
	},
	{#State 317
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_QW' => 152,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 103,
			'SELF' => 101
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operator' => 114,
			'TypeInner' => 156,
			'ArrayDereference' => 127,
			'ListElement' => 151,
			'Expression' => 143,
			'WordScoped' => 104,
			'HashDereference' => 106,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 360,
			'SubExpression' => 155
		}
	},
	{#State 318
		ACTIONS => {
			")" => 361
		}
	},
	{#State 319
		DEFAULT => -187
	},
	{#State 320
		ACTIONS => {
			'ARGV' => 154,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'MY' => 157,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_QW' => 152
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'ListElement' => 362,
			'TypeInner' => 156,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'SubExpression' => 155,
			'HashDereference' => 106
		}
	},
	{#State 321
		ACTIONS => {
			'OP01_NAMED' => 190,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'OP24_LOGICAL_OR_XOR' => 188,
			'WORD' => 189,
			'OP19_LOOP_CONTROL' => 199,
			'OP08_MATH_ADD_SUB' => 200,
			'OP10_NAMED_UNARY' => 203,
			'OP01_NAMED_VOID' => 187,
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_OPEN' => 197,
			'OP01_PRINT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP23_LOGICAL_AND' => 182,
			'OP07_STRING_REPEAT' => 194,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP12_COMPARE_EQ_NE' => 191
		},
		GOTOS => {
			'OpStringOrWord' => 363
		}
	},
	{#State 322
		DEFAULT => -215
	},
	{#State 323
		DEFAULT => -200
	},
	{#State 324
		DEFAULT => -117
	},
	{#State 325
		DEFAULT => -116
	},
	{#State 326
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 327
		DEFAULT => -131
	},
	{#State 328
		DEFAULT => -183
	},
	{#State 329
		ACTIONS => {
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'FHREF_SYMBOL_IN' => 306,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"undef" => 128,
			'OP10_NAMED_UNARY_SCOLON' => 367,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP01_NAMED_SCOLON' => 366,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'STDIN' => 307,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'SubExpressionOrInput' => 368,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'SubExpression' => 308,
			'ArrayReference' => 80,
			'OpNamedScolonOrSubExpIn' => 365,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 330
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101
		},
		GOTOS => {
			'SubExpression' => 369,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 106,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80
		}
	},
	{#State 331
		DEFAULT => -180
	},
	{#State 332
		ACTIONS => {
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP15_LOGICAL_AND' => 232,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP13_BITWISE_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP16_LOGICAL_OR' => 226,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP24_LOGICAL_OR_XOR' => 236,
			"]" => 370,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 333
		ACTIONS => {
			"}" => 371,
			'LPAREN' => -216,
			'OP02_METHOD_THINARROW_NEW' => -216
		}
	},
	{#State 334
		ACTIONS => {
			"}" => 372,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP15_LOGICAL_AND' => 232,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP13_BITWISE_AND' => 222,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226
		}
	},
	{#State 335
		DEFAULT => -201
	},
	{#State 336
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131
		},
		GOTOS => {
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 373,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 337
		DEFAULT => -210
	},
	{#State 338
		ACTIONS => {
			'OP07_STRING_REPEAT' => 194,
			'LITERAL_NUMBER' => 130,
			'OP23_LOGICAL_AND' => 182,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP12_COMPARE_EQ_NE' => 191,
			'ENV' => 192,
			'OP01_OPEN' => 197,
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_PRINT' => 198,
			'SELF' => 101,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP19_LOOP_CONTROL' => 199,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 203,
			'OP08_MATH_ADD_SUB' => 200,
			'LITERAL_STRING' => 124,
			'OP01_NAMED_VOID' => 187,
			'OP01_NAMED' => 190,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'WORD' => 189,
			'OP24_LOGICAL_OR_XOR' => 188
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Literal' => 201,
			'Variable' => 183,
			'HashEntry' => 374,
			'VarOrLitOrOpStrOrWord' => 181,
			'OpStringOrWord' => 184,
			'HashDereference' => 193
		}
	},
	{#State 339
		DEFAULT => -208
	},
	{#State 340
		DEFAULT => -119
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 375
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 377
		}
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 345
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			")" => 379,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 222,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => 232,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223
		}
	},
	{#State 346
		ACTIONS => {
			";" => 380
		}
	},
	{#State 347
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 348
		ACTIONS => {
			'LITERAL_NUMBER' => 130,
			'VARIABLE_SYMBOL' => 95,
			'SELF' => 101,
			'LITERAL_STRING' => 124
		},
		GOTOS => {
			'VariableOrLiteral' => 383,
			'Variable' => 303,
			'Literal' => 301,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 349
		ACTIONS => {
			")" => 384
		}
	},
	{#State 350
		DEFAULT => -126
	},
	{#State 351
		DEFAULT => -76
	},
	{#State 352
		DEFAULT => -59
	},
	{#State 353
		ACTIONS => {
			";" => 385
		}
	},
	{#State 354
		DEFAULT => -77
	},
	{#State 355
		ACTIONS => {
			'TYPE_METHOD' => 386,
			'WORD' => 59,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 61
		}
	},
	{#State 356
		ACTIONS => {
			'OP07_STRING_REPEAT' => 194,
			'OP23_LOGICAL_AND' => 182,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP01_OPEN' => 197,
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_PRINT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			"}" => 388,
			'OP19_LOOP_CONTROL' => 199,
			'OP10_NAMED_UNARY' => 203,
			'OP08_MATH_ADD_SUB' => 200,
			'OP01_NAMED_VOID' => 187,
			'OP01_NAMED' => 190,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'WORD' => 189,
			'OP24_LOGICAL_OR_XOR' => 188
		},
		GOTOS => {
			'OpStringOrWord' => 387,
			'HashEntryProperties' => 389
		}
	},
	{#State 357
		DEFAULT => -225
	},
	{#State 358
		DEFAULT => -48
	},
	{#State 359
		ACTIONS => {
			")" => 392,
			'OP21_LIST_COMMA' => 390
		},
		GOTOS => {
			'PAREN-19' => 391
		}
	},
	{#State 360
		ACTIONS => {
			")" => 393
		}
	},
	{#State 361
		DEFAULT => -82
	},
	{#State 362
		DEFAULT => -186
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 394
		}
	},
	{#State 364
		ACTIONS => {
			'LITERAL_STRING' => 395
		}
	},
	{#State 365
		DEFAULT => -181
	},
	{#State 366
		DEFAULT => -238
	},
	{#State 367
		DEFAULT => -239
	},
	{#State 368
		ACTIONS => {
			";" => 396
		}
	},
	{#State 369
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP13_BITWISE_AND' => 222,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			"]" => 397,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227
		}
	},
	{#State 370
		DEFAULT => -177
	},
	{#State 371
		DEFAULT => -179
	},
	{#State 372
		DEFAULT => -178
	},
	{#State 373
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP21_LIST_COMMA' => -203,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -203,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP13_BITWISE_AND' => 222,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP15_LOGICAL_AND' => 232
		}
	},
	{#State 374
		DEFAULT => -207
	},
	{#State 375
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 398
		}
	},
	{#State 376
		ACTIONS => {
			'LPAREN' => 399
		}
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 400
		}
	},
	{#State 378
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 402
		}
	},
	{#State 380
		DEFAULT => -121
	},
	{#State 381
		DEFAULT => -158,
		GOTOS => {
			'STAR-39' => 403
		}
	},
	{#State 382
		ACTIONS => {
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'LPAREN' => 81,
			'VARIABLE_SYMBOL' => 95,
			'OP19_LOOP_CONTROL' => 94,
			"%{" => 93,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'WORD_UPPERCASE' => 88,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_PRINT' => 102,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 97,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'MY' => 105,
			'OP01_NAMED' => 120,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED_SCOLON' => 115,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 124,
			"if" => 123,
			'OP01_NAMED_VOID' => 121,
			"foreach" => -150,
			"for" => -150,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128
		},
		GOTOS => {
			'OperatorVoid' => 107,
			'HashDereference' => 106,
			'PAREN-36' => 108,
			'VariableSymbolOrSelf' => 109,
			'VariableDeclaration' => 112,
			'Variable' => 129,
			'LoopLabel' => 96,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'Conditional' => 87,
			'PLUS-42' => 404,
			'SubExpression' => 126,
			'Statement' => 122,
			'Literal' => 91,
			'HashReference' => 125,
			'Operator' => 114,
			'ArrayReference' => 80,
			'Operation' => 405,
			'OPTIONAL-37' => 117,
			'VariableModification' => 119,
			'Expression' => 85
		}
	},
	{#State 383
		DEFAULT => -107
	},
	{#State 384
		DEFAULT => -132
	},
	{#State 385
		DEFAULT => -61
	},
	{#State 386
		ACTIONS => {
			'VARIABLE_SYMBOL' => 406
		}
	},
	{#State 387
		ACTIONS => {
			'OP20_HASH_FATARROW' => 407
		}
	},
	{#State 388
		ACTIONS => {
			";" => 408
		}
	},
	{#State 389
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 409
		}
	},
	{#State 390
		ACTIONS => {
			'MY' => 410
		}
	},
	{#State 391
		DEFAULT => -50
	},
	{#State 392
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 393
		DEFAULT => -84
	},
	{#State 394
		DEFAULT => -222
	},
	{#State 395
		ACTIONS => {
			'OP21_LIST_COMMA' => 412
		}
	},
	{#State 396
		DEFAULT => -240
	},
	{#State 397
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 398
		ACTIONS => {
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			'OP10_NAMED_UNARY_SCOLON' => 414,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED' => 147,
			'OP01_NAMED_SCOLON' => 417,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'OpNamedScolonOrSubExp' => 415,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 416,
			'HashDereference' => 106
		}
	},
	{#State 399
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'LBRACE' => 113
		},
		GOTOS => {
			'Operator' => 114,
			'ArrayReference' => 80,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'HashDereference' => 106,
			'SubExpression' => 418,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125
		}
	},
	{#State 400
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP10_NAMED_UNARY' => 90,
			'ARGV' => 154,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'MY' => 157,
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"\@{" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_QW' => 152,
			'SELF' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Variable' => 141,
			'HashReference' => 125,
			'Literal' => 91,
			'VariableSymbolOrSelf' => 109,
			'ListElements' => 419,
			'SubExpression' => 155,
			'HashDereference' => 106,
			'TypeInner' => 156,
			'ListElement' => 151,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 401
		ACTIONS => {
			"undef" => 128,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			'SELF' => 101,
			'FHREF_SYMBOL_IN' => 306,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'STDIN' => 307,
			'LITERAL_STRING' => 124,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED' => 147,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LBRACE' => 113
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'SubExpressionOrInput' => 420,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 308,
			'HashDereference' => 106,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayReference' => 80,
			'Operator' => 114
		}
	},
	{#State 402
		DEFAULT => -169
	},
	{#State 403
		ACTIONS => {
			"\@{" => -161,
			'OP05_LOGICAL_NEG' => -161,
			'OP05_MATH_NEG_LPAREN' => -161,
			"while" => -161,
			'OP01_PRINT' => -161,
			"elsif" => 421,
			'SELF' => -161,
			'OP01_OPEN' => -161,
			'MY' => -161,
			'OP19_LOOP_CONTROL_SCOLON' => -161,
			'OP10_NAMED_UNARY_SCOLON' => -161,
			'' => -161,
			'LPAREN' => -161,
			'OP01_CLOSE' => -161,
			'OP22_LOGICAL_NEG' => -161,
			'CONSTANT_CALL_SCOPED' => -161,
			'WORD_UPPERCASE' => -161,
			'OP01_NAMED_VOID_SCOLON' => -161,
			'OP10_NAMED_UNARY' => -161,
			'LBRACKET' => -161,
			"%{" => -161,
			'OP19_LOOP_CONTROL' => -161,
			'VARIABLE_SYMBOL' => -161,
			"for" => -161,
			"}" => -161,
			"foreach" => -161,
			"undef" => -161,
			'OP03_MATH_INC_DEC' => -161,
			'LITERAL_NUMBER' => -161,
			'WORD' => -161,
			'WORD_SCOPED' => -161,
			'LBRACE' => -161,
			"else" => 424,
			'OP01_NAMED_SCOLON' => -161,
			'OP01_NAMED_VOID_LPAREN' => -161,
			'OP01_NAMED' => -161,
			'OP01_NAMED_VOID' => -161,
			"if" => -161,
			'LITERAL_STRING' => -161
		},
		GOTOS => {
			'PAREN-40' => 425,
			'OPTIONAL-41' => 422,
			'PAREN-38' => 423
		}
	},
	{#State 404
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 89,
			'WORD_UPPERCASE' => 88,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'OP19_LOOP_CONTROL' => 94,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90,
			'LPAREN' => 81,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'MY' => 105,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 99,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_PRINT' => 102,
			'OP01_NAMED_VOID' => 121,
			'LITERAL_STRING' => 124,
			"if" => 123,
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'OP01_NAMED' => 120,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED_SCOLON' => 115,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			"}" => 426,
			"foreach" => -150,
			"for" => -150
		},
		GOTOS => {
			'SubExpression' => 126,
			'Statement' => 122,
			'Literal' => 91,
			'HashReference' => 125,
			'Conditional' => 87,
			'OPTIONAL-37' => 117,
			'VariableModification' => 119,
			'Expression' => 85,
			'Operator' => 114,
			'Operation' => 427,
			'ArrayReference' => 80,
			'VariableSymbolOrSelf' => 109,
			'VariableDeclaration' => 112,
			'Variable' => 129,
			'OperatorVoid' => 107,
			'PAREN-36' => 108,
			'HashDereference' => 106,
			'WordScoped' => 104,
			'ArrayDereference' => 127,
			'LoopLabel' => 96
		}
	},
	{#State 405
		DEFAULT => -172
	},
	{#State 406
		ACTIONS => {
			"= sub {" => 428
		}
	},
	{#State 407
		ACTIONS => {
			'MY' => 429
		},
		GOTOS => {
			'TypeInnerProperties' => 430
		}
	},
	{#State 408
		DEFAULT => -66
	},
	{#State 409
		ACTIONS => {
			"}" => 433,
			'OP21_LIST_COMMA' => 431
		},
		GOTOS => {
			'PAREN-25' => 432
		}
	},
	{#State 410
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 59,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 434
		}
	},
	{#State 411
		ACTIONS => {
			"\@_;" => 435
		}
	},
	{#State 412
		ACTIONS => {
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 436,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 114,
			'ArrayReference' => 80,
			'Expression' => 143,
			'WordScoped' => 104,
			'ArrayDereference' => 127
		}
	},
	{#State 413
		ACTIONS => {
			"undef" => 437
		}
	},
	{#State 414
		DEFAULT => -236
	},
	{#State 415
		ACTIONS => {
			'VARIABLE_SYMBOL' => 438
		}
	},
	{#State 416
		ACTIONS => {
			'OP15_LOGICAL_AND' => 232,
			'OP06_REGEX_MATCH' => 223,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP13_BITWISE_AND' => 222,
			'OP07_STRING_REPEAT' => 220,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP18_TERNARY' => 235,
			";" => 439,
			'OP08_MATH_ADD_SUB' => 227,
			'OP16_LOGICAL_OR' => 226,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229
		}
	},
	{#State 417
		DEFAULT => -235
	},
	{#State 418
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_STRING_CAT' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 440,
			'OP06_REGEX_MATCH' => 223,
			'OP15_LOGICAL_AND' => 232,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP13_BITWISE_AND' => 222,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => 226,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235
		}
	},
	{#State 419
		ACTIONS => {
			")" => 441
		}
	},
	{#State 420
		ACTIONS => {
			")" => 442
		}
	},
	{#State 421
		ACTIONS => {
			'LPAREN' => 443
		}
	},
	{#State 422
		DEFAULT => -162
	},
	{#State 423
		DEFAULT => -157
	},
	{#State 424
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 425
		DEFAULT => -160
	},
	{#State 426
		DEFAULT => -173
	},
	{#State 427
		DEFAULT => -171
	},
	{#State 428
		ACTIONS => {
			'MY' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			"\@{" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP05_LOGICAL_NEG' => -68,
			"while" => -68,
			'OP01_PRINT' => -68,
			'SELF' => -68,
			'OP01_OPEN' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'WORD_UPPERCASE' => -68,
			'OP10_NAMED_UNARY' => -68,
			'LBRACKET' => -68,
			'OP19_LOOP_CONTROL' => -68,
			"%{" => -68,
			'VARIABLE_SYMBOL' => -68,
			'LPAREN' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP01_CLOSE' => -68,
			"undef" => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LITERAL_NUMBER' => -68,
			"for" => -68,
			"foreach" => -68,
			"}" => -68,
			'LPAREN_MY' => 445,
			'OP01_NAMED_VOID' => -68,
			"if" => -68,
			'LITERAL_STRING' => -68,
			'WORD' => -68,
			'WORD_SCOPED' => -68,
			'LBRACE' => -68,
			'OP01_NAMED_SCOLON' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP01_NAMED' => -68
		},
		GOTOS => {
			'MethodArguments' => 446,
			'OPTIONAL-27' => 447
		}
	},
	{#State 429
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 59,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 448
		}
	},
	{#State 430
		DEFAULT => -206
	},
	{#State 431
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'OP01_NAMED' => 190,
			'OP24_LOGICAL_OR_XOR' => 188,
			'WORD' => 189,
			'OP08_MATH_ADD_SUB' => 200,
			'OP10_NAMED_UNARY' => 203,
			'OP19_LOOP_CONTROL' => 199,
			'OP01_NAMED_VOID' => 187,
			'OP01_PRINT' => 198,
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_OPEN' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP23_LOGICAL_AND' => 182,
			'OP07_STRING_REPEAT' => 194,
			'OP12_COMPARE_EQ_NE' => 191
		},
		GOTOS => {
			'HashEntryProperties' => 449,
			'OpStringOrWord' => 387
		}
	},
	{#State 432
		DEFAULT => -63
	},
	{#State 433
		ACTIONS => {
			";" => 450
		}
	},
	{#State 434
		ACTIONS => {
			'VARIABLE_SYMBOL' => 451
		}
	},
	{#State 435
		DEFAULT => -52
	},
	{#State 436
		ACTIONS => {
			"]" => -85,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP16_LOGICAL_OR' => 226,
			";" => -85,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			")" => -85,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			'OP13_BITWISE_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP06_REGEX_MATCH' => 223,
			'OP15_LOGICAL_AND' => 232
		}
	},
	{#State 437
		ACTIONS => {
			";" => 452
		}
	},
	{#State 438
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 453
		}
	},
	{#State 439
		DEFAULT => -237
	},
	{#State 440
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'LBRACE' => 113
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 454,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 106
		}
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 442
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 456
		}
	},
	{#State 443
		ACTIONS => {
			'LBRACE' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128
		},
		GOTOS => {
			'HashDereference' => 106,
			'HashReference' => 125,
			'Literal' => 91,
			'Variable' => 141,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 457,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 444
		DEFAULT => -159
	},
	{#State 445
		ACTIONS => {
			'WORD' => 59,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 458
		}
	},
	{#State 446
		DEFAULT => -67
	},
	{#State 447
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 459
		}
	},
	{#State 448
		ACTIONS => {
			"\$TYPED_" => 460
		}
	},
	{#State 449
		DEFAULT => -62
	},
	{#State 450
		DEFAULT => -65
	},
	{#State 451
		DEFAULT => -49
	},
	{#State 452
		DEFAULT => -182
	},
	{#State 453
		ACTIONS => {
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_NAMED_SCOLON' => 417,
			'LBRACE' => 113,
			'LPAREN' => 81,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP10_NAMED_UNARY_SCOLON' => 414,
			"undef" => 128
		},
		GOTOS => {
			'HashDereference' => 106,
			'VariableSymbolOrSelf' => 109,
			'Literal' => 91,
			'HashReference' => 125,
			'Variable' => 141,
			'SubExpression' => 416,
			'ArrayReference' => 80,
			'Operator' => 114,
			'ArrayDereference' => 127,
			'OpNamedScolonOrSubExp' => 461,
			'Expression' => 143,
			'WordScoped' => 104
		}
	},
	{#State 454
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => -106,
			'OP16_LOGICAL_OR' => 226,
			")" => 462,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 222,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => -106,
			'OP07_STRING_REPEAT' => 220,
			'OP15_LOGICAL_AND' => 232,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 455
		DEFAULT => -168
	},
	{#State 456
		DEFAULT => -170
	},
	{#State 457
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			")" => 463,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP15_LOGICAL_AND' => 232,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP13_BITWISE_AND' => 222,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220
		}
	},
	{#State 458
		ACTIONS => {
			'SELF' => 464
		}
	},
	{#State 459
		ACTIONS => {
			"}" => 465,
			"foreach" => -150,
			"for" => -150,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 120,
			'OP01_NAMED_VOID_LPAREN' => 116,
			'OP01_NAMED_SCOLON' => 115,
			'OP01_NAMED_VOID' => 121,
			'LITERAL_STRING' => 124,
			"if" => 123,
			'OP05_MATH_NEG_LPAREN' => 99,
			"while" => -150,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'OP01_PRINT' => 102,
			'MY' => 105,
			'OP10_NAMED_UNARY_SCOLON' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'LPAREN' => 81,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84,
			'WORD_UPPERCASE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'CONSTANT_CALL_SCOPED' => 86,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'OP19_LOOP_CONTROL' => 94,
			'LBRACKET' => 92,
			'OP10_NAMED_UNARY' => 90
		},
		GOTOS => {
			'ArrayReference' => 80,
			'Operation' => 466,
			'Operator' => 114,
			'Expression' => 85,
			'VariableModification' => 119,
			'OPTIONAL-37' => 117,
			'Conditional' => 87,
			'Literal' => 91,
			'HashReference' => 125,
			'Statement' => 122,
			'SubExpression' => 126,
			'LoopLabel' => 96,
			'ArrayDereference' => 127,
			'WordScoped' => 104,
			'PAREN-36' => 108,
			'OperatorVoid' => 107,
			'HashDereference' => 106,
			'VariableDeclaration' => 112,
			'Variable' => 129,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 460
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 186,
			'OP01_OPEN' => 197,
			'OP01_PRINT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP23_LOGICAL_AND' => 182,
			'OP07_STRING_REPEAT' => 194,
			'OP19_LOOP_CONTROL_SCOLON' => 195,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP01_NAMED' => 190,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_CLOSE' => 204,
			'OP24_LOGICAL_OR_XOR' => 188,
			'WORD' => 189,
			'OP19_LOOP_CONTROL' => 199,
			'OP08_MATH_ADD_SUB' => 200,
			'OP10_NAMED_UNARY' => 203,
			'OP01_NAMED_VOID' => 187
		},
		GOTOS => {
			'OpStringOrWord' => 467
		}
	},
	{#State 461
		ACTIONS => {
			'LITERAL_NUMBER' => 130,
			'OP03_MATH_INC_DEC' => 131,
			"undef" => 128,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'OP01_NAMED' => 147,
			'OP01_CLOSE' => 83,
			'OP22_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'VariableModification' => 469,
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayReference' => 80,
			'Operator' => 114,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 129,
			'Literal' => 91,
			'HashReference' => 125,
			'SubExpression' => 468,
			'SubExpressionOrVarMod' => 470,
			'HashDereference' => 106
		}
	},
	{#State 462
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 471
		}
	},
	{#State 463
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 464
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 473
		}
	},
	{#State 465
		ACTIONS => {
			";" => 474
		}
	},
	{#State 466
		DEFAULT => -69
	},
	{#State 467
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 475,
			'OP19_VARIABLE_ASSIGN' => 476
		}
	},
	{#State 468
		ACTIONS => {
			'OP16_LOGICAL_OR' => 226,
			'OP18_TERNARY' => 235,
			'OP08_MATH_ADD_SUB' => 227,
			")" => -146,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP07_STRING_REPEAT' => 220,
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP13_BITWISE_AND' => 222,
			'OP06_REGEX_MATCH' => 223,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP15_LOGICAL_AND' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 469
		DEFAULT => -147
	},
	{#State 470
		ACTIONS => {
			")" => 477
		}
	},
	{#State 471
		DEFAULT => -166
	},
	{#State 472
		DEFAULT => -156
	},
	{#State 473
		ACTIONS => {
			'OP21_LIST_COMMA' => 479,
			")" => 478
		},
		GOTOS => {
			'PAREN-29' => 480
		}
	},
	{#State 474
		DEFAULT => -71
	},
	{#State 475
		ACTIONS => {
			"undef" => 128,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 97,
			'SELF' => 101,
			'OP01_OPEN' => 103,
			'CONSTANT_CALL_SCOPED' => 86,
			'WORD_UPPERCASE' => 142,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 95,
			"%{" => 93,
			'LPAREN' => 81,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'OP01_NAMED' => 147
		},
		GOTOS => {
			'SubExpression' => 481,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 141,
			'Literal' => 91,
			'HashReference' => 125,
			'HashDereference' => 106,
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80
		}
	},
	{#State 476
		ACTIONS => {
			"%{" => 93,
			'VARIABLE_SYMBOL' => 95,
			'OP10_NAMED_UNARY' => 90,
			'LBRACKET' => 92,
			'LITERAL_STRING' => 124,
			'WORD_UPPERCASE' => 142,
			'CONSTANT_CALL_SCOPED' => 86,
			'OP01_NAMED' => 147,
			'OP22_LOGICAL_NEG' => 84,
			'OP01_CLOSE' => 83,
			'LBRACE' => 113,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			'LPAREN' => 81,
			'OP03_MATH_INC_DEC' => 131,
			'LITERAL_NUMBER' => 130,
			"undef" => 128,
			'OP01_OPEN' => 103,
			'SELF' => 101,
			"\@{" => 97,
			'OP05_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'WordScoped' => 104,
			'Expression' => 143,
			'ArrayDereference' => 127,
			'Operator' => 114,
			'ArrayReference' => 80,
			'SubExpression' => 482,
			'Literal' => 91,
			'Variable' => 141,
			'HashReference' => 125,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 106
		}
	},
	{#State 477
		ACTIONS => {
			'LBRACE' => 382
		},
		GOTOS => {
			'CodeBlock' => 483
		}
	},
	{#State 478
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 484
		}
	},
	{#State 479
		ACTIONS => {
			'MY' => 485
		}
	},
	{#State 480
		DEFAULT => -73
	},
	{#State 481
		ACTIONS => {
			'OP04_MATH_POW' => 221,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 220,
			'OP13_BITWISE_AND' => 222,
			'OP17_LIST_RANGE' => 231,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP06_REGEX_MATCH' => 223,
			'OP15_LOGICAL_AND' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP16_LOGICAL_OR' => 226,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP14_BITWISE_OR_XOR' => 229,
			"]" => 486,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 236
		}
	},
	{#State 482
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 235,
			'OP16_LOGICAL_OR' => 226,
			'OP24_LOGICAL_OR_XOR' => 236,
			'OP21_LIST_COMMA' => -223,
			'OP14_BITWISE_OR_XOR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => 232,
			'OP12_COMPARE_EQ_NE' => 224,
			'OP17_LIST_RANGE' => 231,
			'OP06_REGEX_MATCH' => 223,
			'OP13_BITWISE_AND' => 222,
			'OP23_LOGICAL_AND' => 230,
			'OP04_MATH_POW' => 221,
			'OP07_STRING_REPEAT' => 220,
			"}" => -223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_STRING_CAT' => 234
		}
	},
	{#State 483
		DEFAULT => -167
	},
	{#State 484
		ACTIONS => {
			"\@_;" => 487
		}
	},
	{#State 485
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'WORD' => 59,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 488
		}
	},
	{#State 486
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 489
		}
	},
	{#State 487
		DEFAULT => -75
	},
	{#State 488
		ACTIONS => {
			'VARIABLE_SYMBOL' => 490
		}
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
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6949 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6956 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7084 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7091 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7277 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7312 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7528 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7561 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7583 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7594 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7704 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7715 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7737 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7836 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7850 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7857 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7882 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7893 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7904 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7915 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7926 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7948 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7987 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7998 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8009 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8031 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8042 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8053 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8064 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8075 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8086 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8097 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8119 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8130 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8141 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8152 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8163 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8174 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8185 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8196 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8207 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8214 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8221 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8228 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8239 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8250 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8261 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8272 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8283 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8290 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8297 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8304 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8311 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8318 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8325 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_162
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8336 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8347 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8358 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8369 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8380 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8391 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_168
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8402 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8413 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8424 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8431 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8438 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8449 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8456 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8463 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8474 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8485 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8496 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8507 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8518 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8529 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8540 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8551 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8562 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8573 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8580 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8587 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8594 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8605 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8616 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8627 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8638 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8663 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8674 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8688 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8699 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8710 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8724 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8735 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8746 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8757 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_206
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8768 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8775 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8782 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8789 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8800 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8818 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8825 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8836 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8847 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8858 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8869 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8880 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8891 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8902 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8913 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8924 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8935 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8946 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_225
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8957 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8968 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8979 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_228
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8990 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_229
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9001 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9012 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9023 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9034 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9045 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9056 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_235
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9067 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9078 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9089 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_238
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9100 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9111 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9122 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_241
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9133 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_242
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9144 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9155 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9166 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9177 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9188 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9199 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9210 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9221 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9232 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9243 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9254 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9265 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9276 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9287 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9298 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9309 lib/RPerl/Grammar.pm
	]
],
#line 9312 lib/RPerl/Grammar.pm
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

#line 235 "lib/RPerl/Grammar.eyp"


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


#line 9774 lib/RPerl/Grammar.pm



1;
