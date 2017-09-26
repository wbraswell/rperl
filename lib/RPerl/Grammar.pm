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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|package|foreach|\$TYPED_|\@ARG\;|undef|elsif|while|else|our|for|\%\{|\@\{|if|\]|\}|\;|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use\s+)/gc and return ('USE', $1);
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


#line 150 lib/RPerl/Grammar.pm

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
  [ 'Subroutine_48' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-17', 'STAR-18', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-20', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'SubroutineOrMethod' ], 0 ],
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
  [ 'Method_71' => 'Method', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'TYPE_METHOD', '$RETURN_TYPE', '}', ';', 'OPTIONAL-27', 'STAR-28', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'PAREN-29' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'MethodArguments_75' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-30', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_76' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_77' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
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
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
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
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_134' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_135' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-36', ')' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_143' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_144' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_145' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_146' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_147' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_148' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_149' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_150' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OPTIONAL-38', 'Loop' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_158' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'PAREN-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Conditional_165' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-40', 'OPTIONAL-42' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_168' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_169' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_170' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_171' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_172' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_173' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_176' => 'CodeBlock', [ 'LBRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_179' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_180' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_181' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_182' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_183' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_184' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_186' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_188' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'ListElements_192' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_194' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_195' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_196' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayReference_199' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-47', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayDereference_202' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_203' => 'ArrayDereference', [ '@{', 'OPTIONAL-48', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-49', 'SubExpression' ], 0 ],
  [ 'HashEntry_207' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_208' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_209' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [ 'STAR-51', 'PAREN-50' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [  ], 0 ],
  [ 'HashReference_213' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-51', '}' ], 0 ],
  [ 'HashReference_214' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'HashDereference_217' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_218' => 'HashDereference', [ '%{', 'OPTIONAL-52', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_220' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_221' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_222' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_223' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_224' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_225' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_226' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_227' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_228' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_229' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_230' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_231' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_232' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_233' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_234' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_235' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_236' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_237' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_238' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_239' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_240' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_241' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_242' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_243' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_244' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_245' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_246' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_247' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_248' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_249' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_250' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_251' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_252' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_253' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_254' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_255' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_256' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_257' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_258' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_259' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_260' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'SubroutineOrMethod_76' => 76,
  'SubroutineOrMethod_77' => 77,
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
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'Expression_134' => 134,
  'Expression_135' => 135,
  'Expression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpression_143' => 143,
  'SubExpression_144' => 144,
  'SubExpression_145' => 145,
  'SubExpressionOrInput_146' => 146,
  'SubExpressionOrInput_147' => 147,
  'SubExpressionOrInput_148' => 148,
  'SubExpressionOrVarMod_149' => 149,
  'SubExpressionOrVarMod_150' => 150,
  '_PAREN' => 151,
  '_OPTIONAL' => 152,
  '_OPTIONAL' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  'Statement_157' => 157,
  'Statement_158' => 158,
  '_PAREN' => 159,
  '_STAR_LIST' => 160,
  '_STAR_LIST' => 161,
  '_PAREN' => 162,
  '_OPTIONAL' => 163,
  '_OPTIONAL' => 164,
  'Conditional_165' => 165,
  'Loop_166' => 166,
  'Loop_167' => 167,
  'Loop_168' => 168,
  'LoopFor_169' => 169,
  'LoopFor_170' => 170,
  'LoopForEach_171' => 171,
  'LoopWhile_172' => 172,
  'LoopWhile_173' => 173,
  '_PLUS_LIST' => 174,
  '_PLUS_LIST' => 175,
  'CodeBlock_176' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  'Variable_179' => 179,
  'VariableRetrieval_180' => 180,
  'VariableRetrieval_181' => 181,
  'VariableRetrieval_182' => 182,
  'VariableDeclaration_183' => 183,
  'VariableDeclaration_184' => 184,
  'VariableDeclaration_185' => 185,
  'VariableDeclaration_186' => 186,
  'VariableModification_187' => 187,
  'VariableModification_188' => 188,
  '_PAREN' => 189,
  '_STAR_LIST' => 190,
  '_STAR_LIST' => 191,
  'ListElements_192' => 192,
  'ListElement_193' => 193,
  'ListElement_194' => 194,
  'ListElement_195' => 195,
  'ListElement_196' => 196,
  '_OPTIONAL' => 197,
  '_OPTIONAL' => 198,
  'ArrayReference_199' => 199,
  '_OPTIONAL' => 200,
  '_OPTIONAL' => 201,
  'ArrayDereference_202' => 202,
  'ArrayDereference_203' => 203,
  '_OPTIONAL' => 204,
  '_OPTIONAL' => 205,
  'HashEntry_206' => 206,
  'HashEntry_207' => 207,
  'HashEntry_208' => 208,
  'HashEntryProperties_209' => 209,
  '_PAREN' => 210,
  '_STAR_LIST' => 211,
  '_STAR_LIST' => 212,
  'HashReference_213' => 213,
  'HashReference_214' => 214,
  '_OPTIONAL' => 215,
  '_OPTIONAL' => 216,
  'HashDereference_217' => 217,
  'HashDereference_218' => 218,
  'WordScoped_219' => 219,
  'WordScoped_220' => 220,
  'LoopLabel_221' => 221,
  'Type_222' => 222,
  'Type_223' => 223,
  'Type_224' => 224,
  'TypeInner_225' => 225,
  'TypeInnerProperties_226' => 226,
  'TypeInnerProperties_227' => 227,
  'TypeInnerConstant_228' => 228,
  'VariableOrLiteral_229' => 229,
  'VariableOrLiteral_230' => 230,
  'VarOrLitOrOpStrOrWord_231' => 231,
  'VarOrLitOrOpStrOrWord_232' => 232,
  'VarOrLitOrOpStrOrWord_233' => 233,
  'VariableSymbolOrSelf_234' => 234,
  'VariableSymbolOrSelf_235' => 235,
  'Literal_236' => 236,
  'Literal_237' => 237,
  'OpNamedScolonOrSubExp_238' => 238,
  'OpNamedScolonOrSubExp_239' => 239,
  'OpNamedScolonOrSubExp_240' => 240,
  'OpNamedScolonOrSubExpIn_241' => 241,
  'OpNamedScolonOrSubExpIn_242' => 242,
  'OpNamedScolonOrSubExpIn_243' => 243,
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
  'OpStringOrWord_259' => 259,
  'OpStringOrWord_260' => 260,
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
	SELF => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	SUB => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 7,
			"package" => -20,
			"## no critic qw(" => 8,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'CompileUnit' => 6,
			'Critic' => 2,
			'Program' => 1,
			'PLUS-2' => 5,
			'PAREN-1' => 4,
			'ModuleHeader' => 9
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 11
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => -20,
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 12,
			'ModuleHeader' => 9,
			'Critic' => 2,
			'OPTIONAL-9' => 3
		}
	},
	{#State 6
		ACTIONS => {
			'' => 13
		}
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 8,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 15
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 17
		},
		GOTOS => {
			'PLUS-16' => 16
		}
	},
	{#State 9
		ACTIONS => {
			"use parent qw(" => 20,
			"## no critic qw(" => -27,
			"use constant" => -27,
			'SUB' => -27,
			'USE' => -27
		},
		GOTOS => {
			'STAR-11' => 22,
			'Package' => 18,
			'Class' => 19,
			'Module' => 21
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
		DEFAULT => -2
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			'USE_RPERL' => 24
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			'WORD' => 26,
			")" => 25
		}
	},
	{#State 17
		DEFAULT => -39
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 21
		DEFAULT => -1
	},
	{#State 22
		ACTIONS => {
			"## no critic qw(" => 8,
			'USE' => -29,
			'SUB' => -29,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 31,
			'Critic' => 30
		}
	},
	{#State 23
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 24
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 34
		}
	},
	{#State 25
		DEFAULT => -40
	},
	{#State 26
		DEFAULT => -38
	},
	{#State 27
		DEFAULT => -220
	},
	{#State 28
		ACTIONS => {
			")" => 35
		}
	},
	{#State 29
		DEFAULT => -219
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			'USE' => 38,
			"use constant" => -31,
			'SUB' => -31
		},
		GOTOS => {
			'STAR-13' => 37,
			'Include' => 36
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
		DEFAULT => -28
	},
	{#State 37
		ACTIONS => {
			'SUB' => 46,
			"use constant" => 47
		},
		GOTOS => {
			'Constant' => 45,
			'PLUS-14' => 44,
			'Subroutine' => 43
		}
	},
	{#State 38
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 48
		}
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
			"our" => -36,
			'USE_RPERL_AFTER' => 50
		},
		GOTOS => {
			'OPTIONAL-15' => 51
		}
	},
	{#State 41
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'WORD_SCOPED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"foreach" => -11,
			'OP10_NAMED_UNARY' => -11,
			"## no critic qw(" => 8,
			'SUB' => -11,
			'WORD' => -11,
			'USE' => -11,
			'OP01_PRINT' => -11,
			"while" => -11,
			'LITERAL_STRING' => -11,
			'LPAREN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if" => -11,
			'LBRACE' => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LBRACKET' => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'MY' => -11,
			"for" => -11,
			'SELF' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"%{" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID' => -11,
			"undef" => -11,
			"\@{" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11
		},
		GOTOS => {
			'Critic' => 52,
			'STAR-5' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'USE' => 38
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
			'LITERAL_NUMBER' => 55,
			'SUB' => 46
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			'WORD' => 57
		}
	},
	{#State 47
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 59,
			";" => 60
		}
	},
	{#State 49
		DEFAULT => -23
	},
	{#State 50
		DEFAULT => -35
	},
	{#State 51
		ACTIONS => {
			"our" => 61
		}
	},
	{#State 52
		DEFAULT => -8
	},
	{#State 53
		ACTIONS => {
			'OP01_PRINT' => -13,
			'USE' => 38,
			'WORD' => -13,
			'SUB' => -13,
			"while" => -13,
			"foreach" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP10_NAMED_UNARY' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'SELF' => -13,
			"for" => -13,
			'OP01_CLOSE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			"if" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			'LPAREN' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN' => -13,
			'LBRACKET' => -13,
			"use constant" => -13,
			'VARIABLE_SYMBOL' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"\@{" => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_UPPERCASE' => -13,
			"undef" => -13
		},
		GOTOS => {
			'Include' => 62,
			'STAR-6' => 63
		}
	},
	{#State 54
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 64
		}
	},
	{#State 55
		ACTIONS => {
			";" => 65
		}
	},
	{#State 56
		DEFAULT => -32
	},
	{#State 57
		ACTIONS => {
			'LBRACE' => 66
		}
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 59
		ACTIONS => {
			";" => 68
		}
	},
	{#State 60
		DEFAULT => -41
	},
	{#State 61
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 62
		DEFAULT => -10
	},
	{#State 63
		ACTIONS => {
			'OP01_NAMED_SCOLON' => -15,
			'OP01_NAMED' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			"use constant" => 47,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"%{" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED_VOID' => -15,
			"undef" => -15,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'WORD_SCOPED' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'OP10_NAMED_UNARY' => -15,
			'SUB' => -15,
			'WORD' => -15,
			'OP01_PRINT' => -15,
			"while" => -15,
			'LPAREN' => -15,
			'LITERAL_STRING' => -15,
			"if" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LBRACE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_CLOSE' => -15,
			'LBRACKET' => -15,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'MY' => -15,
			"for" => -15,
			'SELF' => -15
		},
		GOTOS => {
			'Constant' => 71,
			'STAR-7' => 70
		}
	},
	{#State 64
		ACTIONS => {
			"## no critic qw(" => 8,
			"use constant" => -56,
			'USE' => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'Critic' => 72,
			'STAR-22' => 73
		}
	},
	{#State 65
		DEFAULT => -34
	},
	{#State 66
		ACTIONS => {
			'LBRACE' => 74
		}
	},
	{#State 67
		ACTIONS => {
			'MY' => 75
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 68
		DEFAULT => -42
	},
	{#State 69
		DEFAULT => -37
	},
	{#State 70
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED_SCOLON' => 123,
			'OP01_NAMED' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			"undef" => 110,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID' => 112,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			"foreach" => -153,
			"while" => -153,
			'SUB' => 46,
			'WORD' => 29,
			'OP01_PRINT' => 107,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'OP19_LOOP_CONTROL' => 78,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			"if" => 87,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			"for" => -153,
			'SELF' => 90,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'MY' => 92
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Variable' => 82,
			'VariableSymbolOrSelf' => 85,
			'VariableDeclaration' => 111,
			'PAREN-37' => 93,
			'Conditional' => 118,
			'WordScoped' => 119,
			'VariableModification' => 91,
			'SubExpression' => 100,
			'Expression' => 99,
			'Operation' => 103,
			'Operator' => 124,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Statement' => 95,
			'OperatorVoid' => 96,
			'HashReference' => 109,
			'LoopLabel' => 108,
			'OPTIONAL-38' => 106,
			'PLUS-8' => 125,
			'Subroutine' => 126,
			'Literal' => 105
		}
	},
	{#State 71
		DEFAULT => -12
	},
	{#State 72
		DEFAULT => -53
	},
	{#State 73
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 38,
			"use constant" => -58
		},
		GOTOS => {
			'Include' => 131,
			'STAR-23' => 130
		}
	},
	{#State 74
		ACTIONS => {
			'MY' => 132
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 133,
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135
		},
		GOTOS => {
			'Type' => 136
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 89
		},
		GOTOS => {
			'Literal' => 137
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 141,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 78
		ACTIONS => {
			'WORD_UPPERCASE' => 144
		},
		GOTOS => {
			'LoopLabel' => 143
		}
	},
	{#State 79
		ACTIONS => {
			'MY' => 145
		}
	},
	{#State 80
		ACTIONS => {
			"%{" => 127,
			'ARGV' => 150,
			'OP01_QW' => 151,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"]" => -198,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'MY' => 153,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89
		},
		GOTOS => {
			'SubExpression' => 149,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'ListElements' => 148,
			'TypeInner' => 146,
			'OPTIONAL-47' => 152,
			'HashReference' => 109,
			'WordScoped' => 119,
			'ListElement' => 147,
			'Literal' => 105
		}
	},
	{#State 81
		ACTIONS => {
			'FHREF_SYMBOL' => 154
		}
	},
	{#State 82
		ACTIONS => {
			'OP07_STRING_REPEAT' => -140,
			'OP17_LIST_RANGE' => -140,
			'OP19_VARIABLE_ASSIGN_BY' => 158,
			'OP13_BITWISE_AND' => -140,
			'OP15_LOGICAL_AND' => -140,
			'OP06_REGEX_BIND' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			'OP18_TERNARY' => -140,
			'OP09_BITWISE_SHIFT' => -140,
			'OP02_METHOD_THINARROW' => 157,
			'OP16_LOGICAL_OR' => -140,
			'OP19_VARIABLE_ASSIGN' => 156,
			'OP12_COMPARE_EQ_NE' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			")" => -140,
			'OP08_STRING_CAT' => -140,
			'OP04_MATH_POW' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP03_MATH_INC_DEC' => 155,
			'OP11_COMPARE_LT_GT' => -140
		}
	},
	{#State 83
		ACTIONS => {
			'VARIABLE_SYMBOL' => 129,
			'SELF' => 90
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 85,
			'Variable' => 159
		}
	},
	{#State 84
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP01_CLOSE' => 175,
			'OP01_NAMED_VOID' => 162,
			'LITERAL_STRING' => 89,
			"}" => 160,
			'OP19_LOOP_CONTROL' => 173,
			'OP01_OPEN' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP01_PRINT' => 183,
			'WORD' => 184,
			'OP07_STRING_REPEAT' => 182,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			'ENV' => 166,
			'OP08_MATH_ADD_SUB' => 165,
			'OP01_NAMED' => 168,
			'OP23_LOGICAL_AND' => 167,
			'OP22_LOGICAL_NEG' => 180,
			'OP10_NAMED_UNARY' => 179
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 163,
			'OpStringOrWord' => 176,
			'HashEntry' => 164,
			'Literal' => 181,
			'Variable' => 174,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 169
		}
	},
	{#State 85
		DEFAULT => -178,
		GOTOS => {
			'STAR-44' => 185
		}
	},
	{#State 86
		ACTIONS => {
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'Operator' => 124,
			'Expression' => 140,
			'SubExpression' => 186,
			'ArrayDereference' => 114,
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119
		}
	},
	{#State 87
		ACTIONS => {
			'LPAREN' => 187
		}
	},
	{#State 88
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP01_PRINT' => 188,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 190
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'SubExpression' => 189,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85
		}
	},
	{#State 89
		DEFAULT => -237
	},
	{#State 90
		DEFAULT => -235
	},
	{#State 91
		ACTIONS => {
			";" => 191
		}
	},
	{#State 92
		ACTIONS => {
			'WORD' => 133,
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135,
			'TYPE_FHREF' => 192
		},
		GOTOS => {
			'Type' => 193
		}
	},
	{#State 93
		DEFAULT => -152
	},
	{#State 94
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			"%{" => 127,
			'ARGV' => 150,
			'OP01_QW' => 151,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			")" => -116,
			"\@{" => 116,
			'MY' => 153
		},
		GOTOS => {
			'OPTIONAL-33' => 194,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'ListElement' => 147,
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 149,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'Variable' => 142,
			'ListElements' => 195,
			'TypeInner' => 146
		}
	},
	{#State 95
		DEFAULT => -81
	},
	{#State 96
		DEFAULT => -156
	},
	{#State 97
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			"}" => -100,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'OP01_NAMED' => 138,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP18_TERNARY' => -100,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			"]" => -100,
			"%{" => 127,
			'OP15_LOGICAL_AND' => -100,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'OP04_MATH_POW' => -100,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'OP21_LIST_COMMA' => -100,
			'LBRACKET' => 80,
			'OP11_COMPARE_LT_GT' => -100,
			'OP01_OPEN' => 79,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			")" => -100,
			'OP08_STRING_CAT' => -100,
			'SELF' => 90,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP09_BITWISE_SHIFT' => -100,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'WORD' => 29,
			'OP17_LIST_RANGE' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP13_BITWISE_AND' => -100
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'ArrayDereference' => 114,
			'SubExpression' => 196,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85
		}
	},
	{#State 98
		DEFAULT => -141
	},
	{#State 99
		ACTIONS => {
			'OP13_BITWISE_AND' => -137,
			'OP15_LOGICAL_AND' => -137,
			";" => 197,
			'OP17_LIST_RANGE' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP18_TERNARY' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP06_REGEX_BIND' => -137,
			'OP08_STRING_CAT' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP04_MATH_POW' => -137
		}
	},
	{#State 100
		ACTIONS => {
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198
		}
	},
	{#State 101
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 215,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'Variable' => 142,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 102
		DEFAULT => -133
	},
	{#State 103
		DEFAULT => -17
	},
	{#State 104
		DEFAULT => -80
	},
	{#State 105
		DEFAULT => -139
	},
	{#State 106
		ACTIONS => {
			"foreach" => 218,
			"while" => 217,
			"for" => 219
		},
		GOTOS => {
			'LoopFor' => 216,
			'LoopForEach' => 221,
			'Loop' => 220,
			'LoopWhile' => 222
		}
	},
	{#State 107
		ACTIONS => {
			'OP01_NAMED' => -114,
			'CONSTANT_CALL_SCOPED' => -114,
			'WORD_SCOPED' => -114,
			'OP22_LOGICAL_NEG' => -114,
			'OP10_NAMED_UNARY' => -114,
			'OP05_MATH_NEG_LPAREN' => -114,
			'WORD' => -114,
			'OP01_QW' => -114,
			'VARIABLE_SYMBOL' => -114,
			'FHREF_SYMBOL_BRACES' => 223,
			"%{" => -114,
			'STDOUT_STDERR' => 226,
			'ARGV' => -114,
			'LBRACE' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'OP01_CLOSE' => -114,
			'LITERAL_STRING' => -114,
			'LPAREN' => -114,
			'OP05_LOGICAL_NEG' => -114,
			'WORD_UPPERCASE' => -114,
			"undef" => -114,
			'OP05_BITWISE_NEG_LPAREN' => -114,
			'LBRACKET' => -114,
			'OP01_OPEN' => -114,
			'MY' => -114,
			'LITERAL_NUMBER' => -114,
			"\@{" => -114,
			'SELF' => -114
		},
		GOTOS => {
			'PAREN-31' => 224,
			'OPTIONAL-32' => 225
		}
	},
	{#State 108
		ACTIONS => {
			'COLON' => 227
		}
	},
	{#State 109
		DEFAULT => -143
	},
	{#State 110
		DEFAULT => -138
	},
	{#State 111
		DEFAULT => -157
	},
	{#State 112
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'ARGV' => 150,
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'MY' => 153
		},
		GOTOS => {
			'ListElements' => 228,
			'TypeInner' => 146,
			'Variable' => 142,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 149,
			'Operator' => 124,
			'Literal' => 105,
			'ListElement' => 147,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 113
		ACTIONS => {
			'COLON' => -221,
			'LPAREN' => 229
		}
	},
	{#State 114
		DEFAULT => -142
	},
	{#State 115
		DEFAULT => -119
	},
	{#State 116
		ACTIONS => {
			'SELF' => 90,
			'LBRACKET' => -201,
			'MY' => 153,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 85,
			'Variable' => 231,
			'OPTIONAL-48' => 230,
			'TypeInner' => 232
		}
	},
	{#State 117
		DEFAULT => -236
	},
	{#State 118
		DEFAULT => -154
	},
	{#State 119
		ACTIONS => {
			'LPAREN' => 234,
			'OP02_METHOD_THINARROW_NEW' => 233
		}
	},
	{#State 120
		ACTIONS => {
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127
		},
		GOTOS => {
			'Operator' => 124,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 235,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'ARGV' => 150,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'MY' => 153,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'ListElement' => 236,
			'HashReference' => 109,
			'TypeInner' => 146,
			'Operator' => 124,
			'ArrayDereference' => 114,
			'SubExpression' => 237,
			'Expression' => 140,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Variable' => 142
		}
	},
	{#State 122
		DEFAULT => -144
	},
	{#State 123
		DEFAULT => -79
	},
	{#State 124
		DEFAULT => -131
	},
	{#State 125
		ACTIONS => {
			"%{" => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'VARIABLE_SYMBOL' => 129,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 121,
			'OP01_NAMED_SCOLON' => 123,
			'' => -18,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_NAMED_VOID_SCOLON' => 115,
			"undef" => 110,
			'OP01_NAMED_VOID' => 112,
			'WORD_UPPERCASE' => 113,
			"while" => -153,
			'WORD' => 29,
			'OP01_PRINT' => 107,
			'OP10_NAMED_UNARY' => 97,
			"foreach" => -153,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 101,
			'SELF' => 90,
			"for" => -153,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'MY' => 92,
			'OP19_LOOP_CONTROL' => 78,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			"if" => 87
		},
		GOTOS => {
			'PAREN-37' => 93,
			'WordScoped' => 119,
			'VariableModification' => 91,
			'Conditional' => 118,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 82,
			'ArrayDereference' => 114,
			'VariableDeclaration' => 111,
			'LoopLabel' => 108,
			'HashReference' => 109,
			'Literal' => 105,
			'OPTIONAL-38' => 106,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Operation' => 238,
			'Operator' => 124,
			'SubExpression' => 100,
			'Expression' => 99,
			'Statement' => 95,
			'OperatorVoid' => 96
		}
	},
	{#State 126
		DEFAULT => -14
	},
	{#State 127
		ACTIONS => {
			'LBRACE' => -216,
			'VARIABLE_SYMBOL' => 129,
			'MY' => 153,
			'SELF' => 90
		},
		GOTOS => {
			'TypeInner' => 239,
			'OPTIONAL-52' => 240,
			'Variable' => 241,
			'VariableSymbolOrSelf' => 85
		}
	},
	{#State 128
		DEFAULT => -123
	},
	{#State 129
		DEFAULT => -234
	},
	{#State 130
		ACTIONS => {
			"our hashref \$properties" => 243,
			"use constant" => 47
		},
		GOTOS => {
			'Constant' => 244,
			'Properties' => 242
		}
	},
	{#State 131
		DEFAULT => -55
	},
	{#State 132
		ACTIONS => {
			'WORD' => 133,
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135
		},
		GOTOS => {
			'Type' => 245
		}
	},
	{#State 133
		DEFAULT => -222
	},
	{#State 134
		DEFAULT => -223
	},
	{#State 135
		DEFAULT => -224
	},
	{#State 136
		ACTIONS => {
			"\$TYPED_" => 246
		}
	},
	{#State 137
		ACTIONS => {
			";" => 247
		}
	},
	{#State 138
		ACTIONS => {
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'SubExpression' => 248,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122
		}
	},
	{#State 139
		ACTIONS => {
			'LPAREN' => 229
		}
	},
	{#State 140
		DEFAULT => -137
	},
	{#State 141
		ACTIONS => {
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			")" => 249,
			'OP08_STRING_CAT' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214
		}
	},
	{#State 142
		ACTIONS => {
			")" => -140,
			'OP08_STRING_CAT' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP12_COMPARE_EQ_NE' => -140,
			"}" => -140,
			'OP21_LIST_COMMA' => -140,
			'OP11_COMPARE_LT_GT' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			'OP03_MATH_INC_DEC' => 155,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP04_MATH_POW' => -140,
			'OP13_BITWISE_AND' => -140,
			'OP15_LOGICAL_AND' => -140,
			";" => -140,
			'OP17_LIST_RANGE' => -140,
			"]" => -140,
			'OP07_STRING_REPEAT' => -140,
			'OP02_METHOD_THINARROW' => 157,
			'OP18_TERNARY' => -140,
			'OP09_BITWISE_SHIFT' => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			'OP06_REGEX_BIND' => -140
		}
	},
	{#State 143
		ACTIONS => {
			";" => 250
		}
	},
	{#State 144
		DEFAULT => -221
	},
	{#State 145
		ACTIONS => {
			'TYPE_FHREF' => 251
		}
	},
	{#State 146
		ACTIONS => {
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139
		},
		GOTOS => {
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'SubExpression' => 252,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124
		}
	},
	{#State 147
		DEFAULT => -191,
		GOTOS => {
			'STAR-46' => 253
		}
	},
	{#State 148
		DEFAULT => -197
	},
	{#State 149
		ACTIONS => {
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP21_LIST_COMMA' => -193,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => -193,
			'OP08_STRING_CAT' => 210,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 207,
			"]" => -193,
			";" => -193,
			'OP17_LIST_RANGE' => 206,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198
		}
	},
	{#State 150
		DEFAULT => -196
	},
	{#State 151
		DEFAULT => -195
	},
	{#State 152
		ACTIONS => {
			"]" => 254
		}
	},
	{#State 153
		ACTIONS => {
			'WORD' => 133,
			'TYPE_INTEGER' => 135,
			'WORD_SCOPED' => 134
		},
		GOTOS => {
			'Type' => 255
		}
	},
	{#State 154
		DEFAULT => -86
	},
	{#State 155
		DEFAULT => -88
	},
	{#State 156
		ACTIONS => {
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'FHREF_SYMBOL_IN' => 259,
			"%{" => 127,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'STDIN' => 256,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79
		},
		GOTOS => {
			'Expression' => 140,
			'SubExpression' => 258,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'HashReference' => 109,
			'SubExpressionOrInput' => 257,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 157
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 158
		ACTIONS => {
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127
		},
		GOTOS => {
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'SubExpression' => 261,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 159
		DEFAULT => -87
	},
	{#State 160
		DEFAULT => -214
	},
	{#State 161
		DEFAULT => -244
	},
	{#State 162
		DEFAULT => -258
	},
	{#State 163
		ACTIONS => {
			'OP20_HASH_FATARROW' => 262
		}
	},
	{#State 164
		DEFAULT => -212,
		GOTOS => {
			'STAR-51' => 263
		}
	},
	{#State 165
		DEFAULT => -252
	},
	{#State 166
		DEFAULT => -208
	},
	{#State 167
		DEFAULT => -245
	},
	{#State 168
		DEFAULT => -255
	},
	{#State 169
		DEFAULT => -207
	},
	{#State 170
		DEFAULT => -247
	},
	{#State 171
		DEFAULT => -257
	},
	{#State 172
		DEFAULT => -250
	},
	{#State 173
		DEFAULT => -248
	},
	{#State 174
		DEFAULT => -231
	},
	{#State 175
		DEFAULT => -256
	},
	{#State 176
		DEFAULT => -233
	},
	{#State 177
		DEFAULT => -253
	},
	{#State 178
		DEFAULT => -249
	},
	{#State 179
		DEFAULT => -251
	},
	{#State 180
		DEFAULT => -246
	},
	{#State 181
		DEFAULT => -232
	},
	{#State 182
		DEFAULT => -254
	},
	{#State 183
		DEFAULT => -259
	},
	{#State 184
		DEFAULT => -260
	},
	{#State 185
		ACTIONS => {
			"]" => -179,
			'OP07_STRING_REPEAT' => -179,
			'OP17_LIST_RANGE' => -179,
			'COLON' => -179,
			";" => -179,
			'OP15_LOGICAL_AND' => -179,
			'OP19_VARIABLE_ASSIGN_BY' => -179,
			'OP13_BITWISE_AND' => -179,
			'OP20_HASH_FATARROW' => -179,
			'OP06_REGEX_BIND' => -179,
			'OP08_MATH_ADD_SUB' => -179,
			'OP23_LOGICAL_AND' => -179,
			'OP16_LOGICAL_OR' => -179,
			'OP02_METHOD_THINARROW' => -179,
			'OP18_TERNARY' => -179,
			'OP09_BITWISE_SHIFT' => -179,
			'OP19_VARIABLE_ASSIGN' => -179,
			'OP12_COMPARE_EQ_NE' => -179,
			'OP07_MATH_MULT_DIV_MOD' => -179,
			'OP08_STRING_CAT' => -179,
			")" => -179,
			'OP02_ARRAY_THINARROW' => 265,
			'OP04_MATH_POW' => -179,
			'OP03_MATH_INC_DEC' => -179,
			'OP24_LOGICAL_OR_XOR' => -179,
			'OP14_BITWISE_OR_XOR' => -179,
			'OP02_HASH_THINARROW' => 266,
			'OP11_COMPARE_LT_GT' => -179,
			'OP21_LIST_COMMA' => -179,
			"}" => -179
		},
		GOTOS => {
			'VariableRetrieval' => 264
		}
	},
	{#State 186
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -91,
			'OP21_LIST_COMMA' => -91,
			"}" => -91,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			")" => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			'OP06_REGEX_BIND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			"]" => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91
		}
	},
	{#State 187
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116
		},
		GOTOS => {
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Expression' => 140,
			'SubExpression' => 267,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119
		}
	},
	{#State 188
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 268
		}
	},
	{#State 189
		ACTIONS => {
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP06_REGEX_BIND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			")" => 269,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP11_COMPARE_LT_GT' => 213
		}
	},
	{#State 190
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 127,
			'ARGV' => 150,
			'OP01_QW' => 151,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'MY' => 153
		},
		GOTOS => {
			'WordScoped' => 119,
			'ListElement' => 270,
			'Literal' => 105,
			'HashReference' => 109,
			'TypeInner' => 146,
			'Operator' => 124,
			'SubExpression' => 237,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142
		}
	},
	{#State 191
		DEFAULT => -158
	},
	{#State 192
		ACTIONS => {
			'FHREF_SYMBOL' => 271
		}
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 272
		}
	},
	{#State 194
		ACTIONS => {
			")" => 273
		}
	},
	{#State 195
		DEFAULT => -115
	},
	{#State 196
		ACTIONS => {
			")" => -99,
			'OP08_STRING_CAT' => 210,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			"}" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP04_MATH_POW' => 214,
			'OP13_BITWISE_AND' => -99,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP07_STRING_REPEAT' => 207,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202
		}
	},
	{#State 197
		DEFAULT => -78
	},
	{#State 198
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'Operator' => 124,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 274,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 199
		ACTIONS => {
			'VARIABLE_SYMBOL' => 129,
			'LITERAL_STRING' => 89,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'Variable' => 275,
			'VariableSymbolOrSelf' => 85,
			'VariableOrLiteral' => 277,
			'Literal' => 276
		}
	},
	{#State 200
		ACTIONS => {
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'Operator' => 124,
			'SubExpression' => 278,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Variable' => 142,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 201
		ACTIONS => {
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 279,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 202
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 280
		}
	},
	{#State 203
		ACTIONS => {
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88
		},
		GOTOS => {
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109,
			'Variable' => 142,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'ArrayDereference' => 114,
			'SubExpression' => 281,
			'Expression' => 140,
			'Operator' => 124
		}
	},
	{#State 204
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 282,
			'Operator' => 124,
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119
		}
	},
	{#State 205
		ACTIONS => {
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'Operator' => 124,
			'SubExpression' => 283,
			'Expression' => 140,
			'ArrayDereference' => 114
		}
	},
	{#State 206
		ACTIONS => {
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90
		},
		GOTOS => {
			'Variable' => 142,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'SubExpression' => 284,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 207
		ACTIONS => {
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29
		},
		GOTOS => {
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'SubExpression' => 285,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124
		}
	},
	{#State 208
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'Expression' => 140,
			'SubExpression' => 286,
			'ArrayDereference' => 114,
			'Operator' => 124
		}
	},
	{#State 209
		ACTIONS => {
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'SubExpression' => 287,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122
		}
	},
	{#State 210
		ACTIONS => {
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 288,
			'Operator' => 124,
			'Variable' => 142,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98
		}
	},
	{#State 211
		ACTIONS => {
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109,
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 289,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142
		}
	},
	{#State 212
		ACTIONS => {
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89
		},
		GOTOS => {
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'Variable' => 142,
			'Operator' => 124,
			'Expression' => 140,
			'SubExpression' => 290,
			'ArrayDereference' => 114,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 213
		ACTIONS => {
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127
		},
		GOTOS => {
			'SubExpression' => 291,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 214
		ACTIONS => {
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109,
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 292,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'Variable' => 142
		}
	},
	{#State 215
		ACTIONS => {
			'OP23_LOGICAL_AND' => -109,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			";" => -109,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			"]" => -109,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP04_MATH_POW' => 214,
			"}" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => -109,
			'OP08_STRING_CAT' => 210
		}
	},
	{#State 216
		DEFAULT => -166
	},
	{#State 217
		ACTIONS => {
			'LPAREN' => 294,
			'LPAREN_MY' => 293
		}
	},
	{#State 218
		ACTIONS => {
			'MY' => 295
		}
	},
	{#State 219
		ACTIONS => {
			'LPAREN_MY' => 296,
			'MY' => 297
		}
	},
	{#State 220
		DEFAULT => -155
	},
	{#State 221
		DEFAULT => -167
	},
	{#State 222
		DEFAULT => -168
	},
	{#State 223
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'ARGV' => 150,
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'MY' => 153
		},
		GOTOS => {
			'HashReference' => 109,
			'ListElement' => 147,
			'Literal' => 105,
			'WordScoped' => 119,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'Operator' => 124,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 149,
			'ListElements' => 298,
			'TypeInner' => 146
		}
	},
	{#State 224
		DEFAULT => -113
	},
	{#State 225
		ACTIONS => {
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'MY' => 153,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP01_QW' => 151,
			'ARGV' => 150,
			"%{" => 127
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'ListElement' => 147,
			'Literal' => 105,
			'SubExpression' => 149,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'TypeInner' => 146,
			'ListElements' => 299
		}
	},
	{#State 226
		DEFAULT => -112
	},
	{#State 227
		DEFAULT => -151
	},
	{#State 228
		ACTIONS => {
			";" => 300
		}
	},
	{#State 229
		ACTIONS => {
			")" => 301
		}
	},
	{#State 230
		ACTIONS => {
			'LBRACKET' => 80
		},
		GOTOS => {
			'ArrayReference' => 302
		}
	},
	{#State 231
		ACTIONS => {
			"}" => 303
		}
	},
	{#State 232
		DEFAULT => -200
	},
	{#State 233
		ACTIONS => {
			'LBRACE' => 84,
			")" => -130
		},
		GOTOS => {
			'HashReference' => 304,
			'OPTIONAL-36' => 305
		}
	},
	{#State 234
		ACTIONS => {
			'MY' => 153,
			")" => -126,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP01_QW' => 151,
			'ARGV' => 150,
			"%{" => 127,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120
		},
		GOTOS => {
			'TypeInner' => 146,
			'ListElements' => 307,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'SubExpression' => 149,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'OPTIONAL-34' => 306,
			'Operator' => 124,
			'ListElement' => 147,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => 308,
			'OP08_STRING_CAT' => 210,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP11_COMPARE_LT_GT' => 213
		}
	},
	{#State 236
		ACTIONS => {
			'OP21_LIST_COMMA' => 309
		}
	},
	{#State 237
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -193,
			'OP11_COMPARE_LT_GT' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP08_STRING_CAT' => -83,
			")" => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP18_TERNARY' => -83,
			'OP17_LIST_RANGE' => -83,
			";" => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP13_BITWISE_AND' => -83
		}
	},
	{#State 238
		DEFAULT => -16
	},
	{#State 239
		DEFAULT => -215
	},
	{#State 240
		ACTIONS => {
			'LBRACE' => 84
		},
		GOTOS => {
			'HashReference' => 310
		}
	},
	{#State 241
		ACTIONS => {
			"}" => 311
		}
	},
	{#State 242
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 312
		}
	},
	{#State 243
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 244
		DEFAULT => -57
	},
	{#State 245
		ACTIONS => {
			"\$RETURN_TYPE" => 314
		}
	},
	{#State 246
		ACTIONS => {
			'WORD_UPPERCASE' => 315
		}
	},
	{#State 247
		DEFAULT => -43
	},
	{#State 248
		ACTIONS => {
			'OP13_BITWISE_AND' => -83,
			'OP15_LOGICAL_AND' => -83,
			"]" => -83,
			'OP07_STRING_REPEAT' => -83,
			";" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP18_TERNARY' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP06_REGEX_BIND' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			")" => -83,
			'OP08_STRING_CAT' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			"}" => -83,
			'OP21_LIST_COMMA' => -83,
			'OP04_MATH_POW' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP24_LOGICAL_OR_XOR' => -83
		}
	},
	{#State 249
		DEFAULT => -90
	},
	{#State 250
		DEFAULT => -124
	},
	{#State 251
		ACTIONS => {
			'FHREF_SYMBOL' => 316
		}
	},
	{#State 252
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP21_LIST_COMMA' => -194,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			")" => -194,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP06_REGEX_BIND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP17_LIST_RANGE' => 206,
			";" => -194,
			'OP07_STRING_REPEAT' => 207,
			"]" => -194,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205
		}
	},
	{#State 253
		ACTIONS => {
			")" => -192,
			'OP21_LIST_COMMA' => 318,
			"]" => -192,
			";" => -192
		},
		GOTOS => {
			'PAREN-45' => 317
		}
	},
	{#State 254
		DEFAULT => -199
	},
	{#State 255
		ACTIONS => {
			"\$TYPED_" => 319
		}
	},
	{#State 256
		DEFAULT => -148
	},
	{#State 257
		DEFAULT => -187
	},
	{#State 258
		ACTIONS => {
			'OP08_STRING_CAT' => 210,
			")" => -146,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP17_LIST_RANGE' => 206,
			";" => -146,
			'OP07_STRING_REPEAT' => 207,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP06_REGEX_BIND' => 202
		}
	},
	{#State 259
		DEFAULT => -147
	},
	{#State 260
		ACTIONS => {
			'VARIABLE_SYMBOL' => 129,
			'OP01_QW' => 151,
			'WORD' => 29,
			'ARGV' => 150,
			"%{" => 127,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'MY' => 153,
			'SELF' => 90,
			")" => -128,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'ListElement' => 147,
			'Literal' => 105,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 149,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'OPTIONAL-35' => 321,
			'TypeInner' => 146,
			'ListElements' => 320
		}
	},
	{#State 261
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 207,
			";" => -188,
			'OP17_LIST_RANGE' => 206,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			")" => -188,
			'OP08_STRING_CAT' => 210
		}
	},
	{#State 262
		ACTIONS => {
			"\@{" => -205,
			'LITERAL_NUMBER' => -205,
			'SELF' => -205,
			'MY' => 153,
			'LBRACKET' => -205,
			'OP01_OPEN' => -205,
			"undef" => -205,
			'OP05_BITWISE_NEG_LPAREN' => -205,
			'LITERAL_STRING' => -205,
			'LPAREN' => -205,
			'OP05_LOGICAL_NEG' => -205,
			'WORD_UPPERCASE' => -205,
			'LBRACE' => -205,
			'OP03_MATH_INC_DEC' => -205,
			'OP01_CLOSE' => -205,
			"%{" => -205,
			'VARIABLE_SYMBOL' => -205,
			'WORD' => -205,
			'OP10_NAMED_UNARY' => -205,
			'OP05_MATH_NEG_LPAREN' => -205,
			'WORD_SCOPED' => -205,
			'CONSTANT_CALL_SCOPED' => -205,
			'OP22_LOGICAL_NEG' => -205,
			'OP01_NAMED' => -205
		},
		GOTOS => {
			'TypeInner' => 322,
			'OPTIONAL-49' => 323
		}
	},
	{#State 263
		ACTIONS => {
			"}" => 324,
			'OP21_LIST_COMMA' => 326
		},
		GOTOS => {
			'PAREN-50' => 325
		}
	},
	{#State 264
		DEFAULT => -177
	},
	{#State 265
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109,
			'Operator' => 124,
			'Expression' => 140,
			'SubExpression' => 327,
			'ArrayDereference' => 114,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'Variable' => 142
		}
	},
	{#State 266
		ACTIONS => {
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 329,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90
		},
		GOTOS => {
			'ArrayDereference' => 114,
			'SubExpression' => 328,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 267
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_STRING_CAT' => 210,
			")" => 330,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206
		}
	},
	{#State 268
		ACTIONS => {
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'MY' => 153,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'ARGV' => 150
		},
		GOTOS => {
			'WordScoped' => 119,
			'ListElement' => 147,
			'Literal' => 105,
			'HashReference' => 109,
			'ListElements' => 331,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122
		}
	},
	{#State 269
		DEFAULT => -145
	},
	{#State 270
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 271
		ACTIONS => {
			";" => 333
		}
	},
	{#State 272
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 335,
			'OP02_ARRAY_THINARROW' => 336,
			";" => 334
		}
	},
	{#State 273
		ACTIONS => {
			";" => 337
		}
	},
	{#State 274
		ACTIONS => {
			'OP07_STRING_REPEAT' => 207,
			"]" => -105,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => 200,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			")" => -105,
			'OP08_STRING_CAT' => 210,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -105,
			'OP21_LIST_COMMA' => -105
		}
	},
	{#State 275
		DEFAULT => -229
	},
	{#State 276
		DEFAULT => -230
	},
	{#State 277
		ACTIONS => {
			'COLON' => 338
		}
	},
	{#State 278
		ACTIONS => {
			")" => -96,
			'OP08_STRING_CAT' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			"}" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP04_MATH_POW' => 214,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			";" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP07_STRING_REPEAT' => 207,
			"]" => -96,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP06_REGEX_BIND' => 202
		}
	},
	{#State 279
		ACTIONS => {
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -110,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP17_LIST_RANGE' => 206,
			";" => -110,
			"]" => -110,
			'OP07_STRING_REPEAT' => 207,
			'OP21_LIST_COMMA' => -110,
			"}" => -110,
			'OP11_COMPARE_LT_GT' => 213,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP08_STRING_CAT' => 210,
			")" => -110,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211
		}
	},
	{#State 280
		DEFAULT => -93
	},
	{#State 281
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			")" => -111,
			'OP08_STRING_CAT' => 210,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP04_MATH_POW' => 214,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -111,
			'OP17_LIST_RANGE' => 206,
			"]" => -111,
			'OP07_STRING_REPEAT' => 207,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208
		}
	},
	{#State 282
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => -104,
			'OP07_STRING_REPEAT' => 207,
			"]" => -104,
			'OP17_LIST_RANGE' => -104,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => 205,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => 213,
			'OP21_LIST_COMMA' => -104,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			")" => -104
		}
	},
	{#State 283
		ACTIONS => {
			'OP08_STRING_CAT' => 210,
			")" => -103,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			'OP21_LIST_COMMA' => -103,
			"}" => -103,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP07_STRING_REPEAT' => 207,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			";" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 209,
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -103
		}
	},
	{#State 284
		ACTIONS => {
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => -107,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -107,
			'OP06_REGEX_BIND' => 202,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP17_LIST_RANGE' => undef,
			";" => -107,
			'OP07_STRING_REPEAT' => 207,
			"]" => -107,
			'OP21_LIST_COMMA' => -107,
			"}" => -107,
			'OP11_COMPARE_LT_GT' => 213,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP08_STRING_CAT' => 210,
			")" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212
		}
	},
	{#State 285
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP18_TERNARY' => -94,
			'OP16_LOGICAL_OR' => -94,
			"]" => -94,
			'OP07_STRING_REPEAT' => -94,
			";" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			"}" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			")" => -94,
			'OP08_STRING_CAT' => -94
		}
	},
	{#State 286
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP08_STRING_CAT' => 210,
			")" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP21_LIST_COMMA' => -106,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => -106,
			";" => -106,
			"]" => -106,
			'OP07_STRING_REPEAT' => 207,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_BIND' => 202,
			'OP16_LOGICAL_OR' => -106,
			'OP18_TERNARY' => -106,
			'OP09_BITWISE_SHIFT' => 209
		}
	},
	{#State 287
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 200,
			'OP09_BITWISE_SHIFT' => -98,
			'OP18_TERNARY' => -98,
			'OP16_LOGICAL_OR' => -98,
			"]" => -98,
			'OP07_STRING_REPEAT' => 207,
			";" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			"}" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => -98,
			'OP08_STRING_CAT' => 210
		}
	},
	{#State 288
		ACTIONS => {
			'OP13_BITWISE_AND' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_STRING_REPEAT' => 207,
			"]" => -97,
			";" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 200,
			")" => -97,
			'OP08_STRING_CAT' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			"}" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97
		}
	},
	{#State 289
		ACTIONS => {
			'OP08_STRING_CAT' => -95,
			")" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP21_LIST_COMMA' => -95,
			"}" => -95,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => -95,
			'OP23_LOGICAL_AND' => -95
		}
	},
	{#State 290
		ACTIONS => {
			'OP08_STRING_CAT' => 210,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 213,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP04_MATH_POW' => 214,
			'OP15_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP17_LIST_RANGE' => -102,
			";" => -102,
			'OP07_STRING_REPEAT' => 207,
			"]" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_BIND' => 202
		}
	},
	{#State 291
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP13_BITWISE_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			";" => -101,
			'OP17_LIST_RANGE' => -101,
			"]" => -101,
			'OP07_STRING_REPEAT' => 207,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 214,
			")" => -101,
			'OP08_STRING_CAT' => 210,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 211
		}
	},
	{#State 292
		ACTIONS => {
			'OP13_BITWISE_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			"]" => -89,
			'OP07_STRING_REPEAT' => -89,
			";" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP06_REGEX_BIND' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			")" => -89,
			'OP08_STRING_CAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			"}" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 293
		ACTIONS => {
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135,
			'WORD' => 133
		},
		GOTOS => {
			'Type' => 339
		}
	},
	{#State 294
		ACTIONS => {
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110
		},
		GOTOS => {
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'Variable' => 142,
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 340
		}
	},
	{#State 295
		ACTIONS => {
			'TYPE_INTEGER' => 135,
			'WORD_SCOPED' => 134,
			'WORD' => 133
		},
		GOTOS => {
			'Type' => 341
		}
	},
	{#State 296
		ACTIONS => {
			'TYPE_INTEGER' => 342
		}
	},
	{#State 297
		ACTIONS => {
			'TYPE_INTEGER' => 343
		}
	},
	{#State 298
		ACTIONS => {
			";" => 344
		}
	},
	{#State 299
		ACTIONS => {
			";" => 345
		}
	},
	{#State 300
		DEFAULT => -121
	},
	{#State 301
		DEFAULT => -132
	},
	{#State 302
		ACTIONS => {
			"}" => 346
		}
	},
	{#State 303
		DEFAULT => -202
	},
	{#State 304
		DEFAULT => -129
	},
	{#State 305
		ACTIONS => {
			")" => 347
		}
	},
	{#State 306
		ACTIONS => {
			")" => 348
		}
	},
	{#State 307
		DEFAULT => -125
	},
	{#State 308
		DEFAULT => -92
	},
	{#State 309
		ACTIONS => {
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'MY' => 153,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'ARGV' => 150,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP01_QW' => 151,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'WordScoped' => 119,
			'ListElement' => 147,
			'Literal' => 105,
			'HashReference' => 109,
			'ListElements' => 349,
			'TypeInner' => 146,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 149,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98
		}
	},
	{#State 310
		ACTIONS => {
			"}" => 350
		}
	},
	{#State 311
		DEFAULT => -217
	},
	{#State 312
		ACTIONS => {
			'LITERAL_NUMBER' => 353,
			'SUB' => 354
		},
		GOTOS => {
			'SubroutineOrMethod' => 352,
			'Subroutine' => 351,
			'Method' => 355
		}
	},
	{#State 313
		ACTIONS => {
			'LBRACE' => 356
		}
	},
	{#State 314
		ACTIONS => {
			"}" => 357
		}
	},
	{#State 315
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 316
		ACTIONS => {
			'OP21_LIST_COMMA' => 359
		}
	},
	{#State 317
		DEFAULT => -190
	},
	{#State 318
		ACTIONS => {
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'MY' => 153,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'ARGV' => 150
		},
		GOTOS => {
			'SubExpression' => 149,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'TypeInner' => 146,
			'HashReference' => 109,
			'WordScoped' => 119,
			'ListElement' => 360,
			'Literal' => 105
		}
	},
	{#State 319
		ACTIONS => {
			'OP10_NAMED_UNARY' => 179,
			'OP22_LOGICAL_NEG' => 180,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 167,
			'OP01_NAMED' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			'OP07_STRING_REPEAT' => 182,
			'OP01_PRINT' => 183,
			'WORD' => 184,
			'OP01_OPEN' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP19_LOOP_CONTROL' => 173,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP01_CLOSE' => 175,
			'OP01_NAMED_VOID' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 178
		},
		GOTOS => {
			'OpStringOrWord' => 361
		}
	},
	{#State 320
		DEFAULT => -127
	},
	{#State 321
		ACTIONS => {
			")" => 362
		}
	},
	{#State 322
		DEFAULT => -204
	},
	{#State 323
		ACTIONS => {
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'Variable' => 142,
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 363,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 324
		DEFAULT => -213
	},
	{#State 325
		DEFAULT => -211
	},
	{#State 326
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 180,
			'OP01_NAMED' => 168,
			'OP23_LOGICAL_AND' => 167,
			'ENV' => 166,
			'OP08_MATH_ADD_SUB' => 165,
			'OP10_NAMED_UNARY' => 179,
			'VARIABLE_SYMBOL' => 129,
			'OP07_STRING_REPEAT' => 182,
			'WORD' => 184,
			'OP01_PRINT' => 183,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			"%{" => 127,
			'LITERAL_STRING' => 89,
			'OP01_NAMED_VOID' => 162,
			'OP01_CLOSE' => 175,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP11_COMPARE_LT_GT' => 172,
			'OP01_OPEN' => 171,
			'OP19_LOOP_CONTROL' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 178,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'OpStringOrWord' => 176,
			'VarOrLitOrOpStrOrWord' => 163,
			'Literal' => 181,
			'HashEntry' => 364,
			'Variable' => 174,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 169
		}
	},
	{#State 327
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 207,
			"]" => 365,
			'OP17_LIST_RANGE' => 206,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208
		}
	},
	{#State 328
		ACTIONS => {
			'OP08_STRING_CAT' => 210,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => 366,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200
		}
	},
	{#State 329
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -219,
			'LPAREN' => -219,
			"}" => 367
		}
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 331
		ACTIONS => {
			")" => 370
		}
	},
	{#State 332
		ACTIONS => {
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'MY' => 153,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'ARGV' => 150
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'ListElement' => 147,
			'HashReference' => 109,
			'TypeInner' => 146,
			'ListElements' => 371,
			'SubExpression' => 149,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85
		}
	},
	{#State 333
		DEFAULT => -186
	},
	{#State 334
		DEFAULT => -183
	},
	{#State 335
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'STDIN' => 256,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP10_NAMED_UNARY_SCOLON' => 375,
			'WORD_SCOPED' => 27,
			'OP01_NAMED_SCOLON' => 374,
			'OP22_LOGICAL_NEG' => 101,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'FHREF_SYMBOL_IN' => 259,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90
		},
		GOTOS => {
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'SubExpression' => 258,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'OpNamedScolonOrSubExpIn' => 372,
			'SubExpressionOrInput' => 373,
			'HashReference' => 109,
			'Literal' => 105,
			'WordScoped' => 119
		}
	},
	{#State 336
		ACTIONS => {
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29
		},
		GOTOS => {
			'SubExpression' => 376,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 337
		DEFAULT => -120
	},
	{#State 338
		ACTIONS => {
			'LITERAL_STRING' => 89,
			'VARIABLE_SYMBOL' => 129,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90
		},
		GOTOS => {
			'Literal' => 276,
			'VariableOrLiteral' => 377,
			'Variable' => 275,
			'VariableSymbolOrSelf' => 85
		}
	},
	{#State 339
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 340
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => 379,
			'OP08_STRING_CAT' => 210,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208
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
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 344
		DEFAULT => -118
	},
	{#State 345
		DEFAULT => -117
	},
	{#State 346
		DEFAULT => -203
	},
	{#State 347
		DEFAULT => -136
	},
	{#State 348
		DEFAULT => -134
	},
	{#State 349
		ACTIONS => {
			";" => 383
		}
	},
	{#State 350
		DEFAULT => -218
	},
	{#State 351
		DEFAULT => -76
	},
	{#State 352
		DEFAULT => -59
	},
	{#State 353
		ACTIONS => {
			";" => 384
		}
	},
	{#State 354
		ACTIONS => {
			'WORD' => 385
		}
	},
	{#State 355
		DEFAULT => -77
	},
	{#State 356
		ACTIONS => {
			'OP07_STRING_REPEAT' => 182,
			'OP01_PRINT' => 183,
			'WORD' => 184,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			'OP22_LOGICAL_NEG' => 180,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 167,
			'OP01_NAMED' => 168,
			'OP10_NAMED_UNARY' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 178,
			'OP01_CLOSE' => 175,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP01_NAMED_VOID' => 162,
			'OP01_OPEN' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP19_LOOP_CONTROL' => 173,
			"}" => 388
		},
		GOTOS => {
			'OpStringOrWord' => 386,
			'HashEntryProperties' => 387
		}
	},
	{#State 357
		ACTIONS => {
			";" => 389
		}
	},
	{#State 358
		DEFAULT => -228
	},
	{#State 359
		ACTIONS => {
			'LITERAL_STRING' => 390
		}
	},
	{#State 360
		DEFAULT => -189
	},
	{#State 361
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 391
		}
	},
	{#State 362
		DEFAULT => -135
	},
	{#State 363
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP21_LIST_COMMA' => -206,
			"}" => -206,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP08_STRING_CAT' => 210,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP06_REGEX_BIND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205
		}
	},
	{#State 364
		DEFAULT => -210
	},
	{#State 365
		DEFAULT => -180
	},
	{#State 366
		DEFAULT => -181
	},
	{#State 367
		DEFAULT => -182
	},
	{#State 368
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			"foreach" => -153,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 29,
			'OP01_PRINT' => 107,
			"while" => -153,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			"if" => 87,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'OP19_LOOP_CONTROL' => 78,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'MY' => 92,
			"for" => -153,
			'SELF' => 90,
			'OP01_NAMED_SCOLON' => 123,
			'OP01_NAMED' => 121,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"%{" => 127,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID' => 112,
			"undef" => 110,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_NAMED_VOID_SCOLON' => 115
		},
		GOTOS => {
			'VariableDeclaration' => 111,
			'Variable' => 82,
			'VariableSymbolOrSelf' => 85,
			'ArrayDereference' => 114,
			'Conditional' => 118,
			'VariableModification' => 91,
			'WordScoped' => 119,
			'PAREN-37' => 93,
			'OperatorVoid' => 96,
			'Statement' => 95,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'SubExpression' => 100,
			'Expression' => 99,
			'Operator' => 124,
			'Operation' => 392,
			'Literal' => 105,
			'OPTIONAL-38' => 106,
			'LoopLabel' => 108,
			'PLUS-43' => 393,
			'HashReference' => 109
		}
	},
	{#State 369
		DEFAULT => -161,
		GOTOS => {
			'STAR-40' => 394
		}
	},
	{#State 370
		DEFAULT => -82
	},
	{#State 371
		ACTIONS => {
			")" => 395
		}
	},
	{#State 372
		DEFAULT => -184
	},
	{#State 373
		ACTIONS => {
			";" => 396
		}
	},
	{#State 374
		DEFAULT => -241
	},
	{#State 375
		DEFAULT => -242
	},
	{#State 376
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP06_REGEX_BIND' => 202,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP07_STRING_REPEAT' => 207,
			"]" => 397,
			'OP17_LIST_RANGE' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP08_STRING_CAT' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212
		}
	},
	{#State 377
		DEFAULT => -108
	},
	{#State 378
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 398
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 399
		}
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 400
		}
	},
	{#State 381
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 382
		ACTIONS => {
			'LPAREN' => 402
		}
	},
	{#State 383
		DEFAULT => -122
	},
	{#State 384
		DEFAULT => -61
	},
	{#State 385
		ACTIONS => {
			'LBRACE' => 403
		}
	},
	{#State 386
		ACTIONS => {
			'OP20_HASH_FATARROW' => 404
		}
	},
	{#State 387
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 405
		}
	},
	{#State 388
		ACTIONS => {
			";" => 406
		}
	},
	{#State 389
		ACTIONS => {
			'WORD' => -45,
			'OP01_PRINT' => -45,
			"while" => -45,
			"foreach" => -45,
			'OP10_NAMED_UNARY_SCOLON' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'WORD_SCOPED' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'LPAREN_MY' => 408,
			'OP10_NAMED_UNARY' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'MY' => -45,
			'SELF' => -45,
			"for" => -45,
			'LBRACE' => -45,
			'OP01_CLOSE' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'LITERAL_STRING' => -45,
			'LPAREN' => -45,
			"if" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP05_BITWISE_NEG_LPAREN' => -45,
			'LBRACKET' => -45,
			'OP01_OPEN' => -45,
			'VARIABLE_SYMBOL' => -45,
			"%{" => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP01_NAMED' => -45,
			'OP01_NAMED_SCOLON' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LITERAL_NUMBER' => -45,
			"\@{" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP01_NAMED_VOID' => -45,
			'WORD_UPPERCASE' => -45,
			"}" => -45,
			"undef" => -45
		},
		GOTOS => {
			'SubroutineArguments' => 407,
			'OPTIONAL-17' => 409
		}
	},
	{#State 390
		ACTIONS => {
			'OP21_LIST_COMMA' => 410
		}
	},
	{#State 391
		DEFAULT => -225
	},
	{#State 392
		DEFAULT => -175
	},
	{#State 393
		ACTIONS => {
			"while" => -153,
			'OP01_PRINT' => 107,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'CONSTANT_CALL_SCOPED' => 102,
			"foreach" => -153,
			"for" => -153,
			'SELF' => 90,
			'MY' => 92,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 78,
			"if" => 87,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED_SCOLON' => 123,
			'OP01_NAMED' => 121,
			'OP01_NAMED_VOID_SCOLON' => 115,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			"}" => 412,
			"undef" => 110,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID' => 112
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 85,
			'Variable' => 82,
			'ArrayDereference' => 114,
			'VariableDeclaration' => 111,
			'PAREN-37' => 93,
			'VariableModification' => 91,
			'WordScoped' => 119,
			'Conditional' => 118,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Operation' => 411,
			'Operator' => 124,
			'SubExpression' => 100,
			'Expression' => 99,
			'OperatorVoid' => 96,
			'Statement' => 95,
			'LoopLabel' => 108,
			'HashReference' => 109,
			'Literal' => 105,
			'OPTIONAL-38' => 106
		}
	},
	{#State 394
		ACTIONS => {
			"%{" => -164,
			'OP19_LOOP_CONTROL_SCOLON' => -164,
			'VARIABLE_SYMBOL' => -164,
			'OP05_MATH_NEG_LPAREN' => -164,
			'OP01_NAMED' => -164,
			'OP01_NAMED_SCOLON' => -164,
			"\@{" => -164,
			'' => -164,
			'LITERAL_NUMBER' => -164,
			'OP01_NAMED_VOID_SCOLON' => -164,
			"}" => -164,
			"undef" => -164,
			'OP01_NAMED_VOID' => -164,
			"elsif" => 414,
			'WORD_UPPERCASE' => -164,
			"while" => -164,
			'WORD' => -164,
			'OP01_PRINT' => -164,
			'OP10_NAMED_UNARY' => -164,
			"foreach" => -164,
			'OP10_NAMED_UNARY_SCOLON' => -164,
			'CONSTANT_CALL_SCOPED' => -164,
			'WORD_SCOPED' => -164,
			'OP22_LOGICAL_NEG' => -164,
			'SELF' => -164,
			"for" => -164,
			'OP01_NAMED_VOID_LPAREN' => -164,
			'MY' => -164,
			'OP19_LOOP_CONTROL' => -164,
			'OP05_BITWISE_NEG_LPAREN' => -164,
			'LBRACKET' => -164,
			'OP01_OPEN' => -164,
			'LBRACE' => -164,
			'OP01_CLOSE' => -164,
			'OP03_MATH_INC_DEC' => -164,
			'LPAREN' => -164,
			"else" => 416,
			'LITERAL_STRING' => -164,
			"if" => -164,
			'OP05_LOGICAL_NEG' => -164
		},
		GOTOS => {
			'OPTIONAL-42' => 413,
			'PAREN-41' => 417,
			'PAREN-39' => 415
		}
	},
	{#State 395
		DEFAULT => -84
	},
	{#State 396
		DEFAULT => -243
	},
	{#State 397
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 418
		}
	},
	{#State 398
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 259,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'STDIN' => 256,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110
		},
		GOTOS => {
			'HashReference' => 109,
			'SubExpressionOrInput' => 419,
			'WordScoped' => 119,
			'Literal' => 105,
			'Expression' => 140,
			'SubExpression' => 258,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122
		}
	},
	{#State 399
		DEFAULT => -172
	},
	{#State 400
		ACTIONS => {
			"%{" => 127,
			'ARGV' => 150,
			'OP01_QW' => 151,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'MY' => 153,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89
		},
		GOTOS => {
			'Literal' => 105,
			'ListElement' => 147,
			'WordScoped' => 119,
			'HashReference' => 109,
			'TypeInner' => 146,
			'ListElements' => 420,
			'Variable' => 142,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'SubExpression' => 149,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124
		}
	},
	{#State 401
		ACTIONS => {
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 424,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED_SCOLON' => 422,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127
		},
		GOTOS => {
			'SubExpression' => 423,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'ArrayReference' => 98,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'OpNamedScolonOrSubExp' => 421,
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109
		}
	},
	{#State 402
		ACTIONS => {
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'SELF' => 90,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80
		},
		GOTOS => {
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105,
			'Operator' => 124,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'SubExpression' => 425,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'Variable' => 142
		}
	},
	{#State 403
		ACTIONS => {
			'LBRACE' => 426
		}
	},
	{#State 404
		ACTIONS => {
			'MY' => 427
		},
		GOTOS => {
			'TypeInnerProperties' => 428
		}
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 430,
			"}" => 431
		},
		GOTOS => {
			'PAREN-25' => 429
		}
	},
	{#State 406
		DEFAULT => -66
	},
	{#State 407
		DEFAULT => -44
	},
	{#State 408
		ACTIONS => {
			'WORD' => 133,
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135
		},
		GOTOS => {
			'Type' => 432
		}
	},
	{#State 409
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 433
		}
	},
	{#State 410
		ACTIONS => {
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120
		},
		GOTOS => {
			'Expression' => 140,
			'SubExpression' => 434,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 411
		DEFAULT => -174
	},
	{#State 412
		DEFAULT => -176
	},
	{#State 413
		DEFAULT => -165
	},
	{#State 414
		ACTIONS => {
			'LPAREN' => 435
		}
	},
	{#State 415
		DEFAULT => -160
	},
	{#State 416
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 436
		}
	},
	{#State 417
		DEFAULT => -163
	},
	{#State 418
		ACTIONS => {
			"undef" => 437
		}
	},
	{#State 419
		ACTIONS => {
			")" => 438
		}
	},
	{#State 420
		ACTIONS => {
			")" => 439
		}
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 440
		}
	},
	{#State 422
		DEFAULT => -238
	},
	{#State 423
		ACTIONS => {
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			";" => 441,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 210,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214
		}
	},
	{#State 424
		DEFAULT => -239
	},
	{#State 425
		ACTIONS => {
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP17_LIST_RANGE' => 442,
			'OP07_STRING_REPEAT' => 207,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP08_STRING_CAT' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214
		}
	},
	{#State 426
		ACTIONS => {
			'MY' => 443
		}
	},
	{#State 427
		ACTIONS => {
			'WORD' => 133,
			'TYPE_INTEGER' => 135,
			'WORD_SCOPED' => 134
		},
		GOTOS => {
			'Type' => 444
		}
	},
	{#State 428
		DEFAULT => -209
	},
	{#State 429
		DEFAULT => -63
	},
	{#State 430
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP01_OPEN' => 171,
			'OP01_NAMED_VOID' => 162,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP01_CLOSE' => 175,
			'OP12_COMPARE_EQ_NE' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP10_NAMED_UNARY' => 179,
			'OP23_LOGICAL_AND' => 167,
			'OP01_NAMED' => 168,
			'OP08_MATH_ADD_SUB' => 165,
			'OP22_LOGICAL_NEG' => 180,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			'WORD' => 184,
			'OP01_PRINT' => 183,
			'OP07_STRING_REPEAT' => 182
		},
		GOTOS => {
			'OpStringOrWord' => 386,
			'HashEntryProperties' => 445
		}
	},
	{#State 431
		ACTIONS => {
			";" => 446
		}
	},
	{#State 432
		ACTIONS => {
			'VARIABLE_SYMBOL' => 447
		}
	},
	{#State 433
		ACTIONS => {
			"foreach" => -153,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'WORD' => 29,
			'OP01_PRINT' => 107,
			"while" => -153,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 86,
			"if" => 87,
			'OP19_LOOP_CONTROL' => 78,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'MY' => 92,
			'SELF' => 90,
			"for" => -153,
			'OP01_NAMED' => 121,
			'OP01_NAMED_SCOLON' => 123,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'OP01_NAMED_VOID' => 112,
			'WORD_UPPERCASE' => 113,
			"undef" => 110,
			"}" => 449,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_NAMED_VOID_SCOLON' => 115
		},
		GOTOS => {
			'VariableDeclaration' => 111,
			'Variable' => 82,
			'VariableSymbolOrSelf' => 85,
			'ArrayDereference' => 114,
			'Conditional' => 118,
			'VariableModification' => 91,
			'WordScoped' => 119,
			'PAREN-37' => 93,
			'OperatorVoid' => 96,
			'Statement' => 95,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'Expression' => 99,
			'SubExpression' => 100,
			'Operator' => 124,
			'Operation' => 448,
			'Literal' => 105,
			'OPTIONAL-38' => 106,
			'LoopLabel' => 108,
			'HashReference' => 109
		}
	},
	{#State 434
		ACTIONS => {
			'OP08_STRING_CAT' => 210,
			")" => -85,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP21_LIST_COMMA' => -85,
			"}" => -85,
			'OP11_COMPARE_LT_GT' => 213,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP04_MATH_POW' => 214,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP17_LIST_RANGE' => 206,
			";" => -85,
			"]" => -85,
			'OP07_STRING_REPEAT' => 207,
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -85,
			'OP06_REGEX_BIND' => 202
		}
	},
	{#State 435
		ACTIONS => {
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED' => 138,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'WordScoped' => 119,
			'Literal' => 105,
			'HashReference' => 109,
			'SubExpression' => 450,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'Operator' => 124,
			'Variable' => 142,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'HashDereference' => 122
		}
	},
	{#State 436
		DEFAULT => -162
	},
	{#State 437
		ACTIONS => {
			";" => 451
		}
	},
	{#State 438
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 452
		}
	},
	{#State 439
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 453
		}
	},
	{#State 440
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 454
		}
	},
	{#State 441
		DEFAULT => -240
	},
	{#State 442
		ACTIONS => {
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129,
			"%{" => 127,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'SELF' => 90,
			'LBRACE' => 84,
			'OP01_CLOSE' => 81,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79
		},
		GOTOS => {
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'Operator' => 124,
			'SubExpression' => 455,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109
		}
	},
	{#State 443
		ACTIONS => {
			'WORD' => 133,
			'TYPE_METHOD' => 456,
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135
		},
		GOTOS => {
			'Type' => 245
		}
	},
	{#State 444
		ACTIONS => {
			"\$TYPED_" => 457
		}
	},
	{#State 445
		DEFAULT => -62
	},
	{#State 446
		DEFAULT => -65
	},
	{#State 447
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 458
		}
	},
	{#State 448
		DEFAULT => -46
	},
	{#State 449
		DEFAULT => -48
	},
	{#State 450
		ACTIONS => {
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP17_LIST_RANGE' => 206,
			'OP07_STRING_REPEAT' => 207,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			")" => 459,
			'OP08_STRING_CAT' => 210
		}
	},
	{#State 451
		DEFAULT => -185
	},
	{#State 452
		DEFAULT => -173
	},
	{#State 453
		DEFAULT => -171
	},
	{#State 454
		ACTIONS => {
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED_SCOLON' => 422,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP10_NAMED_UNARY_SCOLON' => 424,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127
		},
		GOTOS => {
			'Operator' => 124,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'SubExpression' => 423,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'ArrayReference' => 98,
			'Variable' => 142,
			'HashReference' => 109,
			'WordScoped' => 119,
			'OpNamedScolonOrSubExp' => 460,
			'Literal' => 105
		}
	},
	{#State 455
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => -107,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => -107,
			'OP09_BITWISE_SHIFT' => 209,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP08_STRING_CAT' => 210,
			")" => 461
		}
	},
	{#State 456
		ACTIONS => {
			"\$RETURN_TYPE" => 462
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP01_OPEN' => 171,
			'OP01_NAMED_VOID' => 162,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP01_CLOSE' => 175,
			'OP12_COMPARE_EQ_NE' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP10_NAMED_UNARY' => 179,
			'OP23_LOGICAL_AND' => 167,
			'OP01_NAMED' => 168,
			'OP08_MATH_ADD_SUB' => 165,
			'OP22_LOGICAL_NEG' => 180,
			'OP19_LOOP_CONTROL_SCOLON' => 170,
			'WORD' => 184,
			'OP01_PRINT' => 183,
			'OP07_STRING_REPEAT' => 182
		},
		GOTOS => {
			'OpStringOrWord' => 463
		}
	},
	{#State 458
		ACTIONS => {
			'OP21_LIST_COMMA' => 466,
			")" => 465
		},
		GOTOS => {
			'PAREN-19' => 464
		}
	},
	{#State 459
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 467
		}
	},
	{#State 460
		ACTIONS => {
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'WORD_UPPERCASE' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'Literal' => 105,
			'WordScoped' => 119,
			'VariableModification' => 468,
			'HashReference' => 109,
			'SubExpressionOrVarMod' => 470,
			'Variable' => 82,
			'VariableSymbolOrSelf' => 85,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'SubExpression' => 469,
			'ArrayDereference' => 114,
			'Expression' => 140,
			'Operator' => 124
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 471
		}
	},
	{#State 462
		ACTIONS => {
			"}" => 472
		}
	},
	{#State 463
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 473,
			'OP02_ARRAY_THINARROW' => 474
		}
	},
	{#State 464
		DEFAULT => -50
	},
	{#State 465
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 475
		}
	},
	{#State 466
		ACTIONS => {
			'MY' => 476
		}
	},
	{#State 467
		DEFAULT => -159
	},
	{#State 468
		DEFAULT => -150
	},
	{#State 469
		ACTIONS => {
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP16_LOGICAL_OR' => 208,
			'OP09_BITWISE_SHIFT' => 209,
			'OP18_TERNARY' => 199,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP08_STRING_CAT' => 210,
			")" => -149
		}
	},
	{#State 470
		ACTIONS => {
			")" => 477
		}
	},
	{#State 471
		DEFAULT => -169
	},
	{#State 472
		ACTIONS => {
			";" => 478
		}
	},
	{#State 473
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 77,
			"undef" => 110,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'SELF' => 90,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 97,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			"%{" => 127,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 129
		},
		GOTOS => {
			'Literal' => 105,
			'WordScoped' => 119,
			'HashReference' => 109,
			'Variable' => 142,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Expression' => 140,
			'SubExpression' => 479,
			'ArrayDereference' => 114,
			'Operator' => 124
		}
	},
	{#State 474
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 120,
			'VARIABLE_SYMBOL' => 129,
			'WORD' => 29,
			"%{" => 127,
			'LPAREN' => 88,
			'LITERAL_STRING' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'WORD_UPPERCASE' => 139,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACKET' => 80,
			'OP01_OPEN' => 79,
			"undef" => 110,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'LITERAL_NUMBER' => 117,
			"\@{" => 116,
			'SELF' => 90
		},
		GOTOS => {
			'Operator' => 124,
			'SubExpression' => 480,
			'Expression' => 140,
			'ArrayDereference' => 114,
			'ArrayReference' => 98,
			'HashDereference' => 122,
			'VariableSymbolOrSelf' => 85,
			'Variable' => 142,
			'HashReference' => 109,
			'WordScoped' => 119,
			'Literal' => 105
		}
	},
	{#State 475
		ACTIONS => {
			"\@ARG;" => 481
		}
	},
	{#State 476
		ACTIONS => {
			'WORD_SCOPED' => 134,
			'TYPE_INTEGER' => 135,
			'WORD' => 133
		},
		GOTOS => {
			'Type' => 482
		}
	},
	{#State 477
		ACTIONS => {
			'LBRACE' => 368
		},
		GOTOS => {
			'CodeBlock' => 483
		}
	},
	{#State 478
		ACTIONS => {
			"while" => -68,
			'WORD' => -68,
			'OP01_PRINT' => -68,
			'OP10_NAMED_UNARY' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'OP10_NAMED_UNARY_SCOLON' => -68,
			'WORD_SCOPED' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'LPAREN_MY' => 485,
			"foreach" => -68,
			"for" => -68,
			'SELF' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'MY' => -68,
			'LBRACKET' => -68,
			'OP01_OPEN' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP05_BITWISE_NEG_LPAREN' => -68,
			'LPAREN' => -68,
			'LITERAL_STRING' => -68,
			'OP05_LOGICAL_NEG' => -68,
			"if" => -68,
			'LBRACE' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'OP01_CLOSE' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			"%{" => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP01_NAMED_SCOLON' => -68,
			'OP01_NAMED' => -68,
			"\@{" => -68,
			'LITERAL_NUMBER' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			"}" => -68,
			"undef" => -68,
			'WORD_UPPERCASE' => -68,
			'OP01_NAMED_VOID' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 486,
			'MethodArguments' => 484
		}
	},
	{#State 479
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP21_LIST_COMMA' => -226,
			"}" => -226,
			'OP04_MATH_POW' => 214,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_STRING_CAT' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP06_REGEX_BIND' => 202,
			'OP08_MATH_ADD_SUB' => 200,
			'OP23_LOGICAL_AND' => 201,
			'OP15_LOGICAL_AND' => 198,
			'OP13_BITWISE_AND' => 205,
			'OP07_STRING_REPEAT' => 207,
			'OP17_LIST_RANGE' => 206
		}
	},
	{#State 480
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 211,
			'OP12_COMPARE_EQ_NE' => 212,
			'OP08_STRING_CAT' => 210,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => 203,
			'OP04_MATH_POW' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 206,
			"]" => 487,
			'OP07_STRING_REPEAT' => 207,
			'OP13_BITWISE_AND' => 205,
			'OP15_LOGICAL_AND' => 198,
			'OP23_LOGICAL_AND' => 201,
			'OP08_MATH_ADD_SUB' => 200,
			'OP06_REGEX_BIND' => 202,
			'OP18_TERNARY' => 199,
			'OP09_BITWISE_SHIFT' => 209,
			'OP16_LOGICAL_OR' => 208
		}
	},
	{#State 481
		DEFAULT => -52
	},
	{#State 482
		ACTIONS => {
			'VARIABLE_SYMBOL' => 488
		}
	},
	{#State 483
		DEFAULT => -170
	},
	{#State 484
		DEFAULT => -67
	},
	{#State 485
		ACTIONS => {
			'WORD' => 133,
			'TYPE_INTEGER' => 135,
			'WORD_SCOPED' => 134
		},
		GOTOS => {
			'Type' => 489
		}
	},
	{#State 486
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 490
		}
	},
	{#State 487
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 491
		}
	},
	{#State 488
		DEFAULT => -49
	},
	{#State 489
		ACTIONS => {
			'SELF' => 492
		}
	},
	{#State 490
		ACTIONS => {
			"undef" => 110,
			"}" => 494,
			'WORD_UPPERCASE' => 113,
			'OP01_NAMED_VOID' => 112,
			'OP01_NAMED_VOID_SCOLON' => 115,
			"\@{" => 116,
			'LITERAL_NUMBER' => 117,
			'OP05_MATH_NEG_LPAREN' => 120,
			'OP01_NAMED_SCOLON' => 123,
			'OP01_NAMED' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"%{" => 127,
			'VARIABLE_SYMBOL' => 129,
			'OP01_OPEN' => 79,
			'LBRACKET' => 80,
			'OP05_BITWISE_NEG_LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 78,
			'OP05_LOGICAL_NEG' => 86,
			"if" => 87,
			'LITERAL_STRING' => 89,
			'LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 81,
			'LBRACE' => 84,
			"for" => -153,
			'SELF' => 90,
			'MY' => 92,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'CONSTANT_CALL_SCOPED' => 102,
			'WORD_SCOPED' => 27,
			"foreach" => -153,
			"while" => -153,
			'OP01_PRINT' => 107,
			'WORD' => 29
		},
		GOTOS => {
			'PAREN-37' => 93,
			'Conditional' => 118,
			'VariableModification' => 91,
			'WordScoped' => 119,
			'Variable' => 82,
			'VariableSymbolOrSelf' => 85,
			'ArrayDereference' => 114,
			'VariableDeclaration' => 111,
			'LoopLabel' => 108,
			'HashReference' => 109,
			'Literal' => 105,
			'OPTIONAL-38' => 106,
			'HashDereference' => 122,
			'ArrayReference' => 98,
			'Expression' => 99,
			'SubExpression' => 100,
			'Operator' => 124,
			'Operation' => 493,
			'OperatorVoid' => 96,
			'Statement' => 95
		}
	},
	{#State 491
		ACTIONS => {
			"undef" => 495
		}
	},
	{#State 492
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 496
		}
	},
	{#State 493
		DEFAULT => -69
	},
	{#State 494
		DEFAULT => -71
	},
	{#State 495
		DEFAULT => -227
	},
	{#State 496
		ACTIONS => {
			")" => 498,
			'OP21_LIST_COMMA' => 499
		},
		GOTOS => {
			'PAREN-29' => 497
		}
	},
	{#State 497
		DEFAULT => -73
	},
	{#State 498
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 500
		}
	},
	{#State 499
		ACTIONS => {
			'MY' => 501
		}
	},
	{#State 500
		ACTIONS => {
			"\@ARG;" => 502
		}
	},
	{#State 501
		ACTIONS => {
			'WORD' => 133,
			'TYPE_INTEGER' => 135,
			'WORD_SCOPED' => 134
		},
		GOTOS => {
			'Type' => 503
		}
	},
	{#State 502
		DEFAULT => -75
	},
	{#State 503
		ACTIONS => {
			'VARIABLE_SYMBOL' => 504
		}
	},
	{#State 504
		DEFAULT => -72
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7309 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7334 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7424 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7523 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7591 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7630 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7655 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_76
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_77
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7677 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7721 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7743 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7754 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7765 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7776 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7787 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7963 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7974 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7985 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7996 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8007 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8018 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8029 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8040 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8051 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 226 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8058 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 226 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 226 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8072 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 227 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8086 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8097 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8119 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8130 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8141 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8152 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8163 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8174 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 229 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8188 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8195 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8202 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8209 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 230 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8216 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8227 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8238 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8249 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8260 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_135
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8271 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8282 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8293 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8304 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8315 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8326 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8337 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8348 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8359 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_144
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8370 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_145
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8381 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_146
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8392 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_147
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8403 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_148
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8414 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_149
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_150
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8436 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8443 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8450 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8457 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8468 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8479 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8490 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8501 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8512 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8526 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8533 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8547 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8554 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_165
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8565 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8576 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8587 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_168
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8598 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_169
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8609 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_170
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8620 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_171
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8631 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_172
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8642 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_173
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8653 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8660 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8667 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_176
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8692 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_179
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8703 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_180
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8714 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_181
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8725 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8736 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_183
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8747 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_184
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8758 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8769 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8780 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8791 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8802 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8809 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8823 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8834 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8845 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8856 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8867 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_196
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8878 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8885 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8892 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_199
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8903 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8910 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8917 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_202
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8928 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_203
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8939 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8946 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8953 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8964 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_207
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8975 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8986 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_209
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8997 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9004 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 2,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9011 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9018 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_213
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9029 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_214
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9040 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9047 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9054 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_217
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9065 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_218
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9076 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9087 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_220
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9098 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_221
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9109 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9120 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9131 lib/RPerl/Grammar.pm
	],
	[#Rule Type_224
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9142 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_225
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9153 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_226
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9164 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_227
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9175 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_228
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9186 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_229
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9197 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_230
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9208 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_231
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9219 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_232
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9230 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_233
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9241 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_234
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9252 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_235
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9263 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_236
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9274 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_237
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9285 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_238
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9296 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_239
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9307 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_240
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9318 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_241
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9329 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_242
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9340 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_243
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9351 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_244
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9362 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_245
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9373 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_246
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9384 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_247
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9395 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_248
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9406 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_249
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9417 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_250
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9428 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_251
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9439 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_252
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9450 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_253
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9461 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_254
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9472 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_255
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9483 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_256
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9494 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_257
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9505 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_258
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9516 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_259
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9527 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_260
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9538 lib/RPerl/Grammar.pm
	]
],
#line 9541 lib/RPerl/Grammar.pm
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
         'SubroutineOrMethod_76', 
         'SubroutineOrMethod_77', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'Expression_134', 
         'Expression_135', 
         'Expression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpression_143', 
         'SubExpression_144', 
         'SubExpression_145', 
         'SubExpressionOrInput_146', 
         'SubExpressionOrInput_147', 
         'SubExpressionOrInput_148', 
         'SubExpressionOrVarMod_149', 
         'SubExpressionOrVarMod_150', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         'Statement_157', 
         'Statement_158', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_165', 
         'Loop_166', 
         'Loop_167', 
         'Loop_168', 
         'LoopFor_169', 
         'LoopFor_170', 
         'LoopForEach_171', 
         'LoopWhile_172', 
         'LoopWhile_173', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_176', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_179', 
         'VariableRetrieval_180', 
         'VariableRetrieval_181', 
         'VariableRetrieval_182', 
         'VariableDeclaration_183', 
         'VariableDeclaration_184', 
         'VariableDeclaration_185', 
         'VariableDeclaration_186', 
         'VariableModification_187', 
         'VariableModification_188', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_192', 
         'ListElement_193', 
         'ListElement_194', 
         'ListElement_195', 
         'ListElement_196', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_199', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_202', 
         'ArrayDereference_203', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_206', 
         'HashEntry_207', 
         'HashEntry_208', 
         'HashEntryProperties_209', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_213', 
         'HashReference_214', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_217', 
         'HashDereference_218', 
         'WordScoped_219', 
         'WordScoped_220', 
         'LoopLabel_221', 
         'Type_222', 
         'Type_223', 
         'Type_224', 
         'TypeInner_225', 
         'TypeInnerProperties_226', 
         'TypeInnerProperties_227', 
         'TypeInnerConstant_228', 
         'VariableOrLiteral_229', 
         'VariableOrLiteral_230', 
         'VarOrLitOrOpStrOrWord_231', 
         'VarOrLitOrOpStrOrWord_232', 
         'VarOrLitOrOpStrOrWord_233', 
         'VariableSymbolOrSelf_234', 
         'VariableSymbolOrSelf_235', 
         'Literal_236', 
         'Literal_237', 
         'OpNamedScolonOrSubExp_238', 
         'OpNamedScolonOrSubExp_239', 
         'OpNamedScolonOrSubExp_240', 
         'OpNamedScolonOrSubExpIn_241', 
         'OpNamedScolonOrSubExpIn_242', 
         'OpNamedScolonOrSubExpIn_243', 
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
         'OpStringOrWord_258', 
         'OpStringOrWord_259', 
         'OpStringOrWord_260', );
  $self;
}

#line 278 "lib/RPerl/Grammar.eyp"


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
Subroutine_48 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
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


#line 10013 lib/RPerl/Grammar.pm



1;
