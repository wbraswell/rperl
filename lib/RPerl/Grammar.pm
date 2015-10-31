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

#line 2 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.002_121;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\$TYPED_|\=\ sub\ \{|package|foreach|elsif|while|undef|else|for|\@_\;|our|\%\{|if|\@\{|\;|\}|\]|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$self)/gc and return ('SELF', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
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
      /\G(next|last)\s/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)\s/gc and return ('OP12_COMPARE_EQ_NE', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(-A|-B|-C|-M|-O|-R|-S|-T|-W|-X|-b|-c|-d|-e|-f|-g|-k|-l|-o|-p|-r|-s|-t|-u|-w|-x|-z|
                                     alarm|caller|chdir|chroot|cos|defined|delete|do|eval|exists|gethostbyname|getnetbyname|getpgrp|
                                     getprotobyname|glob|gmtime|goto|hex|int|lc|lcfirst|length|localtime|lock|log|lstat|oct|ord|quotemeta|
                                     rand|readlink|ref|require|rmdir|scalar|sin|sleep|sqrt|srand|stat|uc|ucfirst|umask)\s/gc and return ('OP10_NAMED_UNARY', $1);
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
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\([^()]*\))/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(abs|accept|atan2|bind|binmode|bless|break|chmod|chomp|chop|chown|chr|closedir|cmp|connect|continue|crypt|
                                     dbmclose|dbmopen|default|dump|each|endgrent|endhostent|endnetent|endprotoent|endpwent|endservent|eof|evalbytes|
                                     exec|exp|fc|fcntl|fileno|flock|fork|format|formline|getc|getgrent|getgrgid|getgrnam|gethostbyaddr|gethostent|
                                     getlogin|getnetbyaddr|getnetent|getpeername|getppid|getpriority|getprotobynumber|getprotoent|getpwent|getpwnam|
                                     getpwuid|getservbyname|getservbyport|getservent|getsockname|getsockopt|given|grep|index|ioctl|join|keys|kill|link|
                                     listen|local|m|map|mkdir|msgctl|msgget|msgrcv|msgsnd|opendir|pack|pipe|pop|pos|prototype|push|q|qq|qr|qx|read|
                                     readdir|readline|readpipe|recv|redo|rename|reset|reverse|rewinddir|rindex|s|say|seek|seekdir|select|semctl|semget|
                                     semop|send|setgrent|sethostent|setnetent|setpgrp|setpriority|setprotoent|setpwent|setservent|setsockopt|shift|
                                     shmctl|shmget|shmread|shmwrite|shutdown|socket|socketpair|sort|splice|split|sprintf|state|study|substr|symlink|
                                     syscall|sysopen|sysread|sysseek|system|syswrite|tell|telldir|tie|tied|time|times|tr|truncate|unless|unlink|unpack|
                                     unshift|untie|until|utime|values|vec|wait|waitpid|wantarray|warn|when|write|y)\s/gc and return ('OP01_NAMED', $1);
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


