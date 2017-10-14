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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|package|foreach|\$TYPED_|undef|while|\@ARG\;|elsif|else|for|our|if|\@\{|\%\{|\]|\)|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(\s*use\s+RPerl::Exporter\s+qw\(\s*import\s*\)\s*;\s*)/gc and return ('USE_EXPORTER', $1);
      /\G(use\s+)/gc and return ('USE', $1);
      /\G(\s*our\s+\@EXPORT\s+\=\s*)/gc and return ('OUR_EXPORT', $1);
      /\G(\s*our\s+\@EXPORT_OK\s+\=\s*)/gc and return ('OUR_EXPORT_OK', $1);
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


#line 153 lib/RPerl/Grammar.pm

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
  [ 'Header_39' => 'Header', [ 'use strict;', 'use warnings;', 'OPTIONAL-16', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
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
  [ 'Operator_120' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'OperatorVoid_128' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-38', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_131' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-39', ')', ';' ], 0 ],
  [ 'OperatorVoid_132' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_133' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-40', ')' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-41', ')' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-42', ')' ], 0 ],
  [ 'SubExpression_148' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_149' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_150' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_151' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_152' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_153' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_154' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_157' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_158' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_159' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_160' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_161' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'PAREN-43' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Statement_165' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_166' => 'Statement', [ 'OPTIONAL-44', 'Loop' ], 0 ],
  [ 'Statement_167' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_168' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_169' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Conditional_176' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-46', 'OPTIONAL-48' ], 0 ],
  [ 'Loop_177' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_178' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_179' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_180' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_181' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_182' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_183' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_184' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'PLUS-49', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'Operation' ], 0 ],
  [ 'CodeBlock_187' => 'CodeBlock', [ 'LBRACE', 'PLUS-49', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'Variable_190' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-50' ], 0 ],
  [ 'VariableRetrieval_191' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_192' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_193' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_194' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_195' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_196' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_197' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_198' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_199' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'ListElements_203' => 'ListElements', [ 'ListElement', 'STAR-52' ], 0 ],
  [ 'ListElement_204' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_205' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_206' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_207' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [  ], 0 ],
  [ 'ArrayReference_210' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-53', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'ArrayDereference_213' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_214' => 'ArrayDereference', [ '@{', 'OPTIONAL-54', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'HashEntry_217' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-55', 'SubExpression' ], 0 ],
  [ 'HashEntry_218' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_219' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_220' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-56', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [ 'STAR-57', 'PAREN-56' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [  ], 0 ],
  [ 'HashReference_224' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-57', '}' ], 0 ],
  [ 'HashReference_225' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'HashDereference_228' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_229' => 'HashDereference', [ '%{', 'OPTIONAL-58', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_230' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_231' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_232' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_233' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_234' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_235' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_236' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_237' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_238' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_239' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_240' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_241' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_242' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_243' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_244' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_245' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_246' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_247' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_248' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_249' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_250' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_251' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_252' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_253' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_254' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_259' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_260' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_261' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_262' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PAREN' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  'OperatorVoid_128' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  'OperatorVoid_131' => 131,
  'OperatorVoid_132' => 132,
  'OperatorVoid_133' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  '_OPTIONAL' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  '_OPTIONAL' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'SubExpression_148' => 148,
  'SubExpression_149' => 149,
  'SubExpression_150' => 150,
  'SubExpression_151' => 151,
  'SubExpression_152' => 152,
  'SubExpression_153' => 153,
  'SubExpression_154' => 154,
  'SubExpression_155' => 155,
  'SubExpression_156' => 156,
  'SubExpressionOrInput_157' => 157,
  'SubExpressionOrInput_158' => 158,
  'SubExpressionOrInput_159' => 159,
  'SubExpressionOrVarMod_160' => 160,
  'SubExpressionOrVarMod_161' => 161,
  '_PAREN' => 162,
  '_OPTIONAL' => 163,
  '_OPTIONAL' => 164,
  'Statement_165' => 165,
  'Statement_166' => 166,
  'Statement_167' => 167,
  'Statement_168' => 168,
  'Statement_169' => 169,
  '_PAREN' => 170,
  '_STAR_LIST' => 171,
  '_STAR_LIST' => 172,
  '_PAREN' => 173,
  '_OPTIONAL' => 174,
  '_OPTIONAL' => 175,
  'Conditional_176' => 176,
  'Loop_177' => 177,
  'Loop_178' => 178,
  'Loop_179' => 179,
  'LoopFor_180' => 180,
  'LoopFor_181' => 181,
  'LoopForEach_182' => 182,
  'LoopWhile_183' => 183,
  'LoopWhile_184' => 184,
  '_PLUS_LIST' => 185,
  '_PLUS_LIST' => 186,
  'CodeBlock_187' => 187,
  '_STAR_LIST' => 188,
  '_STAR_LIST' => 189,
  'Variable_190' => 190,
  'VariableRetrieval_191' => 191,
  'VariableRetrieval_192' => 192,
  'VariableRetrieval_193' => 193,
  'VariableDeclaration_194' => 194,
  'VariableDeclaration_195' => 195,
  'VariableDeclaration_196' => 196,
  'VariableDeclaration_197' => 197,
  'VariableModification_198' => 198,
  'VariableModification_199' => 199,
  '_PAREN' => 200,
  '_STAR_LIST' => 201,
  '_STAR_LIST' => 202,
  'ListElements_203' => 203,
  'ListElement_204' => 204,
  'ListElement_205' => 205,
  'ListElement_206' => 206,
  'ListElement_207' => 207,
  '_OPTIONAL' => 208,
  '_OPTIONAL' => 209,
  'ArrayReference_210' => 210,
  '_OPTIONAL' => 211,
  '_OPTIONAL' => 212,
  'ArrayDereference_213' => 213,
  'ArrayDereference_214' => 214,
  '_OPTIONAL' => 215,
  '_OPTIONAL' => 216,
  'HashEntry_217' => 217,
  'HashEntry_218' => 218,
  'HashEntry_219' => 219,
  'HashEntryProperties_220' => 220,
  '_PAREN' => 221,
  '_STAR_LIST' => 222,
  '_STAR_LIST' => 223,
  'HashReference_224' => 224,
  'HashReference_225' => 225,
  '_OPTIONAL' => 226,
  '_OPTIONAL' => 227,
  'HashDereference_228' => 228,
  'HashDereference_229' => 229,
  'WordScoped_230' => 230,
  'WordScoped_231' => 231,
  'LoopLabel_232' => 232,
  'Type_233' => 233,
  'Type_234' => 234,
  'Type_235' => 235,
  'TypeInner_236' => 236,
  'TypeInnerProperties_237' => 237,
  'TypeInnerProperties_238' => 238,
  'TypeInnerConstant_239' => 239,
  'VariableOrLiteral_240' => 240,
  'VariableOrLiteral_241' => 241,
  'VarOrLitOrOpStrOrWord_242' => 242,
  'VarOrLitOrOpStrOrWord_243' => 243,
  'VarOrLitOrOpStrOrWord_244' => 244,
  'VariableSymbolOrSelf_245' => 245,
  'VariableSymbolOrSelf_246' => 246,
  'Literal_247' => 247,
  'Literal_248' => 248,
  'OpNamedScolonOrSubExp_249' => 249,
  'OpNamedScolonOrSubExp_250' => 250,
  'OpNamedScolonOrSubExp_251' => 251,
  'OpNamedScolonOrSubExpIn_252' => 252,
  'OpNamedScolonOrSubExpIn_253' => 253,
  'OpNamedScolonOrSubExpIn_254' => 254,
  'OpStringOrWord_255' => 255,
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
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 4,
			"## no critic qw(" => 6,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Program' => 1,
			'CompileUnit' => 2,
			'Critic' => 3,
			'PLUS-2' => 7,
			'PAREN-1' => 5,
			'ModuleHeader' => 9,
			'OPTIONAL-9' => 8
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'' => 10
		}
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-17' => 14
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 3,
			'PAREN-1' => 15,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 9
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 16
		},
		GOTOS => {
			'OPTIONAL-10' => 17
		}
	},
	{#State 9
		ACTIONS => {
			'USE' => -27,
			"use parent qw(" => 18,
			"use constant" => -27,
			'USE_EXPORTER' => -27,
			'SUB' => -27,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'Module' => 20,
			'STAR-11' => 22,
			'Class' => 19,
			'Package' => 21
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		ACTIONS => {
			'USE_RPERL' => 23
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -41
	},
	{#State 14
		ACTIONS => {
			'WORD' => 25,
			")" => 24
		}
	},
	{#State 15
		DEFAULT => -2
	},
	{#State 16
		DEFAULT => -21
	},
	{#State 17
		ACTIONS => {
			"package" => 26
		}
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		DEFAULT => -24
	},
	{#State 22
		ACTIONS => {
			"## no critic qw(" => 6,
			'SUB' => -29,
			'USE_EXPORTER' => 32,
			"use constant" => -29,
			'USE' => -29
		},
		GOTOS => {
			'Critic' => 33,
			'OPTIONAL-12' => 31,
			'Exports' => 30
		}
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
		DEFAULT => -42
	},
	{#State 25
		DEFAULT => -40
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
		DEFAULT => -231
	},
	{#State 28
		DEFAULT => -230
	},
	{#State 29
		ACTIONS => {
			")" => 37
		}
	},
	{#State 30
		DEFAULT => -28
	},
	{#State 31
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use constant" => -45,
			'OUR_EXPORT' => 39,
			"our hashref \$properties" => -45,
			'OUR_EXPORT_OK' => -45,
			'USE' => -45,
			'SUB' => -45
		},
		GOTOS => {
			'OPTIONAL-19' => 40,
			'PAREN-18' => 41
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
			"use constant" => -33,
			'USE' => 46,
			'SUB' => -33
		},
		GOTOS => {
			'Include' => 48,
			'STAR-14' => 47
		}
	},
	{#State 39
		ACTIONS => {
			'OP01_QW' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'SUB' => -48,
			"our hashref \$properties" => -48,
			'USE' => -48,
			'OUR_EXPORT_OK' => 51,
			"use constant" => -48
		},
		GOTOS => {
			'PAREN-20' => 52,
			'OPTIONAL-21' => 50
		}
	},
	{#State 41
		DEFAULT => -44
	},
	{#State 42
		ACTIONS => {
			"our" => -38,
			'USE_RPERL_AFTER' => 54
		},
		GOTOS => {
			'OPTIONAL-16' => 53
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID' => -11,
			"while" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"%{" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"for" => -11,
			"\@{" => -11,
			'OP10_NAMED_UNARY' => -11,
			'SUB' => -11,
			'LBRACE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'WORD' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_NUMBER' => -11,
			"foreach" => -11,
			"use constant" => -11,
			'LPAREN' => -11,
			'MY' => -11,
			'USE' => -11,
			'WORD_SCOPED' => -11,
			'LBRACKET' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'SELF' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			"## no critic qw(" => 6,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP01_NAMED' => -11,
			'LITERAL_STRING' => -11,
			"undef" => -11
		},
		GOTOS => {
			'Critic' => 55,
			'STAR-5' => 56
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
			'USE' => 46
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 59
		}
	},
	{#State 47
		ACTIONS => {
			"use constant" => 63,
			'SUB' => 61
		},
		GOTOS => {
			'Subroutine' => 64,
			'PLUS-15' => 62,
			'Constant' => 60
		}
	},
	{#State 48
		DEFAULT => -30
	},
	{#State 49
		ACTIONS => {
			";" => 65
		}
	},
	{#State 50
		DEFAULT => -49
	},
	{#State 51
		ACTIONS => {
			'OP01_QW' => 66
		}
	},
	{#State 52
		DEFAULT => -47
	},
	{#State 53
		ACTIONS => {
			"our" => 67
		}
	},
	{#State 54
		DEFAULT => -37
	},
	{#State 55
		DEFAULT => -8
	},
	{#State 56
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -13,
			"for" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"%{" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID' => -13,
			"while" => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'WORD' => -13,
			'VARIABLE_SYMBOL' => -13,
			'SUB' => -13,
			'LBRACE' => -13,
			"\@{" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LPAREN' => -13,
			'MY' => -13,
			'USE' => 46,
			"foreach" => -13,
			"use constant" => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_SCOPED' => -13,
			'SELF' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LBRACKET' => -13,
			'OP01_CLOSE' => -13,
			"if" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"undef" => -13,
			'LITERAL_STRING' => -13
		},
		GOTOS => {
			'Include' => 68,
			'STAR-6' => 69
		}
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
			'OP01_QW' => 72,
			";" => 71
		}
	},
	{#State 60
		DEFAULT => -32
	},
	{#State 61
		ACTIONS => {
			'WORD' => 73
		}
	},
	{#State 62
		ACTIONS => {
			'SUB' => 61,
			'LITERAL_NUMBER' => 74
		},
		GOTOS => {
			'Subroutine' => 75
		}
	},
	{#State 63
		ACTIONS => {
			'WORD_UPPERCASE' => 76
		}
	},
	{#State 64
		DEFAULT => -35
	},
	{#State 65
		DEFAULT => -43
	},
	{#State 66
		ACTIONS => {
			";" => 77
		}
	},
	{#State 67
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 78
		}
	},
	{#State 68
		DEFAULT => -10
	},
	{#State 69
		ACTIONS => {
			"foreach" => -15,
			"use constant" => 63,
			'LPAREN' => -15,
			'MY' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_SCOPED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"%{" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"for" => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD_UPPERCASE' => -15,
			"while" => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD' => -15,
			"\@{" => -15,
			'OP10_NAMED_UNARY' => -15,
			'SUB' => -15,
			'LBRACE' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			"undef" => -15,
			'OP01_NAMED_SCOLON' => -15,
			'SELF' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_OPEN' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"if" => -15
		},
		GOTOS => {
			'Constant' => 79,
			'STAR-7' => 80
		}
	},
	{#State 70
		ACTIONS => {
			'USE_EXPORTER' => 32,
			"## no critic qw(" => 6,
			"our hashref \$properties" => -65,
			'USE' => -65,
			"use constant" => -65
		},
		GOTOS => {
			'OPTIONAL-27' => 81,
			'Exports' => 82,
			'Critic' => 83
		}
	},
	{#State 71
		DEFAULT => -50
	},
	{#State 72
		ACTIONS => {
			";" => 84
		}
	},
	{#State 73
		ACTIONS => {
			'LBRACE' => 85
		}
	},
	{#State 74
		ACTIONS => {
			";" => 86
		}
	},
	{#State 75
		DEFAULT => -34
	},
	{#State 76
		ACTIONS => {
			'OP20_HASH_FATARROW' => 87
		}
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
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			"if" => 115,
			'OP01_NAMED_SCOLON' => 123,
			'SELF' => 127,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'LBRACKET' => 117,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 121,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP01_PRINT' => 134,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_NAMED' => 139,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'SUB' => 61,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			"for" => -164,
			'WORD_UPPERCASE' => 96,
			'OP01_NAMED_VOID' => 97,
			"while" => -164,
			'WORD_SCOPED' => 27,
			"foreach" => -164,
			'LPAREN' => 110,
			'MY' => 111,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'HashReference' => 95,
			'PAREN-43' => 92,
			'VariableDeclaration' => 91,
			'VariableModification' => 124,
			'Subroutine' => 125,
			'Operator' => 99,
			'OPTIONAL-44' => 126,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 105,
			'PLUS-8' => 98,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'Literal' => 130,
			'OperatorVoid' => 132,
			'Conditional' => 108,
			'LoopLabel' => 106,
			'Variable' => 136,
			'SubExpression' => 135,
			'ArrayReference' => 138,
			'Statement' => 112,
			'Operation' => 140
		}
	},
	{#State 81
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 141
		}
	},
	{#State 82
		DEFAULT => -64
	},
	{#State 83
		DEFAULT => -62
	},
	{#State 84
		DEFAULT => -51
	},
	{#State 85
		ACTIONS => {
			'LBRACE' => 142
		}
	},
	{#State 86
		DEFAULT => -36
	},
	{#State 87
		ACTIONS => {
			'MY' => 143
		},
		GOTOS => {
			'TypeInnerConstant' => 144
		}
	},
	{#State 88
		ACTIONS => {
			'LBRACKET' => -212,
			'MY' => 146,
			'VARIABLE_SYMBOL' => 94,
			'SELF' => 127
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 104,
			'OPTIONAL-54' => 147,
			'Variable' => 145,
			'TypeInner' => 148
		}
	},
	{#State 89
		ACTIONS => {
			'OP04_MATH_POW' => -111,
			"%{" => 101,
			"]" => -111,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 152,
			'OP13_BITWISE_AND' => -111,
			'OP18_TERNARY' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP06_REGEX_BIND' => -111,
			'VARIABLE_SYMBOL' => 94,
			'OP14_BITWISE_OR_XOR' => -111,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP16_LOGICAL_OR' => -111,
			'OP08_STRING_CAT' => -111,
			'LBRACE' => 90,
			'LPAREN' => 110,
			'LITERAL_NUMBER' => 109,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			";" => -111,
			"}" => -111,
			'WORD_SCOPED' => 27,
			'OP24_LOGICAL_OR_XOR' => -111,
			'SELF' => 127,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP11_COMPARE_LT_GT' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP01_NAMED' => 149,
			'OP22_LOGICAL_NEG' => 133,
			'OP15_LOGICAL_AND' => -111,
			'LITERAL_STRING' => 129,
			")" => -111,
			"undef" => 131,
			'OP09_BITWISE_SHIFT' => -111,
			'OP17_LIST_RANGE' => -111
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Variable' => 151,
			'SubExpression' => 150,
			'Operator' => 99
		}
	},
	{#State 90
		ACTIONS => {
			'LITERAL_STRING' => 129,
			"}" => 173,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP01_NAMED' => 161,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 154,
			'OP01_CLOSE' => 171,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 178,
			'OP23_LOGICAL_AND' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP10_NAMED_UNARY' => 177,
			'SELF' => 127,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'ENV' => 167,
			"%{" => 101,
			'OP01_OPEN' => 164,
			'OP19_LOOP_CONTROL' => 165,
			'OP01_NAMED_VOID' => 175
		},
		GOTOS => {
			'Literal' => 162,
			'VariableSymbolOrSelf' => 104,
			'OpStringOrWord' => 168,
			'Variable' => 157,
			'HashDereference' => 163,
			'VarOrLitOrOpStrOrWord' => 174,
			'HashEntry' => 155
		}
	},
	{#State 91
		DEFAULT => -168
	},
	{#State 92
		DEFAULT => -163
	},
	{#State 93
		ACTIONS => {
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131
		},
		GOTOS => {
			'HashDereference' => 119,
			'Variable' => 151,
			'SubExpression' => 179,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 94
		DEFAULT => -245
	},
	{#State 95
		DEFAULT => -154
	},
	{#State 96
		ACTIONS => {
			'LPAREN' => 180,
			'COLON' => -232
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'ARGV' => 186,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151,
			'HashDereference' => 119,
			'TypeInner' => 184,
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'ListElement' => 183,
			'ListElements' => 185
		}
	},
	{#State 98
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 139,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_PRINT' => 134,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 121,
			'LBRACKET' => 117,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'SELF' => 127,
			'OP01_NAMED_SCOLON' => 123,
			"if" => 115,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 109,
			'MY' => 111,
			'LPAREN' => 110,
			'' => -18,
			"foreach" => -164,
			'WORD_SCOPED' => 27,
			"while" => -164,
			'WORD_UPPERCASE' => 96,
			'OP01_NAMED_VOID' => 97,
			"for" => -164,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'OperatorVoid' => 132,
			'Conditional' => 108,
			'LoopLabel' => 106,
			'Variable' => 136,
			'SubExpression' => 135,
			'ArrayReference' => 138,
			'Statement' => 112,
			'Operation' => 187,
			'HashReference' => 95,
			'PAREN-43' => 92,
			'VariableDeclaration' => 91,
			'VariableModification' => 124,
			'Operator' => 99,
			'ArrayDereference' => 103,
			'OPTIONAL-44' => 126,
			'Expression' => 105,
			'VariableSymbolOrSelf' => 104,
			'HashDereference' => 119
		}
	},
	{#State 99
		DEFAULT => -142
	},
	{#State 100
		DEFAULT => -134
	},
	{#State 101
		ACTIONS => {
			'SELF' => 127,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 146,
			'LBRACE' => -227
		},
		GOTOS => {
			'TypeInner' => 188,
			'Variable' => 190,
			'OPTIONAL-58' => 189,
			'VariableSymbolOrSelf' => 104
		}
	},
	{#State 102
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129
		},
		GOTOS => {
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Variable' => 151,
			'SubExpression' => 191,
			'Operator' => 99,
			'HashDereference' => 119,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 103
		DEFAULT => -153
	},
	{#State 104
		DEFAULT => -189,
		GOTOS => {
			'STAR-50' => 192
		}
	},
	{#State 105
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -148,
			'OP17_LIST_RANGE' => -148,
			";" => 193,
			'OP07_MATH_MULT_DIV_MOD' => -148,
			'OP15_LOGICAL_AND' => -148,
			'OP08_MATH_ADD_SUB' => -148,
			'OP07_STRING_REPEAT' => -148,
			'OP11_COMPARE_LT_GT' => -148,
			'OP08_STRING_CAT' => -148,
			'OP16_LOGICAL_OR' => -148,
			'OP06_REGEX_BIND' => -148,
			'OP14_BITWISE_OR_XOR' => -148,
			'OP18_TERNARY' => -148,
			'OP12_COMPARE_EQ_NE' => -148,
			'OP23_LOGICAL_AND' => -148,
			'OP13_BITWISE_AND' => -148,
			'OP24_LOGICAL_OR_XOR' => -148,
			'OP04_MATH_POW' => -148
		}
	},
	{#State 106
		ACTIONS => {
			'COLON' => 194
		}
	},
	{#State 107
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 195,
			'LPAREN' => 196
		}
	},
	{#State 108
		DEFAULT => -165
	},
	{#State 109
		DEFAULT => -247
	},
	{#State 110
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'LBRACE' => 90,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_PRINT' => 198,
			'OP01_NAMED' => 197,
			'LPAREN' => 110
		},
		GOTOS => {
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'SubExpression' => 199,
			'Variable' => 151,
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107
		}
	},
	{#State 111
		ACTIONS => {
			'TYPE_FHREF' => 203,
			'WORD_SCOPED' => 202,
			'WORD' => 201,
			'TYPE_INTEGER' => 204
		},
		GOTOS => {
			'Type' => 200
		}
	},
	{#State 112
		DEFAULT => -92
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'SELF' => 127
		},
		GOTOS => {
			'Variable' => 205,
			'VariableSymbolOrSelf' => 104
		}
	},
	{#State 114
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'LBRACE' => 90,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'Variable' => 151,
			'SubExpression' => 206,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 207
		}
	},
	{#State 116
		ACTIONS => {
			'FHREF_SYMBOL' => 208
		}
	},
	{#State 117
		ACTIONS => {
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'ARGV' => 186,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			"]" => -209,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117
		},
		GOTOS => {
			'TypeInner' => 184,
			'HashDereference' => 119,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 182,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ListElement' => 183,
			'ListElements' => 210,
			'WordScoped' => 107,
			'Literal' => 130,
			'OPTIONAL-53' => 209,
			'HashReference' => 95
		}
	},
	{#State 118
		DEFAULT => -144
	},
	{#State 119
		DEFAULT => -155
	},
	{#State 120
		ACTIONS => {
			'MY' => 211
		}
	},
	{#State 121
		ACTIONS => {
			'WORD_UPPERCASE' => 213
		},
		GOTOS => {
			'LoopLabel' => 212
		}
	},
	{#State 122
		DEFAULT => -91
	},
	{#State 123
		DEFAULT => -90
	},
	{#State 124
		ACTIONS => {
			";" => 214
		}
	},
	{#State 125
		DEFAULT => -14
	},
	{#State 126
		ACTIONS => {
			"while" => 218,
			"for" => 219,
			"foreach" => 221
		},
		GOTOS => {
			'LoopForEach' => 216,
			'LoopFor' => 220,
			'Loop' => 215,
			'LoopWhile' => 217
		}
	},
	{#State 127
		DEFAULT => -246
	},
	{#State 128
		DEFAULT => -130
	},
	{#State 129
		DEFAULT => -248
	},
	{#State 130
		DEFAULT => -150
	},
	{#State 131
		DEFAULT => -149
	},
	{#State 132
		DEFAULT => -167
	},
	{#State 133
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Variable' => 151,
			'SubExpression' => 222,
			'Operator' => 99
		}
	},
	{#State 134
		ACTIONS => {
			'WORD_UPPERCASE' => -125,
			'LBRACKET' => -125,
			'OP01_OPEN' => -125,
			'CONSTANT_CALL_SCOPED' => -125,
			"%{" => -125,
			'OP05_MATH_NEG_LPAREN' => -125,
			'SELF' => -125,
			'OP10_NAMED_UNARY' => -125,
			'OP05_LOGICAL_NEG' => -125,
			"\@{" => -125,
			'OP03_MATH_INC_DEC' => -125,
			'OP01_QW' => -125,
			'LBRACE' => -125,
			'VARIABLE_SYMBOL' => -125,
			'WORD' => -125,
			'OP01_CLOSE' => -125,
			'OP05_BITWISE_NEG_LPAREN' => -125,
			'OP22_LOGICAL_NEG' => -125,
			'LITERAL_NUMBER' => -125,
			'ARGV' => -125,
			'STDOUT_STDERR' => 223,
			'OP01_NAMED' => -125,
			'MY' => -125,
			'LPAREN' => -125,
			'FHREF_SYMBOL_BRACES' => 225,
			'WORD_SCOPED' => -125,
			'LITERAL_STRING' => -125,
			"undef" => -125
		},
		GOTOS => {
			'PAREN-37' => 226,
			'OPTIONAL-38' => 224
		}
	},
	{#State 135
		ACTIONS => {
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227
		}
	},
	{#State 136
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -151,
			'OP17_LIST_RANGE' => -151,
			")" => -151,
			'OP15_LOGICAL_AND' => -151,
			'OP07_MATH_MULT_DIV_MOD' => -151,
			'OP11_COMPARE_LT_GT' => -151,
			'OP08_MATH_ADD_SUB' => -151,
			'OP07_STRING_REPEAT' => -151,
			'OP19_VARIABLE_ASSIGN' => 246,
			'OP03_MATH_INC_DEC' => 244,
			'OP16_LOGICAL_OR' => -151,
			'OP08_STRING_CAT' => -151,
			'OP18_TERNARY' => -151,
			'OP23_LOGICAL_AND' => -151,
			'OP12_COMPARE_EQ_NE' => -151,
			'OP14_BITWISE_OR_XOR' => -151,
			'OP06_REGEX_BIND' => -151,
			'OP13_BITWISE_AND' => -151,
			'OP19_VARIABLE_ASSIGN_BY' => 247,
			'OP02_METHOD_THINARROW' => 245,
			'OP04_MATH_POW' => -151,
			'OP24_LOGICAL_OR_XOR' => -151
		}
	},
	{#State 137
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"undef" => 131,
			")" => -127,
			'LITERAL_STRING' => 129,
			'ARGV' => 186,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'MY' => 146,
			'LPAREN' => 110,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101
		},
		GOTOS => {
			'TypeInner' => 184,
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 182,
			'ListElement' => 183,
			'ListElements' => 248,
			'Literal' => 130,
			'OPTIONAL-39' => 249,
			'HashReference' => 95,
			'WordScoped' => 107
		}
	},
	{#State 138
		DEFAULT => -152
	},
	{#State 139
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'ARGV' => 186,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LPAREN' => 110
		},
		GOTOS => {
			'ListElement' => 250,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'TypeInner' => 184,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Variable' => 151,
			'SubExpression' => 251,
			'Operator' => 99
		}
	},
	{#State 140
		DEFAULT => -17
	},
	{#State 141
		ACTIONS => {
			"use constant" => -69,
			'USE' => 46,
			"our hashref \$properties" => -69
		},
		GOTOS => {
			'Include' => 252,
			'STAR-29' => 253
		}
	},
	{#State 142
		ACTIONS => {
			'MY' => 254
		}
	},
	{#State 143
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 201,
			'TYPE_INTEGER' => 204
		},
		GOTOS => {
			'Type' => 255
		}
	},
	{#State 144
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 129
		},
		GOTOS => {
			'Literal' => 256
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 257
		}
	},
	{#State 146
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'TYPE_INTEGER' => 204,
			'WORD' => 201
		},
		GOTOS => {
			'Type' => 258
		}
	},
	{#State 147
		ACTIONS => {
			'LBRACKET' => 117
		},
		GOTOS => {
			'ArrayReference' => 259
		}
	},
	{#State 148
		DEFAULT => -211
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101
		},
		GOTOS => {
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130,
			'HashDereference' => 119,
			'Variable' => 151,
			'SubExpression' => 260,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138
		}
	},
	{#State 150
		ACTIONS => {
			'OP13_BITWISE_AND' => -110,
			"]" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP04_MATH_POW' => 234,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP18_TERNARY' => -110,
			'OP12_COMPARE_EQ_NE' => -110,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => -110,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			"}" => -110,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => -110,
			")" => -110,
			";" => -110
		}
	},
	{#State 151
		ACTIONS => {
			'OP06_REGEX_BIND' => -151,
			'OP14_BITWISE_OR_XOR' => -151,
			'OP21_LIST_COMMA' => -151,
			'OP12_COMPARE_EQ_NE' => -151,
			'OP23_LOGICAL_AND' => -151,
			'OP18_TERNARY' => -151,
			'OP08_STRING_CAT' => -151,
			'OP16_LOGICAL_OR' => -151,
			'OP03_MATH_INC_DEC' => 244,
			'OP02_METHOD_THINARROW' => 245,
			"]" => -151,
			'OP24_LOGICAL_OR_XOR' => -151,
			'OP04_MATH_POW' => -151,
			'OP13_BITWISE_AND' => -151,
			")" => -151,
			";" => -151,
			"}" => -151,
			'OP09_BITWISE_SHIFT' => -151,
			'OP17_LIST_RANGE' => -151,
			'OP08_MATH_ADD_SUB' => -151,
			'OP07_STRING_REPEAT' => -151,
			'OP11_COMPARE_LT_GT' => -151,
			'OP07_MATH_MULT_DIV_MOD' => -151,
			'OP15_LOGICAL_AND' => -151
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 180
		}
	},
	{#State 153
		DEFAULT => -148
	},
	{#State 154
		DEFAULT => -257
	},
	{#State 155
		DEFAULT => -223,
		GOTOS => {
			'STAR-57' => 261
		}
	},
	{#State 156
		DEFAULT => -270
	},
	{#State 157
		DEFAULT => -242
	},
	{#State 158
		DEFAULT => -261
	},
	{#State 159
		DEFAULT => -265
	},
	{#State 160
		DEFAULT => -263
	},
	{#State 161
		DEFAULT => -266
	},
	{#State 162
		DEFAULT => -243
	},
	{#State 163
		DEFAULT => -218
	},
	{#State 164
		DEFAULT => -268
	},
	{#State 165
		DEFAULT => -259
	},
	{#State 166
		DEFAULT => -255
	},
	{#State 167
		DEFAULT => -219
	},
	{#State 168
		DEFAULT => -244
	},
	{#State 169
		DEFAULT => -260
	},
	{#State 170
		DEFAULT => -256
	},
	{#State 171
		DEFAULT => -267
	},
	{#State 172
		DEFAULT => -264
	},
	{#State 173
		DEFAULT => -225
	},
	{#State 174
		ACTIONS => {
			'OP20_HASH_FATARROW' => 262
		}
	},
	{#State 175
		DEFAULT => -269
	},
	{#State 176
		DEFAULT => -258
	},
	{#State 177
		DEFAULT => -262
	},
	{#State 178
		DEFAULT => -271
	},
	{#State 179
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			")" => 263,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235
		}
	},
	{#State 180
		ACTIONS => {
			")" => 264
		}
	},
	{#State 181
		DEFAULT => -206
	},
	{#State 182
		ACTIONS => {
			"]" => -204,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP21_LIST_COMMA' => -204,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			")" => -204,
			";" => -204,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235
		}
	},
	{#State 183
		DEFAULT => -202,
		GOTOS => {
			'STAR-52' => 265
		}
	},
	{#State 184
		ACTIONS => {
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'HashDereference' => 119,
			'SubExpression' => 266,
			'Variable' => 151,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 185
		ACTIONS => {
			";" => 267
		}
	},
	{#State 186
		DEFAULT => -207
	},
	{#State 187
		DEFAULT => -16
	},
	{#State 188
		DEFAULT => -226
	},
	{#State 189
		ACTIONS => {
			'LBRACE' => 90
		},
		GOTOS => {
			'HashReference' => 268
		}
	},
	{#State 190
		ACTIONS => {
			"}" => 269
		}
	},
	{#State 191
		ACTIONS => {
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			")" => 270,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228
		}
	},
	{#State 192
		ACTIONS => {
			";" => -190,
			")" => -190,
			'COLON' => -190,
			'OP20_HASH_FATARROW' => -190,
			"}" => -190,
			'OP09_BITWISE_SHIFT' => -190,
			'OP17_LIST_RANGE' => -190,
			'OP07_STRING_REPEAT' => -190,
			'OP08_MATH_ADD_SUB' => -190,
			'OP11_COMPARE_LT_GT' => -190,
			'OP02_ARRAY_THINARROW' => 272,
			'OP07_MATH_MULT_DIV_MOD' => -190,
			'OP15_LOGICAL_AND' => -190,
			'OP21_LIST_COMMA' => -190,
			'OP06_REGEX_BIND' => -190,
			'OP14_BITWISE_OR_XOR' => -190,
			'OP23_LOGICAL_AND' => -190,
			'OP12_COMPARE_EQ_NE' => -190,
			'OP18_TERNARY' => -190,
			'OP16_LOGICAL_OR' => -190,
			'OP08_STRING_CAT' => -190,
			'OP03_MATH_INC_DEC' => -190,
			'OP19_VARIABLE_ASSIGN' => -190,
			'OP02_HASH_THINARROW' => 273,
			'OP24_LOGICAL_OR_XOR' => -190,
			'OP04_MATH_POW' => -190,
			'OP02_METHOD_THINARROW' => -190,
			"]" => -190,
			'OP19_VARIABLE_ASSIGN_BY' => -190,
			'OP13_BITWISE_AND' => -190
		},
		GOTOS => {
			'VariableRetrieval' => 271
		}
	},
	{#State 193
		DEFAULT => -89
	},
	{#State 194
		DEFAULT => -162
	},
	{#State 195
		ACTIONS => {
			'LBRACE' => 90,
			")" => -141
		},
		GOTOS => {
			'OPTIONAL-42' => 275,
			'HashReference' => 274
		}
	},
	{#State 196
		ACTIONS => {
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'ARGV' => 186,
			'LITERAL_STRING' => 129,
			")" => -137,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			'OP01_QW' => 181
		},
		GOTOS => {
			'ListElement' => 183,
			'ListElements' => 276,
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'TypeInner' => 184,
			'HashDereference' => 119,
			'OPTIONAL-40' => 277,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151
		}
	},
	{#State 197
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'ARGV' => 186,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP01_QW' => 181,
			'LBRACE' => 90,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'ListElement' => 278,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Variable' => 151,
			'SubExpression' => 251,
			'Operator' => 99,
			'TypeInner' => 184,
			'HashDereference' => 119
		}
	},
	{#State 198
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 279
		}
	},
	{#State 199
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			")" => 280,
			'OP13_BITWISE_AND' => 233,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => 242
		}
	},
	{#State 200
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 201
		DEFAULT => -233
	},
	{#State 202
		DEFAULT => -234
	},
	{#State 203
		ACTIONS => {
			'FHREF_SYMBOL' => 282
		}
	},
	{#State 204
		DEFAULT => -235
	},
	{#State 205
		DEFAULT => -98
	},
	{#State 206
		ACTIONS => {
			'OP13_BITWISE_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP04_MATH_POW' => 234,
			"]" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP08_STRING_CAT' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP06_REGEX_BIND' => -102,
			'OP18_TERNARY' => -102,
			'OP12_COMPARE_EQ_NE' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP07_STRING_REPEAT' => -102,
			'OP08_MATH_ADD_SUB' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP17_LIST_RANGE' => -102,
			"}" => -102,
			'OP09_BITWISE_SHIFT' => -102,
			";" => -102,
			")" => -102
		}
	},
	{#State 207
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 283,
			'Variable' => 151,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104
		}
	},
	{#State 208
		DEFAULT => -97
	},
	{#State 209
		ACTIONS => {
			"]" => 284
		}
	},
	{#State 210
		DEFAULT => -208
	},
	{#State 211
		ACTIONS => {
			'TYPE_FHREF' => 285
		}
	},
	{#State 212
		ACTIONS => {
			";" => 286
		}
	},
	{#State 213
		DEFAULT => -232
	},
	{#State 214
		DEFAULT => -169
	},
	{#State 215
		DEFAULT => -166
	},
	{#State 216
		DEFAULT => -178
	},
	{#State 217
		DEFAULT => -179
	},
	{#State 218
		ACTIONS => {
			'LPAREN' => 287,
			'LPAREN_MY' => 288
		}
	},
	{#State 219
		ACTIONS => {
			'LPAREN_MY' => 289,
			'MY' => 290
		}
	},
	{#State 220
		DEFAULT => -177
	},
	{#State 221
		ACTIONS => {
			'MY' => 291
		}
	},
	{#State 222
		ACTIONS => {
			'OP17_LIST_RANGE' => 235,
			"}" => -120,
			'OP09_BITWISE_SHIFT' => 236,
			")" => -120,
			";" => -120,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP23_LOGICAL_AND' => -120,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP21_LIST_COMMA' => -120,
			'OP13_BITWISE_AND' => 233,
			"]" => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP04_MATH_POW' => 234
		}
	},
	{#State 223
		DEFAULT => -123
	},
	{#State 224
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'ARGV' => 186,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151,
			'HashDereference' => 119,
			'TypeInner' => 184,
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'ListElement' => 183,
			'ListElements' => 292
		}
	},
	{#State 225
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'ARGV' => 186
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'ListElements' => 293,
			'ListElement' => 183,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Variable' => 151,
			'SubExpression' => 182,
			'Operator' => 99,
			'HashDereference' => 119,
			'TypeInner' => 184
		}
	},
	{#State 226
		DEFAULT => -124
	},
	{#State 227
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101
		},
		GOTOS => {
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 294,
			'Variable' => 151,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95
		}
	},
	{#State 228
		ACTIONS => {
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'HashDereference' => 119,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 295,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153
		}
	},
	{#State 229
		ACTIONS => {
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90
		},
		GOTOS => {
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 296,
			'Variable' => 151,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95
		}
	},
	{#State 230
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 297,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'HashDereference' => 119
		}
	},
	{#State 231
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 298
		}
	},
	{#State 232
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 129,
			'VARIABLE_SYMBOL' => 94,
			'SELF' => 127
		},
		GOTOS => {
			'Variable' => 299,
			'Literal' => 300,
			'VariableSymbolOrSelf' => 104,
			'VariableOrLiteral' => 301
		}
	},
	{#State 233
		ACTIONS => {
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'SubExpression' => 302,
			'Variable' => 151,
			'Operator' => 99,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 234
		ACTIONS => {
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110
		},
		GOTOS => {
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 303,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95
		}
	},
	{#State 235
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'HashDereference' => 119,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'SubExpression' => 304,
			'Variable' => 151,
			'Operator' => 99,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 236
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 305
		}
	},
	{#State 237
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'LBRACE' => 90,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 306
		}
	},
	{#State 238
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 307,
			'HashDereference' => 119
		}
	},
	{#State 239
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28
		},
		GOTOS => {
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 308,
			'Variable' => 151,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95
		}
	},
	{#State 240
		ACTIONS => {
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Variable' => 151,
			'SubExpression' => 309,
			'Operator' => 99,
			'HashDereference' => 119
		}
	},
	{#State 241
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'LBRACE' => 90,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'SubExpression' => 310,
			'Variable' => 151,
			'Operator' => 99,
			'HashDereference' => 119
		}
	},
	{#State 242
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'LBRACE' => 90,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'HashDereference' => 119,
			'Variable' => 151,
			'SubExpression' => 311,
			'Operator' => 99,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 243
		ACTIONS => {
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90
		},
		GOTOS => {
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 312,
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107
		}
	},
	{#State 244
		DEFAULT => -99
	},
	{#State 245
		ACTIONS => {
			'LPAREN' => 313
		}
	},
	{#State 246
		ACTIONS => {
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			"%{" => 101,
			'STDIN' => 314,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'FHREF_SYMBOL_IN' => 316,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90
		},
		GOTOS => {
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130,
			'HashDereference' => 119,
			'Variable' => 151,
			'SubExpression' => 315,
			'SubExpressionOrInput' => 317,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138
		}
	},
	{#State 247
		ACTIONS => {
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'SubExpression' => 318,
			'Variable' => 151,
			'Operator' => 99,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 248
		DEFAULT => -126
	},
	{#State 249
		ACTIONS => {
			")" => 319
		}
	},
	{#State 250
		ACTIONS => {
			'OP21_LIST_COMMA' => 320
		}
	},
	{#State 251
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -94,
			'OP06_REGEX_BIND' => -94,
			'OP21_LIST_COMMA' => -204,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP18_TERNARY' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_STRING_CAT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP04_MATH_POW' => -94,
			'OP13_BITWISE_AND' => -94,
			")" => -94,
			";" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP07_STRING_REPEAT' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP15_LOGICAL_AND' => -94
		}
	},
	{#State 252
		DEFAULT => -66
	},
	{#State 253
		ACTIONS => {
			"our hashref \$properties" => 321,
			"use constant" => 63
		},
		GOTOS => {
			'Properties' => 322,
			'Constant' => 323
		}
	},
	{#State 254
		ACTIONS => {
			'WORD' => 201,
			'TYPE_INTEGER' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 324
		}
	},
	{#State 255
		ACTIONS => {
			"\$TYPED_" => 325
		}
	},
	{#State 256
		ACTIONS => {
			";" => 326
		}
	},
	{#State 257
		DEFAULT => -213
	},
	{#State 258
		ACTIONS => {
			"\$TYPED_" => 327
		}
	},
	{#State 259
		ACTIONS => {
			"}" => 328
		}
	},
	{#State 260
		ACTIONS => {
			";" => -94,
			")" => -94,
			"}" => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP07_STRING_REPEAT' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP06_REGEX_BIND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP04_MATH_POW' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			"]" => -94,
			'OP13_BITWISE_AND' => -94
		}
	},
	{#State 261
		ACTIONS => {
			"}" => 330,
			'OP21_LIST_COMMA' => 329
		},
		GOTOS => {
			'PAREN-56' => 331
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_SCOPED' => -216,
			'LITERAL_STRING' => -216,
			"undef" => -216,
			'LITERAL_NUMBER' => -216,
			'OP22_LOGICAL_NEG' => -216,
			'LPAREN' => -216,
			'OP01_NAMED' => -216,
			'MY' => 146,
			"\@{" => -216,
			'OP03_MATH_INC_DEC' => -216,
			'OP10_NAMED_UNARY' => -216,
			'OP05_LOGICAL_NEG' => -216,
			'LBRACE' => -216,
			'OP05_BITWISE_NEG_LPAREN' => -216,
			'OP01_CLOSE' => -216,
			'VARIABLE_SYMBOL' => -216,
			'WORD' => -216,
			'WORD_UPPERCASE' => -216,
			'LBRACKET' => -216,
			'OP01_OPEN' => -216,
			'CONSTANT_CALL_SCOPED' => -216,
			"%{" => -216,
			'OP05_MATH_NEG_LPAREN' => -216,
			'SELF' => -216
		},
		GOTOS => {
			'TypeInner' => 333,
			'OPTIONAL-55' => 332
		}
	},
	{#State 263
		DEFAULT => -101
	},
	{#State 264
		DEFAULT => -143
	},
	{#State 265
		ACTIONS => {
			")" => -203,
			'OP21_LIST_COMMA' => 335,
			";" => -203,
			"]" => -203
		},
		GOTOS => {
			'PAREN-51' => 334
		}
	},
	{#State 266
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			")" => -205,
			";" => -205,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			"]" => -205,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP21_LIST_COMMA' => -205,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228
		}
	},
	{#State 267
		DEFAULT => -132
	},
	{#State 268
		ACTIONS => {
			"}" => 336
		}
	},
	{#State 269
		DEFAULT => -228
	},
	{#State 270
		DEFAULT => -103
	},
	{#State 271
		DEFAULT => -188
	},
	{#State 272
		ACTIONS => {
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 337,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'HashDereference' => 119
		}
	},
	{#State 273
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			'WORD' => 339,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'SubExpression' => 338,
			'Variable' => 151,
			'Operator' => 99
		}
	},
	{#State 274
		DEFAULT => -140
	},
	{#State 275
		ACTIONS => {
			")" => 340
		}
	},
	{#State 276
		DEFAULT => -136
	},
	{#State 277
		ACTIONS => {
			")" => 341
		}
	},
	{#State 278
		ACTIONS => {
			'OP21_LIST_COMMA' => 342
		}
	},
	{#State 279
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP01_QW' => 181,
			'LBRACE' => 90,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'ARGV' => 186,
			'OP01_NAMED' => 149,
			'MY' => 146,
			'LPAREN' => 110
		},
		GOTOS => {
			'ListElements' => 343,
			'ListElement' => 183,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130,
			'HashDereference' => 119,
			'TypeInner' => 184,
			'SubExpression' => 182,
			'Variable' => 151,
			'Operator' => 99,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103
		}
	},
	{#State 280
		DEFAULT => -156
	},
	{#State 281
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 346,
			";" => 345,
			'OP02_ARRAY_THINARROW' => 344
		}
	},
	{#State 282
		ACTIONS => {
			";" => 347
		}
	},
	{#State 283
		ACTIONS => {
			")" => 348,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233
		}
	},
	{#State 284
		DEFAULT => -210
	},
	{#State 285
		ACTIONS => {
			'FHREF_SYMBOL' => 349
		}
	},
	{#State 286
		DEFAULT => -135
	},
	{#State 287
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131
		},
		GOTOS => {
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130,
			'Variable' => 151,
			'SubExpression' => 350,
			'Operator' => 99,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'HashDereference' => 119
		}
	},
	{#State 288
		ACTIONS => {
			'WORD' => 201,
			'TYPE_INTEGER' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 351
		}
	},
	{#State 289
		ACTIONS => {
			'TYPE_INTEGER' => 352
		}
	},
	{#State 290
		ACTIONS => {
			'TYPE_INTEGER' => 353
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_INTEGER' => 204,
			'WORD' => 201,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 354
		}
	},
	{#State 292
		ACTIONS => {
			";" => 355
		}
	},
	{#State 293
		ACTIONS => {
			";" => 356
		}
	},
	{#State 294
		ACTIONS => {
			")" => -106,
			";" => -106,
			"}" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP08_STRING_CAT' => -106,
			'OP16_LOGICAL_OR' => -106,
			"]" => -106,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => -106
		}
	},
	{#State 295
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			"}" => -117,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => -117,
			";" => -117,
			")" => -117,
			'OP13_BITWISE_AND' => 233,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -117,
			"]" => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP08_STRING_CAT' => 229,
			'OP23_LOGICAL_AND' => -117,
			'OP18_TERNARY' => -117,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP21_LIST_COMMA' => -117,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231
		}
	},
	{#State 296
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => -108,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => -108,
			'OP17_LIST_RANGE' => -108,
			"}" => -108,
			'OP09_BITWISE_SHIFT' => -108,
			")" => -108,
			";" => -108,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP04_MATH_POW' => 234,
			'OP16_LOGICAL_OR' => -108,
			'OP08_STRING_CAT' => -108,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP18_TERNARY' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NE' => -108
		}
	},
	{#State 297
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP15_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			")" => -115,
			";" => -115,
			'OP09_BITWISE_SHIFT' => 236,
			"}" => -115,
			'OP17_LIST_RANGE' => -115,
			"]" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233,
			'OP23_LOGICAL_AND' => -115,
			'OP18_TERNARY' => -115,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => -115
		}
	},
	{#State 298
		DEFAULT => -104
	},
	{#State 299
		DEFAULT => -240
	},
	{#State 300
		DEFAULT => -241
	},
	{#State 301
		ACTIONS => {
			'COLON' => 357
		}
	},
	{#State 302
		ACTIONS => {
			'OP13_BITWISE_AND' => -114,
			"]" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP04_MATH_POW' => 234,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => -114,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => -114,
			'OP18_TERNARY' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP06_REGEX_BIND' => 231,
			'OP21_LIST_COMMA' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			"}" => -114,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => -114,
			")" => -114,
			";" => -114
		}
	},
	{#State 303
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP15_LOGICAL_AND' => -100,
			")" => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			"}" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			"]" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP08_STRING_CAT' => -100,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 304
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			";" => -118,
			")" => -118,
			'OP17_LIST_RANGE' => undef,
			"}" => -118,
			'OP09_BITWISE_SHIFT' => 236,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -118,
			"]" => -118,
			'OP13_BITWISE_AND' => 233,
			'OP18_TERNARY' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP21_LIST_COMMA' => -118,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228
		}
	},
	{#State 305
		ACTIONS => {
			'OP16_LOGICAL_OR' => -109,
			'OP08_STRING_CAT' => 229,
			'OP18_TERNARY' => -109,
			'OP12_COMPARE_EQ_NE' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -109,
			"]" => -109,
			'OP17_LIST_RANGE' => -109,
			"}" => -109,
			'OP09_BITWISE_SHIFT' => -109,
			";" => -109,
			")" => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => -109,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239
		}
	},
	{#State 306
		ACTIONS => {
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => -116,
			";" => -116,
			")" => -116,
			'OP17_LIST_RANGE' => -116,
			"}" => -116,
			'OP09_BITWISE_SHIFT' => 236,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -116,
			"]" => -116,
			'OP13_BITWISE_AND' => 233,
			'OP21_LIST_COMMA' => -116,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP18_TERNARY' => -116,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => -116,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => -116
		}
	},
	{#State 307
		ACTIONS => {
			'OP13_BITWISE_AND' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP04_MATH_POW' => 234,
			"]" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_STRING_CAT' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP18_TERNARY' => -105,
			'OP12_COMPARE_EQ_NE' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP07_STRING_REPEAT' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			"}" => -105,
			'OP17_LIST_RANGE' => -105,
			";" => -105,
			")" => -105
		}
	},
	{#State 308
		ACTIONS => {
			'OP15_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => -107,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => -107,
			"}" => -107,
			'OP17_LIST_RANGE' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			";" => -107,
			")" => -107,
			'OP13_BITWISE_AND' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP04_MATH_POW' => 234,
			"]" => -107,
			'OP08_STRING_CAT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP18_TERNARY' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP12_COMPARE_EQ_NE' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => -107
		}
	},
	{#State 309
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP04_MATH_POW' => 234,
			"]" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP06_REGEX_BIND' => 231,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => -112,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			";" => -112,
			")" => -112,
			'OP09_BITWISE_SHIFT' => 236,
			"}" => -112,
			'OP17_LIST_RANGE' => -112
		}
	},
	{#State 310
		ACTIONS => {
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -113,
			"]" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP06_REGEX_BIND' => 231,
			'OP16_LOGICAL_OR' => -113,
			'OP08_STRING_CAT' => 229,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			";" => -113,
			")" => -113,
			'OP09_BITWISE_SHIFT' => 236,
			"}" => -113,
			'OP17_LIST_RANGE' => -113
		}
	},
	{#State 311
		ACTIONS => {
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP21_LIST_COMMA' => -121,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => -121,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP13_BITWISE_AND' => 233,
			"]" => -121,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => -121,
			"}" => -121,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			")" => -121,
			";" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => 240
		}
	},
	{#State 312
		ACTIONS => {
			"}" => -122,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			")" => -122,
			";" => -122,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => 240,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP21_LIST_COMMA' => -122,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP13_BITWISE_AND' => 233,
			"]" => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP04_MATH_POW' => 234
		}
	},
	{#State 313
		ACTIONS => {
			'OP01_QW' => 181,
			'LBRACE' => 90,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			")" => -139,
			'LITERAL_STRING' => 129,
			'ARGV' => 186,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149
		},
		GOTOS => {
			'HashDereference' => 119,
			'TypeInner' => 184,
			'SubExpression' => 182,
			'Variable' => 151,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'ListElements' => 359,
			'OPTIONAL-41' => 358,
			'ListElement' => 183,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 314
		DEFAULT => -159
	},
	{#State 315
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			";" => -157,
			")" => -157,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235
		}
	},
	{#State 316
		DEFAULT => -158
	},
	{#State 317
		DEFAULT => -198
	},
	{#State 318
		ACTIONS => {
			")" => -199,
			";" => -199,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233
		}
	},
	{#State 319
		ACTIONS => {
			";" => 360
		}
	},
	{#State 320
		ACTIONS => {
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'ARGV' => 186,
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149
		},
		GOTOS => {
			'ListElement' => 183,
			'ListElements' => 361,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'TypeInner' => 184,
			'HashDereference' => 119,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 182,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153
		}
	},
	{#State 321
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 362
		}
	},
	{#State 322
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 363
		}
	},
	{#State 323
		DEFAULT => -68
	},
	{#State 324
		ACTIONS => {
			"\$RETURN_TYPE" => 364
		}
	},
	{#State 325
		ACTIONS => {
			'WORD_UPPERCASE' => 365
		}
	},
	{#State 326
		DEFAULT => -52
	},
	{#State 327
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP01_NAMED_VOID' => 175,
			'OP01_OPEN' => 164,
			'OP19_LOOP_CONTROL' => 165,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP23_LOGICAL_AND' => 170,
			'WORD' => 178,
			'OP01_CLOSE' => 171,
			'OP10_NAMED_UNARY' => 177,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP01_NAMED' => 161,
			'OP22_LOGICAL_NEG' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 172
		},
		GOTOS => {
			'OpStringOrWord' => 366
		}
	},
	{#State 328
		DEFAULT => -214
	},
	{#State 329
		ACTIONS => {
			'OP10_NAMED_UNARY' => 177,
			'OP23_LOGICAL_AND' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'WORD' => 178,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 171,
			'OP01_NAMED_VOID' => 175,
			'OP01_OPEN' => 164,
			'OP19_LOOP_CONTROL' => 165,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP24_LOGICAL_OR_XOR' => 166,
			"%{" => 101,
			'ENV' => 167,
			'SELF' => 127,
			'LITERAL_STRING' => 129,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP01_NAMED' => 161
		},
		GOTOS => {
			'Literal' => 162,
			'VariableSymbolOrSelf' => 104,
			'Variable' => 157,
			'OpStringOrWord' => 168,
			'VarOrLitOrOpStrOrWord' => 174,
			'HashEntry' => 367,
			'HashDereference' => 163
		}
	},
	{#State 330
		DEFAULT => -224
	},
	{#State 331
		DEFAULT => -222
	},
	{#State 332
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'SubExpression' => 368,
			'Variable' => 151
		}
	},
	{#State 333
		DEFAULT => -215
	},
	{#State 334
		DEFAULT => -201
	},
	{#State 335
		ACTIONS => {
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'OP01_QW' => 181,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'ARGV' => 186,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'ListElement' => 369,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151,
			'HashDereference' => 119,
			'TypeInner' => 184
		}
	},
	{#State 336
		DEFAULT => -229
	},
	{#State 337
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			'OP13_BITWISE_AND' => 233,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			"]" => 370,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241
		}
	},
	{#State 338
		ACTIONS => {
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			"}" => 371
		}
	},
	{#State 339
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -230,
			"}" => 372,
			'LPAREN' => -230
		}
	},
	{#State 340
		DEFAULT => -147
	},
	{#State 341
		DEFAULT => -145
	},
	{#State 342
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'ARGV' => 186,
			'MY' => 146,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'TypeInner' => 184,
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ListElement' => 183,
			'ListElements' => 373,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95
		}
	},
	{#State 343
		ACTIONS => {
			")" => 374
		}
	},
	{#State 344
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'Operator' => 99,
			'SubExpression' => 375,
			'Variable' => 151
		}
	},
	{#State 345
		DEFAULT => -194
	},
	{#State 346
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP10_NAMED_UNARY_SCOLON' => 376,
			'OP01_OPEN' => 120,
			'OP01_NAMED_SCOLON' => 377,
			'STDIN' => 314,
			"%{" => 101,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'FHREF_SYMBOL_IN' => 316,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'Operator' => 99,
			'SubExpressionOrInput' => 379,
			'Variable' => 151,
			'SubExpression' => 315,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'OpNamedScolonOrSubExpIn' => 378
		}
	},
	{#State 347
		DEFAULT => -197
	},
	{#State 348
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 382
		}
	},
	{#State 350
		ACTIONS => {
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => 242,
			'OP13_BITWISE_AND' => 233,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			")" => 383,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => 240
		}
	},
	{#State 351
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 352
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 355
		DEFAULT => -128
	},
	{#State 356
		DEFAULT => -129
	},
	{#State 357
		ACTIONS => {
			'SELF' => 127,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_STRING' => 129,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'Variable' => 299,
			'Literal' => 300,
			'VariableSymbolOrSelf' => 104,
			'VariableOrLiteral' => 388
		}
	},
	{#State 358
		ACTIONS => {
			")" => 389
		}
	},
	{#State 359
		DEFAULT => -138
	},
	{#State 360
		DEFAULT => -131
	},
	{#State 361
		ACTIONS => {
			";" => 390
		}
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 391
		}
	},
	{#State 363
		ACTIONS => {
			'SUB' => 393,
			'LITERAL_NUMBER' => 396
		},
		GOTOS => {
			'SubroutineOrMethod' => 395,
			'Method' => 394,
			'Subroutine' => 392
		}
	},
	{#State 364
		ACTIONS => {
			"}" => 397
		}
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 398
		}
	},
	{#State 366
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 399
		}
	},
	{#State 367
		DEFAULT => -221
	},
	{#State 368
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			"}" => -217,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			'OP13_BITWISE_AND' => 233,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP21_LIST_COMMA' => -217,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230
		}
	},
	{#State 369
		DEFAULT => -200
	},
	{#State 370
		DEFAULT => -191
	},
	{#State 371
		DEFAULT => -192
	},
	{#State 372
		DEFAULT => -193
	},
	{#State 373
		ACTIONS => {
			")" => 400
		}
	},
	{#State 374
		DEFAULT => -93
	},
	{#State 375
		ACTIONS => {
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			"]" => 401,
			'OP13_BITWISE_AND' => 233,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229
		}
	},
	{#State 376
		DEFAULT => -253
	},
	{#State 377
		DEFAULT => -252
	},
	{#State 378
		DEFAULT => -195
	},
	{#State 379
		ACTIONS => {
			";" => 402
		}
	},
	{#State 380
		ACTIONS => {
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_NAMED' => 139,
			'OP01_PRINT' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_CLOSE' => 116,
			"if" => 115,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'SELF' => 127,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP01_NAMED_SCOLON' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP19_LOOP_CONTROL' => 121,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'MY' => 111,
			"foreach" => -164,
			'LITERAL_NUMBER' => 109,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'LBRACE' => 90,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP05_MATH_NEG_LPAREN' => 102,
			"for" => -164,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			"%{" => 101,
			'OP01_NAMED_VOID' => 97,
			'WORD_UPPERCASE' => 96,
			"while" => -164
		},
		GOTOS => {
			'ArrayReference' => 138,
			'Operation' => 403,
			'Statement' => 112,
			'PLUS-49' => 404,
			'Variable' => 136,
			'SubExpression' => 135,
			'LoopLabel' => 106,
			'Literal' => 130,
			'Conditional' => 108,
			'OperatorVoid' => 132,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'OPTIONAL-44' => 126,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 105,
			'Operator' => 99,
			'VariableModification' => 124,
			'VariableDeclaration' => 91,
			'PAREN-43' => 92,
			'HashReference' => 95
		}
	},
	{#State 381
		DEFAULT => -172,
		GOTOS => {
			'STAR-46' => 405
		}
	},
	{#State 382
		ACTIONS => {
			'LITERAL_STRING' => 406
		}
	},
	{#State 383
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 407
		}
	},
	{#State 384
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 408
		}
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 386
		ACTIONS => {
			'LPAREN' => 410
		}
	},
	{#State 387
		ACTIONS => {
			'LPAREN' => 411
		}
	},
	{#State 388
		DEFAULT => -119
	},
	{#State 389
		DEFAULT => -146
	},
	{#State 390
		DEFAULT => -133
	},
	{#State 391
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 169,
			'OP23_LOGICAL_AND' => 170,
			'WORD' => 178,
			'OP01_CLOSE' => 171,
			'OP10_NAMED_UNARY' => 177,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP01_NAMED_VOID' => 175,
			'OP19_LOOP_CONTROL' => 165,
			'OP01_OPEN' => 164,
			"}" => 414,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_STRING_REPEAT' => 159,
			'OP01_NAMED' => 161,
			'OP08_MATH_ADD_SUB' => 160,
			'OP22_LOGICAL_NEG' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 172
		},
		GOTOS => {
			'HashEntryProperties' => 412,
			'OpStringOrWord' => 413
		}
	},
	{#State 392
		DEFAULT => -87
	},
	{#State 393
		ACTIONS => {
			'WORD' => 415
		}
	},
	{#State 394
		DEFAULT => -88
	},
	{#State 395
		DEFAULT => -70
	},
	{#State 396
		ACTIONS => {
			";" => 416
		}
	},
	{#State 397
		ACTIONS => {
			";" => 417
		}
	},
	{#State 398
		DEFAULT => -239
	},
	{#State 399
		DEFAULT => -236
	},
	{#State 400
		DEFAULT => -95
	},
	{#State 401
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 418
		}
	},
	{#State 402
		DEFAULT => -254
	},
	{#State 403
		DEFAULT => -186
	},
	{#State 404
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			"if" => 115,
			'OP01_CLOSE' => 116,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 121,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_NAMED_SCOLON' => 123,
			'SELF' => 127,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_PRINT' => 134,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_NAMED' => 139,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 90,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'WORD_UPPERCASE' => 96,
			'OP01_NAMED_VOID' => 97,
			"while" => -164,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			"for" => -164,
			"}" => 420,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 109,
			"foreach" => -164,
			'LPAREN' => 110,
			'MY' => 111
		},
		GOTOS => {
			'VariableDeclaration' => 91,
			'PAREN-43' => 92,
			'HashReference' => 95,
			'HashDereference' => 119,
			'ArrayDereference' => 103,
			'OPTIONAL-44' => 126,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 105,
			'VariableModification' => 124,
			'Operator' => 99,
			'LoopLabel' => 106,
			'Literal' => 130,
			'OperatorVoid' => 132,
			'Conditional' => 108,
			'WordScoped' => 107,
			'ArrayReference' => 138,
			'Operation' => 419,
			'Statement' => 112,
			'Variable' => 136,
			'SubExpression' => 135
		}
	},
	{#State 405
		ACTIONS => {
			'OP01_PRINT' => -175,
			'OP01_NAMED_VOID_LPAREN' => -175,
			'OP01_NAMED' => -175,
			'OP22_LOGICAL_NEG' => -175,
			'LITERAL_STRING' => -175,
			"else" => 425,
			"undef" => -175,
			'OP01_NAMED_SCOLON' => -175,
			'SELF' => -175,
			'OP01_NAMED_VOID_SCOLON' => -175,
			'LBRACKET' => -175,
			'OP10_NAMED_UNARY_SCOLON' => -175,
			'OP19_LOOP_CONTROL' => -175,
			'OP01_OPEN' => -175,
			'CONSTANT_CALL_SCOPED' => -175,
			'OP01_CLOSE' => -175,
			'OP03_MATH_INC_DEC' => -175,
			'OP05_LOGICAL_NEG' => -175,
			"if" => -175,
			"foreach" => -175,
			'' => -175,
			'LPAREN' => -175,
			'MY' => -175,
			'LITERAL_NUMBER' => -175,
			"}" => -175,
			'WORD_SCOPED' => -175,
			'OP19_LOOP_CONTROL_SCOLON' => -175,
			"%{" => -175,
			'OP05_MATH_NEG_LPAREN' => -175,
			"for" => -175,
			'OP01_NAMED_VOID' => -175,
			'WORD_UPPERCASE' => -175,
			"while" => -175,
			"elsif" => 422,
			'OP05_BITWISE_NEG_LPAREN' => -175,
			'VARIABLE_SYMBOL' => -175,
			'WORD' => -175,
			"\@{" => -175,
			'OP10_NAMED_UNARY' => -175,
			'LBRACE' => -175
		},
		GOTOS => {
			'PAREN-45' => 424,
			'OPTIONAL-48' => 423,
			'PAREN-47' => 421
		}
	},
	{#State 406
		ACTIONS => {
			'OP21_LIST_COMMA' => 426
		}
	},
	{#State 407
		DEFAULT => -183
	},
	{#State 408
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 316,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			"%{" => 101,
			'STDIN' => 314,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'SubExpressionOrInput' => 427,
			'SubExpression' => 315,
			'Variable' => 151,
			'HashDereference' => 119
		}
	},
	{#State 409
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'OP01_NAMED_SCOLON' => 430,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP10_NAMED_UNARY_SCOLON' => 429,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'SubExpression' => 428,
			'Variable' => 151,
			'Operator' => 99,
			'HashDereference' => 119,
			'OpNamedScolonOrSubExp' => 431,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 410
		ACTIONS => {
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113
		},
		GOTOS => {
			'Variable' => 151,
			'SubExpression' => 432,
			'Operator' => 99,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130
		}
	},
	{#State 411
		ACTIONS => {
			'OP01_NAMED' => 149,
			'MY' => 146,
			'LPAREN' => 110,
			'ARGV' => 186,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP01_QW' => 181,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88
		},
		GOTOS => {
			'ListElement' => 183,
			'ListElements' => 433,
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'TypeInner' => 184,
			'HashDereference' => 119,
			'Operator' => 99,
			'SubExpression' => 182,
			'Variable' => 151,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104
		}
	},
	{#State 412
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 434
		}
	},
	{#State 413
		ACTIONS => {
			'OP20_HASH_FATARROW' => 435
		}
	},
	{#State 414
		ACTIONS => {
			";" => 436
		}
	},
	{#State 415
		ACTIONS => {
			'LBRACE' => 437
		}
	},
	{#State 416
		DEFAULT => -72
	},
	{#State 417
		ACTIONS => {
			"}" => -54,
			'WORD_SCOPED' => -54,
			"foreach" => -54,
			'MY' => -54,
			'LPAREN' => -54,
			'LPAREN_MY' => 438,
			'LITERAL_NUMBER' => -54,
			'WORD' => -54,
			'VARIABLE_SYMBOL' => -54,
			'OP05_BITWISE_NEG_LPAREN' => -54,
			'OP10_NAMED_UNARY' => -54,
			"\@{" => -54,
			'LBRACE' => -54,
			"%{" => -54,
			'OP19_LOOP_CONTROL_SCOLON' => -54,
			"for" => -54,
			'OP05_MATH_NEG_LPAREN' => -54,
			"while" => -54,
			'WORD_UPPERCASE' => -54,
			'OP01_NAMED_VOID' => -54,
			'LITERAL_STRING' => -54,
			"undef" => -54,
			'OP01_PRINT' => -54,
			'OP01_NAMED' => -54,
			'OP01_NAMED_VOID_LPAREN' => -54,
			'OP22_LOGICAL_NEG' => -54,
			'OP01_CLOSE' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"if" => -54,
			'OP01_NAMED_SCOLON' => -54,
			'OP01_NAMED_VOID_SCOLON' => -54,
			'SELF' => -54,
			'LBRACKET' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'CONSTANT_CALL_SCOPED' => -54,
			'OP10_NAMED_UNARY_SCOLON' => -54,
			'OP01_OPEN' => -54
		},
		GOTOS => {
			'SubroutineArguments' => 439,
			'OPTIONAL-22' => 440
		}
	},
	{#State 418
		ACTIONS => {
			"undef" => 441
		}
	},
	{#State 419
		DEFAULT => -185
	},
	{#State 420
		DEFAULT => -187
	},
	{#State 421
		DEFAULT => -174
	},
	{#State 422
		ACTIONS => {
			'LPAREN' => 442
		}
	},
	{#State 423
		DEFAULT => -176
	},
	{#State 424
		DEFAULT => -171
	},
	{#State 425
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 426
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 90,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'SubExpression' => 444,
			'Variable' => 151,
			'Operator' => 99,
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107
		}
	},
	{#State 427
		ACTIONS => {
			")" => 445
		}
	},
	{#State 428
		ACTIONS => {
			";" => 446,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233
		}
	},
	{#State 429
		DEFAULT => -250
	},
	{#State 430
		DEFAULT => -249
	},
	{#State 431
		ACTIONS => {
			'VARIABLE_SYMBOL' => 447
		}
	},
	{#State 432
		ACTIONS => {
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 448,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP13_BITWISE_AND' => 233,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228
		}
	},
	{#State 433
		ACTIONS => {
			")" => 449
		}
	},
	{#State 434
		ACTIONS => {
			'OP21_LIST_COMMA' => 451,
			"}" => 450
		},
		GOTOS => {
			'PAREN-31' => 452
		}
	},
	{#State 435
		ACTIONS => {
			'MY' => 454
		},
		GOTOS => {
			'TypeInnerProperties' => 453
		}
	},
	{#State 436
		DEFAULT => -77
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 455
		}
	},
	{#State 438
		ACTIONS => {
			'WORD' => 201,
			'TYPE_INTEGER' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 456
		}
	},
	{#State 439
		DEFAULT => -53
	},
	{#State 440
		DEFAULT => -56,
		GOTOS => {
			'STAR-23' => 457
		}
	},
	{#State 441
		ACTIONS => {
			";" => 458
		}
	},
	{#State 442
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'LBRACE' => 90,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93
		},
		GOTOS => {
			'WordScoped' => 107,
			'HashReference' => 95,
			'Literal' => 130,
			'HashDereference' => 119,
			'Variable' => 151,
			'SubExpression' => 459,
			'Operator' => 99,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138
		}
	},
	{#State 443
		DEFAULT => -173
	},
	{#State 444
		ACTIONS => {
			";" => -96,
			")" => -96,
			"}" => -96,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP23_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP04_MATH_POW' => 234,
			"]" => -96,
			'OP13_BITWISE_AND' => 233
		}
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 460
		}
	},
	{#State 446
		DEFAULT => -251
	},
	{#State 447
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 461
		}
	},
	{#State 448
		ACTIONS => {
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_CLOSE' => 116,
			'LBRACE' => 90,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89
		},
		GOTOS => {
			'Literal' => 130,
			'HashReference' => 95,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 462
		}
	},
	{#State 449
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 463
		}
	},
	{#State 450
		ACTIONS => {
			";" => 464
		}
	},
	{#State 451
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_STRING_REPEAT' => 159,
			'OP01_NAMED' => 161,
			'OP08_MATH_ADD_SUB' => 160,
			'OP01_NAMED_VOID' => 175,
			'OP01_OPEN' => 164,
			'OP19_LOOP_CONTROL' => 165,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP10_NAMED_UNARY' => 177,
			'OP23_LOGICAL_AND' => 170,
			'OP12_COMPARE_EQ_NE' => 169,
			'OP01_CLOSE' => 171,
			'WORD' => 178
		},
		GOTOS => {
			'HashEntryProperties' => 465,
			'OpStringOrWord' => 413
		}
	},
	{#State 452
		DEFAULT => -74
	},
	{#State 453
		DEFAULT => -220
	},
	{#State 454
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 201,
			'TYPE_INTEGER' => 204
		},
		GOTOS => {
			'Type' => 466
		}
	},
	{#State 455
		ACTIONS => {
			'MY' => 467
		}
	},
	{#State 456
		ACTIONS => {
			'VARIABLE_SYMBOL' => 468
		}
	},
	{#State 457
		ACTIONS => {
			'SELF' => 127,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP01_NAMED_SCOLON' => 123,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP19_LOOP_CONTROL' => 121,
			'OP01_OPEN' => 120,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'LBRACKET' => 117,
			'OP01_CLOSE' => 116,
			"if" => 115,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_NAMED' => 139,
			'OP01_PRINT' => 134,
			'OP22_LOGICAL_NEG' => 133,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP05_MATH_NEG_LPAREN' => 102,
			"for" => -164,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			"%{" => 101,
			'WORD_UPPERCASE' => 96,
			'OP01_NAMED_VOID' => 97,
			"while" => -164,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'LBRACE' => 90,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 89,
			'LPAREN' => 110,
			'MY' => 111,
			"foreach" => -164,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 27,
			"}" => 470
		},
		GOTOS => {
			'Variable' => 136,
			'SubExpression' => 135,
			'ArrayReference' => 138,
			'Operation' => 469,
			'Statement' => 112,
			'WordScoped' => 107,
			'Literal' => 130,
			'OperatorVoid' => 132,
			'Conditional' => 108,
			'LoopLabel' => 106,
			'Operator' => 99,
			'VariableModification' => 124,
			'ArrayDereference' => 103,
			'OPTIONAL-44' => 126,
			'Expression' => 105,
			'VariableSymbolOrSelf' => 104,
			'HashDereference' => 119,
			'HashReference' => 95,
			'VariableDeclaration' => 91,
			'PAREN-43' => 92
		}
	},
	{#State 458
		DEFAULT => -196
	},
	{#State 459
		ACTIONS => {
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP13_BITWISE_AND' => 233,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 232,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			")" => 471,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236
		}
	},
	{#State 460
		DEFAULT => -184
	},
	{#State 461
		ACTIONS => {
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP01_NAMED' => 149,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'WORD' => 28,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 90,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_NAMED_SCOLON' => 430,
			"%{" => 101,
			'OP10_NAMED_UNARY_SCOLON' => 429,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'SubExpression' => 428,
			'Variable' => 151,
			'Operator' => 99,
			'HashDereference' => 119,
			'OpNamedScolonOrSubExp' => 472
		}
	},
	{#State 462
		ACTIONS => {
			'OP13_BITWISE_AND' => 233,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP04_MATH_POW' => 234,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP18_TERNARY' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239,
			'OP11_COMPARE_LT_GT' => 240,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 236,
			")" => 473
		}
	},
	{#State 463
		DEFAULT => -182
	},
	{#State 464
		DEFAULT => -76
	},
	{#State 465
		DEFAULT => -73
	},
	{#State 466
		ACTIONS => {
			"\$TYPED_" => 474
		}
	},
	{#State 467
		ACTIONS => {
			'TYPE_INTEGER' => 204,
			'WORD' => 201,
			'TYPE_METHOD' => 475,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 324
		}
	},
	{#State 468
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 476
		}
	},
	{#State 469
		DEFAULT => -55
	},
	{#State 470
		DEFAULT => -57
	},
	{#State 471
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 477
		}
	},
	{#State 472
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'SELF' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_OPEN' => 120,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'SubExpressionOrVarMod' => 479,
			'VariableSymbolOrSelf' => 104,
			'Expression' => 153,
			'ArrayDereference' => 103,
			'ArrayReference' => 138,
			'SubExpression' => 478,
			'Variable' => 136,
			'Operator' => 99,
			'VariableModification' => 480,
			'HashDereference' => 119
		}
	},
	{#State 473
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 481
		}
	},
	{#State 474
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 169,
			'OP23_LOGICAL_AND' => 170,
			'WORD' => 178,
			'OP01_CLOSE' => 171,
			'OP10_NAMED_UNARY' => 177,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP01_NAMED_VOID' => 175,
			'OP01_OPEN' => 164,
			'OP19_LOOP_CONTROL' => 165,
			'OP01_PRINT' => 156,
			'OP11_COMPARE_LT_GT' => 158,
			'OP07_STRING_REPEAT' => 159,
			'OP01_NAMED' => 161,
			'OP08_MATH_ADD_SUB' => 160,
			'OP22_LOGICAL_NEG' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 172
		},
		GOTOS => {
			'OpStringOrWord' => 482
		}
	},
	{#State 475
		ACTIONS => {
			"\$RETURN_TYPE" => 483
		}
	},
	{#State 476
		ACTIONS => {
			")" => 484,
			'OP21_LIST_COMMA' => 486
		},
		GOTOS => {
			'PAREN-24' => 485
		}
	},
	{#State 477
		DEFAULT => -170
	},
	{#State 478
		ACTIONS => {
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP06_REGEX_BIND' => 231,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP13_BITWISE_AND' => 233,
			'OP04_MATH_POW' => 234,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236,
			")" => -160,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 239
		}
	},
	{#State 479
		ACTIONS => {
			")" => 487
		}
	},
	{#State 480
		DEFAULT => -161
	},
	{#State 481
		DEFAULT => -180
	},
	{#State 482
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 488,
			'OP02_ARRAY_THINARROW' => 489
		}
	},
	{#State 483
		ACTIONS => {
			"}" => 490
		}
	},
	{#State 484
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 491
		}
	},
	{#State 485
		DEFAULT => -59
	},
	{#State 486
		ACTIONS => {
			'MY' => 492
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 380
		},
		GOTOS => {
			'CodeBlock' => 493
		}
	},
	{#State 488
		ACTIONS => {
			'LITERAL_STRING' => 129,
			"undef" => 131,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 149,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 109,
			'OP01_CLOSE' => 116,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 113,
			"\@{" => 88,
			'LBRACE' => 90,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			'WORD_UPPERCASE' => 152,
			'LBRACKET' => 117,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118
		},
		GOTOS => {
			'WordScoped' => 107,
			'Literal' => 130,
			'HashReference' => 95,
			'Operator' => 99,
			'Variable' => 151,
			'SubExpression' => 494,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'HashDereference' => 119
		}
	},
	{#State 489
		ACTIONS => {
			'LBRACE' => 90,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 113,
			'OP05_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			'OP01_CLOSE' => 116,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 94,
			'OP01_OPEN' => 120,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 117,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 102,
			'SELF' => 127,
			"%{" => 101,
			'WORD_SCOPED' => 27,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 133,
			'LPAREN' => 110,
			'OP01_NAMED' => 149
		},
		GOTOS => {
			'HashReference' => 95,
			'Literal' => 130,
			'WordScoped' => 107,
			'Expression' => 153,
			'VariableSymbolOrSelf' => 104,
			'ArrayReference' => 138,
			'ArrayDereference' => 103,
			'Variable' => 151,
			'SubExpression' => 495,
			'Operator' => 99,
			'HashDereference' => 119
		}
	},
	{#State 490
		ACTIONS => {
			";" => 496
		}
	},
	{#State 491
		ACTIONS => {
			"\@ARG;" => 497
		}
	},
	{#State 492
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'TYPE_INTEGER' => 204,
			'WORD' => 201
		},
		GOTOS => {
			'Type' => 498
		}
	},
	{#State 493
		DEFAULT => -181
	},
	{#State 494
		ACTIONS => {
			'OP13_BITWISE_AND' => 233,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP16_LOGICAL_OR' => 228,
			'OP08_STRING_CAT' => 229,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP21_LIST_COMMA' => -237,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP11_COMPARE_LT_GT' => 240,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			"}" => -237,
			'OP17_LIST_RANGE' => 235,
			'OP09_BITWISE_SHIFT' => 236
		}
	},
	{#State 495
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 227,
			'OP15_LOGICAL_AND' => 237,
			'OP08_MATH_ADD_SUB' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP11_COMPARE_LT_GT' => 240,
			'OP09_BITWISE_SHIFT' => 236,
			'OP17_LIST_RANGE' => 235,
			'OP13_BITWISE_AND' => 233,
			"]" => 499,
			'OP24_LOGICAL_OR_XOR' => 243,
			'OP04_MATH_POW' => 234,
			'OP08_STRING_CAT' => 229,
			'OP16_LOGICAL_OR' => 228,
			'OP14_BITWISE_OR_XOR' => 230,
			'OP06_REGEX_BIND' => 231,
			'OP23_LOGICAL_AND' => 242,
			'OP18_TERNARY' => 232,
			'OP12_COMPARE_EQ_NE' => 241
		}
	},
	{#State 496
		ACTIONS => {
			"while" => -79,
			'OP01_NAMED_VOID' => -79,
			'WORD_UPPERCASE' => -79,
			"for" => -79,
			'OP05_MATH_NEG_LPAREN' => -79,
			"%{" => -79,
			'OP19_LOOP_CONTROL_SCOLON' => -79,
			'LBRACE' => -79,
			'OP10_NAMED_UNARY' => -79,
			"\@{" => -79,
			'VARIABLE_SYMBOL' => -79,
			'WORD' => -79,
			'OP05_BITWISE_NEG_LPAREN' => -79,
			'LPAREN_MY' => 502,
			'LITERAL_NUMBER' => -79,
			'MY' => -79,
			'LPAREN' => -79,
			"foreach" => -79,
			'WORD_SCOPED' => -79,
			"}" => -79,
			'OP19_LOOP_CONTROL' => -79,
			'OP10_NAMED_UNARY_SCOLON' => -79,
			'CONSTANT_CALL_SCOPED' => -79,
			'OP01_OPEN' => -79,
			'LBRACKET' => -79,
			'OP01_NAMED_VOID_SCOLON' => -79,
			'SELF' => -79,
			'OP01_NAMED_SCOLON' => -79,
			"if" => -79,
			'OP05_LOGICAL_NEG' => -79,
			'OP03_MATH_INC_DEC' => -79,
			'OP01_CLOSE' => -79,
			'OP22_LOGICAL_NEG' => -79,
			'OP01_NAMED' => -79,
			'OP01_NAMED_VOID_LPAREN' => -79,
			'OP01_PRINT' => -79,
			"undef" => -79,
			'LITERAL_STRING' => -79
		},
		GOTOS => {
			'OPTIONAL-33' => 501,
			'MethodArguments' => 500
		}
	},
	{#State 497
		DEFAULT => -61
	},
	{#State 498
		ACTIONS => {
			'VARIABLE_SYMBOL' => 503
		}
	},
	{#State 499
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 504
		}
	},
	{#State 500
		DEFAULT => -78
	},
	{#State 501
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 505
		}
	},
	{#State 502
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 201,
			'TYPE_INTEGER' => 204
		},
		GOTOS => {
			'Type' => 506
		}
	},
	{#State 503
		DEFAULT => -58
	},
	{#State 504
		ACTIONS => {
			"undef" => 507
		}
	},
	{#State 505
		ACTIONS => {
			"if" => 115,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP01_CLOSE' => 116,
			'OP01_OPEN' => 120,
			'OP19_LOOP_CONTROL' => 121,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 117,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'SELF' => 127,
			'OP01_NAMED_SCOLON' => 123,
			"undef" => 131,
			'LITERAL_STRING' => 129,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 139,
			'OP01_NAMED_VOID_LPAREN' => 137,
			'OP01_PRINT' => 134,
			'LBRACE' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 88,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 93,
			"while" => -164,
			'OP01_NAMED_VOID' => 97,
			'WORD_UPPERCASE' => 96,
			"for" => -164,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 100,
			'WORD_SCOPED' => 27,
			"}" => 509,
			'LITERAL_NUMBER' => 109,
			'MY' => 111,
			'LPAREN' => 110,
			"foreach" => -164
		},
		GOTOS => {
			'LoopLabel' => 106,
			'WordScoped' => 107,
			'Literal' => 130,
			'OperatorVoid' => 132,
			'Conditional' => 108,
			'Variable' => 136,
			'SubExpression' => 135,
			'ArrayReference' => 138,
			'Operation' => 508,
			'Statement' => 112,
			'PAREN-43' => 92,
			'VariableDeclaration' => 91,
			'HashReference' => 95,
			'HashDereference' => 119,
			'VariableModification' => 124,
			'Operator' => 99,
			'ArrayDereference' => 103,
			'OPTIONAL-44' => 126,
			'Expression' => 105,
			'VariableSymbolOrSelf' => 104
		}
	},
	{#State 506
		ACTIONS => {
			'SELF' => 510
		}
	},
	{#State 507
		DEFAULT => -238
	},
	{#State 508
		DEFAULT => -80
	},
	{#State 509
		DEFAULT => -82
	},
	{#State 510
		DEFAULT => -85,
		GOTOS => {
			'STAR-36' => 511
		}
	},
	{#State 511
		ACTIONS => {
			'OP21_LIST_COMMA' => 514,
			")" => 512
		},
		GOTOS => {
			'PAREN-35' => 513
		}
	},
	{#State 512
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 515
		}
	},
	{#State 513
		DEFAULT => -84
	},
	{#State 514
		ACTIONS => {
			'MY' => 516
		}
	},
	{#State 515
		ACTIONS => {
			"\@ARG;" => 517
		}
	},
	{#State 516
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 201,
			'TYPE_INTEGER' => 204
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 517
		DEFAULT => -86
	},
	{#State 518
		ACTIONS => {
			'VARIABLE_SYMBOL' => 519
		}
	},
	{#State 519
		DEFAULT => -83
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7287 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7355 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7366 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7479 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7511 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7525 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule Include_50
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7561 lib/RPerl/Grammar.pm
	],
	[#Rule Include_51
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_52
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7583 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7604 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 4,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7643 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_61
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7654 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7696 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7703 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule Class_72
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7735 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7742 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7749 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7756 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_76
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7767 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_77
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7778 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7785 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7806 lib/RPerl/Grammar.pm
	],
	[#Rule Method_82
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7817 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 4,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_86
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7849 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_87
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7860 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_88
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_89
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7882 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_90
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7893 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7904 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_92
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7915 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7926 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7948 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7970 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7981 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7992 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8003 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8014 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8025 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8036 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8047 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8058 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8069 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8080 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8091 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8102 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8113 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8124 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8135 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8146 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8157 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8168 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8179 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8190 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8201 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8212 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8223 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8234 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8245 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 1,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8252 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8259 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8266 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8273 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8280 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8302 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8313 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_132
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_133
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8346 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8368 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8375 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8382 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8389 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8396 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8410 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8421 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8432 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8443 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8454 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8465 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8476 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_148
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8487 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_149
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8498 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_150
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8509 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_151
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8520 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_152
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8531 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_153
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8542 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_154
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8553 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8564 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8575 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_157
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8586 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_158
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8597 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_159
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8608 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_160
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8619 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_161
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8630 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8637 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8644 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8651 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_165
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8662 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_166
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8673 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_167
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8684 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_168
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8695 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_169
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8706 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 5,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8713 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8720 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8727 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8748 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_176
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8759 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_177
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8770 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_178
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8781 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_179
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8792 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_180
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8803 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_181
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8814 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_182
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8825 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_183
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8836 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_184
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8847 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8861 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_187
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8886 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_190
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8897 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_191
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8908 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_192
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8919 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_193
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8930 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_194
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8941 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_195
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8952 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_196
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8963 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_197
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8974 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_198
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8985 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_199
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8996 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9003 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9010 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9017 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_203
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9028 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_204
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9039 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_205
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9050 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_206
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9061 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_207
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9072 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9086 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_210
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9097 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9104 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9111 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_213
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9122 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_214
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9133 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9147 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_217
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9158 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_218
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9169 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_219
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9180 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_220
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9191 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9198 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9205 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9212 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_224
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9223 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_225
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9234 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9241 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9248 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_228
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9259 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_229
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9270 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_230
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9281 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_231
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9292 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_232
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9303 lib/RPerl/Grammar.pm
	],
	[#Rule Type_233
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9314 lib/RPerl/Grammar.pm
	],
	[#Rule Type_234
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9325 lib/RPerl/Grammar.pm
	],
	[#Rule Type_235
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9336 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_236
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9347 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_237
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9358 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_238
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9369 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_239
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9380 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_240
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9391 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_241
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9402 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_242
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9413 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_243
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9424 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_244
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9435 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_245
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9446 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_246
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9457 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_247
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9468 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_248
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9479 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_249
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9490 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_250
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9501 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_251
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9512 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_252
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9523 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_253
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9534 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_254
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9545 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9556 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9567 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9578 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9589 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_259
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9600 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_260
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9611 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_261
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9622 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9633 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9644 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9655 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9666 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9677 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9688 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9699 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9710 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9721 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9732 lib/RPerl/Grammar.pm
	]
],
#line 9735 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_128', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         'OperatorVoid_131', 
         'OperatorVoid_132', 
         'OperatorVoid_133', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_142', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'SubExpression_148', 
         'SubExpression_149', 
         'SubExpression_150', 
         'SubExpression_151', 
         'SubExpression_152', 
         'SubExpression_153', 
         'SubExpression_154', 
         'SubExpression_155', 
         'SubExpression_156', 
         'SubExpressionOrInput_157', 
         'SubExpressionOrInput_158', 
         'SubExpressionOrInput_159', 
         'SubExpressionOrVarMod_160', 
         'SubExpressionOrVarMod_161', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_165', 
         'Statement_166', 
         'Statement_167', 
         'Statement_168', 
         'Statement_169', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_176', 
         'Loop_177', 
         'Loop_178', 
         'Loop_179', 
         'LoopFor_180', 
         'LoopFor_181', 
         'LoopForEach_182', 
         'LoopWhile_183', 
         'LoopWhile_184', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_187', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_190', 
         'VariableRetrieval_191', 
         'VariableRetrieval_192', 
         'VariableRetrieval_193', 
         'VariableDeclaration_194', 
         'VariableDeclaration_195', 
         'VariableDeclaration_196', 
         'VariableDeclaration_197', 
         'VariableModification_198', 
         'VariableModification_199', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_203', 
         'ListElement_204', 
         'ListElement_205', 
         'ListElement_206', 
         'ListElement_207', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_210', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_213', 
         'ArrayDereference_214', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_217', 
         'HashEntry_218', 
         'HashEntry_219', 
         'HashEntryProperties_220', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_224', 
         'HashReference_225', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_228', 
         'HashDereference_229', 
         'WordScoped_230', 
         'WordScoped_231', 
         'LoopLabel_232', 
         'Type_233', 
         'Type_234', 
         'Type_235', 
         'TypeInner_236', 
         'TypeInnerProperties_237', 
         'TypeInnerProperties_238', 
         'TypeInnerConstant_239', 
         'VariableOrLiteral_240', 
         'VariableOrLiteral_241', 
         'VarOrLitOrOpStrOrWord_242', 
         'VarOrLitOrOpStrOrWord_243', 
         'VarOrLitOrOpStrOrWord_244', 
         'VariableSymbolOrSelf_245', 
         'VariableSymbolOrSelf_246', 
         'Literal_247', 
         'Literal_248', 
         'OpNamedScolonOrSubExp_249', 
         'OpNamedScolonOrSubExp_250', 
         'OpNamedScolonOrSubExp_251', 
         'OpNamedScolonOrSubExpIn_252', 
         'OpNamedScolonOrSubExpIn_253', 
         'OpNamedScolonOrSubExpIn_254', 
         'OpStringOrWord_255', 
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
         'OpStringOrWord_271', );
  $self;
}

