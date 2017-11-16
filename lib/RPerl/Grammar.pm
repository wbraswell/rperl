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
    our $VERSION = 0.012_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|foreach|package|\$TYPED_|undef|elsif|while|\@ARG\;|INIT|else|for|\%\{|if|\@\{|\]|\;|\}|\))}gc and return ($1, $1);

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
			'USE_RPERL' => -20,
			'SHEBANG' => 3,
			"package" => -20,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'PAREN-1' => 1,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 5,
			'CompileUnit' => 2,
			'Critic' => 6,
			'PLUS-2' => 7,
			'Program' => 8
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			'' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 4
		ACTIONS => {
			"use constant" => -27,
			'USE' => -27,
			"use parent -norequire, qw(" => 19,
			"INIT" => -27,
			'USE_EXPORTER' => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 13,
			'SUB' => -27
		},
		GOTOS => {
			'Package' => 16,
			'STAR-11' => 17,
			'Class' => 14,
			'UseParent' => 18,
			'Module' => 15
		}
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => 20,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 21
		}
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 9,
			"package" => -20,
			'' => -5,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'PAREN-1' => 22,
			'OPTIONAL-9' => 5,
			'Critic' => 6
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			'WORD' => 23
		},
		GOTOS => {
			'PLUS-17' => 24
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 13
		DEFAULT => -77
	},
	{#State 14
		DEFAULT => -25
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		ACTIONS => {
			"INIT" => -29,
			'USE_EXPORTER' => 28,
			'USE' => -29,
			'SUB' => -29,
			"## no critic qw(" => 9,
			"use constant" => -29
		},
		GOTOS => {
			'Critic' => 27,
			'OPTIONAL-12' => 29,
			'Exports' => 26
		}
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 30
		}
	},
	{#State 19
		DEFAULT => -78
	},
	{#State 20
		DEFAULT => -21
	},
	{#State 21
		ACTIONS => {
			"package" => 33
		}
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		DEFAULT => -41
	},
	{#State 24
		ACTIONS => {
			")" => 35,
			'WORD' => 34
		}
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 26
		DEFAULT => -28
	},
	{#State 27
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			"INIT" => -45,
			'OUR_EXPORT_OK' => -45,
			'USE' => -45,
			"use constant" => -45,
			'SUB' => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT' => 39
		},
		GOTOS => {
			'OPTIONAL-19' => 40,
			'PAREN-18' => 38
		}
	},
	{#State 29
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 41
		}
	},
	{#State 30
		ACTIONS => {
			")" => 42
		}
	},
	{#State 31
		DEFAULT => -237
	},
	{#State 32
		DEFAULT => -238
	},
	{#State 33
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 34
		DEFAULT => -40
	},
	{#State 35
		DEFAULT => -42
	},
	{#State 36
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 44
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 45
		}
	},
	{#State 38
		DEFAULT => -44
	},
	{#State 39
		ACTIONS => {
			'OP01_QW' => 46
		}
	},
	{#State 40
		ACTIONS => {
			"use constant" => -48,
			'OUR_EXPORT_OK' => 49,
			"INIT" => -48,
			"our hashref \$properties" => -48,
			'SUB' => -48,
			'USE' => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 47,
			'PAREN-20' => 48
		}
	},
	{#State 41
		ACTIONS => {
			"use constant" => -33,
			"INIT" => 52,
			'USE' => 53,
			'SUB' => -33
		},
		GOTOS => {
			'STAR-14' => 50,
			'Include' => 51
		}
	},
	{#State 42
		ACTIONS => {
			";" => 54
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55
		}
	},
	{#State 44
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LPAREN' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'SUB' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID' => -11,
			'LBRACE' => -11,
			'LITERAL_NUMBER' => -11,
			"while" => -11,
			'USE' => -11,
			'LITERAL_STRING' => -11,
			'SELF' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'MY' => -11,
			'LBRACKET' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_OPEN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 9,
			'OP03_MATH_INC_DEC' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"foreach" => -11,
			'OP01_NAMED' => -11,
			'OP01_CLOSE' => -11,
			'WORD_SCOPED' => -11,
			"\@{" => -11,
			'WORD' => -11,
			"%{" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"if" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"undef" => -11,
			'OP01_PRINT' => -11,
			"use constant" => -11,
			"INIT" => -11,
			'OP10_NAMED_UNARY' => -11
		},
		GOTOS => {
			'STAR-5' => 57,
			'Critic' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'USE_RPERL_AFTER' => 59,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 58
		}
	},
	{#State 46
		ACTIONS => {
			";" => 60
		}
	},
	{#State 47
		DEFAULT => -49
	},
	{#State 48
		DEFAULT => -47
	},
	{#State 49
		ACTIONS => {
			'OP01_QW' => 61
		}
	},
	{#State 50
		ACTIONS => {
			'SUB' => 65,
			"use constant" => 62
		},
		GOTOS => {
			'Subroutine' => 64,
			'Constant' => 63,
			'PLUS-15' => 66
		}
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			'LBRACE' => 67
		}
	},
	{#State 53
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 68
		}
	},
	{#State 54
		ACTIONS => {
			"INIT" => 52,
			'USE' => 53
		},
		GOTOS => {
			'Include' => 69
		}
	},
	{#State 55
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 70
		}
	},
	{#State 56
		DEFAULT => -8
	},
	{#State 57
		ACTIONS => {
			"for" => -13,
			'WORD_UPPERCASE' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			'USE' => 53,
			"while" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LPAREN' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'SUB' => -13,
			'MY' => -13,
			'LBRACKET' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'VARIABLE_SYMBOL' => -13,
			'SELF' => -13,
			'LITERAL_STRING' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_CLOSE' => -13,
			'WORD_SCOPED' => -13,
			"\@{" => -13,
			'WORD' => -13,
			'OP01_OPEN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"foreach" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			"undef" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use constant" => -13,
			'OP01_PRINT' => -13,
			"INIT" => 52,
			'OP10_NAMED_UNARY' => -13,
			"%{" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			"if" => -13
		},
		GOTOS => {
			'Include' => 71,
			'STAR-6' => 72
		}
	},
	{#State 58
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 59
		DEFAULT => -37
	},
	{#State 60
		DEFAULT => -43
	},
	{#State 61
		ACTIONS => {
			";" => 74
		}
	},
	{#State 62
		ACTIONS => {
			'WORD_UPPERCASE' => 75
		}
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		DEFAULT => -35
	},
	{#State 65
		ACTIONS => {
			'WORD' => 76
		}
	},
	{#State 66
		ACTIONS => {
			'SUB' => 65,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Subroutine' => 77
		}
	},
	{#State 67
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 79
		}
	},
	{#State 68
		ACTIONS => {
			'OP01_QW' => 81,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 80
		}
	},
	{#State 69
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 82
		}
	},
	{#State 70
		DEFAULT => -23
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'LBRACKET' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'MY' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'SELF' => -15,
			'LITERAL_STRING' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			"while" => -15,
			'WORD_UPPERCASE' => -15,
			"for" => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'SUB' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LPAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"undef" => -15,
			'OP01_PRINT' => -15,
			"use constant" => 62,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"if" => -15,
			"%{" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"\@{" => -15,
			'WORD' => -15,
			'OP01_CLOSE' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15
		},
		GOTOS => {
			'Constant' => 84,
			'STAR-7' => 83
		}
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		DEFAULT => -46
	},
	{#State 75
		ACTIONS => {
			'OP20_HASH_FATARROW' => 86
		}
	},
	{#State 76
		ACTIONS => {
			'LBRACE' => 87
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			";" => 88
		}
	},
	{#State 79
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 89
		}
	},
	{#State 80
		ACTIONS => {
			";" => 90
		}
	},
	{#State 81
		DEFAULT => -50
	},
	{#State 82
		ACTIONS => {
			"INIT" => -69,
			'USE_EXPORTER' => 28,
			'USE' => -69,
			"our hashref \$properties" => -69,
			"## no critic qw(" => 9,
			"use constant" => -69
		},
		GOTOS => {
			'Exports' => 91,
			'Critic' => 92,
			'OPTIONAL-29' => 93
		}
	},
	{#State 83
		ACTIONS => {
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'MY' => 113,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'OP01_NAMED_SCOLON' => 105,
			'LITERAL_NUMBER' => 104,
			"while" => -171,
			'WORD_UPPERCASE' => 102,
			"for" => -171,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 100,
			'CONSTANT_CALL_SCOPED' => 98,
			'SUB' => 65,
			'OP01_NAMED_VOID_SCOLON' => 96,
			'LPAREN' => 94,
			'OP10_NAMED_UNARY' => 146,
			'OP01_PRINT' => 145,
			'OP19_LOOP_CONTROL' => 143,
			"undef" => 144,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"if" => 139,
			"%{" => 137,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'LoopLabel' => 131,
			'Operation' => 132,
			'PLUS-8' => 103,
			'Expression' => 101,
			'Variable' => 135,
			'ArrayDereference' => 95,
			'VariableDeclaration' => 124,
			'HashReference' => 97,
			'VariableModification' => 127,
			'Statement' => 128,
			'Conditional' => 114,
			'Subroutine' => 115,
			'ArrayReference' => 147,
			'Operator' => 119,
			'OperatorVoid' => 120,
			'HashDereference' => 138,
			'SubExpression' => 108,
			'OPTIONAL-46' => 109,
			'PAREN-45' => 111,
			'WordScoped' => 141
		}
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		ACTIONS => {
			'MY' => 149
		},
		GOTOS => {
			'TypeInnerConstant' => 148
		}
	},
	{#State 87
		ACTIONS => {
			'LBRACE' => 150
		}
	},
	{#State 88
		DEFAULT => -36
	},
	{#State 89
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 152
		},
		GOTOS => {
			'OPTIONAL-23' => 151
		}
	},
	{#State 90
		DEFAULT => -54
	},
	{#State 91
		DEFAULT => -68
	},
	{#State 92
		DEFAULT => -66
	},
	{#State 93
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 153
		}
	},
	{#State 94
		ACTIONS => {
			'OP01_OPEN' => 125,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_NAMED' => 158,
			'CONSTANT_CALL_SCOPED' => 98,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"undef" => 144,
			'OP01_PRINT' => 157,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 154,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 95
		DEFAULT => -160
	},
	{#State 96
		DEFAULT => -137
	},
	{#State 97
		DEFAULT => -161
	},
	{#State 98
		DEFAULT => -151
	},
	{#State 99
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP01_OPEN' => 172,
			'OP01_NAMED' => 174,
			'OP01_NAMED_VOID' => 180,
			'OP01_CLOSE' => 167,
			'OP23_LOGICAL_AND' => 182,
			'WORD' => 171,
			'OP24_LOGICAL_OR_XOR' => 170,
			'LITERAL_NUMBER' => 104,
			'OP11_COMPARE_LT_GT' => 165,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP07_STRING_REPEAT' => 179,
			'OP22_LOGICAL_NEG' => 178,
			"}" => 177,
			'OP19_LOOP_CONTROL' => 163,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP01_PRINT' => 162,
			'ENV' => 160,
			'OP10_NAMED_UNARY' => 164,
			'OP08_MATH_ADD_SUB' => 176,
			'VARIABLE_SYMBOL' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 175
		},
		GOTOS => {
			'Variable' => 169,
			'HashDereference' => 166,
			'VarOrLitOrOpStrOrWord' => 184,
			'VariableSymbolOrSelf' => 130,
			'HashEntry' => 183,
			'OpStringOrWord' => 181,
			'Literal' => 168
		}
	},
	{#State 100
		ACTIONS => {
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'ARGV' => 190,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'MY' => 185,
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140
		},
		GOTOS => {
			'WordScoped' => 141,
			'ListElements' => 187,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 186,
			'ArrayDereference' => 95,
			'TypeInner' => 189,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'ListElement' => 188,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129
		}
	},
	{#State 101
		ACTIONS => {
			'OP08_STRING_CAT' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP15_LOGICAL_AND' => -155,
			";" => 193,
			'OP16_LOGICAL_OR' => -155,
			'OP18_TERNARY' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP04_MATH_POW' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP09_BITWISE_SHIFT' => -155
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 194,
			'COLON' => -239
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 96,
			'CONSTANT_CALL_SCOPED' => 98,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 100,
			'WORD_UPPERCASE' => 102,
			"for" => -171,
			"while" => -171,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_SCOLON' => 105,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG' => 110,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'MY' => 113,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'OP05_LOGICAL_NEG' => 121,
			"foreach" => -171,
			'OP03_MATH_INC_DEC' => 122,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			'' => -18,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			"\@{" => 134,
			'WORD' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			"%{" => 137,
			"if" => 139,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP19_LOOP_CONTROL' => 143,
			"undef" => 144,
			'OP01_PRINT' => 145,
			'OP10_NAMED_UNARY' => 146
		},
		GOTOS => {
			'Conditional' => 114,
			'OperatorVoid' => 120,
			'Operator' => 119,
			'ArrayReference' => 147,
			'PAREN-45' => 111,
			'OPTIONAL-46' => 109,
			'HashDereference' => 138,
			'SubExpression' => 108,
			'WordScoped' => 141,
			'Operation' => 195,
			'LoopLabel' => 131,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 101,
			'Variable' => 135,
			'ArrayDereference' => 95,
			'VariableDeclaration' => 124,
			'HashReference' => 97,
			'Statement' => 128,
			'VariableModification' => 127
		}
	},
	{#State 104
		DEFAULT => -254
	},
	{#State 105
		DEFAULT => -96
	},
	{#State 106
		DEFAULT => -255
	},
	{#State 107
		DEFAULT => -253
	},
	{#State 108
		ACTIONS => {
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212
		}
	},
	{#State 109
		ACTIONS => {
			"while" => 216,
			"foreach" => 217,
			"for" => 215
		},
		GOTOS => {
			'LoopWhile' => 213,
			'LoopForEach' => 218,
			'LoopFor' => 214,
			'Loop' => 219
		}
	},
	{#State 110
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			"undef" => 144
		},
		GOTOS => {
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ArrayDereference' => 95,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 220,
			'WordScoped' => 141
		}
	},
	{#State 111
		DEFAULT => -170
	},
	{#State 112
		ACTIONS => {
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			")" => -134,
			'MY' => 185,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP01_NAMED' => 191,
			'ARGV' => 190,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'SubExpression' => 186,
			'HashReference' => 97,
			'ListElements' => 222,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'ListElement' => 188,
			'Operator' => 119,
			'Variable' => 159,
			'TypeInner' => 189,
			'ArrayReference' => 147,
			'OPTIONAL-41' => 221
		}
	},
	{#State 113
		ACTIONS => {
			'WORD_SCOPED' => 223,
			'TYPE_FHREF' => 226,
			'TYPE_INTEGER' => 225,
			'WORD' => 224
		},
		GOTOS => {
			'Type' => 227
		}
	},
	{#State 114
		DEFAULT => -172
	},
	{#State 115
		DEFAULT => -14
	},
	{#State 116
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107
		},
		GOTOS => {
			'SubExpression' => 228,
			'HashDereference' => 138,
			'HashReference' => 97,
			'WordScoped' => 141,
			'ArrayDereference' => 95,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155
		}
	},
	{#State 117
		DEFAULT => -252
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			"undef" => 144,
			'MY' => 185,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"]" => -216,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'ARGV' => 190,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'OPTIONAL-55' => 230,
			'ArrayReference' => 147,
			'Variable' => 159,
			'TypeInner' => 189,
			'Operator' => 119,
			'ListElement' => 188,
			'ArrayDereference' => 95,
			'ListElements' => 229,
			'WordScoped' => 141,
			'SubExpression' => 186,
			'HashDereference' => 138,
			'HashReference' => 97
		}
	},
	{#State 119
		DEFAULT => -149
	},
	{#State 120
		DEFAULT => -174
	},
	{#State 121
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			"undef" => 144
		},
		GOTOS => {
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'WordScoped' => 141,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 231,
			'ArrayDereference' => 95
		}
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 117,
			'SELF' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 130,
			'Variable' => 232
		}
	},
	{#State 123
		DEFAULT => -141
	},
	{#State 124
		DEFAULT => -175
	},
	{#State 125
		ACTIONS => {
			'MY' => 233
		}
	},
	{#State 126
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"undef" => 144,
			'MY' => 185,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'ARGV' => 190,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashReference' => 97,
			'SubExpression' => 235,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ListElement' => 234,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147,
			'TypeInner' => 189
		}
	},
	{#State 127
		ACTIONS => {
			";" => 236
		}
	},
	{#State 128
		DEFAULT => -98
	},
	{#State 129
		DEFAULT => -157
	},
	{#State 130
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 237
		}
	},
	{#State 131
		ACTIONS => {
			'COLON' => 238
		}
	},
	{#State 132
		DEFAULT => -17
	},
	{#State 133
		ACTIONS => {
			'FHREF_SYMBOL' => 239
		}
	},
	{#State 134
		ACTIONS => {
			'SELF' => 107,
			'MY' => 185,
			'LBRACKET' => -219,
			'VARIABLE_SYMBOL' => 117
		},
		GOTOS => {
			'Variable' => 242,
			'TypeInner' => 241,
			'OPTIONAL-56' => 240,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 135
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP04_MATH_POW' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP17_LIST_RANGE' => -158,
			")" => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 246,
			'OP11_COMPARE_LT_GT' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP18_TERNARY' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP19_VARIABLE_ASSIGN' => 243,
			'OP16_LOGICAL_OR' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP02_METHOD_THINARROW' => 245,
			'OP08_STRING_CAT' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP03_MATH_INC_DEC' => 244,
			'OP14_BITWISE_OR_XOR' => -158
		}
	},
	{#State 136
		DEFAULT => -97
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 117,
			'SELF' => 107,
			'MY' => 185,
			'LBRACE' => -234
		},
		GOTOS => {
			'Variable' => 248,
			'TypeInner' => 249,
			'OPTIONAL-60' => 247,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 138
		DEFAULT => -162
	},
	{#State 139
		ACTIONS => {
			'LPAREN' => 250
		}
	},
	{#State 140
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			"undef" => 144
		},
		GOTOS => {
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 251,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 141
		ACTIONS => {
			'LPAREN' => 252,
			'OP02_METHOD_THINARROW_NEW' => 253
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 254,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119
		}
	},
	{#State 143
		ACTIONS => {
			'WORD_UPPERCASE' => 256
		},
		GOTOS => {
			'LoopLabel' => 255
		}
	},
	{#State 144
		DEFAULT => -156
	},
	{#State 145
		ACTIONS => {
			'LBRACKET' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'OP10_NAMED_UNARY' => -132,
			'VARIABLE_SYMBOL' => -132,
			"undef" => -132,
			'MY' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'SELF' => -132,
			'LITERAL_STRING' => -132,
			"%{" => -132,
			'LITERAL_NUMBER' => -132,
			"\@{" => -132,
			'WORD' => -132,
			'WORD_SCOPED' => -132,
			'WORD_UPPERCASE' => -132,
			'OP01_CLOSE' => -132,
			'ARGV' => -132,
			'LBRACE' => -132,
			'FHREF_SYMBOL_BRACES' => 258,
			'STDOUT_STDERR' => 259,
			'OP01_NAMED' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'OP01_QW' => -132,
			'OP01_OPEN' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'LPAREN' => -132,
			'OP03_MATH_INC_DEC' => -132
		},
		GOTOS => {
			'PAREN-39' => 260,
			'OPTIONAL-40' => 257
		}
	},
	{#State 146
		ACTIONS => {
			"undef" => 144,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP04_MATH_POW' => -117,
			'OP10_NAMED_UNARY' => 146,
			'OP11_COMPARE_LT_GT' => -117,
			"%{" => 137,
			"]" => -117,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP16_LOGICAL_OR' => -117,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			"\@{" => 134,
			'WORD' => 31,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			";" => -117,
			'OP01_NAMED' => 191,
			'OP15_LOGICAL_AND' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'LBRACKET' => 118,
			'OP13_BITWISE_AND' => -117,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP07_STRING_REPEAT' => -117,
			")" => -117,
			'OP22_LOGICAL_NEG' => 110,
			"}" => -117,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'OP23_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP18_TERNARY' => -117,
			'LITERAL_NUMBER' => 104,
			'OP14_BITWISE_OR_XOR' => -117,
			'LPAREN' => 94,
			'OP06_REGEX_BIND' => -117,
			'OP08_STRING_CAT' => -117,
			'CONSTANT_CALL_SCOPED' => 98
		},
		GOTOS => {
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'SubExpression' => 261,
			'HashReference' => 97,
			'WordScoped' => 141
		}
	},
	{#State 147
		DEFAULT => -159
	},
	{#State 148
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Literal' => 262
		}
	},
	{#State 149
		ACTIONS => {
			'WORD' => 224,
			'TYPE_INTEGER' => 225,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 263
		}
	},
	{#State 150
		ACTIONS => {
			'MY' => 264
		}
	},
	{#State 151
		ACTIONS => {
			")" => 265
		}
	},
	{#State 152
		DEFAULT => -52
	},
	{#State 153
		ACTIONS => {
			"our hashref \$properties" => -73,
			'USE' => 53,
			"INIT" => 52,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 267,
			'STAR-31' => 266
		}
	},
	{#State 154
		ACTIONS => {
			'OP15_LOGICAL_AND' => 210,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP23_LOGICAL_AND' => 205,
			'OP16_LOGICAL_OR' => 212,
			'OP07_STRING_REPEAT' => 196,
			")" => 268,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208
		}
	},
	{#State 155
		DEFAULT => -155
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 194
		}
	},
	{#State 157
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 269
		}
	},
	{#State 158
		ACTIONS => {
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"undef" => 144,
			'MY' => 185,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP01_NAMED' => 191,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'ARGV' => 190,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'ListElement' => 270,
			'Variable' => 159,
			'TypeInner' => 189,
			'ArrayReference' => 147,
			'Operator' => 119,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 235,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 159
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -158,
			"]" => -158,
			'OP13_BITWISE_AND' => -158,
			"}" => -158,
			'OP07_STRING_REPEAT' => -158,
			")" => -158,
			'OP04_MATH_POW' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP08_STRING_CAT' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP03_MATH_INC_DEC' => 244,
			'OP15_LOGICAL_AND' => -158,
			'OP02_METHOD_THINARROW' => 245,
			";" => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP18_TERNARY' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP21_LIST_COMMA' => -158
		}
	},
	{#State 160
		DEFAULT => -226
	},
	{#State 161
		DEFAULT => -267
	},
	{#State 162
		DEFAULT => -277
	},
	{#State 163
		DEFAULT => -266
	},
	{#State 164
		DEFAULT => -269
	},
	{#State 165
		DEFAULT => -268
	},
	{#State 166
		DEFAULT => -225
	},
	{#State 167
		DEFAULT => -274
	},
	{#State 168
		DEFAULT => -250
	},
	{#State 169
		DEFAULT => -249
	},
	{#State 170
		DEFAULT => -262
	},
	{#State 171
		DEFAULT => -278
	},
	{#State 172
		DEFAULT => -275
	},
	{#State 173
		DEFAULT => -265
	},
	{#State 174
		DEFAULT => -273
	},
	{#State 175
		DEFAULT => -271
	},
	{#State 176
		DEFAULT => -270
	},
	{#State 177
		DEFAULT => -232
	},
	{#State 178
		DEFAULT => -264
	},
	{#State 179
		DEFAULT => -272
	},
	{#State 180
		DEFAULT => -276
	},
	{#State 181
		DEFAULT => -251
	},
	{#State 182
		DEFAULT => -263
	},
	{#State 183
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 271
		}
	},
	{#State 184
		ACTIONS => {
			'OP20_HASH_FATARROW' => 272
		}
	},
	{#State 185
		ACTIONS => {
			'TYPE_INTEGER' => 225,
			'WORD' => 224,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 273
		}
	},
	{#State 186
		ACTIONS => {
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP15_LOGICAL_AND' => 210,
			";" => -211,
			'OP16_LOGICAL_OR' => 212,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP21_LIST_COMMA' => -211,
			'OP23_LOGICAL_AND' => 205,
			"]" => -211,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			")" => -211,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198
		}
	},
	{#State 187
		ACTIONS => {
			";" => 274
		}
	},
	{#State 188
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 275
		}
	},
	{#State 189
		ACTIONS => {
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"undef" => 144,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'SubExpression' => 276,
			'HashDereference' => 138,
			'HashReference' => 97,
			'WordScoped' => 141,
			'ArrayDereference' => 95,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155
		}
	},
	{#State 190
		DEFAULT => -214
	},
	{#State 191
		ACTIONS => {
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 144,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142
		},
		GOTOS => {
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'SubExpression' => 277,
			'HashDereference' => 138,
			'HashReference' => 97
		}
	},
	{#State 192
		DEFAULT => -213
	},
	{#State 193
		DEFAULT => -95
	},
	{#State 194
		ACTIONS => {
			")" => 278
		}
	},
	{#State 195
		DEFAULT => -16
	},
	{#State 196
		ACTIONS => {
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 279,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147
		}
	},
	{#State 197
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'SubExpression' => 280,
			'HashReference' => 97,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 198
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 281
		}
	},
	{#State 199
		ACTIONS => {
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 282
		}
	},
	{#State 200
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'HashReference' => 97,
			'SubExpression' => 283,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 201
		ACTIONS => {
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashReference' => 97,
			'SubExpression' => 284,
			'HashDereference' => 138
		}
	},
	{#State 202
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 285
		}
	},
	{#State 203
		ACTIONS => {
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'WordScoped' => 141,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 286,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 204
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'SubExpression' => 287,
			'HashReference' => 97,
			'WordScoped' => 141,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 205
		ACTIONS => {
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'SubExpression' => 288,
			'HashReference' => 97,
			'WordScoped' => 141
		}
	},
	{#State 206
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'VARIABLE_SYMBOL' => 117,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'VariableOrLiteral' => 289,
			'Variable' => 291,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 290
		}
	},
	{#State 207
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118
		},
		GOTOS => {
			'WordScoped' => 141,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 292,
			'ArrayDereference' => 95,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129
		}
	},
	{#State 208
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144
		},
		GOTOS => {
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashReference' => 97,
			'SubExpression' => 293,
			'HashDereference' => 138
		}
	},
	{#State 209
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 294,
			'WordScoped' => 141,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 210
		ACTIONS => {
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107
		},
		GOTOS => {
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'SubExpression' => 295,
			'HashDereference' => 138,
			'HashReference' => 97,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 211
		ACTIONS => {
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 296,
			'ArrayDereference' => 95
		}
	},
	{#State 212
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			"undef" => 144
		},
		GOTOS => {
			'WordScoped' => 141,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 297,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129
		}
	},
	{#State 213
		DEFAULT => -186
	},
	{#State 214
		DEFAULT => -184
	},
	{#State 215
		ACTIONS => {
			'MY' => 299,
			'LPAREN_MY' => 298
		}
	},
	{#State 216
		ACTIONS => {
			'LPAREN_MY' => 300,
			'LPAREN' => 301
		}
	},
	{#State 217
		ACTIONS => {
			'MY' => 302
		}
	},
	{#State 218
		DEFAULT => -185
	},
	{#State 219
		DEFAULT => -173
	},
	{#State 220
		ACTIONS => {
			'OP07_STRING_REPEAT' => 196,
			")" => -127,
			"}" => -127,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => -127,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			";" => -127,
			'OP15_LOGICAL_AND' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => -127,
			'OP21_LIST_COMMA' => -127,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP16_LOGICAL_OR' => 212
		}
	},
	{#State 221
		ACTIONS => {
			")" => 303
		}
	},
	{#State 222
		DEFAULT => -133
	},
	{#State 223
		DEFAULT => -241
	},
	{#State 224
		DEFAULT => -240
	},
	{#State 225
		DEFAULT => -242
	},
	{#State 226
		ACTIONS => {
			'FHREF_SYMBOL' => 304
		}
	},
	{#State 227
		ACTIONS => {
			'VARIABLE_SYMBOL' => 305
		}
	},
	{#State 228
		ACTIONS => {
			")" => 306,
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212
		}
	},
	{#State 229
		DEFAULT => -215
	},
	{#State 230
		ACTIONS => {
			"]" => 307
		}
	},
	{#State 231
		ACTIONS => {
			";" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP08_STRING_CAT' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP18_TERNARY' => -108,
			'OP16_LOGICAL_OR' => -108,
			")" => -108,
			'OP07_STRING_REPEAT' => -108,
			"}" => -108,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP04_MATH_POW' => 209
		}
	},
	{#State 232
		DEFAULT => -104
	},
	{#State 233
		ACTIONS => {
			'TYPE_FHREF' => 308
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => 309
		}
	},
	{#State 235
		ACTIONS => {
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP08_STRING_CAT' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP18_TERNARY' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -211,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => -100,
			")" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP04_MATH_POW' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => -100
		}
	},
	{#State 236
		DEFAULT => -176
	},
	{#State 237
		ACTIONS => {
			'OP15_LOGICAL_AND' => -197,
			'OP02_METHOD_THINARROW' => -197,
			";" => -197,
			'OP02_HASH_THINARROW' => 311,
			'OP08_STRING_CAT' => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP18_TERNARY' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP21_LIST_COMMA' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			'OP16_LOGICAL_OR' => -197,
			"}" => -197,
			'OP07_STRING_REPEAT' => -197,
			")" => -197,
			"]" => -197,
			'OP11_COMPARE_LT_GT' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP13_BITWISE_AND' => -197,
			'OP07_MATH_MULT_DIV_MOD' => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP08_MATH_ADD_SUB' => -197,
			'COLON' => -197,
			'OP04_MATH_POW' => -197,
			'OP02_ARRAY_THINARROW' => 310,
			'OP17_LIST_RANGE' => -197,
			'OP12_COMPARE_EQ_NE' => -197
		},
		GOTOS => {
			'VariableRetrieval' => 312
		}
	},
	{#State 238
		DEFAULT => -169
	},
	{#State 239
		DEFAULT => -103
	},
	{#State 240
		ACTIONS => {
			'LBRACKET' => 118
		},
		GOTOS => {
			'ArrayReference' => 313
		}
	},
	{#State 241
		DEFAULT => -218
	},
	{#State 242
		ACTIONS => {
			"}" => 314
		}
	},
	{#State 243
		ACTIONS => {
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'FHREF_SYMBOL_IN' => 315,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'STDIN' => 317
		},
		GOTOS => {
			'WordScoped' => 141,
			'SubExpression' => 316,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpressionOrInput' => 318,
			'ArrayDereference' => 95,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 244
		DEFAULT => -105
	},
	{#State 245
		ACTIONS => {
			'LPAREN' => 319
		}
	},
	{#State 246
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144
		},
		GOTOS => {
			'WordScoped' => 141,
			'HashDereference' => 138,
			'SubExpression' => 320,
			'HashReference' => 97,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129
		}
	},
	{#State 247
		ACTIONS => {
			'LBRACE' => 99
		},
		GOTOS => {
			'HashReference' => 321
		}
	},
	{#State 248
		ACTIONS => {
			"}" => 322
		}
	},
	{#State 249
		DEFAULT => -233
	},
	{#State 250
		ACTIONS => {
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'SubExpression' => 323,
			'HashReference' => 97,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 251
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 210,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			")" => 324,
			'OP07_STRING_REPEAT' => 196,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200
		}
	},
	{#State 252
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'ARGV' => 190,
			")" => -144,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'MY' => 185
		},
		GOTOS => {
			'OPTIONAL-42' => 325,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'ListElements' => 326,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 186,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'TypeInner' => 189,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'ListElement' => 188
		}
	},
	{#State 253
		ACTIONS => {
			'LBRACE' => 99,
			")" => -148
		},
		GOTOS => {
			'HashReference' => 328,
			'OPTIONAL-44' => 327
		}
	},
	{#State 254
		ACTIONS => {
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			")" => 329,
			'OP07_STRING_REPEAT' => 196,
			'OP16_LOGICAL_OR' => 212,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP23_LOGICAL_AND' => 205,
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 255
		ACTIONS => {
			";" => 330
		}
	},
	{#State 256
		DEFAULT => -239
	},
	{#State 257
		ACTIONS => {
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'ARGV' => 190,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"undef" => 144,
			'MY' => 185,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118
		},
		GOTOS => {
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 186,
			'WordScoped' => 141,
			'ListElements' => 331,
			'ArrayDereference' => 95,
			'ListElement' => 188,
			'ArrayReference' => 147,
			'TypeInner' => 189,
			'Variable' => 159,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155
		}
	},
	{#State 258
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 190,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'MY' => 185,
			"undef" => 144
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ListElement' => 188,
			'Variable' => 159,
			'ArrayReference' => 147,
			'TypeInner' => 189,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'SubExpression' => 186,
			'HashReference' => 97,
			'HashDereference' => 138,
			'ListElements' => 332,
			'WordScoped' => 141
		}
	},
	{#State 259
		DEFAULT => -130
	},
	{#State 260
		DEFAULT => -131
	},
	{#State 261
		ACTIONS => {
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => -116,
			";" => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			"]" => -116,
			'OP13_BITWISE_AND' => -116,
			"}" => -116,
			'OP07_STRING_REPEAT' => 196,
			")" => -116,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198
		}
	},
	{#State 262
		ACTIONS => {
			";" => 333
		}
	},
	{#State 263
		ACTIONS => {
			"\$TYPED_" => 334
		}
	},
	{#State 264
		ACTIONS => {
			'WORD_SCOPED' => 223,
			'WORD' => 224,
			'TYPE_INTEGER' => 225
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 265
		ACTIONS => {
			";" => 336
		}
	},
	{#State 266
		ACTIONS => {
			"our hashref \$properties" => 339,
			"use constant" => 62
		},
		GOTOS => {
			'Constant' => 338,
			'Properties' => 337
		}
	},
	{#State 267
		DEFAULT => -70
	},
	{#State 268
		DEFAULT => -163
	},
	{#State 269
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'ARGV' => 190,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'MY' => 185,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107
		},
		GOTOS => {
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147,
			'TypeInner' => 189,
			'ListElement' => 188,
			'ArrayDereference' => 95,
			'ListElements' => 340,
			'WordScoped' => 141,
			'SubExpression' => 186,
			'HashDereference' => 138,
			'HashReference' => 97
		}
	},
	{#State 270
		ACTIONS => {
			'OP21_LIST_COMMA' => 341
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 344,
			"}" => 342
		},
		GOTOS => {
			'PAREN-58' => 343
		}
	},
	{#State 272
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -223,
			'OP01_NAMED' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'LPAREN' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'OP01_OPEN' => -223,
			'WORD' => -223,
			"\@{" => -223,
			'LITERAL_NUMBER' => -223,
			'LBRACE' => -223,
			'WORD_UPPERCASE' => -223,
			'OP01_CLOSE' => -223,
			'WORD_SCOPED' => -223,
			'OP22_LOGICAL_NEG' => -223,
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			'LITERAL_STRING' => -223,
			"%{" => -223,
			'SELF' => -223,
			'VARIABLE_SYMBOL' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'OP10_NAMED_UNARY' => -223,
			'LBRACKET' => -223,
			'MY' => 185,
			"undef" => -223
		},
		GOTOS => {
			'OPTIONAL-57' => 345,
			'TypeInner' => 346
		}
	},
	{#State 273
		ACTIONS => {
			"\$TYPED_" => 347
		}
	},
	{#State 274
		DEFAULT => -139
	},
	{#State 275
		ACTIONS => {
			"]" => -210,
			";" => -210,
			")" => -210,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-53' => 348
		}
	},
	{#State 276
		ACTIONS => {
			"]" => -212,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			")" => -212,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP15_LOGICAL_AND' => 210,
			";" => -212,
			'OP16_LOGICAL_OR' => 212,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP21_LIST_COMMA' => -212,
			'OP23_LOGICAL_AND' => 205
		}
	},
	{#State 277
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_STRING_CAT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP04_MATH_POW' => -100,
			")" => -100,
			'OP07_STRING_REPEAT' => -100,
			"}" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			"]" => -100
		}
	},
	{#State 278
		DEFAULT => -150
	},
	{#State 279
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP18_TERNARY' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP15_LOGICAL_AND' => -111,
			";" => -111,
			'OP08_STRING_CAT' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP06_REGEX_BIND' => 202,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			"}" => -111,
			'OP07_STRING_REPEAT' => -111,
			")" => -111,
			"]" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP13_BITWISE_AND' => -111
		}
	},
	{#State 280
		ACTIONS => {
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => -120,
			'OP13_BITWISE_AND' => -120,
			"}" => -120,
			")" => -120,
			'OP07_STRING_REPEAT' => 196,
			'OP16_LOGICAL_OR' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP18_TERNARY' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP15_LOGICAL_AND' => -120,
			";" => -120
		}
	},
	{#State 281
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP04_MATH_POW' => 209,
			'OP09_BITWISE_SHIFT' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			"]" => -113,
			")" => -113,
			'OP07_STRING_REPEAT' => 196,
			"}" => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_STRING_CAT' => -113,
			";" => -113,
			'OP15_LOGICAL_AND' => -113
		}
	},
	{#State 282
		ACTIONS => {
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => -115,
			'OP08_MATH_ADD_SUB' => 198,
			"]" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP13_BITWISE_AND' => -115,
			"}" => -115,
			'OP07_STRING_REPEAT' => 196,
			")" => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP18_TERNARY' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => -115,
			";" => -115
		}
	},
	{#State 283
		ACTIONS => {
			"]" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP13_BITWISE_AND' => -112,
			"}" => -112,
			")" => -112,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP08_STRING_CAT' => -112,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP15_LOGICAL_AND' => -112,
			";" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP18_TERNARY' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP23_LOGICAL_AND' => -112
		}
	},
	{#State 284
		ACTIONS => {
			";" => -124,
			'OP15_LOGICAL_AND' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => -124,
			'OP21_LIST_COMMA' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP18_TERNARY' => -124,
			'OP16_LOGICAL_OR' => 212,
			'OP07_STRING_REPEAT' => 196,
			")" => -124,
			"}" => -124,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => -124,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209
		}
	},
	{#State 285
		DEFAULT => -110
	},
	{#State 286
		ACTIONS => {
			'OP13_BITWISE_AND' => 197,
			"]" => -121,
			'OP11_COMPARE_LT_GT' => 207,
			")" => -121,
			'OP07_STRING_REPEAT' => 196,
			"}" => -121,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => -121,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP08_STRING_CAT' => 204,
			";" => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP18_TERNARY' => -121,
			'OP24_LOGICAL_OR_XOR' => -121
		}
	},
	{#State 287
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => -114,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP17_LIST_RANGE' => -114,
			"}" => -114,
			")" => -114,
			'OP07_STRING_REPEAT' => 196,
			"]" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP18_TERNARY' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP15_LOGICAL_AND' => -114,
			";" => -114,
			'OP08_STRING_CAT' => -114,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -114
		}
	},
	{#State 288
		ACTIONS => {
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => 197,
			"]" => -128,
			'OP11_COMPARE_LT_GT' => 207,
			'OP07_STRING_REPEAT' => 196,
			")" => -128,
			"}" => -128,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => -128,
			'OP21_LIST_COMMA' => -128,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			";" => -128,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 289
		ACTIONS => {
			'COLON' => 350
		}
	},
	{#State 290
		DEFAULT => -248
	},
	{#State 291
		DEFAULT => -247
	},
	{#State 292
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP08_STRING_CAT' => 204,
			";" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP18_TERNARY' => -118,
			'OP13_BITWISE_AND' => -118,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -118,
			")" => -118,
			'OP07_STRING_REPEAT' => 196,
			"}" => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP17_LIST_RANGE' => -118,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200
		}
	},
	{#State 293
		ACTIONS => {
			'OP15_LOGICAL_AND' => -119,
			";" => -119,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP06_REGEX_BIND' => 202,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP18_TERNARY' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP16_LOGICAL_OR' => -119,
			"}" => -119,
			'OP07_STRING_REPEAT' => 196,
			")" => -119,
			"]" => -119,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 294
		ACTIONS => {
			"]" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP13_BITWISE_AND' => -106,
			"}" => -106,
			")" => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP08_STRING_CAT' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP15_LOGICAL_AND' => -106,
			";" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP23_LOGICAL_AND' => -106
		}
	},
	{#State 295
		ACTIONS => {
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => -122,
			")" => -122,
			'OP07_STRING_REPEAT' => 196,
			"}" => -122,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => -122,
			'OP04_MATH_POW' => 209,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			";" => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP21_LIST_COMMA' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP18_TERNARY' => -122,
			'OP24_LOGICAL_OR_XOR' => -122
		}
	},
	{#State 296
		ACTIONS => {
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => 197,
			"]" => -129,
			'OP11_COMPARE_LT_GT' => 207,
			'OP07_STRING_REPEAT' => 196,
			")" => -129,
			"}" => -129,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -129,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			";" => -129,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 297
		ACTIONS => {
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => -123,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			"]" => -123,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			"}" => -123,
			'OP07_STRING_REPEAT' => 196,
			")" => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP18_TERNARY' => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP21_LIST_COMMA' => -123,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => 210,
			";" => -123
		}
	},
	{#State 298
		ACTIONS => {
			'TYPE_INTEGER' => 351
		}
	},
	{#State 299
		ACTIONS => {
			'TYPE_INTEGER' => 352
		}
	},
	{#State 300
		ACTIONS => {
			'WORD_SCOPED' => 223,
			'WORD' => 224,
			'TYPE_INTEGER' => 225
		},
		GOTOS => {
			'Type' => 353
		}
	},
	{#State 301
		ACTIONS => {
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"undef" => 144,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'WordScoped' => 141,
			'SubExpression' => 354,
			'HashDereference' => 138,
			'HashReference' => 97,
			'ArrayDereference' => 95
		}
	},
	{#State 302
		ACTIONS => {
			'WORD' => 224,
			'TYPE_INTEGER' => 225,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 355
		}
	},
	{#State 303
		ACTIONS => {
			";" => 356
		}
	},
	{#State 304
		ACTIONS => {
			";" => 357
		}
	},
	{#State 305
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 360,
			'OP19_VARIABLE_ASSIGN' => 358,
			";" => 359
		}
	},
	{#State 306
		DEFAULT => -109
	},
	{#State 307
		DEFAULT => -217
	},
	{#State 308
		ACTIONS => {
			'FHREF_SYMBOL' => 361
		}
	},
	{#State 309
		ACTIONS => {
			"undef" => 144,
			'MY' => 185,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			'ARGV' => 190,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'ListElement' => 188,
			'ArrayReference' => 147,
			'Variable' => 159,
			'TypeInner' => 189,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 186,
			'WordScoped' => 141,
			'ListElements' => 362,
			'ArrayDereference' => 95
		}
	},
	{#State 310
		ACTIONS => {
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 144,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142
		},
		GOTOS => {
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 363,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 311
		ACTIONS => {
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD' => 364,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'WordScoped' => 141,
			'SubExpression' => 365,
			'HashReference' => 97,
			'HashDereference' => 138,
			'ArrayDereference' => 95,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 312
		DEFAULT => -195
	},
	{#State 313
		ACTIONS => {
			"}" => 366
		}
	},
	{#State 314
		DEFAULT => -220
	},
	{#State 315
		DEFAULT => -165
	},
	{#State 316
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			")" => -164,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP15_LOGICAL_AND' => 210,
			";" => -164,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP23_LOGICAL_AND' => 205
		}
	},
	{#State 317
		DEFAULT => -166
	},
	{#State 318
		DEFAULT => -205
	},
	{#State 319
		ACTIONS => {
			'LBRACE' => 99,
			'ARGV' => 190,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			"undef" => 144,
			'MY' => 185,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			")" => -146,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140
		},
		GOTOS => {
			'WordScoped' => 141,
			'ListElements' => 367,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 186,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'TypeInner' => 189,
			'ArrayReference' => 147,
			'Variable' => 159,
			'ListElement' => 188,
			'Expression' => 155,
			'OPTIONAL-43' => 368,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 320
		ACTIONS => {
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212,
			";" => -206,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			")" => -206,
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207
		}
	},
	{#State 321
		ACTIONS => {
			"}" => 369
		}
	},
	{#State 322
		DEFAULT => -235
	},
	{#State 323
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP07_STRING_REPEAT' => 196,
			")" => 370,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 324
		DEFAULT => -107
	},
	{#State 325
		ACTIONS => {
			")" => 371
		}
	},
	{#State 326
		DEFAULT => -143
	},
	{#State 327
		ACTIONS => {
			")" => 372
		}
	},
	{#State 328
		DEFAULT => -147
	},
	{#State 329
		DEFAULT => -126
	},
	{#State 330
		DEFAULT => -142
	},
	{#State 331
		ACTIONS => {
			";" => 373
		}
	},
	{#State 332
		ACTIONS => {
			";" => 374
		}
	},
	{#State 333
		DEFAULT => -56
	},
	{#State 334
		ACTIONS => {
			'WORD_UPPERCASE' => 375
		}
	},
	{#State 335
		ACTIONS => {
			"\$RETURN_TYPE" => 376
		}
	},
	{#State 336
		ACTIONS => {
			"}" => 377
		}
	},
	{#State 337
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 378
		}
	},
	{#State 338
		DEFAULT => -72
	},
	{#State 339
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 340
		ACTIONS => {
			")" => 380
		}
	},
	{#State 341
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'ARGV' => 190,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP01_NAMED' => 191,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			"undef" => 144,
			'MY' => 185,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'WordScoped' => 141,
			'ListElements' => 381,
			'HashReference' => 97,
			'SubExpression' => 186,
			'HashDereference' => 138,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'TypeInner' => 189,
			'ListElement' => 188,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 342
		DEFAULT => -231
	},
	{#State 343
		DEFAULT => -229
	},
	{#State 344
		ACTIONS => {
			'OP01_NAMED' => 174,
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP01_OPEN' => 172,
			'OP23_LOGICAL_AND' => 182,
			'WORD' => 171,
			'OP24_LOGICAL_OR_XOR' => 170,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_VOID' => 180,
			'OP01_CLOSE' => 167,
			'OP07_STRING_REPEAT' => 179,
			'OP22_LOGICAL_NEG' => 178,
			"%{" => 137,
			'OP11_COMPARE_LT_GT' => 165,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'OP10_NAMED_UNARY' => 164,
			'VARIABLE_SYMBOL' => 117,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP19_LOOP_CONTROL' => 163,
			'OP01_PRINT' => 162,
			'OP12_COMPARE_EQ_NE' => 161,
			'ENV' => 160
		},
		GOTOS => {
			'Literal' => 168,
			'HashEntry' => 382,
			'VariableSymbolOrSelf' => 130,
			'OpStringOrWord' => 181,
			'Variable' => 169,
			'VarOrLitOrOpStrOrWord' => 184,
			'HashDereference' => 166
		}
	},
	{#State 345
		ACTIONS => {
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"undef" => 144,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'SubExpression' => 383,
			'HashDereference' => 138,
			'HashReference' => 97,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 346
		DEFAULT => -222
	},
	{#State 347
		ACTIONS => {
			'WORD' => 171,
			'OP23_LOGICAL_AND' => 182,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP01_NAMED_VOID' => 180,
			'OP01_CLOSE' => 167,
			'OP01_NAMED' => 174,
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP01_OPEN' => 172,
			'OP08_MATH_ADD_SUB' => 176,
			'OP10_NAMED_UNARY' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP01_PRINT' => 162,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP19_LOOP_CONTROL' => 163,
			'OP22_LOGICAL_NEG' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => 165
		},
		GOTOS => {
			'OpStringOrWord' => 384
		}
	},
	{#State 348
		DEFAULT => -208
	},
	{#State 349
		ACTIONS => {
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'MY' => 185,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'ARGV' => 190,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'OP01_QW' => 192,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 147,
			'TypeInner' => 189,
			'Operator' => 119,
			'ListElement' => 385,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'WordScoped' => 141,
			'HashReference' => 97,
			'SubExpression' => 186,
			'HashDereference' => 138,
			'ArrayDereference' => 95
		}
	},
	{#State 350
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'VARIABLE_SYMBOL' => 117,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Literal' => 290,
			'VariableSymbolOrSelf' => 130,
			'VariableOrLiteral' => 386,
			'Variable' => 291
		}
	},
	{#State 351
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 352
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 354
		ACTIONS => {
			'OP15_LOGICAL_AND' => 210,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP23_LOGICAL_AND' => 205,
			'OP16_LOGICAL_OR' => 212,
			'OP07_STRING_REPEAT' => 196,
			")" => 390,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208
		}
	},
	{#State 355
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 356
		DEFAULT => -138
	},
	{#State 357
		DEFAULT => -204
	},
	{#State 358
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'STDIN' => 317,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'FHREF_SYMBOL_IN' => 315,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY_SCOLON' => 394,
			'OP01_NAMED_SCOLON' => 393,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 316,
			'WordScoped' => 141,
			'ArrayDereference' => 95,
			'OpNamedScolonOrSubExpIn' => 392,
			'SubExpressionOrInput' => 395
		}
	},
	{#State 359
		DEFAULT => -201
	},
	{#State 360
		ACTIONS => {
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'HashReference' => 97,
			'SubExpression' => 396,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 361
		ACTIONS => {
			'OP21_LIST_COMMA' => 397
		}
	},
	{#State 362
		ACTIONS => {
			";" => 398
		}
	},
	{#State 363
		ACTIONS => {
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => 197,
			"]" => 399,
			'OP11_COMPARE_LT_GT' => 207,
			'OP07_STRING_REPEAT' => 196,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 364
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -237,
			'LPAREN' => -237,
			"}" => 400
		}
	},
	{#State 365
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			"}" => 401,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_STRING_CAT' => 204,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP15_LOGICAL_AND' => 210,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP23_LOGICAL_AND' => 205
		}
	},
	{#State 366
		DEFAULT => -221
	},
	{#State 367
		DEFAULT => -145
	},
	{#State 368
		ACTIONS => {
			")" => 402
		}
	},
	{#State 369
		DEFAULT => -236
	},
	{#State 370
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 371
		DEFAULT => -152
	},
	{#State 372
		DEFAULT => -154
	},
	{#State 373
		DEFAULT => -135
	},
	{#State 374
		DEFAULT => -136
	},
	{#State 375
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 405
		}
	},
	{#State 376
		ACTIONS => {
			"}" => 406
		}
	},
	{#State 377
		DEFAULT => -55
	},
	{#State 378
		ACTIONS => {
			'SUB' => 407,
			'LITERAL_NUMBER' => 408
		},
		GOTOS => {
			'Method' => 410,
			'SubroutineOrMethod' => 411,
			'Subroutine' => 409
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 412
		}
	},
	{#State 380
		DEFAULT => -99
	},
	{#State 381
		ACTIONS => {
			")" => 413
		}
	},
	{#State 382
		DEFAULT => -228
	},
	{#State 383
		ACTIONS => {
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP07_STRING_REPEAT' => 196,
			"}" => -224,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -224,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 384
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 414
		}
	},
	{#State 385
		DEFAULT => -207
	},
	{#State 386
		DEFAULT => -125
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 388
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 389
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 390
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 418
		}
	},
	{#State 391
		ACTIONS => {
			'LPAREN' => 419
		}
	},
	{#State 392
		DEFAULT => -202
	},
	{#State 393
		DEFAULT => -259
	},
	{#State 394
		DEFAULT => -260
	},
	{#State 395
		ACTIONS => {
			";" => 420
		}
	},
	{#State 396
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 207,
			"]" => 421,
			'OP13_BITWISE_AND' => 197,
			'OP07_STRING_REPEAT' => 196,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => 210,
			'OP16_LOGICAL_OR' => 212,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP23_LOGICAL_AND' => 205
		}
	},
	{#State 397
		ACTIONS => {
			'LITERAL_STRING' => 422
		}
	},
	{#State 398
		DEFAULT => -140
	},
	{#State 399
		DEFAULT => -198
	},
	{#State 400
		DEFAULT => -200
	},
	{#State 401
		DEFAULT => -199
	},
	{#State 402
		DEFAULT => -153
	},
	{#State 403
		ACTIONS => {
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 96,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED_VOID' => 100,
			'LBRACE' => 99,
			"for" => -171,
			'WORD_UPPERCASE' => 102,
			"while" => -171,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_SCOLON' => 105,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG' => 110,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'MY' => 113,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACKET' => 118,
			'OP03_MATH_INC_DEC' => 122,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'WORD' => 31,
			"\@{" => 134,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			"%{" => 137,
			"if" => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP01_PRINT' => 145,
			"undef" => 144,
			'OP19_LOOP_CONTROL' => 143,
			'OP10_NAMED_UNARY' => 146
		},
		GOTOS => {
			'Conditional' => 114,
			'ArrayReference' => 147,
			'Operator' => 119,
			'OperatorVoid' => 120,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'SubExpression' => 108,
			'PAREN-45' => 111,
			'OPTIONAL-46' => 109,
			'Expression' => 101,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Operation' => 423,
			'LoopLabel' => 131,
			'Variable' => 135,
			'VariableDeclaration' => 124,
			'ArrayDereference' => 95,
			'PLUS-51' => 424,
			'Statement' => 128,
			'VariableModification' => 127,
			'HashReference' => 97
		}
	},
	{#State 404
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 425
		}
	},
	{#State 405
		DEFAULT => -246
	},
	{#State 406
		ACTIONS => {
			";" => 426
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 427
		}
	},
	{#State 408
		ACTIONS => {
			";" => 428
		}
	},
	{#State 409
		DEFAULT => -93
	},
	{#State 410
		DEFAULT => -94
	},
	{#State 411
		DEFAULT => -74
	},
	{#State 412
		ACTIONS => {
			'OP01_NAMED' => 174,
			'OP01_OPEN' => 172,
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP24_LOGICAL_OR_XOR' => 170,
			'WORD' => 171,
			'OP23_LOGICAL_AND' => 182,
			'OP01_CLOSE' => 167,
			'OP01_NAMED_VOID' => 180,
			"}" => 430,
			'OP22_LOGICAL_NEG' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP08_MATH_ADD_SUB' => 176,
			'OP10_NAMED_UNARY' => 164,
			'OP01_PRINT' => 162,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP19_LOOP_CONTROL' => 163
		},
		GOTOS => {
			'OpStringOrWord' => 431,
			'HashEntryProperties' => 429
		}
	},
	{#State 413
		DEFAULT => -101
	},
	{#State 414
		DEFAULT => -243
	},
	{#State 415
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY_SCOLON' => 434,
			'OP01_NAMED_SCOLON' => 432,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"undef" => 144,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashDereference' => 138,
			'SubExpression' => 433,
			'HashReference' => 97,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'OpNamedScolonOrSubExp' => 435,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147
		}
	},
	{#State 416
		ACTIONS => {
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashReference' => 97,
			'SubExpression' => 436,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'Operator' => 119,
			'Variable' => 159,
			'ArrayReference' => 147
		}
	},
	{#State 417
		ACTIONS => {
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			"undef" => 144,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			'FHREF_SYMBOL_IN' => 315,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'STDIN' => 317,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'SubExpressionOrInput' => 437,
			'SubExpression' => 316,
			'HashReference' => 97,
			'HashDereference' => 138,
			'WordScoped' => 141
		}
	},
	{#State 418
		DEFAULT => -190
	},
	{#State 419
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			"undef" => 144,
			'MY' => 185,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_QW' => 192,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 190,
			'OP01_CLOSE' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Expression' => 155,
			'ListElement' => 188,
			'TypeInner' => 189,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'ArrayDereference' => 95,
			'SubExpression' => 186,
			'HashReference' => 97,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'ListElements' => 438
		}
	},
	{#State 420
		DEFAULT => -261
	},
	{#State 421
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 439
		}
	},
	{#State 422
		ACTIONS => {
			'OP21_LIST_COMMA' => 440
		}
	},
	{#State 423
		DEFAULT => -193
	},
	{#State 424
		ACTIONS => {
			'OP10_NAMED_UNARY' => 146,
			"undef" => 144,
			'OP19_LOOP_CONTROL' => 143,
			'OP01_PRINT' => 145,
			"if" => 139,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			"%{" => 137,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 126,
			'OP05_LOGICAL_NEG' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			"foreach" => -171,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_OPEN' => 125,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'MY' => 113,
			'OP22_LOGICAL_NEG' => 110,
			"}" => 442,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP01_NAMED_SCOLON' => 105,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			"while" => -171,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 100,
			"for" => -171,
			'WORD_UPPERCASE' => 102,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 96
		},
		GOTOS => {
			'Conditional' => 114,
			'ArrayReference' => 147,
			'Operator' => 119,
			'OperatorVoid' => 120,
			'WordScoped' => 141,
			'SubExpression' => 108,
			'HashDereference' => 138,
			'OPTIONAL-46' => 109,
			'PAREN-45' => 111,
			'Expression' => 101,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'LoopLabel' => 131,
			'Operation' => 441,
			'Variable' => 135,
			'VariableDeclaration' => 124,
			'ArrayDereference' => 95,
			'Statement' => 128,
			'VariableModification' => 127,
			'HashReference' => 97
		}
	},
	{#State 425
		ACTIONS => {
			'WORD' => -182,
			"\@{" => -182,
			'WORD_SCOPED' => -182,
			'OP01_CLOSE' => -182,
			'OP01_NAMED' => -182,
			"foreach" => -182,
			'OP03_MATH_INC_DEC' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'OP05_LOGICAL_NEG' => -182,
			'OP01_OPEN' => -182,
			'' => -182,
			'OP10_NAMED_UNARY' => -182,
			'OP01_PRINT' => -182,
			'OP19_LOOP_CONTROL' => -182,
			"undef" => -182,
			"if" => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			"%{" => -182,
			"while" => -182,
			'LITERAL_NUMBER' => -182,
			'LBRACE' => -182,
			'OP01_NAMED_VOID' => -182,
			"for" => -182,
			'WORD_UPPERCASE' => -182,
			'CONSTANT_CALL_SCOPED' => -182,
			'LPAREN' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'VARIABLE_SYMBOL' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			'LBRACKET' => -182,
			"else" => 445,
			'MY' => -182,
			'OP22_LOGICAL_NEG' => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			"}" => -182,
			"elsif" => 446,
			'OP01_NAMED_SCOLON' => -182,
			'LITERAL_STRING' => -182,
			'SELF' => -182
		},
		GOTOS => {
			'PAREN-47' => 444,
			'OPTIONAL-50' => 443,
			'PAREN-49' => 447
		}
	},
	{#State 426
		ACTIONS => {
			'WORD' => -58,
			"\@{" => -58,
			'OP01_CLOSE' => -58,
			'WORD_SCOPED' => -58,
			'OP01_NAMED' => -58,
			'OP03_MATH_INC_DEC' => -58,
			"foreach" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP01_OPEN' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP01_PRINT' => -58,
			"undef" => -58,
			'OP19_LOOP_CONTROL' => -58,
			"if" => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			"%{" => -58,
			"while" => -58,
			'LITERAL_NUMBER' => -58,
			'LBRACE' => -58,
			'OP01_NAMED_VOID' => -58,
			'LPAREN_MY' => 450,
			'WORD_UPPERCASE' => -58,
			"for" => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'LPAREN' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'VARIABLE_SYMBOL' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'LBRACKET' => -58,
			'MY' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			"}" => -58,
			'OP01_NAMED_SCOLON' => -58,
			'SELF' => -58,
			'LITERAL_STRING' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 449,
			'SubroutineArguments' => 448
		}
	},
	{#State 427
		ACTIONS => {
			'LBRACE' => 451
		}
	},
	{#State 428
		DEFAULT => -76
	},
	{#State 429
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 452
		}
	},
	{#State 430
		ACTIONS => {
			";" => 453
		}
	},
	{#State 431
		ACTIONS => {
			'OP20_HASH_FATARROW' => 454
		}
	},
	{#State 432
		DEFAULT => -256
	},
	{#State 433
		ACTIONS => {
			'OP23_LOGICAL_AND' => 205,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP16_LOGICAL_OR' => 212,
			";" => 455,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207
		}
	},
	{#State 434
		DEFAULT => -257
	},
	{#State 435
		ACTIONS => {
			'VARIABLE_SYMBOL' => 456
		}
	},
	{#State 436
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP17_LIST_RANGE' => 457,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 437
		ACTIONS => {
			")" => 458
		}
	},
	{#State 438
		ACTIONS => {
			")" => 459
		}
	},
	{#State 439
		ACTIONS => {
			"undef" => 460
		}
	},
	{#State 440
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 144,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'VARIABLE_SYMBOL' => 117,
			'SELF' => 107,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'SubExpression' => 461,
			'HashReference' => 97,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119
		}
	},
	{#State 441
		DEFAULT => -192
	},
	{#State 442
		DEFAULT => -194
	},
	{#State 443
		DEFAULT => -183
	},
	{#State 444
		DEFAULT => -178
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 446
		ACTIONS => {
			'LPAREN' => 463
		}
	},
	{#State 447
		DEFAULT => -181
	},
	{#State 448
		DEFAULT => -57
	},
	{#State 449
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 464
		}
	},
	{#State 450
		ACTIONS => {
			'WORD' => 224,
			'TYPE_INTEGER' => 225,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 465
		}
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 466
		}
	},
	{#State 452
		ACTIONS => {
			"}" => 468,
			'OP21_LIST_COMMA' => 467
		},
		GOTOS => {
			'PAREN-33' => 469
		}
	},
	{#State 453
		DEFAULT => -83
	},
	{#State 454
		ACTIONS => {
			'MY' => 470
		},
		GOTOS => {
			'TypeInnerProperties' => 471
		}
	},
	{#State 455
		DEFAULT => -258
	},
	{#State 456
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 472
		}
	},
	{#State 457
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134
		},
		GOTOS => {
			'ArrayDereference' => 95,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 473,
			'WordScoped' => 141,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119
		}
	},
	{#State 458
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 474
		}
	},
	{#State 459
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 460
		ACTIONS => {
			";" => 476
		}
	},
	{#State 461
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => 212,
			";" => -102,
			'OP15_LOGICAL_AND' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP07_STRING_REPEAT' => 196,
			")" => -102,
			"}" => -102,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => -102
		}
	},
	{#State 462
		DEFAULT => -180
	},
	{#State 463
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			"%{" => 137,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LBRACKET' => 118,
			"undef" => 144,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP01_OPEN' => 125,
			'WORD' => 31,
			"\@{" => 134,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 147,
			'Operator' => 119,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'HashReference' => 97,
			'SubExpression' => 477,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 464
		ACTIONS => {
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 126,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			'OP01_OPEN' => 125,
			'OP10_NAMED_UNARY' => 146,
			'OP19_LOOP_CONTROL' => 143,
			"undef" => 144,
			'OP01_PRINT' => 145,
			"if" => 139,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			"%{" => 137,
			"while" => -171,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_VOID' => 100,
			'LBRACE' => 99,
			"for" => -171,
			'WORD_UPPERCASE' => 102,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'MY' => 113,
			'OP22_LOGICAL_NEG' => 110,
			"}" => 478,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP01_NAMED_SCOLON' => 105,
			'SELF' => 107,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'Conditional' => 114,
			'ArrayReference' => 147,
			'Operator' => 119,
			'OperatorVoid' => 120,
			'HashDereference' => 138,
			'SubExpression' => 108,
			'OPTIONAL-46' => 109,
			'PAREN-45' => 111,
			'WordScoped' => 141,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'LoopLabel' => 131,
			'Operation' => 479,
			'Expression' => 101,
			'Variable' => 135,
			'ArrayDereference' => 95,
			'VariableDeclaration' => 124,
			'HashReference' => 97,
			'VariableModification' => 127,
			'Statement' => 128
		}
	},
	{#State 465
		ACTIONS => {
			'VARIABLE_SYMBOL' => 480
		}
	},
	{#State 466
		ACTIONS => {
			'MY' => 481
		}
	},
	{#State 467
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP01_OPEN' => 172,
			'OP01_NAMED' => 174,
			'OP01_NAMED_VOID' => 180,
			'OP01_CLOSE' => 167,
			'WORD' => 171,
			'OP23_LOGICAL_AND' => 182,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP11_COMPARE_LT_GT' => 165,
			'OP22_LOGICAL_NEG' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP01_PRINT' => 162,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP19_LOOP_CONTROL' => 163,
			'OP08_MATH_ADD_SUB' => 176,
			'OP10_NAMED_UNARY' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 175
		},
		GOTOS => {
			'OpStringOrWord' => 431,
			'HashEntryProperties' => 482
		}
	},
	{#State 468
		ACTIONS => {
			";" => 483
		}
	},
	{#State 469
		DEFAULT => -80
	},
	{#State 470
		ACTIONS => {
			'TYPE_INTEGER' => 225,
			'WORD' => 224,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 484
		}
	},
	{#State 471
		DEFAULT => -227
	},
	{#State 472
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 434,
			'OP01_NAMED_SCOLON' => 432
		},
		GOTOS => {
			'ArrayReference' => 147,
			'Variable' => 159,
			'Operator' => 119,
			'OpNamedScolonOrSubExp' => 485,
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'WordScoped' => 141,
			'SubExpression' => 433,
			'HashDereference' => 138,
			'HashReference' => 97,
			'ArrayDereference' => 95
		}
	},
	{#State 473
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			")" => 486,
			'OP07_STRING_REPEAT' => 196,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => -124,
			'OP18_TERNARY' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 210
		}
	},
	{#State 474
		DEFAULT => -191
	},
	{#State 475
		DEFAULT => -189
	},
	{#State 476
		DEFAULT => -203
	},
	{#State 477
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			")" => 487,
			'OP07_STRING_REPEAT' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP23_LOGICAL_AND' => 205,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 478
		DEFAULT => -61
	},
	{#State 479
		DEFAULT => -59
	},
	{#State 480
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 488
		}
	},
	{#State 481
		ACTIONS => {
			'TYPE_INTEGER' => 225,
			'WORD' => 224,
			'WORD_SCOPED' => 223,
			'TYPE_METHOD' => 489
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 482
		DEFAULT => -79
	},
	{#State 483
		DEFAULT => -82
	},
	{#State 484
		ACTIONS => {
			"\$TYPED_" => 490
		}
	},
	{#State 485
		ACTIONS => {
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'LPAREN' => 94,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122
		},
		GOTOS => {
			'Expression' => 155,
			'VariableSymbolOrSelf' => 130,
			'Literal' => 129,
			'Variable' => 135,
			'ArrayReference' => 147,
			'Operator' => 119,
			'SubExpressionOrVarMod' => 492,
			'ArrayDereference' => 95,
			'WordScoped' => 141,
			'VariableModification' => 493,
			'HashReference' => 97,
			'HashDereference' => 138,
			'SubExpression' => 491
		}
	},
	{#State 486
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 494
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 495
		}
	},
	{#State 488
		ACTIONS => {
			")" => 497,
			'OP21_LIST_COMMA' => 496
		},
		GOTOS => {
			'PAREN-26' => 498
		}
	},
	{#State 489
		ACTIONS => {
			"\$RETURN_TYPE" => 499
		}
	},
	{#State 490
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 165,
			'OP07_STRING_REPEAT' => 179,
			'OP22_LOGICAL_NEG' => 178,
			'OP19_LOOP_CONTROL' => 163,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP01_PRINT' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP10_NAMED_UNARY' => 164,
			'OP08_MATH_ADD_SUB' => 176,
			'OP01_OPEN' => 172,
			'OP19_LOOP_CONTROL_SCOLON' => 173,
			'OP01_NAMED' => 174,
			'OP01_CLOSE' => 167,
			'OP01_NAMED_VOID' => 180,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP23_LOGICAL_AND' => 182,
			'WORD' => 171
		},
		GOTOS => {
			'OpStringOrWord' => 500
		}
	},
	{#State 491
		ACTIONS => {
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP18_TERNARY' => 206,
			'OP23_LOGICAL_AND' => 205,
			'OP08_STRING_CAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => 210,
			'OP04_MATH_POW' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP09_BITWISE_SHIFT' => 199,
			'OP08_MATH_ADD_SUB' => 198,
			'OP11_COMPARE_LT_GT' => 207,
			'OP13_BITWISE_AND' => 197,
			'OP07_STRING_REPEAT' => 196,
			")" => -167
		}
	},
	{#State 492
		ACTIONS => {
			")" => 501
		}
	},
	{#State 493
		DEFAULT => -168
	},
	{#State 494
		DEFAULT => -187
	},
	{#State 495
		DEFAULT => -177
	},
	{#State 496
		ACTIONS => {
			'MY' => 502
		}
	},
	{#State 497
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 503
		}
	},
	{#State 498
		DEFAULT => -63
	},
	{#State 499
		ACTIONS => {
			"}" => 504
		}
	},
	{#State 500
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 505,
			'OP19_VARIABLE_ASSIGN' => 506
		}
	},
	{#State 501
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 507
		}
	},
	{#State 502
		ACTIONS => {
			'TYPE_INTEGER' => 225,
			'WORD' => 224,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 508
		}
	},
	{#State 503
		ACTIONS => {
			"\@ARG;" => 509
		}
	},
	{#State 504
		ACTIONS => {
			";" => 510
		}
	},
	{#State 505
		ACTIONS => {
			"undef" => 144,
			'LBRACKET' => 118,
			'VARIABLE_SYMBOL' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 146,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			"%{" => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG' => 110,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'LITERAL_NUMBER' => 104,
			'WORD' => 31,
			"\@{" => 134,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_NAMED' => 191
		},
		GOTOS => {
			'WordScoped' => 141,
			'SubExpression' => 511,
			'HashReference' => 97,
			'HashDereference' => 138,
			'ArrayDereference' => 95,
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Expression' => 155,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130
		}
	},
	{#State 506
		ACTIONS => {
			'OP01_NAMED' => 191,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP01_OPEN' => 125,
			'OP05_LOGICAL_NEG' => 121,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 122,
			'LITERAL_NUMBER' => 104,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_UPPERCASE' => 156,
			'WORD_SCOPED' => 32,
			'LBRACE' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 110,
			'LITERAL_STRING' => 106,
			"%{" => 137,
			'SELF' => 107,
			'LBRACKET' => 118,
			'OP10_NAMED_UNARY' => 146,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			"undef" => 144
		},
		GOTOS => {
			'Operator' => 119,
			'ArrayReference' => 147,
			'Variable' => 159,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'Expression' => 155,
			'SubExpression' => 512,
			'HashReference' => 97,
			'HashDereference' => 138,
			'WordScoped' => 141,
			'ArrayDereference' => 95
		}
	},
	{#State 507
		DEFAULT => -188
	},
	{#State 508
		ACTIONS => {
			'VARIABLE_SYMBOL' => 513
		}
	},
	{#State 509
		DEFAULT => -65
	},
	{#State 510
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -85,
			'SELF' => -85,
			'LITERAL_STRING' => -85,
			'OP22_LOGICAL_NEG' => -85,
			"}" => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'MY' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'VARIABLE_SYMBOL' => -85,
			'LBRACKET' => -85,
			'LPAREN' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP01_NAMED_VOID' => -85,
			'LPAREN_MY' => 515,
			'LBRACE' => -85,
			"for" => -85,
			'WORD_UPPERCASE' => -85,
			"while" => -85,
			'LITERAL_NUMBER' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			"%{" => -85,
			"if" => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			"undef" => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP01_PRINT' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP05_LOGICAL_NEG' => -85,
			"foreach" => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_OPEN' => -85,
			'OP01_NAMED' => -85,
			'OP01_CLOSE' => -85,
			'WORD_SCOPED' => -85,
			"\@{" => -85,
			'WORD' => -85
		},
		GOTOS => {
			'MethodArguments' => 514,
			'OPTIONAL-35' => 516
		}
	},
	{#State 511
		ACTIONS => {
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			"]" => 517,
			'OP07_STRING_REPEAT' => 196,
			'OP17_LIST_RANGE' => 201,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP04_MATH_POW' => 209,
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 210,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211
		}
	},
	{#State 512
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 198,
			'OP09_BITWISE_SHIFT' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 200,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 209,
			'OP07_STRING_REPEAT' => 196,
			"}" => -244,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 207,
			'OP21_LIST_COMMA' => -244,
			'OP23_LOGICAL_AND' => 205,
			'OP18_TERNARY' => 206,
			'OP24_LOGICAL_OR_XOR' => 211,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 513
		DEFAULT => -62
	},
	{#State 514
		DEFAULT => -84
	},
	{#State 515
		ACTIONS => {
			'WORD' => 224,
			'TYPE_INTEGER' => 225,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 516
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 519
		}
	},
	{#State 517
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 520
		}
	},
	{#State 518
		ACTIONS => {
			'SELF' => 521
		}
	},
	{#State 519
		ACTIONS => {
			"if" => 139,
			'OP05_BITWISE_NEG_LPAREN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY_SCOLON' => 136,
			"%{" => 137,
			'OP10_NAMED_UNARY' => 146,
			'OP19_LOOP_CONTROL' => 143,
			"undef" => 144,
			'OP01_PRINT' => 145,
			'OP01_NAMED' => 126,
			'OP05_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 122,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 123,
			'OP01_OPEN' => 125,
			"\@{" => 134,
			'WORD' => 31,
			'OP01_CLOSE' => 133,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG' => 110,
			"}" => 523,
			'OP01_NAMED_VOID_LPAREN' => 112,
			'OP01_NAMED_SCOLON' => 105,
			'LITERAL_STRING' => 106,
			'SELF' => 107,
			'OP05_MATH_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 117,
			'LBRACKET' => 118,
			'MY' => 113,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 96,
			"while" => -171,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_VOID' => 100,
			'LBRACE' => 99,
			"for" => -171,
			'WORD_UPPERCASE' => 102
		},
		GOTOS => {
			'Expression' => 101,
			'Literal' => 129,
			'VariableSymbolOrSelf' => 130,
			'LoopLabel' => 131,
			'Operation' => 522,
			'Variable' => 135,
			'VariableDeclaration' => 124,
			'ArrayDereference' => 95,
			'Statement' => 128,
			'VariableModification' => 127,
			'HashReference' => 97,
			'Conditional' => 114,
			'ArrayReference' => 147,
			'Operator' => 119,
			'OperatorVoid' => 120,
			'WordScoped' => 141,
			'HashDereference' => 138,
			'SubExpression' => 108,
			'OPTIONAL-46' => 109,
			'PAREN-45' => 111
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
			'OP21_LIST_COMMA' => 526,
			")" => 528
		},
		GOTOS => {
			'PAREN-37' => 527
		}
	},
	{#State 526
		ACTIONS => {
			'MY' => 529
		}
	},
	{#State 527
		DEFAULT => -90
	},
	{#State 528
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 530
		}
	},
	{#State 529
		ACTIONS => {
			'WORD' => 224,
			'TYPE_INTEGER' => 225,
			'WORD_SCOPED' => 223
		},
		GOTOS => {
			'Type' => 531
		}
	},
	{#State 530
		ACTIONS => {
			"\@ARG;" => 532
		}
	},
	{#State 531
		ACTIONS => {
			'VARIABLE_SYMBOL' => 533
		}
	},
	{#State 532
		DEFAULT => -92
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
