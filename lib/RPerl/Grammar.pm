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
    our $VERSION = 0.011_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|package|foreach|\$TYPED_|\@ARG\;|elsif|while|undef|else|for|\@\{|if|\%\{|\{|\)|\;|\]|\})}gc and return ($1, $1);

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
  [ 'Include_55' => 'Include', [ '{', 'WordScoped', 'OP02_METHOD_THINARROW_IMP', 'OPTIONAL-23', ')', ';', '}' ], 0 ],
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
	'{' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 1,
			'USE_RPERL' => -20,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'Program' => 2,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 7,
			'Critic' => 5,
			'CompileUnit' => 6,
			'PLUS-2' => 4,
			'ModuleHeader' => 3
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 10,
			'OPTIONAL-3' => 11
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"use parent qw(" => 13,
			"{" => -27,
			"use parent -norequire, qw(" => 16,
			'USE' => -27,
			"use constant" => -27,
			'SUB' => -27,
			'USE_EXPORTER' => -27,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'UseParent' => 17,
			'Package' => 15,
			'Module' => 14,
			'Class' => 12,
			'STAR-11' => 18
		}
	},
	{#State 4
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 9,
			'USE_RPERL' => -20,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 19,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 3,
			'Critic' => 5
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			'' => 20
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => 21,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 22
		}
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
		DEFAULT => -6
	},
	{#State 11
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		DEFAULT => -77
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		DEFAULT => -24
	},
	{#State 16
		DEFAULT => -78
	},
	{#State 17
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 18
		ACTIONS => {
			"{" => -29,
			'SUB' => -29,
			"use constant" => -29,
			'USE' => -29,
			"## no critic qw(" => 9,
			'USE_EXPORTER' => 31
		},
		GOTOS => {
			'OPTIONAL-12' => 32,
			'Exports' => 30,
			'Critic' => 29
		}
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		DEFAULT => -21
	},
	{#State 22
		ACTIONS => {
			"package" => 33
		}
	},
	{#State 23
		DEFAULT => -41
	},
	{#State 24
		ACTIONS => {
			'WORD' => 35,
			")" => 34
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
		DEFAULT => -237
	},
	{#State 27
		DEFAULT => -238
	},
	{#State 28
		ACTIONS => {
			")" => 38
		}
	},
	{#State 29
		DEFAULT => -26
	},
	{#State 30
		DEFAULT => -28
	},
	{#State 31
		ACTIONS => {
			'OUR_EXPORT' => 40,
			"{" => -45,
			'OUR_EXPORT_OK' => -45,
			'SUB' => -45,
			"our hashref \$properties" => -45,
			'USE' => -45,
			"use constant" => -45
		},
		GOTOS => {
			'OPTIONAL-19' => 39,
			'PAREN-18' => 41
		}
	},
	{#State 32
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 42
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 34
		DEFAULT => -42
	},
	{#State 35
		DEFAULT => -40
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
		ACTIONS => {
			";" => 46
		}
	},
	{#State 39
		ACTIONS => {
			"our hashref \$properties" => -48,
			'SUB' => -48,
			"{" => -48,
			"use constant" => -48,
			'USE' => -48,
			'OUR_EXPORT_OK' => 48
		},
		GOTOS => {
			'PAREN-20' => 49,
			'OPTIONAL-21' => 47
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 50
		}
	},
	{#State 41
		DEFAULT => -44
	},
	{#State 42
		ACTIONS => {
			"{" => 52,
			'SUB' => -33,
			"use constant" => -33,
			'USE' => 54
		},
		GOTOS => {
			'Include' => 51,
			'STAR-14' => 53
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55
		}
	},
	{#State 44
		ACTIONS => {
			'WORD_SCOPED' => -11,
			"use constant" => -11,
			'USE' => -11,
			'OP01_NAMED' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_PRINT' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"%{" => -11,
			"undef" => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP01_OPEN' => -11,
			"while" => -11,
			'OP10_NAMED_UNARY' => -11,
			'LBRACE' => -11,
			"for" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'MY' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_NUMBER' => -11,
			"## no critic qw(" => 9,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"{" => -11,
			'WORD_UPPERCASE' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"foreach" => -11,
			"\@{" => -11,
			'SUB' => -11,
			'SELF' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID' => -11,
			'LPAREN' => -11
		},
		GOTOS => {
			'STAR-5' => 57,
			'Critic' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'USE_RPERL_AFTER' => 58,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 59
		}
	},
	{#State 46
		ACTIONS => {
			"{" => 52,
			'USE' => 54
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 47
		DEFAULT => -49
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 61
		}
	},
	{#State 49
		DEFAULT => -47
	},
	{#State 50
		ACTIONS => {
			";" => 62
		}
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 63
		}
	},
	{#State 53
		ACTIONS => {
			"use constant" => 67,
			'SUB' => 66
		},
		GOTOS => {
			'Subroutine' => 65,
			'Constant' => 68,
			'PLUS-15' => 64
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 69
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
			"%{" => -13,
			"undef" => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP01_OPEN' => -13,
			"while" => -13,
			'OP10_NAMED_UNARY' => -13,
			"for" => -13,
			'LBRACE' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'MY' => -13,
			"if" => -13,
			'USE' => 54,
			"use constant" => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_PRINT' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"\@{" => -13,
			"foreach" => -13,
			'SELF' => -13,
			'SUB' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'WORD' => -13,
			'OP01_NAMED_VOID' => -13,
			'LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_NUMBER' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"{" => 52,
			'WORD_UPPERCASE' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'LBRACKET' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13
		},
		GOTOS => {
			'Include' => 72,
			'STAR-6' => 71
		}
	},
	{#State 58
		DEFAULT => -37
	},
	{#State 59
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 60
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 61
		ACTIONS => {
			";" => 75
		}
	},
	{#State 62
		DEFAULT => -43
	},
	{#State 63
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 76
		}
	},
	{#State 64
		ACTIONS => {
			'SUB' => 66,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Subroutine' => 77
		}
	},
	{#State 65
		DEFAULT => -35
	},
	{#State 66
		ACTIONS => {
			'WORD' => 79
		}
	},
	{#State 67
		ACTIONS => {
			'WORD_UPPERCASE' => 80
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			";" => -51,
			'OP01_QW' => 82
		},
		GOTOS => {
			'OPTIONAL-22' => 81
		}
	},
	{#State 70
		DEFAULT => -23
	},
	{#State 71
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -15,
			"%{" => -15,
			"undef" => -15,
			"while" => -15,
			'OP01_OPEN' => -15,
			'LBRACE' => -15,
			"for" => -15,
			'OP10_NAMED_UNARY' => -15,
			"if" => -15,
			'MY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			"use constant" => 67,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'SELF' => -15,
			'SUB' => -15,
			"foreach" => -15,
			"\@{" => -15,
			'WORD' => -15,
			'LPAREN' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_UPPERCASE' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15
		},
		GOTOS => {
			'STAR-7' => 84,
			'Constant' => 83
		}
	},
	{#State 72
		DEFAULT => -10
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		ACTIONS => {
			"## no critic qw(" => 9,
			'USE_EXPORTER' => 31,
			"our hashref \$properties" => -69,
			"{" => -69,
			"use constant" => -69,
			'USE' => -69
		},
		GOTOS => {
			'Critic' => 87,
			'OPTIONAL-29' => 88,
			'Exports' => 86
		}
	},
	{#State 75
		DEFAULT => -46
	},
	{#State 76
		ACTIONS => {
			'OP01_QW' => 89,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 90
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			";" => 91
		}
	},
	{#State 79
		ACTIONS => {
			'LBRACE' => 92
		}
	},
	{#State 80
		ACTIONS => {
			'OP20_HASH_FATARROW' => 93
		}
	},
	{#State 81
		ACTIONS => {
			";" => 94
		}
	},
	{#State 82
		DEFAULT => -50
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 145,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_PRINT' => 137,
			'OP01_NAMED_VOID_SCOLON' => 135,
			'OP05_LOGICAL_NEG' => 133,
			'OP01_NAMED_SCOLON' => 131,
			"%{" => 129,
			"undef" => 130,
			"while" => -171,
			'OP01_OPEN' => 127,
			"for" => -171,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			"if" => 123,
			'MY' => 119,
			'OP19_LOOP_CONTROL' => 121,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 115,
			'OP10_NAMED_UNARY_SCOLON' => 112,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LBRACKET' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'SUB' => 66,
			"foreach" => -171,
			"\@{" => 100,
			'WORD' => 26,
			'LPAREN' => 98,
			'OP01_NAMED_VOID' => 96
		},
		GOTOS => {
			'PLUS-8' => 132,
			'Statement' => 102,
			'Variable' => 101,
			'Literal' => 99,
			'OperatorVoid' => 128,
			'Expression' => 126,
			'WordScoped' => 97,
			'PAREN-45' => 122,
			'Operator' => 95,
			'VariableDeclaration' => 120,
			'HashDereference' => 148,
			'VariableModification' => 147,
			'LoopLabel' => 117,
			'Operation' => 118,
			'OPTIONAL-46' => 144,
			'Subroutine' => 142,
			'SubExpression' => 140,
			'Conditional' => 114,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -68
	},
	{#State 87
		DEFAULT => -66
	},
	{#State 88
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 149
		}
	},
	{#State 89
		DEFAULT => -52
	},
	{#State 90
		ACTIONS => {
			")" => 150
		}
	},
	{#State 91
		DEFAULT => -36
	},
	{#State 92
		ACTIONS => {
			'LBRACE' => 151
		}
	},
	{#State 93
		ACTIONS => {
			'MY' => 152
		},
		GOTOS => {
			'TypeInnerConstant' => 153
		}
	},
	{#State 94
		DEFAULT => -54
	},
	{#State 95
		DEFAULT => -149
	},
	{#State 96
		ACTIONS => {
			'MY' => 154,
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'ARGV' => 164,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'ArrayReference' => 106,
			'ListElements' => 157,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'WordScoped' => 97,
			'SubExpression' => 158,
			'Expression' => 156,
			'ListElement' => 155,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 97
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 165,
			'LPAREN' => 166
		}
	},
	{#State 98
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 168,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_PRINT' => 167,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125
		},
		GOTOS => {
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'SubExpression' => 169,
			'Expression' => 156,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106
		}
	},
	{#State 99
		DEFAULT => -157
	},
	{#State 100
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'SELF' => 103,
			'LBRACKET' => -219,
			'MY' => 154
		},
		GOTOS => {
			'OPTIONAL-56' => 170,
			'Variable' => 172,
			'TypeInner' => 171,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 101
		ACTIONS => {
			'OP07_STRING_REPEAT' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP03_MATH_INC_DEC' => 175,
			'OP04_MATH_POW' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP19_VARIABLE_ASSIGN' => 173,
			'OP02_METHOD_THINARROW' => 176,
			'OP11_COMPARE_LT_GT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP15_LOGICAL_AND' => -158,
			")" => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP18_TERNARY' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 174,
			'OP08_STRING_CAT' => -158
		}
	},
	{#State 102
		DEFAULT => -98
	},
	{#State 103
		DEFAULT => -253
	},
	{#State 104
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 177,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 105
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'SubExpression' => 178,
			'Expression' => 156,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 106
		DEFAULT => -159
	},
	{#State 107
		DEFAULT => -141
	},
	{#State 108
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"]" => -216,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'MY' => 154
		},
		GOTOS => {
			'ArrayReference' => 106,
			'ListElements' => 180,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'WordScoped' => 97,
			'Expression' => 156,
			'SubExpression' => 158,
			'OPTIONAL-55' => 179,
			'ListElement' => 155,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 109
		DEFAULT => -160
	},
	{#State 110
		ACTIONS => {
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 181,
			'Expression' => 156,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109
		}
	},
	{#State 111
		ACTIONS => {
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'ARGV' => 164,
			'OP01_NAMED' => 159,
			'MY' => 154,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			")" => -134,
			"%{" => 129,
			"\@{" => 100
		},
		GOTOS => {
			'ListElement' => 155,
			'OPTIONAL-41' => 182,
			'Literal' => 99,
			'SubExpression' => 158,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'ListElements' => 183,
			'Operator' => 95,
			'WordScoped' => 97,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 112
		DEFAULT => -97
	},
	{#State 113
		ACTIONS => {
			'COLON' => -239,
			'LPAREN' => 184
		}
	},
	{#State 114
		DEFAULT => -172
	},
	{#State 115
		DEFAULT => -254
	},
	{#State 116
		ACTIONS => {
			'FHREF_SYMBOL' => 185
		}
	},
	{#State 117
		ACTIONS => {
			'COLON' => 186
		}
	},
	{#State 118
		DEFAULT => -17
	},
	{#State 119
		ACTIONS => {
			'TYPE_FHREF' => 188,
			'WORD_SCOPED' => 190,
			'TYPE_INTEGER' => 187,
			'WORD' => 191
		},
		GOTOS => {
			'Type' => 189
		}
	},
	{#State 120
		DEFAULT => -175
	},
	{#State 121
		ACTIONS => {
			'WORD_UPPERCASE' => 193
		},
		GOTOS => {
			'LoopLabel' => 192
		}
	},
	{#State 122
		DEFAULT => -170
	},
	{#State 123
		ACTIONS => {
			'LPAREN' => 194
		}
	},
	{#State 124
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 133,
			'OP08_MATH_ADD_SUB' => -117,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			"}" => -117,
			";" => -117,
			'OP11_COMPARE_LT_GT' => -117,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP04_MATH_POW' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'LBRACE' => 125,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP10_NAMED_UNARY' => 124,
			'OP09_BITWISE_SHIFT' => -117,
			'OP01_OPEN' => 127,
			'OP17_LIST_RANGE' => -117,
			'OP23_LOGICAL_AND' => -117,
			"undef" => 130,
			"%{" => 129,
			'LBRACKET' => 108,
			'OP07_STRING_REPEAT' => -117,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 115,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP01_CLOSE' => 116,
			'OP15_LOGICAL_AND' => -117,
			'OP06_REGEX_BIND' => -117,
			'LPAREN' => 98,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP08_STRING_CAT' => -117,
			"]" => -117,
			'OP18_TERNARY' => -117,
			'WORD' => 26,
			'OP16_LOGICAL_OR' => -117,
			'SELF' => 103,
			'OP13_BITWISE_AND' => -117,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			")" => -117
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 195,
			'Expression' => 156,
			'Literal' => 99
		}
	},
	{#State 125
		ACTIONS => {
			'OP07_STRING_REPEAT' => 217,
			'VARIABLE_SYMBOL' => 139,
			'ENV' => 218,
			'OP01_PRINT' => 204,
			'OP08_MATH_ADD_SUB' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP01_NAMED' => 208,
			'OP01_CLOSE' => 220,
			"}" => 209,
			'OP11_COMPARE_LT_GT' => 210,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP01_NAMED_VOID' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP10_NAMED_UNARY' => 197,
			'OP19_LOOP_CONTROL' => 200,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 213,
			'OP23_LOGICAL_AND' => 202,
			"%{" => 129,
			'WORD' => 216,
			'OP01_OPEN' => 203
		},
		GOTOS => {
			'OpStringOrWord' => 199,
			'VarOrLitOrOpStrOrWord' => 205,
			'Literal' => 215,
			'HashEntry' => 201,
			'HashDereference' => 207,
			'Variable' => 214,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 126
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP18_TERNARY' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP08_STRING_CAT' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP04_MATH_POW' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			";" => 221
		}
	},
	{#State 127
		ACTIONS => {
			'MY' => 222
		}
	},
	{#State 128
		DEFAULT => -174
	},
	{#State 129
		ACTIONS => {
			'LBRACE' => -234,
			'VARIABLE_SYMBOL' => 139,
			'SELF' => 103,
			'MY' => 154
		},
		GOTOS => {
			'OPTIONAL-60' => 225,
			'TypeInner' => 223,
			'VariableSymbolOrSelf' => 136,
			'Variable' => 224
		}
	},
	{#State 130
		DEFAULT => -156
	},
	{#State 131
		DEFAULT => -96
	},
	{#State 132
		ACTIONS => {
			"if" => 123,
			'OP19_LOOP_CONTROL' => 121,
			'MY' => 119,
			'LBRACE' => 125,
			"for" => -171,
			'OP10_NAMED_UNARY' => 124,
			"while" => -171,
			'OP01_OPEN' => 127,
			'OP01_NAMED_SCOLON' => 131,
			"%{" => 129,
			"undef" => 130,
			'OP05_LOGICAL_NEG' => 133,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_PRINT' => 137,
			'OP01_NAMED_VOID_SCOLON' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 145,
			'LPAREN' => 98,
			'OP01_NAMED_VOID' => 96,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"\@{" => 100,
			"foreach" => -171,
			'LBRACKET' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'OP10_NAMED_UNARY_SCOLON' => 112,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'' => -18,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116
		},
		GOTOS => {
			'Variable' => 101,
			'Statement' => 102,
			'Literal' => 99,
			'OperatorVoid' => 128,
			'Expression' => 126,
			'WordScoped' => 97,
			'Operator' => 95,
			'PAREN-45' => 122,
			'VariableDeclaration' => 120,
			'HashDereference' => 148,
			'VariableModification' => 147,
			'Operation' => 226,
			'LoopLabel' => 117,
			'OPTIONAL-46' => 144,
			'SubExpression' => 140,
			'Conditional' => 114,
			'VariableSymbolOrSelf' => 136,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106
		}
	},
	{#State 133
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Expression' => 156,
			'SubExpression' => 227,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 134
		DEFAULT => -161
	},
	{#State 135
		DEFAULT => -137
	},
	{#State 136
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 228
		}
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => -132,
			'WORD_UPPERCASE' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'LBRACKET' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP01_CLOSE' => -132,
			'OP01_NAMED' => -132,
			'ARGV' => -132,
			'WORD_SCOPED' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'LITERAL_STRING' => -132,
			'FHREF_SYMBOL_BRACES' => 232,
			'LITERAL_NUMBER' => -132,
			'LBRACE' => -132,
			'LPAREN' => -132,
			'OP10_NAMED_UNARY' => -132,
			'OP01_QW' => -132,
			'MY' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'SELF' => -132,
			"%{" => -132,
			"undef" => -132,
			'STDOUT_STDERR' => 230,
			"\@{" => -132,
			'OP01_OPEN' => -132,
			'WORD' => -132
		},
		GOTOS => {
			'OPTIONAL-40' => 229,
			'PAREN-39' => 231
		}
	},
	{#State 138
		DEFAULT => -151
	},
	{#State 139
		DEFAULT => -252
	},
	{#State 140
		ACTIONS => {
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => 241,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242
		}
	},
	{#State 141
		DEFAULT => -255
	},
	{#State 142
		DEFAULT => -14
	},
	{#State 143
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124
		},
		GOTOS => {
			'ArrayReference' => 106,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Expression' => 156,
			'SubExpression' => 250,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 144
		ACTIONS => {
			"foreach" => 255,
			"for" => 251,
			"while" => 253
		},
		GOTOS => {
			'LoopWhile' => 256,
			'Loop' => 252,
			'LoopFor' => 257,
			'LoopForEach' => 254
		}
	},
	{#State 145
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'MY' => 154
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 258,
			'Literal' => 99,
			'ListElement' => 259,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109
		}
	},
	{#State 146
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'SELF' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'Variable' => 260
		}
	},
	{#State 147
		ACTIONS => {
			";" => 261
		}
	},
	{#State 148
		DEFAULT => -162
	},
	{#State 149
		ACTIONS => {
			"{" => 52,
			"our hashref \$properties" => -73,
			'USE' => 54,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 263,
			'STAR-31' => 262
		}
	},
	{#State 150
		ACTIONS => {
			";" => 264
		}
	},
	{#State 151
		ACTIONS => {
			'MY' => 265
		}
	},
	{#State 152
		ACTIONS => {
			'WORD' => 191,
			'TYPE_INTEGER' => 187,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 266
		}
	},
	{#State 153
		ACTIONS => {
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115
		},
		GOTOS => {
			'Literal' => 267
		}
	},
	{#State 154
		ACTIONS => {
			'TYPE_INTEGER' => 187,
			'WORD' => 191,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 155
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 269
		}
	},
	{#State 156
		DEFAULT => -155
	},
	{#State 157
		ACTIONS => {
			";" => 270
		}
	},
	{#State 158
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP21_LIST_COMMA' => -211,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP18_TERNARY' => 241,
			"]" => -211,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			")" => -211,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			";" => -211,
			'OP11_COMPARE_LT_GT' => 244,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234
		}
	},
	{#State 159
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100
		},
		GOTOS => {
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Expression' => 156,
			'SubExpression' => 271,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 160
		DEFAULT => -213
	},
	{#State 161
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -158,
			'OP08_STRING_CAT' => -158,
			"]" => -158,
			'OP18_TERNARY' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP23_LOGICAL_AND' => -158,
			")" => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP21_LIST_COMMA' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			"}" => -158,
			'OP11_COMPARE_LT_GT' => -158,
			";" => -158,
			'OP02_METHOD_THINARROW' => 176,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP03_MATH_INC_DEC' => 175,
			'OP04_MATH_POW' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP07_STRING_REPEAT' => -158
		}
	},
	{#State 162
		ACTIONS => {
			'LPAREN' => 184
		}
	},
	{#State 163
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138
		},
		GOTOS => {
			'SubExpression' => 272,
			'Expression' => 156,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 164
		DEFAULT => -214
	},
	{#State 165
		ACTIONS => {
			")" => -148,
			'LBRACE' => 125
		},
		GOTOS => {
			'OPTIONAL-44' => 274,
			'HashReference' => 273
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'ARGV' => 164,
			'OP01_NAMED' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			"undef" => 130,
			")" => -144,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'MY' => 154
		},
		GOTOS => {
			'SubExpression' => 158,
			'Expression' => 156,
			'Literal' => 99,
			'ListElement' => 155,
			'Variable' => 161,
			'HashDereference' => 148,
			'OPTIONAL-42' => 276,
			'Operator' => 95,
			'ListElements' => 275,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 167
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 277
		}
	},
	{#State 168
		ACTIONS => {
			'MY' => 154,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'ARGV' => 164,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 258,
			'Literal' => 99,
			'ListElement' => 278
		}
	},
	{#State 169
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			")" => 279,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP18_TERNARY' => 241,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACKET' => 108
		},
		GOTOS => {
			'ArrayReference' => 280
		}
	},
	{#State 171
		DEFAULT => -218
	},
	{#State 172
		ACTIONS => {
			"}" => 281
		}
	},
	{#State 173
		ACTIONS => {
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'STDIN' => 284,
			'FHREF_SYMBOL_IN' => 282,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 283,
			'Expression' => 156,
			'SubExpressionOrInput' => 285,
			'Literal' => 99
		}
	},
	{#State 174
		ACTIONS => {
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'SubExpression' => 286,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 175
		DEFAULT => -105
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 287
		}
	},
	{#State 177
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -127,
			"}" => -127,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => -127,
			")" => -127,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			"]" => -127,
			'OP18_TERNARY' => 241
		}
	},
	{#State 178
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => 241,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			")" => 288,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 179
		ACTIONS => {
			"]" => 289
		}
	},
	{#State 180
		DEFAULT => -215
	},
	{#State 181
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			")" => 290,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234
		}
	},
	{#State 182
		ACTIONS => {
			")" => 291
		}
	},
	{#State 183
		DEFAULT => -133
	},
	{#State 184
		ACTIONS => {
			")" => 292
		}
	},
	{#State 185
		DEFAULT => -103
	},
	{#State 186
		DEFAULT => -169
	},
	{#State 187
		DEFAULT => -242
	},
	{#State 188
		ACTIONS => {
			'FHREF_SYMBOL' => 293
		}
	},
	{#State 189
		ACTIONS => {
			'VARIABLE_SYMBOL' => 294
		}
	},
	{#State 190
		DEFAULT => -241
	},
	{#State 191
		DEFAULT => -240
	},
	{#State 192
		ACTIONS => {
			";" => 295
		}
	},
	{#State 193
		DEFAULT => -239
	},
	{#State 194
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 296,
			'Expression' => 156,
			'Literal' => 99
		}
	},
	{#State 195
		ACTIONS => {
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			";" => -116,
			"}" => -116,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			")" => -116,
			'OP17_LIST_RANGE' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP18_TERNARY' => -116,
			"]" => -116,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP06_REGEX_BIND' => 235,
			'OP15_LOGICAL_AND' => -116
		}
	},
	{#State 196
		DEFAULT => -262
	},
	{#State 197
		DEFAULT => -269
	},
	{#State 198
		DEFAULT => -271
	},
	{#State 199
		DEFAULT => -251
	},
	{#State 200
		DEFAULT => -266
	},
	{#State 201
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 297
		}
	},
	{#State 202
		DEFAULT => -263
	},
	{#State 203
		DEFAULT => -275
	},
	{#State 204
		DEFAULT => -277
	},
	{#State 205
		ACTIONS => {
			'OP20_HASH_FATARROW' => 298
		}
	},
	{#State 206
		DEFAULT => -270
	},
	{#State 207
		DEFAULT => -225
	},
	{#State 208
		DEFAULT => -273
	},
	{#State 209
		DEFAULT => -232
	},
	{#State 210
		DEFAULT => -268
	},
	{#State 211
		DEFAULT => -267
	},
	{#State 212
		DEFAULT => -276
	},
	{#State 213
		DEFAULT => -264
	},
	{#State 214
		DEFAULT => -249
	},
	{#State 215
		DEFAULT => -250
	},
	{#State 216
		DEFAULT => -278
	},
	{#State 217
		DEFAULT => -272
	},
	{#State 218
		DEFAULT => -226
	},
	{#State 219
		DEFAULT => -265
	},
	{#State 220
		DEFAULT => -274
	},
	{#State 221
		DEFAULT => -95
	},
	{#State 222
		ACTIONS => {
			'TYPE_FHREF' => 299
		}
	},
	{#State 223
		DEFAULT => -233
	},
	{#State 224
		ACTIONS => {
			"}" => 300
		}
	},
	{#State 225
		ACTIONS => {
			'LBRACE' => 125
		},
		GOTOS => {
			'HashReference' => 301
		}
	},
	{#State 226
		DEFAULT => -16
	},
	{#State 227
		ACTIONS => {
			"}" => -108,
			'OP11_COMPARE_LT_GT' => -108,
			";" => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP18_TERNARY' => -108,
			"]" => -108,
			'OP08_STRING_CAT' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP16_LOGICAL_OR' => -108,
			")" => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP21_LIST_COMMA' => -108
		}
	},
	{#State 228
		ACTIONS => {
			"]" => -197,
			'OP18_TERNARY' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP08_STRING_CAT' => -197,
			'OP16_LOGICAL_OR' => -197,
			'OP13_BITWISE_AND' => -197,
			")" => -197,
			'OP17_LIST_RANGE' => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP02_ARRAY_THINARROW' => 303,
			'OP15_LOGICAL_AND' => -197,
			'COLON' => -197,
			'OP12_COMPARE_EQ_NE' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP21_LIST_COMMA' => -197,
			'OP07_MATH_MULT_DIV_MOD' => -197,
			"}" => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP02_METHOD_THINARROW' => -197,
			'OP11_COMPARE_LT_GT' => -197,
			";" => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			'OP04_MATH_POW' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP08_MATH_ADD_SUB' => -197,
			'OP07_STRING_REPEAT' => -197,
			'OP02_HASH_THINARROW' => 304
		},
		GOTOS => {
			'VariableRetrieval' => 302
		}
	},
	{#State 229
		ACTIONS => {
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'MY' => 154,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'ARGV' => 164,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'WordScoped' => 97,
			'ArrayReference' => 106,
			'ListElements' => 305,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 158,
			'Expression' => 156,
			'ListElement' => 155,
			'Literal' => 99
		}
	},
	{#State 230
		DEFAULT => -130
	},
	{#State 231
		DEFAULT => -131
	},
	{#State 232
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'ARGV' => 164,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'MY' => 154,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'WORD' => 26,
			'OP01_OPEN' => 127
		},
		GOTOS => {
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'ListElement' => 155,
			'Expression' => 156,
			'SubExpression' => 158,
			'WordScoped' => 97,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ListElements' => 306
		}
	},
	{#State 233
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 307,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 234
		ACTIONS => {
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 308
		}
	},
	{#State 235
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 309
		}
	},
	{#State 236
		ACTIONS => {
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124
		},
		GOTOS => {
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'SubExpression' => 310,
			'Expression' => 156,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 237
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'SubExpression' => 311,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 238
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 312,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 239
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 313,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 240
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 314,
			'Literal' => 99
		}
	},
	{#State 241
		ACTIONS => {
			'SELF' => 103,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'Variable' => 317,
			'Literal' => 316,
			'VariableOrLiteral' => 315
		}
	},
	{#State 242
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 318,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 243
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'ArrayReference' => 106,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 319,
			'Literal' => 99
		}
	},
	{#State 244
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 320,
			'Expression' => 156,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109
		}
	},
	{#State 245
		ACTIONS => {
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'SubExpression' => 321,
			'Expression' => 156,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'ArrayReference' => 106,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 246
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 127,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162
		},
		GOTOS => {
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'SubExpression' => 322,
			'Expression' => 156,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106
		}
	},
	{#State 247
		ACTIONS => {
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'SubExpression' => 323,
			'Expression' => 156
		}
	},
	{#State 248
		ACTIONS => {
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98
		},
		GOTOS => {
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 324
		}
	},
	{#State 249
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125
		},
		GOTOS => {
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 325,
			'HashDereference' => 148,
			'Variable' => 161,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 250
		ACTIONS => {
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			")" => 326,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242
		}
	},
	{#State 251
		ACTIONS => {
			'MY' => 328,
			'LPAREN_MY' => 327
		}
	},
	{#State 252
		DEFAULT => -173
	},
	{#State 253
		ACTIONS => {
			'LPAREN_MY' => 330,
			'LPAREN' => 329
		}
	},
	{#State 254
		DEFAULT => -185
	},
	{#State 255
		ACTIONS => {
			'MY' => 331
		}
	},
	{#State 256
		DEFAULT => -186
	},
	{#State 257
		DEFAULT => -184
	},
	{#State 258
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP08_STRING_CAT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP18_TERNARY' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => -211,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			";" => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP08_MATH_ADD_SUB' => -100
		}
	},
	{#State 259
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 260
		DEFAULT => -104
	},
	{#State 261
		DEFAULT => -176
	},
	{#State 262
		ACTIONS => {
			"our hashref \$properties" => 334,
			"use constant" => 67
		},
		GOTOS => {
			'Constant' => 335,
			'Properties' => 333
		}
	},
	{#State 263
		DEFAULT => -70
	},
	{#State 264
		ACTIONS => {
			"}" => 336
		}
	},
	{#State 265
		ACTIONS => {
			'WORD' => 191,
			'TYPE_INTEGER' => 187,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 337
		}
	},
	{#State 266
		ACTIONS => {
			"\$TYPED_" => 338
		}
	},
	{#State 267
		ACTIONS => {
			";" => 339
		}
	},
	{#State 268
		ACTIONS => {
			"\$TYPED_" => 340
		}
	},
	{#State 269
		ACTIONS => {
			";" => -210,
			"]" => -210,
			'OP21_LIST_COMMA' => 342,
			")" => -210
		},
		GOTOS => {
			'PAREN-53' => 341
		}
	},
	{#State 270
		DEFAULT => -139
	},
	{#State 271
		ACTIONS => {
			'OP13_BITWISE_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			"]" => -100,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP08_STRING_CAT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			"}" => -100,
			";" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP08_MATH_ADD_SUB' => -100
		}
	},
	{#State 272
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -212,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP15_LOGICAL_AND' => 237,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -212,
			'OP18_TERNARY' => 241,
			"]" => -212,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			")" => -212,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248
		}
	},
	{#State 273
		DEFAULT => -147
	},
	{#State 274
		ACTIONS => {
			")" => 343
		}
	},
	{#State 275
		DEFAULT => -143
	},
	{#State 276
		ACTIONS => {
			")" => 344
		}
	},
	{#State 277
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'MY' => 154,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'ListElements' => 345,
			'Operator' => 95,
			'HashDereference' => 148,
			'Variable' => 161,
			'ListElement' => 155,
			'Literal' => 99,
			'SubExpression' => 158,
			'Expression' => 156
		}
	},
	{#State 278
		ACTIONS => {
			'OP21_LIST_COMMA' => 346
		}
	},
	{#State 279
		DEFAULT => -163
	},
	{#State 280
		ACTIONS => {
			"}" => 347
		}
	},
	{#State 281
		DEFAULT => -220
	},
	{#State 282
		DEFAULT => -165
	},
	{#State 283
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			";" => -164,
			'OP11_COMPARE_LT_GT' => 244,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			")" => -164,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP18_TERNARY' => 241,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249
		}
	},
	{#State 284
		DEFAULT => -166
	},
	{#State 285
		DEFAULT => -205
	},
	{#State 286
		ACTIONS => {
			";" => -206,
			'OP11_COMPARE_LT_GT' => 244,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			")" => -206,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP12_COMPARE_EQ_NE' => 236
		}
	},
	{#State 287
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'ARGV' => 164,
			'OP01_NAMED' => 159,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			")" => -146,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'MY' => 154
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Operator' => 95,
			'ListElements' => 349,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'ListElement' => 155,
			'Expression' => 156,
			'SubExpression' => 158,
			'HashDereference' => 148,
			'OPTIONAL-43' => 348,
			'Variable' => 161
		}
	},
	{#State 288
		DEFAULT => -109
	},
	{#State 289
		DEFAULT => -217
	},
	{#State 290
		DEFAULT => -126
	},
	{#State 291
		ACTIONS => {
			";" => 350
		}
	},
	{#State 292
		DEFAULT => -150
	},
	{#State 293
		ACTIONS => {
			";" => 351
		}
	},
	{#State 294
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 352,
			";" => 354,
			'OP02_ARRAY_THINARROW' => 353
		}
	},
	{#State 295
		DEFAULT => -142
	},
	{#State 296
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			")" => 355,
			'OP15_LOGICAL_AND' => 237,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP11_COMPARE_LT_GT' => 244,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233
		}
	},
	{#State 297
		ACTIONS => {
			'OP21_LIST_COMMA' => 357,
			"}" => 358
		},
		GOTOS => {
			'PAREN-58' => 356
		}
	},
	{#State 298
		ACTIONS => {
			'LBRACKET' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'WORD_UPPERCASE' => -223,
			'VARIABLE_SYMBOL' => -223,
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			'CONSTANT_CALL_SCOPED' => -223,
			'LITERAL_NUMBER' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			'LITERAL_STRING' => -223,
			'WORD_SCOPED' => -223,
			'OP01_NAMED' => -223,
			'OP01_CLOSE' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'MY' => 154,
			'LPAREN' => -223,
			'LBRACE' => -223,
			'OP10_NAMED_UNARY' => -223,
			'WORD' => -223,
			'OP01_OPEN' => -223,
			'SELF' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'OP22_LOGICAL_NEG' => -223,
			"\@{" => -223,
			"undef" => -223,
			"%{" => -223
		},
		GOTOS => {
			'TypeInner' => 359,
			'OPTIONAL-57' => 360
		}
	},
	{#State 299
		ACTIONS => {
			'FHREF_SYMBOL' => 361
		}
	},
	{#State 300
		DEFAULT => -235
	},
	{#State 301
		ACTIONS => {
			"}" => 362
		}
	},
	{#State 302
		DEFAULT => -195
	},
	{#State 303
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 363,
			'Expression' => 156,
			'Literal' => 99
		}
	},
	{#State 304
		ACTIONS => {
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 364,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'Literal' => 99,
			'SubExpression' => 365,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 305
		ACTIONS => {
			";" => 366
		}
	},
	{#State 306
		ACTIONS => {
			";" => 367
		}
	},
	{#State 307
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -111,
			'OP08_STRING_CAT' => -111,
			'OP18_TERNARY' => -111,
			"]" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP23_LOGICAL_AND' => -111,
			")" => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP21_LIST_COMMA' => -111,
			"}" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => -111,
			'OP07_STRING_REPEAT' => -111
		}
	},
	{#State 308
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP06_REGEX_BIND' => 235,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => -121,
			")" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP17_LIST_RANGE' => -121,
			'OP18_TERNARY' => -121,
			"]" => -121,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP04_MATH_POW' => 243,
			"}" => -121,
			";" => -121,
			'OP11_COMPARE_LT_GT' => 244
		}
	},
	{#State 309
		DEFAULT => -110
	},
	{#State 310
		ACTIONS => {
			";" => -119,
			'OP11_COMPARE_LT_GT' => 244,
			"}" => -119,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP17_LIST_RANGE' => -119,
			'OP23_LOGICAL_AND' => -119,
			")" => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP13_BITWISE_AND' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 311
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			"}" => -122,
			";" => -122,
			'OP11_COMPARE_LT_GT' => 244,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP21_LIST_COMMA' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => -122,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => -122,
			'OP17_LIST_RANGE' => -122,
			'OP23_LOGICAL_AND' => -122,
			")" => -122,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => -122,
			"]" => -122
		}
	},
	{#State 312
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			"]" => -120,
			'OP18_TERNARY' => -120,
			'OP13_BITWISE_AND' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP17_LIST_RANGE' => -120,
			'OP23_LOGICAL_AND' => -120,
			")" => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -120,
			"}" => -120,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233
		}
	},
	{#State 313
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			"}" => -123,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -123,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP15_LOGICAL_AND' => 237,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -123,
			"]" => -123,
			'OP18_TERNARY' => -123,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP16_LOGICAL_OR' => -123,
			'OP13_BITWISE_AND' => 238,
			")" => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP17_LIST_RANGE' => -123
		}
	},
	{#State 314
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP04_MATH_POW' => 243,
			"}" => -114,
			";" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP16_LOGICAL_OR' => -114,
			")" => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP18_TERNARY' => -114,
			"]" => -114,
			'OP08_STRING_CAT' => -114,
			'OP09_BITWISE_SHIFT' => -114
		}
	},
	{#State 315
		ACTIONS => {
			'COLON' => 368
		}
	},
	{#State 316
		DEFAULT => -248
	},
	{#State 317
		DEFAULT => -247
	},
	{#State 318
		ACTIONS => {
			'OP18_TERNARY' => -113,
			"]" => -113,
			'OP08_STRING_CAT' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			")" => -113,
			'OP17_LIST_RANGE' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP06_REGEX_BIND' => 235,
			";" => -113,
			'OP11_COMPARE_LT_GT' => -113,
			"}" => -113,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP07_STRING_REPEAT' => 233
		}
	},
	{#State 319
		ACTIONS => {
			"}" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP08_STRING_CAT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP13_BITWISE_AND' => -106,
			")" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 320
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -118,
			'OP04_MATH_POW' => 243,
			"}" => -118,
			";" => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP13_BITWISE_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			")" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP17_LIST_RANGE' => -118,
			"]" => -118,
			'OP18_TERNARY' => -118,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP06_REGEX_BIND' => 235,
			'OP21_LIST_COMMA' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => -118
		}
	},
	{#State 321
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -112,
			'OP04_MATH_POW' => 243,
			"}" => -112,
			";" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP17_LIST_RANGE' => -112,
			")" => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP08_STRING_CAT' => -112,
			"]" => -112,
			'OP18_TERNARY' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112
		}
	},
	{#State 322
		ACTIONS => {
			'OP21_LIST_COMMA' => -129,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			")" => -129,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			"]" => -129,
			'OP18_TERNARY' => 241,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -129,
			"}" => -129
		}
	},
	{#State 323
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			"}" => -124,
			";" => -124,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP23_LOGICAL_AND' => -124,
			'OP17_LIST_RANGE' => undef,
			")" => -124,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => -124,
			"]" => -124,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP21_LIST_COMMA' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237
		}
	},
	{#State 324
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -128,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			"]" => -128,
			'OP18_TERNARY' => 241,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => -128,
			")" => -128,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			"}" => -128,
			'OP11_COMPARE_LT_GT' => 244,
			";" => -128,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 325
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			";" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			"}" => -115,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => -115,
			"]" => -115,
			'OP18_TERNARY' => -115,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => -115,
			")" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP16_LOGICAL_OR' => -115
		}
	},
	{#State 326
		DEFAULT => -107
	},
	{#State 327
		ACTIONS => {
			'TYPE_INTEGER' => 369
		}
	},
	{#State 328
		ACTIONS => {
			'TYPE_INTEGER' => 370
		}
	},
	{#State 329
		ACTIONS => {
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'SubExpression' => 371,
			'Expression' => 156
		}
	},
	{#State 330
		ACTIONS => {
			'WORD_SCOPED' => 190,
			'TYPE_INTEGER' => 187,
			'WORD' => 191
		},
		GOTOS => {
			'Type' => 372
		}
	},
	{#State 331
		ACTIONS => {
			'WORD_SCOPED' => 190,
			'TYPE_INTEGER' => 187,
			'WORD' => 191
		},
		GOTOS => {
			'Type' => 373
		}
	},
	{#State 332
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'MY' => 154,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115
		},
		GOTOS => {
			'Literal' => 99,
			'ListElement' => 155,
			'SubExpression' => 158,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Operator' => 95,
			'ListElements' => 374,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 333
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 375
		}
	},
	{#State 334
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 376
		}
	},
	{#State 335
		DEFAULT => -72
	},
	{#State 336
		DEFAULT => -55
	},
	{#State 337
		ACTIONS => {
			"\$RETURN_TYPE" => 377
		}
	},
	{#State 338
		ACTIONS => {
			'WORD_UPPERCASE' => 378
		}
	},
	{#State 339
		DEFAULT => -56
	},
	{#State 340
		ACTIONS => {
			'OP01_NAMED' => 208,
			'OP01_CLOSE' => 220,
			'OP11_COMPARE_LT_GT' => 210,
			'OP01_PRINT' => 204,
			'OP07_STRING_REPEAT' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP08_MATH_ADD_SUB' => 206,
			'OP23_LOGICAL_AND' => 202,
			'OP22_LOGICAL_NEG' => 213,
			'WORD' => 216,
			'OP01_OPEN' => 203,
			'OP10_NAMED_UNARY' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP01_NAMED_VOID' => 212,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP19_LOOP_CONTROL' => 200
		},
		GOTOS => {
			'OpStringOrWord' => 379
		}
	},
	{#State 341
		DEFAULT => -208
	},
	{#State 342
		ACTIONS => {
			'MY' => 154,
			'OP10_NAMED_UNARY' => 124,
			'OP01_QW' => 160,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ListElement' => 380,
			'Literal' => 99,
			'SubExpression' => 158,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163
		}
	},
	{#State 343
		DEFAULT => -154
	},
	{#State 344
		DEFAULT => -152
	},
	{#State 345
		ACTIONS => {
			")" => 381
		}
	},
	{#State 346
		ACTIONS => {
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'MY' => 154,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'ARGV' => 164,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143
		},
		GOTOS => {
			'WordScoped' => 97,
			'TypeInner' => 163,
			'VariableSymbolOrSelf' => 136,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'ListElements' => 382,
			'Operator' => 95,
			'HashDereference' => 148,
			'Variable' => 161,
			'ListElement' => 155,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 158
		}
	},
	{#State 347
		DEFAULT => -221
	},
	{#State 348
		ACTIONS => {
			")" => 383
		}
	},
	{#State 349
		DEFAULT => -145
	},
	{#State 350
		DEFAULT => -138
	},
	{#State 351
		DEFAULT => -204
	},
	{#State 352
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'STDIN' => 284,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'FHREF_SYMBOL_IN' => 282,
			'OP01_NAMED_SCOLON' => 386,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'OP10_NAMED_UNARY_SCOLON' => 384,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'Operator' => 95,
			'OpNamedScolonOrSubExpIn' => 387,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'SubExpressionOrInput' => 385,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 283,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 353
		ACTIONS => {
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 388,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 354
		DEFAULT => -201
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 356
		DEFAULT => -229
	},
	{#State 357
		ACTIONS => {
			'OP01_CLOSE' => 220,
			'OP01_NAMED' => 208,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP11_COMPARE_LT_GT' => 210,
			'ENV' => 218,
			'OP01_PRINT' => 204,
			'VARIABLE_SYMBOL' => 139,
			'OP07_STRING_REPEAT' => 217,
			'OP08_MATH_ADD_SUB' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			"%{" => 129,
			'OP23_LOGICAL_AND' => 202,
			'OP22_LOGICAL_NEG' => 213,
			'SELF' => 103,
			'OP01_OPEN' => 203,
			'WORD' => 216,
			'OP01_NAMED_VOID' => 212,
			'OP10_NAMED_UNARY' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP19_LOOP_CONTROL' => 200
		},
		GOTOS => {
			'Literal' => 215,
			'VarOrLitOrOpStrOrWord' => 205,
			'OpStringOrWord' => 199,
			'Variable' => 214,
			'VariableSymbolOrSelf' => 136,
			'HashDereference' => 207,
			'HashEntry' => 391
		}
	},
	{#State 358
		DEFAULT => -231
	},
	{#State 359
		DEFAULT => -222
	},
	{#State 360
		ACTIONS => {
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 392,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'ArrayReference' => 106,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134
		}
	},
	{#State 361
		ACTIONS => {
			'OP21_LIST_COMMA' => 393
		}
	},
	{#State 362
		DEFAULT => -236
	},
	{#State 363
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP15_LOGICAL_AND' => 237,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP18_TERNARY' => 241,
			"]" => 394,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244
		}
	},
	{#State 364
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -237,
			'LPAREN' => -237,
			"}" => 395
		}
	},
	{#State 365
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			"}" => 396,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP18_TERNARY' => 241,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238
		}
	},
	{#State 366
		DEFAULT => -135
	},
	{#State 367
		DEFAULT => -136
	},
	{#State 368
		ACTIONS => {
			'SELF' => 103,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141
		},
		GOTOS => {
			'Literal' => 316,
			'VariableOrLiteral' => 397,
			'VariableSymbolOrSelf' => 136,
			'Variable' => 317
		}
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 398
		}
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 399
		}
	},
	{#State 371
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			")" => 400,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => 241
		}
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 373
		ACTIONS => {
			'VARIABLE_SYMBOL' => 402
		}
	},
	{#State 374
		ACTIONS => {
			";" => 403
		}
	},
	{#State 375
		ACTIONS => {
			'LITERAL_NUMBER' => 407,
			'SUB' => 406
		},
		GOTOS => {
			'Method' => 404,
			'SubroutineOrMethod' => 408,
			'Subroutine' => 405
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 409
		}
	},
	{#State 377
		ACTIONS => {
			"}" => 410
		}
	},
	{#State 378
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 380
		DEFAULT => -207
	},
	{#State 381
		DEFAULT => -99
	},
	{#State 382
		ACTIONS => {
			")" => 413
		}
	},
	{#State 383
		DEFAULT => -153
	},
	{#State 384
		DEFAULT => -260
	},
	{#State 385
		ACTIONS => {
			";" => 414
		}
	},
	{#State 386
		DEFAULT => -259
	},
	{#State 387
		DEFAULT => -202
	},
	{#State 388
		ACTIONS => {
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP11_COMPARE_LT_GT' => 244,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP15_LOGICAL_AND' => 237,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			"]" => 415,
			'OP18_TERNARY' => 241
		}
	},
	{#State 389
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 416
		}
	},
	{#State 390
		ACTIONS => {
			'OP01_OPEN' => 127,
			"while" => -171,
			"%{" => 129,
			"undef" => 130,
			'OP01_NAMED_SCOLON' => 131,
			'MY' => 119,
			'OP19_LOOP_CONTROL' => 121,
			"if" => 123,
			'OP10_NAMED_UNARY' => 124,
			"for" => -171,
			'LBRACE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP01_NAMED' => 145,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP05_LOGICAL_NEG' => 133,
			'OP01_NAMED_VOID_SCOLON' => 135,
			'OP01_PRINT' => 137,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD' => 26,
			"\@{" => 100,
			"foreach" => -171,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 98,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LBRACKET' => 108,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'WORD_UPPERCASE' => 113,
			'OP10_NAMED_UNARY_SCOLON' => 112
		},
		GOTOS => {
			'PLUS-51' => 417,
			'WordScoped' => 97,
			'VariableDeclaration' => 120,
			'Operator' => 95,
			'PAREN-45' => 122,
			'Variable' => 101,
			'Statement' => 102,
			'Literal' => 99,
			'OperatorVoid' => 128,
			'Expression' => 126,
			'VariableSymbolOrSelf' => 136,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'VariableModification' => 147,
			'HashDereference' => 148,
			'Operation' => 418,
			'LoopLabel' => 117,
			'OPTIONAL-46' => 144,
			'SubExpression' => 140,
			'Conditional' => 114
		}
	},
	{#State 391
		DEFAULT => -228
	},
	{#State 392
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -224,
			'OP18_TERNARY' => 241,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			"}" => -224,
			'OP11_COMPARE_LT_GT' => 244,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 393
		ACTIONS => {
			'LITERAL_STRING' => 419
		}
	},
	{#State 394
		DEFAULT => -198
	},
	{#State 395
		DEFAULT => -200
	},
	{#State 396
		DEFAULT => -199
	},
	{#State 397
		DEFAULT => -125
	},
	{#State 398
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 399
		ACTIONS => {
			'LPAREN' => 421
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 422
		}
	},
	{#State 401
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 402
		ACTIONS => {
			'LPAREN' => 424
		}
	},
	{#State 403
		DEFAULT => -140
	},
	{#State 404
		DEFAULT => -94
	},
	{#State 405
		DEFAULT => -93
	},
	{#State 406
		ACTIONS => {
			'WORD' => 425
		}
	},
	{#State 407
		ACTIONS => {
			";" => 426
		}
	},
	{#State 408
		DEFAULT => -74
	},
	{#State 409
		ACTIONS => {
			"}" => 429,
			'OP11_COMPARE_LT_GT' => 210,
			'OP01_NAMED' => 208,
			'OP01_CLOSE' => 220,
			'OP08_MATH_ADD_SUB' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP07_STRING_REPEAT' => 217,
			'OP01_PRINT' => 204,
			'WORD' => 216,
			'OP01_OPEN' => 203,
			'OP22_LOGICAL_NEG' => 213,
			'OP23_LOGICAL_AND' => 202,
			'OP19_LOOP_CONTROL' => 200,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP10_NAMED_UNARY' => 197,
			'OP01_NAMED_VOID' => 212
		},
		GOTOS => {
			'OpStringOrWord' => 428,
			'HashEntryProperties' => 427
		}
	},
	{#State 410
		ACTIONS => {
			";" => 430
		}
	},
	{#State 411
		DEFAULT => -246
	},
	{#State 412
		DEFAULT => -243
	},
	{#State 413
		DEFAULT => -101
	},
	{#State 414
		DEFAULT => -261
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 431
		}
	},
	{#State 416
		ACTIONS => {
			'WORD' => -182,
			"foreach" => -182,
			"\@{" => -182,
			'SELF' => -182,
			'OP22_LOGICAL_NEG' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			'OP01_NAMED_VOID' => -182,
			'LPAREN' => -182,
			'LITERAL_NUMBER' => -182,
			'OP01_CLOSE' => -182,
			'LBRACKET' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			'' => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			'WORD_UPPERCASE' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			'OP01_OPEN' => -182,
			"while" => -182,
			"undef" => -182,
			"%{" => -182,
			'OP01_NAMED_SCOLON' => -182,
			"else" => 434,
			'MY' => -182,
			'OP19_LOOP_CONTROL' => -182,
			"if" => -182,
			'OP10_NAMED_UNARY' => -182,
			"elsif" => 435,
			'LBRACE' => -182,
			"for" => -182,
			'LITERAL_STRING' => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			"}" => -182,
			'OP01_NAMED' => -182,
			'WORD_SCOPED' => -182,
			'OP03_MATH_INC_DEC' => -182,
			'OP05_LOGICAL_NEG' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'OP01_PRINT' => -182,
			'CONSTANT_CALL_SCOPED' => -182,
			'VARIABLE_SYMBOL' => -182
		},
		GOTOS => {
			'PAREN-47' => 433,
			'OPTIONAL-50' => 436,
			'PAREN-49' => 432
		}
	},
	{#State 417
		ACTIONS => {
			"if" => 123,
			'OP19_LOOP_CONTROL' => 121,
			'MY' => 119,
			'LBRACE' => 125,
			"for" => -171,
			'OP10_NAMED_UNARY' => 124,
			"while" => -171,
			'OP01_OPEN' => 127,
			'OP01_NAMED_SCOLON' => 131,
			"undef" => 130,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 133,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_PRINT' => 137,
			'OP01_NAMED_VOID_SCOLON' => 135,
			"}" => 438,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 145,
			'LPAREN' => 98,
			'OP01_NAMED_VOID' => 96,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"\@{" => 100,
			"foreach" => -171,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY_SCOLON' => 112,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116
		},
		GOTOS => {
			'Expression' => 126,
			'OperatorVoid' => 128,
			'Literal' => 99,
			'Statement' => 102,
			'Variable' => 101,
			'Operator' => 95,
			'PAREN-45' => 122,
			'VariableDeclaration' => 120,
			'WordScoped' => 97,
			'Conditional' => 114,
			'SubExpression' => 140,
			'OPTIONAL-46' => 144,
			'Operation' => 437,
			'LoopLabel' => 117,
			'HashDereference' => 148,
			'VariableModification' => 147,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 418
		DEFAULT => -193
	},
	{#State 419
		ACTIONS => {
			'OP21_LIST_COMMA' => 439
		}
	},
	{#State 420
		ACTIONS => {
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP10_NAMED_UNARY_SCOLON' => 440,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_NAMED_SCOLON' => 443,
			'OP22_LOGICAL_NEG' => 104,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129
		},
		GOTOS => {
			'HashDereference' => 148,
			'Variable' => 161,
			'Literal' => 99,
			'OpNamedScolonOrSubExp' => 441,
			'SubExpression' => 442,
			'Expression' => 156,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'Operator' => 95
		}
	},
	{#State 421
		ACTIONS => {
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 444,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148,
			'ArrayReference' => 106,
			'Operator' => 95,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97
		}
	},
	{#State 422
		DEFAULT => -190
	},
	{#State 423
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'STDIN' => 284,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'FHREF_SYMBOL_IN' => 282,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127
		},
		GOTOS => {
			'SubExpressionOrInput' => 445,
			'Literal' => 99,
			'Expression' => 156,
			'SubExpression' => 283,
			'HashDereference' => 148,
			'Variable' => 161,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'Operator' => 95,
			'ArrayReference' => 106,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 424
		ACTIONS => {
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'ARGV' => 164,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'MY' => 154,
			'OP01_QW' => 160,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'ListElements' => 446,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'TypeInner' => 163,
			'ListElement' => 155,
			'Literal' => 99,
			'SubExpression' => 158,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161
		}
	},
	{#State 425
		ACTIONS => {
			'LBRACE' => 447
		}
	},
	{#State 426
		DEFAULT => -76
	},
	{#State 427
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 448
		}
	},
	{#State 428
		ACTIONS => {
			'OP20_HASH_FATARROW' => 449
		}
	},
	{#State 429
		ACTIONS => {
			";" => 450
		}
	},
	{#State 430
		ACTIONS => {
			'VARIABLE_SYMBOL' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP01_PRINT' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'WORD_SCOPED' => -58,
			'OP01_NAMED' => -58,
			'OP03_MATH_INC_DEC' => -58,
			"}" => -58,
			'LITERAL_STRING' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'LBRACE' => -58,
			"for" => -58,
			'OP10_NAMED_UNARY' => -58,
			"if" => -58,
			'OP19_LOOP_CONTROL' => -58,
			'MY' => -58,
			'OP01_NAMED_SCOLON' => -58,
			"%{" => -58,
			"undef" => -58,
			"while" => -58,
			'LPAREN_MY' => 451,
			'OP01_OPEN' => -58,
			'WORD_UPPERCASE' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'LBRACKET' => -58,
			'OP01_CLOSE' => -58,
			'LITERAL_NUMBER' => -58,
			'LPAREN' => -58,
			'OP01_NAMED_VOID' => -58,
			'SELF' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP22_LOGICAL_NEG' => -58,
			"\@{" => -58,
			"foreach" => -58,
			'WORD' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 452,
			'OPTIONAL-24' => 453
		}
	},
	{#State 431
		ACTIONS => {
			"undef" => 454
		}
	},
	{#State 432
		DEFAULT => -181
	},
	{#State 433
		DEFAULT => -178
	},
	{#State 434
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 435
		ACTIONS => {
			'LPAREN' => 456
		}
	},
	{#State 436
		DEFAULT => -183
	},
	{#State 437
		DEFAULT => -192
	},
	{#State 438
		DEFAULT => -194
	},
	{#State 439
		ACTIONS => {
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 457,
			'Expression' => 156,
			'Literal' => 99
		}
	},
	{#State 440
		DEFAULT => -257
	},
	{#State 441
		ACTIONS => {
			'VARIABLE_SYMBOL' => 458
		}
	},
	{#State 442
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			";" => 459,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 443
		DEFAULT => -256
	},
	{#State 444
		ACTIONS => {
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP17_LIST_RANGE' => 460,
			'OP23_LOGICAL_AND' => 248,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP18_TERNARY' => 241,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237
		}
	},
	{#State 445
		ACTIONS => {
			")" => 461
		}
	},
	{#State 446
		ACTIONS => {
			")" => 462
		}
	},
	{#State 447
		ACTIONS => {
			'LBRACE' => 463
		}
	},
	{#State 448
		ACTIONS => {
			'OP21_LIST_COMMA' => 464,
			"}" => 465
		},
		GOTOS => {
			'PAREN-33' => 466
		}
	},
	{#State 449
		ACTIONS => {
			'MY' => 467
		},
		GOTOS => {
			'TypeInnerProperties' => 468
		}
	},
	{#State 450
		DEFAULT => -83
	},
	{#State 451
		ACTIONS => {
			'TYPE_INTEGER' => 187,
			'WORD' => 191,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 469
		}
	},
	{#State 452
		DEFAULT => -57
	},
	{#State 453
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 470
		}
	},
	{#State 454
		ACTIONS => {
			";" => 471
		}
	},
	{#State 455
		DEFAULT => -180
	},
	{#State 456
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Expression' => 156,
			'SubExpression' => 472,
			'Literal' => 99,
			'Variable' => 161,
			'HashDereference' => 148
		}
	},
	{#State 457
		ACTIONS => {
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => 241,
			"]" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => 247,
			")" => -102,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			";" => -102,
			'OP11_COMPARE_LT_GT' => 244,
			"}" => -102,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234
		}
	},
	{#State 458
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 473
		}
	},
	{#State 459
		DEFAULT => -258
	},
	{#State 460
		ACTIONS => {
			'LPAREN' => 98,
			'LBRACE' => 125,
			'OP10_NAMED_UNARY' => 124,
			'WORD' => 26,
			'OP01_OPEN' => 127,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			"\@{" => 100,
			"%{" => 129,
			"undef" => 130,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 474,
			'Expression' => 156,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'ArrayReference' => 106,
			'Operator' => 95,
			'ArrayDereference' => 109,
			'HashReference' => 134
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 462
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 476
		}
	},
	{#State 463
		ACTIONS => {
			'MY' => 477
		}
	},
	{#State 464
		ACTIONS => {
			'OP01_PRINT' => 204,
			'OP07_STRING_REPEAT' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP08_MATH_ADD_SUB' => 206,
			'OP01_NAMED' => 208,
			'OP01_CLOSE' => 220,
			'OP11_COMPARE_LT_GT' => 210,
			'OP01_NAMED_VOID' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP10_NAMED_UNARY' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP19_LOOP_CONTROL' => 200,
			'OP23_LOGICAL_AND' => 202,
			'OP22_LOGICAL_NEG' => 213,
			'WORD' => 216,
			'OP01_OPEN' => 203
		},
		GOTOS => {
			'HashEntryProperties' => 478,
			'OpStringOrWord' => 428
		}
	},
	{#State 465
		ACTIONS => {
			";" => 479
		}
	},
	{#State 466
		DEFAULT => -80
	},
	{#State 467
		ACTIONS => {
			'WORD_SCOPED' => 190,
			'TYPE_INTEGER' => 187,
			'WORD' => 191
		},
		GOTOS => {
			'Type' => 480
		}
	},
	{#State 468
		DEFAULT => -227
	},
	{#State 469
		ACTIONS => {
			'VARIABLE_SYMBOL' => 481
		}
	},
	{#State 470
		ACTIONS => {
			"foreach" => -171,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 98,
			'OP01_CLOSE' => 116,
			'LITERAL_NUMBER' => 115,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 113,
			'OP10_NAMED_UNARY_SCOLON' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LBRACKET' => 108,
			"undef" => 130,
			"%{" => 129,
			'OP01_NAMED_SCOLON' => 131,
			'OP01_OPEN' => 127,
			"while" => -171,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			"for" => -171,
			'MY' => 119,
			'OP19_LOOP_CONTROL' => 121,
			"if" => 123,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 145,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			"}" => 482,
			'OP01_PRINT' => 137,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_NAMED_VOID_SCOLON' => 135,
			'VARIABLE_SYMBOL' => 139,
			'OP05_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'Expression' => 126,
			'OperatorVoid' => 128,
			'Literal' => 99,
			'Statement' => 102,
			'Variable' => 101,
			'VariableDeclaration' => 120,
			'Operator' => 95,
			'PAREN-45' => 122,
			'WordScoped' => 97,
			'Conditional' => 114,
			'SubExpression' => 140,
			'OPTIONAL-46' => 144,
			'LoopLabel' => 117,
			'Operation' => 483,
			'HashDereference' => 148,
			'VariableModification' => 147,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 471
		DEFAULT => -203
	},
	{#State 472
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP15_LOGICAL_AND' => 237,
			")" => 484,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP18_TERNARY' => 241,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244
		}
	},
	{#State 473
		ACTIONS => {
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP01_NAMED_SCOLON' => 443,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'SELF' => 103,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 115,
			'LITERAL_STRING' => 141,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 139,
			'OP10_NAMED_UNARY_SCOLON' => 440,
			'WORD_UPPERCASE' => 162,
			'OP05_LOGICAL_NEG' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'Variable' => 161,
			'HashDereference' => 148,
			'SubExpression' => 442,
			'Expression' => 156,
			'Literal' => 99,
			'OpNamedScolonOrSubExp' => 485
		}
	},
	{#State 474
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -124,
			")" => 486,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => -124,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244
		}
	},
	{#State 475
		DEFAULT => -191
	},
	{#State 476
		DEFAULT => -189
	},
	{#State 477
		ACTIONS => {
			'WORD' => 191,
			'TYPE_INTEGER' => 187,
			'TYPE_METHOD' => 487,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 337
		}
	},
	{#State 478
		DEFAULT => -79
	},
	{#State 479
		DEFAULT => -82
	},
	{#State 480
		ACTIONS => {
			"\$TYPED_" => 488
		}
	},
	{#State 481
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 489
		}
	},
	{#State 482
		DEFAULT => -61
	},
	{#State 483
		DEFAULT => -59
	},
	{#State 484
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 490
		}
	},
	{#State 485
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 138,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 159,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_CLOSE' => 116,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP10_NAMED_UNARY' => 124,
			'LPAREN' => 98,
			'LBRACE' => 125,
			"\@{" => 100,
			"undef" => 130,
			"%{" => 129,
			'SELF' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 104,
			'WORD' => 26,
			'OP01_OPEN' => 127
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136,
			'SubExpressionOrVarMod' => 491,
			'Literal' => 99,
			'SubExpression' => 492,
			'Expression' => 156,
			'VariableModification' => 493,
			'HashDereference' => 148,
			'Variable' => 101
		}
	},
	{#State 486
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 494
		}
	},
	{#State 487
		ACTIONS => {
			"\$RETURN_TYPE" => 495
		}
	},
	{#State 488
		ACTIONS => {
			'OP01_PRINT' => 204,
			'OP07_STRING_REPEAT' => 217,
			'OP08_MATH_ADD_SUB' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 219,
			'OP01_NAMED' => 208,
			'OP01_CLOSE' => 220,
			'OP11_COMPARE_LT_GT' => 210,
			'OP01_NAMED_VOID' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP10_NAMED_UNARY' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP12_COMPARE_EQ_NE' => 211,
			'OP19_LOOP_CONTROL' => 200,
			'OP23_LOGICAL_AND' => 202,
			'OP22_LOGICAL_NEG' => 213,
			'WORD' => 216,
			'OP01_OPEN' => 203
		},
		GOTOS => {
			'OpStringOrWord' => 496
		}
	},
	{#State 489
		ACTIONS => {
			")" => 499,
			'OP21_LIST_COMMA' => 497
		},
		GOTOS => {
			'PAREN-26' => 498
		}
	},
	{#State 490
		DEFAULT => -177
	},
	{#State 491
		ACTIONS => {
			")" => 500
		}
	},
	{#State 492
		ACTIONS => {
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP11_COMPARE_LT_GT' => 244,
			'OP07_STRING_REPEAT' => 233,
			'OP08_MATH_ADD_SUB' => 242,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			")" => -167,
			'OP13_BITWISE_AND' => 238,
			'OP16_LOGICAL_OR' => 239,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			'OP18_TERNARY' => 241,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP06_REGEX_BIND' => 235,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP15_LOGICAL_AND' => 237
		}
	},
	{#State 493
		DEFAULT => -168
	},
	{#State 494
		DEFAULT => -187
	},
	{#State 495
		ACTIONS => {
			"}" => 501
		}
	},
	{#State 496
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 502,
			'OP19_VARIABLE_ASSIGN' => 503
		}
	},
	{#State 497
		ACTIONS => {
			'MY' => 504
		}
	},
	{#State 498
		DEFAULT => -63
	},
	{#State 499
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 505
		}
	},
	{#State 500
		ACTIONS => {
			'LBRACE' => 390
		},
		GOTOS => {
			'CodeBlock' => 506
		}
	},
	{#State 501
		ACTIONS => {
			";" => 507
		}
	},
	{#State 502
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 162,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_STRING' => 141,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 124,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"%{" => 129,
			"undef" => 130,
			"\@{" => 100,
			'OP01_OPEN' => 127,
			'WORD' => 26
		},
		GOTOS => {
			'Variable' => 161,
			'HashDereference' => 148,
			'Expression' => 156,
			'SubExpression' => 508,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 136,
			'WordScoped' => 97,
			'Operator' => 95,
			'ArrayReference' => 106,
			'ArrayDereference' => 109,
			'HashReference' => 134
		}
	},
	{#State 503
		ACTIONS => {
			'LBRACKET' => 108,
			'OP05_LOGICAL_NEG' => 133,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 162,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_STRING' => 141,
			'LITERAL_NUMBER' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_CLOSE' => 116,
			'OP03_MATH_INC_DEC' => 146,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 124,
			'LBRACE' => 125,
			'LPAREN' => 98,
			'OP01_OPEN' => 127,
			'WORD' => 26,
			"undef" => 130,
			"%{" => 129,
			"\@{" => 100,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103
		},
		GOTOS => {
			'Literal' => 99,
			'SubExpression' => 509,
			'Expression' => 156,
			'HashDereference' => 148,
			'Variable' => 161,
			'HashReference' => 134,
			'ArrayDereference' => 109,
			'ArrayReference' => 106,
			'Operator' => 95,
			'WordScoped' => 97,
			'VariableSymbolOrSelf' => 136
		}
	},
	{#State 504
		ACTIONS => {
			'WORD_SCOPED' => 190,
			'WORD' => 191,
			'TYPE_INTEGER' => 187
		},
		GOTOS => {
			'Type' => 510
		}
	},
	{#State 505
		ACTIONS => {
			"\@ARG;" => 511
		}
	},
	{#State 506
		DEFAULT => -188
	},
	{#State 507
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'SELF' => -85,
			"\@{" => -85,
			"foreach" => -85,
			'WORD' => -85,
			'LPAREN' => -85,
			'OP01_NAMED_VOID' => -85,
			'OP01_CLOSE' => -85,
			'LITERAL_NUMBER' => -85,
			'WORD_UPPERCASE' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'LBRACKET' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_NAMED_SCOLON' => -85,
			"undef" => -85,
			"%{" => -85,
			"while" => -85,
			'OP01_OPEN' => -85,
			'LPAREN_MY' => 513,
			"for" => -85,
			'LBRACE' => -85,
			'OP10_NAMED_UNARY' => -85,
			"if" => -85,
			'OP19_LOOP_CONTROL' => -85,
			'MY' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'WORD_SCOPED' => -85,
			'OP01_NAMED' => -85,
			"}" => -85,
			'LITERAL_STRING' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'VARIABLE_SYMBOL' => -85,
			'OP01_PRINT' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP05_LOGICAL_NEG' => -85
		},
		GOTOS => {
			'MethodArguments' => 512,
			'OPTIONAL-35' => 514
		}
	},
	{#State 508
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 244,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP15_LOGICAL_AND' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP08_STRING_CAT' => 240,
			'OP09_BITWISE_SHIFT' => 249,
			"]" => 515,
			'OP18_TERNARY' => 241,
			'OP23_LOGICAL_AND' => 248,
			'OP17_LIST_RANGE' => 247,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238
		}
	},
	{#State 509
		ACTIONS => {
			'OP18_TERNARY' => 241,
			'OP09_BITWISE_SHIFT' => 249,
			'OP08_STRING_CAT' => 240,
			'OP16_LOGICAL_OR' => 239,
			'OP13_BITWISE_AND' => 238,
			'OP17_LIST_RANGE' => 247,
			'OP23_LOGICAL_AND' => 248,
			'OP15_LOGICAL_AND' => 237,
			'OP12_COMPARE_EQ_NE' => 236,
			'OP06_REGEX_BIND' => 235,
			'OP24_LOGICAL_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 245,
			'OP21_LIST_COMMA' => -244,
			"}" => -244,
			'OP11_COMPARE_LT_GT' => 244,
			'OP14_BITWISE_OR_XOR' => 234,
			'OP04_MATH_POW' => 243,
			'OP08_MATH_ADD_SUB' => 242,
			'OP07_STRING_REPEAT' => 233
		}
	},
	{#State 510
		ACTIONS => {
			'VARIABLE_SYMBOL' => 516
		}
	},
	{#State 511
		DEFAULT => -65
	},
	{#State 512
		DEFAULT => -84
	},
	{#State 513
		ACTIONS => {
			'WORD_SCOPED' => 190,
			'TYPE_INTEGER' => 187,
			'WORD' => 191
		},
		GOTOS => {
			'Type' => 517
		}
	},
	{#State 514
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 518
		}
	},
	{#State 515
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 519
		}
	},
	{#State 516
		DEFAULT => -62
	},
	{#State 517
		ACTIONS => {
			'SELF' => 520
		}
	},
	{#State 518
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 133,
			'VARIABLE_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 138,
			'OP01_PRINT' => 137,
			'OP01_NAMED_VOID_SCOLON' => 135,
			"}" => 522,
			'LITERAL_STRING' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP03_MATH_INC_DEC' => 146,
			'OP01_NAMED' => 145,
			'WORD_SCOPED' => 27,
			"if" => 123,
			'MY' => 119,
			'OP19_LOOP_CONTROL' => 121,
			'LBRACE' => 125,
			"for" => -171,
			'OP10_NAMED_UNARY' => 124,
			"while" => -171,
			'OP01_OPEN' => 127,
			'OP01_NAMED_SCOLON' => 131,
			"undef" => 130,
			"%{" => 129,
			'LBRACKET' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'OP10_NAMED_UNARY_SCOLON' => 112,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 115,
			'OP01_CLOSE' => 116,
			'LPAREN' => 98,
			'OP01_NAMED_VOID' => 96,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'SELF' => 103,
			"\@{" => 100,
			"foreach" => -171
		},
		GOTOS => {
			'PAREN-45' => 122,
			'VariableDeclaration' => 120,
			'Operator' => 95,
			'WordScoped' => 97,
			'OperatorVoid' => 128,
			'Literal' => 99,
			'Expression' => 126,
			'Statement' => 102,
			'Variable' => 101,
			'ArrayDereference' => 109,
			'HashReference' => 134,
			'ArrayReference' => 106,
			'VariableSymbolOrSelf' => 136,
			'OPTIONAL-46' => 144,
			'Conditional' => 114,
			'SubExpression' => 140,
			'VariableModification' => 147,
			'HashDereference' => 148,
			'Operation' => 521,
			'LoopLabel' => 117
		}
	},
	{#State 519
		ACTIONS => {
			"undef" => 523
		}
	},
	{#State 520
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 524
		}
	},
	{#State 521
		DEFAULT => -86
	},
	{#State 522
		DEFAULT => -88
	},
	{#State 523
		DEFAULT => -245
	},
	{#State 524
		ACTIONS => {
			")" => 525,
			'OP21_LIST_COMMA' => 527
		},
		GOTOS => {
			'PAREN-37' => 526
		}
	},
	{#State 525
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 528
		}
	},
	{#State 526
		DEFAULT => -90
	},
	{#State 527
		ACTIONS => {
			'MY' => 529
		}
	},
	{#State 528
		ACTIONS => {
			"\@ARG;" => 530
		}
	},
	{#State 529
		ACTIONS => {
			'TYPE_INTEGER' => 187,
			'WORD' => 191,
			'WORD_SCOPED' => 190
		},
		GOTOS => {
			'Type' => 531
		}
	},
	{#State 530
		DEFAULT => -92
	},
	{#State 531
		ACTIONS => {
			'VARIABLE_SYMBOL' => 532
		}
	},
	{#State 532
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7446 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7566 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7577 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7630 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7701 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7708 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7740 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7747 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7754 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7761 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7772 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7779 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7786 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7800 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7811 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7822 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7833 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7861 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7872 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7893 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7904 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7911 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7932 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7939 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7946 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7960 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7974 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7985 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7996 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8007 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8014 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8028 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8039 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8050 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8057 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8078 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8089 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8103 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8110 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8121 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8132 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8143 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8154 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8165 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8176 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8187 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8198 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8209 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8220 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8231 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8242 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8253 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8264 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8275 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8286 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8297 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8308 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8319 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8330 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8341 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8352 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8363 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8374 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8385 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8396 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8407 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8418 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8429 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8440 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8451 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8462 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8473 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8484 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8495 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8506 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8528 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8574 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8585 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8596 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8607 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8618 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8629 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8640 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8651 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8665 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8693 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8704 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8715 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8726 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8737 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8748 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8759 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8770 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8781 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8792 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8803 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8814 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8825 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8836 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8847 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8858 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8869 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8880 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8891 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8902 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_168
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8913 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8920 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8927 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 238 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8934 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8945 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8956 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8967 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8978 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8989 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8996 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9003 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9010 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9031 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_183
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9042 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_184
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9053 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9064 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_186
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9075 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_187
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9086 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_188
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9097 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_189
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9108 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_190
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9119 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_191
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9130 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9137 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9144 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_194
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9169 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_197
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9180 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_198
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9191 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_199
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9202 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_200
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9213 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_201
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9224 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_202
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9235 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_203
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9246 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_204
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9257 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_205
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9268 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_206
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9279 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9286 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9300 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_210
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9311 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_211
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9322 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_212
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9333 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_213
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9344 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_214
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9355 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9362 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9369 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_217
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9380 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9387 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9394 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_220
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9405 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_221
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9416 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9423 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9430 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_224
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9441 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_225
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9452 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_226
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9463 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_227
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9474 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9488 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9495 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_231
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9506 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_232
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9517 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9524 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9531 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_235
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9542 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_236
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9553 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_237
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9564 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_238
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9575 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_239
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9586 lib/RPerl/Grammar.pm
	],
	[#Rule Type_240
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9597 lib/RPerl/Grammar.pm
	],
	[#Rule Type_241
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9608 lib/RPerl/Grammar.pm
	],
	[#Rule Type_242
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9619 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_243
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9630 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_244
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9641 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_245
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9652 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_246
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9663 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_247
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9674 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_248
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9685 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_249
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9696 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_250
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9707 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_251
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9718 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_252
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9729 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_253
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9740 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_254
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9751 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_255
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9762 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_256
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9773 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_257
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9784 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_258
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9795 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_259
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9806 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_260
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9817 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_261
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9828 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9839 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9850 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9861 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9872 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9883 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9894 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9905 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9916 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9927 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9938 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9949 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_273
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9960 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_274
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9971 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_275
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9982 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_276
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9993 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_277
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10004 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_278
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10015 lib/RPerl/Grammar.pm
	]
],
#line 10018 lib/RPerl/Grammar.pm
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
Include_55 => 'RPerl::CompileUnit::Include',                                # Include -> '{' WordScoped OP02_METHOD_THINARROW_IMP OPTIONAL-23 ')' ';' '}'
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


#line 10512 lib/RPerl/Grammar.pm



1;
