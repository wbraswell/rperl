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

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|foreach|\$TYPED_|BEGIN\ \{|package|undef|elsif|while|\@ARG\;|else|for|\@\{|\%\{|if|\}|\;|\]|\))}gc and return ($1, $1);

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
  [ 'Include_55' => 'Include', [ 'BEGIN {', 'WordScoped', 'OP02_METHOD_THINARROW_IMP', 'OPTIONAL-23', ')', ';', '}' ], 0 ],
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
			'SHEBANG' => 2,
			"package" => -20,
			"## no critic qw(" => 8,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Critic' => 7,
			'ModuleHeader' => 3,
			'OPTIONAL-9' => 1,
			'CompileUnit' => 5,
			'PAREN-1' => 9,
			'PLUS-2' => 6,
			'Program' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 11
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-3' => 13,
			'Critic' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"use parent -norequire, qw(" => 14,
			"use constant" => -27,
			'USE_EXPORTER' => -27,
			"## no critic qw(" => -27,
			'USE' => -27,
			'SUB' => -27,
			"BEGIN {" => -27,
			"use parent qw(" => 20
		},
		GOTOS => {
			'UseParent' => 15,
			'Package' => 19,
			'STAR-11' => 18,
			'Class' => 17,
			'Module' => 16
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			'' => 21
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => -20,
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'ModuleHeader' => 3,
			'Critic' => 7,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 22
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'WORD' => 23
		},
		GOTOS => {
			'PLUS-17' => 24
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			'USE_RPERL' => 26
		}
	},
	{#State 14
		DEFAULT => -78
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		ACTIONS => {
			"use constant" => -29,
			'USE_EXPORTER' => 31,
			"BEGIN {" => -29,
			'USE' => -29,
			'SUB' => -29,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 30,
			'OPTIONAL-12' => 32,
			'Exports' => 33
		}
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		DEFAULT => -77
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		DEFAULT => -41
	},
	{#State 24
		ACTIONS => {
			")" => 34,
			'WORD' => 35
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 26
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 27
		DEFAULT => -237
	},
	{#State 28
		DEFAULT => -238
	},
	{#State 29
		ACTIONS => {
			")" => 39
		}
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			'OUR_EXPORT' => 42,
			"use constant" => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT_OK' => -45,
			"BEGIN {" => -45,
			'USE' => -45,
			'SUB' => -45
		},
		GOTOS => {
			'OPTIONAL-19' => 41,
			'PAREN-18' => 40
		}
	},
	{#State 32
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 43
		}
	},
	{#State 33
		DEFAULT => -28
	},
	{#State 34
		DEFAULT => -42
	},
	{#State 35
		DEFAULT => -40
	},
	{#State 36
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 45
		}
	},
	{#State 38
		ACTIONS => {
			"use warnings;" => 46
		}
	},
	{#State 39
		ACTIONS => {
			";" => 47
		}
	},
	{#State 40
		DEFAULT => -44
	},
	{#State 41
		ACTIONS => {
			"our hashref \$properties" => -48,
			"use constant" => -48,
			'OUR_EXPORT_OK' => 49,
			'USE' => -48,
			'SUB' => -48,
			"BEGIN {" => -48
		},
		GOTOS => {
			'PAREN-20' => 50,
			'OPTIONAL-21' => 48
		}
	},
	{#State 42
		ACTIONS => {
			'OP01_QW' => 51
		}
	},
	{#State 43
		ACTIONS => {
			"use constant" => -33,
			"BEGIN {" => 54,
			'USE' => 55,
			'SUB' => -33
		},
		GOTOS => {
			'STAR-14' => 53,
			'Include' => 52
		}
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"## no critic qw(" => 8,
			"undef" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'SELF' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LITERAL_NUMBER' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"BEGIN {" => -11,
			'OP01_NAMED' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"%{" => -11,
			"while" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LBRACKET' => -11,
			"for" => -11,
			'OP01_PRINT' => -11,
			'USE' => -11,
			'MY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_OPEN' => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LPAREN' => -11,
			"foreach" => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD_UPPERCASE' => -11,
			"use constant" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'SUB' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11
		},
		GOTOS => {
			'Critic' => 57,
			'STAR-5' => 58
		}
	},
	{#State 46
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 60
		},
		GOTOS => {
			'OPTIONAL-16' => 59
		}
	},
	{#State 47
		ACTIONS => {
			"BEGIN {" => 54,
			'USE' => 55
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 48
		DEFAULT => -49
	},
	{#State 49
		ACTIONS => {
			'OP01_QW' => 62
		}
	},
	{#State 50
		DEFAULT => -47
	},
	{#State 51
		ACTIONS => {
			";" => 63
		}
	},
	{#State 52
		DEFAULT => -30
	},
	{#State 53
		ACTIONS => {
			"use constant" => 68,
			'SUB' => 64
		},
		GOTOS => {
			'Constant' => 65,
			'PLUS-15' => 66,
			'Subroutine' => 67
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 69
		}
	},
	{#State 55
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 70
		}
	},
	{#State 56
		DEFAULT => -23
	},
	{#State 57
		DEFAULT => -8
	},
	{#State 58
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -13,
			'SUB' => -13,
			'OP01_CLOSE' => -13,
			"if" => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_UPPERCASE' => -13,
			'WORD_SCOPED' => -13,
			"use constant" => -13,
			'MY' => -13,
			'USE' => 55,
			'LITERAL_STRING' => -13,
			'OP01_OPEN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"while" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT' => -13,
			"for" => -13,
			'LBRACKET' => -13,
			'OP01_NAMED' => -13,
			"BEGIN {" => 54,
			'LITERAL_NUMBER' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD' => -13,
			"\@{" => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'SELF' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"undef" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13
		},
		GOTOS => {
			'Include' => 72,
			'STAR-6' => 71
		}
	},
	{#State 59
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 60
		DEFAULT => -37
	},
	{#State 61
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 62
		ACTIONS => {
			";" => 75
		}
	},
	{#State 63
		DEFAULT => -43
	},
	{#State 64
		ACTIONS => {
			'WORD' => 76
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'SUB' => 64
		},
		GOTOS => {
			'Subroutine' => 77
		}
	},
	{#State 67
		DEFAULT => -35
	},
	{#State 68
		ACTIONS => {
			'WORD_UPPERCASE' => 79
		}
	},
	{#State 69
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 80
		}
	},
	{#State 70
		ACTIONS => {
			'OP01_QW' => 82,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 81
		}
	},
	{#State 71
		ACTIONS => {
			'VARIABLE_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LBRACE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'SELF' => -15,
			"undef" => -15,
			'WORD' => -15,
			"\@{" => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"%{" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_PRINT' => -15,
			"for" => -15,
			'LBRACKET' => -15,
			"while" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_OPEN' => -15,
			'LITERAL_STRING' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LPAREN' => -15,
			'MY' => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD_SCOPED' => -15,
			'WORD_UPPERCASE' => -15,
			"use constant" => 68,
			"foreach" => -15,
			'OP01_CLOSE' => -15,
			"if" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'SUB' => -15
		},
		GOTOS => {
			'Constant' => 83,
			'STAR-7' => 84
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
			'USE' => -69,
			"## no critic qw(" => 8,
			"BEGIN {" => -69,
			"our hashref \$properties" => -69,
			'USE_EXPORTER' => 31,
			"use constant" => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 86,
			'Exports' => 88,
			'Critic' => 87
		}
	},
	{#State 75
		DEFAULT => -46
	},
	{#State 76
		ACTIONS => {
			'LBRACE' => 89
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			";" => 90
		}
	},
	{#State 79
		ACTIONS => {
			'OP20_HASH_FATARROW' => 91
		}
	},
	{#State 80
		ACTIONS => {
			'OP01_QW' => 93,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 92
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
			"for" => -171,
			'LBRACKET' => 99,
			'OP01_PRINT' => 101,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LPAREN' => 105,
			'MY' => 103,
			'OP01_NAMED_VOID' => 113,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 114,
			"foreach" => -171,
			"if" => 117,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'SUB' => 64,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LBRACE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 126,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'WORD' => 27,
			'OP01_NAMED_SCOLON' => 133,
			"\@{" => 134,
			'OP19_LOOP_CONTROL' => 140,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'Operation' => 108,
			'HashDereference' => 106,
			'SubExpression' => 136,
			'VariableDeclaration' => 135,
			'Statement' => 104,
			'OperatorVoid' => 102,
			'PAREN-45' => 130,
			'VariableModification' => 131,
			'LoopLabel' => 100,
			'HashReference' => 97,
			'Subroutine' => 98,
			'Expression' => 123,
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Conditional' => 137,
			'PLUS-8' => 138
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 149
		}
	},
	{#State 87
		DEFAULT => -66
	},
	{#State 88
		DEFAULT => -68
	},
	{#State 89
		ACTIONS => {
			'LBRACE' => 150
		}
	},
	{#State 90
		DEFAULT => -36
	},
	{#State 91
		ACTIONS => {
			'MY' => 151
		},
		GOTOS => {
			'TypeInnerConstant' => 152
		}
	},
	{#State 92
		ACTIONS => {
			")" => 153
		}
	},
	{#State 93
		DEFAULT => -52
	},
	{#State 94
		DEFAULT => -54
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 132,
			'SELF' => 122
		},
		GOTOS => {
			'Variable' => 154,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 96
		ACTIONS => {
			"for" => 159,
			"while" => 160,
			"foreach" => 161
		},
		GOTOS => {
			'Loop' => 157,
			'LoopFor' => 156,
			'LoopForEach' => 155,
			'LoopWhile' => 158
		}
	},
	{#State 97
		DEFAULT => -161
	},
	{#State 98
		DEFAULT => -14
	},
	{#State 99
		ACTIONS => {
			'MY' => 172,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACE' => 124,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'OP01_QW' => 165,
			'SELF' => 122,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			"]" => -216,
			'ARGV' => 169,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'TypeInner' => 171,
			'OPTIONAL-55' => 168,
			'HashReference' => 97,
			'ListElements' => 173,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'ListElement' => 162,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 164
		}
	},
	{#State 100
		ACTIONS => {
			'COLON' => 174
		}
	},
	{#State 101
		ACTIONS => {
			'OP01_OPEN' => -132,
			'LITERAL_STRING' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'WORD' => -132,
			'LPAREN' => -132,
			"\@{" => -132,
			'MY' => -132,
			'LBRACKET' => -132,
			'VARIABLE_SYMBOL' => -132,
			'OP10_NAMED_UNARY' => -132,
			'LBRACE' => -132,
			"undef" => -132,
			'OP22_LOGICAL_NEG' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'SELF' => -132,
			'OP01_QW' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			"%{" => -132,
			'FHREF_SYMBOL_BRACES' => 177,
			'OP01_CLOSE' => -132,
			'STDOUT_STDERR' => 178,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'LITERAL_NUMBER' => -132,
			'OP01_NAMED' => -132,
			'WORD_UPPERCASE' => -132,
			'WORD_SCOPED' => -132,
			'ARGV' => -132
		},
		GOTOS => {
			'OPTIONAL-40' => 175,
			'PAREN-39' => 176
		}
	},
	{#State 102
		DEFAULT => -174
	},
	{#State 103
		ACTIONS => {
			'TYPE_FHREF' => 181,
			'WORD' => 179,
			'WORD_SCOPED' => 182,
			'TYPE_INTEGER' => 180
		},
		GOTOS => {
			'Type' => 183
		}
	},
	{#State 104
		DEFAULT => -98
	},
	{#State 105
		ACTIONS => {
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'LBRACE' => 124,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'OP01_PRINT' => 184,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'OP01_NAMED' => 186,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 185,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166
		}
	},
	{#State 106
		DEFAULT => -162
	},
	{#State 107
		DEFAULT => -141
	},
	{#State 108
		DEFAULT => -17
	},
	{#State 109
		DEFAULT => -255
	},
	{#State 110
		ACTIONS => {
			'LPAREN' => 105,
			"\@{" => 134,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'LBRACE' => 124,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 187,
			'HashDereference' => 106,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 111
		ACTIONS => {
			'MY' => 188
		}
	},
	{#State 112
		DEFAULT => -159
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => 105,
			"\@{" => 134,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'WORD' => 27,
			'MY' => 172,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP01_QW' => 165,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'LBRACE' => 124,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'ARGV' => 169
		},
		GOTOS => {
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'TypeInner' => 171,
			'HashReference' => 97,
			'ListElements' => 189,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'ListElement' => 162,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 164
		}
	},
	{#State 114
		ACTIONS => {
			'COLON' => -239,
			'LPAREN' => 190
		}
	},
	{#State 115
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 191,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166
		}
	},
	{#State 116
		DEFAULT => -160
	},
	{#State 117
		ACTIONS => {
			'LPAREN' => 192
		}
	},
	{#State 118
		ACTIONS => {
			'FHREF_SYMBOL' => 193
		}
	},
	{#State 119
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 194
		}
	},
	{#State 120
		DEFAULT => -156
	},
	{#State 121
		ACTIONS => {
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 195,
			'HashDereference' => 106,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 122
		DEFAULT => -253
	},
	{#State 123
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP13_BITWISE_AND' => -155,
			";" => 196,
			'OP17_LIST_RANGE' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP08_STRING_CAT' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP18_TERNARY' => -155,
			'OP04_MATH_POW' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP07_STRING_REPEAT' => -155
		}
	},
	{#State 124
		ACTIONS => {
			'OP07_STRING_REPEAT' => 208,
			'OP01_NAMED_VOID' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP19_LOOP_CONTROL' => 197,
			'ENV' => 198,
			'LITERAL_NUMBER' => 141,
			'OP12_COMPARE_EQ_NE' => 213,
			'OP11_COMPARE_LT_GT' => 200,
			"}" => 202,
			'OP01_NAMED' => 201,
			"%{" => 147,
			'OP23_LOGICAL_AND' => 199,
			'OP01_CLOSE' => 211,
			'OP22_LOGICAL_NEG' => 206,
			'SELF' => 122,
			'OP01_PRINT' => 214,
			'VARIABLE_SYMBOL' => 132,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP08_MATH_ADD_SUB' => 221,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 217,
			'WORD' => 207,
			'OP19_LOOP_CONTROL_SCOLON' => 220
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'HashEntry' => 218,
			'HashDereference' => 219,
			'VarOrLitOrOpStrOrWord' => 212,
			'Variable' => 205,
			'OpStringOrWord' => 216,
			'Literal' => 203
		}
	},
	{#State 125
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			")" => -134,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_QW' => 165,
			'SELF' => 122,
			"undef" => 120,
			'LBRACE' => 124,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'MY' => 172
		},
		GOTOS => {
			'HashReference' => 97,
			'TypeInner' => 171,
			'Expression' => 167,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'HashDereference' => 106,
			'SubExpression' => 164,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'OPTIONAL-41' => 223,
			'Literal' => 144,
			'ListElement' => 162,
			'ListElements' => 222,
			'ArrayDereference' => 116
		}
	},
	{#State 126
		DEFAULT => -137
	},
	{#State 127
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 224,
			'OP17_LIST_RANGE' => -158,
			'OP19_VARIABLE_ASSIGN' => 227,
			'OP16_LOGICAL_OR' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 225,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP07_STRING_REPEAT' => -158,
			")" => -158,
			'OP08_STRING_CAT' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP02_METHOD_THINARROW' => 226,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP18_TERNARY' => -158,
			'OP04_MATH_POW' => -158,
			'OP23_LOGICAL_AND' => -158
		}
	},
	{#State 128
		ACTIONS => {
			'LPAREN' => 105,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP08_MATH_ADD_SUB' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP15_LOGICAL_AND' => -117,
			'LBRACKET' => 99,
			'OP16_LOGICAL_OR' => -117,
			";" => -117,
			'OP17_LIST_RANGE' => -117,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_CLOSE' => 118,
			'OP04_MATH_POW' => -117,
			'OP18_TERNARY' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP05_LOGICAL_NEG' => 115,
			'OP09_BITWISE_SHIFT' => -117,
			'OP08_STRING_CAT' => -117,
			")" => -117,
			'OP07_STRING_REPEAT' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP21_LIST_COMMA' => -117,
			"]" => -117,
			'OP13_BITWISE_AND' => -117,
			"\@{" => 134,
			'OP06_REGEX_BIND' => -117,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'LBRACE' => 124,
			'OP23_LOGICAL_AND' => -117,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			"}" => -117,
			'OP01_NAMED' => 163,
			'OP11_COMPARE_LT_GT' => -117,
			'OP14_BITWISE_OR_XOR' => -117
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 228,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'Expression' => 167
		}
	},
	{#State 129
		DEFAULT => -97
	},
	{#State 130
		DEFAULT => -170
	},
	{#State 131
		ACTIONS => {
			";" => 229
		}
	},
	{#State 132
		DEFAULT => -252
	},
	{#State 133
		DEFAULT => -96
	},
	{#State 134
		ACTIONS => {
			'LBRACKET' => -219,
			'VARIABLE_SYMBOL' => 132,
			'SELF' => 122,
			'MY' => 172
		},
		GOTOS => {
			'TypeInner' => 231,
			'VariableSymbolOrSelf' => 119,
			'OPTIONAL-56' => 232,
			'Variable' => 230
		}
	},
	{#State 135
		DEFAULT => -175
	},
	{#State 136
		ACTIONS => {
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244
		}
	},
	{#State 137
		DEFAULT => -172
	},
	{#State 138
		ACTIONS => {
			'MY' => 103,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 95,
			"for" => -171,
			'LBRACKET' => 99,
			'OP01_PRINT' => 101,
			'OP05_LOGICAL_NEG' => 115,
			"if" => 117,
			'OP01_CLOSE' => 118,
			"foreach" => -171,
			'WORD_UPPERCASE' => 114,
			'OP01_NAMED_VOID' => 113,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'OP01_NAMED_SCOLON' => 133,
			"\@{" => 134,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LBRACE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'' => -18,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 145,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP19_LOOP_CONTROL' => 140
		},
		GOTOS => {
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'Expression' => 123,
			'VariableModification' => 131,
			'LoopLabel' => 100,
			'PAREN-45' => 130,
			'HashReference' => 97,
			'Statement' => 104,
			'OperatorVoid' => 102,
			'SubExpression' => 136,
			'VariableDeclaration' => 135,
			'HashDereference' => 106,
			'Operation' => 250,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Conditional' => 137,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 139
		ACTIONS => {
			'LPAREN' => 251,
			'OP02_METHOD_THINARROW_NEW' => 252
		}
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 253
		},
		GOTOS => {
			'LoopLabel' => 254
		}
	},
	{#State 141
		DEFAULT => -254
	},
	{#State 142
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 134,
			'LPAREN' => 105,
			'LBRACE' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 255,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167
		}
	},
	{#State 143
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'LBRACE' => 124,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 256,
			'HashDereference' => 106
		}
	},
	{#State 144
		DEFAULT => -157
	},
	{#State 145
		ACTIONS => {
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP01_QW' => 165,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'MY' => 172,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'TypeInner' => 171,
			'HashReference' => 97,
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 258,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'ListElement' => 257
		}
	},
	{#State 146
		DEFAULT => -151
	},
	{#State 147
		ACTIONS => {
			'SELF' => 122,
			'MY' => 172,
			'LBRACE' => -234,
			'VARIABLE_SYMBOL' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'TypeInner' => 260,
			'OPTIONAL-60' => 261,
			'Variable' => 259
		}
	},
	{#State 148
		DEFAULT => -149
	},
	{#State 149
		ACTIONS => {
			"BEGIN {" => 54,
			'USE' => 55,
			"use constant" => -73,
			"our hashref \$properties" => -73
		},
		GOTOS => {
			'Include' => 263,
			'STAR-31' => 262
		}
	},
	{#State 150
		ACTIONS => {
			'MY' => 264
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 182,
			'WORD' => 179,
			'TYPE_INTEGER' => 180
		},
		GOTOS => {
			'Type' => 265
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'LITERAL_NUMBER' => 141
		},
		GOTOS => {
			'Literal' => 266
		}
	},
	{#State 153
		ACTIONS => {
			";" => 267
		}
	},
	{#State 154
		DEFAULT => -104
	},
	{#State 155
		DEFAULT => -185
	},
	{#State 156
		DEFAULT => -184
	},
	{#State 157
		DEFAULT => -173
	},
	{#State 158
		DEFAULT => -186
	},
	{#State 159
		ACTIONS => {
			'MY' => 269,
			'LPAREN_MY' => 268
		}
	},
	{#State 160
		ACTIONS => {
			'LPAREN_MY' => 270,
			'LPAREN' => 271
		}
	},
	{#State 161
		ACTIONS => {
			'MY' => 272
		}
	},
	{#State 162
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 273
		}
	},
	{#State 163
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'LBRACE' => 124,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 274,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166
		}
	},
	{#State 164
		ACTIONS => {
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP17_LIST_RANGE' => 233,
			";" => -211,
			'OP16_LOGICAL_OR' => 234,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP21_LIST_COMMA' => -211,
			'OP14_BITWISE_OR_XOR' => 247,
			"]" => -211,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => -211,
			'OP08_STRING_CAT' => 242
		}
	},
	{#State 165
		DEFAULT => -213
	},
	{#State 166
		ACTIONS => {
			'OP07_STRING_REPEAT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			"]" => -158,
			'OP21_LIST_COMMA' => -158,
			'OP18_TERNARY' => -158,
			'OP04_MATH_POW' => -158,
			'OP23_LOGICAL_AND' => -158,
			")" => -158,
			'OP08_STRING_CAT' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			"}" => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP02_METHOD_THINARROW' => 226,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP17_LIST_RANGE' => -158,
			";" => -158,
			'OP03_MATH_INC_DEC' => 224,
			'OP16_LOGICAL_OR' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP08_MATH_ADD_SUB' => -158
		}
	},
	{#State 167
		DEFAULT => -155
	},
	{#State 168
		ACTIONS => {
			"]" => 275
		}
	},
	{#State 169
		DEFAULT => -214
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 190
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 134,
			'LPAREN' => 105,
			'LBRACE' => 124,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 276,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167
		}
	},
	{#State 172
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD' => 179,
			'WORD_SCOPED' => 182
		},
		GOTOS => {
			'Type' => 277
		}
	},
	{#State 173
		DEFAULT => -215
	},
	{#State 174
		DEFAULT => -169
	},
	{#State 175
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP01_QW' => 165,
			'LBRACE' => 124,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'MY' => 172,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'Expression' => 167,
			'TypeInner' => 171,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'ListElements' => 278,
			'ListElement' => 162,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 164,
			'HashDereference' => 106
		}
	},
	{#State 176
		DEFAULT => -131
	},
	{#State 177
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'MY' => 172,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_QW' => 165,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97,
			'TypeInner' => 171,
			'Literal' => 144,
			'ListElement' => 162,
			'ArrayDereference' => 116,
			'ListElements' => 279,
			'SubExpression' => 164,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 178
		DEFAULT => -130
	},
	{#State 179
		DEFAULT => -240
	},
	{#State 180
		DEFAULT => -242
	},
	{#State 181
		ACTIONS => {
			'FHREF_SYMBOL' => 280
		}
	},
	{#State 182
		DEFAULT => -241
	},
	{#State 183
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 184
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 282
		}
	},
	{#State 185
		ACTIONS => {
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			")" => 283
		}
	},
	{#State 186
		ACTIONS => {
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'MY' => 172,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			'OP01_QW' => 165,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120
		},
		GOTOS => {
			'ListElement' => 284,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashDereference' => 106,
			'SubExpression' => 258,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Expression' => 167,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'HashReference' => 97,
			'TypeInner' => 171
		}
	},
	{#State 187
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP08_STRING_CAT' => 242,
			")" => 285,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240
		}
	},
	{#State 188
		ACTIONS => {
			'TYPE_FHREF' => 286
		}
	},
	{#State 189
		ACTIONS => {
			";" => 287
		}
	},
	{#State 190
		ACTIONS => {
			")" => 288
		}
	},
	{#State 191
		ACTIONS => {
			'OP17_LIST_RANGE' => -108,
			";" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			")" => -108,
			'OP08_STRING_CAT' => -108,
			"}" => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP18_TERNARY' => -108,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 192
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'LBRACE' => 124,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 289,
			'HashDereference' => 106
		}
	},
	{#State 193
		DEFAULT => -103
	},
	{#State 194
		ACTIONS => {
			'OP13_BITWISE_AND' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP02_ARRAY_THINARROW' => 290,
			'OP08_MATH_ADD_SUB' => -197,
			'OP15_LOGICAL_AND' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP03_MATH_INC_DEC' => -197,
			";" => -197,
			'OP17_LIST_RANGE' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			'OP16_LOGICAL_OR' => -197,
			'OP04_MATH_POW' => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP18_TERNARY' => -197,
			'OP11_COMPARE_LT_GT' => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP02_HASH_THINARROW' => 292,
			"}" => -197,
			'OP12_COMPARE_EQ_NE' => -197,
			'COLON' => -197,
			'OP02_METHOD_THINARROW' => -197,
			")" => -197,
			'OP08_STRING_CAT' => -197,
			'OP07_STRING_REPEAT' => -197,
			'OP07_MATH_MULT_DIV_MOD' => -197,
			'OP21_LIST_COMMA' => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			"]" => -197
		},
		GOTOS => {
			'VariableRetrieval' => 291
		}
	},
	{#State 195
		ACTIONS => {
			";" => -127,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP21_LIST_COMMA' => -127,
			'OP14_BITWISE_OR_XOR' => 247,
			"]" => -127,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			"}" => -127,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => -127,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -127,
			'OP18_TERNARY' => 244
		}
	},
	{#State 196
		DEFAULT => -95
	},
	{#State 197
		DEFAULT => -266
	},
	{#State 198
		DEFAULT => -226
	},
	{#State 199
		DEFAULT => -263
	},
	{#State 200
		DEFAULT => -268
	},
	{#State 201
		DEFAULT => -273
	},
	{#State 202
		DEFAULT => -232
	},
	{#State 203
		DEFAULT => -250
	},
	{#State 204
		DEFAULT => -269
	},
	{#State 205
		DEFAULT => -249
	},
	{#State 206
		DEFAULT => -264
	},
	{#State 207
		DEFAULT => -278
	},
	{#State 208
		DEFAULT => -272
	},
	{#State 209
		DEFAULT => -276
	},
	{#State 210
		DEFAULT => -271
	},
	{#State 211
		DEFAULT => -274
	},
	{#State 212
		ACTIONS => {
			'OP20_HASH_FATARROW' => 293
		}
	},
	{#State 213
		DEFAULT => -267
	},
	{#State 214
		DEFAULT => -277
	},
	{#State 215
		DEFAULT => -262
	},
	{#State 216
		DEFAULT => -251
	},
	{#State 217
		DEFAULT => -275
	},
	{#State 218
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 294
		}
	},
	{#State 219
		DEFAULT => -225
	},
	{#State 220
		DEFAULT => -265
	},
	{#State 221
		DEFAULT => -270
	},
	{#State 222
		DEFAULT => -133
	},
	{#State 223
		ACTIONS => {
			")" => 295
		}
	},
	{#State 224
		DEFAULT => -105
	},
	{#State 225
		ACTIONS => {
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 296,
			'HashDereference' => 106,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 226
		ACTIONS => {
			'LPAREN' => 297
		}
	},
	{#State 227
		ACTIONS => {
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'FHREF_SYMBOL_IN' => 299,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'WORD_UPPERCASE' => 170,
			'STDIN' => 298,
			'WORD_SCOPED' => 28,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'Expression' => 167,
			'SubExpressionOrInput' => 300,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 301
		}
	},
	{#State 228
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP21_LIST_COMMA' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			"]" => -116,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP09_BITWISE_SHIFT' => 240,
			"}" => -116,
			'OP11_COMPARE_LT_GT' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			")" => -116,
			'OP08_STRING_CAT' => 242,
			'OP15_LOGICAL_AND' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP17_LIST_RANGE' => -116,
			";" => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP06_REGEX_BIND' => 246,
			'OP08_MATH_ADD_SUB' => 237
		}
	},
	{#State 229
		DEFAULT => -176
	},
	{#State 230
		ACTIONS => {
			"}" => 302
		}
	},
	{#State 231
		DEFAULT => -218
	},
	{#State 232
		ACTIONS => {
			'LBRACKET' => 99
		},
		GOTOS => {
			'ArrayReference' => 303
		}
	},
	{#State 233
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'HashReference' => 97,
			'Expression' => 167,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'HashDereference' => 106,
			'SubExpression' => 304,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 234
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'LBRACE' => 124,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105
		},
		GOTOS => {
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'HashDereference' => 106,
			'SubExpression' => 305,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 235
		ACTIONS => {
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'LBRACE' => 124,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 306,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112
		}
	},
	{#State 236
		ACTIONS => {
			'LBRACE' => 124,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118
		},
		GOTOS => {
			'SubExpression' => 307,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167
		}
	},
	{#State 237
		ACTIONS => {
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 308,
			'HashDereference' => 106
		}
	},
	{#State 238
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 309,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167
		}
	},
	{#State 239
		ACTIONS => {
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 310,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Expression' => 167,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139
		}
	},
	{#State 240
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Literal' => 144,
			'ArrayDereference' => 116,
			'SubExpression' => 311,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 241
		ACTIONS => {
			'LBRACE' => 124,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118
		},
		GOTOS => {
			'HashReference' => 97,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'Expression' => 167,
			'SubExpression' => 312,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 242
		ACTIONS => {
			'LBRACE' => 124,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 313,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167
		}
	},
	{#State 243
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'LBRACE' => 124,
			'LPAREN' => 105,
			"\@{" => 134,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'WORD' => 27
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'Expression' => 167,
			'HashReference' => 97,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'SubExpression' => 314,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 244
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'VARIABLE_SYMBOL' => 132,
			'LITERAL_NUMBER' => 141,
			'SELF' => 122
		},
		GOTOS => {
			'VariableOrLiteral' => 315,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 316,
			'Variable' => 317
		}
	},
	{#State 245
		ACTIONS => {
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99
		},
		GOTOS => {
			'SubExpression' => 318,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Variable' => 166,
			'Expression' => 167
		}
	},
	{#State 246
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 319
		}
	},
	{#State 247
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109
		},
		GOTOS => {
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'SubExpression' => 320,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 248
		ACTIONS => {
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 134,
			'LPAREN' => 105,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120
		},
		GOTOS => {
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 321,
			'HashDereference' => 106
		}
	},
	{#State 249
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACE' => 124,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 322,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144
		}
	},
	{#State 250
		DEFAULT => -16
	},
	{#State 251
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			")" => -144,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			'WORD' => 27,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 134,
			'LPAREN' => 105,
			'MY' => 172,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			'OP01_QW' => 165,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			"undef" => 120
		},
		GOTOS => {
			'ListElement' => 162,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'OPTIONAL-42' => 324,
			'ListElements' => 323,
			'SubExpression' => 164,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97,
			'TypeInner' => 171
		}
	},
	{#State 252
		ACTIONS => {
			")" => -148,
			'LBRACE' => 124
		},
		GOTOS => {
			'OPTIONAL-44' => 326,
			'HashReference' => 325
		}
	},
	{#State 253
		DEFAULT => -239
	},
	{#State 254
		ACTIONS => {
			";" => 327
		}
	},
	{#State 255
		ACTIONS => {
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			")" => 328,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244
		}
	},
	{#State 256
		ACTIONS => {
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => 329,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244
		}
	},
	{#State 257
		ACTIONS => {
			'OP21_LIST_COMMA' => 330
		}
	},
	{#State 258
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -211,
			'OP07_STRING_REPEAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100
		}
	},
	{#State 259
		ACTIONS => {
			"}" => 331
		}
	},
	{#State 260
		DEFAULT => -233
	},
	{#State 261
		ACTIONS => {
			'LBRACE' => 124
		},
		GOTOS => {
			'HashReference' => 332
		}
	},
	{#State 262
		ACTIONS => {
			"our hashref \$properties" => 333,
			"use constant" => 68
		},
		GOTOS => {
			'Constant' => 334,
			'Properties' => 335
		}
	},
	{#State 263
		DEFAULT => -70
	},
	{#State 264
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD_SCOPED' => 182,
			'WORD' => 179
		},
		GOTOS => {
			'Type' => 336
		}
	},
	{#State 265
		ACTIONS => {
			"\$TYPED_" => 337
		}
	},
	{#State 266
		ACTIONS => {
			";" => 338
		}
	},
	{#State 267
		ACTIONS => {
			"}" => 339
		}
	},
	{#State 268
		ACTIONS => {
			'TYPE_INTEGER' => 340
		}
	},
	{#State 269
		ACTIONS => {
			'TYPE_INTEGER' => 341
		}
	},
	{#State 270
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD' => 179,
			'WORD_SCOPED' => 182
		},
		GOTOS => {
			'Type' => 342
		}
	},
	{#State 271
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACE' => 124,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 343,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139
		}
	},
	{#State 272
		ACTIONS => {
			'WORD_SCOPED' => 182,
			'WORD' => 179,
			'TYPE_INTEGER' => 180
		},
		GOTOS => {
			'Type' => 344
		}
	},
	{#State 273
		ACTIONS => {
			";" => -210,
			'OP21_LIST_COMMA' => 346,
			")" => -210,
			"]" => -210
		},
		GOTOS => {
			'PAREN-53' => 345
		}
	},
	{#State 274
		ACTIONS => {
			"]" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			"}" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP17_LIST_RANGE' => -100,
			";" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP13_BITWISE_AND' => -100
		}
	},
	{#State 275
		DEFAULT => -217
	},
	{#State 276
		ACTIONS => {
			"]" => -212,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP21_LIST_COMMA' => -212,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP08_STRING_CAT' => 242,
			")" => -212,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			";" => -212,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245
		}
	},
	{#State 277
		ACTIONS => {
			"\$TYPED_" => 347
		}
	},
	{#State 278
		ACTIONS => {
			";" => 348
		}
	},
	{#State 279
		ACTIONS => {
			";" => 349
		}
	},
	{#State 280
		ACTIONS => {
			";" => 350
		}
	},
	{#State 281
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 351,
			";" => 353,
			'OP02_ARRAY_THINARROW' => 352
		}
	},
	{#State 282
		ACTIONS => {
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'ARGV' => 169,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'MY' => 172,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_QW' => 165,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 164,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'ListElement' => 162,
			'Literal' => 144,
			'ListElements' => 354,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'TypeInner' => 171,
			'Expression' => 167,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166
		}
	},
	{#State 283
		DEFAULT => -163
	},
	{#State 284
		ACTIONS => {
			'OP21_LIST_COMMA' => 355
		}
	},
	{#State 285
		DEFAULT => -109
	},
	{#State 286
		ACTIONS => {
			'FHREF_SYMBOL' => 356
		}
	},
	{#State 287
		DEFAULT => -139
	},
	{#State 288
		DEFAULT => -150
	},
	{#State 289
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			")" => 357,
			'OP08_STRING_CAT' => 242,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 244,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239
		}
	},
	{#State 290
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 358,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112
		}
	},
	{#State 291
		DEFAULT => -195
	},
	{#State 292
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'LBRACE' => 124,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 360,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'HashDereference' => 106,
			'SubExpression' => 359,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'Expression' => 167,
			'ArrayReference' => 112,
			'Variable' => 166,
			'WordScoped' => 139
		}
	},
	{#State 293
		ACTIONS => {
			'OP01_OPEN' => -223,
			'LITERAL_STRING' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'WORD' => -223,
			'LPAREN' => -223,
			"\@{" => -223,
			'MY' => 172,
			'LBRACKET' => -223,
			'VARIABLE_SYMBOL' => -223,
			'OP10_NAMED_UNARY' => -223,
			'LBRACE' => -223,
			"undef" => -223,
			'SELF' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'OP22_LOGICAL_NEG' => -223,
			"%{" => -223,
			'CONSTANT_CALL_SCOPED' => -223,
			'OP01_CLOSE' => -223,
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			'LITERAL_NUMBER' => -223,
			'OP01_NAMED' => -223,
			'WORD_SCOPED' => -223,
			'WORD_UPPERCASE' => -223
		},
		GOTOS => {
			'TypeInner' => 361,
			'OPTIONAL-57' => 362
		}
	},
	{#State 294
		ACTIONS => {
			"}" => 363,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-58' => 364
		}
	},
	{#State 295
		ACTIONS => {
			";" => 366
		}
	},
	{#State 296
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP08_STRING_CAT' => 242,
			")" => -206,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP16_LOGICAL_OR' => 234,
			";" => -206,
			'OP17_LIST_RANGE' => 233,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP08_MATH_ADD_SUB' => 237
		}
	},
	{#State 297
		ACTIONS => {
			'LPAREN' => 105,
			"\@{" => 134,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'MY' => 172,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP01_QW' => 165,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACE' => 124,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			")" => -146,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169
		},
		GOTOS => {
			'HashReference' => 97,
			'TypeInner' => 171,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Variable' => 166,
			'Expression' => 167,
			'OPTIONAL-43' => 367,
			'SubExpression' => 164,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'ListElement' => 162,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'ListElements' => 368
		}
	},
	{#State 298
		DEFAULT => -166
	},
	{#State 299
		DEFAULT => -165
	},
	{#State 300
		DEFAULT => -205
	},
	{#State 301
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => -164,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			";" => -164,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236
		}
	},
	{#State 302
		DEFAULT => -220
	},
	{#State 303
		ACTIONS => {
			"}" => 369
		}
	},
	{#State 304
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => undef,
			";" => -124,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -124,
			'OP09_BITWISE_SHIFT' => 240,
			'OP08_STRING_CAT' => 242,
			")" => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => -124,
			'OP21_LIST_COMMA' => -124,
			"]" => -124,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239
		}
	},
	{#State 305
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP15_LOGICAL_AND' => 236,
			'OP17_LIST_RANGE' => -123,
			";" => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP14_BITWISE_OR_XOR' => 247,
			"]" => -123,
			'OP21_LIST_COMMA' => -123,
			'OP18_TERNARY' => -123,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -123,
			")" => -123,
			'OP08_STRING_CAT' => 242,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -123,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241
		}
	},
	{#State 306
		ACTIONS => {
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			";" => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			"]" => -129,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP21_LIST_COMMA' => -129,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP08_STRING_CAT' => 242,
			")" => -129,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -129,
			'OP09_BITWISE_SHIFT' => 240,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 307
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => -122,
			'OP17_LIST_RANGE' => -122,
			";" => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			"}" => -122,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			")" => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => -122,
			'OP21_LIST_COMMA' => -122,
			"]" => -122,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239
		}
	},
	{#State 308
		ACTIONS => {
			"]" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP08_STRING_CAT' => -113,
			")" => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			"}" => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP18_TERNARY' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 243,
			'OP16_LOGICAL_OR' => -113,
			'OP17_LIST_RANGE' => -113,
			";" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => -113
		}
	},
	{#State 309
		ACTIONS => {
			'OP15_LOGICAL_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP17_LIST_RANGE' => -111,
			";" => -111,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP07_STRING_REPEAT' => -111,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP18_TERNARY' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 243,
			'OP08_STRING_CAT' => -111,
			")" => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			"}" => -111,
			'OP11_COMPARE_LT_GT' => -111
		}
	},
	{#State 310
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => -112,
			'OP17_LIST_RANGE' => -112,
			";" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			"}" => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP08_STRING_CAT' => -112,
			")" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => -112,
			'OP21_LIST_COMMA' => -112,
			"]" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP07_STRING_REPEAT' => 238
		}
	},
	{#State 311
		ACTIONS => {
			")" => -115,
			'OP08_STRING_CAT' => 242,
			'OP11_COMPARE_LT_GT' => -115,
			"}" => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP18_TERNARY' => -115,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			"]" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => -115,
			";" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115
		}
	},
	{#State 312
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => -119,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => -119,
			'OP17_LIST_RANGE' => -119,
			";" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -119,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP08_STRING_CAT' => 242,
			")" => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => -119,
			'OP21_LIST_COMMA' => -119,
			"]" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239
		}
	},
	{#State 313
		ACTIONS => {
			'OP16_LOGICAL_OR' => -114,
			'OP17_LIST_RANGE' => -114,
			";" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => -114,
			"]" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_STRING_CAT' => -114,
			")" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			"}" => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP18_TERNARY' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP04_MATH_POW' => 243
		}
	},
	{#State 314
		ACTIONS => {
			'OP16_LOGICAL_OR' => -106,
			";" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP08_STRING_CAT' => -106,
			")" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => -106
		}
	},
	{#State 315
		ACTIONS => {
			'COLON' => 370
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
			'OP09_BITWISE_SHIFT' => 240,
			"}" => -120,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => -120,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -120,
			'OP18_TERNARY' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			"]" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => -120,
			'OP06_REGEX_BIND' => 246,
			'OP17_LIST_RANGE' => -120,
			";" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP15_LOGICAL_AND' => -120
		}
	},
	{#State 319
		DEFAULT => -110
	},
	{#State 320
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP17_LIST_RANGE' => -121,
			";" => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -121,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => -121,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -121,
			'OP18_TERNARY' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			"]" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238
		}
	},
	{#State 321
		ACTIONS => {
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => -118,
			'OP08_MATH_ADD_SUB' => 237,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			";" => -118,
			'OP17_LIST_RANGE' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP18_TERNARY' => -118,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -118,
			")" => -118,
			'OP08_STRING_CAT' => 242,
			"}" => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP14_BITWISE_OR_XOR' => -118,
			"]" => -118,
			'OP21_LIST_COMMA' => -118
		}
	},
	{#State 322
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP15_LOGICAL_AND' => 236,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			";" => -128,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			"]" => -128,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP21_LIST_COMMA' => -128,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => -128,
			'OP04_MATH_POW' => 243,
			'OP08_STRING_CAT' => 242,
			")" => -128,
			'OP12_COMPARE_EQ_NE' => 241,
			"}" => -128,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240
		}
	},
	{#State 323
		DEFAULT => -143
	},
	{#State 324
		ACTIONS => {
			")" => 371
		}
	},
	{#State 325
		DEFAULT => -147
	},
	{#State 326
		ACTIONS => {
			")" => 372
		}
	},
	{#State 327
		DEFAULT => -142
	},
	{#State 328
		DEFAULT => -126
	},
	{#State 329
		DEFAULT => -107
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP01_QW' => 165,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'MY' => 172,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'ARGV' => 169,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118
		},
		GOTOS => {
			'ListElements' => 373,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'ListElement' => 162,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'HashDereference' => 106,
			'SubExpression' => 164,
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'TypeInner' => 171,
			'HashReference' => 97
		}
	},
	{#State 331
		DEFAULT => -235
	},
	{#State 332
		ACTIONS => {
			"}" => 374
		}
	},
	{#State 333
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 375
		}
	},
	{#State 334
		DEFAULT => -72
	},
	{#State 335
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 376
		}
	},
	{#State 336
		ACTIONS => {
			"\$RETURN_TYPE" => 377
		}
	},
	{#State 337
		ACTIONS => {
			'WORD_UPPERCASE' => 378
		}
	},
	{#State 338
		DEFAULT => -56
	},
	{#State 339
		DEFAULT => -55
	},
	{#State 340
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 343
		ACTIONS => {
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244,
			'OP11_COMPARE_LT_GT' => 248,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			")" => 382,
			'OP08_STRING_CAT' => 242,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP08_MATH_ADD_SUB' => 237
		}
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 345
		DEFAULT => -208
	},
	{#State 346
		ACTIONS => {
			'LBRACE' => 124,
			'SELF' => 122,
			'OP01_QW' => 165,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'MY' => 172,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'ARGV' => 169,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118
		},
		GOTOS => {
			'SubExpression' => 164,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'ListElement' => 384,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashReference' => 97,
			'TypeInner' => 171,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Expression' => 167
		}
	},
	{#State 347
		ACTIONS => {
			'OP01_PRINT' => 214,
			'OP10_NAMED_UNARY' => 204,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP22_LOGICAL_NEG' => 206,
			'WORD' => 207,
			'OP01_OPEN' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP08_MATH_ADD_SUB' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP01_NAMED_VOID' => 209,
			'OP07_STRING_REPEAT' => 208,
			'OP19_LOOP_CONTROL' => 197,
			'OP01_CLOSE' => 211,
			'OP23_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 200,
			'OP01_NAMED' => 201,
			'OP12_COMPARE_EQ_NE' => 213
		},
		GOTOS => {
			'OpStringOrWord' => 385
		}
	},
	{#State 348
		DEFAULT => -135
	},
	{#State 349
		DEFAULT => -136
	},
	{#State 350
		DEFAULT => -204
	},
	{#State 351
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'FHREF_SYMBOL_IN' => 299,
			'OP10_NAMED_UNARY_SCOLON' => 388,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'LBRACE' => 124,
			"\@{" => 134,
			'OP01_NAMED_SCOLON' => 386,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'STDIN' => 298,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141
		},
		GOTOS => {
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashDereference' => 106,
			'SubExpression' => 301,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'SubExpressionOrInput' => 389,
			'Expression' => 167,
			'Variable' => 166,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'OpNamedScolonOrSubExpIn' => 387,
			'HashReference' => 97
		}
	},
	{#State 352
		ACTIONS => {
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 390,
			'HashDereference' => 106,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 353
		DEFAULT => -201
	},
	{#State 354
		ACTIONS => {
			")" => 391
		}
	},
	{#State 355
		ACTIONS => {
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP01_QW' => 165,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'MY' => 172,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'ARGV' => 169,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'HashReference' => 97,
			'TypeInner' => 171,
			'Expression' => 167,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Variable' => 166,
			'HashDereference' => 106,
			'SubExpression' => 164,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ListElement' => 162,
			'ListElements' => 392,
			'ArrayDereference' => 116
		}
	},
	{#State 356
		ACTIONS => {
			'OP21_LIST_COMMA' => 393
		}
	},
	{#State 357
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 394
		}
	},
	{#State 358
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP08_STRING_CAT' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			"]" => 396,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239
		}
	},
	{#State 359
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_STRING_CAT' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => 397,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245
		}
	},
	{#State 360
		ACTIONS => {
			'LPAREN' => -237,
			'OP02_METHOD_THINARROW_NEW' => -237,
			"}" => 398
		}
	},
	{#State 361
		DEFAULT => -222
	},
	{#State 362
		ACTIONS => {
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACE' => 124
		},
		GOTOS => {
			'HashReference' => 97,
			'Expression' => 167,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Variable' => 166,
			'HashDereference' => 106,
			'SubExpression' => 399,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 363
		DEFAULT => -231
	},
	{#State 364
		DEFAULT => -229
	},
	{#State 365
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 213,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			"%{" => 147,
			'OP23_LOGICAL_AND' => 199,
			'OP01_CLOSE' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP01_NAMED_VOID' => 209,
			'OP07_STRING_REPEAT' => 208,
			'ENV' => 198,
			'OP19_LOOP_CONTROL' => 197,
			'OP08_MATH_ADD_SUB' => 221,
			'OP01_OPEN' => 217,
			'LITERAL_STRING' => 109,
			'WORD' => 207,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 206,
			'VARIABLE_SYMBOL' => 132,
			'OP01_PRINT' => 214,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP10_NAMED_UNARY' => 204
		},
		GOTOS => {
			'Variable' => 205,
			'Literal' => 203,
			'OpStringOrWord' => 216,
			'VariableSymbolOrSelf' => 119,
			'HashEntry' => 400,
			'HashDereference' => 219,
			'VarOrLitOrOpStrOrWord' => 212
		}
	},
	{#State 366
		DEFAULT => -138
	},
	{#State 367
		ACTIONS => {
			")" => 401
		}
	},
	{#State 368
		DEFAULT => -145
	},
	{#State 369
		DEFAULT => -221
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 132,
			'LITERAL_STRING' => 109,
			'SELF' => 122,
			'LITERAL_NUMBER' => 141
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 119,
			'VariableOrLiteral' => 402,
			'Literal' => 316,
			'Variable' => 317
		}
	},
	{#State 371
		DEFAULT => -152
	},
	{#State 372
		DEFAULT => -154
	},
	{#State 373
		ACTIONS => {
			";" => 403
		}
	},
	{#State 374
		DEFAULT => -236
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 404
		}
	},
	{#State 376
		ACTIONS => {
			'SUB' => 406,
			'LITERAL_NUMBER' => 409
		},
		GOTOS => {
			'Method' => 408,
			'SubroutineOrMethod' => 407,
			'Subroutine' => 405
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
		ACTIONS => {
			'LPAREN' => 413
		}
	},
	{#State 381
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 414
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 383
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 384
		DEFAULT => -207
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 386
		DEFAULT => -259
	},
	{#State 387
		DEFAULT => -202
	},
	{#State 388
		DEFAULT => -260
	},
	{#State 389
		ACTIONS => {
			";" => 418
		}
	},
	{#State 390
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244,
			"]" => 419,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236
		}
	},
	{#State 391
		DEFAULT => -99
	},
	{#State 392
		ACTIONS => {
			")" => 420
		}
	},
	{#State 393
		ACTIONS => {
			'LITERAL_STRING' => 421
		}
	},
	{#State 394
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 422
		}
	},
	{#State 395
		ACTIONS => {
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 145,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP19_LOOP_CONTROL' => 140,
			'WORD' => 27,
			'OP01_NAMED_SCOLON' => 133,
			"\@{" => 134,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LBRACE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 126,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP05_LOGICAL_NEG' => 115,
			"if" => 117,
			'OP01_CLOSE' => 118,
			"foreach" => -171,
			'OP01_NAMED_VOID' => 113,
			'WORD_UPPERCASE' => 114,
			'WORD_SCOPED' => 28,
			'MY' => 103,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LPAREN' => 105,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 99,
			"for" => -171,
			'OP01_PRINT' => 101
		},
		GOTOS => {
			'VariableDeclaration' => 135,
			'SubExpression' => 136,
			'Operation' => 423,
			'HashDereference' => 106,
			'Statement' => 104,
			'OperatorVoid' => 102,
			'VariableModification' => 131,
			'PLUS-51' => 424,
			'LoopLabel' => 100,
			'PAREN-45' => 130,
			'HashReference' => 97,
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'Expression' => 123,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Conditional' => 137
		}
	},
	{#State 396
		DEFAULT => -198
	},
	{#State 397
		DEFAULT => -199
	},
	{#State 398
		DEFAULT => -200
	},
	{#State 399
		ACTIONS => {
			'OP08_STRING_CAT' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -224,
			'OP09_BITWISE_SHIFT' => 240,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP21_LIST_COMMA' => -224,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235
		}
	},
	{#State 400
		DEFAULT => -228
	},
	{#State 401
		DEFAULT => -153
	},
	{#State 402
		DEFAULT => -125
	},
	{#State 403
		DEFAULT => -140
	},
	{#State 404
		ACTIONS => {
			'OP01_OPEN' => 217,
			'WORD' => 207,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP08_MATH_ADD_SUB' => 221,
			'OP01_PRINT' => 214,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP22_LOGICAL_NEG' => 206,
			'OP23_LOGICAL_AND' => 199,
			'OP01_CLOSE' => 211,
			'OP12_COMPARE_EQ_NE' => 213,
			"}" => 426,
			'OP01_NAMED' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP01_NAMED_VOID' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 208,
			'OP19_LOOP_CONTROL' => 197
		},
		GOTOS => {
			'HashEntryProperties' => 425,
			'OpStringOrWord' => 427
		}
	},
	{#State 405
		DEFAULT => -93
	},
	{#State 406
		ACTIONS => {
			'WORD' => 428
		}
	},
	{#State 407
		DEFAULT => -74
	},
	{#State 408
		DEFAULT => -94
	},
	{#State 409
		ACTIONS => {
			";" => 429
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
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_CLOSE' => 118,
			'LBRACE' => 124,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 431,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'OP01_NAMED_SCOLON' => 432
		},
		GOTOS => {
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'SubExpression' => 433,
			'HashDereference' => 106,
			'OpNamedScolonOrSubExp' => 434,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 413
		ACTIONS => {
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			'LPAREN' => 105,
			"\@{" => 134,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 124,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 163,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Literal' => 144,
			'ArrayDereference' => 116,
			'SubExpression' => 435,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97
		}
	},
	{#State 414
		ACTIONS => {
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			"\@{" => 134,
			'LPAREN' => 105,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128,
			'FHREF_SYMBOL_IN' => 299,
			'LBRACE' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'STDIN' => 298
		},
		GOTOS => {
			'HashReference' => 97,
			'WordScoped' => 139,
			'ArrayReference' => 112,
			'Variable' => 166,
			'Expression' => 167,
			'SubExpressionOrInput' => 436,
			'SubExpression' => 301,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 415
		DEFAULT => -190
	},
	{#State 416
		ACTIONS => {
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_CLOSE' => 118,
			'ARGV' => 169,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'MY' => 172,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 134,
			'LPAREN' => 105,
			'LBRACE' => 124,
			'OP01_QW' => 165,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'TypeInner' => 171,
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 164,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'ListElements' => 437,
			'ListElement' => 162,
			'Literal' => 144
		}
	},
	{#State 417
		DEFAULT => -243
	},
	{#State 418
		DEFAULT => -261
	},
	{#State 419
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 438
		}
	},
	{#State 420
		DEFAULT => -101
	},
	{#State 421
		ACTIONS => {
			'OP21_LIST_COMMA' => 439
		}
	},
	{#State 422
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -182,
			'SELF' => -182,
			"undef" => -182,
			'' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'LBRACE' => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			'OP10_NAMED_UNARY' => -182,
			'VARIABLE_SYMBOL' => -182,
			"\@{" => -182,
			'OP01_NAMED_SCOLON' => -182,
			'WORD' => -182,
			'OP19_LOOP_CONTROL' => -182,
			"else" => 441,
			'OP01_NAMED' => -182,
			"}" => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			'LITERAL_NUMBER' => -182,
			'CONSTANT_CALL_SCOPED' => -182,
			"%{" => -182,
			'OP03_MATH_INC_DEC' => -182,
			"elsif" => 440,
			"while" => -182,
			'OP01_PRINT' => -182,
			'LBRACKET' => -182,
			"for" => -182,
			'MY' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'LPAREN' => -182,
			'OP01_OPEN' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			'LITERAL_STRING' => -182,
			"foreach" => -182,
			'OP01_NAMED_VOID' => -182,
			'WORD_UPPERCASE' => -182,
			'WORD_SCOPED' => -182,
			'OP05_LOGICAL_NEG' => -182,
			'OP01_CLOSE' => -182,
			"if" => -182
		},
		GOTOS => {
			'PAREN-47' => 443,
			'PAREN-49' => 442,
			'OPTIONAL-50' => 444
		}
	},
	{#State 423
		DEFAULT => -193
	},
	{#State 424
		ACTIONS => {
			"\@{" => 134,
			'OP01_NAMED_SCOLON' => 133,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'VARIABLE_SYMBOL' => 132,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'LBRACE' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			"}" => 445,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP19_LOOP_CONTROL' => 140,
			'LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'MY' => 103,
			'OP01_PRINT' => 101,
			'LBRACKET' => 99,
			"for" => -171,
			'OP03_MATH_INC_DEC' => 95,
			"while" => -171,
			'OP01_CLOSE' => 118,
			"if" => 117,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_UPPERCASE' => 114,
			'OP01_NAMED_VOID' => 113,
			'WORD_SCOPED' => 28,
			"foreach" => -171
		},
		GOTOS => {
			'LoopLabel' => 100,
			'VariableModification' => 131,
			'PAREN-45' => 130,
			'HashReference' => 97,
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'Expression' => 123,
			'SubExpression' => 136,
			'VariableDeclaration' => 135,
			'Operation' => 446,
			'HashDereference' => 106,
			'Statement' => 104,
			'OperatorVoid' => 102,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Conditional' => 137,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'ArrayDereference' => 116,
			'Literal' => 144
		}
	},
	{#State 425
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 447
		}
	},
	{#State 426
		ACTIONS => {
			";" => 448
		}
	},
	{#State 427
		ACTIONS => {
			'OP20_HASH_FATARROW' => 449
		}
	},
	{#State 428
		ACTIONS => {
			'LBRACE' => 450
		}
	},
	{#State 429
		DEFAULT => -76
	},
	{#State 430
		ACTIONS => {
			"}" => -58,
			'LPAREN_MY' => 452,
			'OP01_NAMED' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'LITERAL_NUMBER' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			"%{" => -58,
			'OP19_LOOP_CONTROL' => -58,
			'WORD' => -58,
			"\@{" => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'LBRACE' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'SELF' => -58,
			"undef" => -58,
			'VARIABLE_SYMBOL' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP01_CLOSE' => -58,
			"if" => -58,
			"foreach" => -58,
			'WORD_SCOPED' => -58,
			'OP01_NAMED_VOID' => -58,
			'WORD_UPPERCASE' => -58,
			'MY' => -58,
			'OP01_OPEN' => -58,
			'LITERAL_STRING' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'LPAREN' => -58,
			"while" => -58,
			'OP03_MATH_INC_DEC' => -58,
			'OP01_PRINT' => -58,
			'LBRACKET' => -58,
			"for" => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 451,
			'SubroutineArguments' => 453
		}
	},
	{#State 431
		DEFAULT => -257
	},
	{#State 432
		DEFAULT => -256
	},
	{#State 433
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP08_STRING_CAT' => 242,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP18_TERNARY' => 244,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP16_LOGICAL_OR' => 234,
			";" => 454,
			'OP17_LIST_RANGE' => 233,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245
		}
	},
	{#State 434
		ACTIONS => {
			'VARIABLE_SYMBOL' => 455
		}
	},
	{#State 435
		ACTIONS => {
			'OP17_LIST_RANGE' => 456,
			'OP16_LOGICAL_OR' => 234,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP08_STRING_CAT' => 242,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP18_TERNARY' => 244
		}
	},
	{#State 436
		ACTIONS => {
			")" => 457
		}
	},
	{#State 437
		ACTIONS => {
			")" => 458
		}
	},
	{#State 438
		ACTIONS => {
			"undef" => 459
		}
	},
	{#State 439
		ACTIONS => {
			'LPAREN' => 105,
			"\@{" => 134,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'LBRACE' => 124,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP01_NAMED' => 163,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 460,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167
		}
	},
	{#State 440
		ACTIONS => {
			'LPAREN' => 461
		}
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 462
		}
	},
	{#State 442
		DEFAULT => -181
	},
	{#State 443
		DEFAULT => -178
	},
	{#State 444
		DEFAULT => -183
	},
	{#State 445
		DEFAULT => -194
	},
	{#State 446
		DEFAULT => -192
	},
	{#State 447
		ACTIONS => {
			"}" => 463,
			'OP21_LIST_COMMA' => 465
		},
		GOTOS => {
			'PAREN-33' => 464
		}
	},
	{#State 448
		DEFAULT => -83
	},
	{#State 449
		ACTIONS => {
			'MY' => 466
		},
		GOTOS => {
			'TypeInnerProperties' => 467
		}
	},
	{#State 450
		ACTIONS => {
			'LBRACE' => 468
		}
	},
	{#State 451
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 469
		}
	},
	{#State 452
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD' => 179,
			'WORD_SCOPED' => 182
		},
		GOTOS => {
			'Type' => 470
		}
	},
	{#State 453
		DEFAULT => -57
	},
	{#State 454
		DEFAULT => -258
	},
	{#State 455
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 471
		}
	},
	{#State 456
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 122,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109
		},
		GOTOS => {
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Variable' => 166,
			'Expression' => 167,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 472,
			'HashDereference' => 106
		}
	},
	{#State 457
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 473
		}
	},
	{#State 458
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 474
		}
	},
	{#State 459
		ACTIONS => {
			";" => 475
		}
	},
	{#State 460
		ACTIONS => {
			'OP16_LOGICAL_OR' => 234,
			";" => -102,
			'OP17_LIST_RANGE' => 233,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => 236,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP21_LIST_COMMA' => -102,
			"]" => -102,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -102,
			'OP09_BITWISE_SHIFT' => 240,
			'OP08_STRING_CAT' => 242,
			")" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244
		}
	},
	{#State 461
		ACTIONS => {
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP01_NAMED' => 163,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			"undef" => 120,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACE' => 124,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 27
		},
		GOTOS => {
			'Literal' => 144,
			'ArrayDereference' => 116,
			'HashDereference' => 106,
			'SubExpression' => 476,
			'VariableSymbolOrSelf' => 119,
			'Operator' => 148,
			'Expression' => 167,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'HashReference' => 97
		}
	},
	{#State 462
		DEFAULT => -180
	},
	{#State 463
		ACTIONS => {
			";" => 477
		}
	},
	{#State 464
		DEFAULT => -80
	},
	{#State 465
		ACTIONS => {
			'OP01_PRINT' => 214,
			'OP10_NAMED_UNARY' => 204,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP22_LOGICAL_NEG' => 206,
			'WORD' => 207,
			'OP01_OPEN' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP08_MATH_ADD_SUB' => 221,
			'OP07_STRING_REPEAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP01_NAMED_VOID' => 209,
			'OP19_LOOP_CONTROL' => 197,
			'OP01_CLOSE' => 211,
			'OP23_LOGICAL_AND' => 199,
			'OP01_NAMED' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP12_COMPARE_EQ_NE' => 213
		},
		GOTOS => {
			'HashEntryProperties' => 478,
			'OpStringOrWord' => 427
		}
	},
	{#State 466
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD' => 179,
			'WORD_SCOPED' => 182
		},
		GOTOS => {
			'Type' => 479
		}
	},
	{#State 467
		DEFAULT => -227
	},
	{#State 468
		ACTIONS => {
			'MY' => 480
		}
	},
	{#State 469
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			"}" => 482,
			'OP01_NAMED' => 145,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP19_LOOP_CONTROL' => 140,
			'WORD' => 27,
			'OP01_NAMED_SCOLON' => 133,
			"\@{" => 134,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LBRACE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 126,
			"undef" => 120,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'OP05_LOGICAL_NEG' => 115,
			"if" => 117,
			'OP01_CLOSE' => 118,
			"foreach" => -171,
			'WORD_UPPERCASE' => 114,
			'OP01_NAMED_VOID' => 113,
			'WORD_SCOPED' => 28,
			'MY' => 103,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP01_OPEN' => 111,
			'LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 99,
			"for" => -171,
			'OP01_PRINT' => 101
		},
		GOTOS => {
			'Conditional' => 137,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'Expression' => 123,
			'HashReference' => 97,
			'LoopLabel' => 100,
			'VariableModification' => 131,
			'PAREN-45' => 130,
			'OperatorVoid' => 102,
			'Statement' => 104,
			'SubExpression' => 136,
			'VariableDeclaration' => 135,
			'HashDereference' => 106,
			'Operation' => 481
		}
	},
	{#State 470
		ACTIONS => {
			'VARIABLE_SYMBOL' => 483
		}
	},
	{#State 471
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 141,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY_SCOLON' => 431,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			"\@{" => 134,
			'OP01_NAMED_SCOLON' => 432,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109
		},
		GOTOS => {
			'HashReference' => 97,
			'Variable' => 166,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Expression' => 167,
			'SubExpression' => 433,
			'HashDereference' => 106,
			'OpNamedScolonOrSubExp' => 484,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'Literal' => 144,
			'ArrayDereference' => 116
		}
	},
	{#State 472
		ACTIONS => {
			")" => 485,
			'OP08_STRING_CAT' => 242,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => -124,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => -124,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 234,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP15_LOGICAL_AND' => 236
		}
	},
	{#State 473
		DEFAULT => -191
	},
	{#State 474
		DEFAULT => -189
	},
	{#State 475
		DEFAULT => -203
	},
	{#State 476
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			")" => 486,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235
		}
	},
	{#State 477
		DEFAULT => -82
	},
	{#State 478
		DEFAULT => -79
	},
	{#State 479
		ACTIONS => {
			"\$TYPED_" => 487
		}
	},
	{#State 480
		ACTIONS => {
			'TYPE_INTEGER' => 180,
			'WORD' => 179,
			'TYPE_METHOD' => 488,
			'WORD_SCOPED' => 182
		},
		GOTOS => {
			'Type' => 336
		}
	},
	{#State 481
		DEFAULT => -59
	},
	{#State 482
		DEFAULT => -61
	},
	{#State 483
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 489
		}
	},
	{#State 484
		ACTIONS => {
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'WORD' => 27
		},
		GOTOS => {
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 491,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'VariableModification' => 490,
			'SubExpressionOrVarMod' => 492,
			'HashReference' => 97,
			'ArrayReference' => 112,
			'Variable' => 127,
			'WordScoped' => 139,
			'Expression' => 167
		}
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 493
		}
	},
	{#State 486
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 494
		}
	},
	{#State 487
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 220,
			'OP01_OPEN' => 217,
			'WORD' => 207,
			'OP08_MATH_ADD_SUB' => 221,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP01_PRINT' => 214,
			'OP22_LOGICAL_NEG' => 206,
			'OP23_LOGICAL_AND' => 199,
			'OP01_CLOSE' => 211,
			'OP12_COMPARE_EQ_NE' => 213,
			'OP11_COMPARE_LT_GT' => 200,
			'OP01_NAMED' => 201,
			'OP19_LOOP_CONTROL' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP01_NAMED_VOID' => 209,
			'OP07_STRING_REPEAT' => 208
		},
		GOTOS => {
			'OpStringOrWord' => 495
		}
	},
	{#State 488
		ACTIONS => {
			"\$RETURN_TYPE" => 496
		}
	},
	{#State 489
		ACTIONS => {
			'OP21_LIST_COMMA' => 498,
			")" => 499
		},
		GOTOS => {
			'PAREN-26' => 497
		}
	},
	{#State 490
		DEFAULT => -168
	},
	{#State 491
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP15_LOGICAL_AND' => 236,
			'OP16_LOGICAL_OR' => 234,
			'OP17_LIST_RANGE' => 233,
			'OP13_BITWISE_AND' => 245,
			'OP06_REGEX_BIND' => 246,
			'OP08_MATH_ADD_SUB' => 237,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP23_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 243,
			'OP18_TERNARY' => 244,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP08_STRING_CAT' => 242,
			")" => -167
		}
	},
	{#State 492
		ACTIONS => {
			")" => 500
		}
	},
	{#State 493
		DEFAULT => -187
	},
	{#State 494
		DEFAULT => -177
	},
	{#State 495
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 502,
			'OP19_VARIABLE_ASSIGN' => 501
		}
	},
	{#State 496
		ACTIONS => {
			"}" => 503
		}
	},
	{#State 497
		DEFAULT => -63
	},
	{#State 498
		ACTIONS => {
			'MY' => 504
		}
	},
	{#State 499
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 505
		}
	},
	{#State 500
		ACTIONS => {
			'LBRACE' => 395
		},
		GOTOS => {
			'CodeBlock' => 506
		}
	},
	{#State 501
		ACTIONS => {
			'OP01_CLOSE' => 118,
			'CONSTANT_CALL_SCOPED' => 146,
			"%{" => 147,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 134,
			'LPAREN' => 105,
			'WORD' => 27,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'OP10_NAMED_UNARY' => 128,
			'VARIABLE_SYMBOL' => 132,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'SELF' => 122,
			"undef" => 120,
			'LBRACE' => 124
		},
		GOTOS => {
			'HashReference' => 97,
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'SubExpression' => 507,
			'HashDereference' => 106,
			'ArrayDereference' => 116,
			'Literal' => 144
		}
	},
	{#State 502
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			'LITERAL_NUMBER' => 141,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 118,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LPAREN' => 105,
			"\@{" => 134,
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD' => 27,
			"undef" => 120,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 121,
			'SELF' => 122,
			'LBRACE' => 124,
			'OP10_NAMED_UNARY' => 128,
			'LBRACKET' => 99,
			'VARIABLE_SYMBOL' => 132
		},
		GOTOS => {
			'WordScoped' => 139,
			'Variable' => 166,
			'ArrayReference' => 112,
			'Expression' => 167,
			'HashReference' => 97,
			'Literal' => 144,
			'ArrayDereference' => 116,
			'SubExpression' => 508,
			'HashDereference' => 106,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119
		}
	},
	{#State 503
		ACTIONS => {
			";" => 509
		}
	},
	{#State 504
		ACTIONS => {
			'WORD' => 179,
			'WORD_SCOPED' => 182,
			'TYPE_INTEGER' => 180
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
			'OP08_STRING_CAT' => 242,
			'OP11_COMPARE_LT_GT' => 248,
			"}" => -244,
			'OP09_BITWISE_SHIFT' => 240,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP18_TERNARY' => 244,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP14_BITWISE_OR_XOR' => 247,
			'OP21_LIST_COMMA' => -244,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP07_STRING_REPEAT' => 238,
			'OP08_MATH_ADD_SUB' => 237,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235
		}
	},
	{#State 508
		ACTIONS => {
			'OP18_TERNARY' => 244,
			'OP04_MATH_POW' => 243,
			'OP23_LOGICAL_AND' => 249,
			'OP08_STRING_CAT' => 242,
			'OP09_BITWISE_SHIFT' => 240,
			'OP11_COMPARE_LT_GT' => 248,
			'OP12_COMPARE_EQ_NE' => 241,
			'OP07_STRING_REPEAT' => 238,
			'OP07_MATH_MULT_DIV_MOD' => 239,
			'OP14_BITWISE_OR_XOR' => 247,
			"]" => 512,
			'OP06_REGEX_BIND' => 246,
			'OP13_BITWISE_AND' => 245,
			'OP08_MATH_ADD_SUB' => 237,
			'OP15_LOGICAL_AND' => 236,
			'OP24_LOGICAL_OR_XOR' => 235,
			'OP17_LIST_RANGE' => 233,
			'OP16_LOGICAL_OR' => 234
		}
	},
	{#State 509
		ACTIONS => {
			"foreach" => -85,
			'OP01_NAMED_VOID' => -85,
			'WORD_SCOPED' => -85,
			'WORD_UPPERCASE' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP01_CLOSE' => -85,
			"if" => -85,
			"while" => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP01_PRINT' => -85,
			"for" => -85,
			'LBRACKET' => -85,
			'MY' => -85,
			'OP01_OPEN' => -85,
			'LITERAL_STRING' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'LPAREN' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP19_LOOP_CONTROL' => -85,
			"}" => -85,
			'LPAREN_MY' => 513,
			'OP01_NAMED' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'LITERAL_NUMBER' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			"%{" => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'LBRACE' => -85,
			'SELF' => -85,
			'OP22_LOGICAL_NEG' => -85,
			"undef" => -85,
			'VARIABLE_SYMBOL' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'WORD' => -85,
			"\@{" => -85,
			'OP01_NAMED_SCOLON' => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 514,
			'MethodArguments' => 515
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
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 517
		}
	},
	{#State 513
		ACTIONS => {
			'WORD_SCOPED' => 182,
			'WORD' => 179,
			'TYPE_INTEGER' => 180
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 514
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 519
		}
	},
	{#State 515
		DEFAULT => -84
	},
	{#State 516
		DEFAULT => -62
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
			"foreach" => -171,
			'OP01_NAMED_VOID' => 113,
			'WORD_UPPERCASE' => 114,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_CLOSE' => 118,
			"if" => 117,
			"while" => -171,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_PRINT' => 101,
			'LBRACKET' => 99,
			"for" => -171,
			'MY' => 103,
			'OP01_OPEN' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 109,
			'LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'OP19_LOOP_CONTROL' => 140,
			"}" => 522,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 142,
			'LITERAL_NUMBER' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 143,
			"%{" => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_NAMED_VOID_SCOLON' => 126,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LBRACE' => 124,
			'SELF' => 122,
			'OP22_LOGICAL_NEG' => 121,
			"undef" => 120,
			'VARIABLE_SYMBOL' => 132,
			'OP10_NAMED_UNARY' => 128,
			'OP10_NAMED_UNARY_SCOLON' => 129,
			'WORD' => 27,
			"\@{" => 134,
			'OP01_NAMED_SCOLON' => 133
		},
		GOTOS => {
			'Statement' => 104,
			'OperatorVoid' => 102,
			'VariableDeclaration' => 135,
			'SubExpression' => 136,
			'Operation' => 523,
			'HashDereference' => 106,
			'OPTIONAL-46' => 96,
			'Variable' => 127,
			'Expression' => 123,
			'VariableModification' => 131,
			'LoopLabel' => 100,
			'PAREN-45' => 130,
			'HashReference' => 97,
			'ArrayDereference' => 116,
			'Literal' => 144,
			'Operator' => 148,
			'VariableSymbolOrSelf' => 119,
			'ArrayReference' => 112,
			'WordScoped' => 139,
			'Conditional' => 137
		}
	},
	{#State 520
		DEFAULT => -245
	},
	{#State 521
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 524
		}
	},
	{#State 522
		DEFAULT => -88
	},
	{#State 523
		DEFAULT => -86
	},
	{#State 524
		ACTIONS => {
			")" => 526,
			'OP21_LIST_COMMA' => 525
		},
		GOTOS => {
			'PAREN-37' => 527
		}
	},
	{#State 525
		ACTIONS => {
			'MY' => 528
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
			'WORD_SCOPED' => 182,
			'WORD' => 179,
			'TYPE_INTEGER' => 180
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
		DEFAULT => -92
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
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7779 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7786 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
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
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
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
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
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
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7911 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7932 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7939 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7946 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7960 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
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
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8014 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
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
#line 224 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8057 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 224 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 224 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 224 "lib/RPerl/Grammar.eyp"
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
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8103 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 225 "lib/RPerl/Grammar.eyp"
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
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
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
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8665 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
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
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8920 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8927 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
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
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8996 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9003 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9010 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
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
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9137 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
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
#line 264 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 264 "lib/RPerl/Grammar.eyp"
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
#line 269 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9286 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 269 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 269 "lib/RPerl/Grammar.eyp"
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
#line 271 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9362 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 271 "lib/RPerl/Grammar.eyp"
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
#line 272 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9387 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 272 "lib/RPerl/Grammar.eyp"
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
#line 273 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9423 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 273 "lib/RPerl/Grammar.eyp"
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
#line 275 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 275 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9488 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 275 "lib/RPerl/Grammar.eyp"
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
#line 276 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9524 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 276 "lib/RPerl/Grammar.eyp"
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

#line 297 "lib/RPerl/Grammar.eyp"


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


#line 10510 lib/RPerl/Grammar.pm



1;
