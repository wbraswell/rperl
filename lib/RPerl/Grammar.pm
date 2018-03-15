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
    our $VERSION = 0.014_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|\$TYPED_|package|foreach|undef|\@ARG\;|while|elsif|else|INIT|for|\%\{|\@\{|if|\}|\;|\)|\])}gc and return ($1, $1);

      /\G(^#!\/(?:\w[\w-]*\/)*[\w-]*\s*[\w-]*perl[\w-]*)/gc and return ('SHEBANG', $1);
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
      /\G(->import\()/gc and return ('OP02_METHOD_THINARROW_IMP', $1);
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


#line 156 lib/RPerl/Grammar.pm

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
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'OP01_QW' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'OP01_QW' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ 'Include_54' => 'Include', [ 'USE', 'WordScoped', 'OPTIONAL-22', ';' ], 0 ],
  [ 'Include_55' => 'Include', [ 'INIT', 'LBRACE', 'WordScoped', 'OP02_METHOD_THINARROW_IMP', 'OPTIONAL-23', ')', ';', '}' ], 0 ],
  [ 'Constant_56' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Subroutine_61' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-24', 'STAR-25', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'PAREN-26' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'SubroutineArguments_65' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-27', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'SubroutineOrMethod' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'Class_76' => 'Class', [ 'UseParent', 'WordScoped', ')', ';', 'Include', 'STAR-28', 'OPTIONAL-29', 'STAR-30', 'STAR-31', 'Properties', 'STAR-32', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'UseParent_77' => 'UseParent', [ 'use parent qw(' ], 0 ],
  [ 'UseParent_78' => 'UseParent', [ 'use parent -norequire, qw(' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [ 'STAR-34', 'PAREN-33' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [  ], 0 ],
  [ 'Properties_82' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-34', '}', ';' ], 0 ],
  [ 'Properties_83' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'Method_88' => 'Method', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'TYPE_METHOD', '$RETURN_TYPE', '}', ';', 'OPTIONAL-35', 'STAR-36', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ 'MethodArguments_92' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-38', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_93' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_94' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_95' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_96' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_97' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_98' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_127' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_128' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_129' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-40', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_140' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_141' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_142' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-43', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-44', ')' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_158' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_159' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_163' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_164' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_165' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_166' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_167' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_168' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'PAREN-45' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'Statement_172' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_173' => 'Statement', [ 'OPTIONAL-46', 'Loop' ], 0 ],
  [ 'Statement_174' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_175' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_176' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Conditional_183' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-48', 'OPTIONAL-50' ], 0 ],
  [ 'Loop_184' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_185' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_186' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_187' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_188' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_189' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_190' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_191' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'PLUS-51', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'Operation' ], 0 ],
  [ 'CodeBlock_194' => 'CodeBlock', [ 'LBRACE', 'PLUS-51', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'Variable_197' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-52' ], 0 ],
  [ 'VariableRetrieval_198' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_199' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_200' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_201' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_202' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_203' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_204' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_205' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_206' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [ 'STAR-54', 'PAREN-53' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [  ], 0 ],
  [ 'ListElements_210' => 'ListElements', [ 'ListElement', 'STAR-54' ], 0 ],
  [ 'ListElement_211' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_212' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_213' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_214' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'ArrayReference_217' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-55', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayDereference_220' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_221' => 'ArrayDereference', [ '@{', 'OPTIONAL-56', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_224' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'SubExpression' ], 0 ],
  [ 'HashEntry_225' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_226' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_227' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_231' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashReference_232' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashDereference_235' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_236' => 'HashDereference', [ '%{', 'OPTIONAL-60', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_237' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_238' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_239' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_240' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_241' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_242' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_243' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_244' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_245' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_246' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_247' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_248' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_249' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_250' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_251' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_252' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_253' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_254' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_255' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_256' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_257' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_258' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_259' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_260' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_261' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_262' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_272' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_273' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_274' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_275' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_276' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_277' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_278' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_OPTIONAL' => 50,
  '_OPTIONAL' => 51,
  '_OPTIONAL' => 52,
  '_OPTIONAL' => 53,
  'Include_54' => 54,
  'Include_55' => 55,
  'Constant_56' => 56,
  '_OPTIONAL' => 57,
  '_OPTIONAL' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'Subroutine_61' => 61,
  '_PAREN' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  'SubroutineArguments_65' => 65,
  '_STAR_LIST' => 66,
  '_STAR_LIST' => 67,
  '_OPTIONAL' => 68,
  '_OPTIONAL' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'Class_76' => 76,
  'UseParent_77' => 77,
  'UseParent_78' => 78,
  '_PAREN' => 79,
  '_STAR_LIST' => 80,
  '_STAR_LIST' => 81,
  'Properties_82' => 82,
  'Properties_83' => 83,
  '_OPTIONAL' => 84,
  '_OPTIONAL' => 85,
  '_STAR_LIST' => 86,
  '_STAR_LIST' => 87,
  'Method_88' => 88,
  '_PAREN' => 89,
  '_STAR_LIST' => 90,
  '_STAR_LIST' => 91,
  'MethodArguments_92' => 92,
  'SubroutineOrMethod_93' => 93,
  'SubroutineOrMethod_94' => 94,
  'Operation_95' => 95,
  'Operation_96' => 96,
  'Operation_97' => 97,
  'Operation_98' => 98,
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
  'Operator_124' => 124,
  'Operator_125' => 125,
  'Operator_126' => 126,
  'Operator_127' => 127,
  'Operator_128' => 128,
  'Operator_129' => 129,
  '_PAREN' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  'OperatorVoid_139' => 139,
  'OperatorVoid_140' => 140,
  'OperatorVoid_141' => 141,
  'OperatorVoid_142' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  '_OPTIONAL' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'Expression_154' => 154,
  'SubExpression_155' => 155,
  'SubExpression_156' => 156,
  'SubExpression_157' => 157,
  'SubExpression_158' => 158,
  'SubExpression_159' => 159,
  'SubExpression_160' => 160,
  'SubExpression_161' => 161,
  'SubExpression_162' => 162,
  'SubExpression_163' => 163,
  'SubExpressionOrInput_164' => 164,
  'SubExpressionOrInput_165' => 165,
  'SubExpressionOrInput_166' => 166,
  'SubExpressionOrVarMod_167' => 167,
  'SubExpressionOrVarMod_168' => 168,
  '_PAREN' => 169,
  '_OPTIONAL' => 170,
  '_OPTIONAL' => 171,
  'Statement_172' => 172,
  'Statement_173' => 173,
  'Statement_174' => 174,
  'Statement_175' => 175,
  'Statement_176' => 176,
  '_PAREN' => 177,
  '_STAR_LIST' => 178,
  '_STAR_LIST' => 179,
  '_PAREN' => 180,
  '_OPTIONAL' => 181,
  '_OPTIONAL' => 182,
  'Conditional_183' => 183,
  'Loop_184' => 184,
  'Loop_185' => 185,
  'Loop_186' => 186,
  'LoopFor_187' => 187,
  'LoopFor_188' => 188,
  'LoopForEach_189' => 189,
  'LoopWhile_190' => 190,
  'LoopWhile_191' => 191,
  '_PLUS_LIST' => 192,
  '_PLUS_LIST' => 193,
  'CodeBlock_194' => 194,
  '_STAR_LIST' => 195,
  '_STAR_LIST' => 196,
  'Variable_197' => 197,
  'VariableRetrieval_198' => 198,
  'VariableRetrieval_199' => 199,
  'VariableRetrieval_200' => 200,
  'VariableDeclaration_201' => 201,
  'VariableDeclaration_202' => 202,
  'VariableDeclaration_203' => 203,
  'VariableDeclaration_204' => 204,
  'VariableModification_205' => 205,
  'VariableModification_206' => 206,
  '_PAREN' => 207,
  '_STAR_LIST' => 208,
  '_STAR_LIST' => 209,
  'ListElements_210' => 210,
  'ListElement_211' => 211,
  'ListElement_212' => 212,
  'ListElement_213' => 213,
  'ListElement_214' => 214,
  '_OPTIONAL' => 215,
  '_OPTIONAL' => 216,
  'ArrayReference_217' => 217,
  '_OPTIONAL' => 218,
  '_OPTIONAL' => 219,
  'ArrayDereference_220' => 220,
  'ArrayDereference_221' => 221,
  '_OPTIONAL' => 222,
  '_OPTIONAL' => 223,
  'HashEntry_224' => 224,
  'HashEntry_225' => 225,
  'HashEntry_226' => 226,
  'HashEntryProperties_227' => 227,
  '_PAREN' => 228,
  '_STAR_LIST' => 229,
  '_STAR_LIST' => 230,
  'HashReference_231' => 231,
  'HashReference_232' => 232,
  '_OPTIONAL' => 233,
  '_OPTIONAL' => 234,
  'HashDereference_235' => 235,
  'HashDereference_236' => 236,
  'WordScoped_237' => 237,
  'WordScoped_238' => 238,
  'LoopLabel_239' => 239,
  'Type_240' => 240,
  'Type_241' => 241,
  'Type_242' => 242,
  'TypeInner_243' => 243,
  'TypeInnerProperties_244' => 244,
  'TypeInnerProperties_245' => 245,
  'TypeInnerConstant_246' => 246,
  'VariableOrLiteral_247' => 247,
  'VariableOrLiteral_248' => 248,
  'VarOrLitOrOpStrOrWord_249' => 249,
  'VarOrLitOrOpStrOrWord_250' => 250,
  'VarOrLitOrOpStrOrWord_251' => 251,
  'VariableSymbolOrSelf_252' => 252,
  'VariableSymbolOrSelf_253' => 253,
  'Literal_254' => 254,
  'Literal_255' => 255,
  'OpNamedScolonOrSubExp_256' => 256,
  'OpNamedScolonOrSubExp_257' => 257,
  'OpNamedScolonOrSubExp_258' => 258,
  'OpNamedScolonOrSubExpIn_259' => 259,
  'OpNamedScolonOrSubExpIn_260' => 260,
  'OpNamedScolonOrSubExpIn_261' => 261,
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
  'OpStringOrWord_273' => 273,
  'OpStringOrWord_274' => 274,
  'OpStringOrWord_275' => 275,
  'OpStringOrWord_276' => 276,
  'OpStringOrWord_277' => 277,
  'OpStringOrWord_278' => 278,
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
	'INIT' => { ISSEMANTIC => 0 },
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
	'use parent -norequire, qw(' => { ISSEMANTIC => 0 },
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
	OP02_METHOD_THINARROW_IMP => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 9,
			"## no critic qw(" => 1,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Program' => 8,
			'PAREN-1' => 7,
			'OPTIONAL-9' => 4,
			'CompileUnit' => 5,
			'ModuleHeader' => 6,
			'Critic' => 3,
			'PLUS-2' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-17' => 11
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => -20,
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'ModuleHeader' => 6,
			'Critic' => 3,
			'OPTIONAL-9' => 4,
			'PAREN-1' => 12
		}
	},
	{#State 3
		DEFAULT => -19
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
			'' => 15
		}
	},
	{#State 6
		ACTIONS => {
			'USE' => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 18,
			'SUB' => -27,
			"use parent -norequire, qw(" => 19,
			"INIT" => -27,
			"use constant" => -27,
			'USE_EXPORTER' => -27
		},
		GOTOS => {
			'STAR-11' => 20,
			'Module' => 21,
			'UseParent' => 16,
			'Class' => 17,
			'Package' => 22
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 24,
			'Critic' => 23
		}
	},
	{#State 10
		DEFAULT => -41
	},
	{#State 11
		ACTIONS => {
			")" => 25,
			'WORD' => 26
		}
	},
	{#State 12
		DEFAULT => -2
	},
	{#State 13
		ACTIONS => {
			"package" => 27
		}
	},
	{#State 14
		DEFAULT => -21
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -77
	},
	{#State 19
		DEFAULT => -78
	},
	{#State 20
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE' => -29,
			"INIT" => -29,
			'USE_EXPORTER' => 33,
			"use constant" => -29,
			'SUB' => -29
		},
		GOTOS => {
			'Critic' => 31,
			'OPTIONAL-12' => 32,
			'Exports' => 34
		}
	},
	{#State 21
		DEFAULT => -1
	},
	{#State 22
		DEFAULT => -24
	},
	{#State 23
		DEFAULT => -6
	},
	{#State 24
		ACTIONS => {
			'USE_RPERL' => 35
		}
	},
	{#State 25
		DEFAULT => -42
	},
	{#State 26
		DEFAULT => -40
	},
	{#State 27
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 28
		ACTIONS => {
			")" => 37
		}
	},
	{#State 29
		DEFAULT => -237
	},
	{#State 30
		DEFAULT => -238
	},
	{#State 31
		DEFAULT => -26
	},
	{#State 32
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 33
		ACTIONS => {
			'SUB' => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT' => 40,
			'USE' => -45,
			"use constant" => -45,
			"INIT" => -45,
			'OUR_EXPORT_OK' => -45
		},
		GOTOS => {
			'PAREN-18' => 41,
			'OPTIONAL-19' => 39
		}
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			"use strict;" => 43
		},
		GOTOS => {
			'Header' => 42
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
			'SUB' => -33,
			"use constant" => -33,
			'USE' => 49,
			"INIT" => 47
		},
		GOTOS => {
			'STAR-14' => 48,
			'Include' => 46
		}
	},
	{#State 39
		ACTIONS => {
			'USE' => -48,
			'OUR_EXPORT_OK' => 50,
			"INIT" => -48,
			'SUB' => -48,
			"use constant" => -48,
			"our hashref \$properties" => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 52,
			'PAREN-20' => 51
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 53
		}
	},
	{#State 41
		DEFAULT => -44
	},
	{#State 42
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 54
		}
	},
	{#State 43
		ACTIONS => {
			"use warnings;" => 55
		}
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 43
		},
		GOTOS => {
			'Header' => 56
		}
	},
	{#State 45
		ACTIONS => {
			"INIT" => 47,
			'USE' => 49
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			'LBRACE' => 58
		}
	},
	{#State 48
		ACTIONS => {
			"use constant" => 63,
			'SUB' => 59
		},
		GOTOS => {
			'Constant' => 61,
			'PLUS-15' => 60,
			'Subroutine' => 62
		}
	},
	{#State 49
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 64
		}
	},
	{#State 50
		ACTIONS => {
			'OP01_QW' => 65
		}
	},
	{#State 51
		DEFAULT => -47
	},
	{#State 52
		DEFAULT => -49
	},
	{#State 53
		ACTIONS => {
			";" => 66
		}
	},
	{#State 54
		ACTIONS => {
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'WORD_SCOPED' => -11,
			'LBRACE' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"use constant" => -11,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"while" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LPAREN' => -11,
			'USE' => -11,
			"## no critic qw(" => 1,
			'OP10_NAMED_UNARY' => -11,
			'VARIABLE_SYMBOL' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_PRINT' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"INIT" => -11,
			'OP01_OPEN' => -11,
			"%{" => -11,
			'SELF' => -11,
			'LBRACKET' => -11,
			'SUB' => -11,
			"for" => -11,
			"undef" => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"\@{" => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'WORD' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'MY' => -11,
			"if" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_CLOSE' => -11,
			"foreach" => -11
		},
		GOTOS => {
			'STAR-5' => 67,
			'Critic' => 68
		}
	},
	{#State 55
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 69
		},
		GOTOS => {
			'OPTIONAL-16' => 70
		}
	},
	{#State 56
		DEFAULT => -23
	},
	{#State 57
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 71
		}
	},
	{#State 58
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 72
		}
	},
	{#State 59
		ACTIONS => {
			'WORD' => 73
		}
	},
	{#State 60
		ACTIONS => {
			'LITERAL_NUMBER' => 74,
			'SUB' => 59
		},
		GOTOS => {
			'Subroutine' => 75
		}
	},
	{#State 61
		DEFAULT => -32
	},
	{#State 62
		DEFAULT => -35
	},
	{#State 63
		ACTIONS => {
			'WORD_UPPERCASE' => 76
		}
	},
	{#State 64
		ACTIONS => {
			'OP01_QW' => 78,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 77
		}
	},
	{#State 65
		ACTIONS => {
			";" => 79
		}
	},
	{#State 66
		DEFAULT => -43
	},
	{#State 67
		ACTIONS => {
			'USE' => 49,
			'OP10_NAMED_UNARY' => -13,
			'LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"INIT" => 47,
			"%{" => -13,
			'OP01_OPEN' => -13,
			'SELF' => -13,
			'OP01_PRINT' => -13,
			'VARIABLE_SYMBOL' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"while" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"use constant" => -13,
			'LITERAL_NUMBER' => -13,
			'MY' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"if" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_CLOSE' => -13,
			"foreach" => -13,
			"for" => -13,
			"undef" => -13,
			'LBRACKET' => -13,
			'SUB' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			"\@{" => -13
		},
		GOTOS => {
			'Include' => 81,
			'STAR-6' => 80
		}
	},
	{#State 68
		DEFAULT => -8
	},
	{#State 69
		DEFAULT => -37
	},
	{#State 70
		ACTIONS => {
			'OUR' => 82
		}
	},
	{#State 71
		ACTIONS => {
			"use constant" => -69,
			"our hashref \$properties" => -69,
			'USE_EXPORTER' => 33,
			"INIT" => -69,
			'USE' => -69,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'OPTIONAL-29' => 85,
			'Critic' => 84,
			'Exports' => 83
		}
	},
	{#State 72
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 86
		}
	},
	{#State 73
		ACTIONS => {
			'LBRACE' => 87
		}
	},
	{#State 74
		ACTIONS => {
			";" => 88
		}
	},
	{#State 75
		DEFAULT => -34
	},
	{#State 76
		ACTIONS => {
			'OP20_HASH_FATARROW' => 89
		}
	},
	{#State 77
		ACTIONS => {
			";" => 90
		}
	},
	{#State 78
		DEFAULT => -50
	},
	{#State 79
		DEFAULT => -46
	},
	{#State 80
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'LBRACE' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 63,
			'LITERAL_NUMBER' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"while" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			'OP01_OPEN' => -15,
			'SELF' => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			"undef" => -15,
			"for" => -15,
			'SUB' => -15,
			'LBRACKET' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			"\@{" => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'MY' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID' => -15,
			"if" => -15
		},
		GOTOS => {
			'STAR-7' => 91,
			'Constant' => 92
		}
	},
	{#State 81
		DEFAULT => -10
	},
	{#State 82
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 93
		}
	},
	{#State 83
		DEFAULT => -68
	},
	{#State 84
		DEFAULT => -66
	},
	{#State 85
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 94
		}
	},
	{#State 86
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 96
		},
		GOTOS => {
			'OPTIONAL-23' => 95
		}
	},
	{#State 87
		ACTIONS => {
			'LBRACE' => 97
		}
	},
	{#State 88
		DEFAULT => -36
	},
	{#State 89
		ACTIONS => {
			'MY' => 99
		},
		GOTOS => {
			'TypeInnerConstant' => 98
		}
	},
	{#State 90
		DEFAULT => -54
	},
	{#State 91
		ACTIONS => {
			"while" => -171,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'OP01_NAMED' => 133,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 130,
			'LBRACE' => 128,
			'OP01_PRINT' => 153,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP19_LOOP_CONTROL' => 149,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_NAMED_SCOLON' => 114,
			'WORD' => 29,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			'SUB' => 59,
			"for" => -171,
			"undef" => 100,
			'OP01_NAMED_VOID' => 127,
			"if" => 126,
			'OP01_CLOSE' => 124,
			"foreach" => -171,
			'WORD_UPPERCASE' => 121,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'MY' => 116
		},
		GOTOS => {
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'Subroutine' => 134,
			'Conditional' => 106,
			'LoopLabel' => 136,
			'Statement' => 135,
			'WordScoped' => 107,
			'OperatorVoid' => 108,
			'Literal' => 103,
			'PAREN-45' => 129,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 102,
			'Operation' => 131,
			'Operator' => 123,
			'OPTIONAL-46' => 125,
			'PLUS-8' => 152,
			'VariableDeclaration' => 122,
			'Expression' => 118,
			'HashDereference' => 119,
			'Variable' => 145,
			'HashReference' => 115,
			'VariableModification' => 142
		}
	},
	{#State 92
		DEFAULT => -12
	},
	{#State 93
		DEFAULT => -39
	},
	{#State 94
		ACTIONS => {
			"INIT" => 47,
			'USE' => 49,
			"use constant" => -73,
			"our hashref \$properties" => -73
		},
		GOTOS => {
			'Include' => 154,
			'STAR-31' => 155
		}
	},
	{#State 95
		ACTIONS => {
			")" => 156
		}
	},
	{#State 96
		DEFAULT => -52
	},
	{#State 97
		ACTIONS => {
			'MY' => 157
		}
	},
	{#State 98
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'Literal' => 158
		}
	},
	{#State 99
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'TYPE_INTEGER' => 161,
			'WORD' => 159
		},
		GOTOS => {
			'Type' => 160
		}
	},
	{#State 100
		DEFAULT => -156
	},
	{#State 101
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 163
		}
	},
	{#State 102
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168
		}
	},
	{#State 103
		DEFAULT => -157
	},
	{#State 104
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			"]" => -216,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137
		},
		GOTOS => {
			'HashReference' => 115,
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101,
			'ListElement' => 186,
			'Variable' => 183,
			'Literal' => 103,
			'Expression' => 189,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'OPTIONAL-55' => 191,
			'ListElements' => 192,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112
		}
	},
	{#State 105
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 193,
			'HashReference' => 115,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103
		}
	},
	{#State 106
		DEFAULT => -172
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 194,
			'OP02_METHOD_THINARROW_NEW' => 195
		}
	},
	{#State 108
		DEFAULT => -174
	},
	{#State 109
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 196,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107
		}
	},
	{#State 110
		DEFAULT => -255
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 151,
			'LBRACKET' => -219,
			'SELF' => 147,
			'MY' => 187
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'TypeInner' => 199,
			'OPTIONAL-56' => 198,
			'Variable' => 197
		}
	},
	{#State 112
		DEFAULT => -159
	},
	{#State 113
		DEFAULT => -160
	},
	{#State 114
		DEFAULT => -96
	},
	{#State 115
		DEFAULT => -161
	},
	{#State 116
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'TYPE_FHREF' => 200,
			'TYPE_INTEGER' => 161,
			'WORD' => 159
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 117
		DEFAULT => -141
	},
	{#State 118
		ACTIONS => {
			'OP17_LIST_RANGE' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP18_TERNARY' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_STRING_CAT' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP04_MATH_POW' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			";" => 202
		}
	},
	{#State 119
		DEFAULT => -162
	},
	{#State 120
		DEFAULT => -137
	},
	{#State 121
		ACTIONS => {
			'COLON' => -239,
			'LPAREN' => 203
		}
	},
	{#State 122
		DEFAULT => -175
	},
	{#State 123
		DEFAULT => -149
	},
	{#State 124
		ACTIONS => {
			'FHREF_SYMBOL' => 204
		}
	},
	{#State 125
		ACTIONS => {
			"for" => 205,
			"foreach" => 208,
			"while" => 210
		},
		GOTOS => {
			'LoopFor' => 207,
			'LoopWhile' => 211,
			'LoopForEach' => 209,
			'Loop' => 206
		}
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 212
		}
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'HashReference' => 115,
			'HashDereference' => 119,
			'TypeInner' => 188,
			'Expression' => 189,
			'Literal' => 103,
			'ListElement' => 186,
			'Variable' => 183,
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ListElements' => 213,
			'ArrayDereference' => 113
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 218,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110,
			'OP11_COMPARE_LT_GT' => 229,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP01_NAMED' => 228,
			'ENV' => 215,
			'OP19_LOOP_CONTROL' => 238,
			'OP01_OPEN' => 237,
			"%{" => 146,
			'SELF' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP01_PRINT' => 234,
			'OP01_NAMED_VOID' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_CLOSE' => 223,
			'VARIABLE_SYMBOL' => 151,
			"}" => 222,
			'OP10_NAMED_UNARY' => 233,
			'OP08_MATH_ADD_SUB' => 219,
			'OP22_LOGICAL_NEG' => 232,
			'OP19_LOOP_CONTROL_SCOLON' => 220
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'OpStringOrWord' => 227,
			'HashDereference' => 221,
			'VarOrLitOrOpStrOrWord' => 235,
			'HashEntry' => 217,
			'Variable' => 231,
			'Literal' => 214
		}
	},
	{#State 129
		DEFAULT => -170
	},
	{#State 130
		DEFAULT => -97
	},
	{#State 131
		DEFAULT => -17
	},
	{#State 132
		ACTIONS => {
			")" => -134,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'OPTIONAL-41' => 239,
			'Expression' => 189,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183,
			'ListElement' => 186,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'ListElements' => 240
		}
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140
		},
		GOTOS => {
			'ListElement' => 242,
			'Variable' => 183,
			'Literal' => 103,
			'Expression' => 189,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 241,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'WordScoped' => 107
		}
	},
	{#State 134
		DEFAULT => -14
	},
	{#State 135
		DEFAULT => -98
	},
	{#State 136
		ACTIONS => {
			'COLON' => 243
		}
	},
	{#State 137
		ACTIONS => {
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 244,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115
		}
	},
	{#State 138
		DEFAULT => -254
	},
	{#State 139
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140
		},
		GOTOS => {
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 245,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 151,
			'SELF' => 147
		},
		GOTOS => {
			'Variable' => 246,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 141
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -117,
			'LBRACKET' => 104,
			'OP09_BITWISE_SHIFT' => -117,
			"undef" => 100,
			'OP04_MATH_POW' => -117,
			'OP15_LOGICAL_AND' => -117,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'WORD_UPPERCASE' => 190,
			"}" => -117,
			'OP01_CLOSE' => 124,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP01_NAMED' => 181,
			'OP07_STRING_REPEAT' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			'LBRACE' => 128,
			'OP13_BITWISE_AND' => -117,
			'WORD_SCOPED' => 30,
			'OP11_COMPARE_LT_GT' => -117,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_MATH_NEG_LPAREN' => 137,
			";" => -117,
			'OP22_LOGICAL_NEG' => 143,
			"]" => -117,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141,
			")" => -117,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP18_TERNARY' => -117,
			'VARIABLE_SYMBOL' => 151,
			'OP06_REGEX_BIND' => -117,
			"%{" => 146,
			'SELF' => 147,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP01_OPEN' => 148,
			'OP08_STRING_CAT' => -117
		},
		GOTOS => {
			'SubExpression' => 247,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 142
		ACTIONS => {
			";" => 248
		}
	},
	{#State 143
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'WordScoped' => 107,
			'Variable' => 183,
			'Literal' => 103,
			'Expression' => 189,
			'HashDereference' => 119,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 249
		}
	},
	{#State 144
		ACTIONS => {
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 252,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'OP01_PRINT' => 251,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 250,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107
		}
	},
	{#State 145
		ACTIONS => {
			'OP15_LOGICAL_AND' => -158,
			'OP19_VARIABLE_ASSIGN' => 253,
			'OP11_COMPARE_LT_GT' => -158,
			'OP04_MATH_POW' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 256,
			'OP13_BITWISE_AND' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP03_MATH_INC_DEC' => 255,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP08_STRING_CAT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP02_METHOD_THINARROW' => 254,
			'OP06_REGEX_BIND' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP18_TERNARY' => -158
		}
	},
	{#State 146
		ACTIONS => {
			'VARIABLE_SYMBOL' => 151,
			'MY' => 187,
			'LBRACE' => -234,
			'SELF' => 147
		},
		GOTOS => {
			'TypeInner' => 258,
			'Variable' => 257,
			'VariableSymbolOrSelf' => 101,
			'OPTIONAL-60' => 259
		}
	},
	{#State 147
		DEFAULT => -253
	},
	{#State 148
		ACTIONS => {
			'MY' => 260
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_UPPERCASE' => 262
		},
		GOTOS => {
			'LoopLabel' => 261
		}
	},
	{#State 150
		DEFAULT => -151
	},
	{#State 151
		DEFAULT => -252
	},
	{#State 152
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'OP03_MATH_INC_DEC' => 140,
			"while" => -171,
			'OP05_LOGICAL_NEG' => 139,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'OP01_NAMED' => 133,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 130,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_PRINT' => 153,
			'OP19_LOOP_CONTROL' => 149,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP01_NAMED_SCOLON' => 114,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			"for" => -171,
			'' => -18,
			"undef" => 100,
			"if" => 126,
			'OP01_NAMED_VOID' => 127,
			'OP01_CLOSE' => 124,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'WORD_UPPERCASE' => 121,
			'MY' => 116
		},
		GOTOS => {
			'PAREN-45' => 129,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 102,
			'Operation' => 263,
			'Literal' => 103,
			'LoopLabel' => 136,
			'Statement' => 135,
			'Conditional' => 106,
			'WordScoped' => 107,
			'OperatorVoid' => 108,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'HashReference' => 115,
			'VariableModification' => 142,
			'Expression' => 118,
			'HashDereference' => 119,
			'Variable' => 145,
			'VariableDeclaration' => 122,
			'Operator' => 123,
			'OPTIONAL-46' => 125
		}
	},
	{#State 153
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -132,
			'VARIABLE_SYMBOL' => -132,
			'OP01_CLOSE' => -132,
			'ARGV' => -132,
			"%{" => -132,
			'SELF' => -132,
			'OP01_OPEN' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'OP01_QW' => -132,
			'LPAREN' => -132,
			'WORD_UPPERCASE' => -132,
			'OP10_NAMED_UNARY' => -132,
			'MY' => -132,
			'FHREF_SYMBOL_BRACES' => 266,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			"\@{" => -132,
			'LITERAL_STRING' => -132,
			'LITERAL_NUMBER' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'WORD' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'OP01_NAMED' => -132,
			'STDOUT_STDERR' => 265,
			'LBRACKET' => -132,
			'LBRACE' => -132,
			"undef" => -132,
			'WORD_SCOPED' => -132
		},
		GOTOS => {
			'PAREN-39' => 264,
			'OPTIONAL-40' => 267
		}
	},
	{#State 154
		DEFAULT => -70
	},
	{#State 155
		ACTIONS => {
			"our hashref \$properties" => 269,
			"use constant" => 63
		},
		GOTOS => {
			'Constant' => 270,
			'Properties' => 268
		}
	},
	{#State 156
		ACTIONS => {
			";" => 271
		}
	},
	{#State 157
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'WORD' => 159,
			'TYPE_INTEGER' => 161
		},
		GOTOS => {
			'Type' => 272
		}
	},
	{#State 158
		ACTIONS => {
			";" => 273
		}
	},
	{#State 159
		DEFAULT => -240
	},
	{#State 160
		ACTIONS => {
			"\$TYPED_" => 274
		}
	},
	{#State 161
		DEFAULT => -242
	},
	{#State 162
		DEFAULT => -241
	},
	{#State 163
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -197,
			'OP02_ARRAY_THINARROW' => 276,
			'OP08_STRING_CAT' => -197,
			'OP18_TERNARY' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP02_HASH_THINARROW' => 277,
			'OP02_METHOD_THINARROW' => -197,
			"}" => -197,
			")" => -197,
			'OP16_LOGICAL_OR' => -197,
			"]" => -197,
			'OP17_LIST_RANGE' => -197,
			'OP08_MATH_ADD_SUB' => -197,
			";" => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			'COLON' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP13_BITWISE_AND' => -197,
			'OP21_LIST_COMMA' => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP11_COMPARE_LT_GT' => -197,
			'OP15_LOGICAL_AND' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			'OP04_MATH_POW' => -197,
			'OP12_COMPARE_EQ_NE' => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP07_STRING_REPEAT' => -197
		},
		GOTOS => {
			'VariableRetrieval' => 275
		}
	},
	{#State 164
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 278,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 165
		ACTIONS => {
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100
		},
		GOTOS => {
			'SubExpression' => 279,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 166
		ACTIONS => {
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107,
			'Literal' => 103,
			'Variable' => 183,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 280,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 167
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 281,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 168
		ACTIONS => {
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151
		},
		GOTOS => {
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183,
			'SubExpression' => 282,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115
		}
	},
	{#State 169
		ACTIONS => {
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105
		},
		GOTOS => {
			'HashReference' => 115,
			'SubExpression' => 283,
			'VariableSymbolOrSelf' => 101,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 170
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 284
		}
	},
	{#State 171
		ACTIONS => {
			'VARIABLE_SYMBOL' => 151,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110,
			'SELF' => 147
		},
		GOTOS => {
			'Variable' => 286,
			'Literal' => 287,
			'VariableSymbolOrSelf' => 101,
			'VariableOrLiteral' => 285
		}
	},
	{#State 172
		ACTIONS => {
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 288
		}
	},
	{#State 173
		ACTIONS => {
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'HashReference' => 115,
			'SubExpression' => 289,
			'VariableSymbolOrSelf' => 101,
			'Variable' => 183,
			'Literal' => 103,
			'Expression' => 189,
			'HashDereference' => 119
		}
	},
	{#State 174
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 290,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 291,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 176
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 292,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 177
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 293,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 178
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 294,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183
		}
	},
	{#State 179
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137
		},
		GOTOS => {
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183,
			'SubExpression' => 295,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115
		}
	},
	{#State 180
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 296,
			'Literal' => 103,
			'Variable' => 183,
			'Expression' => 189,
			'HashDereference' => 119
		}
	},
	{#State 181
		ACTIONS => {
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 297,
			'HashReference' => 115,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 182
		DEFAULT => -213
	},
	{#State 183
		ACTIONS => {
			"}" => -158,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			"]" => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP08_STRING_CAT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP02_METHOD_THINARROW' => 254,
			'OP18_TERNARY' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP04_MATH_POW' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP21_LIST_COMMA' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			";" => -158,
			'OP03_MATH_INC_DEC' => 255
		}
	},
	{#State 184
		DEFAULT => -214
	},
	{#State 185
		ACTIONS => {
			")" => -211,
			'OP17_LIST_RANGE' => 179,
			"]" => -211,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 165,
			'OP21_LIST_COMMA' => -211,
			'OP09_BITWISE_SHIFT' => 175,
			'OP13_BITWISE_AND' => 166,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -211
		}
	},
	{#State 186
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 298
		}
	},
	{#State 187
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'WORD' => 159,
			'TYPE_INTEGER' => 161
		},
		GOTOS => {
			'Type' => 299
		}
	},
	{#State 188
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 300,
			'HashReference' => 115,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103
		}
	},
	{#State 189
		DEFAULT => -155
	},
	{#State 190
		ACTIONS => {
			'LPAREN' => 203
		}
	},
	{#State 191
		ACTIONS => {
			"]" => 301
		}
	},
	{#State 192
		DEFAULT => -215
	},
	{#State 193
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			")" => 302,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP18_TERNARY' => 171,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 175,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 194
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'ARGV' => 184,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			")" => -144,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 143
		},
		GOTOS => {
			'WordScoped' => 107,
			'ListElements' => 304,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'OPTIONAL-42' => 303,
			'HashReference' => 115,
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101,
			'Literal' => 103,
			'Variable' => 183,
			'ListElement' => 186,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Expression' => 189
		}
	},
	{#State 195
		ACTIONS => {
			")" => -148,
			'LBRACE' => 128
		},
		GOTOS => {
			'OPTIONAL-44' => 306,
			'HashReference' => 305
		}
	},
	{#State 196
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 175,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178,
			")" => 307,
			'OP18_TERNARY' => 171,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168
		}
	},
	{#State 197
		ACTIONS => {
			"}" => 308
		}
	},
	{#State 198
		ACTIONS => {
			'LBRACKET' => 104
		},
		GOTOS => {
			'ArrayReference' => 309
		}
	},
	{#State 199
		DEFAULT => -218
	},
	{#State 200
		ACTIONS => {
			'FHREF_SYMBOL' => 310
		}
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 311
		}
	},
	{#State 202
		DEFAULT => -95
	},
	{#State 203
		ACTIONS => {
			")" => 312
		}
	},
	{#State 204
		DEFAULT => -103
	},
	{#State 205
		ACTIONS => {
			'MY' => 313,
			'LPAREN_MY' => 314
		}
	},
	{#State 206
		DEFAULT => -173
	},
	{#State 207
		DEFAULT => -184
	},
	{#State 208
		ACTIONS => {
			'MY' => 315
		}
	},
	{#State 209
		DEFAULT => -185
	},
	{#State 210
		ACTIONS => {
			'LPAREN_MY' => 317,
			'LPAREN' => 316
		}
	},
	{#State 211
		DEFAULT => -186
	},
	{#State 212
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 318,
			'Literal' => 103,
			'Variable' => 183,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 213
		ACTIONS => {
			";" => 319
		}
	},
	{#State 214
		DEFAULT => -250
	},
	{#State 215
		DEFAULT => -226
	},
	{#State 216
		DEFAULT => -267
	},
	{#State 217
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 320
		}
	},
	{#State 218
		DEFAULT => -278
	},
	{#State 219
		DEFAULT => -270
	},
	{#State 220
		DEFAULT => -265
	},
	{#State 221
		DEFAULT => -225
	},
	{#State 222
		DEFAULT => -232
	},
	{#State 223
		DEFAULT => -274
	},
	{#State 224
		DEFAULT => -262
	},
	{#State 225
		DEFAULT => -276
	},
	{#State 226
		DEFAULT => -272
	},
	{#State 227
		DEFAULT => -251
	},
	{#State 228
		DEFAULT => -273
	},
	{#State 229
		DEFAULT => -268
	},
	{#State 230
		DEFAULT => -263
	},
	{#State 231
		DEFAULT => -249
	},
	{#State 232
		DEFAULT => -264
	},
	{#State 233
		DEFAULT => -269
	},
	{#State 234
		DEFAULT => -277
	},
	{#State 235
		ACTIONS => {
			'OP20_HASH_FATARROW' => 321
		}
	},
	{#State 236
		DEFAULT => -271
	},
	{#State 237
		DEFAULT => -275
	},
	{#State 238
		DEFAULT => -266
	},
	{#State 239
		ACTIONS => {
			")" => 322
		}
	},
	{#State 240
		DEFAULT => -133
	},
	{#State 241
		ACTIONS => {
			";" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP21_LIST_COMMA' => -211,
			'OP09_BITWISE_SHIFT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_STRING_CAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP18_TERNARY' => -100,
			")" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP17_LIST_RANGE' => -100
		}
	},
	{#State 242
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 243
		DEFAULT => -169
	},
	{#State 244
		ACTIONS => {
			'OP18_TERNARY' => 171,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			")" => 324,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174
		}
	},
	{#State 245
		ACTIONS => {
			")" => -108,
			"}" => -108,
			'OP17_LIST_RANGE' => -108,
			"]" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP08_STRING_CAT' => -108,
			'OP18_TERNARY' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP07_STRING_REPEAT' => -108,
			";" => -108,
			'OP14_BITWISE_OR_XOR' => -108
		}
	},
	{#State 246
		DEFAULT => -104
	},
	{#State 247
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP09_BITWISE_SHIFT' => 175,
			'OP21_LIST_COMMA' => -116,
			'OP23_LOGICAL_AND' => -116,
			";" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP08_MATH_ADD_SUB' => 178,
			"]" => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP17_LIST_RANGE' => -116,
			"}" => -116,
			")" => -116,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169
		}
	},
	{#State 248
		DEFAULT => -176
	},
	{#State 249
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 175,
			'OP21_LIST_COMMA' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP13_BITWISE_AND' => 166,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -127,
			")" => -127,
			"}" => -127,
			'OP17_LIST_RANGE' => 179,
			"]" => -127,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -127
		}
	},
	{#State 250
		ACTIONS => {
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			")" => 325,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177
		}
	},
	{#State 251
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 326
		}
	},
	{#State 252
		ACTIONS => {
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 241,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'TypeInner' => 188,
			'Variable' => 183,
			'Literal' => 103,
			'ListElement' => 327
		}
	},
	{#State 253
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'STDIN' => 330,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'FHREF_SYMBOL_IN' => 331,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150
		},
		GOTOS => {
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'SubExpressionOrInput' => 329,
			'WordScoped' => 107,
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 328,
			'HashReference' => 115
		}
	},
	{#State 254
		ACTIONS => {
			'LPAREN' => 332
		}
	},
	{#State 255
		DEFAULT => -105
	},
	{#State 256
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 333,
			'HashReference' => 115
		}
	},
	{#State 257
		ACTIONS => {
			"}" => 334
		}
	},
	{#State 258
		DEFAULT => -233
	},
	{#State 259
		ACTIONS => {
			'LBRACE' => 128
		},
		GOTOS => {
			'HashReference' => 335
		}
	},
	{#State 260
		ACTIONS => {
			'TYPE_FHREF' => 336
		}
	},
	{#State 261
		ACTIONS => {
			";" => 337
		}
	},
	{#State 262
		DEFAULT => -239
	},
	{#State 263
		DEFAULT => -16
	},
	{#State 264
		DEFAULT => -131
	},
	{#State 265
		DEFAULT => -130
	},
	{#State 266
		ACTIONS => {
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151
		},
		GOTOS => {
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'ListElement' => 186,
			'Variable' => 183,
			'Literal' => 103,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'ListElements' => 338,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 267
		ACTIONS => {
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181
		},
		GOTOS => {
			'WordScoped' => 107,
			'ListElements' => 339,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'Literal' => 103,
			'ListElement' => 186,
			'Variable' => 183,
			'Expression' => 189,
			'HashDereference' => 119,
			'TypeInner' => 188
		}
	},
	{#State 268
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 340
		}
	},
	{#State 269
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 341
		}
	},
	{#State 270
		DEFAULT => -72
	},
	{#State 271
		ACTIONS => {
			"}" => 342
		}
	},
	{#State 272
		ACTIONS => {
			"\$RETURN_TYPE" => 343
		}
	},
	{#State 273
		DEFAULT => -56
	},
	{#State 274
		ACTIONS => {
			'WORD_UPPERCASE' => 344
		}
	},
	{#State 275
		DEFAULT => -195
	},
	{#State 276
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141
		},
		GOTOS => {
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'SubExpression' => 345,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103
		}
	},
	{#State 277
		ACTIONS => {
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 347,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'SubExpression' => 346,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 183
		}
	},
	{#State 278
		ACTIONS => {
			"]" => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP17_LIST_RANGE' => -118,
			'OP08_MATH_ADD_SUB' => 178,
			"}" => -118,
			")" => -118,
			'OP18_TERNARY' => -118,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP09_BITWISE_SHIFT' => 175,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -118,
			";" => -118,
			'OP14_BITWISE_OR_XOR' => -118
		}
	},
	{#State 279
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 178,
			"]" => -128,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			"}" => -128,
			")" => -128,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP18_TERNARY' => 171,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 166,
			'OP23_LOGICAL_AND' => -128,
			'OP21_LIST_COMMA' => -128,
			'OP09_BITWISE_SHIFT' => 175,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -128
		}
	},
	{#State 280
		ACTIONS => {
			"]" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP17_LIST_RANGE' => -120,
			'OP08_MATH_ADD_SUB' => 178,
			"}" => -120,
			")" => -120,
			'OP18_TERNARY' => -120,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			";" => -120,
			'OP14_BITWISE_OR_XOR' => -120
		}
	},
	{#State 281
		ACTIONS => {
			";" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP08_STRING_CAT' => -111,
			'OP18_TERNARY' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP06_REGEX_BIND' => 170,
			")" => -111,
			"}" => -111,
			'OP17_LIST_RANGE' => -111,
			'OP16_LOGICAL_OR' => -111,
			"]" => -111,
			'OP08_MATH_ADD_SUB' => -111
		}
	},
	{#State 282
		ACTIONS => {
			";" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => -114,
			'OP18_TERNARY' => -114,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -114,
			"}" => -114,
			")" => -114,
			'OP16_LOGICAL_OR' => -114,
			"]" => -114,
			'OP17_LIST_RANGE' => -114,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 283
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -112,
			";" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP08_STRING_CAT' => -112,
			'OP18_TERNARY' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP06_REGEX_BIND' => 170,
			")" => -112,
			"}" => -112,
			'OP17_LIST_RANGE' => -112,
			'OP16_LOGICAL_OR' => -112,
			"]" => -112,
			'OP08_MATH_ADD_SUB' => -112
		}
	},
	{#State 284
		DEFAULT => -110
	},
	{#State 285
		ACTIONS => {
			'COLON' => 348
		}
	},
	{#State 286
		DEFAULT => -247
	},
	{#State 287
		DEFAULT => -248
	},
	{#State 288
		ACTIONS => {
			";" => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP21_LIST_COMMA' => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => -121,
			'OP11_COMPARE_LT_GT' => 164,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP06_REGEX_BIND' => 170,
			"}" => -121,
			")" => -121,
			"]" => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP17_LIST_RANGE' => -121,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 289
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => -122,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP21_LIST_COMMA' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -122,
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => -122,
			"]" => -122,
			'OP17_LIST_RANGE' => -122,
			"}" => -122,
			")" => -122,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP18_TERNARY' => -122,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169
		}
	},
	{#State 290
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -106,
			";" => -106,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP08_STRING_CAT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			"}" => -106,
			")" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			"]" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP17_LIST_RANGE' => -106
		}
	},
	{#State 291
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -115,
			";" => -115,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP18_TERNARY' => -115,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => -115,
			"]" => -115,
			'OP16_LOGICAL_OR' => -115,
			")" => -115,
			"}" => -115
		}
	},
	{#State 292
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP18_TERNARY' => -119,
			")" => -119,
			"}" => -119,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => -119,
			'OP16_LOGICAL_OR' => -119,
			"]" => -119,
			";" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP21_LIST_COMMA' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP09_BITWISE_SHIFT' => 175,
			'OP13_BITWISE_AND' => -119,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 293
		ACTIONS => {
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP13_BITWISE_AND' => 166,
			'OP21_LIST_COMMA' => -129,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -129,
			"}" => -129,
			")" => -129,
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => 180,
			"]" => -129,
			'OP17_LIST_RANGE' => 179,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP18_TERNARY' => 171
		}
	},
	{#State 294
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			";" => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP17_LIST_RANGE' => -113,
			"]" => -113,
			'OP16_LOGICAL_OR' => -113,
			")" => -113,
			"}" => -113,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP18_TERNARY' => -113,
			'OP08_STRING_CAT' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 169
		}
	},
	{#State 295
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP06_REGEX_BIND' => 170,
			'OP18_TERNARY' => -124,
			"}" => -124,
			")" => -124,
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => 180,
			"]" => -124,
			'OP17_LIST_RANGE' => undef,
			";" => -124,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP13_BITWISE_AND' => 166,
			'OP21_LIST_COMMA' => -124,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => -124,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 296
		ACTIONS => {
			'OP18_TERNARY' => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP06_REGEX_BIND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP17_LIST_RANGE' => -123,
			"]" => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP08_MATH_ADD_SUB' => 178,
			")" => -123,
			"}" => -123,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -123,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -123,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => -123,
			'OP13_BITWISE_AND' => 166,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174
		}
	},
	{#State 297
		ACTIONS => {
			'OP04_MATH_POW' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			";" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"}" => -100,
			")" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100
		}
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 350,
			";" => -210,
			")" => -210,
			"]" => -210
		},
		GOTOS => {
			'PAREN-53' => 349
		}
	},
	{#State 299
		ACTIONS => {
			"\$TYPED_" => 351
		}
	},
	{#State 300
		ACTIONS => {
			";" => -212,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP21_LIST_COMMA' => -212,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			")" => -212,
			"]" => -212,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 301
		DEFAULT => -217
	},
	{#State 302
		DEFAULT => -107
	},
	{#State 303
		ACTIONS => {
			")" => 352
		}
	},
	{#State 304
		DEFAULT => -143
	},
	{#State 305
		DEFAULT => -147
	},
	{#State 306
		ACTIONS => {
			")" => 353
		}
	},
	{#State 307
		DEFAULT => -126
	},
	{#State 308
		DEFAULT => -220
	},
	{#State 309
		ACTIONS => {
			"}" => 354
		}
	},
	{#State 310
		ACTIONS => {
			";" => 355
		}
	},
	{#State 311
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 357,
			'OP19_VARIABLE_ASSIGN' => 358,
			";" => 356
		}
	},
	{#State 312
		DEFAULT => -150
	},
	{#State 313
		ACTIONS => {
			'TYPE_INTEGER' => 359
		}
	},
	{#State 314
		ACTIONS => {
			'TYPE_INTEGER' => 360
		}
	},
	{#State 315
		ACTIONS => {
			'TYPE_INTEGER' => 161,
			'WORD' => 159,
			'WORD_SCOPED' => 162
		},
		GOTOS => {
			'Type' => 361
		}
	},
	{#State 316
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'SubExpression' => 362,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 183
		}
	},
	{#State 317
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'WORD' => 159,
			'TYPE_INTEGER' => 161
		},
		GOTOS => {
			'Type' => 363
		}
	},
	{#State 318
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			")" => 364,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 175,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167
		}
	},
	{#State 319
		DEFAULT => -139
	},
	{#State 320
		ACTIONS => {
			'OP21_LIST_COMMA' => 367,
			"}" => 365
		},
		GOTOS => {
			'PAREN-58' => 366
		}
	},
	{#State 321
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			"\@{" => -223,
			'LITERAL_STRING' => -223,
			'LITERAL_NUMBER' => -223,
			'WORD' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'OP01_NAMED' => -223,
			'LBRACKET' => -223,
			'LBRACE' => -223,
			"undef" => -223,
			'WORD_SCOPED' => -223,
			'CONSTANT_CALL_SCOPED' => -223,
			'VARIABLE_SYMBOL' => -223,
			'OP01_CLOSE' => -223,
			'OP01_OPEN' => -223,
			"%{" => -223,
			'SELF' => -223,
			'OP22_LOGICAL_NEG' => -223,
			'LPAREN' => -223,
			'WORD_UPPERCASE' => -223,
			'OP10_NAMED_UNARY' => -223,
			'MY' => 187
		},
		GOTOS => {
			'OPTIONAL-57' => 369,
			'TypeInner' => 368
		}
	},
	{#State 322
		ACTIONS => {
			";" => 370
		}
	},
	{#State 323
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'ARGV' => 184,
			'OP01_CLOSE' => 124,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29
		},
		GOTOS => {
			'Variable' => 183,
			'Literal' => 103,
			'ListElement' => 186,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101,
			'ListElements' => 371,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107
		}
	},
	{#State 324
		DEFAULT => -109
	},
	{#State 325
		DEFAULT => -163
	},
	{#State 326
		ACTIONS => {
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184
		},
		GOTOS => {
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ListElements' => 372,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'HashReference' => 115,
			'Expression' => 189,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Variable' => 183,
			'ListElement' => 186,
			'Literal' => 103
		}
	},
	{#State 327
		ACTIONS => {
			'OP21_LIST_COMMA' => 373
		}
	},
	{#State 328
		ACTIONS => {
			")" => -164,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -164
		}
	},
	{#State 329
		DEFAULT => -205
	},
	{#State 330
		DEFAULT => -166
	},
	{#State 331
		DEFAULT => -165
	},
	{#State 332
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			'ARGV' => 184,
			'OP10_NAMED_UNARY' => 141,
			'MY' => 187,
			")" => -146,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_QW' => 182,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190
		},
		GOTOS => {
			'ListElements' => 375,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112,
			'WordScoped' => 107,
			'Variable' => 183,
			'Literal' => 103,
			'ListElement' => 186,
			'Expression' => 189,
			'HashDereference' => 119,
			'TypeInner' => 188,
			'OPTIONAL-43' => 374,
			'HashReference' => 115,
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 333
		ACTIONS => {
			")" => -206,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			";" => -206
		}
	},
	{#State 334
		DEFAULT => -235
	},
	{#State 335
		ACTIONS => {
			"}" => 376
		}
	},
	{#State 336
		ACTIONS => {
			'FHREF_SYMBOL' => 377
		}
	},
	{#State 337
		DEFAULT => -142
	},
	{#State 338
		ACTIONS => {
			";" => 378
		}
	},
	{#State 339
		ACTIONS => {
			";" => 379
		}
	},
	{#State 340
		ACTIONS => {
			'SUB' => 380,
			'LITERAL_NUMBER' => 383
		},
		GOTOS => {
			'Subroutine' => 384,
			'SubroutineOrMethod' => 381,
			'Method' => 382
		}
	},
	{#State 341
		ACTIONS => {
			'LBRACE' => 385
		}
	},
	{#State 342
		DEFAULT => -55
	},
	{#State 343
		ACTIONS => {
			"}" => 386
		}
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 387
		}
	},
	{#State 345
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 172,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP18_TERNARY' => 171,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			"]" => 388,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 346
		ACTIONS => {
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP18_TERNARY' => 171,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			"}" => 389,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165
		}
	},
	{#State 347
		ACTIONS => {
			'LPAREN' => -237,
			'OP02_METHOD_THINARROW_NEW' => -237,
			"}" => 390
		}
	},
	{#State 348
		ACTIONS => {
			'SELF' => 147,
			'VARIABLE_SYMBOL' => 151,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'Variable' => 286,
			'Literal' => 287,
			'VariableOrLiteral' => 391,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 349
		DEFAULT => -208
	},
	{#State 350
		ACTIONS => {
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'ARGV' => 184,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 143,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181
		},
		GOTOS => {
			'ListElement' => 392,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'TypeInner' => 188,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 185,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107
		}
	},
	{#State 351
		ACTIONS => {
			'OP10_NAMED_UNARY' => 233,
			'OP22_LOGICAL_NEG' => 232,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			'OP19_LOOP_CONTROL' => 238,
			'OP01_OPEN' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP01_NAMED_VOID' => 225,
			'OP01_PRINT' => 234,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_CLOSE' => 223,
			'OP23_LOGICAL_AND' => 230,
			'OP11_COMPARE_LT_GT' => 229,
			'OP01_NAMED' => 228,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP07_STRING_REPEAT' => 226,
			'WORD' => 218
		},
		GOTOS => {
			'OpStringOrWord' => 393
		}
	},
	{#State 352
		DEFAULT => -152
	},
	{#State 353
		DEFAULT => -154
	},
	{#State 354
		DEFAULT => -221
	},
	{#State 355
		DEFAULT => -204
	},
	{#State 356
		DEFAULT => -201
	},
	{#State 357
		ACTIONS => {
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181
		},
		GOTOS => {
			'Expression' => 189,
			'HashDereference' => 119,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 394,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 358
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 397,
			"undef" => 100,
			'LBRACE' => 128,
			'OP01_NAMED_SCOLON' => 395,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'STDIN' => 330,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'FHREF_SYMBOL_IN' => 331,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 328,
			'HashReference' => 115,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpressionOrInput' => 396,
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'OpNamedScolonOrSubExpIn' => 398,
			'ArrayDereference' => 113
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 399
		}
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 400
		}
	},
	{#State 361
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 362
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			")" => 402,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 403
		}
	},
	{#State 364
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 365
		DEFAULT => -231
	},
	{#State 366
		DEFAULT => -229
	},
	{#State 367
		ACTIONS => {
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'WORD' => 218,
			'ENV' => 215,
			'OP01_NAMED' => 228,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 230,
			'OP11_COMPARE_LT_GT' => 229,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 223,
			'OP01_PRINT' => 234,
			'OP01_NAMED_VOID' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP19_LOOP_CONTROL' => 238,
			'OP22_LOGICAL_NEG' => 232,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			'OP10_NAMED_UNARY' => 233
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'Literal' => 214,
			'Variable' => 231,
			'VarOrLitOrOpStrOrWord' => 235,
			'HashEntry' => 406,
			'HashDereference' => 221,
			'OpStringOrWord' => 227
		}
	},
	{#State 368
		DEFAULT => -222
	},
	{#State 369
		ACTIONS => {
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP10_NAMED_UNARY' => 141,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 189,
			'Variable' => 183,
			'Literal' => 103,
			'SubExpression' => 407,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115
		}
	},
	{#State 370
		DEFAULT => -138
	},
	{#State 371
		ACTIONS => {
			";" => 408
		}
	},
	{#State 372
		ACTIONS => {
			")" => 409
		}
	},
	{#State 373
		ACTIONS => {
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 143,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'ARGV' => 184,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ListElements' => 410,
			'ArrayReference' => 112,
			'Operator' => 123,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'ListElement' => 186,
			'Variable' => 183,
			'Literal' => 103,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Expression' => 189
		}
	},
	{#State 374
		ACTIONS => {
			")" => 411
		}
	},
	{#State 375
		DEFAULT => -145
	},
	{#State 376
		DEFAULT => -236
	},
	{#State 377
		ACTIONS => {
			'OP21_LIST_COMMA' => 412
		}
	},
	{#State 378
		DEFAULT => -136
	},
	{#State 379
		DEFAULT => -135
	},
	{#State 380
		ACTIONS => {
			'WORD' => 413
		}
	},
	{#State 381
		DEFAULT => -74
	},
	{#State 382
		DEFAULT => -94
	},
	{#State 383
		ACTIONS => {
			";" => 414
		}
	},
	{#State 384
		DEFAULT => -93
	},
	{#State 385
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 216,
			'OP01_NAMED' => 228,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 230,
			'OP11_COMPARE_LT_GT' => 229,
			'WORD' => 218,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP22_LOGICAL_NEG' => 232,
			'OP08_MATH_ADD_SUB' => 219,
			'OP10_NAMED_UNARY' => 233,
			"}" => 417,
			'OP01_CLOSE' => 223,
			'OP01_NAMED_VOID' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_PRINT' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP01_OPEN' => 237,
			'OP19_LOOP_CONTROL' => 238
		},
		GOTOS => {
			'HashEntryProperties' => 416,
			'OpStringOrWord' => 415
		}
	},
	{#State 386
		ACTIONS => {
			";" => 418
		}
	},
	{#State 387
		DEFAULT => -246
	},
	{#State 388
		DEFAULT => -198
	},
	{#State 389
		DEFAULT => -199
	},
	{#State 390
		DEFAULT => -200
	},
	{#State 391
		DEFAULT => -125
	},
	{#State 392
		DEFAULT => -207
	},
	{#State 393
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 419
		}
	},
	{#State 394
		ACTIONS => {
			'OP17_LIST_RANGE' => 179,
			"]" => 420,
			'OP16_LOGICAL_OR' => 180,
			'OP08_MATH_ADD_SUB' => 178,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166,
			'OP04_MATH_POW' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 395
		DEFAULT => -259
	},
	{#State 396
		ACTIONS => {
			";" => 421
		}
	},
	{#State 397
		DEFAULT => -260
	},
	{#State 398
		DEFAULT => -202
	},
	{#State 399
		ACTIONS => {
			'LPAREN' => 422
		}
	},
	{#State 400
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 401
		ACTIONS => {
			'LPAREN' => 424
		}
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 425
		}
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 426
		}
	},
	{#State 404
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 427
		}
	},
	{#State 405
		ACTIONS => {
			'OP01_CLOSE' => 124,
			"foreach" => -171,
			'OP01_NAMED_VOID' => 127,
			"if" => 126,
			'WORD_UPPERCASE' => 121,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'MY' => 116,
			'WORD' => 29,
			'OP01_NAMED_SCOLON' => 114,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			"undef" => 100,
			"for" => -171,
			'OP01_PRINT' => 153,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'SELF' => 147,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'OP19_LOOP_CONTROL' => 149,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP05_LOGICAL_NEG' => 139,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'OP01_NAMED' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 130,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'OPTIONAL-46' => 125,
			'Operator' => 123,
			'VariableDeclaration' => 122,
			'Variable' => 145,
			'HashDereference' => 119,
			'Expression' => 118,
			'VariableModification' => 142,
			'HashReference' => 115,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'OperatorVoid' => 108,
			'PLUS-51' => 429,
			'WordScoped' => 107,
			'LoopLabel' => 136,
			'Conditional' => 106,
			'Statement' => 135,
			'Literal' => 103,
			'Operation' => 428,
			'SubExpression' => 102,
			'PAREN-45' => 129,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 406
		DEFAULT => -228
	},
	{#State 407
		ACTIONS => {
			'OP13_BITWISE_AND' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP21_LIST_COMMA' => -224,
			'OP09_BITWISE_SHIFT' => 175,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172,
			"}" => -224,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177
		}
	},
	{#State 408
		DEFAULT => -140
	},
	{#State 409
		DEFAULT => -99
	},
	{#State 410
		ACTIONS => {
			")" => 430
		}
	},
	{#State 411
		DEFAULT => -153
	},
	{#State 412
		ACTIONS => {
			'LITERAL_STRING' => 431
		}
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 432
		}
	},
	{#State 414
		DEFAULT => -76
	},
	{#State 415
		ACTIONS => {
			'OP20_HASH_FATARROW' => 433
		}
	},
	{#State 416
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 434
		}
	},
	{#State 417
		ACTIONS => {
			";" => 435
		}
	},
	{#State 418
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -58,
			'WORD_UPPERCASE' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'MY' => -58,
			"}" => -58,
			"foreach" => -58,
			'OP01_CLOSE' => -58,
			'OP01_NAMED_VOID' => -58,
			"if" => -58,
			'LPAREN_MY' => 437,
			'LBRACKET' => -58,
			"undef" => -58,
			"for" => -58,
			'WORD' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'LITERAL_STRING' => -58,
			"\@{" => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'LPAREN' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP01_PRINT' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'VARIABLE_SYMBOL' => -58,
			"%{" => -58,
			'SELF' => -58,
			'OP01_OPEN' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP01_NAMED' => -58,
			'LBRACE' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'WORD_SCOPED' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP03_MATH_INC_DEC' => -58,
			"while" => -58,
			'LITERAL_NUMBER' => -58,
			'OP05_MATH_NEG_LPAREN' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 436,
			'OPTIONAL-24' => 438
		}
	},
	{#State 419
		DEFAULT => -243
	},
	{#State 420
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 439
		}
	},
	{#State 421
		DEFAULT => -261
	},
	{#State 422
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147
		},
		GOTOS => {
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 440,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189
		}
	},
	{#State 423
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 444,
			"undef" => 100,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP01_NAMED_SCOLON' => 441,
			'OP03_MATH_INC_DEC' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 183,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 442,
			'HashReference' => 115,
			'ArrayReference' => 112,
			'Operator' => 123,
			'OpNamedScolonOrSubExp' => 443,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 424
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'MY' => 187,
			'OP10_NAMED_UNARY' => 141,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 143,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'ARGV' => 184,
			'OP01_CLOSE' => 124,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150
		},
		GOTOS => {
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 185,
			'Variable' => 183,
			'Literal' => 103,
			'ListElement' => 186,
			'TypeInner' => 188,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ListElements' => 445,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 425
		DEFAULT => -190
	},
	{#State 426
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'STDIN' => 330,
			'LITERAL_NUMBER' => 138,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'FHREF_SYMBOL_IN' => 331,
			'WORD_UPPERCASE' => 190,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123,
			'WordScoped' => 107,
			'SubExpressionOrInput' => 446,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'HashReference' => 115,
			'SubExpression' => 328,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 427
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -182,
			"while" => -182,
			'OP03_MATH_INC_DEC' => -182,
			'LITERAL_NUMBER' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			'OP01_NAMED' => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			'LBRACE' => -182,
			'WORD_SCOPED' => -182,
			'OP01_PRINT' => -182,
			"elsif" => 450,
			'CONSTANT_CALL_SCOPED' => -182,
			'VARIABLE_SYMBOL' => -182,
			'SELF' => -182,
			"%{" => -182,
			'OP01_OPEN' => -182,
			"else" => 451,
			'OP19_LOOP_CONTROL' => -182,
			'LPAREN' => -182,
			'OP22_LOGICAL_NEG' => -182,
			'OP10_NAMED_UNARY' => -182,
			'WORD' => -182,
			'OP01_NAMED_SCOLON' => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			"\@{" => -182,
			'LITERAL_STRING' => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			'LBRACKET' => -182,
			"undef" => -182,
			'' => -182,
			"for" => -182,
			"foreach" => -182,
			'OP01_CLOSE' => -182,
			"if" => -182,
			'OP01_NAMED_VOID' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'WORD_UPPERCASE' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'MY' => -182,
			"}" => -182
		},
		GOTOS => {
			'PAREN-49' => 448,
			'PAREN-47' => 447,
			'OPTIONAL-50' => 449
		}
	},
	{#State 428
		DEFAULT => -193
	},
	{#State 429
		ACTIONS => {
			'OP01_CLOSE' => 124,
			"foreach" => -171,
			'OP01_NAMED_VOID' => 127,
			"if" => 126,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'WORD_UPPERCASE' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'MY' => 116,
			"}" => 452,
			'WORD' => 29,
			'OP01_NAMED_SCOLON' => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			"undef" => 100,
			"for" => -171,
			'OP01_PRINT' => 153,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP19_LOOP_CONTROL' => 149,
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			"while" => -171,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'OP01_NAMED' => 133,
			'LBRACE' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 130,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Literal' => 103,
			'PAREN-45' => 129,
			'SubExpression' => 102,
			'VariableSymbolOrSelf' => 101,
			'Operation' => 453,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'LoopLabel' => 136,
			'Statement' => 135,
			'Conditional' => 106,
			'WordScoped' => 107,
			'OperatorVoid' => 108,
			'Expression' => 118,
			'HashDereference' => 119,
			'Variable' => 145,
			'HashReference' => 115,
			'VariableModification' => 142,
			'Operator' => 123,
			'OPTIONAL-46' => 125,
			'VariableDeclaration' => 122
		}
	},
	{#State 430
		DEFAULT => -101
	},
	{#State 431
		ACTIONS => {
			'OP21_LIST_COMMA' => 454
		}
	},
	{#State 432
		ACTIONS => {
			'LBRACE' => 455
		}
	},
	{#State 433
		ACTIONS => {
			'MY' => 457
		},
		GOTOS => {
			'TypeInnerProperties' => 456
		}
	},
	{#State 434
		ACTIONS => {
			'OP21_LIST_COMMA' => 459,
			"}" => 460
		},
		GOTOS => {
			'PAREN-33' => 458
		}
	},
	{#State 435
		DEFAULT => -83
	},
	{#State 436
		DEFAULT => -57
	},
	{#State 437
		ACTIONS => {
			'WORD' => 159,
			'TYPE_INTEGER' => 161,
			'WORD_SCOPED' => 162
		},
		GOTOS => {
			'Type' => 461
		}
	},
	{#State 438
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 462
		}
	},
	{#State 439
		ACTIONS => {
			"undef" => 463
		}
	},
	{#State 440
		ACTIONS => {
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 464,
			'OP08_MATH_ADD_SUB' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 441
		DEFAULT => -256
	},
	{#State 442
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP06_REGEX_BIND' => 170,
			'OP18_TERNARY' => 171,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			";" => 465,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP23_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 175,
			'OP13_BITWISE_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 443
		ACTIONS => {
			'VARIABLE_SYMBOL' => 466
		}
	},
	{#State 444
		DEFAULT => -257
	},
	{#State 445
		ACTIONS => {
			")" => 467
		}
	},
	{#State 446
		ACTIONS => {
			")" => 468
		}
	},
	{#State 447
		DEFAULT => -178
	},
	{#State 448
		DEFAULT => -181
	},
	{#State 449
		DEFAULT => -183
	},
	{#State 450
		ACTIONS => {
			'LPAREN' => 469
		}
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 470
		}
	},
	{#State 452
		DEFAULT => -194
	},
	{#State 453
		DEFAULT => -192
	},
	{#State 454
		ACTIONS => {
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 471,
			'HashReference' => 115,
			'Expression' => 189,
			'HashDereference' => 119,
			'Literal' => 103,
			'Variable' => 183,
			'WordScoped' => 107,
			'Operator' => 123,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 455
		ACTIONS => {
			'MY' => 472
		}
	},
	{#State 456
		DEFAULT => -227
	},
	{#State 457
		ACTIONS => {
			'WORD' => 159,
			'TYPE_INTEGER' => 161,
			'WORD_SCOPED' => 162
		},
		GOTOS => {
			'Type' => 473
		}
	},
	{#State 458
		DEFAULT => -80
	},
	{#State 459
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 238,
			'OP01_OPEN' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP01_PRINT' => 234,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_NAMED_VOID' => 225,
			'OP01_CLOSE' => 223,
			'OP10_NAMED_UNARY' => 233,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP22_LOGICAL_NEG' => 232,
			'OP08_MATH_ADD_SUB' => 219,
			'WORD' => 218,
			'OP23_LOGICAL_AND' => 230,
			'OP11_COMPARE_LT_GT' => 229,
			'OP01_NAMED' => 228,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP07_STRING_REPEAT' => 226
		},
		GOTOS => {
			'OpStringOrWord' => 415,
			'HashEntryProperties' => 474
		}
	},
	{#State 460
		ACTIONS => {
			";" => 475
		}
	},
	{#State 461
		ACTIONS => {
			'VARIABLE_SYMBOL' => 476
		}
	},
	{#State 462
		ACTIONS => {
			'LPAREN' => 144,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_PRINT' => 153,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP19_LOOP_CONTROL' => 149,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'OP01_NAMED' => 133,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_SCOLON' => 130,
			'LBRACE' => 128,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'WORD_UPPERCASE' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			"}" => 477,
			'MY' => 116,
			'OP01_NAMED_VOID' => 127,
			"if" => 126,
			'OP01_CLOSE' => 124,
			"foreach" => -171,
			'LBRACKET' => 104,
			"for" => -171,
			"undef" => 100,
			'OP01_NAMED_SCOLON' => 114,
			'WORD' => 29,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'OP05_BITWISE_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Literal' => 103,
			'VariableSymbolOrSelf' => 101,
			'PAREN-45' => 129,
			'SubExpression' => 102,
			'Operation' => 478,
			'ArrayReference' => 112,
			'ArrayDereference' => 113,
			'LoopLabel' => 136,
			'Conditional' => 106,
			'Statement' => 135,
			'WordScoped' => 107,
			'OperatorVoid' => 108,
			'Expression' => 118,
			'HashDereference' => 119,
			'Variable' => 145,
			'VariableModification' => 142,
			'HashReference' => 115,
			'Operator' => 123,
			'OPTIONAL-46' => 125,
			'VariableDeclaration' => 122
		}
	},
	{#State 463
		ACTIONS => {
			";" => 479
		}
	},
	{#State 464
		ACTIONS => {
			'OP10_NAMED_UNARY' => 141,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 183,
			'SubExpression' => 480,
			'VariableSymbolOrSelf' => 101,
			'HashReference' => 115,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107
		}
	},
	{#State 465
		DEFAULT => -258
	},
	{#State 466
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 481
		}
	},
	{#State 467
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 482
		}
	},
	{#State 468
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 483
		}
	},
	{#State 469
		ACTIONS => {
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			"undef" => 100,
			'LBRACE' => 128,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 140,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'SELF' => 147,
			'OP01_OPEN' => 148
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113,
			'WordScoped' => 107,
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 183,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 484,
			'HashReference' => 115
		}
	},
	{#State 470
		DEFAULT => -180
	},
	{#State 471
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_BIND' => 170,
			'OP18_TERNARY' => 171,
			")" => -102,
			"}" => -102,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => 179,
			"]" => -102,
			'OP16_LOGICAL_OR' => 180,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP15_LOGICAL_AND' => 173,
			'OP11_COMPARE_LT_GT' => 164,
			'OP04_MATH_POW' => 174,
			'OP21_LIST_COMMA' => -102,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 472
		ACTIONS => {
			'TYPE_INTEGER' => 161,
			'WORD' => 159,
			'WORD_SCOPED' => 162,
			'TYPE_METHOD' => 485
		},
		GOTOS => {
			'Type' => 272
		}
	},
	{#State 473
		ACTIONS => {
			"\$TYPED_" => 486
		}
	},
	{#State 474
		DEFAULT => -79
	},
	{#State 475
		DEFAULT => -82
	},
	{#State 476
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 487
		}
	},
	{#State 477
		DEFAULT => -61
	},
	{#State 478
		DEFAULT => -59
	},
	{#State 479
		DEFAULT => -203
	},
	{#State 480
		ACTIONS => {
			'OP18_TERNARY' => -124,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_STRING_CAT' => 168,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 178,
			")" => 488,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 166,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => -124,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174
		}
	},
	{#State 481
		ACTIONS => {
			'LBRACE' => 128,
			"undef" => 100,
			'OP10_NAMED_UNARY_SCOLON' => 444,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'OP01_NAMED_SCOLON' => 441,
			'OP03_MATH_INC_DEC' => 140,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'HashReference' => 115,
			'SubExpression' => 442,
			'VariableSymbolOrSelf' => 101,
			'Variable' => 183,
			'Literal' => 103,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'OpNamedScolonOrSubExp' => 489,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 482
		DEFAULT => -189
	},
	{#State 483
		DEFAULT => -191
	},
	{#State 484
		ACTIONS => {
			'OP04_MATH_POW' => 174,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP14_BITWISE_OR_XOR' => 172,
			")" => 490,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP18_TERNARY' => 171
		}
	},
	{#State 485
		ACTIONS => {
			"\$RETURN_TYPE" => 491
		}
	},
	{#State 486
		ACTIONS => {
			'WORD' => 218,
			'OP11_COMPARE_LT_GT' => 229,
			'OP23_LOGICAL_AND' => 230,
			'OP07_STRING_REPEAT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP01_NAMED' => 228,
			'OP19_LOOP_CONTROL' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 236,
			'OP01_OPEN' => 237,
			'OP01_NAMED_VOID' => 225,
			'OP01_PRINT' => 234,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_CLOSE' => 223,
			'OP10_NAMED_UNARY' => 233,
			'OP08_MATH_ADD_SUB' => 219,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP22_LOGICAL_NEG' => 232
		},
		GOTOS => {
			'OpStringOrWord' => 492
		}
	},
	{#State 487
		ACTIONS => {
			")" => 493,
			'OP21_LIST_COMMA' => 494
		},
		GOTOS => {
			'PAREN-26' => 495
		}
	},
	{#State 488
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 496
		}
	},
	{#State 489
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'CONSTANT_CALL_SCOPED' => 150,
			'VARIABLE_SYMBOL' => 151,
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'LPAREN' => 144,
			'WORD_UPPERCASE' => 190,
			'OP22_LOGICAL_NEG' => 143,
			'OP10_NAMED_UNARY' => 141,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'OP03_MATH_INC_DEC' => 140,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 138,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			'OP01_NAMED' => 181,
			'LBRACE' => 128,
			"undef" => 100,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 498,
			'HashReference' => 115,
			'VariableModification' => 499,
			'HashDereference' => 119,
			'Expression' => 189,
			'Literal' => 103,
			'Variable' => 145,
			'SubExpressionOrVarMod' => 497,
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'Operator' => 123,
			'ArrayDereference' => 113
		}
	},
	{#State 490
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 500
		}
	},
	{#State 491
		ACTIONS => {
			"}" => 501
		}
	},
	{#State 492
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 502,
			'OP02_ARRAY_THINARROW' => 503
		}
	},
	{#State 493
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 504
		}
	},
	{#State 494
		ACTIONS => {
			'MY' => 505
		}
	},
	{#State 495
		DEFAULT => -63
	},
	{#State 496
		DEFAULT => -187
	},
	{#State 497
		ACTIONS => {
			")" => 506
		}
	},
	{#State 498
		ACTIONS => {
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP18_TERNARY' => 171,
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			")" => -167,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP13_BITWISE_AND' => 166
		}
	},
	{#State 499
		DEFAULT => -168
	},
	{#State 500
		DEFAULT => -177
	},
	{#State 501
		ACTIONS => {
			";" => 507
		}
	},
	{#State 502
		ACTIONS => {
			'OP01_OPEN' => 148,
			"%{" => 146,
			'SELF' => 147,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 138,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 140,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 139,
			'WORD_SCOPED' => 30,
			"undef" => 100,
			'LBRACE' => 128,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 115,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 508,
			'Literal' => 103,
			'Variable' => 183,
			'Expression' => 189,
			'HashDereference' => 119,
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'Operator' => 123,
			'ArrayReference' => 112
		}
	},
	{#State 503
		ACTIONS => {
			"%{" => 146,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 141,
			'OP22_LOGICAL_NEG' => 143,
			'WORD_UPPERCASE' => 190,
			'LPAREN' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 137,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 110,
			"\@{" => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 140,
			'OP05_LOGICAL_NEG' => 139,
			'WORD' => 29,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			"undef" => 100,
			'OP01_NAMED' => 181,
			'LBRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 115,
			'SubExpression' => 509,
			'VariableSymbolOrSelf' => 101,
			'Literal' => 103,
			'Variable' => 183,
			'HashDereference' => 119,
			'Expression' => 189,
			'WordScoped' => 107,
			'ArrayDereference' => 113,
			'ArrayReference' => 112,
			'Operator' => 123
		}
	},
	{#State 504
		ACTIONS => {
			"\@ARG;" => 510
		}
	},
	{#State 505
		ACTIONS => {
			'TYPE_INTEGER' => 161,
			'WORD' => 159,
			'WORD_SCOPED' => 162
		},
		GOTOS => {
			'Type' => 511
		}
	},
	{#State 506
		ACTIONS => {
			'LBRACE' => 405
		},
		GOTOS => {
			'CodeBlock' => 512
		}
	},
	{#State 507
		ACTIONS => {
			"\@{" => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'LITERAL_STRING' => -85,
			'WORD' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'LBRACKET' => -85,
			"undef" => -85,
			"for" => -85,
			"foreach" => -85,
			'OP01_CLOSE' => -85,
			"if" => -85,
			'OP01_NAMED_VOID' => -85,
			'LPAREN_MY' => 513,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'WORD_UPPERCASE' => -85,
			'MY' => -85,
			"}" => -85,
			'LITERAL_NUMBER' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP03_MATH_INC_DEC' => -85,
			"while" => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'OP01_NAMED' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'LBRACE' => -85,
			'WORD_SCOPED' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'VARIABLE_SYMBOL' => -85,
			'OP01_PRINT' => -85,
			"%{" => -85,
			'SELF' => -85,
			'OP01_OPEN' => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'LPAREN' => -85,
			'OP10_NAMED_UNARY' => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 515,
			'MethodArguments' => 514
		}
	},
	{#State 508
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP18_TERNARY' => 171,
			"}" => -244,
			'OP08_MATH_ADD_SUB' => 178,
			'OP16_LOGICAL_OR' => 180,
			'OP17_LIST_RANGE' => 179,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 166,
			'OP21_LIST_COMMA' => -244,
			'OP09_BITWISE_SHIFT' => 175,
			'OP23_LOGICAL_AND' => 165,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 509
		ACTIONS => {
			'OP08_STRING_CAT' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 169,
			'OP06_REGEX_BIND' => 170,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP18_TERNARY' => 171,
			'OP08_MATH_ADD_SUB' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP16_LOGICAL_OR' => 180,
			"]" => 516,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 174,
			'OP23_LOGICAL_AND' => 165,
			'OP09_BITWISE_SHIFT' => 175,
			'OP13_BITWISE_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 510
		DEFAULT => -65
	},
	{#State 511
		ACTIONS => {
			'VARIABLE_SYMBOL' => 517
		}
	},
	{#State 512
		DEFAULT => -188
	},
	{#State 513
		ACTIONS => {
			'WORD' => 159,
			'TYPE_INTEGER' => 161,
			'WORD_SCOPED' => 162
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 514
		DEFAULT => -84
	},
	{#State 515
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 519
		}
	},
	{#State 516
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 520
		}
	},
	{#State 517
		DEFAULT => -62
	},
	{#State 518
		ACTIONS => {
			'SELF' => 521
		}
	},
	{#State 519
		ACTIONS => {
			"if" => 126,
			'OP01_NAMED_VOID' => 127,
			"foreach" => -171,
			'OP01_CLOSE' => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 120,
			'WORD_UPPERCASE' => 121,
			"}" => 523,
			'MY' => 116,
			'OP22_LOGICAL_NEG_LPAREN' => 109,
			"\@{" => 111,
			'LITERAL_STRING' => 110,
			'OP01_NAMED_SCOLON' => 114,
			'WORD' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 105,
			'LBRACKET' => 104,
			"for" => -171,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 151,
			'CONSTANT_CALL_SCOPED' => 150,
			'OP01_PRINT' => 153,
			'OP19_LOOP_CONTROL' => 149,
			'OP01_OPEN' => 148,
			'SELF' => 147,
			"%{" => 146,
			'OP22_LOGICAL_NEG' => 143,
			'LPAREN' => 144,
			'OP10_NAMED_UNARY' => 141,
			'LITERAL_NUMBER' => 138,
			'OP03_MATH_INC_DEC' => 140,
			"while" => -171,
			'OP05_LOGICAL_NEG' => 139,
			'OP05_MATH_NEG_LPAREN' => 137,
			'OP01_NAMED' => 133,
			'OP01_NAMED_VOID_LPAREN' => 132,
			'WORD_SCOPED' => 30,
			'LBRACE' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 130
		},
		GOTOS => {
			'HashReference' => 115,
			'VariableModification' => 142,
			'HashDereference' => 119,
			'Expression' => 118,
			'Variable' => 145,
			'VariableDeclaration' => 122,
			'Operator' => 123,
			'OPTIONAL-46' => 125,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 102,
			'PAREN-45' => 129,
			'Operation' => 522,
			'Literal' => 103,
			'LoopLabel' => 136,
			'Conditional' => 106,
			'Statement' => 135,
			'OperatorVoid' => 108,
			'WordScoped' => 107,
			'ArrayReference' => 112,
			'ArrayDereference' => 113
		}
	},
	{#State 520
		ACTIONS => {
			"undef" => 524
		}
	},
	{#State 521
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 525
		}
	},
	{#State 522
		DEFAULT => -86
	},
	{#State 523
		DEFAULT => -88
	},
	{#State 524
		DEFAULT => -245
	},
	{#State 525
		ACTIONS => {
			")" => 526,
			'OP21_LIST_COMMA' => 528
		},
		GOTOS => {
			'PAREN-37' => 527
		}
	},
	{#State 526
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 529
		}
	},
	{#State 527
		DEFAULT => -90
	},
	{#State 528
		ACTIONS => {
			'MY' => 530
		}
	},
	{#State 529
		ACTIONS => {
			"\@ARG;" => 531
		}
	},
	{#State 530
		ACTIONS => {
			'WORD_SCOPED' => 162,
			'WORD' => 159,
			'TYPE_INTEGER' => 161
		},
		GOTOS => {
			'Type' => 532
		}
	},
	{#State 531
		DEFAULT => -92
	},
	{#State 532
		ACTIONS => {
			'VARIABLE_SYMBOL' => 533
		}
	},
	{#State 533
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7479 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7593 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7663 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7674 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7713 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7805 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7827 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7845 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7866 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7877 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7898 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7979 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7990 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8001 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8012 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8033 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8044 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8055 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8069 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8094 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8115 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8126 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8137 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8148 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8159 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8170 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8192 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8203 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8214 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8225 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8236 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8269 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8280 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8302 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8313 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8346 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8368 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8379 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8390 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8401 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8412 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8423 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8434 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8445 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8456 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8467 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8478 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8489 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8500 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8511 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8522 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8533 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8547 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8554 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8561 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8568 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8579 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8590 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8601 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8612 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8623 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8634 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8645 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8663 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8670 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8677 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8684 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8698 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8709 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8720 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8731 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8742 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8753 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8764 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8775 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8786 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8797 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8808 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8819 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8830 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8841 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8852 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8863 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8874 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8885 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8896 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8907 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_168
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8918 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8932 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8939 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8950 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8961 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8972 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8983 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8994 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9015 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9022 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9029 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9036 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_183
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9047 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_184
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9058 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9069 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_186
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9080 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_187
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9091 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_188
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9102 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_189
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9113 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_190
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9124 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_191
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9135 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9149 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_194
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9167 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9174 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_197
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9185 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_198
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9196 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_199
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9207 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_200
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9218 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_201
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9229 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_202
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9240 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_203
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9251 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_204
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9262 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_205
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9273 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_206
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9284 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9291 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9305 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_210
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9316 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_211
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9327 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_212
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9338 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_213
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9349 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_214
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9360 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9367 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9374 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_217
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9385 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9399 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_220
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9410 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_221
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9421 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9435 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_224
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9446 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_225
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9457 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_226
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9468 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_227
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9479 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9500 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_231
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9511 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_232
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9522 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9529 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9536 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_235
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9547 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_236
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9558 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_237
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9569 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_238
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9580 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_239
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9591 lib/RPerl/Grammar.pm
	],
	[#Rule Type_240
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9602 lib/RPerl/Grammar.pm
	],
	[#Rule Type_241
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9613 lib/RPerl/Grammar.pm
	],
	[#Rule Type_242
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9624 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_243
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9635 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_244
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9646 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_245
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9657 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_246
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9668 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_247
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9679 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_248
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9690 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_249
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9701 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_250
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9712 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_251
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9723 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_252
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9734 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_253
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9745 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_254
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9756 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_255
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9767 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_256
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9778 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_257
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9789 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_258
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9800 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_259
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9811 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_260
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9822 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_261
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9833 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9844 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9855 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9866 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9877 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9888 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9899 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9910 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9921 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9932 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9943 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9954 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_273
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9965 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_274
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9976 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_275
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9987 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_276
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9998 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_277
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10009 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_278
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10020 lib/RPerl/Grammar.pm
	]
],
#line 10023 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Include_54', 
         'Include_55', 
         'Constant_56', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_61', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_65', 
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
         'Class_76', 
         'UseParent_77', 
         'UseParent_78', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_82', 
         'Properties_83', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_88', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_92', 
         'SubroutineOrMethod_93', 
         'SubroutineOrMethod_94', 
         'Operation_95', 
         'Operation_96', 
         'Operation_97', 
         'Operation_98', 
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
         'Operator_124', 
         'Operator_125', 
         'Operator_126', 
         'Operator_127', 
         'Operator_128', 
         'Operator_129', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         'OperatorVoid_139', 
         'OperatorVoid_140', 
         'OperatorVoid_141', 
         'OperatorVoid_142', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'Expression_154', 
         'SubExpression_155', 
         'SubExpression_156', 
         'SubExpression_157', 
         'SubExpression_158', 
         'SubExpression_159', 
         'SubExpression_160', 
         'SubExpression_161', 
         'SubExpression_162', 
         'SubExpression_163', 
         'SubExpressionOrInput_164', 
         'SubExpressionOrInput_165', 
         'SubExpressionOrInput_166', 
         'SubExpressionOrVarMod_167', 
         'SubExpressionOrVarMod_168', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_172', 
         'Statement_173', 
         'Statement_174', 
         'Statement_175', 
         'Statement_176', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_183', 
         'Loop_184', 
         'Loop_185', 
         'Loop_186', 
         'LoopFor_187', 
         'LoopFor_188', 
         'LoopForEach_189', 
         'LoopWhile_190', 
         'LoopWhile_191', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_194', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_197', 
         'VariableRetrieval_198', 
         'VariableRetrieval_199', 
         'VariableRetrieval_200', 
         'VariableDeclaration_201', 
         'VariableDeclaration_202', 
         'VariableDeclaration_203', 
         'VariableDeclaration_204', 
         'VariableModification_205', 
         'VariableModification_206', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_210', 
         'ListElement_211', 
         'ListElement_212', 
         'ListElement_213', 
         'ListElement_214', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_217', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_220', 
         'ArrayDereference_221', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_224', 
         'HashEntry_225', 
         'HashEntry_226', 
         'HashEntryProperties_227', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_231', 
         'HashReference_232', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_235', 
         'HashDereference_236', 
         'WordScoped_237', 
         'WordScoped_238', 
         'LoopLabel_239', 
         'Type_240', 
         'Type_241', 
         'Type_242', 
         'TypeInner_243', 
         'TypeInnerProperties_244', 
         'TypeInnerProperties_245', 
         'TypeInnerConstant_246', 
         'VariableOrLiteral_247', 
         'VariableOrLiteral_248', 
         'VarOrLitOrOpStrOrWord_249', 
         'VarOrLitOrOpStrOrWord_250', 
         'VarOrLitOrOpStrOrWord_251', 
         'VariableSymbolOrSelf_252', 
         'VariableSymbolOrSelf_253', 
         'Literal_254', 
         'Literal_255', 
         'OpNamedScolonOrSubExp_256', 
         'OpNamedScolonOrSubExp_257', 
         'OpNamedScolonOrSubExp_258', 
         'OpNamedScolonOrSubExpIn_259', 
         'OpNamedScolonOrSubExpIn_260', 
         'OpNamedScolonOrSubExpIn_261', 
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
         'OpStringOrWord_272', 
         'OpStringOrWord_273', 
         'OpStringOrWord_274', 
         'OpStringOrWord_275', 
         'OpStringOrWord_276', 
         'OpStringOrWord_277', 
         'OpStringOrWord_278', );
  $self;
}

