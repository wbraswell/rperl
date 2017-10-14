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
    our $VERSION = 0.009_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|foreach|package|\$TYPED_|elsif|undef|while|\@ARG\;|else|for|\%\{|\@\{|if|\]|\}|\)|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(\s*use\s+RPerl::Exporter\s+qw\(\s*import\s*\)\s*;\s*)/gc and return ('USE_EXPORTER', $1);
      /\G(use\s+)/gc and return ('USE', $1);
      /\G(\s*our\s+\@EXPORT\s+\=\s*)/gc and return ('OUR_EXPORT', $1);
      /\G(\s*our\s+\@EXPORT_OK\s+\=\s*)/gc and return ('OUR_EXPORT_OK', $1);
      /\G(our\s+)/gc and return ('OUR', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(sub)\s+/gc and return ('SUB', $1);
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
      /\G(not\()\s/gc and return ('OP22_LOGICAL_NEG_LPAREN', $1);
      /\G(not)\s/gc and return ('OP22_LOGICAL_NEG', $1);
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


#line 155 lib/RPerl/Grammar.pm

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
  [ '_OPTIONAL' => 'OPTIONAL-12', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [ 'STAR-13', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-14', [ 'STAR-14', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-14', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'PLUS-15', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'Subroutine' ], 0 ],
  [ 'Package_36' => 'Package', [ 'STAR-11', 'OPTIONAL-12', 'STAR-13', 'STAR-14', 'PLUS-15', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'USE_RPERL_AFTER' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ 'Header_39' => 'Header', [ 'use strict;', 'use warnings;', 'OPTIONAL-16', 'OUR', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'WORD' ], 0 ],
  [ 'Critic_42' => 'Critic', [ '## no critic qw(', 'PLUS-17', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OUR_EXPORT', 'OP01_QW', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [ 'PAREN-18' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [  ], 0 ],
  [ '_PAREN' => 'PAREN-20', [ 'OUR_EXPORT_OK', 'OP01_QW', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'PAREN-20' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ 'Exports_49' => 'Exports', [ 'USE_EXPORTER', 'OPTIONAL-19', 'OPTIONAL-21' ], 0 ],
  [ 'Include_50' => 'Include', [ 'USE', 'WordScoped', ';' ], 0 ],
  [ 'Include_51' => 'Include', [ 'USE', 'WordScoped', 'OP01_QW', ';' ], 0 ],
  [ 'Constant_52' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ 'Subroutine_57' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-22', 'STAR-23', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-24', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'PAREN-24' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'SubroutineArguments_61' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-25', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'SubroutineOrMethod' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'Class_72' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-26', 'OPTIONAL-27', 'STAR-28', 'STAR-29', 'Properties', 'STAR-30', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'PAREN-31' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'Properties_76' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-32', '}', ';' ], 0 ],
  [ 'Properties_77' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [ 'STAR-34', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [  ], 0 ],
  [ 'Method_82' => 'Method', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'TYPE_METHOD', '$RETURN_TYPE', '}', ';', 'OPTIONAL-33', 'STAR-34', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'PAREN-35' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'MethodArguments_86' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-36', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_87' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_88' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_89' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_90' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_91' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_92' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-38', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_131' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_132' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-39', ')', ';' ], 0 ],
  [ 'OperatorVoid_133' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-40', ')' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-41', ')' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-42', ')' ], 0 ],
  [ 'SubExpression_149' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_150' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_151' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_152' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_153' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_154' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_158' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_159' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_160' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_161' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_162' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'PAREN-43' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Statement_166' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_167' => 'Statement', [ 'OPTIONAL-44', 'Loop' ], 0 ],
  [ 'Statement_168' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_169' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_170' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Conditional_177' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-46', 'OPTIONAL-48' ], 0 ],
  [ 'Loop_178' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_179' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_180' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_181' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_182' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_183' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_184' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_185' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'PLUS-49', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'Operation' ], 0 ],
  [ 'CodeBlock_188' => 'CodeBlock', [ 'LBRACE', 'PLUS-49', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'Variable_191' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-50' ], 0 ],
  [ 'VariableRetrieval_192' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_193' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_194' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_195' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_196' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_197' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_198' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_199' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_200' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'ListElements_204' => 'ListElements', [ 'ListElement', 'STAR-52' ], 0 ],
  [ 'ListElement_205' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_206' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_207' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_208' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [  ], 0 ],
  [ 'ArrayReference_211' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-53', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'ArrayDereference_214' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_215' => 'ArrayDereference', [ '@{', 'OPTIONAL-54', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'HashEntry_218' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-55', 'SubExpression' ], 0 ],
  [ 'HashEntry_219' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_220' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_221' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-56', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [ 'STAR-57', 'PAREN-56' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [  ], 0 ],
  [ 'HashReference_225' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-57', '}' ], 0 ],
  [ 'HashReference_226' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'HashDereference_229' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_230' => 'HashDereference', [ '%{', 'OPTIONAL-58', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_231' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_232' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_233' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_234' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_235' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_236' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_237' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_238' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_239' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_240' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_241' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_242' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_243' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_244' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_245' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_246' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_247' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_248' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_249' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_250' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_251' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_252' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_253' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_254' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_255' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_259' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_260' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_261' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_262' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_272' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_OPTIONAL' => 28,
  '_OPTIONAL' => 29,
  '_STAR_LIST' => 30,
  '_STAR_LIST' => 31,
  '_STAR_LIST' => 32,
  '_STAR_LIST' => 33,
  '_PLUS_LIST' => 34,
  '_PLUS_LIST' => 35,
  'Package_36' => 36,
  '_OPTIONAL' => 37,
  '_OPTIONAL' => 38,
  'Header_39' => 39,
  '_PLUS_LIST' => 40,
  '_PLUS_LIST' => 41,
  'Critic_42' => 42,
  '_PAREN' => 43,
  '_OPTIONAL' => 44,
  '_OPTIONAL' => 45,
  '_PAREN' => 46,
  '_OPTIONAL' => 47,
  '_OPTIONAL' => 48,
  'Exports_49' => 49,
  'Include_50' => 50,
  'Include_51' => 51,
  'Constant_52' => 52,
  '_OPTIONAL' => 53,
  '_OPTIONAL' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  'Subroutine_57' => 57,
  '_PAREN' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'SubroutineArguments_61' => 61,
  '_STAR_LIST' => 62,
  '_STAR_LIST' => 63,
  '_OPTIONAL' => 64,
  '_OPTIONAL' => 65,
  '_STAR_LIST' => 66,
  '_STAR_LIST' => 67,
  '_STAR_LIST' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  'Class_72' => 72,
  '_PAREN' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'Properties_76' => 76,
  'Properties_77' => 77,
  '_OPTIONAL' => 78,
  '_OPTIONAL' => 79,
  '_STAR_LIST' => 80,
  '_STAR_LIST' => 81,
  'Method_82' => 82,
  '_PAREN' => 83,
  '_STAR_LIST' => 84,
  '_STAR_LIST' => 85,
  'MethodArguments_86' => 86,
  'SubroutineOrMethod_87' => 87,
  'SubroutineOrMethod_88' => 88,
  'Operation_89' => 89,
  'Operation_90' => 90,
  'Operation_91' => 91,
  'Operation_92' => 92,
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
  'Operator_113' => 113,
  'Operator_114' => 114,
  'Operator_115' => 115,
  'Operator_116' => 116,
  'Operator_117' => 117,
  'Operator_118' => 118,
  'Operator_119' => 119,
  'Operator_120' => 120,
  'Operator_121' => 121,
  'Operator_122' => 122,
  'Operator_123' => 123,
  '_PAREN' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  'OperatorVoid_131' => 131,
  'OperatorVoid_132' => 132,
  'OperatorVoid_133' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'Expression_148' => 148,
  'SubExpression_149' => 149,
  'SubExpression_150' => 150,
  'SubExpression_151' => 151,
  'SubExpression_152' => 152,
  'SubExpression_153' => 153,
  'SubExpression_154' => 154,
  'SubExpression_155' => 155,
  'SubExpression_156' => 156,
  'SubExpression_157' => 157,
  'SubExpressionOrInput_158' => 158,
  'SubExpressionOrInput_159' => 159,
  'SubExpressionOrInput_160' => 160,
  'SubExpressionOrVarMod_161' => 161,
  'SubExpressionOrVarMod_162' => 162,
  '_PAREN' => 163,
  '_OPTIONAL' => 164,
  '_OPTIONAL' => 165,
  'Statement_166' => 166,
  'Statement_167' => 167,
  'Statement_168' => 168,
  'Statement_169' => 169,
  'Statement_170' => 170,
  '_PAREN' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  '_PAREN' => 174,
  '_OPTIONAL' => 175,
  '_OPTIONAL' => 176,
  'Conditional_177' => 177,
  'Loop_178' => 178,
  'Loop_179' => 179,
  'Loop_180' => 180,
  'LoopFor_181' => 181,
  'LoopFor_182' => 182,
  'LoopForEach_183' => 183,
  'LoopWhile_184' => 184,
  'LoopWhile_185' => 185,
  '_PLUS_LIST' => 186,
  '_PLUS_LIST' => 187,
  'CodeBlock_188' => 188,
  '_STAR_LIST' => 189,
  '_STAR_LIST' => 190,
  'Variable_191' => 191,
  'VariableRetrieval_192' => 192,
  'VariableRetrieval_193' => 193,
  'VariableRetrieval_194' => 194,
  'VariableDeclaration_195' => 195,
  'VariableDeclaration_196' => 196,
  'VariableDeclaration_197' => 197,
  'VariableDeclaration_198' => 198,
  'VariableModification_199' => 199,
  'VariableModification_200' => 200,
  '_PAREN' => 201,
  '_STAR_LIST' => 202,
  '_STAR_LIST' => 203,
  'ListElements_204' => 204,
  'ListElement_205' => 205,
  'ListElement_206' => 206,
  'ListElement_207' => 207,
  'ListElement_208' => 208,
  '_OPTIONAL' => 209,
  '_OPTIONAL' => 210,
  'ArrayReference_211' => 211,
  '_OPTIONAL' => 212,
  '_OPTIONAL' => 213,
  'ArrayDereference_214' => 214,
  'ArrayDereference_215' => 215,
  '_OPTIONAL' => 216,
  '_OPTIONAL' => 217,
  'HashEntry_218' => 218,
  'HashEntry_219' => 219,
  'HashEntry_220' => 220,
  'HashEntryProperties_221' => 221,
  '_PAREN' => 222,
  '_STAR_LIST' => 223,
  '_STAR_LIST' => 224,
  'HashReference_225' => 225,
  'HashReference_226' => 226,
  '_OPTIONAL' => 227,
  '_OPTIONAL' => 228,
  'HashDereference_229' => 229,
  'HashDereference_230' => 230,
  'WordScoped_231' => 231,
  'WordScoped_232' => 232,
  'LoopLabel_233' => 233,
  'Type_234' => 234,
  'Type_235' => 235,
  'Type_236' => 236,
  'TypeInner_237' => 237,
  'TypeInnerProperties_238' => 238,
  'TypeInnerProperties_239' => 239,
  'TypeInnerConstant_240' => 240,
  'VariableOrLiteral_241' => 241,
  'VariableOrLiteral_242' => 242,
  'VarOrLitOrOpStrOrWord_243' => 243,
  'VarOrLitOrOpStrOrWord_244' => 244,
  'VarOrLitOrOpStrOrWord_245' => 245,
  'VariableSymbolOrSelf_246' => 246,
  'VariableSymbolOrSelf_247' => 247,
  'Literal_248' => 248,
  'Literal_249' => 249,
  'OpNamedScolonOrSubExp_250' => 250,
  'OpNamedScolonOrSubExp_251' => 251,
  'OpNamedScolonOrSubExp_252' => 252,
  'OpNamedScolonOrSubExpIn_253' => 253,
  'OpNamedScolonOrSubExpIn_254' => 254,
  'OpNamedScolonOrSubExpIn_255' => 255,
  'OpStringOrWord_256' => 256,
  'OpStringOrWord_257' => 257,
  'OpStringOrWord_258' => 258,
  'OpStringOrWord_259' => 259,
  'OpStringOrWord_260' => 260,
  'OpStringOrWord_261' => 261,
  'OpStringOrWord_262' => 262,
  'OpStringOrWord_263' => 263,
  'OpStringOrWord_264' => 264,
  'OpStringOrWord_265' => 265,
  'OpStringOrWord_266' => 266,
  'OpStringOrWord_267' => 267,
  'OpStringOrWord_268' => 268,
  'OpStringOrWord_269' => 269,
  'OpStringOrWord_270' => 270,
  'OpStringOrWord_271' => 271,
  'OpStringOrWord_272' => 272,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$RETURN_TYPE' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'@ARG;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'our hashref $properties' => { ISSEMANTIC => 0 },
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
	OP22_LOGICAL_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	OUR => { ISSEMANTIC => 1 },
	OUR_EXPORT => { ISSEMANTIC => 1 },
	OUR_EXPORT_OK => { ISSEMANTIC => 1 },
	SELF => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	SUB => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	USE => { ISSEMANTIC => 1 },
	USE_EXPORTER => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			'SHEBANG' => 1
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'PLUS-2' => 5,
			'PAREN-1' => 4,
			'Critic' => 9,
			'CompileUnit' => 8,
			'Program' => 3,
			'ModuleHeader' => 7
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-3' => 10,
			'Critic' => 11
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-17' => 13
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 2,
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'ModuleHeader' => 7,
			'PAREN-1' => 14,
			'Critic' => 9
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => 15,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 16
		}
	},
	{#State 7
		ACTIONS => {
			'USE' => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 19,
			'SUB' => -27,
			"use constant" => -27,
			'USE_EXPORTER' => -27
		},
		GOTOS => {
			'Package' => 18,
			'Module' => 20,
			'STAR-11' => 21,
			'Class' => 17
		}
	},
	{#State 8
		ACTIONS => {
			'' => 22
		}
	},
	{#State 9
		DEFAULT => -19
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
		DEFAULT => -41
	},
	{#State 13
		ACTIONS => {
			")" => 25,
			'WORD' => 24
		}
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => -21
	},
	{#State 16
		ACTIONS => {
			"package" => 26
		}
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		ACTIONS => {
			"use constant" => -29,
			'SUB' => -29,
			"## no critic qw(" => 2,
			'USE' => -29,
			'USE_EXPORTER' => 32
		},
		GOTOS => {
			'OPTIONAL-12' => 30,
			'Exports' => 31,
			'Critic' => 33
		}
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		ACTIONS => {
			"use strict;" => 34
		},
		GOTOS => {
			'Header' => 35
		}
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		DEFAULT => -42
	},
	{#State 26
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 27
		DEFAULT => -232
	},
	{#State 28
		DEFAULT => -231
	},
	{#State 29
		ACTIONS => {
			")" => 37
		}
	},
	{#State 30
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 31
		DEFAULT => -28
	},
	{#State 32
		ACTIONS => {
			"use constant" => -45,
			'SUB' => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT_OK' => -45,
			'USE' => -45,
			'OUR_EXPORT' => 41
		},
		GOTOS => {
			'OPTIONAL-19' => 40,
			'PAREN-18' => 39
		}
	},
	{#State 33
		DEFAULT => -26
	},
	{#State 34
		ACTIONS => {
			"use warnings;" => 42
		}
	},
	{#State 35
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 43
		}
	},
	{#State 36
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		ACTIONS => {
			";" => 45
		}
	},
	{#State 38
		ACTIONS => {
			'USE' => 48,
			'SUB' => -33,
			"use constant" => -33
		},
		GOTOS => {
			'STAR-14' => 46,
			'Include' => 47
		}
	},
	{#State 39
		DEFAULT => -44
	},
	{#State 40
		ACTIONS => {
			'USE' => -48,
			'OUR_EXPORT_OK' => 51,
			"use constant" => -48,
			'SUB' => -48,
			"our hashref \$properties" => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 50,
			'PAREN-20' => 49
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 53
		},
		GOTOS => {
			'OPTIONAL-16' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'OP01_NAMED_VOID' => -11,
			'SUB' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'USE' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'SELF' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"%{" => -11,
			"foreach" => -11,
			'MY' => -11,
			'LBRACKET' => -11,
			"while" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"\@{" => -11,
			"## no critic qw(" => 2,
			'LITERAL_NUMBER' => -11,
			'LBRACE' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			"undef" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LPAREN' => -11,
			'WORD' => -11,
			"use constant" => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"if" => -11,
			'WORD_SCOPED' => -11
		},
		GOTOS => {
			'STAR-5' => 55,
			'Critic' => 56
		}
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 34
		},
		GOTOS => {
			'Header' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'USE' => 48
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"use constant" => 60,
			'SUB' => 59
		},
		GOTOS => {
			'Subroutine' => 61,
			'Constant' => 63,
			'PLUS-15' => 62
		}
	},
	{#State 47
		DEFAULT => -30
	},
	{#State 48
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 64
		}
	},
	{#State 49
		DEFAULT => -47
	},
	{#State 50
		DEFAULT => -49
	},
	{#State 51
		ACTIONS => {
			'OP01_QW' => 65
		}
	},
	{#State 52
		ACTIONS => {
			";" => 66
		}
	},
	{#State 53
		DEFAULT => -37
	},
	{#State 54
		ACTIONS => {
			'OUR' => 67
		}
	},
	{#State 55
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			"%{" => -13,
			"foreach" => -13,
			'MY' => -13,
			'LBRACKET' => -13,
			'SUB' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP10_NAMED_UNARY' => -13,
			'USE' => 48,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'SELF' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LITERAL_NUMBER' => -13,
			'LBRACE' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"while" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"\@{" => -13,
			'LPAREN' => -13,
			'WORD' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			"undef" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"if" => -13,
			'WORD_SCOPED' => -13,
			"for" => -13,
			"use constant" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13
		},
		GOTOS => {
			'Include' => 69,
			'STAR-6' => 68
		}
	},
	{#State 56
		DEFAULT => -8
	},
	{#State 57
		DEFAULT => -23
	},
	{#State 58
		DEFAULT => -63,
		GOTOS => {
			'STAR-26' => 70
		}
	},
	{#State 59
		ACTIONS => {
			'WORD' => 71
		}
	},
	{#State 60
		ACTIONS => {
			'WORD_UPPERCASE' => 72
		}
	},
	{#State 61
		DEFAULT => -35
	},
	{#State 62
		ACTIONS => {
			'SUB' => 59,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'Subroutine' => 74
		}
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		ACTIONS => {
			";" => 76,
			'OP01_QW' => 75
		}
	},
	{#State 65
		ACTIONS => {
			";" => 77
		}
	},
	{#State 66
		DEFAULT => -43
	},
	{#State 67
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 78
		}
	},
	{#State 68
		ACTIONS => {
			'OP01_NAMED_VOID' => -15,
			'SUB' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			'SELF' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"%{" => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"foreach" => -15,
			'MY' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"\@{" => -15,
			"while" => -15,
			'LITERAL_NUMBER' => -15,
			'LBRACE' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"undef" => -15,
			'LITERAL_STRING' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LPAREN' => -15,
			'WORD' => -15,
			"use constant" => 60,
			"for" => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED' => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_OPEN' => -15,
			'WORD_SCOPED' => -15,
			"if" => -15
		},
		GOTOS => {
			'Constant' => 79,
			'STAR-7' => 80
		}
	},
	{#State 69
		DEFAULT => -10
	},
	{#State 70
		ACTIONS => {
			'USE_EXPORTER' => 32,
			"## no critic qw(" => 2,
			"our hashref \$properties" => -65,
			"use constant" => -65,
			'USE' => -65
		},
		GOTOS => {
			'Exports' => 83,
			'Critic' => 81,
			'OPTIONAL-27' => 82
		}
	},
	{#State 71
		ACTIONS => {
			'LBRACE' => 84
		}
	},
	{#State 72
		ACTIONS => {
			'OP20_HASH_FATARROW' => 85
		}
	},
	{#State 73
		ACTIONS => {
			";" => 86
		}
	},
	{#State 74
		DEFAULT => -34
	},
	{#State 75
		ACTIONS => {
			";" => 87
		}
	},
	{#State 76
		DEFAULT => -50
	},
	{#State 77
		DEFAULT => -46
	},
	{#State 78
		DEFAULT => -39
	},
	{#State 79
		DEFAULT => -12
	},
	{#State 80
		ACTIONS => {
			'LPAREN' => 126,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'VARIABLE_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 120,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			"if" => 137,
			"for" => -165,
			'OP01_PRINT' => 134,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"foreach" => -165,
			"%{" => 104,
			'LBRACKET' => 106,
			'MY' => 108,
			'OP01_NAMED_VOID' => 93,
			'SUB' => 59,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_NUMBER' => 116,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP01_NAMED_SCOLON' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"\@{" => 109,
			"while" => -165
		},
		GOTOS => {
			'Variable' => 128,
			'HashDereference' => 127,
			'PLUS-8' => 103,
			'OperatorVoid' => 107,
			'VariableDeclaration' => 102,
			'LoopLabel' => 90,
			'Expression' => 92,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'VariableModification' => 96,
			'Statement' => 141,
			'Operator' => 118,
			'PAREN-43' => 117,
			'Subroutine' => 136,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'OPTIONAL-44' => 135,
			'ArrayReference' => 112,
			'Conditional' => 131,
			'Operation' => 130,
			'SubExpression' => 129
		}
	},
	{#State 81
		DEFAULT => -62
	},
	{#State 82
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 142
		}
	},
	{#State 83
		DEFAULT => -64
	},
	{#State 84
		ACTIONS => {
			'LBRACE' => 143
		}
	},
	{#State 85
		ACTIONS => {
			'MY' => 145
		},
		GOTOS => {
			'TypeInnerConstant' => 144
		}
	},
	{#State 86
		DEFAULT => -36
	},
	{#State 87
		DEFAULT => -51
	},
	{#State 88
		DEFAULT => -247
	},
	{#State 89
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'Variable' => 146
		}
	},
	{#State 90
		ACTIONS => {
			'COLON' => 147
		}
	},
	{#State 91
		DEFAULT => -155
	},
	{#State 92
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -149,
			'OP17_LIST_RANGE' => -149,
			'OP08_STRING_CAT' => -149,
			'OP06_REGEX_BIND' => -149,
			'OP15_LOGICAL_AND' => -149,
			'OP23_LOGICAL_AND' => -149,
			'OP09_BITWISE_SHIFT' => -149,
			'OP24_LOGICAL_OR_XOR' => -149,
			'OP07_MATH_MULT_DIV_MOD' => -149,
			'OP07_STRING_REPEAT' => -149,
			'OP04_MATH_POW' => -149,
			";" => 148,
			'OP13_BITWISE_AND' => -149,
			'OP18_TERNARY' => -149,
			'OP12_COMPARE_EQ_NE' => -149,
			'OP14_BITWISE_OR_XOR' => -149,
			'OP08_MATH_ADD_SUB' => -149,
			'OP16_LOGICAL_OR' => -149
		}
	},
	{#State 93
		ACTIONS => {
			'WORD' => 28,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'MY' => 149,
			'LBRACKET' => 106,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109
		},
		GOTOS => {
			'SubExpression' => 154,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ListElements' => 153,
			'ArrayReference' => 112,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'ListElement' => 158,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127
		}
	},
	{#State 94
		ACTIONS => {
			'WORD' => 28,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'LBRACKET' => 106,
			'MY' => 149,
			'SELF' => 88,
			'ARGV' => 151,
			'VARIABLE_SYMBOL' => 119,
			")" => -128,
			'OP03_MATH_INC_DEC' => 89,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP01_QW' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'SubExpression' => 154,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ListElements' => 160,
			'ArrayReference' => 112,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'ListElement' => 158,
			'OPTIONAL-39' => 161,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127
		}
	},
	{#State 95
		DEFAULT => -91
	},
	{#State 96
		ACTIONS => {
			";" => 162
		}
	},
	{#State 97
		ACTIONS => {
			'SELF' => 88,
			'OP06_REGEX_BIND' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP03_MATH_INC_DEC' => 89,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP09_BITWISE_SHIFT' => -111,
			'OP05_LOGICAL_NEG' => 101,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'OP08_STRING_CAT' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			"\@{" => 109,
			'OP08_MATH_ADD_SUB' => -111,
			"}" => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'LITERAL_NUMBER' => 116,
			'OP07_STRING_REPEAT' => -111,
			'VARIABLE_SYMBOL' => 119,
			")" => -111,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP23_LOGICAL_AND' => -111,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'WORD' => 28,
			"]" => -111,
			'OP17_LIST_RANGE' => -111,
			'LPAREN' => 126,
			";" => -111,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			'OP13_BITWISE_AND' => -111,
			'OP18_TERNARY' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'OP04_MATH_POW' => -111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'SubExpression' => 163,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 98
		DEFAULT => -190,
		GOTOS => {
			'STAR-50' => 164
		}
	},
	{#State 99
		ACTIONS => {
			'LPAREN' => 166,
			'OP02_METHOD_THINARROW_NEW' => 165
		}
	},
	{#State 100
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104
		},
		GOTOS => {
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'SubExpression' => 167,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 28,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			'LBRACKET' => 106,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'SubExpression' => 168,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99
		}
	},
	{#State 102
		DEFAULT => -169
	},
	{#State 103
		ACTIONS => {
			'OP01_PRINT' => 134,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			"for" => -165,
			'WORD_SCOPED' => 27,
			"if" => 137,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'VARIABLE_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 120,
			'OP01_NAMED_VOID_SCOLON' => 122,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'' => -18,
			'WORD' => 28,
			'LPAREN' => 126,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"\@{" => 109,
			"while" => -165,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP01_NAMED_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP01_NAMED_VOID' => 93,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"foreach" => -165,
			"%{" => 104,
			'LBRACKET' => 106,
			'MY' => 108
		},
		GOTOS => {
			'LoopLabel' => 90,
			'HashReference' => 91,
			'Expression' => 92,
			'VariableModification' => 96,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'VariableDeclaration' => 102,
			'HashDereference' => 127,
			'Variable' => 128,
			'OperatorVoid' => 107,
			'Operation' => 169,
			'SubExpression' => 129,
			'Conditional' => 131,
			'Literal' => 111,
			'ArrayReference' => 112,
			'OPTIONAL-44' => 135,
			'ArrayDereference' => 138,
			'PAREN-43' => 117,
			'Operator' => 118,
			'Statement' => 141
		}
	},
	{#State 104
		ACTIONS => {
			'MY' => 149,
			'LBRACE' => -228,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'OPTIONAL-58' => 170,
			'VariableSymbolOrSelf' => 98,
			'Variable' => 171,
			'TypeInner' => 172
		}
	},
	{#State 105
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'SubExpression' => 173,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138
		}
	},
	{#State 106
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'OP03_MATH_INC_DEC' => 89,
			'OP01_QW' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 28,
			"]" => -210,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'LBRACKET' => 106,
			'MY' => 149
		},
		GOTOS => {
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'ListElement' => 158,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'OPTIONAL-53' => 174,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'ListElements' => 175,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'SubExpression' => 154
		}
	},
	{#State 107
		DEFAULT => -168
	},
	{#State 108
		ACTIONS => {
			'WORD' => 176,
			'TYPE_FHREF' => 180,
			'WORD_SCOPED' => 177,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 109
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'MY' => 149,
			'LBRACKET' => -213
		},
		GOTOS => {
			'OPTIONAL-54' => 181,
			'TypeInner' => 182,
			'Variable' => 183,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 110
		DEFAULT => -135
	},
	{#State 111
		DEFAULT => -151
	},
	{#State 112
		DEFAULT => -153
	},
	{#State 113
		ACTIONS => {
			'FHREF_SYMBOL' => 184
		}
	},
	{#State 114
		ACTIONS => {
			'ENV' => 199,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP19_LOOP_CONTROL' => 200,
			'OP22_LOGICAL_NEG' => 185,
			'OP10_NAMED_UNARY' => 186,
			'LITERAL_STRING' => 123,
			'OP23_LOGICAL_AND' => 202,
			'OP01_NAMED_VOID' => 188,
			'OP11_COMPARE_LT_GT' => 204,
			'WORD' => 203,
			"%{" => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP01_NAMED' => 208,
			'OP01_PRINT' => 207,
			'OP12_COMPARE_EQ_NE' => 191,
			"}" => 192,
			'OP08_MATH_ADD_SUB' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP01_CLOSE' => 197,
			'OP07_STRING_REPEAT' => 198,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 209
		},
		GOTOS => {
			'HashEntry' => 201,
			'OpStringOrWord' => 189,
			'Literal' => 193,
			'HashDereference' => 206,
			'VarOrLitOrOpStrOrWord' => 187,
			'Variable' => 205,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 115
		DEFAULT => -90
	},
	{#State 116
		DEFAULT => -248
	},
	{#State 117
		DEFAULT => -164
	},
	{#State 118
		DEFAULT => -143
	},
	{#State 119
		DEFAULT => -246
	},
	{#State 120
		ACTIONS => {
			'WORD_UPPERCASE' => 210
		},
		GOTOS => {
			'LoopLabel' => 211
		}
	},
	{#State 121
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'WORD' => 28
		},
		GOTOS => {
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'SubExpression' => 212,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138
		}
	},
	{#State 122
		DEFAULT => -131
	},
	{#State 123
		DEFAULT => -249
	},
	{#State 124
		DEFAULT => -150
	},
	{#State 125
		DEFAULT => -145
	},
	{#State 126
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'WORD_UPPERCASE' => 156,
			'OP01_PRINT' => 215,
			"\@{" => 109,
			'OP01_NAMED' => 214,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140
		},
		GOTOS => {
			'SubExpression' => 213,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'ArrayDereference' => 138,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127
		}
	},
	{#State 127
		DEFAULT => -156
	},
	{#State 128
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -152,
			'OP17_LIST_RANGE' => -152,
			'OP19_VARIABLE_ASSIGN_BY' => 216,
			'OP08_STRING_CAT' => -152,
			'OP06_REGEX_BIND' => -152,
			'OP02_METHOD_THINARROW' => 218,
			")" => -152,
			'OP03_MATH_INC_DEC' => 217,
			'OP15_LOGICAL_AND' => -152,
			'OP23_LOGICAL_AND' => -152,
			'OP09_BITWISE_SHIFT' => -152,
			'OP24_LOGICAL_OR_XOR' => -152,
			'OP07_MATH_MULT_DIV_MOD' => -152,
			'OP07_STRING_REPEAT' => -152,
			'OP04_MATH_POW' => -152,
			'OP13_BITWISE_AND' => -152,
			'OP18_TERNARY' => -152,
			'OP12_COMPARE_EQ_NE' => -152,
			'OP19_VARIABLE_ASSIGN' => 219,
			'OP08_MATH_ADD_SUB' => -152,
			'OP14_BITWISE_OR_XOR' => -152,
			'OP16_LOGICAL_OR' => -152
		}
	},
	{#State 129
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => 234,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220
		}
	},
	{#State 130
		DEFAULT => -17
	},
	{#State 131
		DEFAULT => -166
	},
	{#State 132
		ACTIONS => {
			'LPAREN' => 237,
			'COLON' => -233
		}
	},
	{#State 133
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'MY' => 149,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'ARGV' => 151,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'SubExpression' => 239,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'ListElement' => 238,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => -126,
			'LBRACKET' => -126,
			'MY' => -126,
			"%{" => -126,
			'LPAREN' => -126,
			'OP22_LOGICAL_NEG_LPAREN' => -126,
			'FHREF_SYMBOL_BRACES' => 242,
			'OP03_MATH_INC_DEC' => -126,
			'ARGV' => -126,
			'SELF' => -126,
			'VARIABLE_SYMBOL' => -126,
			'STDOUT_STDERR' => 241,
			'OP10_NAMED_UNARY' => -126,
			'OP22_LOGICAL_NEG' => -126,
			'OP05_LOGICAL_NEG' => -126,
			'OP01_QW' => -126,
			'OP05_BITWISE_NEG_LPAREN' => -126,
			'LITERAL_STRING' => -126,
			"undef" => -126,
			'CONSTANT_CALL_SCOPED' => -126,
			'WORD_SCOPED' => -126,
			'OP01_CLOSE' => -126,
			'LBRACE' => -126,
			'LITERAL_NUMBER' => -126,
			'OP05_MATH_NEG_LPAREN' => -126,
			'OP01_OPEN' => -126,
			'WORD_UPPERCASE' => -126,
			"\@{" => -126,
			'OP01_NAMED' => -126
		},
		GOTOS => {
			'OPTIONAL-38' => 240,
			'PAREN-37' => 243
		}
	},
	{#State 135
		ACTIONS => {
			"while" => 244,
			"for" => 250,
			"foreach" => 248
		},
		GOTOS => {
			'LoopForEach' => 249,
			'LoopWhile' => 247,
			'Loop' => 245,
			'LoopFor' => 246
		}
	},
	{#State 136
		DEFAULT => -14
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 251
		}
	},
	{#State 138
		DEFAULT => -154
	},
	{#State 139
		ACTIONS => {
			'MY' => 252
		}
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'WORD' => 28,
			'LBRACKET' => 106,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'SubExpression' => 253
		}
	},
	{#State 141
		DEFAULT => -92
	},
	{#State 142
		ACTIONS => {
			"use constant" => -69,
			"our hashref \$properties" => -69,
			'USE' => 48
		},
		GOTOS => {
			'STAR-29' => 254,
			'Include' => 255
		}
	},
	{#State 143
		ACTIONS => {
			'MY' => 256
		}
	},
	{#State 144
		ACTIONS => {
			'LITERAL_STRING' => 123,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'Literal' => 257
		}
	},
	{#State 145
		ACTIONS => {
			'WORD_SCOPED' => 177,
			'WORD' => 176,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 258
		}
	},
	{#State 146
		DEFAULT => -98
	},
	{#State 147
		DEFAULT => -163
	},
	{#State 148
		DEFAULT => -89
	},
	{#State 149
		ACTIONS => {
			'WORD' => 176,
			'WORD_SCOPED' => 177,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 259
		}
	},
	{#State 150
		DEFAULT => -149
	},
	{#State 151
		DEFAULT => -208
	},
	{#State 152
		ACTIONS => {
			'WORD' => 28,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'SubExpression' => 260,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111
		}
	},
	{#State 153
		ACTIONS => {
			";" => 261
		}
	},
	{#State 154
		ACTIONS => {
			";" => -205,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -205,
			'OP23_LOGICAL_AND' => 222,
			'OP21_LIST_COMMA' => -205,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			"]" => -205,
			'OP08_STRING_CAT' => 227
		}
	},
	{#State 155
		ACTIONS => {
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'LBRACKET' => 106,
			'WORD' => 28,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 262
		}
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 237
		}
	},
	{#State 157
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -152,
			'OP24_LOGICAL_OR_XOR' => -152,
			'OP07_STRING_REPEAT' => -152,
			'OP04_MATH_POW' => -152,
			'OP13_BITWISE_AND' => -152,
			'OP18_TERNARY' => -152,
			'OP12_COMPARE_EQ_NE' => -152,
			";" => -152,
			'OP16_LOGICAL_OR' => -152,
			"}" => -152,
			'OP08_MATH_ADD_SUB' => -152,
			'OP14_BITWISE_OR_XOR' => -152,
			"]" => -152,
			'OP17_LIST_RANGE' => -152,
			'OP11_COMPARE_LT_GT' => -152,
			'OP08_STRING_CAT' => -152,
			")" => -152,
			'OP03_MATH_INC_DEC' => 217,
			'OP02_METHOD_THINARROW' => 218,
			'OP15_LOGICAL_AND' => -152,
			'OP06_REGEX_BIND' => -152,
			'OP09_BITWISE_SHIFT' => -152,
			'OP21_LIST_COMMA' => -152,
			'OP23_LOGICAL_AND' => -152
		}
	},
	{#State 158
		DEFAULT => -203,
		GOTOS => {
			'STAR-52' => 263
		}
	},
	{#State 159
		DEFAULT => -207
	},
	{#State 160
		DEFAULT => -127
	},
	{#State 161
		ACTIONS => {
			")" => 264
		}
	},
	{#State 162
		DEFAULT => -170
	},
	{#State 163
		ACTIONS => {
			'OP23_LOGICAL_AND' => -110,
			'OP09_BITWISE_SHIFT' => 228,
			'OP21_LIST_COMMA' => -110,
			'OP06_REGEX_BIND' => 230,
			")" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => -110,
			"]" => -110,
			'OP17_LIST_RANGE' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => -110,
			"}" => -110,
			";" => -110,
			'OP13_BITWISE_AND' => -110,
			'OP18_TERNARY' => -110,
			'OP12_COMPARE_EQ_NE' => -110,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 232
		}
	},
	{#State 164
		ACTIONS => {
			'OP07_STRING_REPEAT' => -191,
			'OP04_MATH_POW' => -191,
			'COLON' => -191,
			'OP07_MATH_MULT_DIV_MOD' => -191,
			'OP24_LOGICAL_OR_XOR' => -191,
			'OP16_LOGICAL_OR' => -191,
			"}" => -191,
			'OP08_MATH_ADD_SUB' => -191,
			'OP14_BITWISE_OR_XOR' => -191,
			'OP13_BITWISE_AND' => -191,
			'OP18_TERNARY' => -191,
			'OP19_VARIABLE_ASSIGN' => -191,
			'OP12_COMPARE_EQ_NE' => -191,
			";" => -191,
			'OP08_STRING_CAT' => -191,
			'OP19_VARIABLE_ASSIGN_BY' => -191,
			"]" => -191,
			'OP17_LIST_RANGE' => -191,
			'OP11_COMPARE_LT_GT' => -191,
			'OP21_LIST_COMMA' => -191,
			'OP09_BITWISE_SHIFT' => -191,
			'OP23_LOGICAL_AND' => -191,
			'OP03_MATH_INC_DEC' => -191,
			")" => -191,
			'OP02_METHOD_THINARROW' => -191,
			'OP20_HASH_FATARROW' => -191,
			'OP02_ARRAY_THINARROW' => 265,
			'OP15_LOGICAL_AND' => -191,
			'OP02_HASH_THINARROW' => 267,
			'OP06_REGEX_BIND' => -191
		},
		GOTOS => {
			'VariableRetrieval' => 266
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACE' => 114,
			")" => -142
		},
		GOTOS => {
			'HashReference' => 269,
			'OPTIONAL-42' => 268
		}
	},
	{#State 166
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD' => 28,
			'LBRACKET' => 106,
			'MY' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			")" => -138,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_QW' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124
		},
		GOTOS => {
			'ListElement' => 158,
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'OPTIONAL-40' => 270,
			'Operator' => 118,
			'SubExpression' => 154,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ListElements' => 271,
			'ArrayReference' => 112
		}
	},
	{#State 167
		ACTIONS => {
			";" => -121,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			"}" => -121,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			"]" => -121,
			'OP08_STRING_CAT' => 227
		}
	},
	{#State 168
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP08_STRING_CAT' => -102,
			'OP06_REGEX_BIND' => -102,
			")" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP09_BITWISE_SHIFT' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => -102,
			'OP07_STRING_REPEAT' => -102,
			'OP04_MATH_POW' => 223,
			";" => -102,
			'OP18_TERNARY' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP12_COMPARE_EQ_NE' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => -102,
			'OP16_LOGICAL_OR' => -102,
			"}" => -102
		}
	},
	{#State 169
		DEFAULT => -16
	},
	{#State 170
		ACTIONS => {
			'LBRACE' => 114
		},
		GOTOS => {
			'HashReference' => 272
		}
	},
	{#State 171
		ACTIONS => {
			"}" => 273
		}
	},
	{#State 172
		DEFAULT => -227
	},
	{#State 173
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			")" => 274,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234
		}
	},
	{#State 174
		ACTIONS => {
			"]" => 275
		}
	},
	{#State 175
		DEFAULT => -209
	},
	{#State 176
		DEFAULT => -234
	},
	{#State 177
		DEFAULT => -235
	},
	{#State 178
		DEFAULT => -236
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 276
		}
	},
	{#State 180
		ACTIONS => {
			'FHREF_SYMBOL' => 277
		}
	},
	{#State 181
		ACTIONS => {
			'LBRACKET' => 106
		},
		GOTOS => {
			'ArrayReference' => 278
		}
	},
	{#State 182
		DEFAULT => -212
	},
	{#State 183
		ACTIONS => {
			"}" => 279
		}
	},
	{#State 184
		DEFAULT => -97
	},
	{#State 185
		DEFAULT => -258
	},
	{#State 186
		DEFAULT => -263
	},
	{#State 187
		ACTIONS => {
			'OP20_HASH_FATARROW' => 280
		}
	},
	{#State 188
		DEFAULT => -270
	},
	{#State 189
		DEFAULT => -245
	},
	{#State 190
		DEFAULT => -259
	},
	{#State 191
		DEFAULT => -261
	},
	{#State 192
		DEFAULT => -226
	},
	{#State 193
		DEFAULT => -244
	},
	{#State 194
		DEFAULT => -264
	},
	{#State 195
		DEFAULT => -265
	},
	{#State 196
		DEFAULT => -256
	},
	{#State 197
		DEFAULT => -268
	},
	{#State 198
		DEFAULT => -266
	},
	{#State 199
		DEFAULT => -220
	},
	{#State 200
		DEFAULT => -260
	},
	{#State 201
		DEFAULT => -224,
		GOTOS => {
			'STAR-57' => 281
		}
	},
	{#State 202
		DEFAULT => -257
	},
	{#State 203
		DEFAULT => -272
	},
	{#State 204
		DEFAULT => -262
	},
	{#State 205
		DEFAULT => -243
	},
	{#State 206
		DEFAULT => -219
	},
	{#State 207
		DEFAULT => -271
	},
	{#State 208
		DEFAULT => -267
	},
	{#State 209
		DEFAULT => -269
	},
	{#State 210
		DEFAULT => -233
	},
	{#State 211
		ACTIONS => {
			";" => 282
		}
	},
	{#State 212
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			")" => 283,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234
		}
	},
	{#State 213
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => 284,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231
		}
	},
	{#State 214
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD' => 28,
			'MY' => 149,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_QW' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'SubExpression' => 239,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'ListElement' => 285
		}
	},
	{#State 215
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 286
		}
	},
	{#State 216
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119
		},
		GOTOS => {
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'SubExpression' => 287,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138
		}
	},
	{#State 217
		DEFAULT => -99
	},
	{#State 218
		ACTIONS => {
			'LPAREN' => 288
		}
	},
	{#State 219
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'FHREF_SYMBOL_IN' => 290,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 28,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LBRACKET' => 106,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'STDIN' => 292,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'SubExpression' => 291,
			'Expression' => 150,
			'SubExpressionOrInput' => 289,
			'HashReference' => 91,
			'Literal' => 111,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99
		}
	},
	{#State 220
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'SubExpression' => 293,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 221
		ACTIONS => {
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'SubExpression' => 294
		}
	},
	{#State 222
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'LBRACKET' => 106,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89
		},
		GOTOS => {
			'SubExpression' => 295,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 223
		ACTIONS => {
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 296,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 224
		ACTIONS => {
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'WORD' => 28
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'SubExpression' => 297,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LITERAL_STRING' => 123,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'Variable' => 299,
			'Literal' => 298,
			'VariableSymbolOrSelf' => 98,
			'VariableOrLiteral' => 300
		}
	},
	{#State 226
		ACTIONS => {
			'WORD' => 28,
			'LBRACKET' => 106,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'SubExpression' => 301,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138
		}
	},
	{#State 227
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'SubExpression' => 302,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138
		}
	},
	{#State 228
		ACTIONS => {
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'SubExpression' => 303,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 229
		ACTIONS => {
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 304
		}
	},
	{#State 230
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 305
		}
	},
	{#State 231
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD' => 28,
			'LBRACKET' => 106,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'SubExpression' => 306,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138
		}
	},
	{#State 232
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'SubExpression' => 307,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 233
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'SubExpression' => 308
		}
	},
	{#State 234
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'WORD' => 28,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'LBRACKET' => 106,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97
		},
		GOTOS => {
			'SubExpression' => 309,
			'Expression' => 150,
			'HashReference' => 91,
			'Literal' => 111,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 235
		ACTIONS => {
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'SubExpression' => 310,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'ArrayDereference' => 138,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157
		}
	},
	{#State 236
		ACTIONS => {
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD' => 28,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LBRACKET' => 106,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'SubExpression' => 311
		}
	},
	{#State 237
		ACTIONS => {
			")" => 312
		}
	},
	{#State 238
		ACTIONS => {
			'OP21_LIST_COMMA' => 313
		}
	},
	{#State 239
		ACTIONS => {
			";" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP18_TERNARY' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP04_MATH_POW' => -94,
			'OP07_STRING_REPEAT' => -94,
			'OP06_REGEX_BIND' => -94,
			'OP15_LOGICAL_AND' => -94,
			")" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -205,
			'OP09_BITWISE_SHIFT' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP08_STRING_CAT' => -94
		}
	},
	{#State 240
		ACTIONS => {
			'WORD' => 28,
			'MY' => 149,
			'LBRACKET' => 106,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'ARGV' => 151,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'SubExpression' => 154,
			'ListElements' => 314,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 158,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157
		}
	},
	{#State 241
		DEFAULT => -124
	},
	{#State 242
		ACTIONS => {
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'MY' => 149,
			'LBRACKET' => 106,
			'WORD' => 28,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ArrayReference' => 112,
			'ListElements' => 315,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Expression' => 150,
			'HashReference' => 91,
			'Literal' => 111,
			'SubExpression' => 154,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 158
		}
	},
	{#State 243
		DEFAULT => -125
	},
	{#State 244
		ACTIONS => {
			'LPAREN_MY' => 317,
			'LPAREN' => 316
		}
	},
	{#State 245
		DEFAULT => -167
	},
	{#State 246
		DEFAULT => -178
	},
	{#State 247
		DEFAULT => -180
	},
	{#State 248
		ACTIONS => {
			'MY' => 318
		}
	},
	{#State 249
		DEFAULT => -179
	},
	{#State 250
		ACTIONS => {
			'MY' => 320,
			'LPAREN_MY' => 319
		}
	},
	{#State 251
		ACTIONS => {
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 28,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'LBRACKET' => 106
		},
		GOTOS => {
			'SubExpression' => 321,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 252
		ACTIONS => {
			'TYPE_FHREF' => 322
		}
	},
	{#State 253
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP16_LOGICAL_OR' => 234,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221,
			'OP08_STRING_CAT' => 227,
			'OP15_LOGICAL_AND' => 229,
			")" => 323,
			'OP06_REGEX_BIND' => 230,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222
		}
	},
	{#State 254
		ACTIONS => {
			"use constant" => 60,
			"our hashref \$properties" => 324
		},
		GOTOS => {
			'Constant' => 325,
			'Properties' => 326
		}
	},
	{#State 255
		DEFAULT => -66
	},
	{#State 256
		ACTIONS => {
			'WORD_SCOPED' => 177,
			'WORD' => 176,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 327
		}
	},
	{#State 257
		ACTIONS => {
			";" => 328
		}
	},
	{#State 258
		ACTIONS => {
			"\$TYPED_" => 329
		}
	},
	{#State 259
		ACTIONS => {
			"\$TYPED_" => 330
		}
	},
	{#State 260
		ACTIONS => {
			"]" => -206,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221,
			'OP08_STRING_CAT' => 227,
			'OP15_LOGICAL_AND' => 229,
			")" => -206,
			'OP06_REGEX_BIND' => 230,
			'OP09_BITWISE_SHIFT' => 228,
			'OP21_LIST_COMMA' => -206,
			'OP23_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			";" => -206,
			'OP16_LOGICAL_OR' => 234,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224
		}
	},
	{#State 261
		DEFAULT => -133
	},
	{#State 262
		ACTIONS => {
			'OP16_LOGICAL_OR' => -94,
			"}" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP18_TERNARY' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			";" => -94,
			'OP07_STRING_REPEAT' => -94,
			'OP04_MATH_POW' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP23_LOGICAL_AND' => -94,
			")" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_BIND' => -94,
			'OP08_STRING_CAT' => -94,
			'OP17_LIST_RANGE' => -94,
			"]" => -94,
			'OP11_COMPARE_LT_GT' => -94
		}
	},
	{#State 263
		ACTIONS => {
			'OP21_LIST_COMMA' => 332,
			";" => -204,
			"]" => -204,
			")" => -204
		},
		GOTOS => {
			'PAREN-51' => 331
		}
	},
	{#State 264
		ACTIONS => {
			";" => 333
		}
	},
	{#State 265
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 28,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'SubExpression' => 334,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112
		}
	},
	{#State 266
		DEFAULT => -189
	},
	{#State 267
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LBRACKET' => 106,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'WORD' => 336,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'SubExpression' => 335,
			'Expression' => 150,
			'HashReference' => 91,
			'Literal' => 111,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99
		}
	},
	{#State 268
		ACTIONS => {
			")" => 337
		}
	},
	{#State 269
		DEFAULT => -141
	},
	{#State 270
		ACTIONS => {
			")" => 338
		}
	},
	{#State 271
		DEFAULT => -137
	},
	{#State 272
		ACTIONS => {
			"}" => 339
		}
	},
	{#State 273
		DEFAULT => -229
	},
	{#State 274
		DEFAULT => -120
	},
	{#State 275
		DEFAULT => -211
	},
	{#State 276
		ACTIONS => {
			";" => 340,
			'OP02_ARRAY_THINARROW' => 342,
			'OP19_VARIABLE_ASSIGN' => 341
		}
	},
	{#State 277
		ACTIONS => {
			";" => 343
		}
	},
	{#State 278
		ACTIONS => {
			"}" => 344
		}
	},
	{#State 279
		DEFAULT => -214
	},
	{#State 280
		ACTIONS => {
			'WORD_UPPERCASE' => -217,
			"\@{" => -217,
			'OP01_NAMED' => -217,
			'LITERAL_NUMBER' => -217,
			'OP01_OPEN' => -217,
			'OP05_MATH_NEG_LPAREN' => -217,
			'WORD_SCOPED' => -217,
			'LBRACE' => -217,
			'OP01_CLOSE' => -217,
			'OP10_NAMED_UNARY' => -217,
			'OP22_LOGICAL_NEG' => -217,
			'OP05_LOGICAL_NEG' => -217,
			'OP05_BITWISE_NEG_LPAREN' => -217,
			'LITERAL_STRING' => -217,
			"undef" => -217,
			'CONSTANT_CALL_SCOPED' => -217,
			'OP03_MATH_INC_DEC' => -217,
			'VARIABLE_SYMBOL' => -217,
			'SELF' => -217,
			'LBRACKET' => -217,
			'MY' => 149,
			'LPAREN' => -217,
			"%{" => -217,
			'OP22_LOGICAL_NEG_LPAREN' => -217,
			'WORD' => -217
		},
		GOTOS => {
			'TypeInner' => 345,
			'OPTIONAL-55' => 346
		}
	},
	{#State 281
		ACTIONS => {
			"}" => 347,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-56' => 348
		}
	},
	{#State 282
		DEFAULT => -136
	},
	{#State 283
		DEFAULT => -101
	},
	{#State 284
		DEFAULT => -157
	},
	{#State 285
		ACTIONS => {
			'OP21_LIST_COMMA' => 350
		}
	},
	{#State 286
		ACTIONS => {
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'MY' => 149,
			'LBRACKET' => 106,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'ARGV' => 151,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89
		},
		GOTOS => {
			'SubExpression' => 154,
			'ArrayReference' => 112,
			'ListElements' => 351,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 158,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157
		}
	},
	{#State 287
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			";" => -200,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222,
			'OP15_LOGICAL_AND' => 229,
			")" => -200,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 288
		ACTIONS => {
			")" => -140,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'MY' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139
		},
		GOTOS => {
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 158,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'SubExpression' => 154,
			'OPTIONAL-41' => 352,
			'ListElements' => 353,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91
		}
	},
	{#State 289
		DEFAULT => -199
	},
	{#State 290
		DEFAULT => -159
	},
	{#State 291
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			";" => -158,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			")" => -158,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 292
		DEFAULT => -160
	},
	{#State 293
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => undef,
			"]" => -118,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			";" => -118,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => -118,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			"}" => -118,
			'OP16_LOGICAL_OR' => 234
		}
	},
	{#State 294
		ACTIONS => {
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => -112,
			"}" => -112,
			";" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => undef,
			'OP17_LIST_RANGE' => -112,
			"]" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			")" => -112,
			'OP15_LOGICAL_AND' => -112
		}
	},
	{#State 295
		ACTIONS => {
			";" => -122,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			"}" => -122,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP21_LIST_COMMA' => -122,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			"]" => -122,
			'OP08_STRING_CAT' => 227
		}
	},
	{#State 296
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => -100,
			'OP06_REGEX_BIND' => -100,
			")" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP04_MATH_POW' => 223,
			";" => -100,
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			"}" => -100
		}
	},
	{#State 297
		ACTIONS => {
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => -115,
			'OP12_COMPARE_EQ_NE' => 236,
			";" => -115,
			'OP16_LOGICAL_OR' => -115,
			"}" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP08_MATH_ADD_SUB' => 235,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			")" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP06_REGEX_BIND' => 230,
			'OP21_LIST_COMMA' => -115,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => -115,
			"]" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP11_COMPARE_LT_GT' => 221,
			'OP08_STRING_CAT' => 227
		}
	},
	{#State 298
		DEFAULT => -242
	},
	{#State 299
		DEFAULT => -241
	},
	{#State 300
		ACTIONS => {
			'COLON' => 354
		}
	},
	{#State 301
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			")" => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => -114,
			"]" => -114,
			'OP08_STRING_CAT' => 227,
			";" => -114,
			'OP13_BITWISE_AND' => -114,
			'OP18_TERNARY' => -114,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP16_LOGICAL_OR' => -114,
			"}" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 302
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP18_TERNARY' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			";" => -108,
			'OP16_LOGICAL_OR' => -108,
			"}" => -108,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP17_LIST_RANGE' => -108,
			"]" => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP08_STRING_CAT' => -108,
			")" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP06_REGEX_BIND' => 230,
			'OP09_BITWISE_SHIFT' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 303
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			";" => -109,
			'OP18_TERNARY' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP12_COMPARE_EQ_NE' => -109,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP16_LOGICAL_OR' => -109,
			"}" => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"]" => -109,
			'OP17_LIST_RANGE' => -109,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			")" => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP09_BITWISE_SHIFT' => -109
		}
	},
	{#State 304
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => -116,
			'OP12_COMPARE_EQ_NE' => 236,
			";" => -116,
			'OP16_LOGICAL_OR' => -116,
			"}" => -116,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			"]" => -116,
			'OP17_LIST_RANGE' => -116,
			'OP11_COMPARE_LT_GT' => 221,
			'OP08_STRING_CAT' => 227,
			")" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_BIND' => 230,
			'OP21_LIST_COMMA' => -116,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => -116
		}
	},
	{#State 305
		DEFAULT => -104
	},
	{#State 306
		ACTIONS => {
			'OP08_STRING_CAT' => -105,
			"]" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_BIND' => 230,
			'OP07_STRING_REPEAT' => -105,
			'OP04_MATH_POW' => 223,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => -105,
			"}" => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP18_TERNARY' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP12_COMPARE_EQ_NE' => -105,
			";" => -105
		}
	},
	{#State 307
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			")" => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP17_LIST_RANGE' => -106,
			"]" => -106,
			'OP08_STRING_CAT' => -106,
			";" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP16_LOGICAL_OR' => -106,
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 308
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			"}" => -123,
			'OP16_LOGICAL_OR' => 234,
			";" => -123,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			"]" => -123,
			'OP17_LIST_RANGE' => 220,
			'OP23_LOGICAL_AND' => 222,
			'OP21_LIST_COMMA' => -123,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -123
		}
	},
	{#State 309
		ACTIONS => {
			'OP23_LOGICAL_AND' => -117,
			'OP09_BITWISE_SHIFT' => 228,
			'OP21_LIST_COMMA' => -117,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -117,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			"]" => -117,
			'OP17_LIST_RANGE' => -117,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			"}" => -117,
			'OP16_LOGICAL_OR' => -117,
			";" => -117,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => -117,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 232
		}
	},
	{#State 310
		ACTIONS => {
			"]" => -107,
			'OP17_LIST_RANGE' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP08_STRING_CAT' => -107,
			'OP15_LOGICAL_AND' => -107,
			")" => -107,
			'OP06_REGEX_BIND' => 230,
			'OP09_BITWISE_SHIFT' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP12_COMPARE_EQ_NE' => -107,
			'OP18_TERNARY' => -107,
			'OP13_BITWISE_AND' => -107,
			";" => -107,
			"}" => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP14_BITWISE_OR_XOR' => -107
		}
	},
	{#State 311
		ACTIONS => {
			'OP16_LOGICAL_OR' => -113,
			"}" => -113,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP18_TERNARY' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NE' => undef,
			";" => -113,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => -113,
			")" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => -113,
			"]" => -113,
			'OP11_COMPARE_LT_GT' => 221
		}
	},
	{#State 312
		DEFAULT => -144
	},
	{#State 313
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP01_QW' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD' => 28,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LBRACKET' => 106,
			'MY' => 149
		},
		GOTOS => {
			'ListElement' => 158,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'SubExpression' => 154,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ListElements' => 355,
			'ArrayReference' => 112
		}
	},
	{#State 314
		ACTIONS => {
			";" => 356
		}
	},
	{#State 315
		ACTIONS => {
			";" => 357
		}
	},
	{#State 316
		ACTIONS => {
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126
		},
		GOTOS => {
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'SubExpression' => 358
		}
	},
	{#State 317
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 177,
			'WORD' => 176
		},
		GOTOS => {
			'Type' => 359
		}
	},
	{#State 318
		ACTIONS => {
			'WORD' => 176,
			'WORD_SCOPED' => 177,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 360
		}
	},
	{#State 319
		ACTIONS => {
			'TYPE_INTEGER' => 361
		}
	},
	{#State 320
		ACTIONS => {
			'TYPE_INTEGER' => 362
		}
	},
	{#State 321
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => 234,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => 363,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220
		}
	},
	{#State 322
		ACTIONS => {
			'FHREF_SYMBOL' => 364
		}
	},
	{#State 323
		DEFAULT => -103
	},
	{#State 324
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 325
		DEFAULT => -68
	},
	{#State 326
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 366
		}
	},
	{#State 327
		ACTIONS => {
			"\$RETURN_TYPE" => 367
		}
	},
	{#State 328
		DEFAULT => -52
	},
	{#State 329
		ACTIONS => {
			'WORD_UPPERCASE' => 368
		}
	},
	{#State 330
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 204,
			'WORD' => 203,
			'OP19_LOOP_CONTROL' => 200,
			'OP10_NAMED_UNARY' => 186,
			'OP22_LOGICAL_NEG' => 185,
			'OP23_LOGICAL_AND' => 202,
			'OP01_NAMED_VOID' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP01_CLOSE' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 198,
			'OP01_OPEN' => 209,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP01_NAMED' => 208,
			'OP01_PRINT' => 207,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP08_MATH_ADD_SUB' => 194
		},
		GOTOS => {
			'OpStringOrWord' => 369
		}
	},
	{#State 331
		DEFAULT => -202
	},
	{#State 332
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'ARGV' => 151,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'MY' => 149,
			'LBRACKET' => 106,
			'WORD' => 28,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'SubExpression' => 154,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ListElement' => 370,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 333
		DEFAULT => -132
	},
	{#State 334
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			"]" => 371,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 335
		ACTIONS => {
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			"}" => 372,
			'OP16_LOGICAL_OR' => 234,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225
		}
	},
	{#State 336
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -231,
			"}" => 373,
			'LPAREN' => -231
		}
	},
	{#State 337
		DEFAULT => -148
	},
	{#State 338
		DEFAULT => -146
	},
	{#State 339
		DEFAULT => -230
	},
	{#State 340
		DEFAULT => -195
	},
	{#State 341
		ACTIONS => {
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'STDIN' => 292,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_SCOLON' => 374,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP22_LOGICAL_NEG' => 100,
			'FHREF_SYMBOL_IN' => 290,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 377,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LBRACKET' => 106,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'WORD' => 28
		},
		GOTOS => {
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'SubExpressionOrInput' => 375,
			'OpNamedScolonOrSubExpIn' => 376,
			'SubExpression' => 291
		}
	},
	{#State 342
		ACTIONS => {
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'WORD' => 28,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104
		},
		GOTOS => {
			'SubExpression' => 378,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 343
		DEFAULT => -198
	},
	{#State 344
		DEFAULT => -215
	},
	{#State 345
		DEFAULT => -216
	},
	{#State 346
		ACTIONS => {
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'LBRACKET' => 106,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 379,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'ArrayDereference' => 138,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127
		}
	},
	{#State 347
		DEFAULT => -225
	},
	{#State 348
		DEFAULT => -223
	},
	{#State 349
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP01_CLOSE' => 197,
			'OP07_STRING_REPEAT' => 198,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 209,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP01_NAMED' => 208,
			'OP01_PRINT' => 207,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP08_MATH_ADD_SUB' => 194,
			'WORD' => 203,
			'OP11_COMPARE_LT_GT' => 204,
			"%{" => 104,
			'ENV' => 199,
			'VARIABLE_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 200,
			'SELF' => 88,
			'OP22_LOGICAL_NEG' => 185,
			'OP10_NAMED_UNARY' => 186,
			'OP23_LOGICAL_AND' => 202,
			'LITERAL_STRING' => 123,
			'OP01_NAMED_VOID' => 188
		},
		GOTOS => {
			'HashEntry' => 380,
			'OpStringOrWord' => 189,
			'Variable' => 205,
			'VarOrLitOrOpStrOrWord' => 187,
			'HashDereference' => 206,
			'Literal' => 193,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 350
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD' => 28,
			'LBRACKET' => 106,
			'MY' => 149,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123
		},
		GOTOS => {
			'ListElement' => 158,
			'ArrayDereference' => 138,
			'TypeInner' => 152,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118,
			'SubExpression' => 154,
			'Expression' => 150,
			'HashReference' => 91,
			'Literal' => 111,
			'ArrayReference' => 112,
			'ListElements' => 381,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99
		}
	},
	{#State 351
		ACTIONS => {
			")" => 382
		}
	},
	{#State 352
		ACTIONS => {
			")" => 383
		}
	},
	{#State 353
		DEFAULT => -139
	},
	{#State 354
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'LITERAL_STRING' => 123,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'Literal' => 298,
			'Variable' => 299,
			'VariableSymbolOrSelf' => 98,
			'VariableOrLiteral' => 384
		}
	},
	{#State 355
		ACTIONS => {
			";" => 385
		}
	},
	{#State 356
		DEFAULT => -129
	},
	{#State 357
		DEFAULT => -130
	},
	{#State 358
		ACTIONS => {
			'OP16_LOGICAL_OR' => 234,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222,
			'OP15_LOGICAL_AND' => 229,
			")" => 386,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 361
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 362
		ACTIONS => {
			'VARIABLE_SYMBOL' => 390
		}
	},
	{#State 363
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 364
		ACTIONS => {
			'OP21_LIST_COMMA' => 393
		}
	},
	{#State 365
		ACTIONS => {
			'LBRACE' => 394
		}
	},
	{#State 366
		ACTIONS => {
			'LITERAL_NUMBER' => 399,
			'SUB' => 397
		},
		GOTOS => {
			'Method' => 396,
			'SubroutineOrMethod' => 398,
			'Subroutine' => 395
		}
	},
	{#State 367
		ACTIONS => {
			"}" => 400
		}
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 369
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 370
		DEFAULT => -201
	},
	{#State 371
		DEFAULT => -192
	},
	{#State 372
		DEFAULT => -193
	},
	{#State 373
		DEFAULT => -194
	},
	{#State 374
		DEFAULT => -253
	},
	{#State 375
		ACTIONS => {
			";" => 403
		}
	},
	{#State 376
		DEFAULT => -196
	},
	{#State 377
		DEFAULT => -254
	},
	{#State 378
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			"]" => 404,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 379
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP21_LIST_COMMA' => -218,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			"}" => -218
		}
	},
	{#State 380
		DEFAULT => -222
	},
	{#State 381
		ACTIONS => {
			")" => 405
		}
	},
	{#State 382
		DEFAULT => -93
	},
	{#State 383
		DEFAULT => -147
	},
	{#State 384
		DEFAULT => -119
	},
	{#State 385
		DEFAULT => -134
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 406
		}
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 388
		ACTIONS => {
			'LPAREN' => 408
		}
	},
	{#State 389
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 390
		ACTIONS => {
			'LPAREN' => 410
		}
	},
	{#State 391
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP01_NAMED_VOID' => 93,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'MY' => 108,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"foreach" => -165,
			"%{" => 104,
			"while" => -165,
			"\@{" => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'LITERAL_NUMBER' => 116,
			'OP01_NAMED_SCOLON' => 115,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED_VOID_SCOLON' => 122,
			"undef" => 124,
			'VARIABLE_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 120,
			'LPAREN' => 126,
			'WORD' => 28,
			"for" => -165,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			'OP01_PRINT' => 134,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			"if" => 137,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'VariableModification' => 96,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'HashReference' => 91,
			'Expression' => 92,
			'LoopLabel' => 90,
			'VariableDeclaration' => 102,
			'OperatorVoid' => 107,
			'HashDereference' => 127,
			'Variable' => 128,
			'PLUS-49' => 411,
			'SubExpression' => 129,
			'Operation' => 412,
			'Conditional' => 131,
			'ArrayReference' => 112,
			'OPTIONAL-44' => 135,
			'Literal' => 111,
			'ArrayDereference' => 138,
			'PAREN-43' => 117,
			'Operator' => 118,
			'Statement' => 141
		}
	},
	{#State 392
		DEFAULT => -173,
		GOTOS => {
			'STAR-46' => 413
		}
	},
	{#State 393
		ACTIONS => {
			'LITERAL_STRING' => 414
		}
	},
	{#State 394
		ACTIONS => {
			'OP01_NAMED' => 208,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP01_PRINT' => 207,
			'OP12_COMPARE_EQ_NE' => 191,
			"}" => 416,
			'OP08_MATH_ADD_SUB' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP01_CLOSE' => 197,
			'OP07_STRING_REPEAT' => 198,
			'OP01_OPEN' => 209,
			'OP19_LOOP_CONTROL' => 200,
			'OP22_LOGICAL_NEG' => 185,
			'OP10_NAMED_UNARY' => 186,
			'OP01_NAMED_VOID' => 188,
			'OP23_LOGICAL_AND' => 202,
			'OP11_COMPARE_LT_GT' => 204,
			'WORD' => 203
		},
		GOTOS => {
			'OpStringOrWord' => 415,
			'HashEntryProperties' => 417
		}
	},
	{#State 395
		DEFAULT => -87
	},
	{#State 396
		DEFAULT => -88
	},
	{#State 397
		ACTIONS => {
			'WORD' => 418
		}
	},
	{#State 398
		DEFAULT => -70
	},
	{#State 399
		ACTIONS => {
			";" => 419
		}
	},
	{#State 400
		ACTIONS => {
			";" => 420
		}
	},
	{#State 401
		DEFAULT => -240
	},
	{#State 402
		DEFAULT => -237
	},
	{#State 403
		DEFAULT => -255
	},
	{#State 404
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421
		}
	},
	{#State 405
		DEFAULT => -95
	},
	{#State 406
		DEFAULT => -184
	},
	{#State 407
		ACTIONS => {
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'WORD' => 28,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'FHREF_SYMBOL_IN' => 290,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'STDIN' => 292,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'Literal' => 111,
			'SubExpressionOrInput' => 422,
			'HashReference' => 91,
			'Expression' => 150,
			'SubExpression' => 291,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 408
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'ARGV' => 151,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP01_QW' => 159,
			'WORD' => 28,
			'LBRACKET' => 106,
			'MY' => 149,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139
		},
		GOTOS => {
			'TypeInner' => 152,
			'ArrayDereference' => 138,
			'ListElement' => 158,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'ListElements' => 423,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150
		}
	},
	{#State 409
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP01_NAMED_SCOLON' => 426,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD' => 28,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'LBRACKET' => 106,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 427,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'ArrayReference' => 112,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'OpNamedScolonOrSubExp' => 424,
			'SubExpression' => 425,
			'Operator' => 118,
			'Variable' => 157,
			'HashDereference' => 127,
			'ArrayDereference' => 138
		}
	},
	{#State 410
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'WORD' => 28,
			'OP01_NAMED' => 155,
			"\@{" => 109,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'SubExpression' => 428,
			'Expression' => 150,
			'HashReference' => 91,
			'Literal' => 111,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 138,
			'HashDereference' => 127,
			'Variable' => 157,
			'Operator' => 118
		}
	},
	{#State 411
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"foreach" => -165,
			"%{" => 104,
			'LBRACKET' => 106,
			'MY' => 108,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP01_NAMED_VOID' => 93,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_NUMBER' => 116,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED_SCOLON' => 115,
			"}" => 430,
			"\@{" => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"while" => -165,
			'LPAREN' => 126,
			'WORD' => 28,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'VARIABLE_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 120,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			"if" => 137,
			"for" => -165,
			'OP01_NAMED' => 133,
			'OP01_PRINT' => 134,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'Literal' => 111,
			'OPTIONAL-44' => 135,
			'ArrayReference' => 112,
			'Conditional' => 131,
			'SubExpression' => 129,
			'Operation' => 429,
			'Statement' => 141,
			'Operator' => 118,
			'PAREN-43' => 117,
			'ArrayDereference' => 138,
			'HashReference' => 91,
			'LoopLabel' => 90,
			'Expression' => 92,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'VariableModification' => 96,
			'Variable' => 128,
			'HashDereference' => 127,
			'OperatorVoid' => 107,
			'VariableDeclaration' => 102
		}
	},
	{#State 412
		DEFAULT => -187
	},
	{#State 413
		ACTIONS => {
			"for" => -176,
			'WORD_UPPERCASE' => -176,
			'OP01_NAMED' => -176,
			'OP01_PRINT' => -176,
			'OP01_OPEN' => -176,
			'OP05_MATH_NEG_LPAREN' => -176,
			"if" => -176,
			'WORD_SCOPED' => -176,
			'OP05_BITWISE_NEG_LPAREN' => -176,
			'' => -176,
			"undef" => -176,
			'LITERAL_STRING' => -176,
			'CONSTANT_CALL_SCOPED' => -176,
			'OP01_NAMED_VOID_SCOLON' => -176,
			'OP19_LOOP_CONTROL' => -176,
			'VARIABLE_SYMBOL' => -176,
			'LPAREN' => -176,
			'WORD' => -176,
			"}" => -176,
			"while" => -176,
			"\@{" => -176,
			'OP19_LOOP_CONTROL_SCOLON' => -176,
			'LITERAL_NUMBER' => -176,
			'LBRACE' => -176,
			'OP01_CLOSE' => -176,
			'OP01_NAMED_SCOLON' => -176,
			"else" => 433,
			'OP01_NAMED_VOID_LPAREN' => -176,
			'OP01_NAMED_VOID' => -176,
			'OP10_NAMED_UNARY_SCOLON' => -176,
			'OP10_NAMED_UNARY' => -176,
			'OP05_LOGICAL_NEG' => -176,
			'OP22_LOGICAL_NEG' => -176,
			"elsif" => 434,
			'SELF' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP22_LOGICAL_NEG_LPAREN' => -176,
			"%{" => -176,
			"foreach" => -176,
			'MY' => -176,
			'LBRACKET' => -176
		},
		GOTOS => {
			'PAREN-45' => 435,
			'PAREN-47' => 432,
			'OPTIONAL-48' => 431
		}
	},
	{#State 414
		ACTIONS => {
			'OP21_LIST_COMMA' => 436
		}
	},
	{#State 415
		ACTIONS => {
			'OP20_HASH_FATARROW' => 437
		}
	},
	{#State 416
		ACTIONS => {
			";" => 438
		}
	},
	{#State 417
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 439
		}
	},
	{#State 418
		ACTIONS => {
			'LBRACE' => 440
		}
	},
	{#State 419
		DEFAULT => -72
	},
	{#State 420
		ACTIONS => {
			'LBRACE' => -54,
			'OP01_CLOSE' => -54,
			'OP01_NAMED_SCOLON' => -54,
			'LITERAL_NUMBER' => -54,
			"while" => -54,
			"\@{" => -54,
			'OP19_LOOP_CONTROL_SCOLON' => -54,
			"}" => -54,
			"foreach" => -54,
			"%{" => -54,
			'OP22_LOGICAL_NEG_LPAREN' => -54,
			'MY' => -54,
			'LBRACKET' => -54,
			'SELF' => -54,
			'OP03_MATH_INC_DEC' => -54,
			'OP01_NAMED_VOID_LPAREN' => -54,
			'OP01_NAMED_VOID' => -54,
			'OP10_NAMED_UNARY_SCOLON' => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP22_LOGICAL_NEG' => -54,
			'OP05_LOGICAL_NEG' => -54,
			"if" => -54,
			'WORD_SCOPED' => -54,
			'OP05_MATH_NEG_LPAREN' => -54,
			'OP01_OPEN' => -54,
			'LPAREN_MY' => 441,
			'WORD_UPPERCASE' => -54,
			'OP01_NAMED' => -54,
			'OP01_PRINT' => -54,
			"for" => -54,
			'WORD' => -54,
			'LPAREN' => -54,
			'VARIABLE_SYMBOL' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP05_BITWISE_NEG_LPAREN' => -54,
			'LITERAL_STRING' => -54,
			"undef" => -54,
			'OP01_NAMED_VOID_SCOLON' => -54,
			'CONSTANT_CALL_SCOPED' => -54
		},
		GOTOS => {
			'OPTIONAL-22' => 442,
			'SubroutineArguments' => 443
		}
	},
	{#State 421
		ACTIONS => {
			"undef" => 444
		}
	},
	{#State 422
		ACTIONS => {
			")" => 445
		}
	},
	{#State 423
		ACTIONS => {
			")" => 446
		}
	},
	{#State 424
		ACTIONS => {
			'VARIABLE_SYMBOL' => 447
		}
	},
	{#State 425
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP16_LOGICAL_OR' => 234,
			";" => 448,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP08_STRING_CAT' => 227,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220
		}
	},
	{#State 426
		DEFAULT => -250
	},
	{#State 427
		DEFAULT => -251
	},
	{#State 428
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 449,
			'OP08_STRING_CAT' => 227,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 429
		DEFAULT => -186
	},
	{#State 430
		DEFAULT => -188
	},
	{#State 431
		DEFAULT => -177
	},
	{#State 432
		DEFAULT => -175
	},
	{#State 433
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 450
		}
	},
	{#State 434
		ACTIONS => {
			'LPAREN' => 451
		}
	},
	{#State 435
		DEFAULT => -172
	},
	{#State 436
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'LBRACKET' => 106,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 452,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Expression' => 150,
			'Literal' => 111,
			'HashReference' => 91,
			'ArrayDereference' => 138,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157
		}
	},
	{#State 437
		ACTIONS => {
			'MY' => 454
		},
		GOTOS => {
			'TypeInnerProperties' => 453
		}
	},
	{#State 438
		DEFAULT => -77
	},
	{#State 439
		ACTIONS => {
			"}" => 457,
			'OP21_LIST_COMMA' => 455
		},
		GOTOS => {
			'PAREN-31' => 456
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 458
		}
	},
	{#State 441
		ACTIONS => {
			'WORD' => 176,
			'WORD_SCOPED' => 177,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 459
		}
	},
	{#State 442
		DEFAULT => -56,
		GOTOS => {
			'STAR-23' => 460
		}
	},
	{#State 443
		DEFAULT => -53
	},
	{#State 444
		ACTIONS => {
			";" => 461
		}
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 446
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 463
		}
	},
	{#State 447
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 464
		}
	},
	{#State 448
		DEFAULT => -252
	},
	{#State 449
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'SubExpression' => 465,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'ArrayDereference' => 138,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157
		}
	},
	{#State 450
		DEFAULT => -174
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140,
			'LITERAL_NUMBER' => 116,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'WORD' => 28,
			"%{" => 104,
			'LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'SubExpression' => 466,
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138
		}
	},
	{#State 452
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			"]" => -96,
			'OP08_STRING_CAT' => 227,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			";" => -96,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			"}" => -96,
			'OP16_LOGICAL_OR' => 234
		}
	},
	{#State 453
		DEFAULT => -221
	},
	{#State 454
		ACTIONS => {
			'WORD_SCOPED' => 177,
			'WORD' => 176,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 467
		}
	},
	{#State 455
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 204,
			'WORD' => 203,
			'OP19_LOOP_CONTROL' => 200,
			'OP10_NAMED_UNARY' => 186,
			'OP22_LOGICAL_NEG' => 185,
			'OP23_LOGICAL_AND' => 202,
			'OP01_NAMED_VOID' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP01_CLOSE' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 198,
			'OP01_OPEN' => 209,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP01_NAMED' => 208,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP01_PRINT' => 207,
			'OP08_MATH_ADD_SUB' => 194
		},
		GOTOS => {
			'OpStringOrWord' => 415,
			'HashEntryProperties' => 468
		}
	},
	{#State 456
		DEFAULT => -74
	},
	{#State 457
		ACTIONS => {
			";" => 469
		}
	},
	{#State 458
		ACTIONS => {
			'MY' => 470
		}
	},
	{#State 459
		ACTIONS => {
			'VARIABLE_SYMBOL' => 471
		}
	},
	{#State 460
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"foreach" => -165,
			"%{" => 104,
			'MY' => 108,
			'LBRACKET' => 106,
			'OP01_NAMED_VOID' => 93,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'LITERAL_NUMBER' => 116,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP01_NAMED_SCOLON' => 115,
			"}" => 472,
			"\@{" => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"while" => -165,
			'LPAREN' => 126,
			'WORD' => 28,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'OP19_LOOP_CONTROL' => 120,
			'VARIABLE_SYMBOL' => 119,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'WORD_SCOPED' => 27,
			"if" => 137,
			"for" => -165,
			'OP01_PRINT' => 134,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'Statement' => 141,
			'PAREN-43' => 117,
			'Operator' => 118,
			'ArrayDereference' => 138,
			'Literal' => 111,
			'OPTIONAL-44' => 135,
			'ArrayReference' => 112,
			'Conditional' => 131,
			'Operation' => 473,
			'SubExpression' => 129,
			'Variable' => 128,
			'HashDereference' => 127,
			'OperatorVoid' => 107,
			'VariableDeclaration' => 102,
			'HashReference' => 91,
			'Expression' => 92,
			'LoopLabel' => 90,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'VariableModification' => 96
		}
	},
	{#State 461
		DEFAULT => -197
	},
	{#State 462
		DEFAULT => -185
	},
	{#State 463
		DEFAULT => -183
	},
	{#State 464
		ACTIONS => {
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP03_MATH_INC_DEC' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 427,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD' => 28,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED_SCOLON' => 426,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'SubExpression' => 425,
			'OpNamedScolonOrSubExp' => 474,
			'Literal' => 111,
			'Expression' => 150,
			'HashReference' => 91,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 465
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP16_LOGICAL_OR' => 234,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => -118,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 221,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => -118,
			'OP15_LOGICAL_AND' => 229,
			")" => 475,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 466
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222,
			")" => 476,
			'OP15_LOGICAL_AND' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221,
			'OP16_LOGICAL_OR' => 234,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_STRING_REPEAT' => 231,
			'OP04_MATH_POW' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233
		}
	},
	{#State 467
		ACTIONS => {
			"\$TYPED_" => 477
		}
	},
	{#State 468
		DEFAULT => -73
	},
	{#State 469
		DEFAULT => -76
	},
	{#State 470
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD' => 176,
			'TYPE_METHOD' => 478,
			'WORD_SCOPED' => 177
		},
		GOTOS => {
			'Type' => 327
		}
	},
	{#State 471
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 479
		}
	},
	{#State 472
		DEFAULT => -57
	},
	{#State 473
		DEFAULT => -55
	},
	{#State 474
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 156,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			"%{" => 104,
			'LPAREN' => 126,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 124,
			'LITERAL_STRING' => 123,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 121
		},
		GOTOS => {
			'SubExpression' => 480,
			'HashReference' => 91,
			'Literal' => 111,
			'Expression' => 150,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'VariableModification' => 482,
			'SubExpressionOrVarMod' => 481,
			'ArrayDereference' => 138,
			'Variable' => 128,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 475
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 483
		}
	},
	{#State 476
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 484
		}
	},
	{#State 477
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 200,
			'OP01_NAMED_VOID' => 188,
			'OP23_LOGICAL_AND' => 202,
			'OP22_LOGICAL_NEG' => 185,
			'OP10_NAMED_UNARY' => 186,
			'WORD' => 203,
			'OP11_COMPARE_LT_GT' => 204,
			'OP01_PRINT' => 207,
			'OP19_LOOP_CONTROL_SCOLON' => 190,
			'OP01_NAMED' => 208,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP08_MATH_ADD_SUB' => 194,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP01_CLOSE' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP01_OPEN' => 209,
			'OP07_STRING_REPEAT' => 198
		},
		GOTOS => {
			'OpStringOrWord' => 485
		}
	},
	{#State 478
		ACTIONS => {
			"\$RETURN_TYPE" => 486
		}
	},
	{#State 479
		ACTIONS => {
			'OP21_LIST_COMMA' => 488,
			")" => 487
		},
		GOTOS => {
			'PAREN-24' => 489
		}
	},
	{#State 480
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 229,
			")" => -161,
			'OP23_LOGICAL_AND' => 222,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => 221,
			'OP17_LIST_RANGE' => 220,
			'OP08_STRING_CAT' => 227,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP13_BITWISE_AND' => 226,
			'OP18_TERNARY' => 225,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231
		}
	},
	{#State 481
		ACTIONS => {
			")" => 490
		}
	},
	{#State 482
		DEFAULT => -162
	},
	{#State 483
		DEFAULT => -181
	},
	{#State 484
		DEFAULT => -171
	},
	{#State 485
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 492,
			'OP19_VARIABLE_ASSIGN' => 491
		}
	},
	{#State 486
		ACTIONS => {
			"}" => 493
		}
	},
	{#State 487
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 494
		}
	},
	{#State 488
		ACTIONS => {
			'MY' => 495
		}
	},
	{#State 489
		DEFAULT => -59
	},
	{#State 490
		ACTIONS => {
			'LBRACE' => 391
		},
		GOTOS => {
			'CodeBlock' => 496
		}
	},
	{#State 491
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 89,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'WORD' => 28,
			'LBRACKET' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LPAREN' => 126,
			"%{" => 104,
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140
		},
		GOTOS => {
			'Operator' => 118,
			'HashDereference' => 127,
			'Variable' => 157,
			'ArrayDereference' => 138,
			'ArrayReference' => 112,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 111,
			'HashReference' => 91,
			'Expression' => 150,
			'SubExpression' => 497
		}
	},
	{#State 492
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			"\@{" => 109,
			'OP01_NAMED' => 155,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'LITERAL_NUMBER' => 116,
			'OP05_MATH_NEG_LPAREN' => 140,
			'OP01_OPEN' => 139,
			'OP03_MATH_INC_DEC' => 89,
			'VARIABLE_SYMBOL' => 119,
			'SELF' => 88,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 125,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'WORD' => 28,
			'LBRACKET' => 106,
			'LPAREN' => 126,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105
		},
		GOTOS => {
			'SubExpression' => 498,
			'HashReference' => 91,
			'Expression' => 150,
			'Literal' => 111,
			'WordScoped' => 99,
			'VariableSymbolOrSelf' => 98,
			'ArrayReference' => 112,
			'ArrayDereference' => 138,
			'Variable' => 157,
			'HashDereference' => 127,
			'Operator' => 118
		}
	},
	{#State 493
		ACTIONS => {
			";" => 499
		}
	},
	{#State 494
		ACTIONS => {
			"\@ARG;" => 500
		}
	},
	{#State 495
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD' => 176,
			'WORD_SCOPED' => 177
		},
		GOTOS => {
			'Type' => 501
		}
	},
	{#State 496
		DEFAULT => -182
	},
	{#State 497
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233,
			"}" => -238,
			'OP16_LOGICAL_OR' => 234,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => 220,
			'OP11_COMPARE_LT_GT' => 221,
			'OP21_LIST_COMMA' => -238,
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222,
			'OP15_LOGICAL_AND' => 229,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 498
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP23_LOGICAL_AND' => 222,
			'OP15_LOGICAL_AND' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 227,
			'OP17_LIST_RANGE' => 220,
			"]" => 502,
			'OP11_COMPARE_LT_GT' => 221,
			'OP16_LOGICAL_OR' => 234,
			'OP08_MATH_ADD_SUB' => 235,
			'OP14_BITWISE_OR_XOR' => 224,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP18_TERNARY' => 225,
			'OP13_BITWISE_AND' => 226,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 232,
			'OP24_LOGICAL_OR_XOR' => 233
		}
	},
	{#State 499
		ACTIONS => {
			'LPAREN' => -79,
			'WORD' => -79,
			'OP01_NAMED_VOID_SCOLON' => -79,
			"undef" => -79,
			'CONSTANT_CALL_SCOPED' => -79,
			'LITERAL_STRING' => -79,
			'OP05_BITWISE_NEG_LPAREN' => -79,
			'VARIABLE_SYMBOL' => -79,
			'OP19_LOOP_CONTROL' => -79,
			'OP05_MATH_NEG_LPAREN' => -79,
			'OP01_OPEN' => -79,
			'LPAREN_MY' => 503,
			'WORD_SCOPED' => -79,
			"if" => -79,
			"for" => -79,
			'OP01_PRINT' => -79,
			'OP01_NAMED' => -79,
			'WORD_UPPERCASE' => -79,
			'OP22_LOGICAL_NEG_LPAREN' => -79,
			"%{" => -79,
			"foreach" => -79,
			'MY' => -79,
			'LBRACKET' => -79,
			'OP01_NAMED_VOID' => -79,
			'OP01_NAMED_VOID_LPAREN' => -79,
			'OP22_LOGICAL_NEG' => -79,
			'OP05_LOGICAL_NEG' => -79,
			'OP10_NAMED_UNARY' => -79,
			'OP10_NAMED_UNARY_SCOLON' => -79,
			'SELF' => -79,
			'OP03_MATH_INC_DEC' => -79,
			'LITERAL_NUMBER' => -79,
			'OP01_CLOSE' => -79,
			'LBRACE' => -79,
			'OP01_NAMED_SCOLON' => -79,
			"}" => -79,
			"\@{" => -79,
			'OP19_LOOP_CONTROL_SCOLON' => -79,
			"while" => -79
		},
		GOTOS => {
			'MethodArguments' => 505,
			'OPTIONAL-33' => 504
		}
	},
	{#State 500
		DEFAULT => -61
	},
	{#State 501
		ACTIONS => {
			'VARIABLE_SYMBOL' => 506
		}
	},
	{#State 502
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 507
		}
	},
	{#State 503
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD' => 176,
			'WORD_SCOPED' => 177
		},
		GOTOS => {
			'Type' => 508
		}
	},
	{#State 504
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 509
		}
	},
	{#State 505
		DEFAULT => -78
	},
	{#State 506
		DEFAULT => -58
	},
	{#State 507
		ACTIONS => {
			"undef" => 510
		}
	},
	{#State 508
		ACTIONS => {
			'SELF' => 511
		}
	},
	{#State 509
		ACTIONS => {
			'SELF' => 88,
			'OP03_MATH_INC_DEC' => 89,
			'OP01_NAMED_VOID' => 93,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 95,
			"foreach" => -165,
			"%{" => 104,
			'OP22_LOGICAL_NEG_LPAREN' => 105,
			'LBRACKET' => 106,
			'MY' => 108,
			"\@{" => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"while" => -165,
			"}" => 512,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'OP01_NAMED_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'OP19_LOOP_CONTROL' => 120,
			'VARIABLE_SYMBOL' => 119,
			'LITERAL_STRING' => 123,
			"undef" => 124,
			'CONSTANT_CALL_SCOPED' => 125,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP05_BITWISE_NEG_LPAREN' => 121,
			'WORD' => 28,
			'LPAREN' => 126,
			'OP01_PRINT' => 134,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			"for" => -165,
			'WORD_SCOPED' => 27,
			"if" => 137,
			'OP01_OPEN' => 139,
			'OP05_MATH_NEG_LPAREN' => 140
		},
		GOTOS => {
			'Expression' => 92,
			'LoopLabel' => 90,
			'HashReference' => 91,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 99,
			'VariableModification' => 96,
			'VariableDeclaration' => 102,
			'Variable' => 128,
			'HashDereference' => 127,
			'OperatorVoid' => 107,
			'Conditional' => 131,
			'Operation' => 513,
			'SubExpression' => 129,
			'Literal' => 111,
			'OPTIONAL-44' => 135,
			'ArrayReference' => 112,
			'ArrayDereference' => 138,
			'Statement' => 141,
			'PAREN-43' => 117,
			'Operator' => 118
		}
	},
	{#State 510
		DEFAULT => -239
	},
	{#State 511
		DEFAULT => -85,
		GOTOS => {
			'STAR-36' => 514
		}
	},
	{#State 512
		DEFAULT => -82
	},
	{#State 513
		DEFAULT => -80
	},
	{#State 514
		ACTIONS => {
			")" => 515,
			'OP21_LIST_COMMA' => 517
		},
		GOTOS => {
			'PAREN-35' => 516
		}
	},
	{#State 515
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 518
		}
	},
	{#State 516
		DEFAULT => -84
	},
	{#State 517
		ACTIONS => {
			'MY' => 519
		}
	},
	{#State 518
		ACTIONS => {
			"\@ARG;" => 520
		}
	},
	{#State 519
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 177,
			'WORD' => 176
		},
		GOTOS => {
			'Type' => 521
		}
	},
	{#State 520
		DEFAULT => -86
	},
	{#State 521
		ACTIONS => {
			'VARIABLE_SYMBOL' => 522
		}
	},
	{#State 522
		DEFAULT => -83
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7379 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7393 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7435 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7446 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7485 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7577 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7613 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7620 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7652 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7659 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule Include_50
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7702 lib/RPerl/Grammar.pm
	],
	[#Rule Include_51
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7713 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_52
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 4,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_61
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7802 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7830 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule Class_72
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7890 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_76
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_77
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7926 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7947 lib/RPerl/Grammar.pm
	],
	[#Rule Method_82
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7958 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 4,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7979 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_86
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7990 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_87
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8001 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_88
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8012 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_89
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8023 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_90
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8034 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8045 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_92
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8056 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8067 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8078 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8089 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8100 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8111 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8122 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8133 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8144 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8155 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8166 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8177 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8188 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8199 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8210 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8221 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8232 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8243 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8254 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8265 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8276 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8287 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8298 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8309 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8320 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8331 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8342 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8353 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8364 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8375 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8386 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8397 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8404 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8411 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8418 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8432 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8443 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8454 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8465 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_132
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8476 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_133
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8487 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8498 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8509 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8520 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8527 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8555 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8562 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8573 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8584 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8595 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8606 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8617 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8628 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_149
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8639 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_150
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8650 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_151
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8661 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_152
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8672 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_153
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8683 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_154
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8694 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8705 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8716 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8727 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_158
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8738 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_159
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8749 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_160
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8760 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_161
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8771 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_162
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8782 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8796 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8803 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_166
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8814 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_167
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8825 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_168
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8836 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_169
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8847 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_170
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8858 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 5,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8865 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8879 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8886 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8893 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8900 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_177
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8911 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_178
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8922 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_179
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8933 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_180
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8944 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_181
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8955 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_182
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8966 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_183
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8977 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_184
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8988 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_185
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8999 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9006 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_188
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9031 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9038 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_191
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9049 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_192
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9060 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_193
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9071 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_194
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9082 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_195
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9093 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_196
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9104 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_197
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9115 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_198
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9126 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_199
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9137 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_200
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9148 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9169 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_204
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9180 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_205
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9191 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_206
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9202 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_207
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9213 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_208
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9224 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9231 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9238 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_211
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9256 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9263 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_214
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9274 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_215
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9285 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9292 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9299 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_218
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9310 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_219
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9321 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_220
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9332 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_221
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9343 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 265 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9350 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 265 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9357 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 265 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9364 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_225
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9375 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_226
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9386 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 266 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9393 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 266 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9400 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_229
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9411 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_230
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9422 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_231
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9433 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_232
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9444 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_233
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9455 lib/RPerl/Grammar.pm
	],
	[#Rule Type_234
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9466 lib/RPerl/Grammar.pm
	],
	[#Rule Type_235
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9477 lib/RPerl/Grammar.pm
	],
	[#Rule Type_236
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9488 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_237
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9499 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_238
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9510 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_239
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9521 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_240
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9532 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_241
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9543 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_242
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9554 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_243
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9565 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_244
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9576 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_245
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9587 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_246
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9598 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_247
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9609 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_248
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9620 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_249
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9631 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_250
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9642 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_251
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9653 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_252
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9664 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_253
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9675 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_254
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9686 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_255
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9697 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9708 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9719 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9730 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_259
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9741 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_260
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9752 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_261
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9763 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9774 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9785 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9796 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9807 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9818 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9829 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9840 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9851 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9862 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9873 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9884 lib/RPerl/Grammar.pm
	]
],
#line 9887 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_36', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Header_39', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_42', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Exports_49', 
         'Include_50', 
         'Include_51', 
         'Constant_52', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_57', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_61', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_72', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_76', 
         'Properties_77', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_82', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_86', 
         'SubroutineOrMethod_87', 
         'SubroutineOrMethod_88', 
         'Operation_89', 
         'Operation_90', 
         'Operation_91', 
         'Operation_92', 
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
         'Operator_113', 
         'Operator_114', 
         'Operator_115', 
         'Operator_116', 
         'Operator_117', 
         'Operator_118', 
         'Operator_119', 
         'Operator_120', 
         'Operator_121', 
         'Operator_122', 
         'Operator_123', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         'OperatorVoid_131', 
         'OperatorVoid_132', 
         'OperatorVoid_133', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'Expression_148', 
         'SubExpression_149', 
         'SubExpression_150', 
         'SubExpression_151', 
         'SubExpression_152', 
         'SubExpression_153', 
         'SubExpression_154', 
         'SubExpression_155', 
         'SubExpression_156', 
         'SubExpression_157', 
         'SubExpressionOrInput_158', 
         'SubExpressionOrInput_159', 
         'SubExpressionOrInput_160', 
         'SubExpressionOrVarMod_161', 
         'SubExpressionOrVarMod_162', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_166', 
         'Statement_167', 
         'Statement_168', 
         'Statement_169', 
         'Statement_170', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_177', 
         'Loop_178', 
         'Loop_179', 
         'Loop_180', 
         'LoopFor_181', 
         'LoopFor_182', 
         'LoopForEach_183', 
         'LoopWhile_184', 
         'LoopWhile_185', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_188', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_191', 
         'VariableRetrieval_192', 
         'VariableRetrieval_193', 
         'VariableRetrieval_194', 
         'VariableDeclaration_195', 
         'VariableDeclaration_196', 
         'VariableDeclaration_197', 
         'VariableDeclaration_198', 
         'VariableModification_199', 
         'VariableModification_200', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_204', 
         'ListElement_205', 
         'ListElement_206', 
         'ListElement_207', 
         'ListElement_208', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_211', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_214', 
         'ArrayDereference_215', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_218', 
         'HashEntry_219', 
         'HashEntry_220', 
         'HashEntryProperties_221', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_225', 
         'HashReference_226', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_229', 
         'HashDereference_230', 
         'WordScoped_231', 
         'WordScoped_232', 
         'LoopLabel_233', 
         'Type_234', 
         'Type_235', 
         'Type_236', 
         'TypeInner_237', 
         'TypeInnerProperties_238', 
         'TypeInnerProperties_239', 
         'TypeInnerConstant_240', 
         'VariableOrLiteral_241', 
         'VariableOrLiteral_242', 
         'VarOrLitOrOpStrOrWord_243', 
         'VarOrLitOrOpStrOrWord_244', 
         'VarOrLitOrOpStrOrWord_245', 
         'VariableSymbolOrSelf_246', 
         'VariableSymbolOrSelf_247', 
         'Literal_248', 
         'Literal_249', 
         'OpNamedScolonOrSubExp_250', 
         'OpNamedScolonOrSubExp_251', 
         'OpNamedScolonOrSubExp_252', 
         'OpNamedScolonOrSubExpIn_253', 
         'OpNamedScolonOrSubExpIn_254', 
         'OpNamedScolonOrSubExpIn_255', 
         'OpStringOrWord_256', 
         'OpStringOrWord_257', 
         'OpStringOrWord_258', 
         'OpStringOrWord_259', 
         'OpStringOrWord_260', 
         'OpStringOrWord_261', 
         'OpStringOrWord_262', 
         'OpStringOrWord_263', 
         'OpStringOrWord_264', 
         'OpStringOrWord_265', 
         'OpStringOrWord_266', 
         'OpStringOrWord_267', 
         'OpStringOrWord_268', 
         'OpStringOrWord_269', 
         'OpStringOrWord_270', 
         'OpStringOrWord_271', 
         'OpStringOrWord_272', );
  $self;
}

