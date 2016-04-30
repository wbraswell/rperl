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
    our $VERSION = 0.003_600;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|package|foreach|\$TYPED_|while|undef|elsif|else|\@_\;|our|for|\@\{|\%\{|if|\;|\)|\}|\])}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
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
  [ 'Operator_90' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
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
			"## no critic qw(" => 6,
			'SHEBANG' => 7
		},
		GOTOS => {
			'Critic' => 8,
			'PLUS-2' => 4,
			'PAREN-1' => 9,
			'OPTIONAL-9' => 5,
			'Program' => 1,
			'ModuleHeader' => 2,
			'CompileUnit' => 3
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			"use constant" => -27,
			"use parent qw(" => 14,
			"## no critic qw(" => -27,
			'USE' => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 11,
			'Package' => 13,
			'Class' => 12,
			'Module' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'' => 15
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 6,
			'' => -5,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'ModuleHeader' => 2,
			'PAREN-1' => 16,
			'OPTIONAL-9' => 5,
			'Critic' => 8
		}
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => 18,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 17
		}
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
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 21,
			'OPTIONAL-3' => 22
		}
	},
	{#State 8
		DEFAULT => -19
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		ACTIONS => {
			'USE' => -29,
			"our" => -29,
			"use constant" => -29,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 23,
			'STAR-12' => 24
		}
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		DEFAULT => -24
	},
	{#State 14
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		ACTIONS => {
			"package" => 28
		}
	},
	{#State 18
		DEFAULT => -21
	},
	{#State 19
		DEFAULT => -39
	},
	{#State 20
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		ACTIONS => {
			'USE_RPERL' => 31
		}
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		ACTIONS => {
			"use constant" => -31,
			"our" => -31,
			'USE' => 33
		},
		GOTOS => {
			'Include' => 34,
			'STAR-13' => 32
		}
	},
	{#State 25
		DEFAULT => -217
	},
	{#State 26
		ACTIONS => {
			")" => 35
		}
	},
	{#State 27
		DEFAULT => -218
	},
	{#State 28
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 29
		DEFAULT => -38
	},
	{#State 30
		DEFAULT => -40
	},
	{#State 31
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use constant" => 39,
			"our" => 42
		},
		GOTOS => {
			'Constant' => 41,
			'PLUS-14' => 43,
			'Subroutine' => 40
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 44
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
			";" => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 47
		}
	},
	{#State 38
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 48
		}
	},
	{#State 39
		ACTIONS => {
			'WORD_UPPERCASE' => 49
		}
	},
	{#State 40
		DEFAULT => -33
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			'WORD' => 53,
			'WORD_SCOPED' => 51,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 50
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 54
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'OP01_QW' => 57,
			";" => 56
		}
	},
	{#State 45
		ACTIONS => {
			'USE' => 33
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 59
		}
	},
	{#State 47
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 60
		},
		GOTOS => {
			'OPTIONAL-15' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'MY' => -11,
			"while" => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_OPEN' => -11,
			"for" => -11,
			'USE' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"foreach" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"## no critic qw(" => 6,
			'LBRACE' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD_SCOPED' => -11,
			"\@{" => -11,
			'LITERAL_NUMBER' => -11,
			'WORD' => -11,
			"use constant" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_PRINT' => -11,
			'SELF' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP10_NAMED_UNARY' => -11,
			"%{" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"if" => -11
		},
		GOTOS => {
			'STAR-5' => 62,
			'Critic' => 63
		}
	},
	{#State 49
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 50
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 51
		DEFAULT => -221
	},
	{#State 52
		DEFAULT => -222
	},
	{#State 53
		DEFAULT => -220
	},
	{#State 54
		ACTIONS => {
			";" => 66
		}
	},
	{#State 55
		DEFAULT => -32
	},
	{#State 56
		DEFAULT => -41
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
		DEFAULT => -23
	},
	{#State 60
		DEFAULT => -35
	},
	{#State 61
		ACTIONS => {
			"our" => 69
		}
	},
	{#State 62
		ACTIONS => {
			'OP01_OPEN' => -13,
			"for" => -13,
			'USE' => 33,
			'OP01_NAMED' => -13,
			'MY' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"while" => -13,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'LBRACE' => -13,
			"foreach" => -13,
			'OP01_NAMED_SCOLON' => -13,
			'LPAREN' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"\@{" => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			'WORD' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"our" => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			'OP10_NAMED_UNARY' => -13,
			"%{" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED_VOID' => -13,
			"if" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"undef" => -13,
			'LBRACKET' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_PRINT' => -13,
			'SELF' => -13
		},
		GOTOS => {
			'STAR-6' => 70,
			'Include' => 71
		}
	},
	{#State 63
		DEFAULT => -8
	},
	{#State 64
		ACTIONS => {
			'MY' => 73
		},
		GOTOS => {
			'TypeInnerConstant' => 72
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 66
		DEFAULT => -34
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		ACTIONS => {
			'USE' => -56,
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'STAR-22' => 76,
			'Critic' => 75
		}
	},
	{#State 69
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 77
		}
	},
	{#State 70
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'LBRACE' => -15,
			"foreach" => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LPAREN' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"for" => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED' => -15,
			'MY' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LITERAL_STRING' => -15,
			"while" => -15,
			'OP10_NAMED_UNARY' => -15,
			"%{" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED_VOID' => -15,
			"if" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD_UPPERCASE' => -15,
			"undef" => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'SELF' => -15,
			'OP01_PRINT' => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15,
			"use constant" => 39,
			'WORD' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'VARIABLE_SYMBOL' => -15,
			"our" => -15,
			'WORD_SCOPED' => -15
		},
		GOTOS => {
			'STAR-7' => 78,
			'Constant' => 79
		}
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Literal' => 82
		}
	},
	{#State 73
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 53,
			'WORD_SCOPED' => 51
		},
		GOTOS => {
			'Type' => 83
		}
	},
	{#State 74
		ACTIONS => {
			'OP01_NAMED_VOID' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP10_NAMED_UNARY' => -45,
			"%{" => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"if" => -45,
			'LPAREN_MY' => 86,
			'OP01_NAMED_VOID_SCOLON' => -45,
			"undef" => -45,
			'LBRACKET' => -45,
			'WORD_UPPERCASE' => -45,
			'OP01_PRINT' => -45,
			'SELF' => -45,
			"\@{" => -45,
			'LITERAL_NUMBER' => -45,
			'WORD' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'WORD_SCOPED' => -45,
			'OP01_CLOSE' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'LBRACE' => -45,
			'OP01_NAMED_SCOLON' => -45,
			"foreach" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'LPAREN' => -45,
			'OP01_OPEN' => -45,
			"for" => -45,
			"}" => -45,
			'OP01_NAMED' => -45,
			'MY' => -45,
			"while" => -45,
			'LITERAL_STRING' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP22_LOGICAL_NEG' => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 84,
			'SubroutineArguments' => 85
		}
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 33,
			"use constant" => -58
		},
		GOTOS => {
			'Include' => 88,
			'STAR-23' => 87
		}
	},
	{#State 77
		DEFAULT => -37
	},
	{#State 78
		ACTIONS => {
			'LBRACE' => 139,
			'OP19_LOOP_CONTROL_SCOLON' => 136,
			'OP01_CLOSE' => 134,
			'LPAREN' => 131,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP01_NAMED_SCOLON' => 127,
			"foreach" => -151,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 123,
			"for" => -151,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP19_LOOP_CONTROL' => 119,
			'LITERAL_STRING' => 81,
			"while" => -151,
			'MY' => 116,
			"if" => 114,
			'OP01_NAMED_VOID_LPAREN' => 113,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_NAMED_VOID' => 107,
			'CONSTANT_CALL_SCOPED' => 109,
			'SELF' => 106,
			'OP01_PRINT' => 105,
			'WORD_UPPERCASE' => 104,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			"our" => 42
		},
		GOTOS => {
			'SubExpression' => 94,
			'HashReference' => 92,
			'VariableModification' => 91,
			'VariableSymbolOrSelf' => 89,
			'Literal' => 96,
			'OPTIONAL-37' => 118,
			'Operation' => 95,
			'PAREN-36' => 117,
			'PLUS-8' => 125,
			'ArrayReference' => 99,
			'Variable' => 124,
			'Subroutine' => 98,
			'Operator' => 97,
			'HashDereference' => 128,
			'WordScoped' => 132,
			'LoopLabel' => 130,
			'Statement' => 135,
			'ArrayDereference' => 108,
			'Conditional' => 133,
			'VariableDeclaration' => 115,
			'OperatorVoid' => 138,
			'Expression' => 137
		}
	},
	{#State 79
		DEFAULT => -12
	},
	{#State 80
		DEFAULT => -234
	},
	{#State 81
		DEFAULT => -235
	},
	{#State 82
		ACTIONS => {
			";" => 140
		}
	},
	{#State 83
		ACTIONS => {
			"\$TYPED_" => 141
		}
	},
	{#State 84
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 142
		}
	},
	{#State 85
		DEFAULT => -44
	},
	{#State 86
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 53,
			'WORD_SCOPED' => 51
		},
		GOTOS => {
			'Type' => 143
		}
	},
	{#State 87
		ACTIONS => {
			"use constant" => 39,
			"our hashref \$properties" => 144
		},
		GOTOS => {
			'Properties' => 146,
			'Constant' => 145
		}
	},
	{#State 88
		DEFAULT => -55
	},
	{#State 89
		DEFAULT => -176,
		GOTOS => {
			'STAR-43' => 147
		}
	},
	{#State 90
		DEFAULT => -232
	},
	{#State 91
		ACTIONS => {
			";" => 148
		}
	},
	{#State 92
		DEFAULT => -141
	},
	{#State 93
		ACTIONS => {
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'Variable' => 149,
			'VariableSymbolOrSelf' => 89
		}
	},
	{#State 94
		ACTIONS => {
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP13_BITWISE_AND' => 152,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 95
		DEFAULT => -17
	},
	{#State 96
		DEFAULT => -137
	},
	{#State 97
		DEFAULT => -129
	},
	{#State 98
		DEFAULT => -14
	},
	{#State 99
		DEFAULT => -139
	},
	{#State 100
		ACTIONS => {
			'LBRACKET' => -199,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'SELF' => 106
		},
		GOTOS => {
			'TypeInner' => 167,
			'VariableSymbolOrSelf' => 89,
			'Variable' => 169,
			'OPTIONAL-47' => 168
		}
	},
	{#State 101
		DEFAULT => -119
	},
	{#State 102
		ACTIONS => {
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"]" => -196,
			"%{" => 111,
			'OP01_QW' => 172,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103
		},
		GOTOS => {
			'Expression' => 171,
			'OPTIONAL-46' => 178,
			'ListElements' => 177,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'Literal' => 96,
			'WordScoped' => 132,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'ListElement' => 176,
			'SubExpression' => 180
		}
	},
	{#State 103
		DEFAULT => -136
	},
	{#State 104
		ACTIONS => {
			'COLON' => -219,
			'LPAREN' => 182
		}
	},
	{#State 105
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -114,
			'LBRACE' => -114,
			'OP01_CLOSE' => -114,
			'CONSTANT_CALL_SCOPED' => -114,
			"%{" => -114,
			'OP10_NAMED_UNARY' => -114,
			'OP01_QW' => -114,
			'LPAREN' => -114,
			'SELF' => -114,
			'WORD_UPPERCASE' => -114,
			"undef" => -114,
			'LBRACKET' => -114,
			'WORD' => -114,
			'OP01_NAMED' => -114,
			'FHREF_SYMBOL_BRACES' => 185,
			'STDOUT_STDERR' => 184,
			'OP01_OPEN' => -114,
			'LITERAL_NUMBER' => -114,
			"\@{" => -114,
			'LITERAL_STRING' => -114,
			'WORD_SCOPED' => -114,
			'OP22_LOGICAL_NEG' => -114,
			'OP05_LOGICAL_NEG' => -114,
			'OP05_BITWISE_NEG_LPAREN' => -114,
			'VARIABLE_SYMBOL' => -114,
			'MY' => -114,
			'ARGV' => -114,
			'OP03_MATH_INC_DEC' => -114
		},
		GOTOS => {
			'OPTIONAL-32' => 183,
			'PAREN-31' => 186
		}
	},
	{#State 106
		DEFAULT => -233
	},
	{#State 107
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			'OP01_QW' => 172,
			"%{" => 111,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'Expression' => 171,
			'ListElements' => 187,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'SubExpression' => 180,
			'ListElement' => 176,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 108
		DEFAULT => -140
	},
	{#State 109
		DEFAULT => -131
	},
	{#State 110
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -100,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			")" => -100,
			"undef" => 103,
			'SELF' => 106,
			'OP04_MATH_POW' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP11_COMPARE_LT_GT' => -100,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'VARIABLE_SYMBOL' => 90,
			'OP23_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP06_REGEX_MATCH' => -100,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_SCOPED' => 27,
			'OP08_STRING_CAT' => -100,
			'LITERAL_NUMBER' => 80,
			'OP18_TERNARY' => -100,
			"\@{" => 100,
			'WORD' => 25,
			'OP17_LIST_RANGE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'LPAREN' => 131,
			'OP01_CLOSE' => 134,
			"]" => -100,
			'OP13_BITWISE_AND' => -100,
			";" => -100,
			'LBRACE' => 139,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			"}" => -100,
			'OP01_OPEN' => 123,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP01_NAMED' => 173,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'Expression' => 171,
			'HashReference' => 92,
			'SubExpression' => 188,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 111
		ACTIONS => {
			'LBRACE' => -214,
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170
		},
		GOTOS => {
			'TypeInner' => 189,
			'VariableSymbolOrSelf' => 89,
			'Variable' => 191,
			'OPTIONAL-51' => 190
		}
	},
	{#State 112
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'SELF' => 106,
			'LPAREN' => 131,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'WordScoped' => 132,
			'Literal' => 96,
			'HashReference' => 92,
			'SubExpression' => 192,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128
		}
	},
	{#State 113
		ACTIONS => {
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			"%{" => 111,
			'OP01_QW' => 172,
			'OP10_NAMED_UNARY' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			")" => -116,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'SubExpression' => 180,
			'ListElement' => 176,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'ListElements' => 193,
			'Expression' => 171,
			'OPTIONAL-33' => 194,
			'TypeInner' => 179,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108
		}
	},
	{#State 114
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 115
		DEFAULT => -155
	},
	{#State 116
		ACTIONS => {
			'WORD_SCOPED' => 51,
			'WORD' => 53,
			'TYPE_INTEGER' => 52,
			'TYPE_FHREF' => 197
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 117
		DEFAULT => -150
	},
	{#State 118
		ACTIONS => {
			"for" => 202,
			"foreach" => 198,
			"while" => 199
		},
		GOTOS => {
			'LoopWhile' => 201,
			'LoopFor' => 200,
			'Loop' => 203,
			'LoopForEach' => 204
		}
	},
	{#State 119
		ACTIONS => {
			'WORD_UPPERCASE' => 206
		},
		GOTOS => {
			'LoopLabel' => 205
		}
	},
	{#State 120
		ACTIONS => {
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'SubExpression' => 207,
			'Literal' => 96,
			'WordScoped' => 132,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 121
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 208,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 122
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'SELF' => 106,
			'LPAREN' => 131,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 209,
			'HashReference' => 92,
			'Expression' => 171,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99
		}
	},
	{#State 123
		ACTIONS => {
			'MY' => 210
		}
	},
	{#State 124
		ACTIONS => {
			'OP15_LOGICAL_AND' => -138,
			'OP16_LOGICAL_OR' => -138,
			'OP07_STRING_REPEAT' => -138,
			'OP04_MATH_POW' => -138,
			")" => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP02_METHOD_THINARROW' => 212,
			'OP08_MATH_ADD_SUB' => -138,
			'OP19_VARIABLE_ASSIGN' => 213,
			'OP11_COMPARE_LT_GT' => -138,
			'OP08_STRING_CAT' => -138,
			'OP19_VARIABLE_ASSIGN_BY' => 214,
			'OP06_REGEX_MATCH' => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP03_MATH_INC_DEC' => 211,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP12_COMPARE_EQ_NE' => -138,
			'OP18_TERNARY' => -138
		}
	},
	{#State 125
		ACTIONS => {
			'' => -18,
			'LITERAL_STRING' => 81,
			"while" => -151,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP19_LOOP_CONTROL' => 119,
			'MY' => 116,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 123,
			"for" => -151,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'LPAREN' => 131,
			"foreach" => -151,
			'OP01_NAMED_SCOLON' => 127,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'OP19_LOOP_CONTROL_SCOLON' => 136,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'SELF' => 106,
			'OP01_PRINT' => 105,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD_UPPERCASE' => 104,
			'LBRACKET' => 102,
			"undef" => 103,
			'OP01_NAMED_VOID_LPAREN' => 113,
			'OP05_MATH_NEG_LPAREN' => 112,
			"if" => 114,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_NAMED_VOID' => 107,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 94,
			'HashReference' => 92,
			'VariableModification' => 91,
			'Operation' => 215,
			'OPTIONAL-37' => 118,
			'PAREN-36' => 117,
			'Literal' => 96,
			'Variable' => 124,
			'Operator' => 97,
			'ArrayReference' => 99,
			'HashDereference' => 128,
			'WordScoped' => 132,
			'LoopLabel' => 130,
			'ArrayDereference' => 108,
			'Conditional' => 133,
			'Statement' => 135,
			'Expression' => 137,
			'VariableDeclaration' => 115,
			'OperatorVoid' => 138
		}
	},
	{#State 126
		ACTIONS => {
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			'OP01_QW' => 172,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'TypeInner' => 179,
			'ArrayReference' => 99,
			'Expression' => 171,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 217,
			'ListElement' => 216,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 127
		DEFAULT => -79
	},
	{#State 128
		DEFAULT => -142
	},
	{#State 129
		DEFAULT => -80
	},
	{#State 130
		ACTIONS => {
			'COLON' => 218
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_PRINT' => 220,
			'LPAREN' => 131,
			'SELF' => 106,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP01_NAMED' => 219,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'HashReference' => 92,
			'SubExpression' => 221,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Expression' => 171,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174
		}
	},
	{#State 132
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 223,
			'LPAREN' => 222
		}
	},
	{#State 133
		DEFAULT => -152
	},
	{#State 134
		ACTIONS => {
			'FHREF_SYMBOL' => 224
		}
	},
	{#State 135
		DEFAULT => -81
	},
	{#State 136
		DEFAULT => -123
	},
	{#State 137
		ACTIONS => {
			'OP08_STRING_CAT' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP18_TERNARY' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP04_MATH_POW' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			";" => 225,
			'OP13_BITWISE_AND' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP11_COMPARE_LT_GT' => -135
		}
	},
	{#State 138
		DEFAULT => -154
	},
	{#State 139
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 233,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 232,
			'OP01_CLOSE' => 241,
			'OP08_MATH_ADD_SUB' => 231,
			'OP01_NAMED_VOID' => 230,
			'ENV' => 228,
			'SELF' => 106,
			'OP07_STRING_REPEAT' => 227,
			'OP01_PRINT' => 226,
			'LITERAL_NUMBER' => 80,
			'OP12_COMPARE_EQ_NE' => 250,
			"}" => 249,
			'OP01_OPEN' => 247,
			'OP01_NAMED' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP24_LOGICAL_OR_XOR' => 245,
			'WORD' => 236,
			'VARIABLE_SYMBOL' => 90,
			'OP23_LOGICAL_AND' => 235,
			'OP22_LOGICAL_NEG' => 244,
			'OP19_LOOP_CONTROL' => 243,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'HashDereference' => 240,
			'OpStringOrWord' => 239,
			'VariableSymbolOrSelf' => 89,
			'Variable' => 248,
			'HashEntry' => 238,
			'VarOrLitOrOpStrOrWord' => 229,
			'Literal' => 234
		}
	},
	{#State 140
		DEFAULT => -43
	},
	{#State 141
		ACTIONS => {
			'WORD_UPPERCASE' => 251
		}
	},
	{#State 142
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'LPAREN' => 131,
			"foreach" => -151,
			'OP01_NAMED_SCOLON' => 127,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'OP19_LOOP_CONTROL_SCOLON' => 136,
			'LITERAL_STRING' => 81,
			"while" => -151,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP19_LOOP_CONTROL' => 119,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'MY' => 116,
			'OP01_NAMED' => 126,
			"}" => 253,
			'OP01_OPEN' => 123,
			"for" => -151,
			'SELF' => 106,
			'OP01_PRINT' => 105,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD_UPPERCASE' => 104,
			'LBRACKET' => 102,
			"undef" => 103,
			'OP01_NAMED_VOID_LPAREN' => 113,
			'OP05_MATH_NEG_LPAREN' => 112,
			"if" => 114,
			'OP01_NAMED_VOID' => 107,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100
		},
		GOTOS => {
			'Statement' => 135,
			'Conditional' => 133,
			'ArrayDereference' => 108,
			'OperatorVoid' => 138,
			'VariableDeclaration' => 115,
			'Expression' => 137,
			'HashDereference' => 128,
			'LoopLabel' => 130,
			'WordScoped' => 132,
			'ArrayReference' => 99,
			'Operator' => 97,
			'Variable' => 124,
			'HashReference' => 92,
			'VariableModification' => 91,
			'SubExpression' => 94,
			'VariableSymbolOrSelf' => 89,
			'Literal' => 96,
			'PAREN-36' => 117,
			'OPTIONAL-37' => 118,
			'Operation' => 252
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 254
		}
	},
	{#State 144
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 255
		}
	},
	{#State 145
		DEFAULT => -57
	},
	{#State 146
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 256
		}
	},
	{#State 147
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -177,
			")" => -177,
			'OP04_MATH_POW' => -177,
			'OP07_STRING_REPEAT' => -177,
			'OP15_LOGICAL_AND' => -177,
			'OP16_LOGICAL_OR' => -177,
			"]" => -177,
			'OP11_COMPARE_LT_GT' => -177,
			'OP19_VARIABLE_ASSIGN' => -177,
			'OP08_MATH_ADD_SUB' => -177,
			'OP02_METHOD_THINARROW' => -177,
			'OP13_BITWISE_AND' => -177,
			";" => -177,
			'OP02_ARRAY_THINARROW' => 257,
			'OP03_MATH_INC_DEC' => -177,
			'OP23_LOGICAL_AND' => -177,
			'OP09_BITWISE_SHIFT' => -177,
			'OP06_REGEX_MATCH' => -177,
			'OP02_HASH_THINARROW' => 259,
			'OP20_HASH_FATARROW' => -177,
			'OP19_VARIABLE_ASSIGN_BY' => -177,
			'OP08_STRING_CAT' => -177,
			'OP12_COMPARE_EQ_NE' => -177,
			'OP18_TERNARY' => -177,
			"}" => -177,
			'OP07_MATH_MULT_DIV_MOD' => -177,
			'OP24_LOGICAL_OR_XOR' => -177,
			'OP21_LIST_COMMA' => -177,
			'OP17_LIST_RANGE' => -177,
			'COLON' => -177
		},
		GOTOS => {
			'VariableRetrieval' => 258
		}
	},
	{#State 148
		DEFAULT => -156
	},
	{#State 149
		DEFAULT => -87
	},
	{#State 150
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99,
			'Expression' => 171,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 260,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 151
		ACTIONS => {
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'SELF' => 106,
			'LPAREN' => 131,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'HashReference' => 92,
			'SubExpression' => 261,
			'Literal' => 96,
			'WordScoped' => 132,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 152
		ACTIONS => {
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'SubExpression' => 262,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Expression' => 171,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97
		}
	},
	{#State 153
		ACTIONS => {
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'WORD' => 25,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayReference' => 99,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'WordScoped' => 132,
			'Literal' => 96,
			'HashReference' => 92,
			'SubExpression' => 263,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128
		}
	},
	{#State 154
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'SELF' => 106,
			'LPAREN' => 131,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 264,
			'HashReference' => 92,
			'Expression' => 171,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99
		}
	},
	{#State 155
		ACTIONS => {
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LPAREN' => 131,
			'SELF' => 106,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'WordScoped' => 132,
			'Literal' => 96,
			'SubExpression' => 265,
			'HashReference' => 92,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89
		}
	},
	{#State 156
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'SubExpression' => 266,
			'Expression' => 171,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99
		}
	},
	{#State 157
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 267,
			'HashReference' => 92,
			'Expression' => 171,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99
		}
	},
	{#State 158
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'LPAREN' => 131,
			'SELF' => 106
		},
		GOTOS => {
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Expression' => 171,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 268,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'LPAREN' => 131,
			'SELF' => 106
		},
		GOTOS => {
			'ArrayReference' => 99,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'Expression' => 171,
			'HashReference' => 92,
			'SubExpression' => 269,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 160
		ACTIONS => {
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'SubExpression' => 270,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Expression' => 171,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108
		}
	},
	{#State 161
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'HashReference' => 92,
			'SubExpression' => 271,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'WordScoped' => 132,
			'Literal' => 96,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'Expression' => 171
		}
	},
	{#State 162
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 272
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'LPAREN' => 131,
			'SELF' => 106
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 273,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 164
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			'VARIABLE_SYMBOL' => 90,
			'SELF' => 106,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 276,
			'VariableOrLiteral' => 274,
			'VariableSymbolOrSelf' => 89,
			'Variable' => 275
		}
	},
	{#State 165
		ACTIONS => {
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'WordScoped' => 132,
			'Literal' => 96,
			'HashReference' => 92,
			'SubExpression' => 277,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 278,
			'HashReference' => 92,
			'Literal' => 96,
			'WordScoped' => 132,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 167
		DEFAULT => -198
	},
	{#State 168
		ACTIONS => {
			'LBRACKET' => 102
		},
		GOTOS => {
			'ArrayReference' => 279
		}
	},
	{#State 169
		ACTIONS => {
			"}" => 280
		}
	},
	{#State 170
		ACTIONS => {
			'WORD_SCOPED' => 51,
			'WORD' => 53,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 281
		}
	},
	{#State 171
		DEFAULT => -135
	},
	{#State 172
		DEFAULT => -193
	},
	{#State 173
		ACTIONS => {
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'SubExpression' => 282,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Expression' => 171,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97
		}
	},
	{#State 174
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 211,
			'OP06_REGEX_MATCH' => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP08_STRING_CAT' => -138,
			'OP12_COMPARE_EQ_NE' => -138,
			'OP18_TERNARY' => -138,
			"}" => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP21_LIST_COMMA' => -138,
			'OP17_LIST_RANGE' => -138,
			")" => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP07_STRING_REPEAT' => -138,
			'OP04_MATH_POW' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP16_LOGICAL_OR' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			"]" => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP02_METHOD_THINARROW' => 212,
			";" => -138,
			'OP13_BITWISE_AND' => -138
		}
	},
	{#State 175
		ACTIONS => {
			'LPAREN' => 182
		}
	},
	{#State 176
		DEFAULT => -189,
		GOTOS => {
			'STAR-45' => 283
		}
	},
	{#State 177
		DEFAULT => -195
	},
	{#State 178
		ACTIONS => {
			"]" => 284
		}
	},
	{#State 179
		ACTIONS => {
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'SELF' => 106,
			'LPAREN' => 131,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'SubExpression' => 285,
			'WordScoped' => 132,
			'Literal' => 96,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 180
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP21_LIST_COMMA' => -191,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			")" => -191,
			'OP14_BITWISE_OR_XOR' => 155,
			";" => -191,
			'OP13_BITWISE_AND' => 152,
			'OP11_COMPARE_LT_GT' => 158,
			"]" => -191,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 181
		DEFAULT => -194
	},
	{#State 182
		ACTIONS => {
			")" => 286
		}
	},
	{#State 183
		ACTIONS => {
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_QW' => 172,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ListElements' => 287,
			'Expression' => 171,
			'HashReference' => 92,
			'ListElement' => 176,
			'SubExpression' => 180,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 184
		DEFAULT => -112
	},
	{#State 185
		ACTIONS => {
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP01_QW' => 172,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LPAREN' => 131,
			'SELF' => 106,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175
		},
		GOTOS => {
			'ListElements' => 288,
			'Expression' => 171,
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'Literal' => 96,
			'WordScoped' => 132,
			'HashReference' => 92,
			'ListElement' => 176,
			'SubExpression' => 180,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89
		}
	},
	{#State 186
		DEFAULT => -113
	},
	{#State 187
		ACTIONS => {
			";" => 289
		}
	},
	{#State 188
		ACTIONS => {
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			")" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			";" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP21_LIST_COMMA' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP18_TERNARY' => -99,
			"}" => -99
		}
	},
	{#State 189
		DEFAULT => -213
	},
	{#State 190
		ACTIONS => {
			'LBRACE' => 139
		},
		GOTOS => {
			'HashReference' => 290
		}
	},
	{#State 191
		ACTIONS => {
			"}" => 291
		}
	},
	{#State 192
		ACTIONS => {
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 292,
			'OP13_BITWISE_AND' => 152,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 193
		DEFAULT => -115
	},
	{#State 194
		ACTIONS => {
			")" => 293
		}
	},
	{#State 195
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93
		},
		GOTOS => {
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99,
			'Expression' => 171,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 294,
			'HashReference' => 92,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 197
		ACTIONS => {
			'FHREF_SYMBOL' => 296
		}
	},
	{#State 198
		ACTIONS => {
			'MY' => 297
		}
	},
	{#State 199
		ACTIONS => {
			'LPAREN_MY' => 299,
			'LPAREN' => 298
		}
	},
	{#State 200
		DEFAULT => -164
	},
	{#State 201
		DEFAULT => -166
	},
	{#State 202
		ACTIONS => {
			'LPAREN_MY' => 300,
			'MY' => 301
		}
	},
	{#State 203
		DEFAULT => -153
	},
	{#State 204
		DEFAULT => -165
	},
	{#State 205
		ACTIONS => {
			";" => 302
		}
	},
	{#State 206
		DEFAULT => -219
	},
	{#State 207
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 303,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157
		}
	},
	{#State 208
		ACTIONS => {
			'OP21_LIST_COMMA' => -109,
			'OP17_LIST_RANGE' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => -109,
			"}" => -109,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -109,
			'OP09_BITWISE_SHIFT' => 161,
			";" => -109,
			'OP13_BITWISE_AND' => 152,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -109,
			'OP11_COMPARE_LT_GT' => 158,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			")" => -109,
			'OP14_BITWISE_OR_XOR' => 155
		}
	},
	{#State 209
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_STRING_CAT' => -91,
			'OP18_TERNARY' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			"}" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			")" => -91,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP15_LOGICAL_AND' => -91,
			"]" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			";" => -91
		}
	},
	{#State 210
		ACTIONS => {
			'TYPE_FHREF' => 304
		}
	},
	{#State 211
		DEFAULT => -88
	},
	{#State 212
		ACTIONS => {
			'LPAREN' => 305
		}
	},
	{#State 213
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'STDIN' => 307,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'FHREF_SYMBOL_IN' => 306,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'WordScoped' => 132,
			'Literal' => 96,
			'SubExpression' => 309,
			'HashReference' => 92,
			'SubExpressionOrInput' => 308,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89
		}
	},
	{#State 214
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Expression' => 171,
			'SubExpression' => 310,
			'HashReference' => 92,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 215
		DEFAULT => -16
	},
	{#State 216
		ACTIONS => {
			'OP21_LIST_COMMA' => 311
		}
	},
	{#State 217
		ACTIONS => {
			'OP13_BITWISE_AND' => -83,
			";" => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			")" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP21_LIST_COMMA' => -191,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP18_TERNARY' => -83,
			'OP08_STRING_CAT' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP06_REGEX_MATCH' => -83
		}
	},
	{#State 218
		DEFAULT => -149
	},
	{#State 219
		ACTIONS => {
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP01_QW' => 172,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LPAREN' => 131,
			'SELF' => 106,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'Expression' => 171,
			'TypeInner' => 179,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Literal' => 96,
			'WordScoped' => 132,
			'ListElement' => 312,
			'SubExpression' => 217,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128
		}
	},
	{#State 220
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 313
		}
	},
	{#State 221
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 314,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165
		}
	},
	{#State 222
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			'OP01_QW' => 172,
			"%{" => 111,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			")" => -126,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93
		},
		GOTOS => {
			'TypeInner' => 179,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ListElements' => 316,
			'Expression' => 171,
			'OPTIONAL-34' => 315,
			'SubExpression' => 180,
			'ListElement' => 176,
			'HashReference' => 92,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 223
		ACTIONS => {
			")" => 317
		}
	},
	{#State 224
		DEFAULT => -86
	},
	{#State 225
		DEFAULT => -78
	},
	{#State 226
		DEFAULT => -257
	},
	{#State 227
		DEFAULT => -252
	},
	{#State 228
		DEFAULT => -206
	},
	{#State 229
		ACTIONS => {
			'OP20_HASH_FATARROW' => 318
		}
	},
	{#State 230
		DEFAULT => -256
	},
	{#State 231
		DEFAULT => -250
	},
	{#State 232
		DEFAULT => -249
	},
	{#State 233
		DEFAULT => -248
	},
	{#State 234
		DEFAULT => -230
	},
	{#State 235
		DEFAULT => -243
	},
	{#State 236
		DEFAULT => -258
	},
	{#State 237
		DEFAULT => -251
	},
	{#State 238
		DEFAULT => -210,
		GOTOS => {
			'STAR-50' => 319
		}
	},
	{#State 239
		DEFAULT => -231
	},
	{#State 240
		DEFAULT => -205
	},
	{#State 241
		DEFAULT => -254
	},
	{#State 242
		DEFAULT => -245
	},
	{#State 243
		DEFAULT => -246
	},
	{#State 244
		DEFAULT => -244
	},
	{#State 245
		DEFAULT => -242
	},
	{#State 246
		DEFAULT => -253
	},
	{#State 247
		DEFAULT => -255
	},
	{#State 248
		DEFAULT => -229
	},
	{#State 249
		DEFAULT => -212
	},
	{#State 250
		DEFAULT => -247
	},
	{#State 251
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 320
		}
	},
	{#State 252
		DEFAULT => -46
	},
	{#State 253
		ACTIONS => {
			";" => 321
		}
	},
	{#State 254
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 322
		}
	},
	{#State 255
		ACTIONS => {
			'LBRACE' => 323
		}
	},
	{#State 256
		ACTIONS => {
			'LITERAL_NUMBER' => 328,
			"our" => 326
		},
		GOTOS => {
			'Subroutine' => 327,
			'Method' => 324,
			'MethodOrSubroutine' => 325
		}
	},
	{#State 257
		ACTIONS => {
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 329,
			'HashReference' => 92,
			'Literal' => 96,
			'WordScoped' => 132,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 258
		DEFAULT => -175
	},
	{#State 259
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 331,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'HashReference' => 92,
			'SubExpression' => 330,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'Expression' => 171,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174
		}
	},
	{#State 260
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -105,
			'OP09_BITWISE_SHIFT' => 161,
			'OP08_STRING_CAT' => 163,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -105,
			'OP11_COMPARE_LT_GT' => 158,
			";" => -105,
			'OP13_BITWISE_AND' => 152
		}
	},
	{#State 261
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP18_TERNARY' => -106,
			'OP12_COMPARE_EQ_NE' => 153,
			"}" => -106,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => -106,
			'OP15_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -106,
			'OP13_BITWISE_AND' => 152,
			";" => -106,
			"]" => -106,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 262
		ACTIONS => {
			'OP15_LOGICAL_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			")" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			";" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			"]" => -103,
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -103,
			'OP09_BITWISE_SHIFT' => 161,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => -103,
			"}" => -103,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => -103
		}
	},
	{#State 263
		ACTIONS => {
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP18_TERNARY' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -102,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => -102,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			")" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157
		}
	},
	{#State 264
		ACTIONS => {
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			"]" => -111,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -111,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150
		}
	},
	{#State 265
		ACTIONS => {
			")" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -104,
			'OP11_COMPARE_LT_GT' => 158,
			";" => -104,
			'OP13_BITWISE_AND' => 152,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 163,
			"}" => -104,
			'OP18_TERNARY' => -104,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => -104
		}
	},
	{#State 266
		ACTIONS => {
			'OP08_STRING_CAT' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP18_TERNARY' => -89,
			"}" => -89,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			")" => -89,
			'OP13_BITWISE_AND' => -89,
			";" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			"]" => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 267
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP08_STRING_CAT' => -94,
			'OP18_TERNARY' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"}" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			")" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => -94,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			"]" => -94,
			'OP08_MATH_ADD_SUB' => -94,
			";" => -94,
			'OP13_BITWISE_AND' => -94
		}
	},
	{#State 268
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -101,
			")" => -101,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => -101,
			"]" => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => -101,
			";" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP18_TERNARY' => -101,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 166
		}
	},
	{#State 269
		ACTIONS => {
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => -96,
			"}" => -96,
			'OP18_TERNARY' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP08_STRING_CAT' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => -96,
			";" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			"]" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96
		}
	},
	{#State 270
		ACTIONS => {
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -110,
			'OP13_BITWISE_AND' => 152,
			";" => -110,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -110,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => -110,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -110,
			'OP17_LIST_RANGE' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => -110,
			"}" => -110,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => -98,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98
		}
	},
	{#State 272
		DEFAULT => -93
	},
	{#State 273
		ACTIONS => {
			'OP17_LIST_RANGE' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP18_TERNARY' => -97,
			"}" => -97,
			'OP08_STRING_CAT' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => -97,
			";" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			"]" => -97,
			'OP08_MATH_ADD_SUB' => 159,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			")" => -97
		}
	},
	{#State 274
		ACTIONS => {
			'COLON' => 332
		}
	},
	{#State 275
		DEFAULT => -227
	},
	{#State 276
		DEFAULT => -228
	},
	{#State 277
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -107,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => -107,
			"}" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -107,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 158,
			"]" => -107,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152,
			";" => -107
		}
	},
	{#State 278
		ACTIONS => {
			";" => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			")" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP08_STRING_CAT' => -95,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95
		}
	},
	{#State 279
		ACTIONS => {
			"}" => 333
		}
	},
	{#State 280
		DEFAULT => -200
	},
	{#State 281
		ACTIONS => {
			"\$TYPED_" => 334
		}
	},
	{#State 282
		ACTIONS => {
			'OP13_BITWISE_AND' => -83,
			";" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			"]" => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP04_MATH_POW' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			")" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP18_TERNARY' => -83,
			"}" => -83,
			'OP08_STRING_CAT' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP06_REGEX_MATCH' => -83
		}
	},
	{#State 283
		ACTIONS => {
			")" => -190,
			"]" => -190,
			";" => -190,
			'OP21_LIST_COMMA' => 336
		},
		GOTOS => {
			'PAREN-44' => 335
		}
	},
	{#State 284
		DEFAULT => -197
	},
	{#State 285
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP21_LIST_COMMA' => -192,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -192,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152,
			";" => -192,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -192,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157
		}
	},
	{#State 286
		DEFAULT => -130
	},
	{#State 287
		ACTIONS => {
			";" => 337
		}
	},
	{#State 288
		ACTIONS => {
			";" => 338
		}
	},
	{#State 289
		DEFAULT => -121
	},
	{#State 290
		ACTIONS => {
			"}" => 339
		}
	},
	{#State 291
		DEFAULT => -215
	},
	{#State 292
		DEFAULT => -92
	},
	{#State 293
		ACTIONS => {
			";" => 340
		}
	},
	{#State 294
		ACTIONS => {
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 341,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152
		}
	},
	{#State 295
		ACTIONS => {
			";" => 342,
			'OP19_VARIABLE_ASSIGN' => 344,
			'OP02_ARRAY_THINARROW' => 343
		}
	},
	{#State 296
		ACTIONS => {
			";" => 345
		}
	},
	{#State 297
		ACTIONS => {
			'WORD_SCOPED' => 51,
			'WORD' => 53,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 346
		}
	},
	{#State 298
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Expression' => 171,
			'SubExpression' => 347,
			'HashReference' => 92,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 299
		ACTIONS => {
			'WORD' => 53,
			'WORD_SCOPED' => 51,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 348
		}
	},
	{#State 300
		ACTIONS => {
			'TYPE_INTEGER' => 349
		}
	},
	{#State 301
		ACTIONS => {
			'TYPE_INTEGER' => 350
		}
	},
	{#State 302
		DEFAULT => -124
	},
	{#State 303
		DEFAULT => -90
	},
	{#State 304
		ACTIONS => {
			'FHREF_SYMBOL' => 351
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			")" => -128,
			'LBRACKET' => 102,
			"undef" => 103,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP01_QW' => 172,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'Expression' => 171,
			'ListElements' => 352,
			'OPTIONAL-35' => 353,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'Literal' => 96,
			'WordScoped' => 132,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'ListElement' => 176,
			'SubExpression' => 180
		}
	},
	{#State 306
		DEFAULT => -145
	},
	{#State 307
		DEFAULT => -146
	},
	{#State 308
		DEFAULT => -185
	},
	{#State 309
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -144,
			'OP13_BITWISE_AND' => 152,
			";" => -144,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158
		}
	},
	{#State 310
		ACTIONS => {
			'OP13_BITWISE_AND' => 152,
			";" => -186,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -186,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 311
		ACTIONS => {
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			'OP01_QW' => 172,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'SubExpression' => 180,
			'ListElement' => 176,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'ListElements' => 354,
			'Expression' => 171,
			'TypeInner' => 179,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97
		}
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 355
		}
	},
	{#State 313
		ACTIONS => {
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_QW' => 172,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 180,
			'ListElement' => 176,
			'HashReference' => 92,
			'Expression' => 171,
			'ListElements' => 356,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'TypeInner' => 179,
			'ArrayReference' => 99
		}
	},
	{#State 314
		DEFAULT => -143
	},
	{#State 315
		ACTIONS => {
			")" => 357
		}
	},
	{#State 316
		DEFAULT => -125
	},
	{#State 317
		DEFAULT => -134
	},
	{#State 318
		ACTIONS => {
			'WORD_UPPERCASE' => -203,
			"undef" => -203,
			'LBRACKET' => -203,
			'LPAREN' => -203,
			'SELF' => -203,
			'OP01_CLOSE' => -203,
			'CONSTANT_CALL_SCOPED' => -203,
			"%{" => -203,
			'OP10_NAMED_UNARY' => -203,
			'OP05_MATH_NEG_LPAREN' => -203,
			'LBRACE' => -203,
			'VARIABLE_SYMBOL' => -203,
			'MY' => 170,
			'OP03_MATH_INC_DEC' => -203,
			'WORD_SCOPED' => -203,
			'LITERAL_STRING' => -203,
			'OP05_LOGICAL_NEG' => -203,
			'OP22_LOGICAL_NEG' => -203,
			'OP05_BITWISE_NEG_LPAREN' => -203,
			'OP01_OPEN' => -203,
			'LITERAL_NUMBER' => -203,
			"\@{" => -203,
			'WORD' => -203,
			'OP01_NAMED' => -203
		},
		GOTOS => {
			'TypeInner' => 359,
			'OPTIONAL-48' => 358
		}
	},
	{#State 319
		ACTIONS => {
			"}" => 362,
			'OP21_LIST_COMMA' => 361
		},
		GOTOS => {
			'PAREN-49' => 360
		}
	},
	{#State 320
		DEFAULT => -226
	},
	{#State 321
		DEFAULT => -48
	},
	{#State 322
		ACTIONS => {
			'OP21_LIST_COMMA' => 364,
			")" => 363
		},
		GOTOS => {
			'PAREN-19' => 365
		}
	},
	{#State 323
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 244,
			'OP19_LOOP_CONTROL' => 243,
			'OP23_LOGICAL_AND' => 235,
			'WORD' => 236,
			'OP01_NAMED' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP24_LOGICAL_OR_XOR' => 245,
			"}" => 367,
			'OP01_OPEN' => 247,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP01_PRINT' => 226,
			'OP07_STRING_REPEAT' => 227,
			'OP01_CLOSE' => 241,
			'OP08_MATH_ADD_SUB' => 231,
			'OP01_NAMED_VOID' => 230,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			'OP11_COMPARE_LT_GT' => 233,
			'OP10_NAMED_UNARY' => 232
		},
		GOTOS => {
			'HashEntryProperties' => 366,
			'OpStringOrWord' => 368
		}
	},
	{#State 324
		DEFAULT => -76
	},
	{#State 325
		DEFAULT => -59
	},
	{#State 326
		ACTIONS => {
			'WORD_SCOPED' => 51,
			'WORD' => 53,
			'TYPE_METHOD' => 369,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 50
		}
	},
	{#State 327
		DEFAULT => -77
	},
	{#State 328
		ACTIONS => {
			";" => 370
		}
	},
	{#State 329
		ACTIONS => {
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => 371,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156
		}
	},
	{#State 330
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			"}" => 372,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP08_STRING_CAT' => 163
		}
	},
	{#State 331
		ACTIONS => {
			"}" => 373,
			'OP02_METHOD_THINARROW_NEW' => -217,
			'LPAREN' => -217
		}
	},
	{#State 332
		ACTIONS => {
			'VARIABLE_SYMBOL' => 90,
			'LITERAL_NUMBER' => 80,
			'LITERAL_STRING' => 81,
			'SELF' => 106
		},
		GOTOS => {
			'Literal' => 276,
			'VariableOrLiteral' => 374,
			'VariableSymbolOrSelf' => 89,
			'Variable' => 275
		}
	},
	{#State 333
		DEFAULT => -201
	},
	{#State 334
		ACTIONS => {
			'OP23_LOGICAL_AND' => 235,
			'OP19_LOOP_CONTROL' => 243,
			'OP22_LOGICAL_NEG' => 244,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP01_OPEN' => 247,
			'OP24_LOGICAL_OR_XOR' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP01_NAMED' => 246,
			'WORD' => 236,
			'OP01_PRINT' => 226,
			'OP07_STRING_REPEAT' => 227,
			'OP10_NAMED_UNARY' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			'OP01_NAMED_VOID' => 230,
			'OP01_CLOSE' => 241,
			'OP08_MATH_ADD_SUB' => 231
		},
		GOTOS => {
			'OpStringOrWord' => 375
		}
	},
	{#State 335
		DEFAULT => -188
	},
	{#State 336
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP01_QW' => 172,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'MY' => 170,
			'VARIABLE_SYMBOL' => 90,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99,
			'TypeInner' => 179,
			'Expression' => 171,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'HashReference' => 92,
			'ListElement' => 376,
			'SubExpression' => 180,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 337
		DEFAULT => -117
	},
	{#State 338
		DEFAULT => -118
	},
	{#State 339
		DEFAULT => -216
	},
	{#State 340
		DEFAULT => -120
	},
	{#State 341
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 342
		DEFAULT => -181
	},
	{#State 343
		ACTIONS => {
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103
		},
		GOTOS => {
			'Expression' => 171,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99,
			'WordScoped' => 132,
			'Literal' => 96,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 379,
			'HashReference' => 92
		}
	},
	{#State 344
		ACTIONS => {
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED_SCOLON' => 383,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 382,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'STDIN' => 307,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'FHREF_SYMBOL_IN' => 306,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25
		},
		GOTOS => {
			'SubExpression' => 309,
			'SubExpressionOrInput' => 380,
			'HashReference' => 92,
			'OpNamedScolonOrSubExpIn' => 381,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'Literal' => 96,
			'WordScoped' => 132,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Expression' => 171
		}
	},
	{#State 345
		DEFAULT => -184
	},
	{#State 346
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 347
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 385,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165
		}
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 350
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 389
		}
	},
	{#State 352
		DEFAULT => -127
	},
	{#State 353
		ACTIONS => {
			")" => 390
		}
	},
	{#State 354
		ACTIONS => {
			";" => 391
		}
	},
	{#State 355
		ACTIONS => {
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'OP03_MATH_INC_DEC' => 93,
			'ARGV' => 181,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_QW' => 172,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'LPAREN' => 131,
			'SELF' => 106
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'ListElement' => 176,
			'SubExpression' => 180,
			'HashReference' => 92,
			'Expression' => 171,
			'ListElements' => 392,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'TypeInner' => 179,
			'ArrayReference' => 99
		}
	},
	{#State 356
		ACTIONS => {
			")" => 393
		}
	},
	{#State 357
		DEFAULT => -132
	},
	{#State 358
		ACTIONS => {
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Expression' => 171,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99,
			'WordScoped' => 132,
			'Literal' => 96,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'SubExpression' => 394
		}
	},
	{#State 359
		DEFAULT => -202
	},
	{#State 360
		DEFAULT => -209
	},
	{#State 361
		ACTIONS => {
			'OP01_OPEN' => 247,
			'LITERAL_NUMBER' => 80,
			'OP12_COMPARE_EQ_NE' => 250,
			'WORD' => 236,
			'OP01_NAMED' => 246,
			'OP24_LOGICAL_OR_XOR' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP23_LOGICAL_AND' => 235,
			'VARIABLE_SYMBOL' => 90,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 244,
			'OP19_LOOP_CONTROL' => 243,
			'OP08_MATH_ADD_SUB' => 231,
			'OP01_CLOSE' => 241,
			'OP01_NAMED_VOID' => 230,
			'OP11_COMPARE_LT_GT' => 233,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 232,
			'ENV' => 228,
			'SELF' => 106,
			'OP07_STRING_REPEAT' => 227,
			'OP01_PRINT' => 226
		},
		GOTOS => {
			'Variable' => 248,
			'HashDereference' => 240,
			'VariableSymbolOrSelf' => 89,
			'OpStringOrWord' => 239,
			'HashEntry' => 395,
			'Literal' => 234,
			'VarOrLitOrOpStrOrWord' => 229
		}
	},
	{#State 362
		DEFAULT => -211
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 364
		ACTIONS => {
			'MY' => 397
		}
	},
	{#State 365
		DEFAULT => -50
	},
	{#State 366
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 398
		}
	},
	{#State 367
		ACTIONS => {
			";" => 399
		}
	},
	{#State 368
		ACTIONS => {
			'OP20_HASH_FATARROW' => 400
		}
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 370
		DEFAULT => -61
	},
	{#State 371
		DEFAULT => -178
	},
	{#State 372
		DEFAULT => -179
	},
	{#State 373
		DEFAULT => -180
	},
	{#State 374
		DEFAULT => -108
	},
	{#State 375
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 376
		DEFAULT => -187
	},
	{#State 377
		DEFAULT => -159,
		GOTOS => {
			'STAR-39' => 403
		}
	},
	{#State 378
		ACTIONS => {
			'OP01_NAMED' => 126,
			"for" => -151,
			'OP01_OPEN' => 123,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP19_LOOP_CONTROL' => 119,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 81,
			"while" => -151,
			'MY' => 116,
			'LBRACE' => 139,
			'OP19_LOOP_CONTROL_SCOLON' => 136,
			'OP01_CLOSE' => 134,
			'LPAREN' => 131,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP01_NAMED_SCOLON' => 127,
			"foreach" => -151,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			"if" => 114,
			'OP01_NAMED_VOID_LPAREN' => 113,
			'OP05_MATH_NEG_LPAREN' => 112,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_NAMED_VOID' => 107,
			'SELF' => 106,
			'OP01_PRINT' => 105,
			'WORD_UPPERCASE' => 104,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP01_NAMED_VOID_SCOLON' => 101
		},
		GOTOS => {
			'Operator' => 97,
			'Variable' => 124,
			'ArrayReference' => 99,
			'PAREN-36' => 117,
			'OPTIONAL-37' => 118,
			'Operation' => 405,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'VariableModification' => 91,
			'SubExpression' => 94,
			'Expression' => 137,
			'OperatorVoid' => 138,
			'VariableDeclaration' => 115,
			'Conditional' => 133,
			'ArrayDereference' => 108,
			'Statement' => 135,
			'LoopLabel' => 130,
			'PLUS-42' => 404,
			'WordScoped' => 132,
			'HashDereference' => 128
		}
	},
	{#State 379
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP08_STRING_CAT' => 163,
			"]" => 406,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150
		}
	},
	{#State 380
		ACTIONS => {
			";" => 407
		}
	},
	{#State 381
		DEFAULT => -182
	},
	{#State 382
		DEFAULT => -240
	},
	{#State 383
		DEFAULT => -239
	},
	{#State 384
		ACTIONS => {
			'LPAREN' => 408
		}
	},
	{#State 385
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 409
		}
	},
	{#State 386
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 388
		ACTIONS => {
			'LPAREN' => 412
		}
	},
	{#State 389
		ACTIONS => {
			'LITERAL_STRING' => 413
		}
	},
	{#State 390
		DEFAULT => -133
	},
	{#State 391
		DEFAULT => -122
	},
	{#State 392
		ACTIONS => {
			")" => 414
		}
	},
	{#State 393
		DEFAULT => -82
	},
	{#State 394
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			"}" => -204,
			'OP17_LIST_RANGE' => 165,
			'OP21_LIST_COMMA' => -204,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163
		}
	},
	{#State 395
		DEFAULT => -208
	},
	{#State 396
		ACTIONS => {
			"\@_;" => 415
		}
	},
	{#State 397
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 416
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
		DEFAULT => -66
	},
	{#State 400
		ACTIONS => {
			'MY' => 421
		},
		GOTOS => {
			'TypeInnerProperties' => 420
		}
	},
	{#State 401
		ACTIONS => {
			"= sub {" => 422
		}
	},
	{#State 402
		DEFAULT => -223
	},
	{#State 403
		ACTIONS => {
			'WORD' => -162,
			"\@{" => -162,
			'LITERAL_NUMBER' => -162,
			'WORD_SCOPED' => -162,
			'VARIABLE_SYMBOL' => -162,
			'OP03_MATH_INC_DEC' => -162,
			'OP05_MATH_NEG_LPAREN' => -162,
			'OP01_NAMED_VOID_LPAREN' => -162,
			"if" => -162,
			'OP01_NAMED_VOID' => -162,
			'CONSTANT_CALL_SCOPED' => -162,
			"%{" => -162,
			'OP10_NAMED_UNARY' => -162,
			"elsif" => 424,
			'OP01_PRINT' => -162,
			'SELF' => -162,
			'OP01_NAMED_VOID_SCOLON' => -162,
			'LBRACKET' => -162,
			"undef" => -162,
			'WORD_UPPERCASE' => -162,
			'OP01_NAMED' => -162,
			"for" => -162,
			'OP01_OPEN' => -162,
			"}" => -162,
			"while" => -162,
			'LITERAL_STRING' => -162,
			'' => -162,
			'OP05_BITWISE_NEG_LPAREN' => -162,
			'OP19_LOOP_CONTROL' => -162,
			'OP22_LOGICAL_NEG' => -162,
			'OP05_LOGICAL_NEG' => -162,
			'MY' => -162,
			"else" => 427,
			'LBRACE' => -162,
			'OP01_CLOSE' => -162,
			'OP19_LOOP_CONTROL_SCOLON' => -162,
			'OP10_NAMED_UNARY_SCOLON' => -162,
			'LPAREN' => -162,
			"foreach" => -162,
			'OP01_NAMED_SCOLON' => -162
		},
		GOTOS => {
			'PAREN-40' => 426,
			'PAREN-38' => 423,
			'OPTIONAL-41' => 425
		}
	},
	{#State 404
		ACTIONS => {
			'WORD_UPPERCASE' => 104,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'SELF' => 106,
			'OP01_PRINT' => 105,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_NAMED_VOID' => 107,
			'CONSTANT_CALL_SCOPED' => 109,
			"if" => 114,
			'OP01_NAMED_VOID_LPAREN' => 113,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD' => 25,
			'OP01_NAMED_SCOLON' => 127,
			"foreach" => -151,
			'LPAREN' => 131,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 136,
			'OP01_CLOSE' => 134,
			'LBRACE' => 139,
			'MY' => 116,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP19_LOOP_CONTROL' => 119,
			'LITERAL_STRING' => 81,
			"while" => -151,
			"}" => 429,
			"for" => -151,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 126
		},
		GOTOS => {
			'HashDereference' => 128,
			'LoopLabel' => 130,
			'WordScoped' => 132,
			'ArrayDereference' => 108,
			'Conditional' => 133,
			'Statement' => 135,
			'Expression' => 137,
			'OperatorVoid' => 138,
			'VariableDeclaration' => 115,
			'VariableSymbolOrSelf' => 89,
			'VariableModification' => 91,
			'HashReference' => 92,
			'SubExpression' => 94,
			'PAREN-36' => 117,
			'Operation' => 428,
			'OPTIONAL-37' => 118,
			'Literal' => 96,
			'Operator' => 97,
			'Variable' => 124,
			'ArrayReference' => 99
		}
	},
	{#State 405
		DEFAULT => -173
	},
	{#State 406
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 430
		}
	},
	{#State 407
		DEFAULT => -241
	},
	{#State 408
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_QW' => 172,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'MY' => 170,
			'ARGV' => 181,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100
		},
		GOTOS => {
			'WordScoped' => 132,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'ListElement' => 176,
			'SubExpression' => 180,
			'HashReference' => 92,
			'Expression' => 171,
			'ListElements' => 431,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'TypeInner' => 179,
			'ArrayReference' => 99
		}
	},
	{#State 409
		DEFAULT => -170
	},
	{#State 410
		ACTIONS => {
			'LBRACE' => 139,
			'STDIN' => 307,
			'OP05_MATH_NEG_LPAREN' => 112,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD_UPPERCASE' => 175,
			'LBRACKET' => 102,
			"undef" => 103,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'FHREF_SYMBOL_IN' => 306,
			'OP01_OPEN' => 123,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'SubExpressionOrInput' => 432,
			'HashReference' => 92,
			'SubExpression' => 309,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'WordScoped' => 132,
			'Literal' => 96,
			'ArrayReference' => 99,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'Expression' => 171
		}
	},
	{#State 411
		ACTIONS => {
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 433,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP01_NAMED_SCOLON' => 434,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpression' => 436,
			'HashReference' => 92,
			'Literal' => 96,
			'WordScoped' => 132,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'OpNamedScolonOrSubExp' => 435,
			'Expression' => 171
		}
	},
	{#State 412
		ACTIONS => {
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90
		},
		GOTOS => {
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'ArrayReference' => 99,
			'Expression' => 171,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 437,
			'HashReference' => 92,
			'WordScoped' => 132,
			'Literal' => 96
		}
	},
	{#State 413
		ACTIONS => {
			'OP21_LIST_COMMA' => 438
		}
	},
	{#State 414
		DEFAULT => -84
	},
	{#State 415
		DEFAULT => -52
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 439
		}
	},
	{#State 417
		ACTIONS => {
			'WORD' => 236,
			'OP24_LOGICAL_OR_XOR' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP01_NAMED' => 246,
			'OP01_OPEN' => 247,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP19_LOOP_CONTROL' => 243,
			'OP22_LOGICAL_NEG' => 244,
			'OP23_LOGICAL_AND' => 235,
			'OP01_NAMED_VOID' => 230,
			'OP01_CLOSE' => 241,
			'OP08_MATH_ADD_SUB' => 231,
			'OP10_NAMED_UNARY' => 232,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 227,
			'OP01_PRINT' => 226
		},
		GOTOS => {
			'OpStringOrWord' => 368,
			'HashEntryProperties' => 440
		}
	},
	{#State 418
		DEFAULT => -63
	},
	{#State 419
		ACTIONS => {
			";" => 441
		}
	},
	{#State 420
		DEFAULT => -207
	},
	{#State 421
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 442
		}
	},
	{#State 422
		ACTIONS => {
			'LITERAL_NUMBER' => -68,
			"\@{" => -68,
			'WORD' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'VARIABLE_SYMBOL' => -68,
			'WORD_SCOPED' => -68,
			"%{" => -68,
			'OP10_NAMED_UNARY' => -68,
			'OP01_NAMED_VOID' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"if" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'WORD_UPPERCASE' => -68,
			'LBRACKET' => -68,
			"undef" => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'LPAREN_MY' => 444,
			'SELF' => -68,
			'OP01_PRINT' => -68,
			"}" => -68,
			"for" => -68,
			'OP01_OPEN' => -68,
			'OP01_NAMED' => -68,
			'MY' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP05_BITWISE_NEG_LPAREN' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'LITERAL_STRING' => -68,
			"while" => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_CLOSE' => -68,
			'LBRACE' => -68,
			"foreach" => -68,
			'OP01_NAMED_SCOLON' => -68,
			'LPAREN' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 443,
			'MethodArguments' => 445
		}
	},
	{#State 423
		DEFAULT => -158
	},
	{#State 424
		ACTIONS => {
			'LPAREN' => 446
		}
	},
	{#State 425
		DEFAULT => -163
	},
	{#State 426
		DEFAULT => -161
	},
	{#State 427
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 447
		}
	},
	{#State 428
		DEFAULT => -172
	},
	{#State 429
		DEFAULT => -174
	},
	{#State 430
		ACTIONS => {
			"undef" => 448
		}
	},
	{#State 431
		ACTIONS => {
			")" => 449
		}
	},
	{#State 432
		ACTIONS => {
			")" => 450
		}
	},
	{#State 433
		DEFAULT => -237
	},
	{#State 434
		DEFAULT => -236
	},
	{#State 435
		ACTIONS => {
			'VARIABLE_SYMBOL' => 451
		}
	},
	{#State 436
		ACTIONS => {
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 152,
			";" => 452,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155
		}
	},
	{#State 437
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 453,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP13_BITWISE_AND' => 152,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158
		}
	},
	{#State 438
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Expression' => 171,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 174,
			'ArrayReference' => 99,
			'Literal' => 96,
			'WordScoped' => 132,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'HashReference' => 92,
			'SubExpression' => 454
		}
	},
	{#State 439
		DEFAULT => -49
	},
	{#State 440
		DEFAULT => -62
	},
	{#State 441
		DEFAULT => -65
	},
	{#State 442
		ACTIONS => {
			"\$TYPED_" => 455
		}
	},
	{#State 443
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 456
		}
	},
	{#State 444
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 457
		}
	},
	{#State 445
		DEFAULT => -67
	},
	{#State 446
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93
		},
		GOTOS => {
			'SubExpression' => 458,
			'HashReference' => 92,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'WordScoped' => 132,
			'Literal' => 96,
			'ArrayReference' => 99,
			'Variable' => 174,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Expression' => 171
		}
	},
	{#State 447
		DEFAULT => -160
	},
	{#State 448
		ACTIONS => {
			";" => 459
		}
	},
	{#State 449
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 460
		}
	},
	{#State 450
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 461
		}
	},
	{#State 451
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 462
		}
	},
	{#State 452
		DEFAULT => -238
	},
	{#State 453
		ACTIONS => {
			'OP01_NAMED' => 173,
			'WORD' => 25,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 463,
			'HashReference' => 92,
			'Literal' => 96,
			'WordScoped' => 132,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Expression' => 171
		}
	},
	{#State 454
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			"]" => -85,
			'OP13_BITWISE_AND' => 152,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -85,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			"}" => -85,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP17_LIST_RANGE' => 165,
			'OP21_LIST_COMMA' => -85,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -85,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163
		}
	},
	{#State 455
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 244,
			'OP19_LOOP_CONTROL' => 243,
			'OP23_LOGICAL_AND' => 235,
			'WORD' => 236,
			'OP01_NAMED' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP24_LOGICAL_OR_XOR' => 245,
			'OP01_OPEN' => 247,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP07_STRING_REPEAT' => 227,
			'OP01_PRINT' => 226,
			'OP01_CLOSE' => 241,
			'OP08_MATH_ADD_SUB' => 231,
			'OP01_NAMED_VOID' => 230,
			'OP19_LOOP_CONTROL_SCOLON' => 242,
			'OP11_COMPARE_LT_GT' => 233,
			'OP10_NAMED_UNARY' => 232
		},
		GOTOS => {
			'OpStringOrWord' => 464
		}
	},
	{#State 456
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_PRINT' => 105,
			'SELF' => 106,
			'OP01_NAMED_VOID_SCOLON' => 101,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP01_NAMED_VOID_LPAREN' => 113,
			"if" => 114,
			'OP01_NAMED_VOID' => 107,
			'CONSTANT_CALL_SCOPED' => 109,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			"while" => -151,
			'LITERAL_STRING' => 81,
			'OP19_LOOP_CONTROL' => 119,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'MY' => 116,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 123,
			"for" => -151,
			"}" => 465,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'LPAREN' => 131,
			"foreach" => -151,
			'OP01_NAMED_SCOLON' => 127,
			'LBRACE' => 139,
			'OP01_CLOSE' => 134,
			'OP19_LOOP_CONTROL_SCOLON' => 136
		},
		GOTOS => {
			'Expression' => 137,
			'OperatorVoid' => 138,
			'VariableDeclaration' => 115,
			'Conditional' => 133,
			'ArrayDereference' => 108,
			'Statement' => 135,
			'LoopLabel' => 130,
			'WordScoped' => 132,
			'HashDereference' => 128,
			'Operator' => 97,
			'Variable' => 124,
			'ArrayReference' => 99,
			'PAREN-36' => 117,
			'OPTIONAL-37' => 118,
			'Operation' => 466,
			'Literal' => 96,
			'VariableSymbolOrSelf' => 89,
			'HashReference' => 92,
			'VariableModification' => 91,
			'SubExpression' => 94
		}
	},
	{#State 457
		ACTIONS => {
			'SELF' => 467
		}
	},
	{#State 458
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP08_STRING_CAT' => 163,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => 468,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 152
		}
	},
	{#State 459
		DEFAULT => -183
	},
	{#State 460
		DEFAULT => -169
	},
	{#State 461
		DEFAULT => -171
	},
	{#State 462
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			'OP10_NAMED_UNARY_SCOLON' => 433,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED_SCOLON' => 434,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP01_NAMED' => 173,
			'WORD' => 25,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN' => 123
		},
		GOTOS => {
			'Expression' => 171,
			'OpNamedScolonOrSubExp' => 469,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'ArrayReference' => 99,
			'Literal' => 96,
			'WordScoped' => 132,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'SubExpression' => 436,
			'HashReference' => 92
		}
	},
	{#State 463
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => -107,
			'OP08_STRING_CAT' => 163,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => -107,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			")" => 470,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP07_STRING_REPEAT' => 157,
			'OP04_MATH_POW' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP13_BITWISE_AND' => 152
		}
	},
	{#State 464
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 472,
			'OP02_ARRAY_THINARROW' => 471
		}
	},
	{#State 465
		ACTIONS => {
			";" => 473
		}
	},
	{#State 466
		DEFAULT => -69
	},
	{#State 467
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 474
		}
	},
	{#State 468
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 469
		ACTIONS => {
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'SELF' => 106,
			'LPAREN' => 131,
			"undef" => 103,
			'LBRACKET' => 102,
			'WORD_UPPERCASE' => 175
		},
		GOTOS => {
			'ArrayReference' => 99,
			'ArrayDereference' => 108,
			'Operator' => 97,
			'Variable' => 124,
			'Expression' => 171,
			'HashReference' => 92,
			'VariableModification' => 478,
			'SubExpression' => 477,
			'HashDereference' => 128,
			'VariableSymbolOrSelf' => 89,
			'SubExpressionOrVarMod' => 476,
			'Literal' => 96,
			'WordScoped' => 132
		}
	},
	{#State 470
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 479
		}
	},
	{#State 471
		ACTIONS => {
			'LPAREN' => 131,
			'SELF' => 106,
			'LBRACKET' => 102,
			"undef" => 103,
			'WORD_UPPERCASE' => 175,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LBRACE' => 139,
			'CONSTANT_CALL_SCOPED' => 109,
			'OP01_CLOSE' => 134,
			"%{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'VARIABLE_SYMBOL' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 25,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 123,
			"\@{" => 100,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Literal' => 96,
			'WordScoped' => 132,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'HashReference' => 92,
			'SubExpression' => 480,
			'Expression' => 171,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Variable' => 174,
			'ArrayReference' => 99
		}
	},
	{#State 472
		ACTIONS => {
			'WORD_UPPERCASE' => 175,
			"undef" => 103,
			'LBRACKET' => 102,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 111,
			'OP01_CLOSE' => 134,
			'CONSTANT_CALL_SCOPED' => 109,
			'LBRACE' => 139,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 90,
			'OP22_LOGICAL_NEG' => 121,
			'OP05_LOGICAL_NEG' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 80,
			"\@{" => 100,
			'OP01_OPEN' => 123,
			'OP01_NAMED' => 173,
			'WORD' => 25
		},
		GOTOS => {
			'SubExpression' => 481,
			'HashReference' => 92,
			'VariableSymbolOrSelf' => 89,
			'HashDereference' => 128,
			'WordScoped' => 132,
			'Literal' => 96,
			'ArrayReference' => 99,
			'Variable' => 174,
			'Operator' => 97,
			'ArrayDereference' => 108,
			'Expression' => 171
		}
	},
	{#State 473
		DEFAULT => -71
	},
	{#State 474
		ACTIONS => {
			'OP21_LIST_COMMA' => 483,
			")" => 482
		},
		GOTOS => {
			'PAREN-29' => 484
		}
	},
	{#State 475
		DEFAULT => -157
	},
	{#State 476
		ACTIONS => {
			")" => 485
		}
	},
	{#State 477
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP16_LOGICAL_OR' => 151,
			'OP15_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 155,
			")" => -147,
			'OP13_BITWISE_AND' => 152,
			'OP11_COMPARE_LT_GT' => 158,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 478
		DEFAULT => -148
	},
	{#State 479
		DEFAULT => -167
	},
	{#State 480
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP18_TERNARY' => 164,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP13_BITWISE_AND' => 152,
			'OP11_COMPARE_LT_GT' => 158,
			"]" => 486,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 481
		ACTIONS => {
			'OP13_BITWISE_AND' => 152,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 158,
			'OP15_LOGICAL_AND' => 150,
			'OP16_LOGICAL_OR' => 151,
			'OP04_MATH_POW' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP21_LIST_COMMA' => -224,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP17_LIST_RANGE' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			"}" => -224,
			'OP18_TERNARY' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => 161,
			'OP23_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 482
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 487
		}
	},
	{#State 483
		ACTIONS => {
			'MY' => 488
		}
	},
	{#State 484
		DEFAULT => -73
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 378
		},
		GOTOS => {
			'CodeBlock' => 489
		}
	},
	{#State 486
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 490
		}
	},
	{#State 487
		ACTIONS => {
			"\@_;" => 491
		}
	},
	{#State 488
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 53,
			'WORD_SCOPED' => 51
		},
		GOTOS => {
			'Type' => 492
		}
	},
	{#State 489
		DEFAULT => -168
	},
	{#State 490
		ACTIONS => {
			"undef" => 493
		}
	},
	{#State 491
		DEFAULT => -75
	},
	{#State 492
		ACTIONS => {
			'VARIABLE_SYMBOL' => 494
		}
	},
	{#State 493
		DEFAULT => -225
	},
	{#State 494
		DEFAULT => -72
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6989 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6996 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7102 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7127 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7244 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7287 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7366 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7490 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7533 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7547 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7558 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7634 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7887 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7898 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7920 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7931 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7942 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7964 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7975 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7986 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7993 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8014 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8032 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8054 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8087 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8098 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8109 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8116 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8123 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8130 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8137 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8148 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8159 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8170 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8192 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8203 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8214 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8225 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8236 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8269 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8280 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8302 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_144
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8313 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_145
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_146
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_147
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8346 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_148
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8371 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8378 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8389 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8400 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8411 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8422 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8440 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8447 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8454 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8461 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8468 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8475 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_163
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8486 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_167
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8552 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_171
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8574 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 226 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8581 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 226 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8588 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_174
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8599 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8606 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8613 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_177
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8624 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8635 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8646 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_180
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8657 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8668 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8679 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8690 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_184
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8701 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_185
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8712 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_186
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8723 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8744 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_190
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8755 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8766 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8777 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8788 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8799 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8813 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_197
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8824 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8831 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8838 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8849 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_201
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8860 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8867 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8874 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8885 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8896 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8907 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_207
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8918 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8932 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8939 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_211
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8950 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_212
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8961 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8968 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8975 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_215
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8986 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_216
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8997 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9008 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9019 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9030 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9041 lib/RPerl/Grammar.pm
	],
	[#Rule Type_221
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9052 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9063 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_223
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9074 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_224
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9085 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_225
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9096 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_226
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9107 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_227
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9118 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_228
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9129 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_229
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9140 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_230
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9151 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_231
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9162 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_232
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9173 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_233
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9184 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_234
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9195 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_235
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9206 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_236
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9217 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_237
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9228 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_238
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9239 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_239
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9250 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_240
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9261 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_241
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9272 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_242
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9283 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_243
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9294 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9305 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9316 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9327 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9338 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9349 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9360 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9371 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9382 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9393 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9404 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9415 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9426 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9437 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9448 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9459 lib/RPerl/Grammar.pm
	]
],
#line 9462 lib/RPerl/Grammar.pm
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

#line 263 "lib/RPerl/Grammar.eyp"


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
Operator_87 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_88 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_89 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_90 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_91 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_92 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_93 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
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


#line 9931 lib/RPerl/Grammar.pm



1;
