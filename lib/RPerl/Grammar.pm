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
    our $VERSION = 0.002_101;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\$TYPED_|foreach|\=\ sub\ \{|package|elsif|while|undef|else|our|for|\@_\;|\%\{|if|\@\{|\;|\}|\)|\])}gc and return ($1, $1);

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
                                     getprotobyname|glob|gmtime|goto|hex|int\s|lc|lcfirst|length|localtime|lock|log|lstat|oct|ord|quotemeta|
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
			'SHEBANG' => 6,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Program' => 2,
			'PAREN-1' => 3,
			'OPTIONAL-9' => 7,
			'Critic' => 1,
			'ModuleHeader' => 8,
			'PLUS-2' => 9,
			'CompileUnit' => 5
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-16' => 10
		}
	},
	{#State 5
		ACTIONS => {
			'' => 12
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-3' => 13,
			'Critic' => 14
		}
	},
	{#State 7
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 15
		},
		GOTOS => {
			'OPTIONAL-10' => 16
		}
	},
	{#State 8
		ACTIONS => {
			"use constant" => -27,
			'USE' => -27,
			"use parent qw(" => 18,
			"## no critic qw(" => -27,
			"our" => -27
		},
		GOTOS => {
			'Class' => 21,
			'Module' => 20,
			'Package' => 17,
			'STAR-11' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 4,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 22,
			'OPTIONAL-9' => 7,
			'ModuleHeader' => 8,
			'Critic' => 1
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 23,
			")" => 24
		}
	},
	{#State 11
		DEFAULT => -39
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 14
		DEFAULT => -6
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
		DEFAULT => -24
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
		ACTIONS => {
			"use constant" => -29,
			'USE' => -29,
			"our" => -29,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'STAR-12' => 30,
			'Critic' => 31
		}
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		DEFAULT => -25
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 32
		}
	},
	{#State 26
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 34
		}
	},
	{#State 27
		DEFAULT => -215
	},
	{#State 28
		DEFAULT => -214
	},
	{#State 29
		ACTIONS => {
			")" => 35
		}
	},
	{#State 30
		ACTIONS => {
			'USE' => 38,
			"use constant" => -31,
			"our" => -31
		},
		GOTOS => {
			'Include' => 36,
			'STAR-13' => 37
		}
	},
	{#State 31
		DEFAULT => -26
	},
	{#State 32
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use warnings;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			";" => 41
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
			"use constant" => 43,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 46,
			'PLUS-14' => 45,
			'Constant' => 47
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 39
		ACTIONS => {
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			"while" => -11,
			'MY' => -11,
			'OP01_PRINT' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'WORD_SCOPED' => -11,
			'SELF' => -11,
			"## no critic qw(" => 4,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"undef" => -11,
			"foreach" => -11,
			'LBRACKET' => -11,
			'WORD' => -11,
			'LBRACE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID' => -11,
			"if" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"for" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_OPEN' => -11,
			'USE' => -11,
			"\@{" => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_CLOSE' => -11,
			'WORD_UPPERCASE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"use constant" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'LPAREN' => -11,
			'LITERAL_STRING' => -11,
			"%{" => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 50
		}
	},
	{#State 40
		ACTIONS => {
			'USE_RPERL_AFTER' => 52,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 51
		}
	},
	{#State 41
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 53
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
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 61,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 46
		DEFAULT => -33
	},
	{#State 47
		DEFAULT => -30
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 62,
			";" => 63
		}
	},
	{#State 49
		DEFAULT => -8
	},
	{#State 50
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"for" => -13,
			"if" => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13,
			'WORD' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACKET' => -13,
			"%{" => -13,
			'LITERAL_STRING' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LPAREN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'USE' => 38,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"while" => -13,
			'MY' => -13,
			"our" => -13,
			'OP10_NAMED_UNARY' => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"undef" => -13,
			'SELF' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			'OP01_PRINT' => -13
		},
		GOTOS => {
			'STAR-6' => 64,
			'Include' => 65
		}
	},
	{#State 51
		ACTIONS => {
			"our" => 66
		}
	},
	{#State 52
		DEFAULT => -35
	},
	{#State 53
		DEFAULT => -23
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
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 57
		DEFAULT => -219
	},
	{#State 58
		DEFAULT => -218
	},
	{#State 59
		DEFAULT => -217
	},
	{#State 60
		DEFAULT => -32
	},
	{#State 61
		ACTIONS => {
			";" => 70
		}
	},
	{#State 62
		ACTIONS => {
			";" => 71
		}
	},
	{#State 63
		DEFAULT => -41
	},
	{#State 64
		ACTIONS => {
			'SELF' => -15,
			"undef" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_PRINT' => -15,
			'WORD_SCOPED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"foreach" => -15,
			"our" => -15,
			'OP10_NAMED_UNARY' => -15,
			'MY' => -15,
			"while" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_OPEN' => -15,
			"\@{" => -15,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LITERAL_NUMBER' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"use constant" => 43,
			'LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACE' => -15,
			'WORD' => -15,
			'LBRACKET' => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID' => -15,
			"if" => -15
		},
		GOTOS => {
			'STAR-7' => 72,
			'Constant' => 73
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 74
		}
	},
	{#State 67
		ACTIONS => {
			"## no critic qw(" => 4,
			"use constant" => -56,
			'USE' => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-22' => 76
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
		ACTIONS => {
			"= sub {" => 79
		}
	},
	{#State 70
		DEFAULT => -34
	},
	{#State 71
		DEFAULT => -42
	},
	{#State 72
		ACTIONS => {
			"if" => 125,
			'OP01_NAMED_VOID' => 123,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 127,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP01_NAMED_VOID_SCOLON' => 100,
			"while" => -148,
			'MY' => 92,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			"our" => 44,
			"foreach" => -148,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP01_PRINT' => 80,
			"undef" => 84,
			'OP01_NAMED_VOID_LPAREN' => 85,
			'SELF' => 83
		},
		GOTOS => {
			'VariableModification' => 86,
			'Subroutine' => 102,
			'LoopLabel' => 82,
			'SubExpression' => 98,
			'HashDereference' => 115,
			'Expression' => 114,
			'Variable' => 88,
			'PLUS-8' => 112,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'OPTIONAL-37' => 87,
			'ArrayReference' => 122,
			'VariableDeclaration' => 90,
			'Conditional' => 118,
			'PAREN-36' => 117,
			'Operator' => 128,
			'Statement' => 96,
			'WordScoped' => 126,
			'Operation' => 95,
			'OperatorVoid' => 93,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			"our hashref \$properties" => -58,
			'USE' => 38,
			"use constant" => -58
		},
		GOTOS => {
			'STAR-23' => 131,
			'Include' => 130
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_STRING' => 111,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Literal' => 132
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 133
		}
	},
	{#State 79
		ACTIONS => {
			'OP10_NAMED_UNARY' => -45,
			'VARIABLE_SYMBOL' => -45,
			"while" => -45,
			'MY' => -45,
			'OP01_PRINT' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'WORD_SCOPED' => -45,
			'SELF' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			"undef" => -45,
			"foreach" => -45,
			'LPAREN_MY' => 135,
			'LBRACKET' => -45,
			'LBRACE' => -45,
			'WORD' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP01_NAMED_VOID' => -45,
			"if" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"for" => -45,
			'OP01_OPEN' => -45,
			"\@{" => -45,
			'OP01_NAMED' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP01_CLOSE' => -45,
			'WORD_UPPERCASE' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"}" => -45,
			'OP22_LOGICAL_NEG' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'LITERAL_NUMBER' => -45,
			'LPAREN' => -45,
			'LITERAL_STRING' => -45,
			"%{" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 136,
			'SubroutineArguments' => 134
		}
	},
	{#State 80
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -111,
			'MY' => -111,
			'STDOUT_STDERR' => 139,
			'VARIABLE_SYMBOL' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'OP01_QW' => -111,
			'LBRACE' => -111,
			'WORD' => -111,
			'OP10_NAMED_UNARY' => -111,
			'LBRACKET' => -111,
			"%{" => -111,
			'LITERAL_STRING' => -111,
			'FHREF_SYMBOL_BRACES' => 138,
			'CONSTANT_CALL_SCOPED' => -111,
			'LITERAL_NUMBER' => -111,
			'LPAREN' => -111,
			'OP22_LOGICAL_NEG' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			"undef" => -111,
			'OP01_CLOSE' => -111,
			'ARGV' => -111,
			'WORD_UPPERCASE' => -111,
			'SELF' => -111,
			'OP01_NAMED' => -111,
			'WORD_SCOPED' => -111,
			"\@{" => -111,
			'OP01_OPEN' => -111
		},
		GOTOS => {
			'OPTIONAL-32' => 140,
			'PAREN-31' => 137
		}
	},
	{#State 81
		DEFAULT => -120
	},
	{#State 82
		ACTIONS => {
			'COLON' => 141
		}
	},
	{#State 83
		DEFAULT => -230
	},
	{#State 84
		DEFAULT => -133
	},
	{#State 85
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 27,
			")" => -113,
			"\@{" => 99,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"undef" => 84,
			'ARGV' => 146,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'OP01_QW' => 152,
			'LBRACE' => 121
		},
		GOTOS => {
			'SubExpression' => 150,
			'OPTIONAL-33' => 149,
			'TypeInner' => 142,
			'ArrayReference' => 122,
			'Literal' => 91,
			'ListElements' => 145,
			'HashReference' => 124,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126,
			'ListElement' => 143,
			'Operator' => 128,
			'HashDereference' => 115
		}
	},
	{#State 86
		ACTIONS => {
			";" => 154
		}
	},
	{#State 87
		ACTIONS => {
			"foreach" => 157,
			"while" => 161,
			"for" => 155
		},
		GOTOS => {
			'LoopWhile' => 159,
			'Loop' => 158,
			'LoopFor' => 156,
			'LoopForEach' => 160
		}
	},
	{#State 88
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 162,
			'OP04_MATH_POW' => -135,
			")" => -135,
			'OP08_STRING_CAT' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP19_VARIABLE_ASSIGN' => 165,
			'OP13_BITWISE_AND' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP02_METHOD_THINARROW' => 163,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP18_TERNARY' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP03_MATH_INC_DEC' => 164,
			'OP11_COMPARE_LT_GT' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP14_BITWISE_OR_XOR' => -135
		}
	},
	{#State 89
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'OP21_LIST_COMMA' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP10_NAMED_UNARY' => 89,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => -97,
			'OP17_LIST_RANGE' => -97,
			'SELF' => 83,
			"undef" => 84,
			'WORD_SCOPED' => 27,
			'OP09_BITWISE_SHIFT' => -97,
			'OP07_STRING_REPEAT' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP05_LOGICAL_NEG' => 129,
			'OP11_COMPARE_LT_GT' => -97,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119,
			'OP23_LOGICAL_AND' => -97,
			";" => -97,
			'LITERAL_STRING' => 111,
			'OP08_MATH_ADD_SUB' => -97,
			"%{" => 116,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP01_NAMED' => 148,
			"]" => -97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP04_MATH_POW' => -97,
			'OP01_OPEN' => 97,
			")" => -97,
			"\@{" => 99,
			'OP08_STRING_CAT' => -97
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 166,
			'Operator' => 128,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 90
		DEFAULT => -152
	},
	{#State 91
		DEFAULT => -134
	},
	{#State 92
		ACTIONS => {
			'WORD' => 59,
			'TYPE_FHREF' => 168,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 167
		}
	},
	{#State 93
		DEFAULT => -151
	},
	{#State 94
		DEFAULT => -229
	},
	{#State 95
		DEFAULT => -17
	},
	{#State 96
		DEFAULT => -79
	},
	{#State 97
		ACTIONS => {
			'MY' => 169
		}
	},
	{#State 98
		ACTIONS => {
			'OP15_LOGICAL_AND' => 170,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP07_STRING_REPEAT' => 179,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 99
		ACTIONS => {
			'MY' => 151,
			'SELF' => 83,
			'VARIABLE_SYMBOL' => 94,
			'LBRACKET' => -196
		},
		GOTOS => {
			'TypeInner' => 189,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 187,
			'OPTIONAL-47' => 188
		}
	},
	{#State 100
		DEFAULT => -116
	},
	{#State 101
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'ARGV' => 146,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP05_LOGICAL_NEG' => 129,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP01_QW' => 152
		},
		GOTOS => {
			'TypeInner' => 142,
			'ArrayReference' => 122,
			'SubExpression' => 191,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'Operator' => 128,
			'ListElement' => 190,
			'HashDereference' => 115,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 102
		DEFAULT => -14
	},
	{#State 103
		ACTIONS => {
			'FHREF_SYMBOL' => 192
		}
	},
	{#State 104
		ACTIONS => {
			'COLON' => -216,
			'LPAREN' => 193
		}
	},
	{#State 105
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'HashDereference' => 115,
			'Operator' => 128,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'SubExpression' => 194,
			'ArrayReference' => 122
		}
	},
	{#State 106
		DEFAULT => -128
	},
	{#State 107
		DEFAULT => -231
	},
	{#State 108
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			'OP01_PRINT' => 195,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 196,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'Operator' => 128,
			'HashDereference' => 115,
			'SubExpression' => 197,
			'ArrayReference' => 122
		}
	},
	{#State 109
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'Operator' => 128,
			'HashDereference' => 115,
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayReference' => 122,
			'SubExpression' => 198
		}
	},
	{#State 110
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 199
		}
	},
	{#State 111
		DEFAULT => -232
	},
	{#State 112
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'OP19_LOOP_CONTROL' => 127,
			"for" => -148,
			'OP01_NAMED_VOID' => 123,
			"if" => 125,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_NAMED' => 101,
			'OP01_NAMED_VOID_SCOLON' => 100,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 104,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'VARIABLE_SYMBOL' => 94,
			"while" => -148,
			'MY' => 92,
			'OP10_NAMED_UNARY' => 89,
			"foreach" => -148,
			'' => -18,
			'SELF' => 83,
			"undef" => 84,
			'OP01_NAMED_VOID_LPAREN' => 85,
			'OP01_PRINT' => 80,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'OPTIONAL-37' => 87,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 88,
			'Expression' => 114,
			'HashDereference' => 115,
			'SubExpression' => 98,
			'LoopLabel' => 82,
			'VariableModification' => 86,
			'Literal' => 91,
			'HashReference' => 124,
			'Statement' => 96,
			'WordScoped' => 126,
			'Operation' => 200,
			'OperatorVoid' => 93,
			'Operator' => 128,
			'PAREN-36' => 117,
			'Conditional' => 118,
			'ArrayReference' => 122,
			'VariableDeclaration' => 90
		}
	},
	{#State 113
		DEFAULT => -137
	},
	{#State 114
		ACTIONS => {
			'OP17_LIST_RANGE' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP04_MATH_POW' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP23_LOGICAL_AND' => -132,
			";" => 201,
			'OP18_TERNARY' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP11_COMPARE_LT_GT' => -132
		}
	},
	{#State 115
		DEFAULT => -139
	},
	{#State 116
		ACTIONS => {
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => -211,
			'SELF' => 83
		},
		GOTOS => {
			'OPTIONAL-51' => 202,
			'TypeInner' => 203,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 204
		}
	},
	{#State 117
		DEFAULT => -147
	},
	{#State 118
		DEFAULT => -149
	},
	{#State 119
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_QW' => 152,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 129,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			"]" => -193,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'ARGV' => 146,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Operator' => 128,
			'HashDereference' => 115,
			'ListElement' => 143,
			'HashReference' => 124,
			'ListElements' => 205,
			'Literal' => 91,
			'OPTIONAL-46' => 206,
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'SubExpression' => 150
		}
	},
	{#State 120
		ACTIONS => {
			'SELF' => 83,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'Variable' => 207
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 208,
			'SELF' => 83,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			"}" => 209,
			'ENV' => 212,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Literal' => 211,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 214,
			'HashDereference' => 210,
			'VariableOrLiteralOrWord' => 213,
			'HashEntry' => 215
		}
	},
	{#State 122
		DEFAULT => -136
	},
	{#State 123
		ACTIONS => {
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'ARGV' => 146,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP01_QW' => 152,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'SubExpression' => 150,
			'HashDereference' => 115,
			'ListElement' => 143,
			'Operator' => 128,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashReference' => 124,
			'ListElements' => 216,
			'Literal' => 91
		}
	},
	{#State 124
		DEFAULT => -138
	},
	{#State 125
		ACTIONS => {
			'LPAREN' => 217
		}
	},
	{#State 126
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 219,
			'LPAREN' => 218
		}
	},
	{#State 127
		ACTIONS => {
			'WORD_UPPERCASE' => 221
		},
		GOTOS => {
			'LoopLabel' => 220
		}
	},
	{#State 128
		DEFAULT => -126
	},
	{#State 129
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'SubExpression' => 222,
			'ArrayReference' => 122,
			'Literal' => 91,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126
		}
	},
	{#State 130
		DEFAULT => -55
	},
	{#State 131
		ACTIONS => {
			"use constant" => 43,
			"our hashref \$properties" => 225
		},
		GOTOS => {
			'Constant' => 224,
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
		DEFAULT => -44
	},
	{#State 135
		ACTIONS => {
			'WORD' => 59,
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 228
		}
	},
	{#State 136
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 229
		}
	},
	{#State 137
		DEFAULT => -110
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP01_QW' => 152,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'ARGV' => 146,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'SubExpression' => 150,
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'ListElements' => 230,
			'HashReference' => 124,
			'Literal' => 91,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Operator' => 128,
			'HashDereference' => 115,
			'ListElement' => 143
		}
	},
	{#State 139
		DEFAULT => -109
	},
	{#State 140
		ACTIONS => {
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_UPPERCASE' => 147,
			'ARGV' => 146,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP05_LOGICAL_NEG' => 129,
			'WORD' => 28,
			'OP01_QW' => 152,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89
		},
		GOTOS => {
			'Literal' => 91,
			'ListElements' => 231,
			'HashReference' => 124,
			'HashDereference' => 115,
			'Operator' => 128,
			'ListElement' => 143,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'SubExpression' => 150,
			'TypeInner' => 142,
			'ArrayReference' => 122
		}
	},
	{#State 141
		DEFAULT => -146
	},
	{#State 142
		ACTIONS => {
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'SubExpression' => 232,
			'ArrayReference' => 122
		}
	},
	{#State 143
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 233
		}
	},
	{#State 144
		DEFAULT => -132
	},
	{#State 145
		DEFAULT => -112
	},
	{#State 146
		DEFAULT => -191
	},
	{#State 147
		ACTIONS => {
			'LPAREN' => 193
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'HashReference' => 124,
			'Literal' => 91,
			'HashDereference' => 115,
			'Operator' => 128,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 234,
			'ArrayReference' => 122
		}
	},
	{#State 149
		ACTIONS => {
			")" => 235
		}
	},
	{#State 150
		ACTIONS => {
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			";" => -188,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -188,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			")" => -188,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			"]" => -188,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185
		}
	},
	{#State 151
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 236
		}
	},
	{#State 152
		DEFAULT => -190
	},
	{#State 153
		ACTIONS => {
			")" => -135,
			'OP08_STRING_CAT' => -135,
			'OP04_MATH_POW' => -135,
			"]" => -135,
			'OP17_LIST_RANGE' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP13_BITWISE_AND' => -135,
			"}" => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP02_METHOD_THINARROW' => 163,
			'OP24_LOGICAL_OR_XOR' => -135,
			";" => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP18_TERNARY' => -135,
			'OP03_MATH_INC_DEC' => 164,
			'OP21_LIST_COMMA' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP09_BITWISE_SHIFT' => -135
		}
	},
	{#State 154
		DEFAULT => -153
	},
	{#State 155
		ACTIONS => {
			'MY' => 237,
			'LPAREN_MY' => 238
		}
	},
	{#State 156
		DEFAULT => -161
	},
	{#State 157
		ACTIONS => {
			'MY' => 239
		}
	},
	{#State 158
		DEFAULT => -150
	},
	{#State 159
		DEFAULT => -163
	},
	{#State 160
		DEFAULT => -162
	},
	{#State 161
		ACTIONS => {
			'LPAREN' => 241,
			'LPAREN_MY' => 240
		}
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 27,
			"\@{" => 99
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 242,
			'Operator' => 128,
			'HashDereference' => 115,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 163
		ACTIONS => {
			'LPAREN' => 243
		}
	},
	{#State 164
		DEFAULT => -86
	},
	{#State 165
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'STDIN' => 247,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"undef" => 84,
			'FHREF_SYMBOL_IN' => 245,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 27,
			"\@{" => 99
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 246,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashDereference' => 115,
			'Operator' => 128,
			'HashReference' => 124,
			'Literal' => 91,
			'SubExpressionOrInput' => 244
		}
	},
	{#State 166
		ACTIONS => {
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			";" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP04_MATH_POW' => 182,
			")" => -96,
			'OP08_STRING_CAT' => 183,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP13_BITWISE_AND' => -96,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184
		}
	},
	{#State 167
		ACTIONS => {
			'VARIABLE_SYMBOL' => 248
		}
	},
	{#State 168
		ACTIONS => {
			'FHREF_SYMBOL' => 249
		}
	},
	{#State 169
		ACTIONS => {
			'TYPE_FHREF' => 250
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'Operator' => 128,
			'HashDereference' => 115,
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayReference' => 122,
			'SubExpression' => 251
		}
	},
	{#State 171
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'SELF' => 83,
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'Variable' => 252,
			'VariableSymbolOrSelf' => 110,
			'VariableOrLiteral' => 253,
			'Literal' => 254
		}
	},
	{#State 172
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'SubExpression' => 255,
			'ArrayReference' => 122
		}
	},
	{#State 173
		ACTIONS => {
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'SubExpression' => 256,
			'ArrayReference' => 122,
			'Literal' => 91,
			'HashReference' => 124,
			'HashDereference' => 115,
			'Operator' => 128,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153
		}
	},
	{#State 174
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 257
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'SubExpression' => 258,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashDereference' => 115,
			'Operator' => 128
		}
	},
	{#State 176
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126,
			'HashDereference' => 115,
			'Operator' => 128,
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayReference' => 122,
			'SubExpression' => 259
		}
	},
	{#State 177
		ACTIONS => {
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 260,
			'Operator' => 128,
			'HashDereference' => 115,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 178
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'SubExpression' => 261,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 115,
			'Operator' => 128
		}
	},
	{#State 179
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83
		},
		GOTOS => {
			'SubExpression' => 262,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashDereference' => 115,
			'Operator' => 128
		}
	},
	{#State 180
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 263,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'Operator' => 128,
			'HashDereference' => 115,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 181
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'SubExpression' => 264,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 115,
			'Operator' => 128
		}
	},
	{#State 182
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 265,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Operator' => 128,
			'HashDereference' => 115,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 183
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'Operator' => 128,
			'HashDereference' => 115,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashReference' => 124,
			'Literal' => 91,
			'ArrayReference' => 122,
			'SubExpression' => 266
		}
	},
	{#State 184
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 267,
			'HashDereference' => 115,
			'Operator' => 128,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 185
		ACTIONS => {
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129
		},
		GOTOS => {
			'HashReference' => 124,
			'Literal' => 91,
			'Expression' => 144,
			'WordScoped' => 126,
			'Variable' => 153,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 115,
			'Operator' => 128,
			'SubExpression' => 268,
			'ArrayReference' => 122
		}
	},
	{#State 186
		ACTIONS => {
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89
		},
		GOTOS => {
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Operator' => 128,
			'HashDereference' => 115,
			'HashReference' => 124,
			'Literal' => 91,
			'ArrayReference' => 122,
			'SubExpression' => 269
		}
	},
	{#State 187
		ACTIONS => {
			"}" => 270
		}
	},
	{#State 188
		ACTIONS => {
			'LBRACKET' => 119
		},
		GOTOS => {
			'ArrayReference' => 271
		}
	},
	{#State 189
		DEFAULT => -195
	},
	{#State 190
		ACTIONS => {
			'OP21_LIST_COMMA' => 272
		}
	},
	{#State 191
		ACTIONS => {
			'OP21_LIST_COMMA' => -188,
			'OP15_LOGICAL_AND' => -81,
			";" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP08_STRING_CAT' => -81,
			")" => -81,
			'OP04_MATH_POW' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP13_BITWISE_AND' => -81
		}
	},
	{#State 192
		DEFAULT => -84
	},
	{#State 193
		ACTIONS => {
			")" => 273
		}
	},
	{#State 194
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 180,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP15_LOGICAL_AND' => 170,
			'OP13_BITWISE_AND' => 186,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => 173,
			")" => 274,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181
		}
	},
	{#State 195
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 275
		}
	},
	{#State 196
		ACTIONS => {
			"undef" => 84,
			'ARGV' => 146,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP05_LOGICAL_NEG' => 129,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'TypeInner' => 142,
			'ArrayReference' => 122,
			'SubExpression' => 191,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'Operator' => 128,
			'HashDereference' => 115,
			'ListElement' => 276,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 197
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP13_BITWISE_AND' => 186,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP04_MATH_POW' => 182,
			")" => 277,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 180,
			'OP15_LOGICAL_AND' => 170,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175
		}
	},
	{#State 198
		ACTIONS => {
			"]" => -106,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			")" => -106,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 186,
			"}" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => 170,
			";" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => 171,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 199
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP02_HASH_THINARROW' => 279,
			'OP18_TERNARY' => -174,
			'COLON' => -174,
			'OP20_HASH_FATARROW' => -174,
			";" => -174,
			'OP23_LOGICAL_AND' => -174,
			'OP02_ARRAY_THINARROW' => 280,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP06_REGEX_MATCH' => -174,
			"}" => -174,
			'OP13_BITWISE_AND' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP17_LIST_RANGE' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			"]" => -174,
			'OP04_MATH_POW' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP08_STRING_CAT' => -174,
			")" => -174
		},
		GOTOS => {
			'VariableRetrieval' => 278
		}
	},
	{#State 200
		DEFAULT => -16
	},
	{#State 201
		DEFAULT => -78
	},
	{#State 202
		ACTIONS => {
			'LBRACE' => 121
		},
		GOTOS => {
			'HashReference' => 281
		}
	},
	{#State 203
		DEFAULT => -210
	},
	{#State 204
		ACTIONS => {
			"}" => 282
		}
	},
	{#State 205
		DEFAULT => -192
	},
	{#State 206
		ACTIONS => {
			"]" => 283
		}
	},
	{#State 207
		DEFAULT => -85
	},
	{#State 208
		DEFAULT => -228
	},
	{#State 209
		DEFAULT => -209
	},
	{#State 210
		DEFAULT => -202
	},
	{#State 211
		DEFAULT => -227
	},
	{#State 212
		DEFAULT => -203
	},
	{#State 213
		ACTIONS => {
			'OP20_HASH_FATARROW' => 284
		}
	},
	{#State 214
		DEFAULT => -226
	},
	{#State 215
		DEFAULT => -207,
		GOTOS => {
			'STAR-50' => 285
		}
	},
	{#State 216
		ACTIONS => {
			";" => 286
		}
	},
	{#State 217
		ACTIONS => {
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'HashDereference' => 115,
			'Operator' => 128,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashReference' => 124,
			'Literal' => 91,
			'ArrayReference' => 122,
			'SubExpression' => 287
		}
	},
	{#State 218
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_QW' => 152,
			'WORD' => 28,
			'LBRACE' => 121,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			")" => -123,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'ARGV' => 146,
			'SELF' => 83,
			'OP01_NAMED' => 148
		},
		GOTOS => {
			'ListElements' => 288,
			'HashReference' => 124,
			'Literal' => 91,
			'ListElement' => 143,
			'Operator' => 128,
			'HashDereference' => 115,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'OPTIONAL-34' => 289,
			'SubExpression' => 150,
			'ArrayReference' => 122,
			'TypeInner' => 142
		}
	},
	{#State 219
		ACTIONS => {
			")" => 290
		}
	},
	{#State 220
		ACTIONS => {
			";" => 291
		}
	},
	{#State 221
		DEFAULT => -216
	},
	{#State 222
		ACTIONS => {
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => -88,
			")" => -88,
			'OP17_LIST_RANGE' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			"]" => -88,
			"}" => -88,
			'OP13_BITWISE_AND' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP18_TERNARY' => -88,
			'OP23_LOGICAL_AND' => -88,
			";" => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP07_STRING_REPEAT' => -88
		}
	},
	{#State 223
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 292
		}
	},
	{#State 224
		DEFAULT => -57
	},
	{#State 225
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 293
		}
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
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 229
		ACTIONS => {
			'OP01_NAMED_VOID' => 123,
			"if" => 125,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 127,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			"}" => 296,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'OP01_NAMED_VOID_SCOLON' => 100,
			'OP01_NAMED' => 101,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			'MY' => 92,
			"while" => -148,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			"foreach" => -148,
			'OP01_PRINT' => 80,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'SELF' => 83,
			"undef" => 84,
			'OP01_NAMED_VOID_LPAREN' => 85
		},
		GOTOS => {
			'VariableModification' => 86,
			'LoopLabel' => 82,
			'SubExpression' => 98,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Variable' => 88,
			'Expression' => 114,
			'OPTIONAL-37' => 87,
			'VariableDeclaration' => 90,
			'ArrayReference' => 122,
			'PAREN-36' => 117,
			'Conditional' => 118,
			'Operator' => 128,
			'Operation' => 297,
			'Statement' => 96,
			'OperatorVoid' => 93,
			'WordScoped' => 126,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 230
		ACTIONS => {
			";" => 298
		}
	},
	{#State 231
		ACTIONS => {
			";" => 299
		}
	},
	{#State 232
		ACTIONS => {
			";" => -189,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -189,
			'OP11_COMPARE_LT_GT' => 180,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			")" => -189,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			"]" => -189,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 186,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 233
		ACTIONS => {
			'OP21_LIST_COMMA' => 301,
			"]" => -187,
			";" => -187,
			")" => -187
		},
		GOTOS => {
			'PAREN-44' => 300
		}
	},
	{#State 234
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP18_TERNARY' => -81,
			'OP23_LOGICAL_AND' => -81,
			";" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP13_BITWISE_AND' => -81,
			"}" => -81,
			'OP17_LIST_RANGE' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			"]" => -81,
			'OP04_MATH_POW' => -81,
			")" => -81,
			'OP08_STRING_CAT' => -81
		}
	},
	{#State 235
		ACTIONS => {
			";" => 302
		}
	},
	{#State 236
		ACTIONS => {
			"\$TYPED_" => 303
		}
	},
	{#State 237
		ACTIONS => {
			'TYPE_INTEGER' => 304
		}
	},
	{#State 238
		ACTIONS => {
			'TYPE_INTEGER' => 305
		}
	},
	{#State 239
		ACTIONS => {
			'WORD' => 59,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 306
		}
	},
	{#State 240
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 57,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 241
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 308,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 115,
			'Operator' => 128,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 242
		ACTIONS => {
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			";" => -183,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP04_MATH_POW' => 182,
			")" => -183,
			'OP08_STRING_CAT' => 183,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184
		}
	},
	{#State 243
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP05_LOGICAL_NEG' => 129,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LBRACE' => 121,
			'OP01_QW' => 152,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			")" => -125,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_UPPERCASE' => 147,
			'ARGV' => 146,
			'OP01_CLOSE' => 103,
			"undef" => 84
		},
		GOTOS => {
			'HashReference' => 124,
			'ListElements' => 310,
			'Literal' => 91,
			'Operator' => 128,
			'HashDereference' => 115,
			'ListElement' => 143,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'SubExpression' => 150,
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'OPTIONAL-35' => 309
		}
	},
	{#State 244
		DEFAULT => -182
	},
	{#State 245
		DEFAULT => -142
	},
	{#State 246
		ACTIONS => {
			";" => -141,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			")" => -141,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 247
		DEFAULT => -143
	},
	{#State 248
		ACTIONS => {
			";" => 312,
			'OP02_ARRAY_THINARROW' => 313,
			'OP19_VARIABLE_ASSIGN' => 311
		}
	},
	{#State 249
		ACTIONS => {
			";" => 314
		}
	},
	{#State 250
		ACTIONS => {
			'FHREF_SYMBOL' => 315
		}
	},
	{#State 251
		ACTIONS => {
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP12_COMPARE_EQ_NE' => 181,
			")" => -102,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => -102,
			"}" => -102,
			'OP13_BITWISE_AND' => 186,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => -102,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => -102,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 252
		DEFAULT => -224
	},
	{#State 253
		ACTIONS => {
			'COLON' => 316
		}
	},
	{#State 254
		DEFAULT => -225
	},
	{#State 255
		ACTIONS => {
			'OP21_LIST_COMMA' => -104,
			'OP15_LOGICAL_AND' => 170,
			";" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP18_TERNARY' => -104,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			"]" => -104,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 181,
			")" => -104,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => -104,
			"}" => -104,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 256
		ACTIONS => {
			"}" => -108,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			")" => -108,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			"]" => -108,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			";" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP15_LOGICAL_AND' => 170
		}
	},
	{#State 257
		DEFAULT => -90
	},
	{#State 258
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			"]" => -107,
			'OP04_MATH_POW' => 182,
			")" => -107,
			'OP08_STRING_CAT' => 183,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP13_BITWISE_AND' => 186,
			"}" => -107,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -107,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => -107,
			";" => -107,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 259
		ACTIONS => {
			'OP16_LOGICAL_OR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			";" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP18_TERNARY' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => -95,
			"}" => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP08_STRING_CAT' => 183,
			")" => -95,
			'OP04_MATH_POW' => 182
		}
	},
	{#State 260
		ACTIONS => {
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			";" => -103,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -103,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => -103,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			")" => -103,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => -103,
			"]" => -103,
			"}" => -103,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174
		}
	},
	{#State 261
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 180,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			";" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => 186,
			"}" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_STRING_CAT' => 183,
			")" => -101,
			'OP04_MATH_POW' => 182,
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NE' => 181
		}
	},
	{#State 262
		ACTIONS => {
			"]" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP08_STRING_CAT' => -91,
			")" => -91,
			'OP04_MATH_POW' => 182,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP13_BITWISE_AND' => -91,
			"}" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP15_LOGICAL_AND' => -91,
			";" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91
		}
	},
	{#State 263
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			"]" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP08_STRING_CAT' => 183,
			")" => -98,
			'OP04_MATH_POW' => 182,
			'OP16_LOGICAL_OR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			";" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP18_TERNARY' => -98
		}
	},
	{#State 264
		ACTIONS => {
			";" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP11_COMPARE_LT_GT' => 180,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP08_STRING_CAT' => 183,
			")" => -99,
			'OP04_MATH_POW' => 182,
			"]" => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => -99
		}
	},
	{#State 265
		ACTIONS => {
			'OP04_MATH_POW' => 182,
			")" => -87,
			'OP08_STRING_CAT' => -87,
			'OP17_LIST_RANGE' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			"]" => -87,
			'OP13_BITWISE_AND' => -87,
			"}" => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP06_REGEX_MATCH' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			'OP18_TERNARY' => -87,
			'OP23_LOGICAL_AND' => -87,
			";" => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP21_LIST_COMMA' => -87,
			'OP11_COMPARE_LT_GT' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP16_LOGICAL_OR' => -87
		}
	},
	{#State 266
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			";" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP18_TERNARY' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			"]" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP08_STRING_CAT' => -94,
			")" => -94,
			'OP04_MATH_POW' => 182
		}
	},
	{#State 267
		ACTIONS => {
			")" => -92,
			'OP08_STRING_CAT' => -92,
			'OP04_MATH_POW' => 182,
			"]" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP13_BITWISE_AND' => -92,
			"}" => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 268
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => -93,
			'OP06_REGEX_MATCH' => 174,
			'OP13_BITWISE_AND' => -93,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP17_LIST_RANGE' => -93,
			"]" => -93,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => -93,
			")" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93
		}
	},
	{#State 269
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => 181,
			"]" => -100,
			'OP04_MATH_POW' => 182,
			")" => -100,
			'OP08_STRING_CAT' => 183,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			"}" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 270
		DEFAULT => -197
	},
	{#State 271
		ACTIONS => {
			"}" => 317
		}
	},
	{#State 272
		ACTIONS => {
			'ARGV' => 146,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP01_QW' => 152,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151
		},
		GOTOS => {
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'ListElement' => 143,
			'HashDereference' => 115,
			'Operator' => 128,
			'ListElements' => 318,
			'HashReference' => 124,
			'Literal' => 91,
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'SubExpression' => 150
		}
	},
	{#State 273
		DEFAULT => -127
	},
	{#State 274
		DEFAULT => -89
	},
	{#State 275
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP01_QW' => 152,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'ARGV' => 146,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'Literal' => 91,
			'ListElements' => 319,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'ListElement' => 143,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126,
			'SubExpression' => 150,
			'TypeInner' => 142,
			'ArrayReference' => 122
		}
	},
	{#State 276
		ACTIONS => {
			'OP21_LIST_COMMA' => 320
		}
	},
	{#State 277
		DEFAULT => -140
	},
	{#State 278
		DEFAULT => -172
	},
	{#State 279
		ACTIONS => {
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 321,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 322,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Operator' => 128,
			'HashDereference' => 115,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 280
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'HashReference' => 124,
			'Literal' => 91,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Operator' => 128,
			'HashDereference' => 115,
			'SubExpression' => 323,
			'ArrayReference' => 122
		}
	},
	{#State 281
		ACTIONS => {
			"}" => 324
		}
	},
	{#State 282
		DEFAULT => -212
	},
	{#State 283
		DEFAULT => -194
	},
	{#State 284
		ACTIONS => {
			"%{" => -200,
			'LITERAL_STRING' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'LITERAL_NUMBER' => -200,
			'LPAREN' => -200,
			'OP22_LOGICAL_NEG' => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			"undef" => -200,
			'OP01_CLOSE' => -200,
			'WORD_UPPERCASE' => -200,
			'SELF' => -200,
			'OP01_NAMED' => -200,
			'WORD_SCOPED' => -200,
			"\@{" => -200,
			'OP01_OPEN' => -200,
			'OP05_LOGICAL_NEG' => -200,
			'MY' => 151,
			'VARIABLE_SYMBOL' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'WORD' => -200,
			'LBRACE' => -200,
			'OP10_NAMED_UNARY' => -200,
			'LBRACKET' => -200
		},
		GOTOS => {
			'TypeInner' => 325,
			'OPTIONAL-48' => 326
		}
	},
	{#State 285
		ACTIONS => {
			"}" => 329,
			'OP21_LIST_COMMA' => 328
		},
		GOTOS => {
			'PAREN-49' => 327
		}
	},
	{#State 286
		DEFAULT => -118
	},
	{#State 287
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => 180,
			'OP15_LOGICAL_AND' => 170,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP13_BITWISE_AND' => 186,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			")" => 330
		}
	},
	{#State 288
		DEFAULT => -122
	},
	{#State 289
		ACTIONS => {
			")" => 331
		}
	},
	{#State 290
		DEFAULT => -131
	},
	{#State 291
		DEFAULT => -121
	},
	{#State 292
		ACTIONS => {
			'LITERAL_NUMBER' => 336,
			"our" => 333
		},
		GOTOS => {
			'Method' => 335,
			'Subroutine' => 334,
			'MethodOrSubroutine' => 332
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
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 339
		}
	},
	{#State 296
		ACTIONS => {
			";" => 340
		}
	},
	{#State 297
		DEFAULT => -46
	},
	{#State 298
		DEFAULT => -115
	},
	{#State 299
		DEFAULT => -114
	},
	{#State 300
		DEFAULT => -185
	},
	{#State 301
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP01_QW' => 152,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'ARGV' => 146,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'ArrayReference' => 122,
			'TypeInner' => 142,
			'SubExpression' => 150,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Operator' => 128,
			'ListElement' => 341,
			'HashDereference' => 115,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 302
		DEFAULT => -117
	},
	{#State 303
		ACTIONS => {
			'WORD' => 342
		}
	},
	{#State 304
		ACTIONS => {
			'VARIABLE_SYMBOL' => 343
		}
	},
	{#State 305
		ACTIONS => {
			'VARIABLE_SYMBOL' => 344
		}
	},
	{#State 306
		ACTIONS => {
			'VARIABLE_SYMBOL' => 345
		}
	},
	{#State 307
		ACTIONS => {
			'VARIABLE_SYMBOL' => 346
		}
	},
	{#State 308
		ACTIONS => {
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP04_MATH_POW' => 182,
			")" => 347,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP15_LOGICAL_AND' => 170
		}
	},
	{#State 309
		ACTIONS => {
			")" => 348
		}
	},
	{#State 310
		DEFAULT => -124
	},
	{#State 311
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'STDIN' => 247,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			'FHREF_SYMBOL_IN' => 245,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'HashReference' => 124,
			'SubExpressionOrInput' => 349,
			'Literal' => 91,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Operator' => 128,
			'HashDereference' => 115,
			'SubExpression' => 246,
			'ArrayReference' => 122
		}
	},
	{#State 312
		DEFAULT => -178
	},
	{#State 313
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 350,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'HashDereference' => 115,
			'Operator' => 128
		}
	},
	{#State 314
		DEFAULT => -181
	},
	{#State 315
		ACTIONS => {
			'OP21_LIST_COMMA' => 351
		}
	},
	{#State 316
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 111,
			'SELF' => 83,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'VariableOrLiteral' => 352,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 252,
			'Literal' => 254
		}
	},
	{#State 317
		DEFAULT => -198
	},
	{#State 318
		ACTIONS => {
			";" => 353
		}
	},
	{#State 319
		ACTIONS => {
			")" => 354
		}
	},
	{#State 320
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'ARGV' => 146,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'OP01_QW' => 152,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'SubExpression' => 150,
			'TypeInner' => 142,
			'ArrayReference' => 122,
			'Literal' => 91,
			'ListElements' => 355,
			'HashReference' => 124,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'Operator' => 128,
			'ListElement' => 143,
			'HashDereference' => 115
		}
	},
	{#State 321
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -214,
			'LPAREN' => -214,
			"}" => 356
		}
	},
	{#State 322
		ACTIONS => {
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 186,
			"}" => 357,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178
		}
	},
	{#State 323
		ACTIONS => {
			"]" => 358,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 186,
			'OP15_LOGICAL_AND' => 170,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 324
		DEFAULT => -213
	},
	{#State 325
		DEFAULT => -199
	},
	{#State 326
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 359,
			'HashDereference' => 115,
			'Operator' => 128,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 327
		DEFAULT => -206
	},
	{#State 328
		ACTIONS => {
			'WORD' => 208,
			'VARIABLE_SYMBOL' => 94,
			'SELF' => 83,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'ENV' => 212,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Variable' => 214,
			'VariableSymbolOrSelf' => 110,
			'VariableOrLiteralOrWord' => 213,
			'HashEntry' => 360,
			'HashDereference' => 210,
			'Literal' => 211
		}
	},
	{#State 329
		DEFAULT => -208
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 362
		}
	},
	{#State 331
		DEFAULT => -129
	},
	{#State 332
		DEFAULT => -59
	},
	{#State 333
		ACTIONS => {
			'WORD' => 59,
			'TYPE_METHOD' => 363,
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 334
		DEFAULT => -77
	},
	{#State 335
		DEFAULT => -76
	},
	{#State 336
		ACTIONS => {
			";" => 364
		}
	},
	{#State 337
		ACTIONS => {
			"}" => 366,
			'WORD' => 367
		},
		GOTOS => {
			'HashEntryProperties' => 365
		}
	},
	{#State 338
		DEFAULT => -223
	},
	{#State 339
		ACTIONS => {
			'OP21_LIST_COMMA' => 370,
			")" => 368
		},
		GOTOS => {
			'PAREN-19' => 369
		}
	},
	{#State 340
		DEFAULT => -48
	},
	{#State 341
		DEFAULT => -184
	},
	{#State 342
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 343
		ACTIONS => {
			'LPAREN' => 372
		}
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 345
		ACTIONS => {
			'LPAREN' => 374
		}
	},
	{#State 346
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 375
		}
	},
	{#State 347
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 376
		}
	},
	{#State 348
		DEFAULT => -130
	},
	{#State 349
		ACTIONS => {
			";" => 377
		}
	},
	{#State 350
		ACTIONS => {
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			"]" => 378,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 351
		ACTIONS => {
			'LITERAL_STRING' => 379
		}
	},
	{#State 352
		DEFAULT => -105
	},
	{#State 353
		DEFAULT => -119
	},
	{#State 354
		DEFAULT => -80
	},
	{#State 355
		ACTIONS => {
			")" => 380
		}
	},
	{#State 356
		DEFAULT => -177
	},
	{#State 357
		DEFAULT => -176
	},
	{#State 358
		DEFAULT => -175
	},
	{#State 359
		ACTIONS => {
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP13_BITWISE_AND' => 186,
			"}" => -201,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -201,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => 180
		}
	},
	{#State 360
		DEFAULT => -205
	},
	{#State 361
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 92,
			"while" => -148,
			'OP01_PRINT' => 80,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'WORD_SCOPED' => 27,
			'SELF' => 83,
			'OP01_NAMED_VOID_LPAREN' => 85,
			"undef" => 84,
			"foreach" => -148,
			'LBRACKET' => 119,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_NAMED_VOID' => 123,
			"if" => 125,
			'OP05_LOGICAL_NEG' => 129,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 127,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'OP01_NAMED' => 101,
			'OP01_NAMED_VOID_SCOLON' => 100,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'VariableModification' => 86,
			'LoopLabel' => 82,
			'SubExpression' => 98,
			'HashDereference' => 115,
			'Expression' => 114,
			'Variable' => 88,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'OPTIONAL-37' => 87,
			'ArrayReference' => 122,
			'VariableDeclaration' => 90,
			'PLUS-42' => 381,
			'Conditional' => 118,
			'PAREN-36' => 117,
			'Operator' => 128,
			'Statement' => 96,
			'OperatorVoid' => 93,
			'Operation' => 382,
			'WordScoped' => 126,
			'HashReference' => 124,
			'Literal' => 91
		}
	},
	{#State 362
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 383
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 364
		DEFAULT => -61
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
		ACTIONS => {
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 390,
			'ArrayReference' => 122,
			'Literal' => 91,
			'HashReference' => 124,
			'HashDereference' => 115,
			'Operator' => 128,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126
		}
	},
	{#State 373
		ACTIONS => {
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 391,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'HashDereference' => 115,
			'Operator' => 128,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 374
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'MY' => 151,
			'OP01_QW' => 152,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'ARGV' => 146,
			"undef" => 84,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'SubExpression' => 150,
			'TypeInner' => 142,
			'ArrayReference' => 122,
			'Literal' => 91,
			'HashReference' => 124,
			'ListElements' => 392,
			'HashDereference' => 115,
			'ListElement' => 143,
			'Operator' => 128,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144
		}
	},
	{#State 375
		ACTIONS => {
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"undef" => 84,
			'FHREF_SYMBOL_IN' => 245,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'STDIN' => 247,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89
		},
		GOTOS => {
			'SubExpression' => 246,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'SubExpressionOrInput' => 393,
			'Literal' => 91,
			'Operator' => 128,
			'HashDereference' => 115,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110
		}
	},
	{#State 376
		DEFAULT => -167
	},
	{#State 377
		DEFAULT => -179
	},
	{#State 378
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 394
		}
	},
	{#State 379
		ACTIONS => {
			'OP21_LIST_COMMA' => 395
		}
	},
	{#State 380
		DEFAULT => -82
	},
	{#State 381
		ACTIONS => {
			"foreach" => -148,
			'SELF' => 83,
			'OP01_NAMED_VOID_LPAREN' => 85,
			"undef" => 84,
			'OP01_PRINT' => 80,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'MY' => 92,
			"while" => -148,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			"}" => 397,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 101,
			'OP01_NAMED_VOID_SCOLON' => 100,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 127,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_NAMED_VOID' => 123,
			"if" => 125,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119
		},
		GOTOS => {
			'OPTIONAL-37' => 87,
			'Variable' => 88,
			'Expression' => 114,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'HashDereference' => 115,
			'SubExpression' => 98,
			'LoopLabel' => 82,
			'VariableModification' => 86,
			'HashReference' => 124,
			'Literal' => 91,
			'WordScoped' => 126,
			'Statement' => 96,
			'OperatorVoid' => 93,
			'Operation' => 396,
			'Operator' => 128,
			'Conditional' => 118,
			'PAREN-36' => 117,
			'VariableDeclaration' => 90,
			'ArrayReference' => 122
		}
	},
	{#State 382
		DEFAULT => -170
	},
	{#State 383
		ACTIONS => {
			"for" => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP05_LOGICAL_NEG' => -159,
			"if" => -159,
			'OP01_NAMED_VOID' => -159,
			'OP03_MATH_INC_DEC' => -159,
			'WORD' => -159,
			'LBRACE' => -159,
			'LBRACKET' => -159,
			"else" => 402,
			"%{" => -159,
			'LITERAL_STRING' => -159,
			"elsif" => 400,
			'CONSTANT_CALL_SCOPED' => -159,
			'LITERAL_NUMBER' => -159,
			'LPAREN' => -159,
			'OP22_LOGICAL_NEG' => -159,
			"}" => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			'WORD_UPPERCASE' => -159,
			'OP01_CLOSE' => -159,
			'OP01_NAMED' => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			"\@{" => -159,
			'OP01_OPEN' => -159,
			"while" => -159,
			'MY' => -159,
			'VARIABLE_SYMBOL' => -159,
			'OP10_NAMED_UNARY' => -159,
			"foreach" => -159,
			'' => -159,
			"undef" => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			'SELF' => -159,
			'WORD_SCOPED' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'OP01_PRINT' => -159
		},
		GOTOS => {
			'OPTIONAL-41' => 398,
			'PAREN-38' => 399,
			'PAREN-40' => 401
		}
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 403
		}
	},
	{#State 385
		ACTIONS => {
			"}" => 406,
			'OP21_LIST_COMMA' => 405
		},
		GOTOS => {
			'PAREN-25' => 404
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
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 390
		ACTIONS => {
			'OP15_LOGICAL_AND' => 170,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			'OP17_LIST_RANGE' => 411,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 391
		ACTIONS => {
			'OP15_LOGICAL_AND' => 170,
			'OP23_LOGICAL_AND' => 175,
			";" => 412,
			'OP18_TERNARY' => 171,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 392
		ACTIONS => {
			")" => 413
		}
	},
	{#State 393
		ACTIONS => {
			")" => 414
		}
	},
	{#State 394
		ACTIONS => {
			"undef" => 415
		}
	},
	{#State 395
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'SELF' => 83,
			'OP01_NAMED' => 148
		},
		GOTOS => {
			'HashReference' => 124,
			'Literal' => 91,
			'HashDereference' => 115,
			'Operator' => 128,
			'Variable' => 153,
			'Expression' => 144,
			'WordScoped' => 126,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'SubExpression' => 416,
			'ArrayReference' => 122
		}
	},
	{#State 396
		DEFAULT => -169
	},
	{#State 397
		DEFAULT => -171
	},
	{#State 398
		DEFAULT => -160
	},
	{#State 399
		DEFAULT => -155
	},
	{#State 400
		ACTIONS => {
			'LPAREN' => 417
		}
	},
	{#State 401
		DEFAULT => -158
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 418
		}
	},
	{#State 403
		ACTIONS => {
			'OP10_NAMED_UNARY' => -68,
			"while" => -68,
			'MY' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP01_PRINT' => -68,
			'WORD_SCOPED' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'SELF' => -68,
			"undef" => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'LPAREN_MY' => 420,
			"foreach" => -68,
			'LBRACKET' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LBRACE' => -68,
			'WORD' => -68,
			'OP01_NAMED_VOID' => -68,
			"if" => -68,
			'OP19_LOOP_CONTROL' => -68,
			"for" => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_OPEN' => -68,
			"\@{" => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP01_NAMED' => -68,
			'WORD_UPPERCASE' => -68,
			'OP01_CLOSE' => -68,
			"}" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'LPAREN' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'LITERAL_NUMBER' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'LITERAL_STRING' => -68,
			"%{" => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 419,
			'MethodArguments' => 421
		}
	},
	{#State 404
		DEFAULT => -63
	},
	{#State 405
		ACTIONS => {
			'WORD' => 367
		},
		GOTOS => {
			'HashEntryProperties' => 422
		}
	},
	{#State 406
		ACTIONS => {
			";" => 423
		}
	},
	{#State 407
		DEFAULT => -204
	},
	{#State 408
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 57,
			'WORD' => 59
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
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83
		},
		GOTOS => {
			'HashDereference' => 115,
			'Operator' => 128,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Expression' => 144,
			'Variable' => 153,
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayReference' => 122,
			'SubExpression' => 426
		}
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 415
		ACTIONS => {
			";" => 430
		}
	},
	{#State 416
		ACTIONS => {
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			'OP15_LOGICAL_AND' => 170,
			'OP21_LIST_COMMA' => -83,
			";" => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP18_TERNARY' => 171,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP13_BITWISE_AND' => 186,
			"}" => -83,
			"]" => -83,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			")" => -83,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182
		}
	},
	{#State 417
		ACTIONS => {
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP03_MATH_INC_DEC' => 120,
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP01_OPEN' => 97,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_STRING' => 111,
			"%{" => 116
		},
		GOTOS => {
			'SubExpression' => 431,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'HashDereference' => 115,
			'Operator' => 128,
			'Expression' => 144,
			'Variable' => 153,
			'WordScoped' => 126,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113
		}
	},
	{#State 418
		DEFAULT => -157
	},
	{#State 419
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 432
		}
	},
	{#State 420
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 57,
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 433
		}
	},
	{#State 421
		DEFAULT => -67
	},
	{#State 422
		DEFAULT => -62
	},
	{#State 423
		DEFAULT => -65
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
			'OP18_TERNARY' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP07_STRING_REPEAT' => 179,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			")" => 435,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174
		}
	},
	{#State 427
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 436
		}
	},
	{#State 428
		DEFAULT => -166
	},
	{#State 429
		DEFAULT => -168
	},
	{#State 430
		DEFAULT => -180
	},
	{#State 431
		ACTIONS => {
			'OP15_LOGICAL_AND' => 170,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP11_COMPARE_LT_GT' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 182,
			")" => 437,
			'OP08_STRING_CAT' => 183,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 432
		ACTIONS => {
			"foreach" => -148,
			"undef" => 84,
			'OP01_NAMED_VOID_LPAREN' => 85,
			'SELF' => 83,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP01_PRINT' => 80,
			"while" => -148,
			'MY' => 92,
			'VARIABLE_SYMBOL' => 94,
			'OP10_NAMED_UNARY' => 89,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'OP22_LOGICAL_NEG' => 109,
			"}" => 438,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP01_NAMED_VOID_SCOLON' => 100,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			'OP19_LOOP_CONTROL' => 127,
			"for" => -148,
			'OP05_LOGICAL_NEG' => 129,
			"if" => 125,
			'OP01_NAMED_VOID' => 123,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119
		},
		GOTOS => {
			'Conditional' => 118,
			'PAREN-36' => 117,
			'VariableDeclaration' => 90,
			'ArrayReference' => 122,
			'HashReference' => 124,
			'Literal' => 91,
			'Operator' => 128,
			'Operation' => 439,
			'Statement' => 96,
			'OperatorVoid' => 93,
			'WordScoped' => 126,
			'SubExpression' => 98,
			'VariableModification' => 86,
			'LoopLabel' => 82,
			'OPTIONAL-37' => 87,
			'HashDereference' => 115,
			'Expression' => 114,
			'Variable' => 88,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110
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
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 436
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'OP05_LOGICAL_NEG' => 129,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'LBRACKET' => 119,
			'OP10_NAMED_UNARY' => 89,
			'LITERAL_STRING' => 111,
			"%{" => 116,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LPAREN' => 108,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 27,
			"\@{" => 99
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'SubExpression' => 443,
			'ArrayReference' => 122
		}
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 444
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
			'OP02_ARRAY_THINARROW' => 447,
			'OP19_VARIABLE_ASSIGN' => 448
		}
	},
	{#State 442
		DEFAULT => -164
	},
	{#State 443
		ACTIONS => {
			'OP15_LOGICAL_AND' => 170,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			";" => 449,
			'OP09_BITWISE_SHIFT' => 176,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP07_STRING_REPEAT' => 179,
			'OP11_COMPARE_LT_GT' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 444
		DEFAULT => -154
	},
	{#State 445
		DEFAULT => -71
	},
	{#State 446
		ACTIONS => {
			'OP21_LIST_COMMA' => 451,
			")" => 452
		},
		GOTOS => {
			'PAREN-29' => 450
		}
	},
	{#State 447
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97,
			"undef" => 84,
			'WORD_UPPERCASE' => 147,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'ArrayReference' => 122,
			'SubExpression' => 453,
			'Operator' => 128,
			'HashDereference' => 115,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'Variable' => 153,
			'WordScoped' => 126,
			'Expression' => 144,
			'Literal' => 91,
			'HashReference' => 124
		}
	},
	{#State 448
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			'LBRACE' => 121,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 99,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 97,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			"undef" => 84,
			'OP01_NAMED' => 148,
			'SELF' => 83,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			"%{" => 116,
			'LITERAL_STRING' => 111
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'ArrayDereference' => 113,
			'VariableSymbolOrSelf' => 110,
			'WordScoped' => 126,
			'Variable' => 153,
			'Expression' => 144,
			'HashDereference' => 115,
			'Operator' => 128,
			'SubExpression' => 454,
			'ArrayReference' => 122
		}
	},
	{#State 449
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 129,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 120,
			'WORD' => 28,
			'LBRACE' => 121,
			'OP10_NAMED_UNARY' => 89,
			'LBRACKET' => 119,
			"%{" => 116,
			'LITERAL_STRING' => 111,
			'LITERAL_NUMBER' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 105,
			"undef" => 84,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 147,
			'SELF' => 83,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 27,
			"\@{" => 99,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'Literal' => 91,
			'HashReference' => 124,
			'Operator' => 128,
			'HashDereference' => 115,
			'VariableSymbolOrSelf' => 110,
			'ArrayDereference' => 113,
			'WordScoped' => 126,
			'Variable' => 88,
			'Expression' => 144,
			'SubExpression' => 455,
			'VariableModification' => 456,
			'SubExpressionOrVarMod' => 457,
			'ArrayReference' => 122
		}
	},
	{#State 450
		DEFAULT => -73
	},
	{#State 451
		ACTIONS => {
			'MY' => 458
		}
	},
	{#State 452
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 459
		}
	},
	{#State 453
		ACTIONS => {
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP04_MATH_POW' => 182,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			"]" => 460,
			'OP11_COMPARE_LT_GT' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 179,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP18_TERNARY' => 171,
			'OP23_LOGICAL_AND' => 175,
			'OP15_LOGICAL_AND' => 170
		}
	},
	{#State 454
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 182,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 186,
			"}" => -221,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP21_LIST_COMMA' => -221,
			'OP15_LOGICAL_AND' => 170,
			'OP11_COMPARE_LT_GT' => 180,
			'OP07_STRING_REPEAT' => 179,
			'OP16_LOGICAL_OR' => 177,
			'OP14_BITWISE_OR_XOR' => 178,
			'OP09_BITWISE_SHIFT' => 176
		}
	},
	{#State 455
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 178,
			'OP16_LOGICAL_OR' => 177,
			'OP07_STRING_REPEAT' => 179,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 180,
			'OP15_LOGICAL_AND' => 170,
			'OP23_LOGICAL_AND' => 175,
			'OP18_TERNARY' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP06_REGEX_MATCH' => 174,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP13_BITWISE_AND' => 186,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_STRING_CAT' => 183,
			")" => -144,
			'OP04_MATH_POW' => 182
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
			'WORD' => 59,
			'TYPE_INTEGER' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 462
		}
	},
	{#State 459
		ACTIONS => {
			"\@_;" => 463
		}
	},
	{#State 460
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 464
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 361
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 462
		ACTIONS => {
			'VARIABLE_SYMBOL' => 466
		}
	},
	{#State 463
		DEFAULT => -75
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