#line 287 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1.  Update grammar code in this file, above this line only
# 2.  Run `script/development/grammar_recompile.sh`
# 3.  Run `perl t/12_parse.t` for new & existing grammar parse-only tests, if errors goto step 1
# 4.  Inspect updates from Grammar.output file, note starting & finishing & increment/decrement numbers if any rule numbers have changed
# 5a. Run `script/development/grammar_increment.pl START FINISH INCREMENT` if rules added from step 4, repeat if needed
# 5b. Run `script/development/grammar_decrement.pl START FINISH DECREMENT` if rules deleted from step 4, repeat if needed
# 6.  Copy updates from Grammar.output file into this file with now-unique numbers, below this line only, if not-automatically-generated rules have been added
# 7.  Run `script/development/grammar_recompile.sh` again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',                             # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',                              # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG OPTIONAL-3 USE_RPERL Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_23 => 'RPerl::CompileUnit::Module::Header',                    # ModuleHeader -> OPTIONAL-9 OPTIONAL-10 'package' WordScoped ';' Header
Module_24 => 'RPerl::CompileUnit::Module::Package',                         # Module -> Package
Module_25 => 'RPerl::CompileUnit::Module::Class::Generator',                # Module -> Class
Package_36 => 'RPerl::CompileUnit::Module::Package',                        # Package -> STAR-11 OPTIONAL-12 STAR-13 STAR-14 PLUS-15 LITERAL_NUMBER ';'
Header_39 => 'RPerl::NonGenerator',                                         # Header -> 'use strict;' 'use warnings;' OPTIONAL-16 'our' VERSION_NUMBER_ASSIGN
Critic_42 => 'RPerl::CompileUnit::Critic',                                  # Critic -> '## no critic qw(' PLUS-17 ')'
Exports_49 => 'RPerl::CompileUnit::Exports',                                # Exports -> USE_EXPORTER OPTIONAL-19 OPTIONAL-21
Include_50 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped ';'
Include_51 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OP01_QW ';'
Constant_52 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_57 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> SUB WORD LBRACE LBRACE MY Type '$RETURN_TYPE' '}' ';' OPTIONAL-22 STAR-23 '}'
SubroutineArguments_61 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-25 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_72 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-26 OPTIONAL-27 STAR-28 STAR-29 Properties STAR-30 LITERAL_NUMBER ';'
Properties_76 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-32 '}' ';'
Properties_77 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_82 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> SUB WORD LBRACE LBRACE MY TYPE_METHOD '$RETURN_TYPE' '}' ';' OPTIONAL-33 STAR-34 '}'
MethodArguments_86 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY Type SELF STAR-36 ')' OP19_VARIABLE_ASSIGN '@ARG;'
SubroutineOrMethod_87 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_88 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
Operation_89 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_90 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_91 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_92 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_93 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_94 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_96 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_98 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_99 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_100 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_102 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_104 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
Operator_105 => 'RPerl::Operation::Expression::Operator::String::Repeat',                    # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo',  # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract',           # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_108 => 'RPerl::Operation::Expression::Operator::String::Concatenate',               # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                    # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_110 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY SubExpression
Operator_111 => 'RPerl::Operation::Expression::Operator::NamedUnary',                       # Operator -> OP10_NAMED_UNARY
Operator_112 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',     # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_113 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',           # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_114 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                     # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_115 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                   # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_116 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_117 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_118 => 'RPerl::Operation::Expression::Operator::List::Range',                      # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_119 => 'RPerl::Operation::Expression::Operator::Ternary',                          # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_120 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
Operator_121 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_122 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_123 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_129 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_130 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_131 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_132 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_133 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_134 => 'RPerl::Operation::Expression::Operator::Named',                        # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_135 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_136 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_143 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_144 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_145 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_146 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-40 ')'
Expression_147 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-41 ')'
Expression_148 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-42 ')'
SubExpression_149 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_150 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_151 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_152 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_153 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_154 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_155 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_156 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_157 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_158 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_159 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_160 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_161 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_162 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_166 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_167 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-44 Loop
Statement_168 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_169 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_170 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_177 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-46 OPTIONAL-48
Loop_178 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_179 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_180 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_181 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_182 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_183 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_184 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_185 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_188 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-49 '}'
Variable_191 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-50
VariableRetrieval_192 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_193 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_194 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_195 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_196 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_197 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_198 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_199 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_200 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_204 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-52
ListElement_205 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_206 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_207 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_208 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_211 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-53 ']'
ArrayDereference_214 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_215 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-54 ArrayReference '}'
HashEntry_218 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
HashEntry_219 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_220 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_221 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_225 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-57 '}'
HashReference_226 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_229 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_230 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-58 HashReference '}'
WordScoped_231 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_232 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_233 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_234 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_235 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_236 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_237 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_238 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_239 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_240 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_241 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_242 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_243 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_244 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_245 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_246 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_247 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_248 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_249 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_250 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_251 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_252 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_253 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_254 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_255 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_258 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_259 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_260 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_261 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_262 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_263 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_264 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_265 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_266 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_267 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_268 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_269 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_270 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_271 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_272 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 10373 lib/RPerl/Grammar.pm



1;
