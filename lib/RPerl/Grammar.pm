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
    our $VERSION = 0.002_900;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|\=\ sub\ \{|foreach|elsif|while|undef|else|\@_\;|for|our|\%\{|\@\{|if|\;|\}|\]|\))}gc and return ($1, $1);

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
			'SHEBANG' => 3,
			"package" => -20,
			"## no critic qw(" => 9,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'PAREN-1' => 7,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 1,
			'Critic' => 2,
			'CompileUnit' => 6,
			'PLUS-2' => 5,
			'Program' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"use constant" => -27,
			'USE' => -27,
			"use parent qw(" => 14,
			"our" => -27,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'Class' => 12,
			'STAR-11' => 13,
			'Module' => 10,
			'Package' => 11
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 9,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'Critic' => 15,
			'OPTIONAL-3' => 16
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 9,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'PAREN-1' => 17,
			'Critic' => 2,
			'ModuleHeader' => 1
		}
	},
	{#State 6
		ACTIONS => {
			'' => 18
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => 20,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 22
		},
		GOTOS => {
			'PLUS-16' => 21
		}
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		DEFAULT => -24
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		ACTIONS => {
			"our" => -29,
			"## no critic qw(" => 9,
			'USE' => -29,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 23,
			'Critic' => 24
		}
	},
	{#State 14
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			'USE_RPERL' => 28
		}
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			"package" => 29
		}
	},
	{#State 20
		DEFAULT => -21
	},
	{#State 21
		ACTIONS => {
			'WORD' => 31,
			")" => 30
		}
	},
	{#State 22
		DEFAULT => -39
	},
	{#State 23
		ACTIONS => {
			"our" => -31,
			'USE' => 32,
			"use constant" => -31
		},
		GOTOS => {
			'Include' => 34,
			'STAR-13' => 33
		}
	},
	{#State 24
		DEFAULT => -26
	},
	{#State 25
		DEFAULT => -216
	},
	{#State 26
		DEFAULT => -217
	},
	{#State 27
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 30
		DEFAULT => -40
	},
	{#State 31
		DEFAULT => -38
	},
	{#State 32
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => 42,
			"our" => 43
		},
		GOTOS => {
			'Constant' => 40,
			'Subroutine' => 41,
			'PLUS-14' => 44
		}
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			"use warnings;" => 46
		}
	},
	{#State 37
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'OP01_QW' => 50,
			";" => 49
		}
	},
	{#State 40
		DEFAULT => -30
	},
	{#State 41
		DEFAULT => -33
	},
	{#State 42
		ACTIONS => {
			'WORD_UPPERCASE' => 51
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'USE' => 32
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 59
		},
		GOTOS => {
			'OPTIONAL-15' => 60
		}
	},
	{#State 47
		ACTIONS => {
			'OP01_CLOSE' => -11,
			'LBRACE' => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"foreach" => -11,
			'SELF' => -11,
			'MY' => -11,
			'LITERAL_NUMBER' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'WORD_SCOPED' => -11,
			"\@{" => -11,
			"## no critic qw(" => 9,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD' => -11,
			'LPAREN' => -11,
			'OP01_PRINT' => -11,
			"if" => -11,
			'OP01_OPEN' => -11,
			'USE' => -11,
			"while" => -11,
			"use constant" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"%{" => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			"undef" => -11,
			'OP22_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'Critic' => 62,
			'STAR-5' => 61
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		DEFAULT => -41
	},
	{#State 50
		ACTIONS => {
			";" => 64
		}
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
		}
	},
	{#State 52
		DEFAULT => -220
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 54
		DEFAULT => -219
	},
	{#State 55
		DEFAULT => -221
	},
	{#State 56
		DEFAULT => -32
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 68
		}
	},
	{#State 59
		DEFAULT => -35
	},
	{#State 60
		ACTIONS => {
			"our" => 69
		}
	},
	{#State 61
		ACTIONS => {
			'OP01_OPEN' => -13,
			"if" => -13,
			'OP01_PRINT' => -13,
			'LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'WORD' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"undef" => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			'OP01_NAMED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"use constant" => -13,
			'USE' => 32,
			"while" => -13,
			'SELF' => -13,
			'MY' => -13,
			'LITERAL_STRING' => -13,
			"foreach" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13,
			'OP01_CLOSE' => -13,
			"our" => -13,
			"for" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"\@{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LBRACKET' => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 70,
			'Include' => 71
		}
	},
	{#State 62
		DEFAULT => -8
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		DEFAULT => -42
	},
	{#State 65
		ACTIONS => {
			'MY' => 72
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
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
			'USE' => -56,
			"our hashref \$properties" => -56,
			"## no critic qw(" => 9,
			"use constant" => -56
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-22' => 76
		}
	},
	{#State 69
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 77
		}
	},
	{#State 70
		ACTIONS => {
			'WORD_UPPERCASE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD' => -15,
			'LPAREN' => -15,
			'OP01_PRINT' => -15,
			"if" => -15,
			'OP01_OPEN' => -15,
			"while" => -15,
			"use constant" => 42,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			"%{" => -15,
			'OP01_NAMED' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			"undef" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_CLOSE' => -15,
			'LBRACE' => -15,
			"our" => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"foreach" => -15,
			'SELF' => -15,
			'MY' => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'WORD_SCOPED' => -15,
			"\@{" => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"for" => -15
		},
		GOTOS => {
			'STAR-7' => 79,
			'Constant' => 78
		}
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 80
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 82
		},
		GOTOS => {
			'Literal' => 83
		}
	},
	{#State 74
		ACTIONS => {
			'LPAREN_MY' => 84,
			'SELF' => -45,
			'MY' => -45,
			'LITERAL_STRING' => -45,
			"foreach" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'OP01_NAMED_VOID' => -45,
			'LBRACE' => -45,
			'OP01_CLOSE' => -45,
			"for" => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			"\@{" => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'LBRACKET' => -45,
			'WORD_SCOPED' => -45,
			'LITERAL_NUMBER' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_OPEN' => -45,
			"if" => -45,
			'OP01_PRINT' => -45,
			'LPAREN' => -45,
			'WORD_UPPERCASE' => -45,
			'WORD' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP10_NAMED_UNARY' => -45,
			"undef" => -45,
			'OP22_LOGICAL_NEG' => -45,
			"}" => -45,
			'OP01_NAMED_SCOLON' => -45,
			"%{" => -45,
			'OP01_NAMED' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			"while" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 85,
			'SubroutineArguments' => 86
		}
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 32,
			"use constant" => -58
		},
		GOTOS => {
			'STAR-23' => 88,
			'Include' => 87
		}
	},
	{#State 77
		DEFAULT => -37
	},
	{#State 78
		DEFAULT => -12
	},
	{#State 79
		ACTIONS => {
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 105,
			'OP01_NAMED_SCOLON' => 106,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"while" => -150,
			'VARIABLE_SYMBOL' => 108,
			'OP01_NAMED_VOID_SCOLON' => 109,
			"if" => 92,
			'OP01_OPEN' => 90,
			'WORD_UPPERCASE' => 98,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			'OP01_PRINT' => 94,
			"\@{" => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			"for" => -150,
			'OP05_MATH_NEG_LPAREN' => 138,
			'OP19_LOOP_CONTROL' => 136,
			'LITERAL_NUMBER' => 82,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			"foreach" => -150,
			'SELF' => 113,
			'MY' => 112,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			"our" => 43,
			'OP01_NAMED_VOID' => 119
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 107,
			'OperatorVoid' => 125,
			'WordScoped' => 126,
			'VariableModification' => 123,
			'Subroutine' => 99,
			'HashReference' => 137,
			'Expression' => 111,
			'VariableSymbolOrSelf' => 134,
			'OPTIONAL-37' => 133,
			'Literal' => 110,
			'Variable' => 132,
			'Operation' => 131,
			'Conditional' => 117,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'LoopLabel' => 91,
			'PLUS-8' => 89,
			'Statement' => 121,
			'PAREN-36' => 96,
			'HashDereference' => 95,
			'VariableDeclaration' => 118
		}
	},
	{#State 80
		ACTIONS => {
			"\$TYPED_" => 139
		}
	},
	{#State 81
		DEFAULT => -234
	},
	{#State 82
		DEFAULT => -233
	},
	{#State 83
		ACTIONS => {
			";" => 140
		}
	},
	{#State 84
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 141
		}
	},
	{#State 85
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 142
		}
	},
	{#State 86
		DEFAULT => -44
	},
	{#State 87
		DEFAULT => -55
	},
	{#State 88
		ACTIONS => {
			"use constant" => 42,
			"our hashref \$properties" => 145
		},
		GOTOS => {
			'Properties' => 143,
			'Constant' => 144
		}
	},
	{#State 89
		ACTIONS => {
			"foreach" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			'LITERAL_STRING' => 81,
			'MY' => 112,
			'SELF' => 113,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'OP01_NAMED_VOID' => 119,
			'LBRACKET' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"\@{" => 129,
			"for" => -150,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'OP19_LOOP_CONTROL' => 136,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			"if" => 92,
			'OP01_OPEN' => 90,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 98,
			'OP01_PRINT' => 94,
			'LPAREN' => 93,
			'OP01_NAMED_SCOLON' => 106,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 105,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"while" => -150,
			'' => -18,
			'OP01_NAMED_VOID_SCOLON' => 109,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'VariableDeclaration' => 118,
			'PAREN-36' => 96,
			'HashDereference' => 95,
			'Statement' => 121,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'LoopLabel' => 91,
			'Conditional' => 117,
			'Variable' => 132,
			'Operation' => 146,
			'OPTIONAL-37' => 133,
			'Literal' => 110,
			'Expression' => 111,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'VariableModification' => 123,
			'OperatorVoid' => 125,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 107
		}
	},
	{#State 90
		ACTIONS => {
			'MY' => 147
		}
	},
	{#State 91
		ACTIONS => {
			'COLON' => 148
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 149
		}
	},
	{#State 93
		ACTIONS => {
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP01_PRINT' => 153,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 151,
			'LBRACKET' => 127,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'WordScoped' => 126,
			'SubExpression' => 152,
			'ArrayReference' => 130,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 94
		ACTIONS => {
			'STDOUT_STDERR' => 157,
			'WORD_SCOPED' => -113,
			'VARIABLE_SYMBOL' => -113,
			'LITERAL_NUMBER' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			"undef" => -113,
			'OP10_NAMED_UNARY' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'ARGV' => -113,
			"\@{" => -113,
			"%{" => -113,
			'OP05_LOGICAL_NEG' => -113,
			'OP01_NAMED' => -113,
			'LBRACKET' => -113,
			'OP01_QW' => -113,
			'LPAREN' => -113,
			'OP01_CLOSE' => -113,
			'FHREF_SYMBOL_BRACES' => 158,
			'WORD_UPPERCASE' => -113,
			'LBRACE' => -113,
			'OP03_MATH_INC_DEC' => -113,
			'WORD' => -113,
			'SELF' => -113,
			'MY' => -113,
			'OP01_OPEN' => -113,
			'LITERAL_STRING' => -113
		},
		GOTOS => {
			'OPTIONAL-32' => 159,
			'PAREN-31' => 156
		}
	},
	{#State 95
		DEFAULT => -141
	},
	{#State 96
		DEFAULT => -149
	},
	{#State 97
		ACTIONS => {
			'SELF' => 113,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'Variable' => 160
		}
	},
	{#State 98
		ACTIONS => {
			'LPAREN' => 161,
			'COLON' => -218
		}
	},
	{#State 99
		DEFAULT => -14
	},
	{#State 100
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP09_BITWISE_SHIFT' => -99,
			'LBRACKET' => 127,
			"\@{" => 129,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'CONSTANT_CALL_SCOPED' => 124,
			")" => -99,
			"]" => -99,
			'OP04_MATH_POW' => -99,
			'OP23_LOGICAL_AND' => -99,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'OP16_LOGICAL_OR' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'WORD_SCOPED' => 26,
			";" => -99,
			'OP01_OPEN' => 90,
			'OP06_REGEX_MATCH' => -99,
			'OP08_STRING_CAT' => -99,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP24_LOGICAL_OR_XOR' => -99,
			'LPAREN' => 93,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP11_COMPARE_LT_GT' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			"}" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP21_LIST_COMMA' => -99,
			'OP07_STRING_REPEAT' => -99,
			'VARIABLE_SYMBOL' => 108,
			'OP14_BITWISE_OR_XOR' => -99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'WordScoped' => 126,
			'SubExpression' => 162,
			'ArrayReference' => 130,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 101
		DEFAULT => -135
	},
	{#State 102
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 129,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25
		},
		GOTOS => {
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'ArrayReference' => 130,
			'SubExpression' => 164,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114
		}
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'MY' => 168,
			'SELF' => 113,
			'LBRACE' => -213
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'TypeInner' => 167,
			'OPTIONAL-51' => 165,
			'Variable' => 166
		}
	},
	{#State 104
		ACTIONS => {
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			"\@{" => 129,
			'LBRACKET' => 127,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 169,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 105
		ACTIONS => {
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 173,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'ARGV' => 172
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 174,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'HashReference' => 137,
			'ListElement' => 170,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Literal' => 110,
			'HashDereference' => 95,
			'TypeInner' => 171,
			'Variable' => 155
		}
	},
	{#State 106
		DEFAULT => -79
	},
	{#State 107
		ACTIONS => {
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP17_LIST_RANGE' => 187,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189,
			'OP07_STRING_REPEAT' => 184,
			'OP16_LOGICAL_OR' => 191,
			'OP06_REGEX_MATCH' => 175,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179
		}
	},
	{#State 108
		DEFAULT => -231
	},
	{#State 109
		DEFAULT => -118
	},
	{#State 110
		DEFAULT => -136
	},
	{#State 111
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP04_MATH_POW' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP06_REGEX_MATCH' => -134,
			";" => 192,
			'OP15_LOGICAL_AND' => -134,
			'OP18_TERNARY' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP08_STRING_CAT' => -134
		}
	},
	{#State 112
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_FHREF' => 193,
			'WORD' => 54,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 194
		}
	},
	{#State 113
		DEFAULT => -232
	},
	{#State 114
		DEFAULT => -139
	},
	{#State 115
		DEFAULT => -128
	},
	{#State 116
		DEFAULT => -80
	},
	{#State 117
		DEFAULT => -151
	},
	{#State 118
		DEFAULT => -154
	},
	{#State 119
		ACTIONS => {
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'MY' => 168,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'ListElements' => 197,
			'WordScoped' => 126,
			'TypeInner' => 171,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'ListElement' => 195,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 120
		ACTIONS => {
			'FHREF_SYMBOL' => 198
		}
	},
	{#State 121
		DEFAULT => -81
	},
	{#State 122
		ACTIONS => {
			'OP01_NAMED_VOID' => 222,
			'OP01_PRINT' => 209,
			'WORD' => 212,
			'OP01_CLOSE' => 223,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_OPEN' => 214,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 108,
			'OP08_MATH_ADD_SUB' => 216,
			'OP23_LOGICAL_AND' => 217,
			'ENV' => 200,
			'OP07_STRING_REPEAT' => 201,
			'OP19_LOOP_CONTROL' => 218,
			'LITERAL_NUMBER' => 82,
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP22_LOGICAL_NEG' => 204,
			'OP10_NAMED_UNARY' => 203,
			'OP01_NAMED' => 205,
			"%{" => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP11_COMPARE_LT_GT' => 206,
			'OP12_COMPARE_EQ_NE' => 207,
			"}" => 208
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'VarOrLitOrOpStrOrWord' => 220,
			'OpStringOrWord' => 202,
			'Variable' => 215,
			'HashEntry' => 210,
			'Literal' => 199,
			'HashDereference' => 211
		}
	},
	{#State 123
		ACTIONS => {
			";" => 224
		}
	},
	{#State 124
		DEFAULT => -130
	},
	{#State 125
		DEFAULT => -153
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 226,
			'OP02_METHOD_THINARROW_NEW' => 225
		}
	},
	{#State 127
		ACTIONS => {
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'CONSTANT_CALL_SCOPED' => 124,
			'ARGV' => 172,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			"]" => -195,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'LITERAL_STRING' => 81,
			'OP01_QW' => 173,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'OPTIONAL-46' => 227,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'ListElements' => 228,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'TypeInner' => 171,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ListElement' => 195,
			'HashReference' => 137
		}
	},
	{#State 128
		DEFAULT => -122
	},
	{#State 129
		ACTIONS => {
			'LBRACKET' => -198,
			'MY' => 168,
			'VARIABLE_SYMBOL' => 108,
			'SELF' => 113
		},
		GOTOS => {
			'Variable' => 230,
			'TypeInner' => 231,
			'VariableSymbolOrSelf' => 134,
			'OPTIONAL-47' => 229
		}
	},
	{#State 130
		DEFAULT => -138
	},
	{#State 131
		DEFAULT => -17
	},
	{#State 132
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP04_MATH_POW' => -137,
			")" => -137,
			'OP13_BITWISE_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP02_METHOD_THINARROW' => 232,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 234,
			'OP18_TERNARY' => -137,
			'OP19_VARIABLE_ASSIGN' => 233,
			'OP09_BITWISE_SHIFT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP03_MATH_INC_DEC' => 235,
			'OP08_STRING_CAT' => -137,
			'OP06_REGEX_MATCH' => -137
		}
	},
	{#State 133
		ACTIONS => {
			"while" => 238,
			"foreach" => 240,
			"for" => 242
		},
		GOTOS => {
			'LoopWhile' => 241,
			'LoopForEach' => 236,
			'Loop' => 239,
			'LoopFor' => 237
		}
	},
	{#State 134
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 243
		}
	},
	{#State 135
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			")" => -115,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'ListElements' => 244,
			'Variable' => 155,
			'TypeInner' => 171,
			'HashDereference' => 95,
			'Literal' => 110,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'OPTIONAL-33' => 245,
			'ListElement' => 195,
			'HashReference' => 137
		}
	},
	{#State 136
		ACTIONS => {
			'WORD_UPPERCASE' => 247
		},
		GOTOS => {
			'LoopLabel' => 246
		}
	},
	{#State 137
		DEFAULT => -140
	},
	{#State 138
		ACTIONS => {
			'LPAREN' => 93,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129
		},
		GOTOS => {
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 248,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95
		}
	},
	{#State 139
		ACTIONS => {
			'WORD_UPPERCASE' => 249
		}
	},
	{#State 140
		DEFAULT => -43
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 250
		}
	},
	{#State 142
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'LBRACKET' => 127,
			"\@{" => 129,
			"for" => -150,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'OP05_MATH_NEG_LPAREN' => 138,
			'OP19_LOOP_CONTROL' => 136,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			"foreach" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			'LITERAL_STRING' => 81,
			'MY' => 112,
			'SELF' => 113,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'OP01_NAMED_VOID' => 119,
			'OP01_NAMED_SCOLON' => 106,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 105,
			"%{" => 103,
			"}" => 251,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"while" => -150,
			'VARIABLE_SYMBOL' => 108,
			'OP01_NAMED_VOID_SCOLON' => 109,
			"if" => 92,
			'OP01_OPEN' => 90,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 98,
			'OP01_PRINT' => 94,
			'LPAREN' => 93
		},
		GOTOS => {
			'Expression' => 111,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'Variable' => 132,
			'Operation' => 252,
			'OPTIONAL-37' => 133,
			'Literal' => 110,
			'OperatorVoid' => 125,
			'WordScoped' => 126,
			'SubExpression' => 107,
			'ArrayReference' => 130,
			'VariableModification' => 123,
			'Statement' => 121,
			'VariableDeclaration' => 118,
			'PAREN-36' => 96,
			'HashDereference' => 95,
			'Conditional' => 117,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'LoopLabel' => 91
		}
	},
	{#State 143
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 253
		}
	},
	{#State 144
		DEFAULT => -57
	},
	{#State 145
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 254
		}
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		ACTIONS => {
			'TYPE_FHREF' => 255
		}
	},
	{#State 148
		DEFAULT => -148
	},
	{#State 149
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'SubExpression' => 256,
			'ArrayReference' => 130,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137
		}
	},
	{#State 150
		DEFAULT => -134
	},
	{#State 151
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 127,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 129,
			'ARGV' => 172,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'ArrayReference' => 130,
			'SubExpression' => 174,
			'WordScoped' => 126,
			'HashDereference' => 95,
			'Literal' => 110,
			'TypeInner' => 171,
			'Variable' => 155,
			'HashReference' => 137,
			'ListElement' => 257,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150
		}
	},
	{#State 152
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => 258,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP16_LOGICAL_OR' => 191,
			'OP06_REGEX_MATCH' => 175,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179
		}
	},
	{#State 153
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 259
		}
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 161
		}
	},
	{#State 155
		ACTIONS => {
			'OP16_LOGICAL_OR' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP04_MATH_POW' => -137,
			'OP21_LIST_COMMA' => -137,
			"]" => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP17_LIST_RANGE' => -137,
			"}" => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			")" => -137,
			'OP13_BITWISE_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP02_METHOD_THINARROW' => 232,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP08_STRING_CAT' => -137,
			'OP03_MATH_INC_DEC' => 235,
			'OP15_LOGICAL_AND' => -137,
			'OP18_TERNARY' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			";" => -137,
			'OP06_REGEX_MATCH' => -137
		}
	},
	{#State 156
		DEFAULT => -112
	},
	{#State 157
		DEFAULT => -111
	},
	{#State 158
		ACTIONS => {
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129,
			'ARGV' => 172,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LPAREN' => 93,
			'OP01_QW' => 173
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 110,
			'TypeInner' => 171,
			'Variable' => 155,
			'ListElement' => 195,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'SubExpression' => 196,
			'ArrayReference' => 130,
			'ListElements' => 260,
			'WordScoped' => 126
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'MY' => 168,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 126,
			'SubExpression' => 196,
			'ArrayReference' => 130,
			'ListElements' => 261,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ListElement' => 195,
			'HashReference' => 137,
			'Variable' => 155,
			'TypeInner' => 171,
			'Literal' => 110,
			'HashDereference' => 95
		}
	},
	{#State 160
		DEFAULT => -87
	},
	{#State 161
		ACTIONS => {
			")" => 262
		}
	},
	{#State 162
		ACTIONS => {
			'OP06_REGEX_MATCH' => 175,
			";" => -98,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			"}" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 188,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => -98,
			"]" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP16_LOGICAL_OR' => -98
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LPAREN' => 93,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'SubExpression' => 263,
			'ArrayReference' => 130,
			'WordScoped' => 126
		}
	},
	{#State 164
		ACTIONS => {
			"}" => -108,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			")" => -108,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 191,
			'OP23_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			";" => -108,
			'OP06_REGEX_MATCH' => 175,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACE' => 122
		},
		GOTOS => {
			'HashReference' => 264
		}
	},
	{#State 166
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 167
		DEFAULT => -212
	},
	{#State 168
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 266
		}
	},
	{#State 169
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP13_BITWISE_AND' => -90,
			")" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => -90,
			'OP23_LOGICAL_AND' => -90,
			"]" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP06_REGEX_MATCH' => -90,
			";" => -90,
			'OP18_TERNARY' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90
		}
	},
	{#State 170
		ACTIONS => {
			'OP21_LIST_COMMA' => 267
		}
	},
	{#State 171
		ACTIONS => {
			'LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 268,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155
		}
	},
	{#State 172
		DEFAULT => -193
	},
	{#State 173
		DEFAULT => -192
	},
	{#State 174
		ACTIONS => {
			")" => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -190,
			'OP06_REGEX_MATCH' => -83,
			";" => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP18_TERNARY' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP08_STRING_CAT' => -83
		}
	},
	{#State 175
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 269
		}
	},
	{#State 176
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'SELF' => 113,
			'LITERAL_NUMBER' => 82,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 271,
			'Variable' => 272,
			'VariableOrLiteral' => 270,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 177
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113
		},
		GOTOS => {
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'SubExpression' => 273,
			'ArrayReference' => 130
		}
	},
	{#State 178
		ACTIONS => {
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 274
		}
	},
	{#State 179
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			"\@{" => 129,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			'LPAREN' => 93,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 275,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155
		}
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 93,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			"\@{" => 129,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127
		},
		GOTOS => {
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 276,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95
		}
	},
	{#State 181
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101
		},
		GOTOS => {
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'ArrayReference' => 130,
			'SubExpression' => 277,
			'WordScoped' => 126
		}
	},
	{#State 182
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'ArrayReference' => 130,
			'SubExpression' => 278,
			'WordScoped' => 126
		}
	},
	{#State 183
		ACTIONS => {
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 279,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137
		}
	},
	{#State 184
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113
		},
		GOTOS => {
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'SubExpression' => 280,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 185
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LPAREN' => 93,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'SubExpression' => 281,
			'ArrayReference' => 130,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 282,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155
		}
	},
	{#State 187
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 283
		}
	},
	{#State 188
		ACTIONS => {
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'SubExpression' => 284,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 189
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'ArrayReference' => 130,
			'SubExpression' => 285,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155
		}
	},
	{#State 190
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'LBRACKET' => 127,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'SubExpression' => 286,
			'ArrayReference' => 130,
			'WordScoped' => 126
		}
	},
	{#State 191
		ACTIONS => {
			'LBRACKET' => 127,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"\@{" => 129,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LPAREN' => 93
		},
		GOTOS => {
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'SubExpression' => 287,
			'ArrayReference' => 130,
			'WordScoped' => 126
		}
	},
	{#State 192
		DEFAULT => -78
	},
	{#State 193
		ACTIONS => {
			'FHREF_SYMBOL' => 288
		}
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 195
		DEFAULT => -188,
		GOTOS => {
			'STAR-45' => 290
		}
	},
	{#State 196
		ACTIONS => {
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			"]" => -190,
			'OP21_LIST_COMMA' => -190,
			'OP16_LOGICAL_OR' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => -190,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP06_REGEX_MATCH' => 175,
			";" => -190
		}
	},
	{#State 197
		ACTIONS => {
			";" => 291
		}
	},
	{#State 198
		DEFAULT => -86
	},
	{#State 199
		DEFAULT => -229
	},
	{#State 200
		DEFAULT => -205
	},
	{#State 201
		DEFAULT => -251
	},
	{#State 202
		DEFAULT => -230
	},
	{#State 203
		DEFAULT => -248
	},
	{#State 204
		DEFAULT => -243
	},
	{#State 205
		DEFAULT => -252
	},
	{#State 206
		DEFAULT => -247
	},
	{#State 207
		DEFAULT => -246
	},
	{#State 208
		DEFAULT => -211
	},
	{#State 209
		DEFAULT => -256
	},
	{#State 210
		DEFAULT => -209,
		GOTOS => {
			'STAR-50' => 292
		}
	},
	{#State 211
		DEFAULT => -204
	},
	{#State 212
		DEFAULT => -257
	},
	{#State 213
		DEFAULT => -241
	},
	{#State 214
		DEFAULT => -254
	},
	{#State 215
		DEFAULT => -228
	},
	{#State 216
		DEFAULT => -249
	},
	{#State 217
		DEFAULT => -242
	},
	{#State 218
		DEFAULT => -245
	},
	{#State 219
		DEFAULT => -250
	},
	{#State 220
		ACTIONS => {
			'OP20_HASH_FATARROW' => 293
		}
	},
	{#State 221
		DEFAULT => -244
	},
	{#State 222
		DEFAULT => -255
	},
	{#State 223
		DEFAULT => -253
	},
	{#State 224
		DEFAULT => -155
	},
	{#State 225
		ACTIONS => {
			")" => 294
		}
	},
	{#State 226
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			'LBRACKET' => 127,
			"\@{" => 129,
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			")" => -125,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'OPTIONAL-34' => 296,
			'ListElements' => 295,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'Variable' => 155,
			'Literal' => 110,
			'TypeInner' => 171,
			'HashDereference' => 95,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'ListElement' => 195
		}
	},
	{#State 227
		ACTIONS => {
			"]" => 297
		}
	},
	{#State 228
		DEFAULT => -194
	},
	{#State 229
		ACTIONS => {
			'LBRACKET' => 127
		},
		GOTOS => {
			'ArrayReference' => 298
		}
	},
	{#State 230
		ACTIONS => {
			"}" => 299
		}
	},
	{#State 231
		DEFAULT => -197
	},
	{#State 232
		ACTIONS => {
			'LPAREN' => 300
		}
	},
	{#State 233
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'FHREF_SYMBOL_IN' => 302,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'CONSTANT_CALL_SCOPED' => 124,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'STDIN' => 301,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'SubExpressionOrInput' => 304,
			'SubExpression' => 303,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 234
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'SubExpression' => 305,
			'ArrayReference' => 130,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137
		}
	},
	{#State 235
		DEFAULT => -88
	},
	{#State 236
		DEFAULT => -164
	},
	{#State 237
		DEFAULT => -163
	},
	{#State 238
		ACTIONS => {
			'LPAREN' => 307,
			'LPAREN_MY' => 306
		}
	},
	{#State 239
		DEFAULT => -152
	},
	{#State 240
		ACTIONS => {
			'MY' => 308
		}
	},
	{#State 241
		DEFAULT => -165
	},
	{#State 242
		ACTIONS => {
			'MY' => 310,
			'LPAREN_MY' => 309
		}
	},
	{#State 243
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP13_BITWISE_AND' => -176,
			")" => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP12_COMPARE_EQ_NE' => -176,
			"}" => -176,
			'OP17_LIST_RANGE' => -176,
			'COLON' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			"]" => -176,
			'OP21_LIST_COMMA' => -176,
			'OP07_STRING_REPEAT' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP04_MATH_POW' => -176,
			'OP02_ARRAY_THINARROW' => 311,
			'OP16_LOGICAL_OR' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP02_HASH_THINARROW' => 312,
			";" => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP18_TERNARY' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP08_STRING_CAT' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP20_HASH_FATARROW' => -176,
			'OP24_LOGICAL_OR_XOR' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 313
		}
	},
	{#State 244
		DEFAULT => -114
	},
	{#State 245
		ACTIONS => {
			")" => 314
		}
	},
	{#State 246
		ACTIONS => {
			";" => 315
		}
	},
	{#State 247
		DEFAULT => -218
	},
	{#State 248
		ACTIONS => {
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP06_REGEX_MATCH' => 175,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			'OP16_LOGICAL_OR' => 191,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => 316
		}
	},
	{#State 249
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 317
		}
	},
	{#State 250
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 318
		}
	},
	{#State 251
		ACTIONS => {
			";" => 319
		}
	},
	{#State 252
		DEFAULT => -46
	},
	{#State 253
		ACTIONS => {
			"our" => 324,
			'LITERAL_NUMBER' => 322
		},
		GOTOS => {
			'Subroutine' => 320,
			'MethodOrSubroutine' => 323,
			'Method' => 321
		}
	},
	{#State 254
		ACTIONS => {
			'LBRACE' => 325
		}
	},
	{#State 255
		ACTIONS => {
			'FHREF_SYMBOL' => 326
		}
	},
	{#State 256
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => 327,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP16_LOGICAL_OR' => 191,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP06_REGEX_MATCH' => 175,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 177
		}
	},
	{#State 257
		ACTIONS => {
			'OP21_LIST_COMMA' => 328
		}
	},
	{#State 258
		DEFAULT => -142
	},
	{#State 259
		ACTIONS => {
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'ARGV' => 172,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_QW' => 173,
			'LPAREN' => 93
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 95,
			'TypeInner' => 171,
			'Literal' => 110,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'ListElement' => 195,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'ListElements' => 329,
			'SubExpression' => 196,
			'ArrayReference' => 130
		}
	},
	{#State 260
		ACTIONS => {
			";" => 330
		}
	},
	{#State 261
		ACTIONS => {
			";" => 331
		}
	},
	{#State 262
		DEFAULT => -129
	},
	{#State 263
		ACTIONS => {
			"}" => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			")" => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP04_MATH_POW' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP23_LOGICAL_AND' => -83,
			"]" => -83,
			'OP21_LIST_COMMA' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP17_LIST_RANGE' => -83,
			";" => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP08_STRING_CAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP18_TERNARY' => -83
		}
	},
	{#State 264
		ACTIONS => {
			"}" => 332
		}
	},
	{#State 265
		DEFAULT => -214
	},
	{#State 266
		ACTIONS => {
			"\$TYPED_" => 333
		}
	},
	{#State 267
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 173,
			'LPAREN' => 93,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'CONSTANT_CALL_SCOPED' => 124,
			'ARGV' => 172,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Operator' => 115,
			'ListElements' => 334,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'WordScoped' => 126,
			'TypeInner' => 171,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'HashReference' => 137,
			'ListElement' => 195,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150
		}
	},
	{#State 268
		ACTIONS => {
			")" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP21_LIST_COMMA' => -191,
			"]" => -191,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP06_REGEX_MATCH' => 175,
			";" => -191,
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178
		}
	},
	{#State 269
		DEFAULT => -92
	},
	{#State 270
		ACTIONS => {
			'COLON' => 335
		}
	},
	{#State 271
		DEFAULT => -227
	},
	{#State 272
		DEFAULT => -226
	},
	{#State 273
		ACTIONS => {
			")" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => -104,
			'OP11_COMPARE_LT_GT' => 181,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => -104,
			'OP16_LOGICAL_OR' => -104,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -104,
			'OP06_REGEX_MATCH' => 175,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_STRING_CAT' => 178
		}
	},
	{#State 274
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => -96,
			'OP06_REGEX_MATCH' => 175,
			";" => -96,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP16_LOGICAL_OR' => -96,
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -96,
			")" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NE' => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => -96
		}
	},
	{#State 275
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			"]" => -110,
			'OP21_LIST_COMMA' => -110,
			")" => -110,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"}" => -110,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_STRING_CAT' => 178,
			'OP06_REGEX_MATCH' => 175,
			";" => -110
		}
	},
	{#State 276
		ACTIONS => {
			'OP16_LOGICAL_OR' => -102,
			'OP21_LIST_COMMA' => -102,
			"]" => -102,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 181,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -102,
			";" => -102,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 277
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			"]" => -100,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			"}" => -100,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 185,
			";" => -100,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 278
		ACTIONS => {
			'OP13_BITWISE_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -101,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 188,
			"]" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 175,
			";" => -101,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 279
		ACTIONS => {
			";" => -103,
			'OP06_REGEX_MATCH' => 175,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 181,
			"}" => -103,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			"]" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => -103
		}
	},
	{#State 280
		ACTIONS => {
			'OP16_LOGICAL_OR' => -93,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			"]" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_STRING_CAT' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			";" => -93,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 281
		ACTIONS => {
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => -97,
			"]" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			"}" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -97,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP15_LOGICAL_AND' => -97,
			";" => -97,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 282
		ACTIONS => {
			'OP06_REGEX_MATCH' => 175,
			";" => -94,
			'OP18_TERNARY' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP08_STRING_CAT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -94,
			'OP04_MATH_POW' => 190,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP16_LOGICAL_OR' => -94
		}
	},
	{#State 283
		ACTIONS => {
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 190,
			'OP16_LOGICAL_OR' => 191,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => -106,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -106,
			'OP15_LOGICAL_AND' => 177,
			";" => -106,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 284
		ACTIONS => {
			'OP16_LOGICAL_OR' => -95,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => -95,
			'OP07_STRING_REPEAT' => 184,
			'OP21_LIST_COMMA' => -95,
			"]" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP17_LIST_RANGE' => -95,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_STRING_CAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP18_TERNARY' => -95,
			";" => -95,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 285
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_STRING_CAT' => 178,
			'OP06_REGEX_MATCH' => 175,
			";" => -109,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP23_LOGICAL_AND' => -109,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			"]" => -109,
			'OP21_LIST_COMMA' => -109,
			")" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			"}" => -109,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181
		}
	},
	{#State 286
		ACTIONS => {
			'OP06_REGEX_MATCH' => -89,
			";" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			")" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			"}" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => -89
		}
	},
	{#State 287
		ACTIONS => {
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => -105,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP11_COMPARE_LT_GT' => 181,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -105,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -105,
			'OP15_LOGICAL_AND' => 177,
			";" => -105,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 288
		ACTIONS => {
			";" => 336
		}
	},
	{#State 289
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 337,
			";" => 339,
			'OP02_ARRAY_THINARROW' => 338
		}
	},
	{#State 290
		ACTIONS => {
			"]" => -189,
			";" => -189,
			'OP21_LIST_COMMA' => 340,
			")" => -189
		},
		GOTOS => {
			'PAREN-44' => 341
		}
	},
	{#State 291
		DEFAULT => -120
	},
	{#State 292
		ACTIONS => {
			'OP21_LIST_COMMA' => 342,
			"}" => 343
		},
		GOTOS => {
			'PAREN-49' => 344
		}
	},
	{#State 293
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -202,
			'WORD' => -202,
			'WORD_UPPERCASE' => -202,
			'OP01_CLOSE' => -202,
			'LBRACE' => -202,
			'LPAREN' => -202,
			'LITERAL_STRING' => -202,
			'OP01_OPEN' => -202,
			'MY' => 168,
			'SELF' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'LITERAL_NUMBER' => -202,
			'VARIABLE_SYMBOL' => -202,
			'WORD_SCOPED' => -202,
			'OP05_LOGICAL_NEG' => -202,
			"%{" => -202,
			'OP01_NAMED' => -202,
			'LBRACKET' => -202,
			"\@{" => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'OP22_LOGICAL_NEG' => -202,
			"undef" => -202,
			'OP10_NAMED_UNARY' => -202
		},
		GOTOS => {
			'OPTIONAL-48' => 345,
			'TypeInner' => 346
		}
	},
	{#State 294
		DEFAULT => -133
	},
	{#State 295
		DEFAULT => -124
	},
	{#State 296
		ACTIONS => {
			")" => 347
		}
	},
	{#State 297
		DEFAULT => -196
	},
	{#State 298
		ACTIONS => {
			"}" => 348
		}
	},
	{#State 299
		DEFAULT => -199
	},
	{#State 300
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			")" => -127,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'ARGV' => 172,
			"\@{" => 129,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'LBRACKET' => 127,
			'OP01_QW' => 173,
			'LPAREN' => 93,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'TypeInner' => 171,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ListElement' => 195,
			'OPTIONAL-35' => 350,
			'HashReference' => 137,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'ListElements' => 349
		}
	},
	{#State 301
		DEFAULT => -145
	},
	{#State 302
		DEFAULT => -144
	},
	{#State 303
		ACTIONS => {
			'OP16_LOGICAL_OR' => 191,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			")" => -143,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			";" => -143,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 304
		DEFAULT => -184
	},
	{#State 305
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP06_REGEX_MATCH' => 175,
			";" => -185,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			")" => -185,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181
		}
	},
	{#State 306
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 351
		}
	},
	{#State 307
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 352
		}
	},
	{#State 308
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 353
		}
	},
	{#State 309
		ACTIONS => {
			'TYPE_INTEGER' => 354
		}
	},
	{#State 310
		ACTIONS => {
			'TYPE_INTEGER' => 355
		}
	},
	{#State 311
		ACTIONS => {
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124
		},
		GOTOS => {
			'WordScoped' => 126,
			'SubExpression' => 356,
			'ArrayReference' => 130,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110
		}
	},
	{#State 312
		ACTIONS => {
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 358,
			'LPAREN' => 93
		},
		GOTOS => {
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'SubExpression' => 357,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114
		}
	},
	{#State 313
		DEFAULT => -174
	},
	{#State 314
		ACTIONS => {
			";" => 359
		}
	},
	{#State 315
		DEFAULT => -123
	},
	{#State 316
		DEFAULT => -91
	},
	{#State 317
		DEFAULT => -225
	},
	{#State 318
		ACTIONS => {
			'OP21_LIST_COMMA' => 360,
			")" => 362
		},
		GOTOS => {
			'PAREN-19' => 361
		}
	},
	{#State 319
		DEFAULT => -48
	},
	{#State 320
		DEFAULT => -77
	},
	{#State 321
		DEFAULT => -76
	},
	{#State 322
		ACTIONS => {
			";" => 363
		}
	},
	{#State 323
		DEFAULT => -59
	},
	{#State 324
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_METHOD' => 364,
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 325
		ACTIONS => {
			'OP01_OPEN' => 214,
			'WORD' => 212,
			'OP01_CLOSE' => 223,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_NAMED_VOID' => 222,
			'OP01_PRINT' => 209,
			'OP01_NAMED' => 205,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP11_COMPARE_LT_GT' => 206,
			'OP12_COMPARE_EQ_NE' => 207,
			"}" => 366,
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP22_LOGICAL_NEG' => 204,
			'OP10_NAMED_UNARY' => 203,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 217,
			'OP19_LOOP_CONTROL' => 218,
			'OP08_MATH_ADD_SUB' => 216
		},
		GOTOS => {
			'OpStringOrWord' => 365,
			'HashEntryProperties' => 367
		}
	},
	{#State 326
		ACTIONS => {
			'OP21_LIST_COMMA' => 368
		}
	},
	{#State 327
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 328
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'MY' => 168,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127,
			"\@{" => 129,
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'ListElements' => 371,
			'SubExpression' => 196,
			'ArrayReference' => 130,
			'Variable' => 155,
			'HashDereference' => 95,
			'TypeInner' => 171,
			'Literal' => 110,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'ListElement' => 195
		}
	},
	{#State 329
		ACTIONS => {
			")" => 372
		}
	},
	{#State 330
		DEFAULT => -117
	},
	{#State 331
		DEFAULT => -116
	},
	{#State 332
		DEFAULT => -215
	},
	{#State 333
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 216,
			'OP19_LOOP_CONTROL' => 218,
			'OP23_LOGICAL_AND' => 217,
			'OP07_STRING_REPEAT' => 201,
			'OP10_NAMED_UNARY' => 203,
			'OP22_LOGICAL_NEG' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP01_NAMED' => 205,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP11_COMPARE_LT_GT' => 206,
			'OP01_NAMED_VOID' => 222,
			'OP01_PRINT' => 209,
			'OP01_CLOSE' => 223,
			'OP24_LOGICAL_OR_XOR' => 213,
			'WORD' => 212,
			'OP01_OPEN' => 214
		},
		GOTOS => {
			'OpStringOrWord' => 373
		}
	},
	{#State 334
		ACTIONS => {
			";" => 374
		}
	},
	{#State 335
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 82
		},
		GOTOS => {
			'VariableOrLiteral' => 375,
			'VariableSymbolOrSelf' => 134,
			'Literal' => 271,
			'Variable' => 272
		}
	},
	{#State 336
		DEFAULT => -183
	},
	{#State 337
		ACTIONS => {
			'LBRACKET' => 127,
			'OP01_NAMED_SCOLON' => 378,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'FHREF_SYMBOL_IN' => 302,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY_SCOLON' => 377,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'STDIN' => 301,
			'SELF' => 113,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LPAREN' => 93
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 95,
			'OpNamedScolonOrSubExpIn' => 376,
			'Literal' => 110,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'SubExpressionOrInput' => 379,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'SubExpression' => 303,
			'ArrayReference' => 130
		}
	},
	{#State 338
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'ArrayReference' => 130,
			'SubExpression' => 380,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 339
		DEFAULT => -180
	},
	{#State 340
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			"\@{" => 129,
			'ARGV' => 172,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113
		},
		GOTOS => {
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'ListElement' => 381,
			'HashReference' => 137,
			'Variable' => 155,
			'TypeInner' => 171,
			'HashDereference' => 95,
			'Literal' => 110,
			'WordScoped' => 126,
			'SubExpression' => 196,
			'ArrayReference' => 130,
			'Operator' => 115,
			'ArrayDereference' => 114
		}
	},
	{#State 341
		DEFAULT => -187
	},
	{#State 342
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 214,
			'SELF' => 113,
			'WORD' => 212,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_CLOSE' => 223,
			'OP01_PRINT' => 209,
			'OP01_NAMED_VOID' => 222,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP11_COMPARE_LT_GT' => 206,
			'OP01_NAMED' => 205,
			"%{" => 103,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP10_NAMED_UNARY' => 203,
			'OP22_LOGICAL_NEG' => 204,
			'ENV' => 200,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 217,
			'OP19_LOOP_CONTROL' => 218,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'OP08_MATH_ADD_SUB' => 216
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 220,
			'VariableSymbolOrSelf' => 134,
			'OpStringOrWord' => 202,
			'Variable' => 215,
			'HashEntry' => 382,
			'Literal' => 199,
			'HashDereference' => 211
		}
	},
	{#State 343
		DEFAULT => -210
	},
	{#State 344
		DEFAULT => -208
	},
	{#State 345
		ACTIONS => {
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'ArrayReference' => 130,
			'SubExpression' => 383,
			'WordScoped' => 126,
			'Operator' => 115,
			'ArrayDereference' => 114
		}
	},
	{#State 346
		DEFAULT => -201
	},
	{#State 347
		DEFAULT => -131
	},
	{#State 348
		DEFAULT => -200
	},
	{#State 349
		DEFAULT => -126
	},
	{#State 350
		ACTIONS => {
			")" => 384
		}
	},
	{#State 351
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 352
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => 386,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			'OP16_LOGICAL_OR' => 191,
			'OP06_REGEX_MATCH' => 175,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 355
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 356
		ACTIONS => {
			'OP17_LIST_RANGE' => 187,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			"]" => 390,
			'OP16_LOGICAL_OR' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 357
		ACTIONS => {
			'OP06_REGEX_MATCH' => 175,
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => 391,
			'OP11_COMPARE_LT_GT' => 181,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 358
		ACTIONS => {
			'LPAREN' => -216,
			'OP02_METHOD_THINARROW_NEW' => -216,
			"}" => 392
		}
	},
	{#State 359
		DEFAULT => -119
	},
	{#State 360
		ACTIONS => {
			'MY' => 393
		}
	},
	{#State 361
		DEFAULT => -50
	},
	{#State 362
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 394
		}
	},
	{#State 363
		DEFAULT => -61
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 365
		ACTIONS => {
			'OP20_HASH_FATARROW' => 396
		}
	},
	{#State 366
		ACTIONS => {
			";" => 397
		}
	},
	{#State 367
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 398
		}
	},
	{#State 368
		ACTIONS => {
			'LITERAL_STRING' => 399
		}
	},
	{#State 369
		DEFAULT => -158,
		GOTOS => {
			'STAR-39' => 400
		}
	},
	{#State 370
		ACTIONS => {
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_NAMED_SCOLON' => 106,
			"%{" => 103,
			'OP01_NAMED' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 108,
			'OP01_NAMED_VOID_SCOLON' => 109,
			"while" => -150,
			'OP01_OPEN' => 90,
			"if" => 92,
			'OP01_PRINT' => 94,
			'LPAREN' => 93,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 98,
			"for" => -150,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACKET' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"\@{" => 129,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'OP19_LOOP_CONTROL' => 136,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'MY' => 112,
			'SELF' => 113,
			"foreach" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			'LITERAL_STRING' => 81,
			'OP01_NAMED_VOID' => 119,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120
		},
		GOTOS => {
			'VariableModification' => 123,
			'SubExpression' => 107,
			'ArrayReference' => 130,
			'OperatorVoid' => 125,
			'WordScoped' => 126,
			'Literal' => 110,
			'OPTIONAL-37' => 133,
			'Variable' => 132,
			'Operation' => 402,
			'HashReference' => 137,
			'Expression' => 111,
			'VariableSymbolOrSelf' => 134,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'PLUS-42' => 401,
			'LoopLabel' => 91,
			'Conditional' => 117,
			'HashDereference' => 95,
			'PAREN-36' => 96,
			'VariableDeclaration' => 118,
			'Statement' => 121
		}
	},
	{#State 371
		ACTIONS => {
			")" => 403
		}
	},
	{#State 372
		DEFAULT => -82
	},
	{#State 373
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 374
		DEFAULT => -121
	},
	{#State 375
		DEFAULT => -107
	},
	{#State 376
		DEFAULT => -181
	},
	{#State 377
		DEFAULT => -239
	},
	{#State 378
		DEFAULT => -238
	},
	{#State 379
		ACTIONS => {
			";" => 405
		}
	},
	{#State 380
		ACTIONS => {
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP06_REGEX_MATCH' => 175,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			"]" => 406,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189,
			'OP07_STRING_REPEAT' => 184,
			'OP16_LOGICAL_OR' => 191,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182
		}
	},
	{#State 381
		DEFAULT => -186
	},
	{#State 382
		DEFAULT => -207
	},
	{#State 383
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189,
			'OP07_STRING_REPEAT' => 184,
			'OP21_LIST_COMMA' => -203,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			"}" => -203,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 384
		DEFAULT => -132
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 408
		}
	},
	{#State 387
		ACTIONS => {
			'LPAREN' => 409
		}
	},
	{#State 388
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 389
		ACTIONS => {
			'LPAREN' => 411
		}
	},
	{#State 390
		DEFAULT => -177
	},
	{#State 391
		DEFAULT => -178
	},
	{#State 392
		DEFAULT => -179
	},
	{#State 393
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 394
		ACTIONS => {
			"\@_;" => 413
		}
	},
	{#State 395
		ACTIONS => {
			"= sub {" => 414
		}
	},
	{#State 396
		ACTIONS => {
			'MY' => 415
		},
		GOTOS => {
			'TypeInnerProperties' => 416
		}
	},
	{#State 397
		DEFAULT => -66
	},
	{#State 398
		ACTIONS => {
			"}" => 418,
			'OP21_LIST_COMMA' => 417
		},
		GOTOS => {
			'PAREN-25' => 419
		}
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 420
		}
	},
	{#State 400
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -161,
			"%{" => -161,
			'OP01_NAMED' => -161,
			'OP05_LOGICAL_NEG' => -161,
			"}" => -161,
			"undef" => -161,
			'OP10_NAMED_UNARY' => -161,
			'OP22_LOGICAL_NEG' => -161,
			"while" => -161,
			'' => -161,
			'OP01_NAMED_VOID_SCOLON' => -161,
			'VARIABLE_SYMBOL' => -161,
			"if" => -161,
			'OP01_OPEN' => -161,
			'WORD' => -161,
			'OP03_MATH_INC_DEC' => -161,
			'WORD_UPPERCASE' => -161,
			'OP01_PRINT' => -161,
			'LPAREN' => -161,
			'OP19_LOOP_CONTROL_SCOLON' => -161,
			'LBRACKET' => -161,
			"\@{" => -161,
			"for" => -161,
			'CONSTANT_CALL_SCOPED' => -161,
			'OP01_NAMED_VOID_LPAREN' => -161,
			'OP05_MATH_NEG_LPAREN' => -161,
			'LITERAL_NUMBER' => -161,
			'OP19_LOOP_CONTROL' => -161,
			'WORD_SCOPED' => -161,
			"foreach" => -161,
			'OP10_NAMED_UNARY_SCOLON' => -161,
			'LITERAL_STRING' => -161,
			'MY' => -161,
			"elsif" => 423,
			'SELF' => -161,
			'LBRACE' => -161,
			'OP01_CLOSE' => -161,
			'OP01_NAMED_VOID' => -161,
			"else" => 422
		},
		GOTOS => {
			'PAREN-38' => 425,
			'OPTIONAL-41' => 421,
			'PAREN-40' => 424
		}
	},
	{#State 401
		ACTIONS => {
			"}" => 426,
			'OP01_NAMED_SCOLON' => 106,
			"%{" => 103,
			'OP01_NAMED' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"while" => -150,
			'OP01_NAMED_VOID_SCOLON' => 109,
			'VARIABLE_SYMBOL' => 108,
			"if" => 92,
			'OP01_OPEN' => 90,
			'WORD_UPPERCASE' => 98,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_PRINT' => 94,
			'LPAREN' => 93,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"for" => -150,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'OP19_LOOP_CONTROL' => 136,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			"foreach" => -150,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			'SELF' => 113,
			'MY' => 112,
			'LBRACE' => 122,
			'OP01_CLOSE' => 120,
			'OP01_NAMED_VOID' => 119
		},
		GOTOS => {
			'PAREN-36' => 96,
			'HashDereference' => 95,
			'VariableDeclaration' => 118,
			'Statement' => 121,
			'LoopLabel' => 91,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'Conditional' => 117,
			'OPTIONAL-37' => 133,
			'Literal' => 110,
			'Operation' => 427,
			'Variable' => 132,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 111,
			'VariableModification' => 123,
			'ArrayReference' => 130,
			'SubExpression' => 107,
			'OperatorVoid' => 125,
			'WordScoped' => 126
		}
	},
	{#State 402
		DEFAULT => -172
	},
	{#State 403
		DEFAULT => -84
	},
	{#State 404
		DEFAULT => -222
	},
	{#State 405
		DEFAULT => -240
	},
	{#State 406
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 428
		}
	},
	{#State 407
		ACTIONS => {
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			"\@{" => 129,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			'FHREF_SYMBOL_IN' => 302,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'STDIN' => 301,
			'SELF' => 113,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LPAREN' => 93
		},
		GOTOS => {
			'SubExpressionOrInput' => 429,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 303,
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137
		}
	},
	{#State 408
		DEFAULT => -169
	},
	{#State 409
		ACTIONS => {
			'OP01_OPEN' => 90,
			'MY' => 168,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'LPAREN' => 93,
			'OP01_QW' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'ARGV' => 172,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACKET' => 127,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'ArrayReference' => 130,
			'SubExpression' => 196,
			'ListElements' => 430,
			'WordScoped' => 126,
			'TypeInner' => 171,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'ListElement' => 195,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 410
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP01_NAMED_SCOLON' => 432,
			'LBRACKET' => 127,
			"\@{" => 129,
			'LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP10_NAMED_UNARY_SCOLON' => 434,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'OpNamedScolonOrSubExp' => 431,
			'ArrayReference' => 130,
			'SubExpression' => 433,
			'WordScoped' => 126,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150
		}
	},
	{#State 411
		ACTIONS => {
			'LPAREN' => 93,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'CONSTANT_CALL_SCOPED' => 124,
			'LBRACKET' => 127,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 129
		},
		GOTOS => {
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'ArrayReference' => 130,
			'SubExpression' => 435
		}
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 436
		}
	},
	{#State 413
		DEFAULT => -52
	},
	{#State 414
		ACTIONS => {
			'WORD_SCOPED' => -68,
			'LITERAL_NUMBER' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"for" => -68,
			"\@{" => -68,
			'LBRACKET' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_NAMED_VOID' => -68,
			'OP01_CLOSE' => -68,
			'LBRACE' => -68,
			'SELF' => -68,
			'LPAREN_MY' => 439,
			'MY' => -68,
			'LITERAL_STRING' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			"foreach" => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			"while" => -68,
			'OP10_NAMED_UNARY' => -68,
			'OP22_LOGICAL_NEG' => -68,
			"undef" => -68,
			"}" => -68,
			'OP05_LOGICAL_NEG' => -68,
			"%{" => -68,
			'OP01_NAMED' => -68,
			'OP01_NAMED_SCOLON' => -68,
			'LPAREN' => -68,
			'OP01_PRINT' => -68,
			'WORD_UPPERCASE' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'WORD' => -68,
			'OP01_OPEN' => -68,
			"if" => -68
		},
		GOTOS => {
			'MethodArguments' => 437,
			'OPTIONAL-27' => 438
		}
	},
	{#State 415
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 440
		}
	},
	{#State 416
		DEFAULT => -206
	},
	{#State 417
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP10_NAMED_UNARY' => 203,
			'OP22_LOGICAL_NEG' => 204,
			'OP11_COMPARE_LT_GT' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP01_NAMED' => 205,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP08_MATH_ADD_SUB' => 216,
			'OP23_LOGICAL_AND' => 217,
			'OP07_STRING_REPEAT' => 201,
			'OP19_LOOP_CONTROL' => 218,
			'OP01_OPEN' => 214,
			'OP01_PRINT' => 209,
			'OP01_NAMED_VOID' => 222,
			'WORD' => 212,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_CLOSE' => 223
		},
		GOTOS => {
			'OpStringOrWord' => 365,
			'HashEntryProperties' => 441
		}
	},
	{#State 418
		ACTIONS => {
			";" => 442
		}
	},
	{#State 419
		DEFAULT => -63
	},
	{#State 420
		ACTIONS => {
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'SubExpression' => 443,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 421
		DEFAULT => -162
	},
	{#State 422
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 423
		ACTIONS => {
			'LPAREN' => 445
		}
	},
	{#State 424
		DEFAULT => -160
	},
	{#State 425
		DEFAULT => -157
	},
	{#State 426
		DEFAULT => -173
	},
	{#State 427
		DEFAULT => -171
	},
	{#State 428
		ACTIONS => {
			"undef" => 446
		}
	},
	{#State 429
		ACTIONS => {
			")" => 447
		}
	},
	{#State 430
		ACTIONS => {
			")" => 448
		}
	},
	{#State 431
		ACTIONS => {
			'VARIABLE_SYMBOL' => 449
		}
	},
	{#State 432
		DEFAULT => -235
	},
	{#State 433
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP06_REGEX_MATCH' => 175,
			";" => 450,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP16_LOGICAL_OR' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182
		}
	},
	{#State 434
		DEFAULT => -236
	},
	{#State 435
		ACTIONS => {
			'OP16_LOGICAL_OR' => 191,
			'OP23_LOGICAL_AND' => 189,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 451,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 436
		DEFAULT => -49
	},
	{#State 437
		DEFAULT => -67
	},
	{#State 438
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 452
		}
	},
	{#State 439
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 453
		}
	},
	{#State 440
		ACTIONS => {
			"\$TYPED_" => 454
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
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -85,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => -85,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			"]" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => -85,
			'OP07_STRING_REPEAT' => 184,
			'OP16_LOGICAL_OR' => 191,
			'OP06_REGEX_MATCH' => 175,
			";" => -85,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -85
		}
	},
	{#State 444
		DEFAULT => -159
	},
	{#State 445
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'CONSTANT_CALL_SCOPED' => 124,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Operator' => 115,
			'ArrayDereference' => 114,
			'SubExpression' => 455,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'HashReference' => 137,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134
		}
	},
	{#State 446
		ACTIONS => {
			";" => 456
		}
	},
	{#State 447
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 457
		}
	},
	{#State 448
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 458
		}
	},
	{#State 449
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 459
		}
	},
	{#State 450
		DEFAULT => -237
	},
	{#State 451
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 124,
			"\@{" => 129,
			'LBRACKET' => 127,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LPAREN' => 93,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 97,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'WordScoped' => 126,
			'SubExpression' => 460,
			'ArrayReference' => 130,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'Variable' => 155,
			'Literal' => 110,
			'HashDereference' => 95
		}
	},
	{#State 452
		ACTIONS => {
			'OP01_OPEN' => 90,
			"if" => 92,
			'LPAREN' => 93,
			'OP01_PRINT' => 94,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 98,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 105,
			'OP01_NAMED_SCOLON' => 106,
			"}" => 462,
			'VARIABLE_SYMBOL' => 108,
			'OP01_NAMED_VOID_SCOLON' => 109,
			"while" => -150,
			'MY' => 112,
			'SELF' => 113,
			'OP10_NAMED_UNARY_SCOLON' => 116,
			"foreach" => -150,
			'LITERAL_STRING' => 81,
			'OP01_NAMED_VOID' => 119,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 124,
			"for" => -150,
			'LBRACKET' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"\@{" => 129,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID_LPAREN' => 135,
			'OP19_LOOP_CONTROL' => 136,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138
		},
		GOTOS => {
			'Conditional' => 117,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'LoopLabel' => 91,
			'Statement' => 121,
			'PAREN-36' => 96,
			'HashDereference' => 95,
			'VariableDeclaration' => 118,
			'ArrayReference' => 130,
			'SubExpression' => 107,
			'OperatorVoid' => 125,
			'WordScoped' => 126,
			'VariableModification' => 123,
			'HashReference' => 137,
			'Expression' => 111,
			'VariableSymbolOrSelf' => 134,
			'Literal' => 110,
			'OPTIONAL-37' => 133,
			'Variable' => 132,
			'Operation' => 461
		}
	},
	{#State 453
		ACTIONS => {
			'SELF' => 463
		}
	},
	{#State 454
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 219,
			'OP10_NAMED_UNARY' => 203,
			'OP22_LOGICAL_NEG' => 204,
			'OP19_LOOP_CONTROL_SCOLON' => 221,
			'OP11_COMPARE_LT_GT' => 206,
			'OP01_NAMED' => 205,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP08_MATH_ADD_SUB' => 216,
			'OP23_LOGICAL_AND' => 217,
			'OP07_STRING_REPEAT' => 201,
			'OP19_LOOP_CONTROL' => 218,
			'OP01_OPEN' => 214,
			'OP01_PRINT' => 209,
			'OP01_NAMED_VOID' => 222,
			'WORD' => 212,
			'OP24_LOGICAL_OR_XOR' => 213,
			'OP01_CLOSE' => 223
		},
		GOTOS => {
			'OpStringOrWord' => 464
		}
	},
	{#State 455
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP06_REGEX_MATCH' => 175,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP07_STRING_REPEAT' => 184,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189,
			")" => 465,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181
		}
	},
	{#State 456
		DEFAULT => -182
	},
	{#State 457
		DEFAULT => -170
	},
	{#State 458
		DEFAULT => -168
	},
	{#State 459
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'LPAREN' => 93,
			'OP10_NAMED_UNARY_SCOLON' => 434,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 90,
			'SELF' => 113,
			'OP05_MATH_NEG_LPAREN' => 138,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 26,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			'LBRACKET' => 127,
			'OP01_NAMED_SCOLON' => 432,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP10_NAMED_UNARY' => 100,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 95,
			'Literal' => 110,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 134,
			'HashReference' => 137,
			'OpNamedScolonOrSubExp' => 466,
			'Operator' => 115,
			'ArrayDereference' => 114,
			'WordScoped' => 126,
			'SubExpression' => 433,
			'ArrayReference' => 130
		}
	},
	{#State 460
		ACTIONS => {
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 190,
			'OP16_LOGICAL_OR' => 191,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			")" => 467,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => -106,
			'OP15_LOGICAL_AND' => 177,
			'OP06_REGEX_MATCH' => 175
		}
	},
	{#State 461
		DEFAULT => -69
	},
	{#State 462
		ACTIONS => {
			";" => 468
		}
	},
	{#State 463
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 469
		}
	},
	{#State 464
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 470,
			'OP19_VARIABLE_ASSIGN' => 471
		}
	},
	{#State 465
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 466
		ACTIONS => {
			'LPAREN' => 93,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'LBRACKET' => 127
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashReference' => 137,
			'SubExpressionOrVarMod' => 475,
			'Variable' => 132,
			'Literal' => 110,
			'HashDereference' => 95,
			'WordScoped' => 126,
			'SubExpression' => 473,
			'ArrayReference' => 130,
			'VariableModification' => 474,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 467
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 476
		}
	},
	{#State 468
		DEFAULT => -71
	},
	{#State 469
		ACTIONS => {
			'OP21_LIST_COMMA' => 479,
			")" => 477
		},
		GOTOS => {
			'PAREN-29' => 478
		}
	},
	{#State 470
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108,
			"\@{" => 129,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 163,
			"%{" => 103,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			"undef" => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP10_NAMED_UNARY' => 100,
			'WORD_UPPERCASE' => 154,
			'OP01_CLOSE' => 120,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'HashDereference' => 95,
			'Literal' => 110,
			'Variable' => 155,
			'SubExpression' => 480,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115
		}
	},
	{#State 471
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'SELF' => 113,
			'OP01_OPEN' => 90,
			'OP01_CLOSE' => 120,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 25,
			'LPAREN' => 93,
			"\@{" => 129,
			"%{" => 103,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 127,
			'CONSTANT_CALL_SCOPED' => 124,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 101,
			'OP10_NAMED_UNARY' => 100,
			'LITERAL_NUMBER' => 82,
			'OP05_MATH_NEG_LPAREN' => 138,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'SubExpression' => 481,
			'ArrayReference' => 130,
			'WordScoped' => 126,
			'ArrayDereference' => 114,
			'Operator' => 115,
			'HashReference' => 137,
			'VariableSymbolOrSelf' => 134,
			'Expression' => 150,
			'Literal' => 110,
			'HashDereference' => 95,
			'Variable' => 155
		}
	},
	{#State 472
		DEFAULT => -156
	},
	{#State 473
		ACTIONS => {
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP06_REGEX_MATCH' => 175,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP23_LOGICAL_AND' => 189,
			'OP16_LOGICAL_OR' => 191,
			'OP17_LIST_RANGE' => 187,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP11_COMPARE_LT_GT' => 181,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			")" => -146
		}
	},
	{#State 474
		DEFAULT => -147
	},
	{#State 475
		ACTIONS => {
			")" => 482
		}
	},
	{#State 476
		DEFAULT => -166
	},
	{#State 477
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 483
		}
	},
	{#State 478
		DEFAULT => -73
	},
	{#State 479
		ACTIONS => {
			'MY' => 484
		}
	},
	{#State 480
		ACTIONS => {
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NE' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP08_MATH_ADD_SUB' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP17_LIST_RANGE' => 187,
			'OP16_LOGICAL_OR' => 191,
			'OP04_MATH_POW' => 190,
			'OP23_LOGICAL_AND' => 189,
			'OP07_STRING_REPEAT' => 184,
			"]" => 485,
			'OP06_REGEX_MATCH' => 175,
			'OP15_LOGICAL_AND' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 185,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178
		}
	},
	{#State 481
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 182,
			"}" => -223,
			'OP11_COMPARE_LT_GT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP13_BITWISE_AND' => 180,
			'OP16_LOGICAL_OR' => 191,
			'OP21_LIST_COMMA' => -223,
			'OP23_LOGICAL_AND' => 189,
			'OP04_MATH_POW' => 190,
			'OP07_STRING_REPEAT' => 184,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_MATH_ADD_SUB' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP06_REGEX_MATCH' => 175,
			'OP24_LOGICAL_OR_XOR' => 179,
			'OP08_STRING_CAT' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 185,
			'OP18_TERNARY' => 176
		}
	},
	{#State 482
		ACTIONS => {
			'LBRACE' => 370
		},
		GOTOS => {
			'CodeBlock' => 486
		}
	},
	{#State 483
		ACTIONS => {
			"\@_;" => 487
		}
	},
	{#State 484
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'WORD' => 54,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 488
		}
	},
	{#State 485
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 489
		}
	},
	{#State 486
		DEFAULT => -167
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
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7485 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7749 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7760 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7771 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7782 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7793 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7804 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7815 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7826 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7894 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7905 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7927 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7938 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7949 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8010 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8032 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8054 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8087 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8098 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8109 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8131 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8142 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8153 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8164 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8175 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8186 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8197 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8240 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8251 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8262 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8273 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8337 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8348 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8359 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8370 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8381 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8392 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_168
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8414 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8475 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8486 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8552 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8606 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8617 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8628 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8639 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8700 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8736 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8747 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8758 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_206
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8801 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
    bless { children => [ @_ ] }, $name;
}
#line 8837 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8848 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8859 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8870 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8881 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8892 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8903 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8914 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8936 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8947 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_225
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8958 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8969 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8980 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_228
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8991 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_229
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9002 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9035 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9046 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9057 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_235
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9068 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9079 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9090 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_238
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9101 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9112 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9123 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_241
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9134 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_242
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9145 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9156 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9167 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9178 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9189 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9200 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9211 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9222 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9233 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9244 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9255 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9266 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9277 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9288 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9299 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
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
