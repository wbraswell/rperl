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

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|BEGIN\ \{|foreach|\$TYPED_|package|elsif|\@ARG\;|while|undef|else|for|if|\%\{|\@\{|\]|\)|\;|\})}gc and return ($1, $1);

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
  [ 'Include_52' => 'Include', [ 'USE', 'WordScoped', ';' ], 0 ],
  [ 'Include_53' => 'Include', [ 'USE', 'WordScoped', 'OP01_QW', ';' ], 0 ],
  [ 'Include_54' => 'Include', [ 'BEGIN {', 'WordScoped', 'OP02_METHOD_THINARROW_IMP', 'OPTIONAL-22', ')', ';', '}' ], 0 ],
  [ 'Constant_55' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ 'Subroutine_60' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-23', 'STAR-24', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'PAREN-25' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ 'SubroutineArguments_64' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-26', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-28', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-28', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'SubroutineOrMethod' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'Class_75' => 'Class', [ 'UseParent', 'WordScoped', ')', ';', 'Include', 'STAR-27', 'OPTIONAL-28', 'STAR-29', 'STAR-30', 'Properties', 'STAR-31', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'UseParent_76' => 'UseParent', [ 'use parent qw(' ], 0 ],
  [ 'UseParent_77' => 'UseParent', [ 'use parent -norequire, qw(' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'Properties_81' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-33', '}', ';' ], 0 ],
  [ 'Properties_82' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ 'Method_87' => 'Method', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'TYPE_METHOD', '$RETURN_TYPE', '}', ';', 'OPTIONAL-34', 'STAR-35', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ 'MethodArguments_91' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-37', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_92' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_93' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_94' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_95' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_96' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_97' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_127' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_128' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-39', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_140' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_141' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-41', ')' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-43', ')' ], 0 ],
  [ 'SubExpression_154' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_158' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_159' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_163' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_164' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_165' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_166' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_167' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'PAREN-44' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Statement_171' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_172' => 'Statement', [ 'OPTIONAL-45', 'Loop' ], 0 ],
  [ 'Statement_173' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_174' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_175' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'PAREN-48' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'Conditional_182' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-47', 'OPTIONAL-49' ], 0 ],
  [ 'Loop_183' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_184' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_185' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_186' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_187' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_188' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_189' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_190' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-50', [ 'PLUS-50', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-50', [ 'Operation' ], 0 ],
  [ 'CodeBlock_193' => 'CodeBlock', [ 'LBRACE', 'PLUS-50', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [ 'STAR-51', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [  ], 0 ],
  [ 'Variable_196' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-51' ], 0 ],
  [ 'VariableRetrieval_197' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_198' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_199' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_200' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_201' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_202' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_203' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_204' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_205' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-52', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'PAREN-52' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'ListElements_209' => 'ListElements', [ 'ListElement', 'STAR-53' ], 0 ],
  [ 'ListElement_210' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_211' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_212' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_213' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'ArrayReference_216' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-54', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'ArrayDereference_219' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_220' => 'ArrayDereference', [ '@{', 'OPTIONAL-55', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'HashEntry_223' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-56', 'SubExpression' ], 0 ],
  [ 'HashEntry_224' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_225' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_226' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'HashReference_230' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-58', '}' ], 0 ],
  [ 'HashReference_231' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'HashDereference_234' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_235' => 'HashDereference', [ '%{', 'OPTIONAL-59', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_236' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_237' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_238' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_239' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_240' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_241' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_242' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_243' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_244' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_245' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_246' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_247' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_248' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_249' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_250' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_251' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_252' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_253' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_254' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_255' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_256' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_257' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_258' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_259' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_260' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_261' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_262' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_272' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_273' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_274' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_275' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_276' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_277' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'Include_52' => 52,
  'Include_53' => 53,
  'Include_54' => 54,
  'Constant_55' => 55,
  '_OPTIONAL' => 56,
  '_OPTIONAL' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  'Subroutine_60' => 60,
  '_PAREN' => 61,
  '_STAR_LIST' => 62,
  '_STAR_LIST' => 63,
  'SubroutineArguments_64' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  '_OPTIONAL' => 67,
  '_OPTIONAL' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  'Class_75' => 75,
  'UseParent_76' => 76,
  'UseParent_77' => 77,
  '_PAREN' => 78,
  '_STAR_LIST' => 79,
  '_STAR_LIST' => 80,
  'Properties_81' => 81,
  'Properties_82' => 82,
  '_OPTIONAL' => 83,
  '_OPTIONAL' => 84,
  '_STAR_LIST' => 85,
  '_STAR_LIST' => 86,
  'Method_87' => 87,
  '_PAREN' => 88,
  '_STAR_LIST' => 89,
  '_STAR_LIST' => 90,
  'MethodArguments_91' => 91,
  'SubroutineOrMethod_92' => 92,
  'SubroutineOrMethod_93' => 93,
  'Operation_94' => 94,
  'Operation_95' => 95,
  'Operation_96' => 96,
  'Operation_97' => 97,
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
  'Operator_124' => 124,
  'Operator_125' => 125,
  'Operator_126' => 126,
  'Operator_127' => 127,
  'Operator_128' => 128,
  '_PAREN' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  'OperatorVoid_139' => 139,
  'OperatorVoid_140' => 140,
  'OperatorVoid_141' => 141,
  '_OPTIONAL' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  '_OPTIONAL' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  'Expression_148' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'SubExpression_154' => 154,
  'SubExpression_155' => 155,
  'SubExpression_156' => 156,
  'SubExpression_157' => 157,
  'SubExpression_158' => 158,
  'SubExpression_159' => 159,
  'SubExpression_160' => 160,
  'SubExpression_161' => 161,
  'SubExpression_162' => 162,
  'SubExpressionOrInput_163' => 163,
  'SubExpressionOrInput_164' => 164,
  'SubExpressionOrInput_165' => 165,
  'SubExpressionOrVarMod_166' => 166,
  'SubExpressionOrVarMod_167' => 167,
  '_PAREN' => 168,
  '_OPTIONAL' => 169,
  '_OPTIONAL' => 170,
  'Statement_171' => 171,
  'Statement_172' => 172,
  'Statement_173' => 173,
  'Statement_174' => 174,
  'Statement_175' => 175,
  '_PAREN' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  '_PAREN' => 179,
  '_OPTIONAL' => 180,
  '_OPTIONAL' => 181,
  'Conditional_182' => 182,
  'Loop_183' => 183,
  'Loop_184' => 184,
  'Loop_185' => 185,
  'LoopFor_186' => 186,
  'LoopFor_187' => 187,
  'LoopForEach_188' => 188,
  'LoopWhile_189' => 189,
  'LoopWhile_190' => 190,
  '_PLUS_LIST' => 191,
  '_PLUS_LIST' => 192,
  'CodeBlock_193' => 193,
  '_STAR_LIST' => 194,
  '_STAR_LIST' => 195,
  'Variable_196' => 196,
  'VariableRetrieval_197' => 197,
  'VariableRetrieval_198' => 198,
  'VariableRetrieval_199' => 199,
  'VariableDeclaration_200' => 200,
  'VariableDeclaration_201' => 201,
  'VariableDeclaration_202' => 202,
  'VariableDeclaration_203' => 203,
  'VariableModification_204' => 204,
  'VariableModification_205' => 205,
  '_PAREN' => 206,
  '_STAR_LIST' => 207,
  '_STAR_LIST' => 208,
  'ListElements_209' => 209,
  'ListElement_210' => 210,
  'ListElement_211' => 211,
  'ListElement_212' => 212,
  'ListElement_213' => 213,
  '_OPTIONAL' => 214,
  '_OPTIONAL' => 215,
  'ArrayReference_216' => 216,
  '_OPTIONAL' => 217,
  '_OPTIONAL' => 218,
  'ArrayDereference_219' => 219,
  'ArrayDereference_220' => 220,
  '_OPTIONAL' => 221,
  '_OPTIONAL' => 222,
  'HashEntry_223' => 223,
  'HashEntry_224' => 224,
  'HashEntry_225' => 225,
  'HashEntryProperties_226' => 226,
  '_PAREN' => 227,
  '_STAR_LIST' => 228,
  '_STAR_LIST' => 229,
  'HashReference_230' => 230,
  'HashReference_231' => 231,
  '_OPTIONAL' => 232,
  '_OPTIONAL' => 233,
  'HashDereference_234' => 234,
  'HashDereference_235' => 235,
  'WordScoped_236' => 236,
  'WordScoped_237' => 237,
  'LoopLabel_238' => 238,
  'Type_239' => 239,
  'Type_240' => 240,
  'Type_241' => 241,
  'TypeInner_242' => 242,
  'TypeInnerProperties_243' => 243,
  'TypeInnerProperties_244' => 244,
  'TypeInnerConstant_245' => 245,
  'VariableOrLiteral_246' => 246,
  'VariableOrLiteral_247' => 247,
  'VarOrLitOrOpStrOrWord_248' => 248,
  'VarOrLitOrOpStrOrWord_249' => 249,
  'VarOrLitOrOpStrOrWord_250' => 250,
  'VariableSymbolOrSelf_251' => 251,
  'VariableSymbolOrSelf_252' => 252,
  'Literal_253' => 253,
  'Literal_254' => 254,
  'OpNamedScolonOrSubExp_255' => 255,
  'OpNamedScolonOrSubExp_256' => 256,
  'OpNamedScolonOrSubExp_257' => 257,
  'OpNamedScolonOrSubExpIn_258' => 258,
  'OpNamedScolonOrSubExpIn_259' => 259,
  'OpNamedScolonOrSubExpIn_260' => 260,
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
  'OpStringOrWord_273' => 273,
  'OpStringOrWord_274' => 274,
  'OpStringOrWord_275' => 275,
  'OpStringOrWord_276' => 276,
  'OpStringOrWord_277' => 277,
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
	'BEGIN {' => { ISSEMANTIC => 0 },
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
			"## no critic qw(" => 3,
			'SHEBANG' => 1,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 9,
			'OPTIONAL-9' => 7,
			'CompileUnit' => 6,
			'ModuleHeader' => 5,
			'PLUS-2' => 2,
			'Program' => 8,
			'PAREN-1' => 4
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'OPTIONAL-3' => 10,
			'Critic' => 11
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 3,
			'USE_RPERL' => -20,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 9,
			'OPTIONAL-9' => 7,
			'ModuleHeader' => 5,
			'PAREN-1' => 12
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 14
		},
		GOTOS => {
			'PLUS-17' => 13
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			"BEGIN {" => -27,
			"use constant" => -27,
			"## no critic qw(" => -27,
			'SUB' => -27,
			"use parent qw(" => 18,
			'USE' => -27,
			"use parent -norequire, qw(" => 19,
			'USE_EXPORTER' => -27
		},
		GOTOS => {
			'Module' => 20,
			'Class' => 15,
			'UseParent' => 21,
			'Package' => 16,
			'STAR-11' => 17
		}
	},
	{#State 6
		ACTIONS => {
			'' => 22
		}
	},
	{#State 7
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 24
		},
		GOTOS => {
			'OPTIONAL-10' => 23
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		DEFAULT => -2
	},
	{#State 13
		ACTIONS => {
			")" => 27,
			'WORD' => 26
		}
	},
	{#State 14
		DEFAULT => -41
	},
	{#State 15
		DEFAULT => -25
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		ACTIONS => {
			"use constant" => -29,
			"## no critic qw(" => 3,
			'USE' => -29,
			"BEGIN {" => -29,
			'SUB' => -29,
			'USE_EXPORTER' => 30
		},
		GOTOS => {
			'Exports' => 31,
			'Critic' => 28,
			'OPTIONAL-12' => 29
		}
	},
	{#State 18
		DEFAULT => -76
	},
	{#State 19
		DEFAULT => -77
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		ACTIONS => {
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 33
		}
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		ACTIONS => {
			"package" => 35
		}
	},
	{#State 24
		DEFAULT => -21
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
		DEFAULT => -40
	},
	{#State 27
		DEFAULT => -42
	},
	{#State 28
		DEFAULT => -26
	},
	{#State 29
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 30
		ACTIONS => {
			'SUB' => -45,
			'OUR_EXPORT_OK' => -45,
			"use constant" => -45,
			"BEGIN {" => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT' => 40,
			'USE' => -45
		},
		GOTOS => {
			'PAREN-18' => 41,
			'OPTIONAL-19' => 39
		}
	},
	{#State 31
		DEFAULT => -28
	},
	{#State 32
		DEFAULT => -237
	},
	{#State 33
		ACTIONS => {
			")" => 42
		}
	},
	{#State 34
		DEFAULT => -236
	},
	{#State 35
		ACTIONS => {
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 43
		}
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
			'SUB' => -33,
			"BEGIN {" => 48,
			'USE' => 46,
			"use constant" => -33
		},
		GOTOS => {
			'STAR-14' => 47,
			'Include' => 49
		}
	},
	{#State 39
		ACTIONS => {
			'OUR_EXPORT_OK' => 52,
			'SUB' => -48,
			"our hashref \$properties" => -48,
			'USE' => -48,
			"BEGIN {" => -48,
			"use constant" => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 51,
			'PAREN-20' => 50
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
			'OP01_NAMED_SCOLON' => -11,
			'WORD_SCOPED' => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			"while" => -11,
			'OP01_PRINT' => -11,
			"## no critic qw(" => 3,
			"\@{" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'LPAREN' => -11,
			'USE' => -11,
			'LBRACKET' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'VARIABLE_SYMBOL' => -11,
			"BEGIN {" => -11,
			'MY' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"undef" => -11,
			'OP01_NAMED' => -11,
			"%{" => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"if" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"for" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'SELF' => -11,
			"foreach" => -11,
			'SUB' => -11,
			"use constant" => -11,
			'OP01_OPEN' => -11,
			'LITERAL_NUMBER' => -11
		},
		GOTOS => {
			'Critic' => 57,
			'STAR-5' => 56
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
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 60
		}
	},
	{#State 47
		ACTIONS => {
			'SUB' => 63,
			"use constant" => 65
		},
		GOTOS => {
			'Subroutine' => 64,
			'Constant' => 62,
			'PLUS-15' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 34
		},
		GOTOS => {
			'WordScoped' => 66
		}
	},
	{#State 49
		DEFAULT => -30
	},
	{#State 50
		DEFAULT => -47
	},
	{#State 51
		DEFAULT => -49
	},
	{#State 52
		ACTIONS => {
			'OP01_QW' => 67
		}
	},
	{#State 53
		ACTIONS => {
			";" => 68
		}
	},
	{#State 54
		ACTIONS => {
			"BEGIN {" => 48,
			'USE' => 46
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
		ACTIONS => {
			'USE' => 46,
			'LPAREN' => -13,
			'LBRACKET' => -13,
			'OP01_CLOSE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"BEGIN {" => 48,
			'VARIABLE_SYMBOL' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"\@{" => -13,
			'OP01_PRINT' => -13,
			"while" => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"for" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'LBRACE' => -13,
			"if" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			'OP01_OPEN' => -13,
			'SELF' => -13,
			"foreach" => -13,
			'SUB' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"undef" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"%{" => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_NAMED' => -13
		},
		GOTOS => {
			'Include' => 71,
			'STAR-6' => 72
		}
	},
	{#State 57
		DEFAULT => -8
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
		ACTIONS => {
			";" => 74,
			'OP01_QW' => 75
		}
	},
	{#State 61
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'SUB' => 63
		},
		GOTOS => {
			'Subroutine' => 76
		}
	},
	{#State 62
		DEFAULT => -32
	},
	{#State 63
		ACTIONS => {
			'WORD' => 78
		}
	},
	{#State 64
		DEFAULT => -35
	},
	{#State 65
		ACTIONS => {
			'WORD_UPPERCASE' => 79
		}
	},
	{#State 66
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 80
		}
	},
	{#State 67
		ACTIONS => {
			";" => 81
		}
	},
	{#State 68
		DEFAULT => -43
	},
	{#State 69
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 82
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
			'VARIABLE_SYMBOL' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACKET' => -15,
			'LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"\@{" => -15,
			"while" => -15,
			'OP01_PRINT' => -15,
			'WORD' => -15,
			'OP10_NAMED_UNARY' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_OPEN' => -15,
			"use constant" => 65,
			'SUB' => -15,
			'SELF' => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"for" => -15,
			'LBRACE' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'WORD_UPPERCASE' => -15,
			"if" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"%{" => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"undef" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'MY' => -15
		},
		GOTOS => {
			'Constant' => 83,
			'STAR-7' => 84
		}
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		DEFAULT => -52
	},
	{#State 75
		ACTIONS => {
			";" => 86
		}
	},
	{#State 76
		DEFAULT => -34
	},
	{#State 77
		ACTIONS => {
			";" => 87
		}
	},
	{#State 78
		ACTIONS => {
			'LBRACE' => 88
		}
	},
	{#State 79
		ACTIONS => {
			'OP20_HASH_FATARROW' => 89
		}
	},
	{#State 80
		ACTIONS => {
			")" => -51,
			'OP01_QW' => 90
		},
		GOTOS => {
			'OPTIONAL-22' => 91
		}
	},
	{#State 81
		DEFAULT => -46
	},
	{#State 82
		ACTIONS => {
			'USE_EXPORTER' => 30,
			"our hashref \$properties" => -68,
			'USE' => -68,
			"BEGIN {" => -68,
			"use constant" => -68,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 94,
			'OPTIONAL-28' => 93,
			'Exports' => 92
		}
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'OP19_LOOP_CONTROL' => 129,
			'SELF' => 132,
			"foreach" => -170,
			'SUB' => 63,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			"if" => 137,
			'WORD_UPPERCASE' => 139,
			'OP01_NAMED_VOID' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"for" => -170,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'OP01_NAMED' => 116,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'MY' => 121,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_NAMED_VOID_SCOLON' => 128,
			"undef" => 126,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			"while" => -170,
			'OP01_PRINT' => 98,
			"\@{" => 99,
			'OP01_NAMED_SCOLON' => 100,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'Subroutine' => 97,
			'LoopLabel' => 95,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Statement' => 102,
			'PLUS-8' => 101,
			'Literal' => 122,
			'Operation' => 124,
			'ArrayReference' => 120,
			'VariableDeclaration' => 106,
			'OperatorVoid' => 134,
			'Operator' => 104,
			'HashReference' => 130,
			'Variable' => 114,
			'Conditional' => 112,
			'SubExpression' => 145,
			'ArrayDereference' => 144,
			'VariableModification' => 143,
			'OPTIONAL-45' => 109,
			'HashDereference' => 108,
			'Expression' => 136,
			'PAREN-44' => 107
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -53
	},
	{#State 87
		DEFAULT => -36
	},
	{#State 88
		ACTIONS => {
			'LBRACE' => 149
		}
	},
	{#State 89
		ACTIONS => {
			'MY' => 151
		},
		GOTOS => {
			'TypeInnerConstant' => 150
		}
	},
	{#State 90
		DEFAULT => -50
	},
	{#State 91
		ACTIONS => {
			")" => 152
		}
	},
	{#State 92
		DEFAULT => -67
	},
	{#State 93
		DEFAULT => -70,
		GOTOS => {
			'STAR-29' => 153
		}
	},
	{#State 94
		DEFAULT => -65
	},
	{#State 95
		ACTIONS => {
			'COLON' => 154
		}
	},
	{#State 96
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP08_MATH_ADD_SUB' => -116,
			'OP06_REGEX_BIND' => -116,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'OP17_LIST_RANGE' => -116,
			";" => -116,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'OP13_BITWISE_AND' => -116,
			'OP07_STRING_REPEAT' => -116,
			'WORD_SCOPED' => 32,
			"}" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP09_BITWISE_SHIFT' => -116,
			'OP18_TERNARY' => -116,
			"\@{" => 99,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"]" => -116,
			'OP21_LIST_COMMA' => -116,
			'LBRACE' => 140,
			'OP04_MATH_POW' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			")" => -116,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP07_MATH_MULT_DIV_MOD' => -116,
			'OP08_STRING_CAT' => -116,
			"undef" => 126,
			'OP23_LOGICAL_AND' => -116,
			'OP01_NAMED' => 155,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP16_LOGICAL_OR' => -116
		},
		GOTOS => {
			'SubExpression' => 158,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 97
		DEFAULT => -14
	},
	{#State 98
		ACTIONS => {
			'SELF' => -131,
			'VARIABLE_SYMBOL' => -131,
			'OP03_MATH_INC_DEC' => -131,
			'LITERAL_NUMBER' => -131,
			'OP01_OPEN' => -131,
			'FHREF_SYMBOL_BRACES' => 161,
			'OP05_BITWISE_NEG_LPAREN' => -131,
			'OP05_MATH_NEG_LPAREN' => -131,
			'OP01_CLOSE' => -131,
			'LBRACE' => -131,
			'WORD_UPPERCASE' => -131,
			'STDOUT_STDERR' => 163,
			'ARGV' => -131,
			'LITERAL_STRING' => -131,
			'OP22_LOGICAL_NEG' => -131,
			'OP05_LOGICAL_NEG' => -131,
			'LPAREN' => -131,
			'LBRACKET' => -131,
			'OP01_QW' => -131,
			'OP10_NAMED_UNARY' => -131,
			'WORD' => -131,
			'OP01_NAMED' => -131,
			"\@{" => -131,
			"%{" => -131,
			'OP22_LOGICAL_NEG_LPAREN' => -131,
			'CONSTANT_CALL_SCOPED' => -131,
			'WORD_SCOPED' => -131,
			'MY' => -131,
			"undef" => -131
		},
		GOTOS => {
			'PAREN-38' => 162,
			'OPTIONAL-39' => 160
		}
	},
	{#State 99
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'MY' => 164,
			'LBRACKET' => -218
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 125,
			'Variable' => 167,
			'OPTIONAL-55' => 166,
			'TypeInner' => 165
		}
	},
	{#State 100
		DEFAULT => -95
	},
	{#State 101
		ACTIONS => {
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'WORD_SCOPED' => 32,
			'OP01_NAMED_SCOLON' => 100,
			"\@{" => 99,
			'OP01_PRINT' => 98,
			"while" => -170,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'' => -18,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"for" => -170,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_NAMED_VOID' => 138,
			'WORD_UPPERCASE' => 139,
			"if" => 137,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			"foreach" => -170,
			'SELF' => 132,
			'OP19_LOOP_CONTROL' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'OP01_NAMED_VOID_SCOLON' => 128,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'MY' => 121,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'OP01_NAMED' => 116
		},
		GOTOS => {
			'OPTIONAL-45' => 109,
			'PAREN-44' => 107,
			'Expression' => 136,
			'HashDereference' => 108,
			'Conditional' => 112,
			'SubExpression' => 145,
			'Variable' => 114,
			'ArrayDereference' => 144,
			'VariableModification' => 143,
			'Operator' => 104,
			'HashReference' => 130,
			'OperatorVoid' => 134,
			'VariableDeclaration' => 106,
			'Operation' => 168,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Statement' => 102,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'LoopLabel' => 95
		}
	},
	{#State 102
		DEFAULT => -97
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 125,
			'Variable' => 169
		}
	},
	{#State 104
		DEFAULT => -148
	},
	{#State 105
		DEFAULT => -251
	},
	{#State 106
		DEFAULT => -174
	},
	{#State 107
		DEFAULT => -169
	},
	{#State 108
		DEFAULT => -161
	},
	{#State 109
		ACTIONS => {
			"foreach" => 174,
			"while" => 170,
			"for" => 176
		},
		GOTOS => {
			'LoopForEach' => 175,
			'LoopFor' => 173,
			'LoopWhile' => 171,
			'Loop' => 172
		}
	},
	{#State 110
		ACTIONS => {
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 177,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 111
		ACTIONS => {
			'FHREF_SYMBOL' => 178
		}
	},
	{#State 112
		DEFAULT => -171
	},
	{#State 113
		ACTIONS => {
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP01_QW' => 181,
			"undef" => 126,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP01_CLOSE' => 111,
			"]" => -215,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 184,
			'ListElements' => 180,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130,
			'ListElement' => 182,
			'OPTIONAL-54' => 179,
			'TypeInner' => 185
		}
	},
	{#State 114
		ACTIONS => {
			'OP18_TERNARY' => -157,
			'OP09_BITWISE_SHIFT' => -157,
			'OP16_LOGICAL_OR' => -157,
			'OP23_LOGICAL_AND' => -157,
			'OP11_COMPARE_LT_GT' => -157,
			'OP15_LOGICAL_AND' => -157,
			'OP08_STRING_CAT' => -157,
			'OP07_MATH_MULT_DIV_MOD' => -157,
			'OP14_BITWISE_OR_XOR' => -157,
			'OP19_VARIABLE_ASSIGN_BY' => 189,
			'OP24_LOGICAL_OR_XOR' => -157,
			'OP07_STRING_REPEAT' => -157,
			'OP13_BITWISE_AND' => -157,
			'OP02_METHOD_THINARROW' => 186,
			'OP03_MATH_INC_DEC' => 187,
			")" => -157,
			'OP17_LIST_RANGE' => -157,
			'OP12_COMPARE_EQ_NE' => -157,
			'OP08_MATH_ADD_SUB' => -157,
			'OP04_MATH_POW' => -157,
			'OP06_REGEX_BIND' => -157,
			'OP19_VARIABLE_ASSIGN' => 188
		}
	},
	{#State 115
		ACTIONS => {
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			"\@{" => 99,
			'OP01_PRINT' => 190,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 192,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 191,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 116
		ACTIONS => {
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP01_QW' => 181,
			"undef" => 126,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 193,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'TypeInner' => 185,
			'ListElement' => 194,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 117
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'SubExpression' => 195,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108
		}
	},
	{#State 118
		ACTIONS => {
			'MY' => 164,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'LBRACE' => -233
		},
		GOTOS => {
			'TypeInner' => 198,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 197,
			'OPTIONAL-59' => 196
		}
	},
	{#State 119
		ACTIONS => {
			'MY' => 164,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 181,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'ARGV' => 183,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACKET' => 113,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'OP03_MATH_INC_DEC' => 103,
			")" => -133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135
		},
		GOTOS => {
			'ListElements' => 200,
			'ArrayDereference' => 144,
			'SubExpression' => 184,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108,
			'Literal' => 122,
			'OPTIONAL-40' => 199,
			'TypeInner' => 185,
			'ListElement' => 182,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 120
		DEFAULT => -158
	},
	{#State 121
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 204,
			'TYPE_INTEGER' => 205,
			'TYPE_FHREF' => 203
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 122
		DEFAULT => -156
	},
	{#State 123
		DEFAULT => -150
	},
	{#State 124
		DEFAULT => -17
	},
	{#State 125
		DEFAULT => -195,
		GOTOS => {
			'STAR-51' => 206
		}
	},
	{#State 126
		DEFAULT => -155
	},
	{#State 127
		ACTIONS => {
			'LPAREN' => 207,
			'OP02_METHOD_THINARROW_NEW' => 208
		}
	},
	{#State 128
		DEFAULT => -136
	},
	{#State 129
		ACTIONS => {
			'WORD_UPPERCASE' => 210
		},
		GOTOS => {
			'LoopLabel' => 209
		}
	},
	{#State 130
		DEFAULT => -160
	},
	{#State 131
		DEFAULT => -140
	},
	{#State 132
		DEFAULT => -252
	},
	{#State 133
		ACTIONS => {
			'MY' => 211
		}
	},
	{#State 134
		DEFAULT => -173
	},
	{#State 135
		DEFAULT => -253
	},
	{#State 136
		ACTIONS => {
			";" => 212,
			'OP07_STRING_REPEAT' => -154,
			'OP13_BITWISE_AND' => -154,
			'OP12_COMPARE_EQ_NE' => -154,
			'OP17_LIST_RANGE' => -154,
			'OP04_MATH_POW' => -154,
			'OP08_MATH_ADD_SUB' => -154,
			'OP06_REGEX_BIND' => -154,
			'OP09_BITWISE_SHIFT' => -154,
			'OP16_LOGICAL_OR' => -154,
			'OP18_TERNARY' => -154,
			'OP24_LOGICAL_OR_XOR' => -154,
			'OP14_BITWISE_OR_XOR' => -154,
			'OP08_STRING_CAT' => -154,
			'OP15_LOGICAL_AND' => -154,
			'OP11_COMPARE_LT_GT' => -154,
			'OP23_LOGICAL_AND' => -154,
			'OP07_MATH_MULT_DIV_MOD' => -154
		}
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 213
		}
	},
	{#State 138
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACKET' => 113,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP01_QW' => 181,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'SubExpression' => 184,
			'ListElements' => 214,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130,
			'ListElement' => 182,
			'TypeInner' => 185
		}
	},
	{#State 139
		ACTIONS => {
			'COLON' => -238,
			'LPAREN' => 215
		}
	},
	{#State 140
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 232,
			'OP23_LOGICAL_AND' => 219,
			'OP07_MATH_MULT_DIV_MOD' => 218,
			"}" => 230,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_PRINT' => 235,
			"%{" => 118,
			'OP10_NAMED_UNARY' => 234,
			'OP01_NAMED' => 220,
			'WORD' => 233,
			'OP12_COMPARE_EQ_NE' => 225,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 224,
			'OP08_MATH_ADD_SUB' => 238,
			'ENV' => 222,
			'OP01_CLOSE' => 237,
			'OP01_NAMED_VOID' => 221,
			'LITERAL_NUMBER' => 135,
			'OP07_STRING_REPEAT' => 240,
			'OP01_OPEN' => 228,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP19_LOOP_CONTROL' => 226
		},
		GOTOS => {
			'HashDereference' => 236,
			'HashEntry' => 231,
			'Literal' => 217,
			'VarOrLitOrOpStrOrWord' => 223,
			'OpStringOrWord' => 229,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 239
		}
	},
	{#State 141
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'SubExpression' => 241,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 142
		DEFAULT => -96
	},
	{#State 143
		ACTIONS => {
			";" => 242
		}
	},
	{#State 144
		DEFAULT => -159
	},
	{#State 145
		ACTIONS => {
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'LBRACKET' => 113,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 260,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 147
		DEFAULT => -254
	},
	{#State 148
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 261,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 149
		ACTIONS => {
			'MY' => 262
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL_NUMBER' => 135,
			'LITERAL_STRING' => 147
		},
		GOTOS => {
			'Literal' => 263
		}
	},
	{#State 151
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 264
		}
	},
	{#State 152
		ACTIONS => {
			";" => 265
		}
	},
	{#State 153
		ACTIONS => {
			"our hashref \$properties" => -72,
			"BEGIN {" => 48,
			'USE' => 46,
			"use constant" => -72
		},
		GOTOS => {
			'STAR-30' => 266,
			'Include' => 267
		}
	},
	{#State 154
		DEFAULT => -168
	},
	{#State 155
		ACTIONS => {
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'SubExpression' => 268,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 215
		}
	},
	{#State 157
		DEFAULT => -154
	},
	{#State 158
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => -115,
			'OP18_TERNARY' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP15_LOGICAL_AND' => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP08_STRING_CAT' => 245,
			'OP23_LOGICAL_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			"}" => -115,
			'OP13_BITWISE_AND' => -115,
			'OP07_STRING_REPEAT' => 259,
			";" => -115,
			")" => -115,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP21_LIST_COMMA' => -115,
			"]" => -115
		}
	},
	{#State 159
		ACTIONS => {
			'OP04_MATH_POW' => -157,
			'OP08_MATH_ADD_SUB' => -157,
			'OP06_REGEX_BIND' => -157,
			'OP17_LIST_RANGE' => -157,
			'OP12_COMPARE_EQ_NE' => -157,
			"]" => -157,
			'OP21_LIST_COMMA' => -157,
			'OP13_BITWISE_AND' => -157,
			'OP07_STRING_REPEAT' => -157,
			'OP03_MATH_INC_DEC' => 187,
			";" => -157,
			")" => -157,
			'OP02_METHOD_THINARROW' => 186,
			'OP07_MATH_MULT_DIV_MOD' => -157,
			'OP23_LOGICAL_AND' => -157,
			'OP08_STRING_CAT' => -157,
			'OP11_COMPARE_LT_GT' => -157,
			'OP15_LOGICAL_AND' => -157,
			'OP14_BITWISE_OR_XOR' => -157,
			'OP24_LOGICAL_OR_XOR' => -157,
			"}" => -157,
			'OP18_TERNARY' => -157,
			'OP16_LOGICAL_OR' => -157,
			'OP09_BITWISE_SHIFT' => -157
		}
	},
	{#State 160
		ACTIONS => {
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP01_QW' => 181,
			"undef" => 126,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'TypeInner' => 185,
			'ListElement' => 182,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108,
			'Literal' => 122,
			'ListElements' => 269,
			'ArrayDereference' => 144,
			'SubExpression' => 184,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159
		}
	},
	{#State 161
		ACTIONS => {
			'ARGV' => 183,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'MY' => 164,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 181,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'SubExpression' => 184,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144,
			'ListElements' => 270,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'ListElement' => 182,
			'TypeInner' => 185,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 162
		DEFAULT => -130
	},
	{#State 163
		DEFAULT => -129
	},
	{#State 164
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'TYPE_INTEGER' => 205,
			'WORD' => 204
		},
		GOTOS => {
			'Type' => 271
		}
	},
	{#State 165
		DEFAULT => -217
	},
	{#State 166
		ACTIONS => {
			'LBRACKET' => 113
		},
		GOTOS => {
			'ArrayReference' => 272
		}
	},
	{#State 167
		ACTIONS => {
			"}" => 273
		}
	},
	{#State 168
		DEFAULT => -16
	},
	{#State 169
		DEFAULT => -103
	},
	{#State 170
		ACTIONS => {
			'LPAREN_MY' => 274,
			'LPAREN' => 275
		}
	},
	{#State 171
		DEFAULT => -185
	},
	{#State 172
		DEFAULT => -172
	},
	{#State 173
		DEFAULT => -183
	},
	{#State 174
		ACTIONS => {
			'MY' => 276
		}
	},
	{#State 175
		DEFAULT => -184
	},
	{#State 176
		ACTIONS => {
			'MY' => 278,
			'LPAREN_MY' => 277
		}
	},
	{#State 177
		ACTIONS => {
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => 253,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => 244,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => 279,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249
		}
	},
	{#State 178
		DEFAULT => -102
	},
	{#State 179
		ACTIONS => {
			"]" => 280
		}
	},
	{#State 180
		DEFAULT => -214
	},
	{#State 181
		DEFAULT => -212
	},
	{#State 182
		DEFAULT => -208,
		GOTOS => {
			'STAR-53' => 281
		}
	},
	{#State 183
		DEFAULT => -213
	},
	{#State 184
		ACTIONS => {
			'OP21_LIST_COMMA' => -210,
			"]" => -210,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			")" => -210,
			";" => -210,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP23_LOGICAL_AND' => 244,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => 253
		}
	},
	{#State 185
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 282,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 283
		}
	},
	{#State 187
		DEFAULT => -104
	},
	{#State 188
		ACTIONS => {
			'STDIN' => 287,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'FHREF_SYMBOL_IN' => 285,
			"undef" => 126,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99
		},
		GOTOS => {
			'Expression' => 157,
			'ArrayReference' => 120,
			'SubExpressionOrInput' => 284,
			'HashDereference' => 108,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'SubExpression' => 286,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 189
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'SubExpression' => 288,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159
		}
	},
	{#State 190
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 289
		}
	},
	{#State 191
		ACTIONS => {
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			")" => 290,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => 244,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247
		}
	},
	{#State 192
		ACTIONS => {
			"undef" => 126,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP01_QW' => 181,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 193,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130,
			'ListElement' => 291,
			'TypeInner' => 185
		}
	},
	{#State 193
		ACTIONS => {
			'OP13_BITWISE_AND' => -99,
			'OP07_STRING_REPEAT' => -99,
			")" => -99,
			";" => -99,
			'OP06_REGEX_BIND' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP04_MATH_POW' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP21_LIST_COMMA' => -210,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP24_LOGICAL_OR_XOR' => -99
		}
	},
	{#State 194
		ACTIONS => {
			'OP21_LIST_COMMA' => 292
		}
	},
	{#State 195
		ACTIONS => {
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => 293
		}
	},
	{#State 196
		ACTIONS => {
			'LBRACE' => 140
		},
		GOTOS => {
			'HashReference' => 294
		}
	},
	{#State 197
		ACTIONS => {
			"}" => 295
		}
	},
	{#State 198
		DEFAULT => -232
	},
	{#State 199
		ACTIONS => {
			")" => 296
		}
	},
	{#State 200
		DEFAULT => -132
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 297
		}
	},
	{#State 202
		DEFAULT => -240
	},
	{#State 203
		ACTIONS => {
			'FHREF_SYMBOL' => 298
		}
	},
	{#State 204
		DEFAULT => -239
	},
	{#State 205
		DEFAULT => -241
	},
	{#State 206
		ACTIONS => {
			'OP15_LOGICAL_AND' => -196,
			'OP11_COMPARE_LT_GT' => -196,
			'OP08_STRING_CAT' => -196,
			'OP23_LOGICAL_AND' => -196,
			'OP07_MATH_MULT_DIV_MOD' => -196,
			"}" => -196,
			'OP24_LOGICAL_OR_XOR' => -196,
			'OP14_BITWISE_OR_XOR' => -196,
			'OP19_VARIABLE_ASSIGN_BY' => -196,
			'OP09_BITWISE_SHIFT' => -196,
			'OP16_LOGICAL_OR' => -196,
			'OP18_TERNARY' => -196,
			'OP02_HASH_THINARROW' => 301,
			'OP02_ARRAY_THINARROW' => 300,
			'OP12_COMPARE_EQ_NE' => -196,
			'OP17_LIST_RANGE' => -196,
			'OP04_MATH_POW' => -196,
			'OP08_MATH_ADD_SUB' => -196,
			'OP06_REGEX_BIND' => -196,
			'OP20_HASH_FATARROW' => -196,
			'OP21_LIST_COMMA' => -196,
			"]" => -196,
			'COLON' => -196,
			'OP19_VARIABLE_ASSIGN' => -196,
			'OP07_STRING_REPEAT' => -196,
			'OP13_BITWISE_AND' => -196,
			'OP02_METHOD_THINARROW' => -196,
			")" => -196,
			";" => -196,
			'OP03_MATH_INC_DEC' => -196
		},
		GOTOS => {
			'VariableRetrieval' => 299
		}
	},
	{#State 207
		ACTIONS => {
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			")" => -143,
			'OP03_MATH_INC_DEC' => 103,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP01_QW' => 181,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'MY' => 164
		},
		GOTOS => {
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'OPTIONAL-41' => 302,
			'ArrayDereference' => 144,
			'ListElements' => 303,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'SubExpression' => 184,
			'HashReference' => 130,
			'Operator' => 104,
			'TypeInner' => 185,
			'ListElement' => 182
		}
	},
	{#State 208
		ACTIONS => {
			'LBRACE' => 140,
			")" => -147
		},
		GOTOS => {
			'OPTIONAL-43' => 305,
			'HashReference' => 304
		}
	},
	{#State 209
		ACTIONS => {
			";" => 306
		}
	},
	{#State 210
		DEFAULT => -238
	},
	{#State 211
		ACTIONS => {
			'TYPE_FHREF' => 307
		}
	},
	{#State 212
		DEFAULT => -94
	},
	{#State 213
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'SubExpression' => 308,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108
		}
	},
	{#State 214
		ACTIONS => {
			";" => 309
		}
	},
	{#State 215
		ACTIONS => {
			")" => 310
		}
	},
	{#State 216
		DEFAULT => -261
	},
	{#State 217
		DEFAULT => -249
	},
	{#State 218
		DEFAULT => -270
	},
	{#State 219
		DEFAULT => -262
	},
	{#State 220
		DEFAULT => -272
	},
	{#State 221
		DEFAULT => -275
	},
	{#State 222
		DEFAULT => -225
	},
	{#State 223
		ACTIONS => {
			'OP20_HASH_FATARROW' => 311
		}
	},
	{#State 224
		DEFAULT => -263
	},
	{#State 225
		DEFAULT => -266
	},
	{#State 226
		DEFAULT => -265
	},
	{#State 227
		DEFAULT => -264
	},
	{#State 228
		DEFAULT => -274
	},
	{#State 229
		DEFAULT => -250
	},
	{#State 230
		DEFAULT => -231
	},
	{#State 231
		DEFAULT => -229,
		GOTOS => {
			'STAR-58' => 312
		}
	},
	{#State 232
		DEFAULT => -267
	},
	{#State 233
		DEFAULT => -277
	},
	{#State 234
		DEFAULT => -268
	},
	{#State 235
		DEFAULT => -276
	},
	{#State 236
		DEFAULT => -224
	},
	{#State 237
		DEFAULT => -273
	},
	{#State 238
		DEFAULT => -269
	},
	{#State 239
		DEFAULT => -248
	},
	{#State 240
		DEFAULT => -271
	},
	{#State 241
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP23_LOGICAL_AND' => 244,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			")" => 313,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257
		}
	},
	{#State 242
		DEFAULT => -175
	},
	{#State 243
		ACTIONS => {
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 314
		}
	},
	{#State 244
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACKET' => 113,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126
		},
		GOTOS => {
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 315,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 245
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACKET' => 113,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 316,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122
		}
	},
	{#State 246
		ACTIONS => {
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'SubExpression' => 317,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'Literal' => 122
		}
	},
	{#State 247
		ACTIONS => {
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 318,
			'ArrayDereference' => 144
		}
	},
	{#State 248
		ACTIONS => {
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 156,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'SubExpression' => 319,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125
		}
	},
	{#State 249
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'SubExpression' => 320,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120
		}
	},
	{#State 250
		ACTIONS => {
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD_UPPERCASE' => 156,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 321,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 251
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'SubExpression' => 322,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122
		}
	},
	{#State 252
		ACTIONS => {
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 323,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157
		}
	},
	{#State 253
		ACTIONS => {
			'LITERAL_STRING' => 147,
			'LITERAL_NUMBER' => 135,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'VariableOrLiteral' => 325,
			'Variable' => 324,
			'VariableSymbolOrSelf' => 125,
			'Literal' => 326
		}
	},
	{#State 254
		ACTIONS => {
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 327,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 255
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126
		},
		GOTOS => {
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'SubExpression' => 328,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 256
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 329
		}
	},
	{#State 257
		ACTIONS => {
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96
		},
		GOTOS => {
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 330,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 258
		ACTIONS => {
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'SubExpression' => 331,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157
		}
	},
	{#State 259
		ACTIONS => {
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 332,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 260
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP14_BITWISE_OR_XOR' => 246,
			"}" => -126,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			";" => -126,
			")" => -126,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP21_LIST_COMMA' => -126,
			"]" => -126
		}
	},
	{#State 261
		ACTIONS => {
			'OP07_STRING_REPEAT' => -107,
			'OP13_BITWISE_AND' => -107,
			")" => -107,
			";" => -107,
			'OP12_COMPARE_EQ_NE' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP06_REGEX_BIND' => -107,
			'OP04_MATH_POW' => 249,
			'OP21_LIST_COMMA' => -107,
			"]" => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP18_TERNARY' => -107,
			'OP08_STRING_CAT' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			"}" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP14_BITWISE_OR_XOR' => -107
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 204,
			'TYPE_INTEGER' => 205
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 263
		ACTIONS => {
			";" => 334
		}
	},
	{#State 264
		ACTIONS => {
			"\$TYPED_" => 335
		}
	},
	{#State 265
		ACTIONS => {
			"}" => 336
		}
	},
	{#State 266
		ACTIONS => {
			"our hashref \$properties" => 337,
			"use constant" => 65
		},
		GOTOS => {
			'Properties' => 339,
			'Constant' => 338
		}
	},
	{#State 267
		DEFAULT => -69
	},
	{#State 268
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP08_STRING_CAT' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			"}" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => -99,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			";" => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP04_MATH_POW' => -99,
			'OP06_REGEX_BIND' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99
		}
	},
	{#State 269
		ACTIONS => {
			";" => 340
		}
	},
	{#State 270
		ACTIONS => {
			";" => 341
		}
	},
	{#State 271
		ACTIONS => {
			"\$TYPED_" => 342
		}
	},
	{#State 272
		ACTIONS => {
			"}" => 343
		}
	},
	{#State 273
		DEFAULT => -219
	},
	{#State 274
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 344
		}
	},
	{#State 275
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 345,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 276
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'WORD' => 204,
			'TYPE_INTEGER' => 205
		},
		GOTOS => {
			'Type' => 346
		}
	},
	{#State 277
		ACTIONS => {
			'TYPE_INTEGER' => 347
		}
	},
	{#State 278
		ACTIONS => {
			'TYPE_INTEGER' => 348
		}
	},
	{#State 279
		DEFAULT => -108
	},
	{#State 280
		DEFAULT => -216
	},
	{#State 281
		ACTIONS => {
			'OP21_LIST_COMMA' => 350,
			"]" => -209,
			")" => -209,
			";" => -209
		},
		GOTOS => {
			'PAREN-52' => 349
		}
	},
	{#State 282
		ACTIONS => {
			";" => -211,
			")" => -211,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP21_LIST_COMMA' => -211,
			"]" => -211,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => 253,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 283
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			")" => -145,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			'MY' => 164,
			"undef" => 126,
			'OP01_QW' => 181,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117
		},
		GOTOS => {
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 184,
			'ArrayDereference' => 144,
			'ListElements' => 351,
			'OPTIONAL-42' => 352,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'ListElement' => 182,
			'TypeInner' => 185,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 284
		DEFAULT => -204
	},
	{#State 285
		DEFAULT => -164
	},
	{#State 286
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP18_TERNARY' => 253,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			")" => -163,
			";" => -163,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258
		}
	},
	{#State 287
		DEFAULT => -165
	},
	{#State 288
		ACTIONS => {
			";" => -205,
			")" => -205,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => 244,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245
		}
	},
	{#State 289
		ACTIONS => {
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP01_QW' => 181,
			"undef" => 126,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'TypeInner' => 185,
			'ListElement' => 182,
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'ListElements' => 353,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 184,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122
		}
	},
	{#State 290
		DEFAULT => -162
	},
	{#State 291
		ACTIONS => {
			'OP21_LIST_COMMA' => 354
		}
	},
	{#State 292
		ACTIONS => {
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'ARGV' => 183,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 181,
			"undef" => 126,
			'MY' => 164,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123
		},
		GOTOS => {
			'SubExpression' => 184,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'ArrayDereference' => 144,
			'ListElements' => 355,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'ListElement' => 182,
			'TypeInner' => 185,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 293
		DEFAULT => -125
	},
	{#State 294
		ACTIONS => {
			"}" => 356
		}
	},
	{#State 295
		DEFAULT => -234
	},
	{#State 296
		ACTIONS => {
			";" => 357
		}
	},
	{#State 297
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358,
			";" => 360,
			'OP02_ARRAY_THINARROW' => 359
		}
	},
	{#State 298
		ACTIONS => {
			";" => 361
		}
	},
	{#State 299
		DEFAULT => -194
	},
	{#State 300
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'SubExpression' => 362,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144
		}
	},
	{#State 301
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 363,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 364,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 302
		ACTIONS => {
			")" => 365
		}
	},
	{#State 303
		DEFAULT => -142
	},
	{#State 304
		DEFAULT => -146
	},
	{#State 305
		ACTIONS => {
			")" => 366
		}
	},
	{#State 306
		DEFAULT => -141
	},
	{#State 307
		ACTIONS => {
			'FHREF_SYMBOL' => 367
		}
	},
	{#State 308
		ACTIONS => {
			")" => 368,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 309
		DEFAULT => -138
	},
	{#State 310
		DEFAULT => -149
	},
	{#State 311
		ACTIONS => {
			'WORD_SCOPED' => -222,
			'CONSTANT_CALL_SCOPED' => -222,
			'MY' => 164,
			"undef" => -222,
			'OP01_NAMED' => -222,
			'WORD' => -222,
			'OP10_NAMED_UNARY' => -222,
			"\@{" => -222,
			'OP22_LOGICAL_NEG_LPAREN' => -222,
			"%{" => -222,
			'LBRACE' => -222,
			'OP05_MATH_NEG_LPAREN' => -222,
			'OP05_BITWISE_NEG_LPAREN' => -222,
			'OP01_CLOSE' => -222,
			'WORD_UPPERCASE' => -222,
			'LBRACKET' => -222,
			'OP22_LOGICAL_NEG' => -222,
			'OP05_LOGICAL_NEG' => -222,
			'LITERAL_STRING' => -222,
			'LPAREN' => -222,
			'VARIABLE_SYMBOL' => -222,
			'SELF' => -222,
			'OP03_MATH_INC_DEC' => -222,
			'LITERAL_NUMBER' => -222,
			'OP01_OPEN' => -222
		},
		GOTOS => {
			'TypeInner' => 370,
			'OPTIONAL-56' => 369
		}
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 372,
			"}" => 373
		},
		GOTOS => {
			'PAREN-57' => 371
		}
	},
	{#State 313
		DEFAULT => -106
	},
	{#State 314
		ACTIONS => {
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => -111,
			")" => -111,
			";" => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP18_TERNARY' => -111,
			'OP08_STRING_CAT' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			"}" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP14_BITWISE_OR_XOR' => -111
		}
	},
	{#State 315
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP23_LOGICAL_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			"}" => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => -127,
			";" => -127,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP21_LIST_COMMA' => -127,
			"]" => -127
		}
	},
	{#State 316
		ACTIONS => {
			'OP18_TERNARY' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"}" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP08_STRING_CAT' => -113,
			'OP15_LOGICAL_AND' => -113,
			";" => -113,
			")" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP07_STRING_REPEAT' => 259,
			'OP21_LIST_COMMA' => -113,
			"]" => -113,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP17_LIST_RANGE' => -113,
			'OP12_COMPARE_EQ_NE' => -113
		}
	},
	{#State 317
		ACTIONS => {
			'OP18_TERNARY' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP09_BITWISE_SHIFT' => 254,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			"}" => -120,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			";" => -120,
			")" => -120,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP17_LIST_RANGE' => -120,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP21_LIST_COMMA' => -120,
			"]" => -120
		}
	},
	{#State 318
		ACTIONS => {
			")" => -128,
			";" => -128,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			"]" => -128,
			'OP21_LIST_COMMA' => -128,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			"}" => -128,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP23_LOGICAL_AND' => 244,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 243
		}
	},
	{#State 319
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP14_BITWISE_OR_XOR' => 246,
			"}" => -122,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => -122,
			"]" => -122,
			'OP21_LIST_COMMA' => -122,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => -122,
			";" => -122,
			")" => -122,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259
		}
	},
	{#State 320
		ACTIONS => {
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NE' => -105,
			";" => -105,
			")" => -105,
			'OP13_BITWISE_AND' => -105,
			'OP07_STRING_REPEAT' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => -105,
			'OP18_TERNARY' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP09_BITWISE_SHIFT' => -105
		}
	},
	{#State 321
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			"}" => -118,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP18_TERNARY' => -118,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => -118,
			"]" => -118,
			'OP21_LIST_COMMA' => -118,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP17_LIST_RANGE' => -118,
			'OP12_COMPARE_EQ_NE' => undef,
			";" => -118,
			")" => -118,
			'OP13_BITWISE_AND' => -118,
			'OP07_STRING_REPEAT' => 259
		}
	},
	{#State 322
		ACTIONS => {
			'OP23_LOGICAL_AND' => -121,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			"}" => -121,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP18_TERNARY' => -121,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => -121,
			'OP17_LIST_RANGE' => -121,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			"]" => -121,
			'OP21_LIST_COMMA' => -121,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => -121,
			";" => -121
		}
	},
	{#State 323
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 245,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			"}" => -117,
			'OP18_TERNARY' => -117,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => -117,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP17_LIST_RANGE' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			"]" => -117,
			'OP21_LIST_COMMA' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP07_STRING_REPEAT' => 259,
			";" => -117,
			")" => -117
		}
	},
	{#State 324
		DEFAULT => -246
	},
	{#State 325
		ACTIONS => {
			'COLON' => 374
		}
	},
	{#State 326
		DEFAULT => -247
	},
	{#State 327
		ACTIONS => {
			'OP18_TERNARY' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"}" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -114,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			";" => -114,
			")" => -114,
			'OP13_BITWISE_AND' => -114,
			'OP07_STRING_REPEAT' => 259,
			'OP21_LIST_COMMA' => -114,
			"]" => -114,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP17_LIST_RANGE' => -114,
			'OP12_COMPARE_EQ_NE' => -114
		}
	},
	{#State 328
		ACTIONS => {
			'OP18_TERNARY' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP08_STRING_CAT' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			"}" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP07_STRING_REPEAT' => 259,
			";" => -112,
			")" => -112,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => -112,
			'OP06_REGEX_BIND' => 256,
			'OP17_LIST_RANGE' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP21_LIST_COMMA' => -112,
			"]" => -112
		}
	},
	{#State 329
		DEFAULT => -109
	},
	{#State 330
		ACTIONS => {
			'OP18_TERNARY' => -123,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => -123,
			"}" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => -123,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			";" => -123,
			")" => -123,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP21_LIST_COMMA' => -123,
			"]" => -123,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 250
		}
	},
	{#State 331
		ACTIONS => {
			"}" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP18_TERNARY' => -119,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => -119,
			'OP21_LIST_COMMA' => -119,
			"]" => -119,
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			")" => -119,
			";" => -119,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => -119
		}
	},
	{#State 332
		ACTIONS => {
			'OP21_LIST_COMMA' => -110,
			"]" => -110,
			'OP17_LIST_RANGE' => -110,
			'OP12_COMPARE_EQ_NE' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			")" => -110,
			";" => -110,
			'OP07_STRING_REPEAT' => -110,
			'OP13_BITWISE_AND' => -110,
			"}" => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP08_STRING_CAT' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP07_MATH_MULT_DIV_MOD' => -110,
			'OP18_TERNARY' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP16_LOGICAL_OR' => -110
		}
	},
	{#State 333
		ACTIONS => {
			"\$RETURN_TYPE" => 375
		}
	},
	{#State 334
		DEFAULT => -55
	},
	{#State 335
		ACTIONS => {
			'WORD_UPPERCASE' => 376
		}
	},
	{#State 336
		DEFAULT => -54
	},
	{#State 337
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 338
		DEFAULT => -71
	},
	{#State 339
		DEFAULT => -74,
		GOTOS => {
			'STAR-31' => 378
		}
	},
	{#State 340
		DEFAULT => -134
	},
	{#State 341
		DEFAULT => -135
	},
	{#State 342
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 225,
			'OP22_LOGICAL_NEG' => 224,
			'OP08_MATH_ADD_SUB' => 238,
			'OP01_CLOSE' => 237,
			'OP01_NAMED_VOID' => 221,
			'OP07_STRING_REPEAT' => 240,
			'OP01_OPEN' => 228,
			'OP19_LOOP_CONTROL' => 226,
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP23_LOGICAL_AND' => 219,
			'OP11_COMPARE_LT_GT' => 232,
			'OP07_MATH_MULT_DIV_MOD' => 218,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_PRINT' => 235,
			'WORD' => 233,
			'OP01_NAMED' => 220,
			'OP10_NAMED_UNARY' => 234
		},
		GOTOS => {
			'OpStringOrWord' => 379
		}
	},
	{#State 343
		DEFAULT => -220
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 345
		ACTIONS => {
			'OP18_TERNARY' => 253,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			")" => 381,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250
		}
	},
	{#State 346
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 347
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 349
		DEFAULT => -207
	},
	{#State 350
		ACTIONS => {
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP01_QW' => 181,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'MY' => 164,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_UPPERCASE' => 156,
			'ARGV' => 183,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113
		},
		GOTOS => {
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'SubExpression' => 184,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'ListElement' => 385,
			'TypeInner' => 185,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 351
		DEFAULT => -144
	},
	{#State 352
		ACTIONS => {
			")" => 386
		}
	},
	{#State 353
		ACTIONS => {
			")" => 387
		}
	},
	{#State 354
		ACTIONS => {
			'ARGV' => 183,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'MY' => 164,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 181,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'TypeInner' => 185,
			'ListElement' => 182,
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'ListElements' => 388,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 184,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122
		}
	},
	{#State 355
		ACTIONS => {
			";" => 389
		}
	},
	{#State 356
		DEFAULT => -235
	},
	{#State 357
		DEFAULT => -137
	},
	{#State 358
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'STDIN' => 287,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP10_NAMED_UNARY_SCOLON' => 393,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_NAMED_SCOLON' => 391,
			"undef" => 126,
			'FHREF_SYMBOL_IN' => 285
		},
		GOTOS => {
			'OpNamedScolonOrSubExpIn' => 390,
			'Operator' => 104,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 286,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'SubExpressionOrInput' => 392
		}
	},
	{#State 359
		ACTIONS => {
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113
		},
		GOTOS => {
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 394,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 360
		DEFAULT => -200
	},
	{#State 361
		DEFAULT => -203
	},
	{#State 362
		ACTIONS => {
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			"]" => 395,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP18_TERNARY' => 253,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 244,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 243
		}
	},
	{#State 363
		ACTIONS => {
			"}" => 396,
			'OP02_METHOD_THINARROW_NEW' => -236,
			'LPAREN' => -236
		}
	},
	{#State 364
		ACTIONS => {
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP23_LOGICAL_AND' => 244,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			"}" => 397,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247
		}
	},
	{#State 365
		DEFAULT => -151
	},
	{#State 366
		DEFAULT => -153
	},
	{#State 367
		ACTIONS => {
			'OP21_LIST_COMMA' => 398
		}
	},
	{#State 368
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'LBRACE' => 140,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108,
			'SubExpression' => 401,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144
		}
	},
	{#State 370
		DEFAULT => -221
	},
	{#State 371
		DEFAULT => -228
	},
	{#State 372
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 218,
			'OP11_COMPARE_LT_GT' => 232,
			'OP23_LOGICAL_AND' => 219,
			'OP24_LOGICAL_OR_XOR' => 216,
			"%{" => 118,
			'OP01_PRINT' => 235,
			'OP10_NAMED_UNARY' => 234,
			'WORD' => 233,
			'OP01_NAMED' => 220,
			'OP08_MATH_ADD_SUB' => 238,
			'LITERAL_STRING' => 147,
			'OP12_COMPARE_EQ_NE' => 225,
			'OP22_LOGICAL_NEG' => 224,
			'OP01_NAMED_VOID' => 221,
			'OP01_CLOSE' => 237,
			'ENV' => 222,
			'OP01_OPEN' => 228,
			'LITERAL_NUMBER' => 135,
			'OP07_STRING_REPEAT' => 240,
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP19_LOOP_CONTROL' => 226,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 239,
			'VariableSymbolOrSelf' => 125,
			'OpStringOrWord' => 229,
			'VarOrLitOrOpStrOrWord' => 223,
			'HashDereference' => 236,
			'HashEntry' => 402,
			'Literal' => 217
		}
	},
	{#State 373
		DEFAULT => -230
	},
	{#State 374
		ACTIONS => {
			'LITERAL_STRING' => 147,
			'LITERAL_NUMBER' => 135,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'Literal' => 326,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 324,
			'VariableOrLiteral' => 403
		}
	},
	{#State 375
		ACTIONS => {
			"}" => 404
		}
	},
	{#State 376
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 405
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACE' => 406
		}
	},
	{#State 378
		ACTIONS => {
			'SUB' => 407,
			'LITERAL_NUMBER' => 408
		},
		GOTOS => {
			'SubroutineOrMethod' => 410,
			'Method' => 409,
			'Subroutine' => 411
		}
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 381
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 414
		}
	},
	{#State 382
		ACTIONS => {
			'LPAREN' => 415
		}
	},
	{#State 383
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 384
		ACTIONS => {
			'LPAREN' => 417
		}
	},
	{#State 385
		DEFAULT => -206
	},
	{#State 386
		DEFAULT => -152
	},
	{#State 387
		DEFAULT => -98
	},
	{#State 388
		ACTIONS => {
			")" => 418
		}
	},
	{#State 389
		DEFAULT => -139
	},
	{#State 390
		DEFAULT => -201
	},
	{#State 391
		DEFAULT => -258
	},
	{#State 392
		ACTIONS => {
			";" => 419
		}
	},
	{#State 393
		DEFAULT => -259
	},
	{#State 394
		ACTIONS => {
			"]" => 420,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP06_REGEX_BIND' => 256,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 244,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254
		}
	},
	{#State 395
		DEFAULT => -197
	},
	{#State 396
		DEFAULT => -199
	},
	{#State 397
		DEFAULT => -198
	},
	{#State 398
		ACTIONS => {
			'LITERAL_STRING' => 421
		}
	},
	{#State 399
		ACTIONS => {
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP01_NAMED' => 116,
			"undef" => 126,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'MY' => 121,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'OP19_LOOP_CONTROL' => 129,
			'SELF' => 132,
			"foreach" => -170,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"for" => -170,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'WORD_UPPERCASE' => 139,
			"if" => 137,
			'OP01_NAMED_VOID' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'OP01_PRINT' => 98,
			"while" => -170,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED_SCOLON' => 100,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110
		},
		GOTOS => {
			'Statement' => 102,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Operation' => 422,
			'Literal' => 122,
			'ArrayReference' => 120,
			'PLUS-50' => 423,
			'LoopLabel' => 95,
			'Conditional' => 112,
			'SubExpression' => 145,
			'Variable' => 114,
			'VariableModification' => 143,
			'ArrayDereference' => 144,
			'OPTIONAL-45' => 109,
			'PAREN-44' => 107,
			'Expression' => 136,
			'HashDereference' => 108,
			'OperatorVoid' => 134,
			'VariableDeclaration' => 106,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 400
		DEFAULT => -178,
		GOTOS => {
			'STAR-47' => 424
		}
	},
	{#State 401
		ACTIONS => {
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP21_LIST_COMMA' => -223,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP23_LOGICAL_AND' => 244,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			"}" => -223
		}
	},
	{#State 402
		DEFAULT => -227
	},
	{#State 403
		DEFAULT => -124
	},
	{#State 404
		ACTIONS => {
			";" => 425
		}
	},
	{#State 405
		DEFAULT => -245
	},
	{#State 406
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 224,
			'OP12_COMPARE_EQ_NE' => 225,
			'OP08_MATH_ADD_SUB' => 238,
			'OP01_CLOSE' => 237,
			'OP01_NAMED_VOID' => 221,
			'OP07_STRING_REPEAT' => 240,
			'OP01_OPEN' => 228,
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP19_LOOP_CONTROL' => 226,
			'OP11_COMPARE_LT_GT' => 232,
			'OP23_LOGICAL_AND' => 219,
			'OP07_MATH_MULT_DIV_MOD' => 218,
			"}" => 426,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_PRINT' => 235,
			'OP10_NAMED_UNARY' => 234,
			'WORD' => 233,
			'OP01_NAMED' => 220
		},
		GOTOS => {
			'OpStringOrWord' => 428,
			'HashEntryProperties' => 427
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 429
		}
	},
	{#State 408
		ACTIONS => {
			";" => 430
		}
	},
	{#State 409
		DEFAULT => -93
	},
	{#State 410
		DEFAULT => -73
	},
	{#State 411
		DEFAULT => -92
	},
	{#State 412
		DEFAULT => -242
	},
	{#State 413
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'STDIN' => 287,
			'LBRACE' => 140,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACKET' => 113,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"undef" => 126,
			'FHREF_SYMBOL_IN' => 285,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 286,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'Expression' => 157,
			'SubExpressionOrInput' => 431,
			'ArrayReference' => 120,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 414
		DEFAULT => -189
	},
	{#State 415
		ACTIONS => {
			'OP01_QW' => 181,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'MY' => 164,
			"undef" => 126,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'ARGV' => 183,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'ListElements' => 432,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'WordScoped' => 127,
			'SubExpression' => 184,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'TypeInner' => 185,
			'ListElement' => 182,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 416
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			"undef" => 126,
			'OP01_NAMED_SCOLON' => 433,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP10_NAMED_UNARY_SCOLON' => 435,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Variable' => 159,
			'SubExpression' => 436,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'OpNamedScolonOrSubExp' => 434,
			'HashReference' => 130
		}
	},
	{#State 417
		ACTIONS => {
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'SubExpression' => 437,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 418
		DEFAULT => -100
	},
	{#State 419
		DEFAULT => -260
	},
	{#State 420
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 438
		}
	},
	{#State 421
		ACTIONS => {
			'OP21_LIST_COMMA' => 439
		}
	},
	{#State 422
		DEFAULT => -192
	},
	{#State 423
		ACTIONS => {
			"undef" => 126,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'MY' => 121,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'OP01_NAMED' => 116,
			"for" => -170,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'OP01_NAMED_VOID' => 138,
			"if" => 137,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP19_LOOP_CONTROL' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'SELF' => 132,
			"foreach" => -170,
			'OP01_NAMED_SCOLON' => 100,
			"}" => 440,
			'WORD_SCOPED' => 32,
			"while" => -170,
			'OP01_PRINT' => 98,
			"\@{" => 99,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Operation' => 441,
			'Literal' => 122,
			'ArrayReference' => 120,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Statement' => 102,
			'LoopLabel' => 95,
			'OPTIONAL-45' => 109,
			'HashDereference' => 108,
			'PAREN-44' => 107,
			'Expression' => 136,
			'Variable' => 114,
			'SubExpression' => 145,
			'Conditional' => 112,
			'VariableModification' => 143,
			'ArrayDereference' => 144,
			'Operator' => 104,
			'HashReference' => 130,
			'VariableDeclaration' => 106,
			'OperatorVoid' => 134
		}
	},
	{#State 424
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -181,
			"}" => -181,
			'WORD_SCOPED' => -181,
			'OP10_NAMED_UNARY' => -181,
			'WORD' => -181,
			'OP01_PRINT' => -181,
			"while" => -181,
			"\@{" => -181,
			"elsif" => 442,
			'OP01_CLOSE' => -181,
			'OP05_MATH_NEG_LPAREN' => -181,
			'LPAREN' => -181,
			'LBRACKET' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'VARIABLE_SYMBOL' => -181,
			'MY' => -181,
			'OP01_NAMED_VOID_LPAREN' => -181,
			'CONSTANT_CALL_SCOPED' => -181,
			"undef" => -181,
			'OP01_NAMED_VOID_SCOLON' => -181,
			'OP01_NAMED' => -181,
			"%{" => -181,
			'OP22_LOGICAL_NEG_LPAREN' => -181,
			'OP01_NAMED_VOID' => -181,
			"if" => -181,
			'WORD_UPPERCASE' => -181,
			'OP05_BITWISE_NEG_LPAREN' => -181,
			'LBRACE' => -181,
			'OP10_NAMED_UNARY_SCOLON' => -181,
			"for" => -181,
			'OP22_LOGICAL_NEG' => -181,
			'OP05_LOGICAL_NEG' => -181,
			'LITERAL_STRING' => -181,
			"else" => 445,
			'' => -181,
			'OP19_LOOP_CONTROL_SCOLON' => -181,
			'OP19_LOOP_CONTROL' => -181,
			'SELF' => -181,
			"foreach" => -181,
			'OP01_OPEN' => -181,
			'LITERAL_NUMBER' => -181
		},
		GOTOS => {
			'OPTIONAL-49' => 443,
			'PAREN-46' => 444,
			'PAREN-48' => 446
		}
	},
	{#State 425
		ACTIONS => {
			'OP01_NAMED' => -57,
			'OP22_LOGICAL_NEG_LPAREN' => -57,
			"%{" => -57,
			'OP01_NAMED_VOID_LPAREN' => -57,
			'MY' => -57,
			'CONSTANT_CALL_SCOPED' => -57,
			'OP01_NAMED_VOID_SCOLON' => -57,
			"undef" => -57,
			'OP19_LOOP_CONTROL' => -57,
			'OP19_LOOP_CONTROL_SCOLON' => -57,
			'SELF' => -57,
			"foreach" => -57,
			'OP01_OPEN' => -57,
			'LITERAL_NUMBER' => -57,
			'OP01_NAMED_VOID' => -57,
			"if" => -57,
			'WORD_UPPERCASE' => -57,
			'LBRACE' => -57,
			'OP05_BITWISE_NEG_LPAREN' => -57,
			"for" => -57,
			'OP10_NAMED_UNARY_SCOLON' => -57,
			'OP22_LOGICAL_NEG' => -57,
			'OP05_LOGICAL_NEG' => -57,
			'LITERAL_STRING' => -57,
			'WORD' => -57,
			'OP10_NAMED_UNARY' => -57,
			'OP01_PRINT' => -57,
			"while" => -57,
			"\@{" => -57,
			'OP01_NAMED_SCOLON' => -57,
			'LPAREN_MY' => 448,
			"}" => -57,
			'WORD_SCOPED' => -57,
			'OP03_MATH_INC_DEC' => -57,
			'VARIABLE_SYMBOL' => -57,
			'OP01_CLOSE' => -57,
			'OP05_MATH_NEG_LPAREN' => -57,
			'LBRACKET' => -57,
			'LPAREN' => -57
		},
		GOTOS => {
			'OPTIONAL-23' => 449,
			'SubroutineArguments' => 447
		}
	},
	{#State 426
		ACTIONS => {
			";" => 450
		}
	},
	{#State 427
		DEFAULT => -80,
		GOTOS => {
			'STAR-33' => 451
		}
	},
	{#State 428
		ACTIONS => {
			'OP20_HASH_FATARROW' => 452
		}
	},
	{#State 429
		ACTIONS => {
			'LBRACE' => 453
		}
	},
	{#State 430
		DEFAULT => -75
	},
	{#State 431
		ACTIONS => {
			")" => 454
		}
	},
	{#State 432
		ACTIONS => {
			")" => 455
		}
	},
	{#State 433
		DEFAULT => -255
	},
	{#State 434
		ACTIONS => {
			'VARIABLE_SYMBOL' => 456
		}
	},
	{#State 435
		DEFAULT => -256
	},
	{#State 436
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => 244,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			";" => 457,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259
		}
	},
	{#State 437
		ACTIONS => {
			'OP18_TERNARY' => 253,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 244,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP17_LIST_RANGE' => 458,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256
		}
	},
	{#State 438
		ACTIONS => {
			"undef" => 459
		}
	},
	{#State 439
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 460,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157
		}
	},
	{#State 440
		DEFAULT => -193
	},
	{#State 441
		DEFAULT => -191
	},
	{#State 442
		ACTIONS => {
			'LPAREN' => 461
		}
	},
	{#State 443
		DEFAULT => -182
	},
	{#State 444
		DEFAULT => -177
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 446
		DEFAULT => -180
	},
	{#State 447
		DEFAULT => -56
	},
	{#State 448
		ACTIONS => {
			'WORD' => 204,
			'TYPE_INTEGER' => 205,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 463
		}
	},
	{#State 449
		DEFAULT => -59,
		GOTOS => {
			'STAR-24' => 464
		}
	},
	{#State 450
		DEFAULT => -82
	},
	{#State 451
		ACTIONS => {
			"}" => 465,
			'OP21_LIST_COMMA' => 467
		},
		GOTOS => {
			'PAREN-32' => 466
		}
	},
	{#State 452
		ACTIONS => {
			'MY' => 469
		},
		GOTOS => {
			'TypeInnerProperties' => 468
		}
	},
	{#State 453
		ACTIONS => {
			'LBRACE' => 470
		}
	},
	{#State 454
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 471
		}
	},
	{#State 455
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 456
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 473
		}
	},
	{#State 457
		DEFAULT => -257
	},
	{#State 458
		ACTIONS => {
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_STRING' => 147,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'WORD_UPPERCASE' => 156,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'VariableSymbolOrSelf' => 125,
			'WordScoped' => 127,
			'Variable' => 159,
			'SubExpression' => 474,
			'HashReference' => 130,
			'Operator' => 104
		}
	},
	{#State 459
		ACTIONS => {
			";" => 475
		}
	},
	{#State 460
		ACTIONS => {
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => 253,
			'OP11_COMPARE_LT_GT' => 252,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			"}" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => -101,
			";" => -101,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP21_LIST_COMMA' => -101,
			"]" => -101
		}
	},
	{#State 461
		ACTIONS => {
			"undef" => 126,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			"\@{" => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			'OP10_NAMED_UNARY' => 96,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 476,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Operator' => 104,
			'HashReference' => 130
		}
	},
	{#State 462
		DEFAULT => -179
	},
	{#State 463
		ACTIONS => {
			'VARIABLE_SYMBOL' => 477
		}
	},
	{#State 464
		ACTIONS => {
			"while" => -170,
			'OP01_PRINT' => 98,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED_SCOLON' => 100,
			'WORD_SCOPED' => 32,
			"}" => 478,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'LPAREN' => 115,
			'LBRACKET' => 113,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP01_NAMED' => 116,
			"undef" => 126,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'MY' => 121,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'OP19_LOOP_CONTROL' => 129,
			'SELF' => 132,
			"foreach" => -170,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"for" => -170,
			'OP05_LOGICAL_NEG' => 148,
			'OP22_LOGICAL_NEG' => 146,
			'LITERAL_STRING' => 147,
			"if" => 137,
			'WORD_UPPERCASE' => 139,
			'OP01_NAMED_VOID' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140
		},
		GOTOS => {
			'OperatorVoid' => 134,
			'VariableDeclaration' => 106,
			'HashReference' => 130,
			'Operator' => 104,
			'ArrayDereference' => 144,
			'VariableModification' => 143,
			'Conditional' => 112,
			'SubExpression' => 145,
			'Variable' => 114,
			'PAREN-44' => 107,
			'Expression' => 136,
			'HashDereference' => 108,
			'OPTIONAL-45' => 109,
			'LoopLabel' => 95,
			'Statement' => 102,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'ArrayReference' => 120,
			'Literal' => 122,
			'Operation' => 479
		}
	},
	{#State 465
		ACTIONS => {
			";" => 480
		}
	},
	{#State 466
		DEFAULT => -79
	},
	{#State 467
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP19_LOOP_CONTROL' => 226,
			'OP07_STRING_REPEAT' => 240,
			'OP01_OPEN' => 228,
			'OP01_CLOSE' => 237,
			'OP01_NAMED_VOID' => 221,
			'OP22_LOGICAL_NEG' => 224,
			'OP12_COMPARE_EQ_NE' => 225,
			'OP08_MATH_ADD_SUB' => 238,
			'OP10_NAMED_UNARY' => 234,
			'WORD' => 233,
			'OP01_NAMED' => 220,
			'OP01_PRINT' => 235,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP11_COMPARE_LT_GT' => 232,
			'OP23_LOGICAL_AND' => 219,
			'OP07_MATH_MULT_DIV_MOD' => 218
		},
		GOTOS => {
			'OpStringOrWord' => 428,
			'HashEntryProperties' => 481
		}
	},
	{#State 468
		DEFAULT => -226
	},
	{#State 469
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 482
		}
	},
	{#State 470
		ACTIONS => {
			'MY' => 483
		}
	},
	{#State 471
		DEFAULT => -190
	},
	{#State 472
		DEFAULT => -188
	},
	{#State 473
		ACTIONS => {
			"undef" => 126,
			'OP01_NAMED_SCOLON' => 433,
			'WORD_SCOPED' => 32,
			'CONSTANT_CALL_SCOPED' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			"\@{" => 99,
			'OP01_NAMED' => 155,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP10_NAMED_UNARY_SCOLON' => 435,
			'LBRACKET' => 113,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 140,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 111,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'SELF' => 132
		},
		GOTOS => {
			'ArrayDereference' => 144,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 436,
			'HashDereference' => 108,
			'ArrayReference' => 120,
			'Expression' => 157,
			'Literal' => 122,
			'HashReference' => 130,
			'OpNamedScolonOrSubExp' => 484,
			'Operator' => 104
		}
	},
	{#State 474
		ACTIONS => {
			'OP18_TERNARY' => -123,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP15_LOGICAL_AND' => 251,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			")" => 485,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256
		}
	},
	{#State 475
		DEFAULT => -202
	},
	{#State 476
		ACTIONS => {
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			")" => 486,
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			'OP18_TERNARY' => 253,
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247
		}
	},
	{#State 477
		DEFAULT => -63,
		GOTOS => {
			'STAR-26' => 487
		}
	},
	{#State 478
		DEFAULT => -60
	},
	{#State 479
		DEFAULT => -58
	},
	{#State 480
		DEFAULT => -81
	},
	{#State 481
		DEFAULT => -78
	},
	{#State 482
		ACTIONS => {
			"\$TYPED_" => 488
		}
	},
	{#State 483
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'TYPE_METHOD' => 489,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 484
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LBRACE' => 140,
			'OP05_LOGICAL_NEG' => 148,
			'LPAREN' => 115,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'LBRACKET' => 113,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126
		},
		GOTOS => {
			'SubExpressionOrVarMod' => 492,
			'Operator' => 104,
			'HashReference' => 130,
			'SubExpression' => 491,
			'Variable' => 114,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144,
			'VariableModification' => 490,
			'Literal' => 122,
			'ArrayReference' => 120,
			'Expression' => 157,
			'HashDereference' => 108
		}
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 493
		}
	},
	{#State 486
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 494
		}
	},
	{#State 487
		ACTIONS => {
			'OP21_LIST_COMMA' => 495,
			")" => 496
		},
		GOTOS => {
			'PAREN-25' => 497
		}
	},
	{#State 488
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 225,
			'OP22_LOGICAL_NEG' => 224,
			'OP08_MATH_ADD_SUB' => 238,
			'OP01_CLOSE' => 237,
			'OP01_NAMED_VOID' => 221,
			'OP07_STRING_REPEAT' => 240,
			'OP01_OPEN' => 228,
			'OP19_LOOP_CONTROL' => 226,
			'OP19_LOOP_CONTROL_SCOLON' => 227,
			'OP23_LOGICAL_AND' => 219,
			'OP11_COMPARE_LT_GT' => 232,
			'OP07_MATH_MULT_DIV_MOD' => 218,
			'OP24_LOGICAL_OR_XOR' => 216,
			'OP01_PRINT' => 235,
			'WORD' => 233,
			'OP01_NAMED' => 220,
			'OP10_NAMED_UNARY' => 234
		},
		GOTOS => {
			'OpStringOrWord' => 498
		}
	},
	{#State 489
		ACTIONS => {
			"\$RETURN_TYPE" => 499
		}
	},
	{#State 490
		DEFAULT => -167
	},
	{#State 491
		ACTIONS => {
			")" => -166,
			'OP13_BITWISE_AND' => 258,
			'OP07_STRING_REPEAT' => 259,
			'OP04_MATH_POW' => 249,
			'OP08_MATH_ADD_SUB' => 255,
			'OP06_REGEX_BIND' => 256,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254,
			'OP18_TERNARY' => 253,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP08_STRING_CAT' => 245,
			'OP11_COMPARE_LT_GT' => 252,
			'OP15_LOGICAL_AND' => 251,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 492
		ACTIONS => {
			")" => 500
		}
	},
	{#State 493
		DEFAULT => -186
	},
	{#State 494
		DEFAULT => -176
	},
	{#State 495
		ACTIONS => {
			'MY' => 501
		}
	},
	{#State 496
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 502
		}
	},
	{#State 497
		DEFAULT => -62
	},
	{#State 498
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 503,
			'OP02_ARRAY_THINARROW' => 504
		}
	},
	{#State 499
		ACTIONS => {
			"}" => 505
		}
	},
	{#State 500
		ACTIONS => {
			'LBRACE' => 399
		},
		GOTOS => {
			'CodeBlock' => 506
		}
	},
	{#State 501
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 507
		}
	},
	{#State 502
		ACTIONS => {
			"\@ARG;" => 508
		}
	},
	{#State 503
		ACTIONS => {
			'LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'LBRACKET' => 113,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'LBRACE' => 140,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 135,
			'OP01_OPEN' => 133,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 103,
			"undef" => 126,
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"\@{" => 99,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED' => 155,
			'WORD' => 34
		},
		GOTOS => {
			'HashReference' => 130,
			'Operator' => 104,
			'HashDereference' => 108,
			'Expression' => 157,
			'ArrayReference' => 120,
			'Literal' => 122,
			'ArrayDereference' => 144,
			'Variable' => 159,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'SubExpression' => 509
		}
	},
	{#State 504
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 123,
			'WORD_SCOPED' => 32,
			"undef" => 126,
			'OP10_NAMED_UNARY' => 96,
			'WORD' => 34,
			'OP01_NAMED' => 155,
			"%{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"\@{" => 99,
			'WORD_UPPERCASE' => 156,
			'OP01_CLOSE' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 140,
			'LITERAL_STRING' => 147,
			'OP22_LOGICAL_NEG' => 146,
			'LPAREN' => 115,
			'OP05_LOGICAL_NEG' => 148,
			'LBRACKET' => 113,
			'OP03_MATH_INC_DEC' => 103,
			'SELF' => 132,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135
		},
		GOTOS => {
			'Operator' => 104,
			'HashReference' => 130,
			'SubExpression' => 510,
			'WordScoped' => 127,
			'Variable' => 159,
			'VariableSymbolOrSelf' => 125,
			'ArrayDereference' => 144,
			'Literal' => 122,
			'Expression' => 157,
			'ArrayReference' => 120,
			'HashDereference' => 108
		}
	},
	{#State 505
		ACTIONS => {
			";" => 511
		}
	},
	{#State 506
		DEFAULT => -187
	},
	{#State 507
		ACTIONS => {
			'VARIABLE_SYMBOL' => 512
		}
	},
	{#State 508
		DEFAULT => -64
	},
	{#State 509
		ACTIONS => {
			'OP17_LIST_RANGE' => 257,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP06_REGEX_BIND' => 256,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP21_LIST_COMMA' => -243,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP23_LOGICAL_AND' => 244,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			"}" => -243,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP18_TERNARY' => 253,
			'OP16_LOGICAL_OR' => 248,
			'OP09_BITWISE_SHIFT' => 254
		}
	},
	{#State 510
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 254,
			'OP16_LOGICAL_OR' => 248,
			'OP18_TERNARY' => 253,
			'OP08_STRING_CAT' => 245,
			'OP15_LOGICAL_AND' => 251,
			'OP11_COMPARE_LT_GT' => 252,
			'OP23_LOGICAL_AND' => 244,
			'OP07_MATH_MULT_DIV_MOD' => 243,
			'OP24_LOGICAL_OR_XOR' => 247,
			'OP14_BITWISE_OR_XOR' => 246,
			'OP07_STRING_REPEAT' => 259,
			'OP13_BITWISE_AND' => 258,
			'OP12_COMPARE_EQ_NE' => 250,
			'OP17_LIST_RANGE' => 257,
			'OP08_MATH_ADD_SUB' => 255,
			'OP04_MATH_POW' => 249,
			'OP06_REGEX_BIND' => 256,
			"]" => 513
		}
	},
	{#State 511
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -84,
			'WORD_SCOPED' => -84,
			'LPAREN_MY' => 514,
			"}" => -84,
			'WORD' => -84,
			'OP10_NAMED_UNARY' => -84,
			'OP01_PRINT' => -84,
			"while" => -84,
			"\@{" => -84,
			'OP05_MATH_NEG_LPAREN' => -84,
			'OP01_CLOSE' => -84,
			'LBRACKET' => -84,
			'LPAREN' => -84,
			'OP03_MATH_INC_DEC' => -84,
			'VARIABLE_SYMBOL' => -84,
			'OP01_NAMED_VOID_LPAREN' => -84,
			'MY' => -84,
			'CONSTANT_CALL_SCOPED' => -84,
			"undef" => -84,
			'OP01_NAMED_VOID_SCOLON' => -84,
			'OP01_NAMED' => -84,
			'OP22_LOGICAL_NEG_LPAREN' => -84,
			"%{" => -84,
			"if" => -84,
			'WORD_UPPERCASE' => -84,
			'OP01_NAMED_VOID' => -84,
			'LBRACE' => -84,
			'OP05_BITWISE_NEG_LPAREN' => -84,
			"for" => -84,
			'OP10_NAMED_UNARY_SCOLON' => -84,
			'OP22_LOGICAL_NEG' => -84,
			'LITERAL_STRING' => -84,
			'OP05_LOGICAL_NEG' => -84,
			'OP19_LOOP_CONTROL' => -84,
			'OP19_LOOP_CONTROL_SCOLON' => -84,
			'SELF' => -84,
			"foreach" => -84,
			'OP01_OPEN' => -84,
			'LITERAL_NUMBER' => -84
		},
		GOTOS => {
			'OPTIONAL-34' => 516,
			'MethodArguments' => 515
		}
	},
	{#State 512
		DEFAULT => -61
	},
	{#State 513
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 517
		}
	},
	{#State 514
		ACTIONS => {
			'TYPE_INTEGER' => 205,
			'WORD' => 204,
			'WORD_SCOPED' => 202
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 515
		DEFAULT => -83
	},
	{#State 516
		DEFAULT => -86,
		GOTOS => {
			'STAR-35' => 519
		}
	},
	{#State 517
		ACTIONS => {
			"undef" => 520
		}
	},
	{#State 518
		ACTIONS => {
			'SELF' => 521
		}
	},
	{#State 519
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 105,
			'LBRACKET' => 113,
			'LPAREN' => 115,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 111,
			'OP01_PRINT' => 98,
			"while" => -170,
			"\@{" => 99,
			'WORD' => 34,
			'OP10_NAMED_UNARY' => 96,
			'OP01_NAMED_SCOLON' => 100,
			'WORD_SCOPED' => 32,
			"}" => 523,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 135,
			'OP19_LOOP_CONTROL' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 131,
			'SELF' => 132,
			"foreach" => -170,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"for" => -170,
			'OP22_LOGICAL_NEG' => 146,
			'OP05_LOGICAL_NEG' => 148,
			'LITERAL_STRING' => 147,
			'WORD_UPPERCASE' => 139,
			"if" => 137,
			'OP01_NAMED_VOID' => 138,
			'LBRACE' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 117,
			"%{" => 118,
			'OP01_NAMED' => 116,
			"undef" => 126,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP01_NAMED_VOID_LPAREN' => 119,
			'MY' => 121,
			'CONSTANT_CALL_SCOPED' => 123
		},
		GOTOS => {
			'LoopLabel' => 95,
			'ArrayReference' => 120,
			'Operation' => 522,
			'Literal' => 122,
			'WordScoped' => 127,
			'VariableSymbolOrSelf' => 125,
			'Statement' => 102,
			'HashReference' => 130,
			'Operator' => 104,
			'VariableDeclaration' => 106,
			'OperatorVoid' => 134,
			'HashDereference' => 108,
			'PAREN-44' => 107,
			'Expression' => 136,
			'OPTIONAL-45' => 109,
			'ArrayDereference' => 144,
			'VariableModification' => 143,
			'Variable' => 114,
			'SubExpression' => 145,
			'Conditional' => 112
		}
	},
	{#State 520
		DEFAULT => -244
	},
	{#State 521
		DEFAULT => -90,
		GOTOS => {
			'STAR-37' => 524
		}
	},
	{#State 522
		DEFAULT => -85
	},
	{#State 523
		DEFAULT => -87
	},
	{#State 524
		ACTIONS => {
			'OP21_LIST_COMMA' => 526,
			")" => 527
		},
		GOTOS => {
			'PAREN-36' => 525
		}
	},
	{#State 525
		DEFAULT => -89
	},
	{#State 526
		ACTIONS => {
			'MY' => 528
		}
	},
	{#State 527
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 529
		}
	},
	{#State 528
		ACTIONS => {
			'WORD_SCOPED' => 202,
			'TYPE_INTEGER' => 205,
			'WORD' => 204
		},
		GOTOS => {
			'Type' => 530
		}
	},
	{#State 529
		ACTIONS => {
			"\@ARG;" => 531
		}
	},
	{#State 530
		ACTIONS => {
			'VARIABLE_SYMBOL' => 532
		}
	},
	{#State 531
		DEFAULT => -91
	},
	{#State 532
		DEFAULT => -88
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7448 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7490 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7511 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7522 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7529 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7536 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7561 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7583 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7604 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7625 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7632 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7646 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7696 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7703 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7714 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7721 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7735 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7742 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7749 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7756 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7767 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7774 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule Include_52
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule Include_53
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_55
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7839 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7846 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_60
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 4,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7878 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7885 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_64
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7896 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7903 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7910 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7924 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule Class_75
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7977 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_76
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7988 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 2,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_81
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8031 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8049 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8056 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8063 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Method_87
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 228 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8102 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_91
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8113 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_92
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8124 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8135 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_94
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8146 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8157 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8168 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8179 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8190 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8201 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8212 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8223 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8234 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8245 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8256 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8267 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8278 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8289 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8300 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8311 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8322 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8509 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8520 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 1,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8527 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8555 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8566 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8577 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8588 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8599 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8610 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8621 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8632 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8643 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8671 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8678 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8685 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8696 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8707 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8718 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8729 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8740 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8751 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_154
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8762 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8773 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8784 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8795 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8806 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8817 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8828 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8839 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8850 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_163
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8861 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8872 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8883 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_166
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8894 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8905 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8912 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8919 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8926 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_171
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8937 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8948 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8959 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8970 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8981 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 5,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8988 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8995 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9002 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9009 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9016 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9023 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_182
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9034 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_183
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9045 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_184
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9056 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9067 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_186
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9078 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_187
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9089 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_188
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9100 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_189
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9111 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_190
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9122 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-50', 2,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9129 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-50', 1,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9136 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_193
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 2,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 0,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9161 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_196
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9172 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_197
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9183 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_198
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9194 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_199
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9205 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_200
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9216 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_201
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9227 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_202
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9238 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_203
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9249 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_204
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9260 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_205
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9271 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-52', 2,
sub {
#line 272 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 272 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 272 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9292 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_209
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9303 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_210
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9314 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_211
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9325 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_212
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9336 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_213
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9347 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 274 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9354 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 274 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9361 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_216
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9372 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 275 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9379 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 275 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9386 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_219
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9397 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_220
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 276 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9415 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 276 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9422 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_223
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9433 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_224
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9444 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_225
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9455 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_226
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9466 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 278 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9473 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 278 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9480 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 278 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9487 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_230
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9498 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_231
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9509 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 279 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9516 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 279 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9523 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_234
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9534 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_235
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9545 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_236
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9556 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_237
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9567 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_238
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9578 lib/RPerl/Grammar.pm
	],
	[#Rule Type_239
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9589 lib/RPerl/Grammar.pm
	],
	[#Rule Type_240
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9600 lib/RPerl/Grammar.pm
	],
	[#Rule Type_241
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9611 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_242
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9622 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_243
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9633 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_244
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9644 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_245
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9655 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_246
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9666 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_247
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9677 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_248
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9688 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_249
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9699 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_250
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9710 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_251
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9721 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_252
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9732 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_253
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9743 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_254
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9754 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_255
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9765 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_256
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9776 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_257
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9787 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_258
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9798 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_259
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9809 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_260
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9820 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_261
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9831 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9842 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9853 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9864 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9875 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9886 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9897 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9908 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9919 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9930 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9941 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9952 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_273
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9963 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_274
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9974 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_275
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9985 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_276
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9996 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_277
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10007 lib/RPerl/Grammar.pm
	]
],
#line 10010 lib/RPerl/Grammar.pm
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
         'Include_52', 
         'Include_53', 
         'Include_54', 
         'Constant_55', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_60', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_64', 
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
         'Class_75', 
         'UseParent_76', 
         'UseParent_77', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_81', 
         'Properties_82', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_87', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_91', 
         'SubroutineOrMethod_92', 
         'SubroutineOrMethod_93', 
         'Operation_94', 
         'Operation_95', 
         'Operation_96', 
         'Operation_97', 
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
         'Operator_124', 
         'Operator_125', 
         'Operator_126', 
         'Operator_127', 
         'Operator_128', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         'OperatorVoid_139', 
         'OperatorVoid_140', 
         'OperatorVoid_141', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_148', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'SubExpression_154', 
         'SubExpression_155', 
         'SubExpression_156', 
         'SubExpression_157', 
         'SubExpression_158', 
         'SubExpression_159', 
         'SubExpression_160', 
         'SubExpression_161', 
         'SubExpression_162', 
         'SubExpressionOrInput_163', 
         'SubExpressionOrInput_164', 
         'SubExpressionOrInput_165', 
         'SubExpressionOrVarMod_166', 
         'SubExpressionOrVarMod_167', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_171', 
         'Statement_172', 
         'Statement_173', 
         'Statement_174', 
         'Statement_175', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_182', 
         'Loop_183', 
         'Loop_184', 
         'Loop_185', 
         'LoopFor_186', 
         'LoopFor_187', 
         'LoopForEach_188', 
         'LoopWhile_189', 
         'LoopWhile_190', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_193', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_196', 
         'VariableRetrieval_197', 
         'VariableRetrieval_198', 
         'VariableRetrieval_199', 
         'VariableDeclaration_200', 
         'VariableDeclaration_201', 
         'VariableDeclaration_202', 
         'VariableDeclaration_203', 
         'VariableModification_204', 
         'VariableModification_205', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_209', 
         'ListElement_210', 
         'ListElement_211', 
         'ListElement_212', 
         'ListElement_213', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_216', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_219', 
         'ArrayDereference_220', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_223', 
         'HashEntry_224', 
         'HashEntry_225', 
         'HashEntryProperties_226', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_230', 
         'HashReference_231', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_234', 
         'HashDereference_235', 
         'WordScoped_236', 
         'WordScoped_237', 
         'LoopLabel_238', 
         'Type_239', 
         'Type_240', 
         'Type_241', 
         'TypeInner_242', 
         'TypeInnerProperties_243', 
         'TypeInnerProperties_244', 
         'TypeInnerConstant_245', 
         'VariableOrLiteral_246', 
         'VariableOrLiteral_247', 
         'VarOrLitOrOpStrOrWord_248', 
         'VarOrLitOrOpStrOrWord_249', 
         'VarOrLitOrOpStrOrWord_250', 
         'VariableSymbolOrSelf_251', 
         'VariableSymbolOrSelf_252', 
         'Literal_253', 
         'Literal_254', 
         'OpNamedScolonOrSubExp_255', 
         'OpNamedScolonOrSubExp_256', 
         'OpNamedScolonOrSubExp_257', 
         'OpNamedScolonOrSubExpIn_258', 
         'OpNamedScolonOrSubExpIn_259', 
         'OpNamedScolonOrSubExpIn_260', 
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
         'OpStringOrWord_272', 
         'OpStringOrWord_273', 
         'OpStringOrWord_274', 
         'OpStringOrWord_275', 
         'OpStringOrWord_276', 
         'OpStringOrWord_277', );
  $self;
}

#line 300 "lib/RPerl/Grammar.eyp"


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
Include_50 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped ';'
Include_51 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OP01_QW ';'
Constant_52 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_57 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> SUB WORD LBRACE LBRACE MY Type '$RETURN_TYPE' '}' ';' OPTIONAL-22 STAR-23 '}'
SubroutineArguments_61 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-25 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_72 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 
UseParent_XXY => 'RPerl::NonGenerator',                                     # UseParent ->
UseParent_XXY => 'RPerl::NonGenerator',                                     # UseParent ->
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


#line 10503 lib/RPerl/Grammar.pm



1;