#line 152 lib/RPerl/Grammar.pm

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
  [ 'Operation_79' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'PAREN-31' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-32', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-33', ')', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_141' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_142' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_143' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_144' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_145' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_160' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_164' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_165' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpression', ';', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'SubExpression', ';', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_166' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_167' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_168' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_171' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_174' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ';' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_187' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_194' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_197' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_198' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_201' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_202' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_203' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_204' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_208' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_209' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_212' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_213' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_214' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_215' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_216' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_217' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_218' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_219' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_220' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_221' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_222' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_223' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_224' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_225' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_226' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_227' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_228' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_229' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_230' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_231' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_232' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'Operator_80' => 80,
  'Operator_81' => 81,
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
  '_PAREN' => 109,
  '_OPTIONAL' => 110,
  '_OPTIONAL' => 111,
  '_OPTIONAL' => 112,
  '_OPTIONAL' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  'Expression_126' => 126,
  'Expression_127' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpressionOrInput_141' => 141,
  'SubExpressionOrInput_142' => 142,
  'SubExpressionOrInput_143' => 143,
  'SubExpressionOrVarMod_144' => 144,
  'SubExpressionOrVarMod_145' => 145,
  '_PAREN' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  '_PAREN' => 154,
  '_STAR_LIST' => 155,
  '_STAR_LIST' => 156,
  '_PAREN' => 157,
  '_OPTIONAL' => 158,
  '_OPTIONAL' => 159,
  'Conditional_160' => 160,
  'Loop_161' => 161,
  'Loop_162' => 162,
  'Loop_163' => 163,
  'LoopFor_164' => 164,
  'LoopFor_165' => 165,
  'LoopForEach_166' => 166,
  'LoopWhile_167' => 167,
  'LoopWhile_168' => 168,
  '_PLUS_LIST' => 169,
  '_PLUS_LIST' => 170,
  'CodeBlock_171' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  'Variable_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableDeclaration_178' => 178,
  'VariableDeclaration_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableModification_182' => 182,
  'VariableModification_183' => 183,
  '_PAREN' => 184,
  '_STAR_LIST' => 185,
  '_STAR_LIST' => 186,
  'ListElements_187' => 187,
  'ListElement_188' => 188,
  'ListElement_189' => 189,
  'ListElement_190' => 190,
  'ListElement_191' => 191,
  '_OPTIONAL' => 192,
  '_OPTIONAL' => 193,
  'ArrayReference_194' => 194,
  '_OPTIONAL' => 195,
  '_OPTIONAL' => 196,
  'ArrayDereference_197' => 197,
  'ArrayDereference_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'HashEntry_201' => 201,
  'HashEntry_202' => 202,
  'HashEntry_203' => 203,
  'HashEntryProperties_204' => 204,
  '_PAREN' => 205,
  '_STAR_LIST' => 206,
  '_STAR_LIST' => 207,
  'HashReference_208' => 208,
  'HashReference_209' => 209,
  '_OPTIONAL' => 210,
  '_OPTIONAL' => 211,
  'HashDereference_212' => 212,
  'HashDereference_213' => 213,
  'WordScoped_214' => 214,
  'WordScoped_215' => 215,
  'LoopLabel_216' => 216,
  'Type_217' => 217,
  'Type_218' => 218,
  'Type_219' => 219,
  'TypeInner_220' => 220,
  'TypeInnerProperties_221' => 221,
  'TypeInnerProperties_222' => 222,
  'TypeInnerConstant_223' => 223,
  'VariableOrLiteral_224' => 224,
  'VariableOrLiteral_225' => 225,
  'VariableOrLiteralOrWord_226' => 226,
  'VariableOrLiteralOrWord_227' => 227,
  'VariableOrLiteralOrWord_228' => 228,
  'VariableSymbolOrSelf_229' => 229,
  'VariableSymbolOrSelf_230' => 230,
  'Literal_231' => 231,
  'Literal_232' => 232,
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
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Program' => 6,
			'ModuleHeader' => 5,
			'Critic' => 2,
			'PAREN-1' => 8,
			'OPTIONAL-9' => 1,
			'PLUS-2' => 4,
			'CompileUnit' => 9
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => 11,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 13,
			'OPTIONAL-3' => 12
		}
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => -20,
			'' => -5,
			"## no critic qw(" => 7,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 14,
			'Critic' => 2,
			'ModuleHeader' => 5
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => -27,
			"use parent qw(" => 16,
			"our" => -27,
			"use constant" => -27,
			'USE' => -27
		},
		GOTOS => {
			'Package' => 15,
			'Module' => 19,
			'Class' => 18,
			'STAR-11' => 17
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-16' => 21
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			'' => 22
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
		ACTIONS => {
			'USE_RPERL' => 24
		}
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => -24
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 17
		ACTIONS => {
			"## no critic qw(" => 7,
			'USE' => -29,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 28,
			'Critic' => 29
		}
	},
	{#State 18
		DEFAULT => -25
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 26
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
		ACTIONS => {
			")" => 35
		}
	},
	{#State 26
		DEFAULT => -215
	},
	{#State 27
		DEFAULT => -214
	},
	{#State 28
		ACTIONS => {
			'USE' => 37,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'Include' => 38,
			'STAR-13' => 36
		}
	},
	{#State 29
		DEFAULT => -26
	},
	{#State 30
		DEFAULT => -38
	},
	{#State 31
		DEFAULT => -40
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
		ACTIONS => {
			"our" => 46,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 45,
			'PLUS-14' => 44,
			'Subroutine' => 47
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 38
		DEFAULT => -28
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
			'USE_RPERL_AFTER' => 51,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 50
		}
	},
	{#State 41
		ACTIONS => {
			"use constant" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"\@{" => -11,
			'WORD_SCOPED' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if" => -11,
			'LITERAL_STRING' => -11,
			"while" => -11,
			'LBRACE' => -11,
			"for" => -11,
			'OP01_PRINT' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LPAREN' => -11,
			'LBRACKET' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			"%{" => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED' => -11,
			'SELF' => -11,
			"## no critic qw(" => 7,
			'CONSTANT_CALL_SCOPED' => -11,
			"our" => -11,
			"foreach" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD' => -11,
			'VARIABLE_SYMBOL' => -11,
			'USE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'MY' => -11,
			"undef" => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'WORD_UPPERCASE' => -11
		},
		GOTOS => {
			'Critic' => 53,
			'STAR-5' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'USE' => 37
		},
		GOTOS => {
			'Include' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 46
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'WORD' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 47
		DEFAULT => -33
	},
	{#State 48
		ACTIONS => {
			";" => 62,
			'OP01_QW' => 63
		}
	},
	{#State 49
		DEFAULT => -23
	},
	{#State 50
		ACTIONS => {
			"our" => 64
		}
	},
	{#State 51
		DEFAULT => -35
	},
	{#State 52
		ACTIONS => {
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			'VARIABLE_SYMBOL' => -13,
			'USE' => 37,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			"undef" => -13,
			'MY' => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			'OP01_CLOSE' => -13,
			'SELF' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"our" => -13,
			"foreach" => -13,
			'OP01_PRINT' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LPAREN' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"%{" => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"\@{" => -13,
			'WORD_SCOPED' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"if" => -13,
			'LITERAL_STRING' => -13,
			'LBRACE' => -13,
			"for" => -13,
			"while" => -13
		},
		GOTOS => {
			'STAR-6' => 66,
			'Include' => 65
		}
	},
	{#State 53
		DEFAULT => -8
	},
	{#State 54
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 67
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 56
		ACTIONS => {
			";" => 69
		}
	},
	{#State 57
		DEFAULT => -32
	},
	{#State 58
		DEFAULT => -219
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		}
	},
	{#State 60
		DEFAULT => -217
	},
	{#State 61
		DEFAULT => -218
	},
	{#State 62
		DEFAULT => -41
	},
	{#State 63
		ACTIONS => {
			";" => 71
		}
	},
	{#State 64
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 72
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -15,
			'OP01_PRINT' => -15,
			'LPAREN' => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"%{" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"use constant" => 43,
			'WORD_SCOPED' => -15,
			"\@{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"if" => -15,
			'LBRACE' => -15,
			"while" => -15,
			"for" => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			'MY' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_OPEN' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED' => -15,
			'SELF' => -15,
			"our" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"foreach" => -15
		},
		GOTOS => {
			'STAR-7' => 74,
			'Constant' => 73
		}
	},
	{#State 67
		ACTIONS => {
			"## no critic qw(" => 7,
			"our hashref \$properties" => -56,
			'USE' => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 76,
			'Critic' => 75
		}
	},
	{#State 68
		ACTIONS => {
			'MY' => 78
		},
		GOTOS => {
			'TypeInnerConstant' => 77
		}
	},
	{#State 69
		DEFAULT => -34
	},
	{#State 70
		ACTIONS => {
			"= sub {" => 79
		}
	},
	{#State 71
		DEFAULT => -42
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		ACTIONS => {
			"undef" => 112,
			'MY' => 113,
			'OP01_OPEN' => 109,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED_VOID' => 117,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'CONSTANT_CALL_SCOPED' => 120,
			"our" => 46,
			"foreach" => -148,
			'OP01_NAMED' => 129,
			'OP01_CLOSE' => 128,
			'SELF' => 125,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'OP01_PRINT' => 95,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 102,
			"if" => 97,
			'LITERAL_STRING' => 100,
			"while" => -148,
			"for" => -148,
			'LBRACE' => 98,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'VariableModification' => 111,
			'LoopLabel' => 83,
			'Operator' => 82,
			'OPTIONAL-37' => 108,
			'OperatorVoid' => 80,
			'Variable' => 81,
			'SubExpression' => 114,
			'PAREN-36' => 87,
			'Expression' => 93,
			'HashDereference' => 91,
			'Statement' => 96,
			'VariableDeclaration' => 119,
			'PLUS-8' => 99,
			'Subroutine' => 121,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'Operation' => 122,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Conditional' => 126,
			'Literal' => 106
		}
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"our hashref \$properties" => -58,
			"use constant" => -58,
			'USE' => 37
		},
		GOTOS => {
			'STAR-23' => 131,
			'Include' => 130
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'LITERAL_STRING' => 100
		},
		GOTOS => {
			'Literal' => 132
		}
	},
	{#State 78
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'WORD' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 133
		}
	},
	{#State 79
		ACTIONS => {
			'OP01_PRINT' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'LPAREN' => -45,
			'LBRACKET' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP10_NAMED_UNARY' => -45,
			"%{" => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LPAREN_MY' => 136,
			"\@{" => -45,
			'WORD_SCOPED' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'LITERAL_STRING' => -45,
			"while" => -45,
			'LBRACE' => -45,
			"for" => -45,
			"if" => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP01_NAMED_VOID' => -45,
			'WORD' => -45,
			'LITERAL_NUMBER' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'MY' => -45,
			"undef" => -45,
			'WORD_UPPERCASE' => -45,
			'OP01_OPEN' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_NAMED' => -45,
			'OP01_CLOSE' => -45,
			'SELF' => -45,
			"}" => -45,
			"foreach" => -45,
			'CONSTANT_CALL_SCOPED' => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 134,
			'SubroutineArguments' => 135
		}
	},
	{#State 80
		DEFAULT => -151
	},
	{#State 81
		ACTIONS => {
			'OP18_TERNARY' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP19_VARIABLE_ASSIGN' => 138,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP16_LOGICAL_OR' => -135,
			")" => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP04_MATH_POW' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 139,
			'OP07_STRING_REPEAT' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP08_STRING_CAT' => -135,
			'OP02_METHOD_THINARROW' => 140,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP03_MATH_INC_DEC' => 137,
			'OP13_BITWISE_AND' => -135
		}
	},
	{#State 82
		DEFAULT => -126
	},
	{#State 83
		ACTIONS => {
			'COLON' => 141
		}
	},
	{#State 84
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 142,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106
		}
	},
	{#State 85
		ACTIONS => {
			'LBRACE' => -211,
			'SELF' => 125,
			'MY' => 147,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'TypeInner' => 149,
			'VariableSymbolOrSelf' => 101,
			'Variable' => 150,
			'OPTIONAL-51' => 148
		}
	},
	{#State 86
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'VARIABLE_SYMBOL' => 118,
			'OP09_BITWISE_SHIFT' => -97,
			'WORD' => 27,
			'OP21_LIST_COMMA' => -97,
			'OP04_MATH_POW' => -97,
			'WORD_UPPERCASE' => 143,
			'OP01_OPEN' => 109,
			'OP16_LOGICAL_OR' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			"undef" => 112,
			'OP18_TERNARY' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP17_LIST_RANGE' => -97,
			'SELF' => 125,
			"]" => -97,
			"}" => -97,
			'OP08_STRING_CAT' => -97,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP15_LOGICAL_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'LPAREN' => 92,
			";" => -97,
			'OP10_NAMED_UNARY' => 86,
			'OP24_LOGICAL_OR_XOR' => -97,
			"%{" => 85,
			'OP05_MATH_NEG_LPAREN' => 84,
			")" => -97,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP23_LOGICAL_AND' => -97,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'OP13_BITWISE_AND' => -97,
			'OP06_REGEX_MATCH' => -97,
			'OP03_MATH_INC_DEC' => 104,
			'LITERAL_STRING' => 100,
			'OP11_COMPARE_LT_GT' => -97,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP07_STRING_REPEAT' => -97
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'ArrayDereference' => 123,
			'SubExpression' => 151,
			'VariableSymbolOrSelf' => 101,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 87
		DEFAULT => -147
	},
	{#State 88
		ACTIONS => {
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"]" => -193,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'ARGV' => 156,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'MY' => 147,
			"undef" => 112
		},
		GOTOS => {
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 154,
			'ArrayReference' => 103,
			'ListElement' => 152,
			'ListElements' => 155,
			'TypeInner' => 153,
			'Variable' => 145,
			'OPTIONAL-46' => 158,
			'Operator' => 82,
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124
		}
	},
	{#State 89
		DEFAULT => -116
	},
	{#State 90
		ACTIONS => {
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105
		},
		GOTOS => {
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 159,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124
		}
	},
	{#State 91
		DEFAULT => -139
	},
	{#State 92
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'OP01_PRINT' => 162,
			'WORD' => 27,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 160,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120
		},
		GOTOS => {
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 161
		}
	},
	{#State 93
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_STRING_CAT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP18_TERNARY' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			";" => 163,
			'OP09_BITWISE_SHIFT' => -132,
			'OP04_MATH_POW' => -132
		}
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 165
		},
		GOTOS => {
			'LoopLabel' => 164
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => -111,
			'ARGV' => -111,
			'WORD' => -111,
			'LITERAL_NUMBER' => -111,
			'LPAREN' => -111,
			'FHREF_SYMBOL_BRACES' => 169,
			'STDOUT_STDERR' => 166,
			'LBRACKET' => -111,
			'OP22_LOGICAL_NEG' => -111,
			'OP01_QW' => -111,
			'MY' => -111,
			"undef" => -111,
			'OP10_NAMED_UNARY' => -111,
			"%{" => -111,
			'WORD_UPPERCASE' => -111,
			'OP01_OPEN' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			'OP01_CLOSE' => -111,
			'OP01_NAMED' => -111,
			"\@{" => -111,
			'SELF' => -111,
			'WORD_SCOPED' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'LITERAL_STRING' => -111,
			'LBRACE' => -111,
			'CONSTANT_CALL_SCOPED' => -111
		},
		GOTOS => {
			'OPTIONAL-32' => 167,
			'PAREN-31' => 168
		}
	},
	{#State 96
		DEFAULT => -79
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 170
		}
	},
	{#State 98
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'SELF' => 125,
			"}" => 173,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 174,
			'LITERAL_STRING' => 100,
			"%{" => 85,
			'ENV' => 171
		},
		GOTOS => {
			'HashDereference' => 178,
			'VariableOrLiteralOrWord' => 172,
			'HashEntry' => 177,
			'Variable' => 176,
			'VariableSymbolOrSelf' => 101,
			'Literal' => 175
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 27,
			'OP01_NAMED_VOID' => 117,
			'VARIABLE_SYMBOL' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'MY' => 113,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED' => 129,
			'OP01_CLOSE' => 128,
			'' => -18,
			'SELF' => 125,
			'CONSTANT_CALL_SCOPED' => 120,
			"foreach" => -148,
			'OP19_LOOP_CONTROL' => 94,
			'OP01_PRINT' => 95,
			'LPAREN' => 92,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP05_MATH_NEG_LPAREN' => 84,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			"if" => 97,
			"for" => -148,
			"while" => -148,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100
		},
		GOTOS => {
			'PAREN-36' => 87,
			'SubExpression' => 114,
			'OPTIONAL-37' => 108,
			'OperatorVoid' => 80,
			'Variable' => 81,
			'Operator' => 82,
			'LoopLabel' => 83,
			'VariableModification' => 111,
			'Statement' => 96,
			'VariableDeclaration' => 119,
			'HashDereference' => 91,
			'Expression' => 93,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'Operation' => 179,
			'ArrayReference' => 103,
			'Literal' => 106,
			'Conditional' => 126,
			'HashReference' => 127,
			'WordScoped' => 124
		}
	},
	{#State 100
		DEFAULT => -232
	},
	{#State 101
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 180
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 181
		}
	},
	{#State 103
		DEFAULT => -136
	},
	{#State 104
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'SELF' => 125
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'Variable' => 182
		}
	},
	{#State 105
		ACTIONS => {
			'SELF' => 125,
			'LBRACKET' => -196,
			'VARIABLE_SYMBOL' => 118,
			'MY' => 147
		},
		GOTOS => {
			'Variable' => 185,
			'OPTIONAL-47' => 184,
			'VariableSymbolOrSelf' => 101,
			'TypeInner' => 183
		}
	},
	{#State 106
		DEFAULT => -134
	},
	{#State 107
		ACTIONS => {
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			")" => -113,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'MY' => 147,
			"undef" => 112,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156
		},
		GOTOS => {
			'ListElements' => 187,
			'TypeInner' => 153,
			'ArrayDereference' => 123,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 101,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82,
			'Literal' => 106,
			'HashReference' => 127,
			'OPTIONAL-33' => 186,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146
		}
	},
	{#State 108
		ACTIONS => {
			"while" => 192,
			"for" => 193,
			"foreach" => 189
		},
		GOTOS => {
			'LoopWhile' => 194,
			'LoopForEach' => 188,
			'Loop' => 190,
			'LoopFor' => 191
		}
	},
	{#State 109
		ACTIONS => {
			'MY' => 195
		}
	},
	{#State 110
		ACTIONS => {
			'COLON' => -216,
			'LPAREN' => 196
		}
	},
	{#State 111
		ACTIONS => {
			";" => 197
		}
	},
	{#State 112
		DEFAULT => -133
	},
	{#State 113
		ACTIONS => {
			'TYPE_FHREF' => 199,
			'WORD' => 60,
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 61
		},
		GOTOS => {
			'Type' => 198
		}
	},
	{#State 114
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP07_STRING_REPEAT' => 214,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP08_STRING_CAT' => 202,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => 216,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 115
		DEFAULT => -120
	},
	{#State 116
		DEFAULT => -231
	},
	{#State 117
		ACTIONS => {
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'MY' => 147,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'ARGV' => 156,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'ListElements' => 217,
			'TypeInner' => 153,
			'ArrayDereference' => 123,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 101,
			'ListElement' => 152,
			'ArrayReference' => 103
		}
	},
	{#State 118
		DEFAULT => -229
	},
	{#State 119
		DEFAULT => -152
	},
	{#State 120
		DEFAULT => -128
	},
	{#State 121
		DEFAULT => -14
	},
	{#State 122
		DEFAULT => -17
	},
	{#State 123
		DEFAULT => -137
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 219,
			'OP02_METHOD_THINARROW_NEW' => 218
		}
	},
	{#State 125
		DEFAULT => -230
	},
	{#State 126
		DEFAULT => -149
	},
	{#State 127
		DEFAULT => -138
	},
	{#State 128
		ACTIONS => {
			'FHREF_SYMBOL' => 220
		}
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'MY' => 147,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120
		},
		GOTOS => {
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ListElement' => 221,
			'SubExpression' => 222,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'TypeInner' => 153
		}
	},
	{#State 130
		DEFAULT => -55
	},
	{#State 131
		ACTIONS => {
			"use constant" => 43,
			"our hashref \$properties" => 224
		},
		GOTOS => {
			'Constant' => 225,
			'Properties' => 223
		}
	},
	{#State 132
		ACTIONS => {
			";" => 226
		}
	},
	{#State 133
		ACTIONS => {
			"\$TYPED_" => 227
		}
	},
	{#State 134
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 228
		}
	},
	{#State 135
		DEFAULT => -44
	},
	{#State 136
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'WORD' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 229
		}
	},
	{#State 137
		DEFAULT => -86
	},
	{#State 138
		ACTIONS => {
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'FHREF_SYMBOL_IN' => 231,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'LBRACKET' => 88,
			'STDIN' => 233,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27
		},
		GOTOS => {
			'Variable' => 145,
			'SubExpressionOrInput' => 230,
			'Operator' => 82,
			'SubExpression' => 232,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127
		}
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112
		},
		GOTOS => {
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 234,
			'ArrayDereference' => 123,
			'ArrayReference' => 103
		}
	},
	{#State 140
		ACTIONS => {
			'LPAREN' => 235
		}
	},
	{#State 141
		DEFAULT => -146
	},
	{#State 142
		ACTIONS => {
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP08_STRING_CAT' => 202,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP16_LOGICAL_OR' => 208,
			")" => 236,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210
		}
	},
	{#State 143
		ACTIONS => {
			'LPAREN' => 196
		}
	},
	{#State 144
		ACTIONS => {
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 237,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 145
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -135,
			")" => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP18_TERNARY' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			";" => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP04_MATH_POW' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			"}" => -135,
			'OP13_BITWISE_AND' => -135,
			'OP03_MATH_INC_DEC' => 137,
			'OP06_REGEX_MATCH' => -135,
			"]" => -135,
			'OP08_STRING_CAT' => -135,
			'OP02_METHOD_THINARROW' => 140
		}
	},
	{#State 146
		DEFAULT => -132
	},
	{#State 147
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'TYPE_INTEGER' => 58,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 238
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACE' => 98
		},
		GOTOS => {
			'HashReference' => 239
		}
	},
	{#State 149
		DEFAULT => -210
	},
	{#State 150
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 151
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 207,
			'OP21_LIST_COMMA' => -96,
			'OP04_MATH_POW' => 206,
			";" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP23_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP08_MATH_ADD_SUB' => 209,
			'OP16_LOGICAL_OR' => -96,
			")" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => 202,
			'OP06_REGEX_MATCH' => 212,
			"}" => -96,
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_STRING_REPEAT' => 214,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96
		}
	},
	{#State 152
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 241
		}
	},
	{#State 153
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85
		},
		GOTOS => {
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 242,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124
		}
	},
	{#State 154
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => -188,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP08_STRING_CAT' => 202,
			")" => -188,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			";" => -188,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -188,
			'OP09_BITWISE_SHIFT' => 207
		}
	},
	{#State 155
		DEFAULT => -192
	},
	{#State 156
		DEFAULT => -191
	},
	{#State 157
		DEFAULT => -190
	},
	{#State 158
		ACTIONS => {
			"]" => 243
		}
	},
	{#State 159
		ACTIONS => {
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			")" => -106,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 207,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 206,
			";" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP08_STRING_CAT' => 202,
			"}" => -106,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => -106,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'MY' => 147,
			"undef" => 112,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ArrayReference' => 103,
			'ListElement' => 244,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 222,
			'ArrayDereference' => 123,
			'TypeInner' => 153,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 161
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			")" => 245,
			'OP16_LOGICAL_OR' => 208,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_STRING_CAT' => 202,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212
		}
	},
	{#State 162
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 246
		}
	},
	{#State 163
		DEFAULT => -78
	},
	{#State 164
		ACTIONS => {
			";" => 247
		}
	},
	{#State 165
		DEFAULT => -216
	},
	{#State 166
		DEFAULT => -109
	},
	{#State 167
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'ARGV' => 156,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'MY' => 147,
			"undef" => 112,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 154,
			'ArrayDereference' => 123,
			'TypeInner' => 153,
			'ListElements' => 248,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 168
		DEFAULT => -110
	},
	{#State 169
		ACTIONS => {
			"undef" => 112,
			'MY' => 147,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'WORD' => 27,
			'ARGV' => 156,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'ListElements' => 249,
			'TypeInner' => 153,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'SubExpression' => 250,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 171
		DEFAULT => -203
	},
	{#State 172
		ACTIONS => {
			'OP20_HASH_FATARROW' => 251
		}
	},
	{#State 173
		DEFAULT => -209
	},
	{#State 174
		DEFAULT => -228
	},
	{#State 175
		DEFAULT => -227
	},
	{#State 176
		DEFAULT => -226
	},
	{#State 177
		DEFAULT => -207,
		GOTOS => {
			'STAR-50' => 252
		}
	},
	{#State 178
		DEFAULT => -202
	},
	{#State 179
		DEFAULT => -16
	},
	{#State 180
		ACTIONS => {
			"]" => -174,
			'OP03_MATH_INC_DEC' => -174,
			"}" => -174,
			'OP13_BITWISE_AND' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP02_ARRAY_THINARROW' => 254,
			'OP17_LIST_RANGE' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP08_STRING_CAT' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP07_STRING_REPEAT' => -174,
			";" => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'COLON' => -174,
			'OP04_MATH_POW' => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP20_HASH_FATARROW' => -174,
			")" => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP23_LOGICAL_AND' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP18_TERNARY' => -174,
			'OP02_HASH_THINARROW' => 253
		},
		GOTOS => {
			'VariableRetrieval' => 255
		}
	},
	{#State 181
		ACTIONS => {
			'OP21_LIST_COMMA' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			";" => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP18_TERNARY' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			")" => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP08_STRING_CAT' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP17_LIST_RANGE' => -88,
			"]" => -88,
			"}" => -88,
			'OP13_BITWISE_AND' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP14_BITWISE_OR_XOR' => -88
		}
	},
	{#State 182
		DEFAULT => -85
	},
	{#State 183
		DEFAULT => -195
	},
	{#State 184
		ACTIONS => {
			'LBRACKET' => 88
		},
		GOTOS => {
			'ArrayReference' => 256
		}
	},
	{#State 185
		ACTIONS => {
			"}" => 257
		}
	},
	{#State 186
		ACTIONS => {
			")" => 258
		}
	},
	{#State 187
		DEFAULT => -112
	},
	{#State 188
		DEFAULT => -162
	},
	{#State 189
		ACTIONS => {
			'MY' => 259
		}
	},
	{#State 190
		DEFAULT => -150
	},
	{#State 191
		DEFAULT => -161
	},
	{#State 192
		ACTIONS => {
			'LPAREN_MY' => 260,
			'LPAREN' => 261
		}
	},
	{#State 193
		ACTIONS => {
			'MY' => 262,
			'LPAREN_MY' => 263
		}
	},
	{#State 194
		DEFAULT => -163
	},
	{#State 195
		ACTIONS => {
			'TYPE_FHREF' => 264
		}
	},
	{#State 196
		ACTIONS => {
			")" => 265
		}
	},
	{#State 197
		DEFAULT => -153
	},
	{#State 198
		ACTIONS => {
			'VARIABLE_SYMBOL' => 266
		}
	},
	{#State 199
		ACTIONS => {
			'FHREF_SYMBOL' => 267
		}
	},
	{#State 200
		ACTIONS => {
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105
		},
		GOTOS => {
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 268,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124
		}
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP03_MATH_INC_DEC' => 104,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 269,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82,
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124
		}
	},
	{#State 202
		ACTIONS => {
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'SubExpression' => 270,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'ArrayReference' => 103
		}
	},
	{#State 203
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'SubExpression' => 271,
			'VariableSymbolOrSelf' => 101,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 204
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 272,
			'ArrayDereference' => 123,
			'ArrayReference' => 103
		}
	},
	{#State 205
		ACTIONS => {
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112
		},
		GOTOS => {
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 273,
			'ArrayDereference' => 123
		}
	},
	{#State 206
		ACTIONS => {
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'SubExpression' => 274,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 207
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'Variable' => 145,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 275,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127
		}
	},
	{#State 208
		ACTIONS => {
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 276,
			'ArrayReference' => 103
		}
	},
	{#State 209
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'SubExpression' => 277,
			'VariableSymbolOrSelf' => 101,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 210
		ACTIONS => {
			'SELF' => 125,
			'LITERAL_STRING' => 100,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'Variable' => 279,
			'VariableOrLiteral' => 280,
			'Literal' => 278,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 211
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'SubExpression' => 281,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106
		}
	},
	{#State 212
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 282
		}
	},
	{#State 213
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 283,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 214
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'Variable' => 145,
			'Operator' => 82,
			'SubExpression' => 284,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127
		}
	},
	{#State 215
		ACTIONS => {
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27
		},
		GOTOS => {
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 285,
			'ArrayDereference' => 123,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91
		}
	},
	{#State 216
		ACTIONS => {
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 286,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106
		}
	},
	{#State 217
		ACTIONS => {
			";" => 287
		}
	},
	{#State 218
		ACTIONS => {
			")" => 288
		}
	},
	{#State 219
		ACTIONS => {
			'MY' => 147,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			")" => -123,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104
		},
		GOTOS => {
			'Literal' => 106,
			'HashReference' => 127,
			'OPTIONAL-34' => 290,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'ListElements' => 289,
			'TypeInner' => 153,
			'SubExpression' => 154,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'ArrayReference' => 103,
			'ListElement' => 152,
			'Variable' => 145,
			'Operator' => 82
		}
	},
	{#State 220
		DEFAULT => -84
	},
	{#State 221
		ACTIONS => {
			'OP21_LIST_COMMA' => 291
		}
	},
	{#State 222
		ACTIONS => {
			'OP06_REGEX_MATCH' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP08_STRING_CAT' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP07_STRING_REPEAT' => -81,
			";" => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP21_LIST_COMMA' => -188,
			'OP04_MATH_POW' => -81,
			")" => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => -81,
			'OP08_MATH_ADD_SUB' => -81
		}
	},
	{#State 223
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 292
		}
	},
	{#State 224
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 293
		}
	},
	{#State 225
		DEFAULT => -57
	},
	{#State 226
		DEFAULT => -43
	},
	{#State 227
		ACTIONS => {
			'WORD_UPPERCASE' => 294
		}
	},
	{#State 228
		ACTIONS => {
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 100,
			"for" => -148,
			'LBRACE' => 98,
			"while" => -148,
			"if" => 97,
			'OP01_PRINT' => 95,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 92,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 129,
			'SELF' => 125,
			"}" => 295,
			"foreach" => -148,
			'CONSTANT_CALL_SCOPED' => 120,
			'VARIABLE_SYMBOL' => 118,
			'OP01_NAMED_VOID' => 117,
			'WORD' => 27,
			'LITERAL_NUMBER' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			"undef" => 112,
			'MY' => 113,
			'WORD_UPPERCASE' => 110,
			'OP01_OPEN' => 109,
			'OP01_NAMED_VOID_LPAREN' => 107
		},
		GOTOS => {
			'VariableDeclaration' => 119,
			'Statement' => 96,
			'Expression' => 93,
			'HashDereference' => 91,
			'SubExpression' => 114,
			'PAREN-36' => 87,
			'VariableModification' => 111,
			'Operator' => 82,
			'LoopLabel' => 83,
			'Variable' => 81,
			'OperatorVoid' => 80,
			'OPTIONAL-37' => 108,
			'HashReference' => 127,
			'Conditional' => 126,
			'Literal' => 106,
			'WordScoped' => 124,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'Operation' => 296
		}
	},
	{#State 229
		ACTIONS => {
			'VARIABLE_SYMBOL' => 297
		}
	},
	{#State 230
		DEFAULT => -182
	},
	{#State 231
		DEFAULT => -142
	},
	{#State 232
		ACTIONS => {
			'OP08_STRING_CAT' => 202,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -141,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			")" => -141,
			'OP16_LOGICAL_OR' => 208
		}
	},
	{#State 233
		DEFAULT => -143
	},
	{#State 234
		ACTIONS => {
			";" => -183,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			")" => -183,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP08_STRING_CAT' => 202,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 235
		ACTIONS => {
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'ARGV' => 156,
			'VARIABLE_SYMBOL' => 118,
			")" => -125,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'MY' => 147,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'TypeInner' => 153,
			'ListElements' => 299,
			'ArrayReference' => 103,
			'ListElement' => 152,
			'SubExpression' => 154,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106,
			'OPTIONAL-35' => 298
		}
	},
	{#State 236
		DEFAULT => -89
	},
	{#State 237
		ACTIONS => {
			"]" => -81,
			'OP13_BITWISE_AND' => -81,
			"}" => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP08_STRING_CAT' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP07_STRING_REPEAT' => -81,
			";" => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP04_MATH_POW' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			")" => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP18_TERNARY' => -81
		}
	},
	{#State 238
		ACTIONS => {
			"\$TYPED_" => 300
		}
	},
	{#State 239
		ACTIONS => {
			"}" => 301
		}
	},
	{#State 240
		DEFAULT => -212
	},
	{#State 241
		ACTIONS => {
			"]" => -187,
			";" => -187,
			")" => -187,
			'OP21_LIST_COMMA' => 303
		},
		GOTOS => {
			'PAREN-44' => 302
		}
	},
	{#State 242
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 214,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			"]" => -189,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP08_STRING_CAT' => 202,
			'OP24_LOGICAL_OR_XOR' => 215,
			")" => -189,
			'OP16_LOGICAL_OR' => 208,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -189,
			'OP21_LIST_COMMA' => -189,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 243
		DEFAULT => -194
	},
	{#State 244
		ACTIONS => {
			'OP21_LIST_COMMA' => 304
		}
	},
	{#State 245
		DEFAULT => -140
	},
	{#State 246
		ACTIONS => {
			"undef" => 112,
			'MY' => 147,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104
		},
		GOTOS => {
			'Variable' => 145,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 154,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'ListElement' => 152,
			'ListElements' => 305,
			'TypeInner' => 153,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127
		}
	},
	{#State 247
		DEFAULT => -121
	},
	{#State 248
		ACTIONS => {
			";" => 306
		}
	},
	{#State 249
		ACTIONS => {
			";" => 307
		}
	},
	{#State 250
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP08_STRING_CAT' => 202,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 214,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP24_LOGICAL_OR_XOR' => 215,
			")" => 308,
			'OP16_LOGICAL_OR' => 208,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216
		}
	},
	{#State 251
		ACTIONS => {
			'LBRACE' => -200,
			'LITERAL_STRING' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'OP05_LOGICAL_NEG' => -200,
			'WORD_SCOPED' => -200,
			'SELF' => -200,
			"\@{" => -200,
			'OP03_MATH_INC_DEC' => -200,
			'OP01_NAMED' => -200,
			'OP01_CLOSE' => -200,
			"%{" => -200,
			'WORD_UPPERCASE' => -200,
			'OP10_NAMED_UNARY' => -200,
			'OP01_OPEN' => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			'MY' => 147,
			"undef" => -200,
			'OP22_LOGICAL_NEG' => -200,
			'LBRACKET' => -200,
			'LPAREN' => -200,
			'LITERAL_NUMBER' => -200,
			'VARIABLE_SYMBOL' => -200,
			'WORD' => -200
		},
		GOTOS => {
			'OPTIONAL-48' => 309,
			'TypeInner' => 310
		}
	},
	{#State 252
		ACTIONS => {
			"}" => 312,
			'OP21_LIST_COMMA' => 311
		},
		GOTOS => {
			'PAREN-49' => 313
		}
	},
	{#State 253
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 314,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 315,
			'ArrayDereference' => 123,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 254
		ACTIONS => {
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'SubExpression' => 316,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 255
		DEFAULT => -172
	},
	{#State 256
		ACTIONS => {
			"}" => 317
		}
	},
	{#State 257
		DEFAULT => -197
	},
	{#State 258
		ACTIONS => {
			";" => 318
		}
	},
	{#State 259
		ACTIONS => {
			'WORD' => 60,
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 61
		},
		GOTOS => {
			'Type' => 319
		}
	},
	{#State 260
		ACTIONS => {
			'WORD' => 60,
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 61
		},
		GOTOS => {
			'Type' => 320
		}
	},
	{#State 261
		ACTIONS => {
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'ArrayReference' => 103,
			'SubExpression' => 321,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91
		}
	},
	{#State 262
		ACTIONS => {
			'TYPE_INTEGER' => 322
		}
	},
	{#State 263
		ACTIONS => {
			'TYPE_INTEGER' => 323
		}
	},
	{#State 264
		ACTIONS => {
			'FHREF_SYMBOL' => 324
		}
	},
	{#State 265
		DEFAULT => -127
	},
	{#State 266
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 327,
			";" => 325,
			'OP02_ARRAY_THINARROW' => 326
		}
	},
	{#State 267
		ACTIONS => {
			";" => 328
		}
	},
	{#State 268
		ACTIONS => {
			'OP08_STRING_CAT' => 202,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => undef,
			"}" => -104,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			"]" => -104,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP21_LIST_COMMA' => -104,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -104,
			'OP18_TERNARY' => -104,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => 208,
			")" => -104
		}
	},
	{#State 269
		ACTIONS => {
			"]" => -99,
			'OP13_BITWISE_AND' => -99,
			"}" => -99,
			'OP06_REGEX_MATCH' => 212,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP08_STRING_CAT' => 202,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			";" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -99,
			'OP09_BITWISE_SHIFT' => 207,
			'OP16_LOGICAL_OR' => -99,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => -99
		}
	},
	{#State 270
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 214,
			'OP17_LIST_RANGE' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"]" => -94,
			"}" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP06_REGEX_MATCH' => 212,
			'OP08_STRING_CAT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			")" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -94
		}
	},
	{#State 271
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => -102,
			'OP13_BITWISE_AND' => 211,
			"}" => -102,
			'OP06_REGEX_MATCH' => 212,
			"]" => -102,
			'OP08_STRING_CAT' => 202,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => -102,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 272
		ACTIONS => {
			'OP07_STRING_REPEAT' => 214,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 213,
			'OP08_STRING_CAT' => 202,
			"}" => -101,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => -101,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP08_MATH_ADD_SUB' => 209,
			'OP16_LOGICAL_OR' => -101,
			")" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -101,
			'OP09_BITWISE_SHIFT' => 207,
			";" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 205
		}
	},
	{#State 273
		ACTIONS => {
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			"]" => -92,
			'OP06_REGEX_MATCH' => 212,
			"}" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP18_TERNARY' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			")" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			";" => -92
		}
	},
	{#State 274
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -87,
			")" => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP18_TERNARY' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			";" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			'OP17_LIST_RANGE' => -87,
			"}" => -87,
			'OP06_REGEX_MATCH' => -87,
			'OP13_BITWISE_AND' => -87,
			"]" => -87,
			'OP08_STRING_CAT' => -87
		}
	},
	{#State 275
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP16_LOGICAL_OR' => -95,
			")" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -95,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP08_STRING_CAT' => 202,
			'OP17_LIST_RANGE' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"]" => -95,
			'OP13_BITWISE_AND' => -95,
			"}" => -95,
			'OP06_REGEX_MATCH' => 212
		}
	},
	{#State 276
		ACTIONS => {
			'OP07_STRING_REPEAT' => 214,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP08_STRING_CAT' => 202,
			"}" => -103,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP23_LOGICAL_AND' => -103,
			'OP18_TERNARY' => -103,
			'OP08_MATH_ADD_SUB' => 209,
			")" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 207,
			'OP21_LIST_COMMA' => -103,
			'OP04_MATH_POW' => 206,
			";" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 205
		}
	},
	{#State 277
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			")" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP18_TERNARY' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP17_LIST_RANGE' => -93,
			"]" => -93,
			'OP13_BITWISE_AND' => -93,
			"}" => -93,
			'OP06_REGEX_MATCH' => 212,
			'OP08_STRING_CAT' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 278
		DEFAULT => -225
	},
	{#State 279
		DEFAULT => -224
	},
	{#State 280
		ACTIONS => {
			'COLON' => 329
		}
	},
	{#State 281
		ACTIONS => {
			";" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => 207,
			")" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 209,
			'OP06_REGEX_MATCH' => 212,
			"}" => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP08_STRING_CAT' => 202,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 282
		DEFAULT => -90
	},
	{#State 283
		ACTIONS => {
			'OP21_LIST_COMMA' => -98,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -98,
			'OP18_TERNARY' => -98,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			")" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => 202,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP17_LIST_RANGE' => -98,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP06_REGEX_MATCH' => 212,
			"]" => -98,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => undef,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98
		}
	},
	{#State 284
		ACTIONS => {
			")" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP18_TERNARY' => -91,
			";" => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP04_MATH_POW' => 206,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP07_STRING_REPEAT' => -91,
			"]" => -91,
			"}" => -91,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP08_STRING_CAT' => -91
		}
	},
	{#State 285
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -108,
			")" => -108,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => 216,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP07_STRING_REPEAT' => 214,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			"}" => -108,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => -108,
			'OP08_STRING_CAT' => 202
		}
	},
	{#State 286
		ACTIONS => {
			'OP08_STRING_CAT' => 202,
			"]" => -107,
			'OP06_REGEX_MATCH' => 212,
			"}" => -107,
			'OP13_BITWISE_AND' => 211,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP07_STRING_REPEAT' => 214,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -107,
			'OP09_BITWISE_SHIFT' => 207,
			";" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP23_LOGICAL_AND' => -107,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			")" => -107,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => -107
		}
	},
	{#State 287
		DEFAULT => -118
	},
	{#State 288
		DEFAULT => -131
	},
	{#State 289
		DEFAULT => -122
	},
	{#State 290
		ACTIONS => {
			")" => 330
		}
	},
	{#State 291
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'MY' => 147,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'ARGV' => 156,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92
		},
		GOTOS => {
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 101,
			'TypeInner' => 153,
			'ListElements' => 331
		}
	},
	{#State 292
		ACTIONS => {
			"our" => 336,
			'LITERAL_NUMBER' => 333
		},
		GOTOS => {
			'MethodOrSubroutine' => 332,
			'Subroutine' => 335,
			'Method' => 334
		}
	},
	{#State 293
		ACTIONS => {
			'LBRACE' => 337
		}
	},
	{#State 294
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 338
		}
	},
	{#State 295
		ACTIONS => {
			";" => 339
		}
	},
	{#State 296
		DEFAULT => -46
	},
	{#State 297
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 340
		}
	},
	{#State 298
		ACTIONS => {
			")" => 341
		}
	},
	{#State 299
		DEFAULT => -124
	},
	{#State 300
		ACTIONS => {
			'WORD' => 342
		}
	},
	{#State 301
		DEFAULT => -213
	},
	{#State 302
		DEFAULT => -185
	},
	{#State 303
		ACTIONS => {
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'ARGV' => 156,
			'VARIABLE_SYMBOL' => 118,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'MY' => 147,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_QW' => 157,
			'LBRACKET' => 88,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'ArrayReference' => 103,
			'ListElement' => 343,
			'ArrayDereference' => 123,
			'SubExpression' => 154,
			'VariableSymbolOrSelf' => 101,
			'TypeInner' => 153,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124
		}
	},
	{#State 304
		ACTIONS => {
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'ARGV' => 156,
			'VARIABLE_SYMBOL' => 118,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			"undef" => 112,
			'MY' => 147,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP01_QW' => 157,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 154,
			'TypeInner' => 153,
			'ListElements' => 344,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 305
		ACTIONS => {
			")" => 345
		}
	},
	{#State 306
		DEFAULT => -114
	},
	{#State 307
		DEFAULT => -115
	},
	{#State 308
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 347
		}
	},
	{#State 309
		ACTIONS => {
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144
		},
		GOTOS => {
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'SubExpression' => 348,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'ArrayReference' => 103
		}
	},
	{#State 310
		DEFAULT => -199
	},
	{#State 311
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'LITERAL_STRING' => 100,
			"%{" => 85,
			'SELF' => 125,
			'VARIABLE_SYMBOL' => 118,
			'ENV' => 171,
			'WORD' => 174
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'Literal' => 175,
			'HashDereference' => 178,
			'Variable' => 176,
			'VariableOrLiteralOrWord' => 172,
			'HashEntry' => 349
		}
	},
	{#State 312
		DEFAULT => -208
	},
	{#State 313
		DEFAULT => -206
	},
	{#State 314
		ACTIONS => {
			"}" => 350,
			'OP02_METHOD_THINARROW_NEW' => -214,
			'LPAREN' => -214
		}
	},
	{#State 315
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_STRING_CAT' => 202,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			"}" => 351,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211
		}
	},
	{#State 316
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			"]" => 352,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP08_STRING_CAT' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 317
		DEFAULT => -198
	},
	{#State 318
		DEFAULT => -117
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 354
		}
	},
	{#State 321
		ACTIONS => {
			'OP08_STRING_CAT' => 202,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			")" => 355
		}
	},
	{#State 322
		ACTIONS => {
			'VARIABLE_SYMBOL' => 356
		}
	},
	{#State 323
		ACTIONS => {
			'VARIABLE_SYMBOL' => 357
		}
	},
	{#State 324
		ACTIONS => {
			'OP21_LIST_COMMA' => 358
		}
	},
	{#State 325
		DEFAULT => -178
	},
	{#State 326
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'SubExpression' => 359,
			'VariableSymbolOrSelf' => 101,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106
		}
	},
	{#State 327
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'FHREF_SYMBOL_IN' => 231,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'LBRACKET' => 88,
			'STDIN' => 233,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118
		},
		GOTOS => {
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127,
			'Variable' => 145,
			'Operator' => 82,
			'SubExpressionOrInput' => 360,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 232,
			'ArrayReference' => 103
		}
	},
	{#State 328
		DEFAULT => -181
	},
	{#State 329
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_STRING' => 100,
			'LITERAL_NUMBER' => 116,
			'SELF' => 125
		},
		GOTOS => {
			'Variable' => 279,
			'Literal' => 278,
			'VariableOrLiteral' => 361,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 330
		DEFAULT => -129
	},
	{#State 331
		ACTIONS => {
			";" => 362
		}
	},
	{#State 332
		DEFAULT => -59
	},
	{#State 333
		ACTIONS => {
			";" => 363
		}
	},
	{#State 334
		DEFAULT => -76
	},
	{#State 335
		DEFAULT => -77
	},
	{#State 336
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'TYPE_METHOD' => 364,
			'TYPE_INTEGER' => 58,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 337
		ACTIONS => {
			'WORD' => 367,
			"}" => 366
		},
		GOTOS => {
			'HashEntryProperties' => 365
		}
	},
	{#State 338
		DEFAULT => -223
	},
	{#State 339
		DEFAULT => -48
	},
	{#State 340
		ACTIONS => {
			")" => 369,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-19' => 368
		}
	},
	{#State 341
		DEFAULT => -130
	},
	{#State 342
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 343
		DEFAULT => -184
	},
	{#State 344
		ACTIONS => {
			")" => 372
		}
	},
	{#State 345
		DEFAULT => -80
	},
	{#State 346
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			"foreach" => -148,
			'OP01_NAMED' => 129,
			'OP01_CLOSE' => 128,
			'SELF' => 125,
			'MY' => 113,
			"undef" => 112,
			'OP01_OPEN' => 109,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED_VOID' => 117,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			"if" => 97,
			'LITERAL_STRING' => 100,
			"while" => -148,
			"for" => -148,
			'LBRACE' => 98,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'OP01_PRINT' => 95,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 92
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'Operation' => 374,
			'ArrayReference' => 103,
			'Conditional' => 126,
			'Literal' => 106,
			'HashReference' => 127,
			'WordScoped' => 124,
			'PLUS-42' => 373,
			'SubExpression' => 114,
			'PAREN-36' => 87,
			'VariableModification' => 111,
			'OPTIONAL-37' => 108,
			'Variable' => 81,
			'OperatorVoid' => 80,
			'LoopLabel' => 83,
			'Operator' => 82,
			'VariableDeclaration' => 119,
			'Statement' => 96,
			'HashDereference' => 91,
			'Expression' => 93
		}
	},
	{#State 347
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 375
		}
	},
	{#State 348
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP06_REGEX_MATCH' => 212,
			"}" => -201,
			'OP13_BITWISE_AND' => 211,
			'OP08_STRING_CAT' => 202,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 214,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP21_LIST_COMMA' => -201,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216
		}
	},
	{#State 349
		DEFAULT => -205
	},
	{#State 350
		DEFAULT => -177
	},
	{#State 351
		DEFAULT => -176
	},
	{#State 352
		DEFAULT => -175
	},
	{#State 353
		ACTIONS => {
			'LPAREN' => 376
		}
	},
	{#State 354
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 356
		ACTIONS => {
			'LPAREN' => 379
		}
	},
	{#State 357
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 358
		ACTIONS => {
			'LITERAL_STRING' => 381
		}
	},
	{#State 359
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			"]" => 382,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP08_STRING_CAT' => 202,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 360
		ACTIONS => {
			";" => 383
		}
	},
	{#State 361
		DEFAULT => -105
	},
	{#State 362
		DEFAULT => -119
	},
	{#State 363
		DEFAULT => -61
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 365
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 385
		}
	},
	{#State 366
		ACTIONS => {
			";" => 386
		}
	},
	{#State 367
		ACTIONS => {
			'OP20_HASH_FATARROW' => 387
		}
	},
	{#State 368
		DEFAULT => -50
	},
	{#State 369
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 388
		}
	},
	{#State 370
		ACTIONS => {
			'MY' => 389
		}
	},
	{#State 371
		DEFAULT => -220
	},
	{#State 372
		DEFAULT => -82
	},
	{#State 373
		ACTIONS => {
			'OP01_PRINT' => 95,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 92,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 102,
			"if" => 97,
			'LITERAL_STRING' => 100,
			"while" => -148,
			"for" => -148,
			'LBRACE' => 98,
			'OP01_NAMED_VOID' => 117,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'MY' => 113,
			"undef" => 112,
			'OP01_OPEN' => 109,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED' => 129,
			'OP01_CLOSE' => 128,
			"}" => 390,
			'SELF' => 125,
			'CONSTANT_CALL_SCOPED' => 120,
			"foreach" => -148
		},
		GOTOS => {
			'Operator' => 82,
			'LoopLabel' => 83,
			'OPTIONAL-37' => 108,
			'OperatorVoid' => 80,
			'Variable' => 81,
			'VariableModification' => 111,
			'PAREN-36' => 87,
			'SubExpression' => 114,
			'Expression' => 93,
			'HashDereference' => 91,
			'Statement' => 96,
			'VariableDeclaration' => 119,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'Operation' => 391,
			'VariableSymbolOrSelf' => 101,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Conditional' => 126,
			'Literal' => 106
		}
	},
	{#State 374
		DEFAULT => -170
	},
	{#State 375
		ACTIONS => {
			'LPAREN' => -159,
			'OP01_PRINT' => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP10_NAMED_UNARY' => -159,
			"%{" => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			'LBRACKET' => -159,
			'OP22_LOGICAL_NEG' => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			"\@{" => -159,
			'WORD_SCOPED' => -159,
			'OP03_MATH_INC_DEC' => -159,
			'LITERAL_STRING' => -159,
			"for" => -159,
			'LBRACE' => -159,
			"while" => -159,
			"if" => -159,
			'OP05_LOGICAL_NEG' => -159,
			'LITERAL_NUMBER' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'VARIABLE_SYMBOL' => -159,
			'OP01_NAMED_VOID' => -159,
			'WORD' => -159,
			'WORD_UPPERCASE' => -159,
			'OP01_OPEN' => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			"undef" => -159,
			'MY' => -159,
			'SELF' => -159,
			"}" => -159,
			"elsif" => 394,
			'' => -159,
			"else" => 396,
			'OP01_CLOSE' => -159,
			'OP01_NAMED' => -159,
			"foreach" => -159,
			'CONSTANT_CALL_SCOPED' => -159
		},
		GOTOS => {
			'PAREN-38' => 393,
			'PAREN-40' => 395,
			'OPTIONAL-41' => 392
		}
	},
	{#State 376
		ACTIONS => {
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'MY' => 147,
			"undef" => 112,
			'OP01_QW' => 157,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'ARGV' => 156,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP05_LOGICAL_NEG' => 102,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'TypeInner' => 153,
			'ListElements' => 397,
			'ListElement' => 152,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 154,
			'ArrayDereference' => 123
		}
	},
	{#State 377
		ACTIONS => {
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 90,
			'STDIN' => 233,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'FHREF_SYMBOL_IN' => 231,
			'OP10_NAMED_UNARY' => 86,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98
		},
		GOTOS => {
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 232,
			'ArrayReference' => 103,
			'Variable' => 145,
			'SubExpressionOrInput' => 398,
			'Operator' => 82,
			'Literal' => 106,
			'HashReference' => 127,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146
		}
	},
	{#State 378
		DEFAULT => -167
	},
	{#State 379
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 104,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92
		},
		GOTOS => {
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 399,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'HashReference' => 127,
			'Literal' => 106
		}
	},
	{#State 380
		ACTIONS => {
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100
		},
		GOTOS => {
			'Variable' => 145,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 400,
			'ArrayDereference' => 123,
			'ArrayReference' => 103,
			'WordScoped' => 124,
			'HashDereference' => 91,
			'Expression' => 146,
			'Literal' => 106,
			'HashReference' => 127
		}
	},
	{#State 381
		ACTIONS => {
			'OP21_LIST_COMMA' => 401
		}
	},
	{#State 382
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 383
		DEFAULT => -179
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 403
		}
	},
	{#State 385
		ACTIONS => {
			'OP21_LIST_COMMA' => 405,
			"}" => 404
		},
		GOTOS => {
			'PAREN-25' => 406
		}
	},
	{#State 386
		DEFAULT => -66
	},
	{#State 387
		ACTIONS => {
			'MY' => 408
		},
		GOTOS => {
			'TypeInnerProperties' => 407
		}
	},
	{#State 388
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 389
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'WORD' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 390
		DEFAULT => -171
	},
	{#State 391
		DEFAULT => -169
	},
	{#State 392
		DEFAULT => -160
	},
	{#State 393
		DEFAULT => -155
	},
	{#State 394
		ACTIONS => {
			'LPAREN' => 411
		}
	},
	{#State 395
		DEFAULT => -158
	},
	{#State 396
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 412
		}
	},
	{#State 397
		ACTIONS => {
			")" => 413
		}
	},
	{#State 398
		ACTIONS => {
			")" => 414
		}
	},
	{#State 399
		ACTIONS => {
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP08_STRING_CAT' => 202,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 415,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204
		}
	},
	{#State 400
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP08_STRING_CAT' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			";" => 416,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 401
		ACTIONS => {
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143
		},
		GOTOS => {
			'ArrayReference' => 103,
			'SubExpression' => 417,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'Operator' => 82,
			'Variable' => 145,
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124
		}
	},
	{#State 402
		ACTIONS => {
			"undef" => 418
		}
	},
	{#State 403
		ACTIONS => {
			'OP01_NAMED_VOID' => -68,
			'WORD' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'LITERAL_NUMBER' => -68,
			"undef" => -68,
			'MY' => -68,
			'OP01_OPEN' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'WORD_UPPERCASE' => -68,
			'OP01_NAMED' => -68,
			'OP01_CLOSE' => -68,
			"}" => -68,
			'SELF' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"foreach" => -68,
			'OP01_PRINT' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'LPAREN' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'LBRACKET' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'OP10_NAMED_UNARY' => -68,
			"%{" => -68,
			'LPAREN_MY' => 420,
			'OP03_MATH_INC_DEC' => -68,
			"\@{" => -68,
			'WORD_SCOPED' => -68,
			'OP05_LOGICAL_NEG' => -68,
			"if" => -68,
			'LITERAL_STRING' => -68,
			"for" => -68,
			'LBRACE' => -68,
			"while" => -68
		},
		GOTOS => {
			'MethodArguments' => 421,
			'OPTIONAL-27' => 419
		}
	},
	{#State 404
		ACTIONS => {
			";" => 422
		}
	},
	{#State 405
		ACTIONS => {
			'WORD' => 367
		},
		GOTOS => {
			'HashEntryProperties' => 423
		}
	},
	{#State 406
		DEFAULT => -63
	},
	{#State 407
		DEFAULT => -204
	},
	{#State 408
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'TYPE_INTEGER' => 58,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 424
		}
	},
	{#State 409
		DEFAULT => -52
	},
	{#State 410
		ACTIONS => {
			'VARIABLE_SYMBOL' => 425
		}
	},
	{#State 411
		ACTIONS => {
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'WordScoped' => 124,
			'Expression' => 146,
			'HashDereference' => 91,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpression' => 426,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 412
		DEFAULT => -157
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 427
		}
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 415
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			"undef" => 112,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP10_NAMED_UNARY' => 86,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116
		},
		GOTOS => {
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 429,
			'ArrayReference' => 103,
			'Variable' => 145,
			'Operator' => 82,
			'Literal' => 106,
			'HashReference' => 127,
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124
		}
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 430
		}
	},
	{#State 417
		ACTIONS => {
			'OP16_LOGICAL_OR' => 208,
			")" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			";" => -83,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP21_LIST_COMMA' => -83,
			'OP04_MATH_POW' => 206,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			"]" => -83,
			"}" => -83,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP08_STRING_CAT' => 202
		}
	},
	{#State 418
		ACTIONS => {
			";" => 431
		}
	},
	{#State 419
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 432
		}
	},
	{#State 420
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'TYPE_INTEGER' => 58,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 433
		}
	},
	{#State 421
		DEFAULT => -67
	},
	{#State 422
		DEFAULT => -65
	},
	{#State 423
		DEFAULT => -62
	},
	{#State 424
		ACTIONS => {
			"\$TYPED_" => 434
		}
	},
	{#State 425
		DEFAULT => -49
	},
	{#State 426
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			")" => 435,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP08_STRING_CAT' => 202,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214
		}
	},
	{#State 427
		DEFAULT => -166
	},
	{#State 428
		DEFAULT => -168
	},
	{#State 429
		ACTIONS => {
			'OP08_STRING_CAT' => 202,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 214,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP23_LOGICAL_AND' => -104,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => -104,
			")" => 436,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => -104
		}
	},
	{#State 430
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 437
		}
	},
	{#State 431
		DEFAULT => -180
	},
	{#State 432
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 120,
			"foreach" => -148,
			"}" => 438,
			'SELF' => 125,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 129,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 110,
			'MY' => 113,
			"undef" => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 115,
			'LITERAL_NUMBER' => 116,
			'WORD' => 27,
			'OP01_NAMED_VOID' => 117,
			'VARIABLE_SYMBOL' => 118,
			"if" => 97,
			"while" => -148,
			"for" => -148,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'OP05_LOGICAL_NEG' => 102,
			'OP03_MATH_INC_DEC' => 104,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP05_MATH_NEG_LPAREN' => 84,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP01_NAMED_VOID_SCOLON' => 89,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			'LPAREN' => 92,
			'OP19_LOOP_CONTROL' => 94,
			'OP01_PRINT' => 95
		},
		GOTOS => {
			'Operation' => 439,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101,
			'ArrayReference' => 103,
			'WordScoped' => 124,
			'Conditional' => 126,
			'Literal' => 106,
			'HashReference' => 127,
			'OPTIONAL-37' => 108,
			'Variable' => 81,
			'OperatorVoid' => 80,
			'Operator' => 82,
			'LoopLabel' => 83,
			'VariableModification' => 111,
			'PAREN-36' => 87,
			'SubExpression' => 114,
			'HashDereference' => 91,
			'Expression' => 93,
			'Statement' => 96,
			'VariableDeclaration' => 119
		}
	},
	{#State 433
		ACTIONS => {
			'SELF' => 440
		}
	},
	{#State 434
		ACTIONS => {
			'WORD' => 441
		}
	},
	{#State 435
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118,
			'WORD' => 27,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 26,
			'SELF' => 125,
			"\@{" => 105,
			'OP03_MATH_INC_DEC' => 104,
			'OP05_LOGICAL_NEG' => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'CONSTANT_CALL_SCOPED' => 120
		},
		GOTOS => {
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'SubExpression' => 444,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123
		}
	},
	{#State 438
		ACTIONS => {
			";" => 445
		}
	},
	{#State 439
		DEFAULT => -69
	},
	{#State 440
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 446
		}
	},
	{#State 441
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 447,
			'OP02_ARRAY_THINARROW' => 448
		}
	},
	{#State 442
		DEFAULT => -154
	},
	{#State 443
		DEFAULT => -164
	},
	{#State 444
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 207,
			'OP04_MATH_POW' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			";" => 449,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP08_STRING_CAT' => 202,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204
		}
	},
	{#State 445
		DEFAULT => -71
	},
	{#State 446
		ACTIONS => {
			")" => 450,
			'OP21_LIST_COMMA' => 451
		},
		GOTOS => {
			'PAREN-29' => 452
		}
	},
	{#State 447
		ACTIONS => {
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'HashReference' => 127,
			'Literal' => 106,
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'ArrayReference' => 103,
			'VariableSymbolOrSelf' => 101,
			'SubExpression' => 453,
			'ArrayDereference' => 123,
			'Operator' => 82,
			'Variable' => 145
		}
	},
	{#State 448
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 90,
			'LBRACKET' => 88,
			"undef" => 112,
			'OP01_OPEN' => 109,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP10_NAMED_UNARY' => 86,
			"%{" => 85,
			'WORD_UPPERCASE' => 143,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LITERAL_NUMBER' => 116,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LITERAL_STRING' => 100,
			'LBRACE' => 98,
			'OP01_CLOSE' => 128,
			'OP01_NAMED' => 144,
			'OP03_MATH_INC_DEC' => 104,
			"\@{" => 105,
			'SELF' => 125,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Expression' => 146,
			'HashDereference' => 91,
			'WordScoped' => 124,
			'HashReference' => 127,
			'Literal' => 106,
			'Operator' => 82,
			'Variable' => 145,
			'ArrayReference' => 103,
			'SubExpression' => 454,
			'ArrayDereference' => 123,
			'VariableSymbolOrSelf' => 101
		}
	},
	{#State 449
		ACTIONS => {
			'OP01_NAMED' => 144,
			'OP01_CLOSE' => 128,
			'OP03_MATH_INC_DEC' => 104,
			'SELF' => 125,
			'WORD_SCOPED' => 26,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 102,
			'CONSTANT_CALL_SCOPED' => 120,
			'LBRACE' => 98,
			'LITERAL_STRING' => 100,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 118,
			'LPAREN' => 92,
			'LITERAL_NUMBER' => 116,
			"undef" => 112,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 90,
			'OP05_MATH_NEG_LPAREN' => 84,
			'OP01_OPEN' => 109,
			'WORD_UPPERCASE' => 143,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 86
		},
		GOTOS => {
			'HashDereference' => 91,
			'Expression' => 146,
			'WordScoped' => 124,
			'Literal' => 106,
			'HashReference' => 127,
			'VariableModification' => 455,
			'Variable' => 81,
			'Operator' => 82,
			'VariableSymbolOrSelf' => 101,
			'ArrayDereference' => 123,
			'SubExpressionOrVarMod' => 457,
			'SubExpression' => 456,
			'ArrayReference' => 103
		}
	},
	{#State 450
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 458
		}
	},
	{#State 451
		ACTIONS => {
			'MY' => 459
		}
	},
	{#State 452
		DEFAULT => -73
	},
	{#State 453
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP06_REGEX_MATCH' => 212,
			"}" => -221,
			'OP13_BITWISE_AND' => 211,
			'OP08_STRING_CAT' => 202,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP15_LOGICAL_AND' => 203,
			'OP07_STRING_REPEAT' => 214,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP21_LIST_COMMA' => -221,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP18_TERNARY' => 210,
			'OP08_MATH_ADD_SUB' => 209,
			'OP23_LOGICAL_AND' => 216
		}
	},
	{#State 454
		ACTIONS => {
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP23_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 208,
			'OP08_STRING_CAT' => 202,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP17_LIST_RANGE' => 200,
			"]" => 460,
			'OP13_BITWISE_AND' => 211,
			'OP06_REGEX_MATCH' => 212,
			'OP07_STRING_REPEAT' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204
		}
	},
	{#State 455
		DEFAULT => -145
	},
	{#State 456
		ACTIONS => {
			'OP15_LOGICAL_AND' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 214,
			'OP06_REGEX_MATCH' => 212,
			'OP13_BITWISE_AND' => 211,
			'OP17_LIST_RANGE' => 200,
			'OP12_COMPARE_EQ_NE' => 201,
			'OP08_STRING_CAT' => 202,
			'OP16_LOGICAL_OR' => 208,
			")" => -144,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 216,
			'OP08_MATH_ADD_SUB' => 209,
			'OP18_TERNARY' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 207
		}
	},
	{#State 457
		ACTIONS => {
			")" => 461
		}
	},
	{#State 458
		ACTIONS => {
			"\@_;" => 462
		}
	},
	{#State 459
		ACTIONS => {
			'WORD_SCOPED' => 61,
			'WORD' => 60,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 463
		}
	},
	{#State 460
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 464
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 462
		DEFAULT => -75
	},
	{#State 463
		ACTIONS => {
			'VARIABLE_SYMBOL' => 466
		}
	},
	{#State 464
		ACTIONS => {
			"undef" => 467
		}
	},
	{#State 465
		DEFAULT => -165
	},
	{#State 466
		DEFAULT => -72
	},
	{#State 467
		DEFAULT => -222
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6830 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7051 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7168 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7186 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7471 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7704 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7718 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7725 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7743 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7754 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7765 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7776 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7787 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_141
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_142
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7995 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8017 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8028 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8035 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8042 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8049 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8056 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8063 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8092 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8103 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8114 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 10,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8125 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 14,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_166
		 'LoopForEach', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8147 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8158 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8169 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8183 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8208 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8219 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8230 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8241 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8252 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8263 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8274 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8296 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8307 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8318 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8339 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8350 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8361 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8372 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8383 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8394 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8408 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_194
		 'ArrayReference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8419 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_197
		 'ArrayDereference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8444 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8455 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8462 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8469 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8480 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8491 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8502 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_204
		 'HashEntryProperties', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8513 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8520 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8527 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8545 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8570 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_212
		 'HashDereference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8581 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8592 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8603 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8614 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_216
		 'LoopLabel', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8625 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8647 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8658 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_220
		 'TypeInner', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8669 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_221
		 'TypeInnerProperties', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8680 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_222
		 'TypeInnerProperties', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_223
		 'TypeInnerConstant', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8702 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8713 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_225
		 'VariableOrLiteral', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8724 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8735 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8746 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8757 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8768 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_230
		 'VariableSymbolOrSelf', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8779 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8790 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_232
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8801 lib/RPerl/Grammar.pm
	]
],
#line 8804 lib/RPerl/Grammar.pm
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
         'Operator_80', 
         'Operator_81', 
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_126', 
         'Expression_127', 
         'Expression_128', 
         'Expression_129', 
         'Expression_130', 
         'Expression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpressionOrInput_141', 
         'SubExpressionOrInput_142', 
         'SubExpressionOrInput_143', 
         'SubExpressionOrVarMod_144', 
         'SubExpressionOrVarMod_145', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_160', 
         'Loop_161', 
         'Loop_162', 
         'Loop_163', 
         'LoopFor_164', 
         'LoopFor_165', 
         'LoopForEach_166', 
         'LoopWhile_167', 
         'LoopWhile_168', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_171', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_174', 
         'VariableRetrieval_175', 
         'VariableRetrieval_176', 
         'VariableRetrieval_177', 
         'VariableDeclaration_178', 
         'VariableDeclaration_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableModification_182', 
         'VariableModification_183', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_187', 
         'ListElement_188', 
         'ListElement_189', 
         'ListElement_190', 
         'ListElement_191', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_194', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_197', 
         'ArrayDereference_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_201', 
         'HashEntry_202', 
         'HashEntry_203', 
         'HashEntryProperties_204', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_208', 
         'HashReference_209', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_212', 
         'HashDereference_213', 
         'WordScoped_214', 
         'WordScoped_215', 
         'LoopLabel_216', 
         'Type_217', 
         'Type_218', 
         'Type_219', 
         'TypeInner_220', 
         'TypeInnerProperties_221', 
         'TypeInnerProperties_222', 
         'TypeInnerConstant_223', 
         'VariableOrLiteral_224', 
         'VariableOrLiteral_225', 
         'VariableOrLiteralOrWord_226', 
         'VariableOrLiteralOrWord_227', 
         'VariableOrLiteralOrWord_228', 
         'VariableSymbolOrSelf_229', 
         'VariableSymbolOrSelf_230', 
         'Literal_231', 
         'Literal_232', );
  $self;
}