#line 282 "lib/RPerl/Grammar.eyp"


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
Exports_49 => 'RPerl::NonGenerator',                                        # Exports -> USE_EXPORTER OPTIONAL-19 OPTIONAL-21
Include_54 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OPTIONAL-22 ';'
Include_55 => 'RPerl::CompileUnit::Include',                                # Include -> 'INIT' LBRACE WordScoped OP02_METHOD_THINARROW_IMP OPTIONAL-23 ')' ';' '}'
Constant_56 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_61 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> SUB WORD LBRACE LBRACE MY Type '$RETURN_TYPE' '}' ';' OPTIONAL-22 STAR-23 '}'
SubroutineArguments_65 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-25 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_76 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> UseParent WordScoped ')' ';' Include STAR-28 OPTIONAL-29 STAR-30 STAR-31 Properties STAR-32 LITERAL_NUMBER ';'
UseParent_77 => 'RPerl::NonGenerator',                                      # UseParent -> 'use parent qw('
UseParent_78 => 'RPerl::NonGenerator',                                      # UseParent -> 'use parent -norequire, qw('
Properties_82 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-32 '}' ';'
Properties_83 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_88 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> SUB WORD LBRACE LBRACE MY TYPE_METHOD '$RETURN_TYPE' '}' ';' OPTIONAL-33 STAR-34 '}'
MethodArguments_92 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY Type SELF STAR-36 ')' OP19_VARIABLE_ASSIGN '@ARG;'
SubroutineOrMethod_93 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_94 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
Operation_95 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_96 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_97 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_98 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_99 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_100 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_102 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_104 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_105 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_106 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_110 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
Operator_111 => 'RPerl::Operation::Expression::Operator::String::Repeat',                    # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_112 => 'RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo',  # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_113 => 'RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract',           # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_114 => 'RPerl::Operation::Expression::Operator::String::Concatenate',               # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_115 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                    # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_116 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY SubExpression
Operator_117 => 'RPerl::Operation::Expression::Operator::NamedUnary',                       # Operator -> OP10_NAMED_UNARY
Operator_118 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',     # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_119 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',           # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_120 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                     # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_121 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                   # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_122 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_123 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_124 => 'RPerl::Operation::Expression::Operator::List::Range',                      # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_125 => 'RPerl::Operation::Expression::Operator::Ternary',                          # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_126 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
Operator_127 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_128 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_129 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_135 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_136 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_137 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_138 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_139 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_140 => 'RPerl::Operation::Expression::Operator::Named',                        # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_141 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_142 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_149 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_150 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_151 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_152 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-40 ')'
Expression_153 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-41 ')'
Expression_154 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-42 ')'
SubExpression_155 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_156 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_157 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_158 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_159 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_160 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_161 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_162 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_163 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_164 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_165 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_166 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_167 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_168 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_172 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_173 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-44 Loop
Statement_174 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_175 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_176 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_183 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-46 OPTIONAL-48
Loop_184 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_185 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_186 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_187 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_188 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_189 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_190 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_191 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_194 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-49 '}'
Variable_197 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-50
VariableRetrieval_198 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_199 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_200 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_201 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_202 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_203 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_204 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_205 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_206 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_210 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-52
ListElement_211 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_212 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_213 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_214 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_217 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-53 ']'
ArrayDereference_220 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_221 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-54 ArrayReference '}'
HashEntry_224 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
HashEntry_225 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_226 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_227 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_231 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-57 '}'
HashReference_232 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_235 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_236 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-58 HashReference '}'
WordScoped_237 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_238 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_239 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_240 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_241 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_242 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_243 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_244 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_245 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_246 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_247 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_248 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_249 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_250 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_251 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_252 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_253 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_254 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_255 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_256 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_257 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_258 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_259 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_260 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_261 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_262 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_263 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_264 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_265 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_266 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_267 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_268 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_269 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_270 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_271 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_272 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_273 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_274 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_275 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_276 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_277 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_278 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 10517 lib/RPerl/Grammar.pm



1;