#line 280 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1.  Update grammar code in this file, above this line only
# 2.  Run `script/development/grammar_recompile.sh`
# 3.  Run `perl t/12_parse.t` for new & existing grammar parse-only tests, if errors goto step 1
# 4.  Inspect updates from Grammar.output file, note starting & finishing & increment/decrement numbers if any rule numbers have changed
# 5a. Run `scripts/development/grammar_increment.pl START FINISH INCREMENT` if rules added from step 4, repeat if needed
# 5b. Run `scripts/development/grammar_decrement.pl START FINISH DECREMENT` if rules deleted from step 4, repeat if needed
# 6.  Copy updates from Grammar.output file into this file with now-unique numbers, below this line only, if not-automatically-generated rules have been added
# 7.  Run `script/development/grammar_recompile.sh` again
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
Subroutine_48 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> SUB WORD LBRACE LBRACE MY Type '$RETURN_TYPE' '}' ';' OPTIONAL-17 STAR-18 '}'
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> SUB WORD LBRACE LBRACE MY TYPE_METHOD '$RETURN_TYPE' '}' ';' OPTIONAL-27 STAR-28 '}'
MethodArguments_75 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@ARG;'
SubroutineOrMethod_76 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_77 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
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
Operator_93 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
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
Expression_131 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_132 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_133 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_134 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_135 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_136 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-36 ')'
SubExpression_137 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_138 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_140 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_141 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_142 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_143 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_144 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_145 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_146 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_147 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_148 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_149 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_150 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_154 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_155 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_156 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_157 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_158 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_165 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_166 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_167 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_168 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_169 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_170 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_171 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_172 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_173 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_176 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_179 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_180 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_181 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_182 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_183 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_184 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_185 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_186 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_187 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_188 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_192 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_193 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_194 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_195 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_196 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_199 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_202 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_203 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_206 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_207 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_208 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_209 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_213 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_214 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_217 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_218 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_219 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_220 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_221 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_222 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_223 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_224 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_225 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_226 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_227 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_228 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_229 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_230 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_231 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_232 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_233 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_234 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_235 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_236 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_237 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_238 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_239 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_240 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_241 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_242 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_243 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_244 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_245 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_246 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_247 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_248 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_249 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_250 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_251 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_252 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_253 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_254 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_255 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_256 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_257 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_258 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_259 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_260 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 10218 lib/RPerl/Grammar.pm



1;
