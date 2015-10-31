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
    our $VERSION = 0.002_100;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|package|foreach|\$TYPED_|while|elsif|undef|else|\@_\;|our|for|\@\{|\%\{|if|\]|\;|\)|\})}gc and return ($1, $1);

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
                                     rand|readlink|ref|require|rmdir|scalar\s|sin|sleep|sqrt|srand|stat|uc|ucfirst|umask)/gc and return ('OP10_NAMED_UNARY', $1);
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
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 7,
			'SHEBANG' => 6
		},
		GOTOS => {
			'OPTIONAL-9' => 5,
			'PAREN-1' => 9,
			'ModuleHeader' => 8,
			'Program' => 4,
			'PLUS-2' => 3,
			'Critic' => 1,
			'CompileUnit' => 2
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			'' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 7,
			'USE_RPERL' => -20,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'Critic' => 1,
			'ModuleHeader' => 8,
			'OPTIONAL-9' => 5,
			'PAREN-1' => 11
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 13
		},
		GOTOS => {
			'OPTIONAL-10' => 12
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 7,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 15,
			'Critic' => 14
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 17
		},
		GOTOS => {
			'PLUS-16' => 16
		}
	},
	{#State 8
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => -27,
			"use constant" => -27,
			"use parent qw(" => 20,
			'USE' => -27
		},
		GOTOS => {
			'Package' => 19,
			'Module' => 18,
			'Class' => 22,
			'STAR-11' => 21
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -2
	},
	{#State 12
		ACTIONS => {
			"package" => 23
		}
	},
	{#State 13
		DEFAULT => -21
	},
	{#State 14
		DEFAULT => -6
	},
	{#State 15
		ACTIONS => {
			'USE_RPERL' => 24
		}
	},
	{#State 16
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 17
		DEFAULT => -39
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 21
		ACTIONS => {
			"our" => -29,
			"## no critic qw(" => 7,
			'USE' => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Critic' => 31,
			'STAR-12' => 30
		}
	},
	{#State 22
		DEFAULT => -25
	},
	{#State 23
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 28
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
		DEFAULT => -38
	},
	{#State 26
		DEFAULT => -40
	},
	{#State 27
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		DEFAULT => -215
	},
	{#State 29
		DEFAULT => -214
	},
	{#State 30
		ACTIONS => {
			'USE' => 38,
			"use constant" => -31,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 37,
			'Include' => 36
		}
	},
	{#State 31
		DEFAULT => -26
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
			"our" => 44,
			"use constant" => 45
		},
		GOTOS => {
			'Constant' => 46,
			'PLUS-14' => 47,
			'Subroutine' => 43
		}
	},
	{#State 38
		ACTIONS => {
			'WORD_SCOPED' => 28,
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
			'USE_RPERL_AFTER' => 50,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 51
		}
	},
	{#State 41
		ACTIONS => {
			"while" => -11,
			'LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			"\@{" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP10_NAMED_UNARY' => -11,
			'MY' => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'SELF' => -11,
			'USE' => -11,
			"## no critic qw(" => 7,
			"undef" => -11,
			"for" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID' => -11,
			"our" => -11,
			'LITERAL_STRING' => -11,
			'WORD' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED' => -11,
			"if" => -11,
			"%{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_OPEN' => -11,
			'LBRACKET' => -11,
			'LBRACE' => -11,
			"use constant" => -11,
			"foreach" => -11
		},
		GOTOS => {
			'Critic' => 53,
			'STAR-5' => 52
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
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 59
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			'LITERAL_NUMBER' => 60,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 63,
			";" => 62
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
			"our" => 64
		}
	},
	{#State 52
		ACTIONS => {
			"foreach" => -13,
			'OP01_CLOSE' => -13,
			'OP01_OPEN' => -13,
			'LBRACKET' => -13,
			"use constant" => -13,
			'LBRACE' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'WORD' => -13,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"if" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			"our" => -13,
			"undef" => -13,
			"for" => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_SCOPED' => -13,
			'MY' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'SELF' => -13,
			'USE' => 38,
			'LPAREN' => -13,
			"while" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"\@{" => -13
		},
		GOTOS => {
			'Include' => 66,
			'STAR-6' => 65
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
		DEFAULT => -218
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 57
		DEFAULT => -217
	},
	{#State 58
		DEFAULT => -219
	},
	{#State 59
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
	},
	{#State 60
		ACTIONS => {
			";" => 70
		}
	},
	{#State 61
		DEFAULT => -32
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
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_PRINT' => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"if" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD' => -15,
			'LITERAL_STRING' => -15,
			"foreach" => -15,
			"use constant" => 45,
			'LBRACE' => -15,
			'LBRACKET' => -15,
			'OP01_CLOSE' => -15,
			'OP01_OPEN' => -15,
			'SELF' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			'MY' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"\@{" => -15,
			'VARIABLE_SYMBOL' => -15,
			"while" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			"our" => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_NUMBER' => -15,
			"for" => -15,
			"undef" => -15
		},
		GOTOS => {
			'STAR-7' => 74,
			'Constant' => 73
		}
	},
	{#State 66
		DEFAULT => -10
	},
	{#State 67
		ACTIONS => {
			"use constant" => -56,
			'USE' => -56,
			"our hashref \$properties" => -56,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 76,
			'STAR-22' => 75
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 69
		ACTIONS => {
			'MY' => 79
		},
		GOTOS => {
			'TypeInnerConstant' => 78
		}
	},
	{#State 70
		DEFAULT => -34
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
			'OP01_NAMED_VOID_LPAREN' => 111,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_PRINT' => 117,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			"if" => 101,
			'OP01_NAMED' => 104,
			'WORD_UPPERCASE' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			"foreach" => -148,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'SELF' => 88,
			'OP19_LOOP_CONTROL' => 89,
			'MY' => 90,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			"while" => -148,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"our" => 44,
			'OP01_NAMED_VOID' => 91,
			'LITERAL_NUMBER' => 92,
			"for" => -148,
			"undef" => 95
		},
		GOTOS => {
			'OperatorVoid' => 107,
			'Expression' => 108,
			'LoopLabel' => 85,
			'Statement' => 102,
			'VariableDeclaration' => 105,
			'Operator' => 116,
			'Conditional' => 115,
			'OPTIONAL-37' => 113,
			'ArrayReference' => 118,
			'Subroutine' => 110,
			'PLUS-8' => 94,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'VariableModification' => 121,
			'SubExpression' => 127,
			'HashReference' => 128,
			'Operation' => 129,
			'HashDereference' => 97,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 100,
			'PAREN-36' => 98
		}
	},
	{#State 75
		ACTIONS => {
			'USE' => 38,
			"our hashref \$properties" => -58,
			"use constant" => -58
		},
		GOTOS => {
			'STAR-23' => 130,
			'Include' => 131
		}
	},
	{#State 76
		DEFAULT => -53
	},
	{#State 77
		ACTIONS => {
			'LBRACKET' => -45,
			'OP01_CLOSE' => -45,
			'OP01_OPEN' => -45,
			'LBRACE' => -45,
			"foreach" => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'LITERAL_STRING' => -45,
			'WORD' => -45,
			'OP01_NAMED' => -45,
			'WORD_UPPERCASE' => -45,
			"if" => -45,
			'OP01_PRINT' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			"%{" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			"undef" => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_NAMED_VOID' => -45,
			"for" => -45,
			'LPAREN_MY' => 132,
			'VARIABLE_SYMBOL' => -45,
			"while" => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LPAREN' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"\@{" => -45,
			"}" => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'WORD_SCOPED' => -45,
			'MY' => -45,
			'SELF' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 133,
			'OPTIONAL-17' => 134
		}
	},
	{#State 78
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 135
		}
	},
	{#State 79
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 136
		}
	},
	{#State 80
		ACTIONS => {
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP11_COMPARE_LT_GT' => -97,
			'WORD' => 29,
			")" => -97,
			'LITERAL_STRING' => 109,
			'OP18_TERNARY' => -97,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP09_BITWISE_SHIFT' => -97,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'LBRACE' => 122,
			'OP13_BITWISE_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'LBRACKET' => 123,
			'OP23_LOGICAL_AND' => -97,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"}" => -97,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			"]" => -97,
			'SELF' => 88,
			'OP04_MATH_POW' => -97,
			'WORD_SCOPED' => 28,
			'OP24_LOGICAL_OR_XOR' => -97,
			'LITERAL_NUMBER' => 92,
			'OP08_STRING_CAT' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			"undef" => 95,
			";" => -97,
			'OP06_REGEX_MATCH' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_STRING_REPEAT' => -97
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashReference' => 128,
			'SubExpression' => 141,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 81
		ACTIONS => {
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'Variable' => 142,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 82
		ACTIONS => {
			'SELF' => 88,
			'MY' => 143,
			'LBRACKET' => -196,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'TypeInner' => 146,
			'OPTIONAL-47' => 144,
			'Variable' => 145,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 83
		DEFAULT => -229
	},
	{#State 84
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP01_NAMED' => 149,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_PRINT' => 148,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 147,
			'HashReference' => 128,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 85
		ACTIONS => {
			'COLON' => 150
		}
	},
	{#State 86
		ACTIONS => {
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'Operator' => 116,
			'SubExpression' => 151,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 87
		ACTIONS => {
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80
		},
		GOTOS => {
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 152,
			'Operator' => 116,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93
		}
	},
	{#State 88
		DEFAULT => -230
	},
	{#State 89
		ACTIONS => {
			'WORD_UPPERCASE' => 153
		},
		GOTOS => {
			'LoopLabel' => 154
		}
	},
	{#State 90
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'TYPE_FHREF' => 155,
			'WORD' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 156
		}
	},
	{#State 91
		ACTIONS => {
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'WORD' => 29,
			'ARGV' => 158,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 119,
			'MY' => 143,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_QW' => 161
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 162,
			'HashReference' => 128,
			'ListElement' => 160,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'Expression' => 140,
			'Literal' => 96,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'ListElements' => 157
		}
	},
	{#State 92
		DEFAULT => -231
	},
	{#State 93
		DEFAULT => -137
	},
	{#State 94
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			"if" => 101,
			'WORD_UPPERCASE' => 103,
			'OP01_NAMED' => 104,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_PRINT' => 117,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			'' => -18,
			'LBRACE' => 122,
			"foreach" => -148,
			"while" => -148,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'WORD_SCOPED' => 28,
			'MY' => 90,
			'OP19_LOOP_CONTROL' => 89,
			'SELF' => 88,
			"undef" => 95,
			"for" => -148,
			'OP01_NAMED_VOID' => 91,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'PAREN-36' => 98,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 100,
			'HashDereference' => 97,
			'Operation' => 163,
			'HashReference' => 128,
			'SubExpression' => 127,
			'ArrayDereference' => 93,
			'VariableModification' => 121,
			'Literal' => 96,
			'ArrayReference' => 118,
			'Conditional' => 115,
			'Operator' => 116,
			'OPTIONAL-37' => 113,
			'VariableDeclaration' => 105,
			'Statement' => 102,
			'Expression' => 108,
			'LoopLabel' => 85,
			'OperatorVoid' => 107
		}
	},
	{#State 95
		DEFAULT => -133
	},
	{#State 96
		DEFAULT => -134
	},
	{#State 97
		DEFAULT => -139
	},
	{#State 98
		DEFAULT => -147
	},
	{#State 99
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 164
		}
	},
	{#State 100
		ACTIONS => {
			'OP18_TERNARY' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 168,
			'OP03_MATH_INC_DEC' => 165,
			'OP19_VARIABLE_ASSIGN_BY' => 166,
			'OP11_COMPARE_LT_GT' => -135,
			")" => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP08_STRING_CAT' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP19_VARIABLE_ASSIGN' => 167
		}
	},
	{#State 101
		ACTIONS => {
			'LPAREN' => 169
		}
	},
	{#State 102
		DEFAULT => -79
	},
	{#State 103
		ACTIONS => {
			'COLON' => -216,
			'LPAREN' => 170
		}
	},
	{#State 104
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 83,
			'ARGV' => 158,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'MY' => 143,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'OP01_QW' => 161
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 171,
			'HashReference' => 128,
			'ListElement' => 172,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'Expression' => 140,
			'Literal' => 96,
			'TypeInner' => 159,
			'ArrayDereference' => 93
		}
	},
	{#State 105
		DEFAULT => -152
	},
	{#State 106
		DEFAULT => -120
	},
	{#State 107
		DEFAULT => -151
	},
	{#State 108
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP08_STRING_CAT' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP07_STRING_REPEAT' => -132,
			";" => 173,
			'OP06_REGEX_MATCH' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP04_MATH_POW' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP18_TERNARY' => -132
		}
	},
	{#State 109
		DEFAULT => -232
	},
	{#State 110
		DEFAULT => -14
	},
	{#State 111
		ACTIONS => {
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'ARGV' => 158,
			")" => -113,
			'WORD' => 29,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'MY' => 143,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'OP01_QW' => 161
		},
		GOTOS => {
			'ListElement' => 160,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'OPTIONAL-33' => 175,
			'SubExpression' => 162,
			'HashReference' => 128,
			'ArrayDereference' => 93,
			'ListElements' => 174,
			'Literal' => 96,
			'Expression' => 140,
			'TypeInner' => 159
		}
	},
	{#State 112
		DEFAULT => -128
	},
	{#State 113
		ACTIONS => {
			"while" => 180,
			"for" => 181,
			"foreach" => 177
		},
		GOTOS => {
			'Loop' => 176,
			'LoopWhile' => 182,
			'LoopForEach' => 179,
			'LoopFor' => 178
		}
	},
	{#State 114
		DEFAULT => -116
	},
	{#State 115
		DEFAULT => -149
	},
	{#State 116
		DEFAULT => -126
	},
	{#State 117
		ACTIONS => {
			'OP01_QW' => -111,
			'LITERAL_NUMBER' => -111,
			'LBRACE' => -111,
			'LBRACKET' => -111,
			"undef" => -111,
			'OP01_OPEN' => -111,
			'OP01_CLOSE' => -111,
			'SELF' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			"%{" => -111,
			'MY' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'WORD_SCOPED' => -111,
			'OP10_NAMED_UNARY' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'WORD_UPPERCASE' => -111,
			'OP01_NAMED' => -111,
			"\@{" => -111,
			'FHREF_SYMBOL_BRACES' => 184,
			'STDOUT_STDERR' => 185,
			'VARIABLE_SYMBOL' => -111,
			'ARGV' => -111,
			'WORD' => -111,
			'LITERAL_STRING' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			'LPAREN' => -111,
			'OP22_LOGICAL_NEG' => -111
		},
		GOTOS => {
			'PAREN-31' => 183,
			'OPTIONAL-32' => 186
		}
	},
	{#State 118
		DEFAULT => -136
	},
	{#State 119
		ACTIONS => {
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123,
			'SELF' => 88,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'SubExpression' => 187,
			'HashReference' => 128,
			'Operator' => 116
		}
	},
	{#State 120
		ACTIONS => {
			'MY' => 143,
			'VARIABLE_SYMBOL' => 83,
			'LBRACE' => -211,
			'SELF' => 88
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 99,
			'Variable' => 190,
			'TypeInner' => 188,
			'OPTIONAL-51' => 189
		}
	},
	{#State 121
		ACTIONS => {
			";" => 191
		}
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 83,
			'ENV' => 197,
			'LITERAL_STRING' => 109,
			'WORD' => 192,
			'LITERAL_NUMBER' => 92,
			"}" => 194,
			"%{" => 120,
			'SELF' => 88
		},
		GOTOS => {
			'Literal' => 196,
			'HashEntry' => 193,
			'HashDereference' => 199,
			'VariableOrLiteralOrWord' => 195,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 198
		}
	},
	{#State 123
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'WORD' => 29,
			'ARGV' => 158,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			"]" => -193,
			'OP05_LOGICAL_NEG' => 119,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_QW' => 161
		},
		GOTOS => {
			'SubExpression' => 162,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'OPTIONAL-46' => 200,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'ListElement' => 160,
			'TypeInner' => 159,
			'Literal' => 96,
			'Expression' => 140,
			'ListElements' => 201,
			'ArrayDereference' => 93
		}
	},
	{#State 124
		ACTIONS => {
			'FHREF_SYMBOL' => 202
		}
	},
	{#State 125
		ACTIONS => {
			'MY' => 203
		}
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 204,
			'OP02_METHOD_THINARROW_NEW' => 205
		}
	},
	{#State 127
		ACTIONS => {
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => 221,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP23_LOGICAL_AND' => 217,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219
		}
	},
	{#State 128
		DEFAULT => -138
	},
	{#State 129
		DEFAULT => -17
	},
	{#State 130
		ACTIONS => {
			"our hashref \$properties" => 223,
			"use constant" => 45
		},
		GOTOS => {
			'Properties' => 225,
			'Constant' => 224
		}
	},
	{#State 131
		DEFAULT => -55
	},
	{#State 132
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 226
		}
	},
	{#State 133
		DEFAULT => -44
	},
	{#State 134
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 227
		}
	},
	{#State 135
		ACTIONS => {
			";" => 228
		}
	},
	{#State 136
		ACTIONS => {
			"\$TYPED_" => 229
		}
	},
	{#State 137
		ACTIONS => {
			'OP08_STRING_CAT' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP16_LOGICAL_OR' => -135,
			";" => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP03_MATH_INC_DEC' => 165,
			"}" => -135,
			")" => -135,
			'OP18_TERNARY' => -135,
			"]" => -135,
			'OP02_METHOD_THINARROW' => 168,
			'OP04_MATH_POW' => -135,
			'OP09_BITWISE_SHIFT' => -135
		}
	},
	{#State 138
		ACTIONS => {
			'LPAREN' => 170
		}
	},
	{#State 139
		ACTIONS => {
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'SELF' => 88
		},
		GOTOS => {
			'SubExpression' => 230,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93
		}
	},
	{#State 140
		DEFAULT => -132
	},
	{#State 141
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			"]" => -96,
			'OP18_TERNARY' => -96,
			")" => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => -96
		}
	},
	{#State 142
		DEFAULT => -85
	},
	{#State 143
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 231
		}
	},
	{#State 144
		ACTIONS => {
			'LBRACKET' => 123
		},
		GOTOS => {
			'ArrayReference' => 232
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 146
		DEFAULT => -195
	},
	{#State 147
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => 214,
			")" => 234,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP16_LOGICAL_OR' => 221,
			'OP23_LOGICAL_AND' => 217,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 148
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 235
		}
	},
	{#State 149
		ACTIONS => {
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'ARGV' => 158,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'MY' => 143,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_QW' => 161
		},
		GOTOS => {
			'Operator' => 116,
			'SubExpression' => 171,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'ListElement' => 236,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Expression' => 140,
			'Literal' => 96,
			'TypeInner' => 159,
			'ArrayDereference' => 93
		}
	},
	{#State 150
		DEFAULT => -146
	},
	{#State 151
		ACTIONS => {
			'OP18_TERNARY' => 214,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => 213,
			")" => 237,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217
		}
	},
	{#State 152
		ACTIONS => {
			")" => -106,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			"]" => -106,
			'OP18_TERNARY' => 214,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			";" => -106,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP21_LIST_COMMA' => -106,
			'OP06_REGEX_MATCH' => 210
		}
	},
	{#State 153
		DEFAULT => -216
	},
	{#State 154
		ACTIONS => {
			";" => 238
		}
	},
	{#State 155
		ACTIONS => {
			'FHREF_SYMBOL' => 239
		}
	},
	{#State 156
		ACTIONS => {
			'VARIABLE_SYMBOL' => 240
		}
	},
	{#State 157
		ACTIONS => {
			";" => 241
		}
	},
	{#State 158
		DEFAULT => -191
	},
	{#State 159
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93,
			'Operator' => 116,
			'SubExpression' => 242,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126
		}
	},
	{#State 160
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 243
		}
	},
	{#State 161
		DEFAULT => -190
	},
	{#State 162
		ACTIONS => {
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			";" => -188,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP21_LIST_COMMA' => -188,
			'OP06_REGEX_MATCH' => 210,
			")" => -188,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"]" => -188,
			'OP18_TERNARY' => 214
		}
	},
	{#State 163
		DEFAULT => -16
	},
	{#State 164
		ACTIONS => {
			'OP18_TERNARY' => -174,
			"]" => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP02_HASH_THINARROW' => 244,
			'OP02_ARRAY_THINARROW' => 246,
			'OP09_BITWISE_SHIFT' => -174,
			'OP04_MATH_POW' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			"}" => -174,
			")" => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP16_LOGICAL_OR' => -174,
			";" => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP08_STRING_CAT' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'COLON' => -174,
			'OP23_LOGICAL_AND' => -174,
			'OP13_BITWISE_AND' => -174,
			'OP17_LIST_RANGE' => -174
		},
		GOTOS => {
			'VariableRetrieval' => 245
		}
	},
	{#State 165
		DEFAULT => -86
	},
	{#State 166
		ACTIONS => {
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			'OP01_NAMED' => 139,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'WORD' => 29,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93,
			'HashReference' => 128,
			'SubExpression' => 247,
			'Operator' => 116,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 167
		ACTIONS => {
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 80,
			'FHREF_SYMBOL_IN' => 251,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'STDIN' => 248,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'SELF' => 88
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'WordScoped' => 126,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 249,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'SubExpressionOrInput' => 250
		}
	},
	{#State 168
		ACTIONS => {
			'LPAREN' => 252
		}
	},
	{#State 169
		ACTIONS => {
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 81,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80
		},
		GOTOS => {
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 253,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 137
		}
	},
	{#State 170
		ACTIONS => {
			")" => 254
		}
	},
	{#State 171
		ACTIONS => {
			")" => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP04_MATH_POW' => -81,
			'OP18_TERNARY' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP08_STRING_CAT' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP21_LIST_COMMA' => -188,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP16_LOGICAL_OR' => -81,
			";" => -81
		}
	},
	{#State 172
		ACTIONS => {
			'OP21_LIST_COMMA' => 255
		}
	},
	{#State 173
		DEFAULT => -78
	},
	{#State 174
		DEFAULT => -112
	},
	{#State 175
		ACTIONS => {
			")" => 256
		}
	},
	{#State 176
		DEFAULT => -150
	},
	{#State 177
		ACTIONS => {
			'MY' => 257
		}
	},
	{#State 178
		DEFAULT => -161
	},
	{#State 179
		DEFAULT => -162
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 258,
			'LPAREN_MY' => 259
		}
	},
	{#State 181
		ACTIONS => {
			'LPAREN_MY' => 261,
			'MY' => 260
		}
	},
	{#State 182
		DEFAULT => -163
	},
	{#State 183
		DEFAULT => -110
	},
	{#State 184
		ACTIONS => {
			'SELF' => 88,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP10_NAMED_UNARY' => 80,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'ARGV' => 158,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'OP01_QW' => 161,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95
		},
		GOTOS => {
			'HashDereference' => 97,
			'ListElement' => 160,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'WordScoped' => 126,
			'Operator' => 116,
			'SubExpression' => 162,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'ListElements' => 262,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'TypeInner' => 159
		}
	},
	{#State 185
		DEFAULT => -109
	},
	{#State 186
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_QW' => 161,
			'WORD' => 29,
			'ARGV' => 158,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88
		},
		GOTOS => {
			'Literal' => 96,
			'Expression' => 140,
			'TypeInner' => 159,
			'ArrayDereference' => 93,
			'ListElements' => 263,
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 162,
			'HashReference' => 128,
			'ListElement' => 160,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97
		}
	},
	{#State 187
		ACTIONS => {
			")" => -88,
			"}" => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -88,
			"]" => -88,
			'OP18_TERNARY' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP17_LIST_RANGE' => -88,
			'OP13_BITWISE_AND' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP08_STRING_CAT' => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP07_STRING_REPEAT' => -88,
			";" => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP16_LOGICAL_OR' => -88
		}
	},
	{#State 188
		DEFAULT => -210
	},
	{#State 189
		ACTIONS => {
			'LBRACE' => 122
		},
		GOTOS => {
			'HashReference' => 264
		}
	},
	{#State 190
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 191
		DEFAULT => -153
	},
	{#State 192
		DEFAULT => -228
	},
	{#State 193
		DEFAULT => -207,
		GOTOS => {
			'STAR-50' => 266
		}
	},
	{#State 194
		DEFAULT => -209
	},
	{#State 195
		ACTIONS => {
			'OP20_HASH_FATARROW' => 267
		}
	},
	{#State 196
		DEFAULT => -227
	},
	{#State 197
		DEFAULT => -203
	},
	{#State 198
		DEFAULT => -226
	},
	{#State 199
		DEFAULT => -202
	},
	{#State 200
		ACTIONS => {
			"]" => 268
		}
	},
	{#State 201
		DEFAULT => -192
	},
	{#State 202
		DEFAULT => -84
	},
	{#State 203
		ACTIONS => {
			'TYPE_FHREF' => 269
		}
	},
	{#State 204
		ACTIONS => {
			'SELF' => 88,
			"%{" => 120,
			'MY' => 143,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			")" => -123,
			'WORD' => 29,
			'ARGV' => 158,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'VARIABLE_SYMBOL' => 83,
			'OP01_QW' => 161,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'ListElement' => 160,
			'SubExpression' => 162,
			'OPTIONAL-34' => 271,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ListElements' => 270,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 205
		ACTIONS => {
			")" => 272
		}
	},
	{#State 206
		ACTIONS => {
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP10_NAMED_UNARY' => 80
		},
		GOTOS => {
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 273,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 207
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109
		},
		GOTOS => {
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93,
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 274,
			'Operator' => 116,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'WordScoped' => 126,
			'HashDereference' => 97
		}
	},
	{#State 208
		ACTIONS => {
			'SELF' => 88,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD' => 29,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95
		},
		GOTOS => {
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'Operator' => 116,
			'SubExpression' => 275,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 209
		ACTIONS => {
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 276
		}
	},
	{#State 210
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 277
		}
	},
	{#State 211
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123
		},
		GOTOS => {
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 278,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 212
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'HashDereference' => 97,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 137,
			'HashReference' => 128,
			'SubExpression' => 279,
			'Operator' => 116,
			'ArrayReference' => 118
		}
	},
	{#State 213
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'SubExpression' => 280,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 214
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 282,
			'VariableSymbolOrSelf' => 99,
			'VariableOrLiteral' => 281,
			'Variable' => 283
		}
	},
	{#State 215
		ACTIONS => {
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP01_NAMED' => 139,
			'OP10_NAMED_UNARY' => 80,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 284
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'SELF' => 88,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'Operator' => 116,
			'SubExpression' => 285,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 217
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 286,
			'ArrayReference' => 118
		}
	},
	{#State 218
		ACTIONS => {
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP10_NAMED_UNARY' => 80,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123
		},
		GOTOS => {
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'SubExpression' => 287,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126
		}
	},
	{#State 219
		ACTIONS => {
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'SubExpression' => 288,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 220
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Operator' => 116,
			'SubExpression' => 289,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93
		}
	},
	{#State 221
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 290,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 222
		ACTIONS => {
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 29,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'SELF' => 88,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 291,
			'HashReference' => 128
		}
	},
	{#State 223
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 292
		}
	},
	{#State 224
		DEFAULT => -57
	},
	{#State 225
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 293
		}
	},
	{#State 226
		ACTIONS => {
			'VARIABLE_SYMBOL' => 294
		}
	},
	{#State 227
		ACTIONS => {
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'OP01_PRINT' => 117,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED' => 104,
			'WORD_UPPERCASE' => 103,
			"if" => 101,
			"foreach" => -148,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'MY' => 90,
			'WORD_SCOPED' => 28,
			'OP19_LOOP_CONTROL' => 89,
			'SELF' => 88,
			"while" => -148,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'VARIABLE_SYMBOL' => 83,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			"}" => 296,
			'OP10_NAMED_UNARY' => 80,
			"undef" => 95,
			"for" => -148,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED_VOID' => 91
		},
		GOTOS => {
			'Operator' => 116,
			'Conditional' => 115,
			'OPTIONAL-37' => 113,
			'ArrayReference' => 118,
			'Statement' => 102,
			'VariableDeclaration' => 105,
			'OperatorVoid' => 107,
			'Expression' => 108,
			'LoopLabel' => 85,
			'HashDereference' => 97,
			'PAREN-36' => 98,
			'Variable' => 100,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashReference' => 128,
			'SubExpression' => 127,
			'Operation' => 295,
			'ArrayDereference' => 93,
			'VariableModification' => 121,
			'Literal' => 96
		}
	},
	{#State 228
		DEFAULT => -43
	},
	{#State 229
		ACTIONS => {
			'WORD_UPPERCASE' => 297
		}
	},
	{#State 230
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -81,
			'OP08_STRING_CAT' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP16_LOGICAL_OR' => -81,
			";" => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			"}" => -81,
			")" => -81,
			'OP18_TERNARY' => -81,
			"]" => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP04_MATH_POW' => -81
		}
	},
	{#State 231
		ACTIONS => {
			"\$TYPED_" => 298
		}
	},
	{#State 232
		ACTIONS => {
			"}" => 299
		}
	},
	{#State 233
		DEFAULT => -197
	},
	{#State 234
		DEFAULT => -140
	},
	{#State 235
		ACTIONS => {
			'OP01_QW' => 161,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'SELF' => 88,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 29,
			'ARGV' => 158,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 162,
			'Operator' => 116,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'ListElement' => 160,
			'HashDereference' => 97,
			'TypeInner' => 159,
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'ListElements' => 300
		}
	},
	{#State 236
		ACTIONS => {
			'OP21_LIST_COMMA' => 301
		}
	},
	{#State 237
		DEFAULT => -89
	},
	{#State 238
		DEFAULT => -121
	},
	{#State 239
		ACTIONS => {
			";" => 302
		}
	},
	{#State 240
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 303,
			'OP02_ARRAY_THINARROW' => 305,
			";" => 304
		}
	},
	{#State 241
		DEFAULT => -118
	},
	{#State 242
		ACTIONS => {
			'OP16_LOGICAL_OR' => 221,
			'OP21_LIST_COMMA' => -189,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			";" => -189,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => 217,
			'OP18_TERNARY' => 214,
			"]" => -189,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => 213,
			")" => -189
		}
	},
	{#State 243
		ACTIONS => {
			'OP21_LIST_COMMA' => 307,
			";" => -187,
			"]" => -187,
			")" => -187
		},
		GOTOS => {
			'PAREN-44' => 306
		}
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'WORD' => 308,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'SELF' => 88,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 309,
			'HashReference' => 128
		}
	},
	{#State 245
		DEFAULT => -172
	},
	{#State 246
		ACTIONS => {
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'Operator' => 116,
			'SubExpression' => 310,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 247
		ACTIONS => {
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP18_TERNARY' => 214,
			")" => -183,
			'OP11_COMPARE_LT_GT' => 213,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP16_LOGICAL_OR' => 221,
			";" => -183,
			'OP23_LOGICAL_AND' => 217,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209
		}
	},
	{#State 248
		DEFAULT => -143
	},
	{#State 249
		ACTIONS => {
			";" => -141,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => 217,
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			")" => -141
		}
	},
	{#State 250
		DEFAULT => -182
	},
	{#State 251
		DEFAULT => -142
	},
	{#State 252
		ACTIONS => {
			'OP01_QW' => 161,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			")" => -125,
			'ARGV' => 158,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80
		},
		GOTOS => {
			'HashDereference' => 97,
			'ListElement' => 160,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 137,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 162,
			'OPTIONAL-35' => 312,
			'ArrayReference' => 118,
			'ListElements' => 311,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'TypeInner' => 159
		}
	},
	{#State 253
		ACTIONS => {
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			")" => 313,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217
		}
	},
	{#State 254
		DEFAULT => -127
	},
	{#State 255
		ACTIONS => {
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'MY' => 143,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'ARGV' => 158,
			'WORD' => 29,
			'OP01_QW' => 161,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'ListElement' => 160,
			'HashReference' => 128,
			'SubExpression' => 162,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ListElements' => 314,
			'ArrayDereference' => 93,
			'TypeInner' => 159,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 256
		ACTIONS => {
			";" => 315
		}
	},
	{#State 257
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 316
		}
	},
	{#State 258
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122
		},
		GOTOS => {
			'Operator' => 116,
			'SubExpression' => 317,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93
		}
	},
	{#State 259
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 318
		}
	},
	{#State 260
		ACTIONS => {
			'TYPE_INTEGER' => 319
		}
	},
	{#State 261
		ACTIONS => {
			'TYPE_INTEGER' => 320
		}
	},
	{#State 262
		ACTIONS => {
			";" => 321
		}
	},
	{#State 263
		ACTIONS => {
			";" => 322
		}
	},
	{#State 264
		ACTIONS => {
			"}" => 323
		}
	},
	{#State 265
		DEFAULT => -212
	},
	{#State 266
		ACTIONS => {
			"}" => 326,
			'OP21_LIST_COMMA' => 324
		},
		GOTOS => {
			'PAREN-49' => 325
		}
	},
	{#State 267
		ACTIONS => {
			"undef" => -200,
			'LBRACKET' => -200,
			'OP01_CLOSE' => -200,
			'OP01_OPEN' => -200,
			'LITERAL_NUMBER' => -200,
			'LBRACE' => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			'LITERAL_STRING' => -200,
			'OP22_LOGICAL_NEG' => -200,
			'LPAREN' => -200,
			'WORD' => -200,
			'OP01_NAMED' => -200,
			'WORD_UPPERCASE' => -200,
			'OP03_MATH_INC_DEC' => -200,
			"\@{" => -200,
			'OP10_NAMED_UNARY' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'WORD_SCOPED' => -200,
			"%{" => -200,
			'OP05_LOGICAL_NEG' => -200,
			'MY' => 143,
			'SELF' => -200
		},
		GOTOS => {
			'TypeInner' => 327,
			'OPTIONAL-48' => 328
		}
	},
	{#State 268
		DEFAULT => -194
	},
	{#State 269
		ACTIONS => {
			'FHREF_SYMBOL' => 329
		}
	},
	{#State 270
		DEFAULT => -122
	},
	{#State 271
		ACTIONS => {
			")" => 330
		}
	},
	{#State 272
		DEFAULT => -131
	},
	{#State 273
		ACTIONS => {
			'OP13_BITWISE_AND' => -87,
			'OP17_LIST_RANGE' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP08_STRING_CAT' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP21_LIST_COMMA' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			'OP06_REGEX_MATCH' => -87,
			";" => -87,
			")" => -87,
			'OP11_COMPARE_LT_GT' => -87,
			"}" => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => -87,
			"]" => -87
		}
	},
	{#State 274
		ACTIONS => {
			'OP18_TERNARY' => -93,
			"]" => -93,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			"}" => -93,
			")" => -93,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP16_LOGICAL_OR' => -93,
			";" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP08_STRING_CAT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP13_BITWISE_AND' => -93
		}
	},
	{#State 275
		ACTIONS => {
			"]" => -94,
			'OP18_TERNARY' => -94,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -94,
			"}" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			")" => -94,
			";" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP06_REGEX_MATCH' => 210,
			'OP15_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP23_LOGICAL_AND' => -94
		}
	},
	{#State 276
		ACTIONS => {
			")" => -108,
			"}" => -108,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"]" => -108,
			'OP18_TERNARY' => 214,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => 217,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			";" => -108,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -108,
			'OP12_COMPARE_EQ_NE' => 220
		}
	},
	{#State 277
		DEFAULT => -90
	},
	{#State 278
		ACTIONS => {
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_STRING_REPEAT' => -91,
			";" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => -91,
			")" => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -91,
			"]" => -91,
			'OP18_TERNARY' => -91
		}
	},
	{#State 279
		ACTIONS => {
			'OP18_TERNARY' => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -102,
			")" => -102,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP21_LIST_COMMA' => -102,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => -102,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => -102
		}
	},
	{#State 280
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			";" => -98,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP18_TERNARY' => -98,
			"]" => -98,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -98,
			")" => -98
		}
	},
	{#State 281
		ACTIONS => {
			'COLON' => 331
		}
	},
	{#State 282
		DEFAULT => -225
	},
	{#State 283
		DEFAULT => -224
	},
	{#State 284
		ACTIONS => {
			'OP18_TERNARY' => -95,
			"]" => -95,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			"}" => -95,
			")" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP06_REGEX_MATCH' => 210,
			";" => -95,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP23_LOGICAL_AND' => -95
		}
	},
	{#State 285
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 206,
			"]" => -92,
			'OP18_TERNARY' => -92,
			")" => -92,
			"}" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -92,
			";" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP06_REGEX_MATCH' => 210,
			'OP13_BITWISE_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP08_STRING_CAT' => -92,
			'OP08_MATH_ADD_SUB' => -92
		}
	},
	{#State 286
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"]" => -107,
			'OP18_TERNARY' => 214,
			")" => -107,
			"}" => -107,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			";" => -107,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -107,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207
		}
	},
	{#State 287
		ACTIONS => {
			")" => -104,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -104,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => -104,
			"]" => -104,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP16_LOGICAL_OR' => 221,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			";" => -104
		}
	},
	{#State 288
		ACTIONS => {
			";" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"}" => -100,
			'OP11_COMPARE_LT_GT' => 213,
			")" => -100
		}
	},
	{#State 289
		ACTIONS => {
			")" => -99,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -99,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => -99,
			"]" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP16_LOGICAL_OR' => -99,
			";" => -99
		}
	},
	{#State 290
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP21_LIST_COMMA' => -103,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP16_LOGICAL_OR' => -103,
			";" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP13_BITWISE_AND' => 219,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => -103,
			"]" => -103,
			")" => -103,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -103
		}
	},
	{#State 291
		ACTIONS => {
			'OP18_TERNARY' => -101,
			"]" => -101,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -101,
			")" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => 220,
			";" => -101,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACE' => 332
		}
	},
	{#State 293
		ACTIONS => {
			'LITERAL_NUMBER' => 333,
			"our" => 335
		},
		GOTOS => {
			'Method' => 336,
			'MethodOrSubroutine' => 334,
			'Subroutine' => 337
		}
	},
	{#State 294
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 338
		}
	},
	{#State 295
		DEFAULT => -46
	},
	{#State 296
		ACTIONS => {
			";" => 339
		}
	},
	{#State 297
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 340
		}
	},
	{#State 298
		ACTIONS => {
			'WORD' => 341
		}
	},
	{#State 299
		DEFAULT => -198
	},
	{#State 300
		ACTIONS => {
			")" => 342
		}
	},
	{#State 301
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'MY' => 143,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'ARGV' => 158,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_QW' => 161,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'ListElements' => 343,
			'Expression' => 140,
			'Literal' => 96,
			'TypeInner' => 159,
			'ListElement' => 160,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'SubExpression' => 162,
			'HashReference' => 128
		}
	},
	{#State 302
		DEFAULT => -181
	},
	{#State 303
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'STDIN' => 248,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'FHREF_SYMBOL_IN' => 251,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88
		},
		GOTOS => {
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'SubExpression' => 249,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'SubExpressionOrInput' => 344,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 304
		DEFAULT => -178
	},
	{#State 305
		ACTIONS => {
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'SELF' => 88,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'HashDereference' => 97,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'HashReference' => 128,
			'SubExpression' => 345,
			'Operator' => 116,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 306
		DEFAULT => -185
	},
	{#State 307
		ACTIONS => {
			'OP01_QW' => 161,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123,
			'SELF' => 88,
			'MY' => 143,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'ARGV' => 158,
			'WORD' => 29,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 109,
			'VARIABLE_SYMBOL' => 83
		},
		GOTOS => {
			'TypeInner' => 159,
			'Literal' => 96,
			'Expression' => 140,
			'ArrayDereference' => 93,
			'HashReference' => 128,
			'SubExpression' => 162,
			'Operator' => 116,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'ListElement' => 346
		}
	},
	{#State 308
		ACTIONS => {
			'LPAREN' => -214,
			'OP02_METHOD_THINARROW_NEW' => -214,
			"}" => 347
		}
	},
	{#State 309
		ACTIONS => {
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"}" => 348,
			'OP11_COMPARE_LT_GT' => 213,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => 217
		}
	},
	{#State 310
		ACTIONS => {
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP23_LOGICAL_AND' => 217,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => 221,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP18_TERNARY' => 214,
			"]" => 349,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 311
		DEFAULT => -124
	},
	{#State 312
		ACTIONS => {
			")" => 350
		}
	},
	{#State 313
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 351
		}
	},
	{#State 314
		ACTIONS => {
			";" => 353
		}
	},
	{#State 315
		DEFAULT => -117
	},
	{#State 316
		ACTIONS => {
			'VARIABLE_SYMBOL' => 354
		}
	},
	{#State 317
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			")" => 355,
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP23_LOGICAL_AND' => 217,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => 221,
			'OP15_LOGICAL_AND' => 212,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 356
		}
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 357
		}
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 358
		}
	},
	{#State 321
		DEFAULT => -115
	},
	{#State 322
		DEFAULT => -114
	},
	{#State 323
		DEFAULT => -213
	},
	{#State 324
		ACTIONS => {
			'LITERAL_STRING' => 109,
			"%{" => 120,
			'WORD' => 192,
			'VARIABLE_SYMBOL' => 83,
			'ENV' => 197,
			'SELF' => 88,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 196,
			'HashEntry' => 359,
			'HashDereference' => 199,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 198,
			'VariableOrLiteralOrWord' => 195
		}
	},
	{#State 325
		DEFAULT => -206
	},
	{#State 326
		DEFAULT => -208
	},
	{#State 327
		DEFAULT => -199
	},
	{#State 328
		ACTIONS => {
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'SELF' => 88
		},
		GOTOS => {
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'SubExpression' => 360,
			'HashReference' => 128,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 329
		ACTIONS => {
			'OP21_LIST_COMMA' => 361
		}
	},
	{#State 330
		DEFAULT => -129
	},
	{#State 331
		ACTIONS => {
			'VARIABLE_SYMBOL' => 83,
			'LITERAL_STRING' => 109,
			'LITERAL_NUMBER' => 92,
			'SELF' => 88
		},
		GOTOS => {
			'VariableOrLiteral' => 362,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 283,
			'Literal' => 282
		}
	},
	{#State 332
		ACTIONS => {
			'WORD' => 363,
			"}" => 364
		},
		GOTOS => {
			'HashEntryProperties' => 365
		}
	},
	{#State 333
		ACTIONS => {
			";" => 366
		}
	},
	{#State 334
		DEFAULT => -59
	},
	{#State 335
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'TYPE_METHOD' => 367,
			'WORD' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 336
		DEFAULT => -76
	},
	{#State 337
		DEFAULT => -77
	},
	{#State 338
		ACTIONS => {
			")" => 368,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-19' => 369
		}
	},
	{#State 339
		DEFAULT => -48
	},
	{#State 340
		DEFAULT => -223
	},
	{#State 341
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 342
		DEFAULT => -80
	},
	{#State 343
		ACTIONS => {
			")" => 372
		}
	},
	{#State 344
		ACTIONS => {
			";" => 373
		}
	},
	{#State 345
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			"]" => 374,
			'OP18_TERNARY' => 214,
			'OP23_LOGICAL_AND' => 217,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP15_LOGICAL_AND' => 212,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => 221
		}
	},
	{#State 346
		DEFAULT => -184
	},
	{#State 347
		DEFAULT => -177
	},
	{#State 348
		DEFAULT => -176
	},
	{#State 349
		DEFAULT => -175
	},
	{#State 350
		DEFAULT => -130
	},
	{#State 351
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 375
		}
	},
	{#State 352
		ACTIONS => {
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			"foreach" => -148,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED' => 104,
			'WORD_UPPERCASE' => 103,
			"if" => 101,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'OP01_PRINT' => 117,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_NAMED_VOID_LPAREN' => 111,
			"undef" => 95,
			"for" => -148,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED_VOID' => 91,
			'OP05_MATH_NEG_LPAREN' => 86,
			"while" => -148,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 28,
			'MY' => 90,
			'OP19_LOOP_CONTROL' => 89,
			'SELF' => 88
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Conditional' => 115,
			'Operator' => 116,
			'OPTIONAL-37' => 113,
			'VariableDeclaration' => 105,
			'Statement' => 102,
			'LoopLabel' => 85,
			'Expression' => 108,
			'OperatorVoid' => 107,
			'WordScoped' => 126,
			'Variable' => 100,
			'PAREN-36' => 98,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'Operation' => 377,
			'SubExpression' => 127,
			'HashReference' => 128,
			'ArrayDereference' => 93,
			'VariableModification' => 121,
			'Literal' => 96,
			'PLUS-42' => 376
		}
	},
	{#State 353
		DEFAULT => -119
	},
	{#State 354
		ACTIONS => {
			'LPAREN' => 378
		}
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 356
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 357
		ACTIONS => {
			'LPAREN' => 381
		}
	},
	{#State 358
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 382
		}
	},
	{#State 359
		DEFAULT => -205
	},
	{#State 360
		ACTIONS => {
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -201,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP16_LOGICAL_OR' => 221,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 212,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP23_LOGICAL_AND' => 217,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP18_TERNARY' => 214,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -201
		}
	},
	{#State 361
		ACTIONS => {
			'LITERAL_STRING' => 383
		}
	},
	{#State 362
		DEFAULT => -105
	},
	{#State 363
		ACTIONS => {
			'OP20_HASH_FATARROW' => 384
		}
	},
	{#State 364
		ACTIONS => {
			";" => 385
		}
	},
	{#State 365
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 386
		}
	},
	{#State 366
		DEFAULT => -61
	},
	{#State 367
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 388
		}
	},
	{#State 369
		DEFAULT => -50
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
		DEFAULT => -179
	},
	{#State 374
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 390
		}
	},
	{#State 375
		ACTIONS => {
			'OP10_NAMED_UNARY' => -159,
			"}" => -159,
			"\@{" => -159,
			'OP03_MATH_INC_DEC' => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			"while" => -159,
			'LPAREN' => -159,
			'OP22_LOGICAL_NEG' => -159,
			'VARIABLE_SYMBOL' => -159,
			'SELF' => -159,
			'WORD_SCOPED' => -159,
			'MY' => -159,
			'OP19_LOOP_CONTROL' => -159,
			"for" => -159,
			'OP01_NAMED_VOID' => -159,
			'LITERAL_NUMBER' => -159,
			"elsif" => 395,
			"undef" => -159,
			"if" => -159,
			'OP01_NAMED' => -159,
			'WORD_UPPERCASE' => -159,
			'WORD' => -159,
			'LITERAL_STRING' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			"else" => 391,
			"%{" => -159,
			'OP05_LOGICAL_NEG' => -159,
			'CONSTANT_CALL_SCOPED' => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			'OP01_PRINT' => -159,
			'' => -159,
			'LBRACE' => -159,
			'OP01_OPEN' => -159,
			'OP01_CLOSE' => -159,
			'LBRACKET' => -159,
			"foreach" => -159
		},
		GOTOS => {
			'PAREN-40' => 392,
			'PAREN-38' => 393,
			'OPTIONAL-41' => 394
		}
	},
	{#State 376
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'OP01_PRINT' => 117,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'LITERAL_STRING' => 109,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED' => 104,
			'WORD_UPPERCASE' => 103,
			"if" => 101,
			"foreach" => -148,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'MY' => 90,
			'WORD_SCOPED' => 28,
			'OP19_LOOP_CONTROL' => 89,
			'SELF' => 88,
			"while" => -148,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			"}" => 396,
			'OP10_NAMED_UNARY' => 80,
			"undef" => 95,
			"for" => -148,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED_VOID' => 91
		},
		GOTOS => {
			'OperatorVoid' => 107,
			'Expression' => 108,
			'LoopLabel' => 85,
			'Statement' => 102,
			'VariableDeclaration' => 105,
			'Operator' => 116,
			'Conditional' => 115,
			'OPTIONAL-37' => 113,
			'ArrayReference' => 118,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'VariableModification' => 121,
			'SubExpression' => 127,
			'HashReference' => 128,
			'Operation' => 397,
			'HashDereference' => 97,
			'Variable' => 100,
			'PAREN-36' => 98,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 377
		DEFAULT => -170
	},
	{#State 378
		ACTIONS => {
			'SELF' => 88,
			'WORD_SCOPED' => 28,
			'MY' => 143,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'ARGV' => 158,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'OP01_QW' => 161,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 123,
			"undef" => 95
		},
		GOTOS => {
			'ListElement' => 160,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 162,
			'ArrayDereference' => 93,
			'ListElements' => 398,
			'Literal' => 96,
			'Expression' => 140,
			'TypeInner' => 159
		}
	},
	{#State 379
		DEFAULT => -167
	},
	{#State 380
		ACTIONS => {
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'STDIN' => 248,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_NAMED_UNARY' => 80,
			'FHREF_SYMBOL_IN' => 251,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 249,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'Variable' => 137,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Expression' => 140,
			'Literal' => 96,
			'SubExpressionOrInput' => 399,
			'ArrayDereference' => 93
		}
	},
	{#State 381
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'HashDereference' => 97,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'WordScoped' => 126,
			'Operator' => 116,
			'SubExpression' => 400,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 382
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123
		},
		GOTOS => {
			'HashDereference' => 97,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'WordScoped' => 126,
			'Operator' => 116,
			'SubExpression' => 401,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 383
		ACTIONS => {
			'OP21_LIST_COMMA' => 402
		}
	},
	{#State 384
		ACTIONS => {
			'MY' => 404
		},
		GOTOS => {
			'TypeInnerProperties' => 403
		}
	},
	{#State 385
		DEFAULT => -66
	},
	{#State 386
		ACTIONS => {
			'OP21_LIST_COMMA' => 405,
			"}" => 407
		},
		GOTOS => {
			'PAREN-25' => 406
		}
	},
	{#State 387
		ACTIONS => {
			"= sub {" => 408
		}
	},
	{#State 388
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 389
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD_SCOPED' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 390
		ACTIONS => {
			"undef" => 411
		}
	},
	{#State 391
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 412
		}
	},
	{#State 392
		DEFAULT => -158
	},
	{#State 393
		DEFAULT => -155
	},
	{#State 394
		DEFAULT => -160
	},
	{#State 395
		ACTIONS => {
			'LPAREN' => 413
		}
	},
	{#State 396
		DEFAULT => -171
	},
	{#State 397
		DEFAULT => -169
	},
	{#State 398
		ACTIONS => {
			")" => 414
		}
	},
	{#State 399
		ACTIONS => {
			")" => 415
		}
	},
	{#State 400
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP18_TERNARY' => 214,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 416,
			'OP23_LOGICAL_AND' => 217,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210
		}
	},
	{#State 401
		ACTIONS => {
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			";" => 417,
			'OP11_COMPARE_LT_GT' => 213,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP18_TERNARY' => 214
		}
	},
	{#State 402
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP01_NAMED' => 139,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93,
			'Operator' => 116,
			'SubExpression' => 418,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99
		}
	},
	{#State 403
		DEFAULT => -204
	},
	{#State 404
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 419
		}
	},
	{#State 405
		ACTIONS => {
			'WORD' => 363
		},
		GOTOS => {
			'HashEntryProperties' => 420
		}
	},
	{#State 406
		DEFAULT => -63
	},
	{#State 407
		ACTIONS => {
			";" => 421
		}
	},
	{#State 408
		ACTIONS => {
			"for" => -68,
			'OP01_NAMED_VOID' => -68,
			'LITERAL_NUMBER' => -68,
			"undef" => -68,
			'LPAREN_MY' => 422,
			'OP10_NAMED_UNARY' => -68,
			"}" => -68,
			'OP03_MATH_INC_DEC' => -68,
			"\@{" => -68,
			'OP22_LOGICAL_NEG' => -68,
			'LPAREN' => -68,
			"while" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'VARIABLE_SYMBOL' => -68,
			'SELF' => -68,
			'MY' => -68,
			'WORD_SCOPED' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'LBRACE' => -68,
			'OP01_OPEN' => -68,
			'OP01_CLOSE' => -68,
			'LBRACKET' => -68,
			"foreach" => -68,
			"if" => -68,
			'OP01_NAMED' => -68,
			'WORD_UPPERCASE' => -68,
			'WORD' => -68,
			'LITERAL_STRING' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			"%{" => -68,
			'OP05_LOGICAL_NEG' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP01_PRINT' => -68
		},
		GOTOS => {
			'MethodArguments' => 423,
			'OPTIONAL-27' => 424
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
			";" => 426
		}
	},
	{#State 412
		DEFAULT => -157
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP01_NAMED' => 139,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112
		},
		GOTOS => {
			'Operator' => 116,
			'SubExpression' => 427,
			'HashReference' => 128,
			'ArrayReference' => 118,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93
		}
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 415
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 416
		ACTIONS => {
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 83,
			'SELF' => 88,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'CONSTANT_CALL_SCOPED' => 112,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			"undef" => 95,
			'LBRACKET' => 123
		},
		GOTOS => {
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'HashReference' => 128,
			'SubExpression' => 430,
			'Operator' => 116,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 417
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 418
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -83,
			")" => -83,
			'OP18_TERNARY' => 214,
			"]" => -83,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -83,
			'OP12_COMPARE_EQ_NE' => 220,
			";" => -83,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212
		}
	},
	{#State 419
		ACTIONS => {
			"\$TYPED_" => 432
		}
	},
	{#State 420
		DEFAULT => -62
	},
	{#State 421
		DEFAULT => -65
	},
	{#State 422
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 433
		}
	},
	{#State 423
		DEFAULT => -67
	},
	{#State 424
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 434
		}
	},
	{#State 425
		DEFAULT => -49
	},
	{#State 426
		DEFAULT => -180
	},
	{#State 427
		ACTIONS => {
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP18_TERNARY' => 214,
			")" => 435,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP17_LIST_RANGE' => 218,
			'OP13_BITWISE_AND' => 219,
			'OP23_LOGICAL_AND' => 217,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216
		}
	},
	{#State 428
		DEFAULT => -166
	},
	{#State 429
		DEFAULT => -168
	},
	{#State 430
		ACTIONS => {
			'OP06_REGEX_MATCH' => 210,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP16_LOGICAL_OR' => 221,
			'OP15_LOGICAL_AND' => 212,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP23_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			")" => 436
		}
	},
	{#State 431
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 437
		}
	},
	{#State 432
		ACTIONS => {
			'WORD' => 438
		}
	},
	{#State 433
		ACTIONS => {
			'SELF' => 439
		}
	},
	{#State 434
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED_VOID' => 91,
			"for" => -148,
			"undef" => 95,
			'SELF' => 88,
			'OP19_LOOP_CONTROL' => 89,
			'MY' => 90,
			'WORD_SCOPED' => 28,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			"}" => 441,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 83,
			'LPAREN' => 84,
			"while" => -148,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"foreach" => -148,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'OP01_PRINT' => 117,
			'CONSTANT_CALL_SCOPED' => 112,
			'OP01_NAMED_VOID_SCOLON' => 114,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'OP01_NAMED' => 104,
			'WORD_UPPERCASE' => 103,
			"if" => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'LITERAL_STRING' => 109,
			'WORD' => 29
		},
		GOTOS => {
			'VariableModification' => 121,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'HashDereference' => 97,
			'WordScoped' => 126,
			'Variable' => 100,
			'VariableSymbolOrSelf' => 99,
			'PAREN-36' => 98,
			'SubExpression' => 127,
			'HashReference' => 128,
			'Operation' => 440,
			'Statement' => 102,
			'VariableDeclaration' => 105,
			'OperatorVoid' => 107,
			'Expression' => 108,
			'LoopLabel' => 85,
			'OPTIONAL-37' => 113,
			'Operator' => 116,
			'Conditional' => 115,
			'ArrayReference' => 118
		}
	},
	{#State 435
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 84,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 126,
			'Variable' => 137,
			'VariableSymbolOrSelf' => 99,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 444,
			'ArrayDereference' => 93,
			'Expression' => 140,
			'Literal' => 96
		}
	},
	{#State 438
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 446,
			'OP19_VARIABLE_ASSIGN' => 445
		}
	},
	{#State 439
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 447
		}
	},
	{#State 440
		DEFAULT => -69
	},
	{#State 441
		ACTIONS => {
			";" => 448
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
			'OP18_TERNARY' => 214,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => 213,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			";" => 449,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217
		}
	},
	{#State 445
		ACTIONS => {
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 124,
			"undef" => 95,
			'LBRACKET' => 123,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 92,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 83,
			'OP10_NAMED_UNARY' => 80,
			'WORD_UPPERCASE' => 138,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			"%{" => 120,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			'CONSTANT_CALL_SCOPED' => 112,
			'SELF' => 88
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 450,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'Expression' => 140,
			'Literal' => 96,
			'ArrayDereference' => 93
		}
	},
	{#State 446
		ACTIONS => {
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 119,
			"%{" => 120,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			"\@{" => 82,
			'WORD_UPPERCASE' => 138,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LPAREN' => 84,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			'LBRACKET' => 123,
			"undef" => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 137,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'Operator' => 116,
			'HashReference' => 128,
			'SubExpression' => 451,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140
		}
	},
	{#State 447
		ACTIONS => {
			")" => 453,
			'OP21_LIST_COMMA' => 452
		},
		GOTOS => {
			'PAREN-29' => 454
		}
	},
	{#State 448
		DEFAULT => -71
	},
	{#State 449
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LBRACE' => 122,
			"undef" => 95,
			'LBRACKET' => 123,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 125,
			'SELF' => 88,
			'CONSTANT_CALL_SCOPED' => 112,
			'WORD_SCOPED' => 28,
			"%{" => 120,
			'OP05_LOGICAL_NEG' => 119,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 81,
			'WORD_UPPERCASE' => 138,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 83,
			'WORD' => 29,
			'LPAREN' => 84,
			'LITERAL_STRING' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'SubExpressionOrVarMod' => 457,
			'VariableModification' => 456,
			'ArrayDereference' => 93,
			'Literal' => 96,
			'Expression' => 140,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 99,
			'Variable' => 100,
			'HashDereference' => 97,
			'ArrayReference' => 118,
			'SubExpression' => 455,
			'HashReference' => 128,
			'Operator' => 116
		}
	},
	{#State 450
		ACTIONS => {
			'OP16_LOGICAL_OR' => 221,
			'OP06_REGEX_MATCH' => 210,
			'OP21_LIST_COMMA' => -221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP15_LOGICAL_AND' => 212,
			'OP08_STRING_CAT' => 208,
			'OP08_MATH_ADD_SUB' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217,
			'OP18_TERNARY' => 214,
			'OP09_BITWISE_SHIFT' => 215,
			'OP04_MATH_POW' => 206,
			'OP11_COMPARE_LT_GT' => 213,
			"}" => -221
		}
	},
	{#State 451
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP16_LOGICAL_OR' => 221,
			'OP15_LOGICAL_AND' => 212,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208,
			'OP23_LOGICAL_AND' => 217,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			"]" => 458,
			'OP18_TERNARY' => 214,
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP11_COMPARE_LT_GT' => 213
		}
	},
	{#State 452
		ACTIONS => {
			'MY' => 459
		}
	},
	{#State 453
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 460
		}
	},
	{#State 454
		DEFAULT => -73
	},
	{#State 455
		ACTIONS => {
			'OP04_MATH_POW' => 206,
			'OP09_BITWISE_SHIFT' => 215,
			'OP18_TERNARY' => 214,
			")" => -144,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 212,
			'OP07_STRING_REPEAT' => 211,
			'OP14_BITWISE_OR_XOR' => 222,
			'OP16_LOGICAL_OR' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP06_REGEX_MATCH' => 210,
			'OP13_BITWISE_AND' => 219,
			'OP17_LIST_RANGE' => 218,
			'OP23_LOGICAL_AND' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP08_MATH_ADD_SUB' => 207,
			'OP08_STRING_CAT' => 208
		}
	},
	{#State 456
		DEFAULT => -145
	},
	{#State 457
		ACTIONS => {
			")" => 461
		}
	},
	{#State 458
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 462
		}
	},
	{#State 459
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 57,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 463
		}
	},
	{#State 460
		ACTIONS => {
			"\@_;" => 464
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 352
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 462
		ACTIONS => {
			"undef" => 466
		}
	},
	{#State 463
		ACTIONS => {
			'VARIABLE_SYMBOL' => 467
		}
	},
	{#State 464
		DEFAULT => -75
	},
	{#State 465
		DEFAULT => -165
	},
	{#State 466
		DEFAULT => -222
	},
	{#State 467
		DEFAULT => -72
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
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6830 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7051 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7168 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7186 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7471 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7704 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7718 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7725 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7743 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7754 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7765 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7776 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7787 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_141
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_142
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7995 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8017 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8028 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8035 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8042 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8049 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8056 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8063 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8092 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8103 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8114 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8125 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_166
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8147 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8158 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8169 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8183 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8208 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8219 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8230 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8241 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8252 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8263 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8274 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8296 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8307 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8318 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8339 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8350 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8361 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8372 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8383 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8394 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8408 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_194
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8419 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_197
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8444 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8455 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8462 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8469 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8480 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8491 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8502 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_204
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8513 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8520 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8527 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8545 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8563 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8570 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_212
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8581 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8592 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8603 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8614 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_216
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8625 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8647 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8658 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_220
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8669 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_221
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8680 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_222
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_223
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8702 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8713 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_225
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8724 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8735 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8746 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8757 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8768 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_230
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8779 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8790 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_232
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

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

#line 226 "lib/RPerl/Grammar.eyp"


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