#line 227 "lib/RPerl/Grammar.eyp"


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
Properties_65 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_75 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_76 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_77 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_78 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_79 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_80 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_81 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_82 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_83 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_84 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_85 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> OP03_MATH_INC_DEC Variable
Operator_86 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> Variable OP03_MATH_INC_DEC
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::Power',                   # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_88 => 'RPerl::Operation::Expression::Operator::Logical::Negation',             # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_89 => 'RPerl::Operation::Expression::Operator::Math::Negative',                # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_90 => 'RPerl::Operation::Expression::Operator::RegularExpression',             # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_91 => 'RPerl::Operation::Expression::Operator::String::Repeat',                # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_92 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',    # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_93 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',             # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_94 => 'RPerl::Operation::Expression::Operator::String::Concatenate',           # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY
Operator_98 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan', # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',       # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_100 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                 # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',               # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::List::Range',                  # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Ternary',                      # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::Negation',            # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_114 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_117 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_119 => 'RPerl::Operation::Expression::Operator::Named',                    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_121 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_126 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_127 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_128 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_129 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_130 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_131 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_132 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_133 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_135 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_136 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_138 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_140 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_141 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_142 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_143 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_144 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_145 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_149 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_150 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_151 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_152 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_153 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_160 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_161 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_162 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_163 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_164 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_165 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
LoopForEach_166 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_167 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_168 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_171 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_174 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_175 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_176 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_177 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_178 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_179 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ';'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_182 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_183 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_187 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_188 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_189 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_190 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_191 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_194 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_197 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_198 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_201 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_202 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_203 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_204 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
HashReference_208 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_209 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_212 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_213 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_214 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_215 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_216 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_217 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_218 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_219 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_220 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerProperties_221 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_222 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_223 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_224 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_225 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_226 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_227 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_228 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_229 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_230 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_231 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_232 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 9216 lib/RPerl/Grammar.pm



1;
