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

#line 1 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.000_901;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|for\ my\ integer|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|while\ \(|elsif\ \(|package|\$TYPED_|\=\ sub\ \{|undef|\(\ my|if\ \(|else|qw\(|our|\@_\;|use|\@\{|\%\{|\.\.|my|\;|\]|\}|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FILEHANDLE_REF_SYMBOL', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(\{\*STDIN\}|\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDIN_STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN_PROMPT', $1);
      /\G(or|xor)/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NOT', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next|last)/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NEQ', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(::[a-zA-Z]\w*__stringify)/gc and return ('OP10_NAMED_UNARY_STRINGIFY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(m\/.*\/xms)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<|>|<=|>=|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(print)/gc and return ('OP01_PRINT_VOID', $1);
      /\G(croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_QW', $1);
      /\G(open)/gc and return ('OP01_OPEN', $1);
      /\G(close)/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|ETC)/gc and return ('OP01_NAMED', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G(([a-zA-Z]\w*(::[a-zA-Z]\w*)+)|(::[a-zA-Z]\w*(::[a-zA-Z]\w*)*))/gc and return ('WORD_SCOPED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);
      /\G:/gc and return ('COLON', $1);
      /\G\(/gc and return ('LEFT_PAREN', $1);
      /\G\[/gc and return ('LEFT_BRACKET', $1);
      /\G\{/gc and return ('LEFT_BRACE', $1);


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


#line 123 lib/RPerl/Grammar.pm

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
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ 'ModuleHeader_21' => 'ModuleHeader', [ 'OPTIONAL-9', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_22' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_23' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [ 'STAR-10', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [ 'STAR-12', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Subroutine' ], 0 ],
  [ 'Package_32' => 'Package', [ 'STAR-10', 'STAR-11', 'STAR-12', 'PLUS-13', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'Header_33' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'PLUS-14', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'WORD' ], 0 ],
  [ 'Critic_36' => 'Critic', [ '## no critic qw(', 'PLUS-14', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'PLUS-15', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'WORD' ], 0 ],
  [ 'Include_39' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_40' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-15', ')', ';' ], 0 ],
  [ 'Constant_41' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'Operation' ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'PLUS-17', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'PAREN-18' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ 'SubroutineArguments_50' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'PropertiesClass' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ 'Class_61' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-20', 'STAR-21', 'STAR-22', 'Properties', 'OPTIONAL-23', 'STAR-24', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'PAREN-25' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ 'Properties_65' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-26', ')', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
  [ '_PAREN' => 'PAREN-27', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'PAREN-27' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'PropertiesClass_70' => 'PropertiesClass', [ 'our %properties_class = (', 'Critic', 'HashEntryTyped', 'STAR-28', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-30', [ 'PLUS-30', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-30', [ 'Operation' ], 0 ],
  [ 'Method_75' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-29', 'PLUS-30', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'PAREN-31' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'MethodArguments_79' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-32', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_80' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_81' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_82' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_83' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'LEFT_PAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_OPEN', 'FileHandleOpen', 'OP21_LIST_COMMA', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_CLOSE', 'FileHandleClose' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_MATH_NEG', 'SubExpression', ')' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NEQ', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP22_LOGICAL_NOT', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-33', ';' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandlePrint', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_121' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_122' => 'Expression', [ 'WordScoped', 'LEFT_PAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_123' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LEFT_PAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'SubExpression_124' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_125' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_126' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_127' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'LEFT_BRACE', '}' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'LEFT_PAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrPrompt_134' => 'SubExpressionOrPrompt', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrPrompt_135' => 'SubExpressionOrPrompt', [ 'STDIN_PROMPT' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_139' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_140' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_150' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_151' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_152' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_154' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'SubExpression', '..', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_155' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_156' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_159' => 'CodeBlock', [ 'LEFT_BRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_162' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_163' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_164' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_166' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_167' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrPrompt', ';' ], 0 ],
  [ 'VariableModification_168' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrPrompt', ';' ], 0 ],
  [ 'VariableModification_169' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-46', [ 'PLUS-46', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-46', [ 'WORD' ], 0 ],
  [ 'ListElements_175' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElements_176' => 'ListElements', [ 'OP01_QW', 'LEFT_PAREN', 'PLUS-46', ')' ], 0 ],
  [ 'ListElement_177' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_178' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayReference_182' => 'ArrayReference', [ 'LEFT_BRACKET', 'OPTIONAL-47', ']' ], 0 ],
  [ 'ArrayDereferenced_183' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_184' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_187' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_188' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_189' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_190' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_194' => 'HashReference', [ 'LEFT_BRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashDereferenced_195' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_196' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_197' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_198' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_199' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_200' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_201' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandleOpen_202' => 'FileHandleOpen', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandleOpen_203' => 'FileHandleOpen', [ 'my', 'filehandle_ref', 'FILEHANDLE_REF_SYMBOL' ], 0 ],
  [ 'FileHandleClose_204' => 'FileHandleClose', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandleClose_205' => 'FileHandleClose', [ 'FILEHANDLE_REF_SYMBOL' ], 0 ],
  [ 'FileHandlePrint_206' => 'FileHandlePrint', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandlePrint_207' => 'FileHandlePrint', [ 'LEFT_BRACE', 'FILEHANDLE_REF_SYMBOL', '}' ], 0 ],
  [ 'Literal_208' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_209' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'ModuleHeader_21' => 21,
  'Module_22' => 22,
  'Module_23' => 23,
  '_STAR_LIST' => 24,
  '_STAR_LIST' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_STAR_LIST' => 28,
  '_STAR_LIST' => 29,
  '_PLUS_LIST' => 30,
  '_PLUS_LIST' => 31,
  'Package_32' => 32,
  'Header_33' => 33,
  '_PLUS_LIST' => 34,
  '_PLUS_LIST' => 35,
  'Critic_36' => 36,
  '_PLUS_LIST' => 37,
  '_PLUS_LIST' => 38,
  'Include_39' => 39,
  'Include_40' => 40,
  'Constant_41' => 41,
  '_OPTIONAL' => 42,
  '_OPTIONAL' => 43,
  '_PLUS_LIST' => 44,
  '_PLUS_LIST' => 45,
  'Subroutine_46' => 46,
  '_PAREN' => 47,
  '_STAR_LIST' => 48,
  '_STAR_LIST' => 49,
  'SubroutineArguments_50' => 50,
  '_STAR_LIST' => 51,
  '_STAR_LIST' => 52,
  '_STAR_LIST' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_OPTIONAL' => 57,
  '_OPTIONAL' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'Class_61' => 61,
  '_PAREN' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  'Properties_65' => 65,
  'Properties_66' => 66,
  '_PAREN' => 67,
  '_STAR_LIST' => 68,
  '_STAR_LIST' => 69,
  'PropertiesClass_70' => 70,
  '_OPTIONAL' => 71,
  '_OPTIONAL' => 72,
  '_PLUS_LIST' => 73,
  '_PLUS_LIST' => 74,
  'Method_75' => 75,
  '_PAREN' => 76,
  '_STAR_LIST' => 77,
  '_STAR_LIST' => 78,
  'MethodArguments_79' => 79,
  'MethodOrSubroutine_80' => 80,
  'MethodOrSubroutine_81' => 81,
  'Operation_82' => 82,
  'Operation_83' => 83,
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
  '_OPTIONAL' => 111,
  '_OPTIONAL' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  'Expression_121' => 121,
  'Expression_122' => 122,
  'Expression_123' => 123,
  'SubExpression_124' => 124,
  'SubExpression_125' => 125,
  'SubExpression_126' => 126,
  'SubExpression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpressionOrPrompt_134' => 134,
  'SubExpressionOrPrompt_135' => 135,
  '_PAREN' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  'Statement_139' => 139,
  'Statement_140' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  '_PAREN' => 144,
  '_STAR_LIST' => 145,
  '_STAR_LIST' => 146,
  '_PAREN' => 147,
  '_OPTIONAL' => 148,
  '_OPTIONAL' => 149,
  'Conditional_150' => 150,
  'Loop_151' => 151,
  'Loop_152' => 152,
  'Loop_153' => 153,
  'LoopFor_154' => 154,
  'LoopForEach_155' => 155,
  'LoopWhile_156' => 156,
  '_PLUS_LIST' => 157,
  '_PLUS_LIST' => 158,
  'CodeBlock_159' => 159,
  '_STAR_LIST' => 160,
  '_STAR_LIST' => 161,
  'Variable_162' => 162,
  'VariableRetrieval_163' => 163,
  'VariableRetrieval_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableDeclaration_166' => 166,
  'VariableDeclaration_167' => 167,
  'VariableModification_168' => 168,
  'VariableModification_169' => 169,
  '_PAREN' => 170,
  '_STAR_LIST' => 171,
  '_STAR_LIST' => 172,
  '_PLUS_LIST' => 173,
  '_PLUS_LIST' => 174,
  'ListElements_175' => 175,
  'ListElements_176' => 176,
  'ListElement_177' => 177,
  'ListElement_178' => 178,
  'ListElement_179' => 179,
  '_OPTIONAL' => 180,
  '_OPTIONAL' => 181,
  'ArrayReference_182' => 182,
  'ArrayDereferenced_183' => 183,
  'ArrayDereferenced_184' => 184,
  '_OPTIONAL' => 185,
  '_OPTIONAL' => 186,
  'HashEntry_187' => 187,
  'HashEntry_188' => 188,
  'HashEntryTyped_189' => 189,
  'HashEntryTyped_190' => 190,
  '_PAREN' => 191,
  '_STAR_LIST' => 192,
  '_STAR_LIST' => 193,
  'HashReference_194' => 194,
  'HashDereferenced_195' => 195,
  'HashDereferenced_196' => 196,
  'WordScoped_197' => 197,
  'WordScoped_198' => 198,
  'LoopLabel_199' => 199,
  'Type_200' => 200,
  'TypeInner_201' => 201,
  'FileHandleOpen_202' => 202,
  'FileHandleOpen_203' => 203,
  'FileHandleClose_204' => 204,
  'FileHandleClose_205' => 205,
  'FileHandlePrint_206' => 206,
  'FileHandlePrint_207' => 207,
  'Literal_208' => 208,
  'Literal_209' => 209,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif (' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our %properties = (' => { ISSEMANTIC => 0 },
	'our %properties_class = (' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use RPerl;' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
	'while (' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	COLON => { ISSEMANTIC => 1 },
	FILEHANDLE_REF_SYMBOL => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LEFT_BRACE => { ISSEMANTIC => 1 },
	LEFT_BRACKET => { ISSEMANTIC => 1 },
	LEFT_PAREN => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_OPEN => { ISSEMANTIC => 1 },
	OP01_PRINT_VOID => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP03_MATH_INC_DEC => { ISSEMANTIC => 1 },
	OP04_MATH_POW => { ISSEMANTIC => 1 },
	OP05_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP05_MATH_NEG => { ISSEMANTIC => 1 },
	OP06_REGEX_MATCH => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY_STRINGIFY => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NEQ => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN_BY => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NOT => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN_PROMPT => { ISSEMANTIC => 1 },
	STDIN_STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER_ASSIGN => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 2,
			'SHEBANG' => 6
		},
		GOTOS => {
			'CompileUnit' => 3,
			'PAREN-1' => 8,
			'PLUS-2' => 1,
			'Program' => 5,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 9,
			'Critic' => 7
		}
	},
	{#State 1
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 2,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'ModuleHeader' => 4,
			'PAREN-1' => 10,
			'Critic' => 7
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-14' => 11
		}
	},
	{#State 3
		ACTIONS => {
			'' => 13
		}
	},
	{#State 4
		ACTIONS => {
			"our" => -25,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use parent qw(" => 15,
			"use" => -25
		},
		GOTOS => {
			'Class' => 16,
			'STAR-10' => 17,
			'Package' => 14,
			'Module' => 18
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 19,
			'OPTIONAL-3' => 20
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'WORD' => 22,
			")" => 23
		}
	},
	{#State 12
		DEFAULT => -35
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 16
		DEFAULT => -23
	},
	{#State 17
		ACTIONS => {
			"## no critic qw(" => 2,
			"our" => -27,
			"use" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 28,
			'Critic' => 27
		}
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -36
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		DEFAULT => -197
	},
	{#State 26
		DEFAULT => -198
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			"use" => 34,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 33,
			'Include' => 35
		}
	},
	{#State 29
		ACTIONS => {
			"use warnings;" => 36
		}
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => 40,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 44,
			'PLUS-13' => 43,
			'Constant' => 41
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			"use RPerl;" => 46
		}
	},
	{#State 37
		ACTIONS => {
			'OP01_NAMED_VOID' => -11,
			'OP01_PRINT_VOID' => -11,
			"use constant" => -11,
			"my" => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED' => -11,
			"foreach my" => -11,
			'OP05_MATH_NEG' => -11,
			'WORD_SCOPED' => -11,
			'OP01_OPEN' => -11,
			'WORD' => -11,
			"undef" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"for my integer" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 2,
			'OP03_MATH_INC_DEC' => -11,
			"if (" => -11,
			"while (" => -11,
			'LEFT_PAREN' => -11,
			'LEFT_BRACKET' => -11,
			'LITERAL_NUMBER' => -11,
			'LITERAL_STRING' => -11,
			'LEFT_BRACE' => -11,
			"\@{" => -11,
			"use" => -11,
			"%{" => -11,
			'OP01_CLOSE' => -11
		},
		GOTOS => {
			'STAR-5' => 47,
			'Critic' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 51
		}
	},
	{#State 41
		DEFAULT => -28
	},
	{#State 42
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 54
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 44
		DEFAULT => -31
	},
	{#State 45
		ACTIONS => {
			";" => 57,
			"qw(" => 56
		}
	},
	{#State 46
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 47
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -13,
			"for my integer" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LITERAL_STRING' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_CLOSE' => -13,
			"use" => 34,
			"%{" => -13,
			'LEFT_BRACE' => -13,
			"\@{" => -13,
			'LEFT_PAREN' => -13,
			"while (" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"if (" => -13,
			'LEFT_BRACKET' => -13,
			"our" => -13,
			"my" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT_VOID' => -13,
			'OP01_NAMED_VOID' => -13,
			"use constant" => -13,
			'WORD' => -13,
			'OP01_OPEN' => -13,
			'WORD_SCOPED' => -13,
			'OP05_MATH_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			"undef" => -13,
			'OP01_NAMED' => -13,
			"foreach my" => -13
		},
		GOTOS => {
			'STAR-6' => 59,
			'Include' => 60
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 62
		}
	},
	{#State 52
		DEFAULT => -200
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 54
		ACTIONS => {
			";" => 64
		}
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 57
		DEFAULT => -39
	},
	{#State 58
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 67
		}
	},
	{#State 59
		ACTIONS => {
			"if (" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			"while (" => -15,
			'LEFT_PAREN' => -15,
			'LEFT_BRACKET' => -15,
			"foreach my" => -15,
			'OP05_MATH_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			'OP01_OPEN' => -15,
			'LEFT_BRACE' => -15,
			"\@{" => -15,
			"undef" => -15,
			"%{" => -15,
			'OP01_CLOSE' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_PRINT_VOID' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP22_LOGICAL_NOT' => -15,
			"use constant" => 40,
			"my" => -15,
			"our" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"for my integer" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 69,
			'Constant' => 68
		}
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			"## no critic qw(" => 2,
			"use constant" => -54,
			"use" => -54,
			"our %properties = (" => -54
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 72
		}
	},
	{#State 63
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		ACTIONS => {
			'WORD' => 76,
			")" => 75
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'WORD' => 108,
			'LITERAL_STRING' => 83,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP03_MATH_INC_DEC' => 79,
			"if (" => 80,
			'OP01_NAMED' => 105,
			"while (" => -138,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			"foreach my" => -138,
			"my" => 119,
			"our" => 42,
			"for my integer" => -138,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_NAMED_VOID' => 114,
			'OP01_PRINT_VOID' => 115,
			'OP19_LOOP_CONTROL' => 97,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Variable' => 82,
			'VariableModification' => 106,
			'Statement' => 104,
			'PLUS-8' => 77,
			'ArrayReference' => 111,
			'SubExpression' => 84,
			'LoopLabel' => 86,
			'PAREN-36' => 117,
			'Conditional' => 116,
			'OperatorVoid' => 98,
			'OPTIONAL-37' => 95,
			'HashReference' => 93,
			'VariableDeclaration' => 94,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92,
			'Operation' => 100,
			'HashDereferenced' => 120,
			'Subroutine' => 102,
			'Expression' => 99,
			'Operator' => 118
		}
	},
	{#State 70
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 34,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 123,
			'Include' => 122
		}
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83
		},
		GOTOS => {
			'Literal' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 125
		}
	},
	{#State 74
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_PRINT_VOID' => -43,
			"for my integer" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"my" => -43,
			'LEFT_BRACKET' => -43,
			"foreach my" => -43,
			"( my" => 128,
			"if (" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED' => -43,
			'LEFT_PAREN' => -43,
			"while (" => -43,
			"\@{" => -43,
			'LEFT_BRACE' => -43,
			"undef" => -43,
			"%{" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_CLOSE' => -43,
			'OP05_MATH_NEG' => -43,
			'LITERAL_NUMBER' => -43,
			'WORD_SCOPED' => -43,
			'OP01_OPEN' => -43,
			'LITERAL_STRING' => -43,
			'WORD' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 126,
			'OPTIONAL-16' => 127
		}
	},
	{#State 75
		ACTIONS => {
			";" => 129
		}
	},
	{#State 76
		DEFAULT => -37
	},
	{#State 77
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP19_LOOP_CONTROL' => 97,
			'OP01_PRINT_VOID' => 115,
			'OP01_NAMED_VOID' => 114,
			'OP05_LOGICAL_NEG' => 101,
			"for my integer" => -138,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			"my" => 119,
			'' => -18,
			'LEFT_BRACKET' => 81,
			"foreach my" => -138,
			'LEFT_PAREN' => 78,
			"while (" => -138,
			'OP03_MATH_INC_DEC' => 79,
			"if (" => 80,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 108,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'SubExpression' => 84,
			'LoopLabel' => 86,
			'ArrayReference' => 111,
			'Statement' => 104,
			'VariableModification' => 106,
			'Variable' => 82,
			'Operator' => 118,
			'Expression' => 99,
			'HashDereferenced' => 120,
			'Operation' => 130,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'VariableDeclaration' => 94,
			'HashReference' => 93,
			'OPTIONAL-37' => 95,
			'OperatorVoid' => 98,
			'PAREN-36' => 117,
			'Conditional' => 116
		}
	},
	{#State 78
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 134,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 133,
			'Expression' => 131,
			'Operator' => 118
		}
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 135
		}
	},
	{#State 80
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109
		},
		GOTOS => {
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'Variable' => 132,
			'SubExpression' => 136,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120
		}
	},
	{#State 81
		ACTIONS => {
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP01_QW' => 141,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			"]" => -181,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 73,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'TypeInner' => 138,
			'Variable' => 132,
			'ListElements' => 143,
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 142,
			'Expression' => 131,
			'OPTIONAL-47' => 137,
			'ListElement' => 140,
			'Operator' => 118
		}
	},
	{#State 82
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 144,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP18_TERNARY' => -127,
			'OP08_STRING_CAT' => -127,
			'OP19_VARIABLE_ASSIGN' => 145,
			'OP23_LOGICAL_AND' => -127,
			'OP04_MATH_POW' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP03_MATH_INC_DEC' => 146,
			'OP13_BITWISE_AND' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP19_VARIABLE_ASSIGN_BY' => 147
		}
	},
	{#State 83
		DEFAULT => -208
	},
	{#State 84
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP04_MATH_POW' => 155,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161
		}
	},
	{#State 85
		DEFAULT => -209
	},
	{#State 86
		ACTIONS => {
			'COLON' => 164
		}
	},
	{#State 87
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'LEFT_BRACE' => 167
		},
		GOTOS => {
			'Variable' => 166,
			'HashReference' => 165
		}
	},
	{#State 88
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 168,
			'STDIN_STDOUT_STDERR' => 169
		},
		GOTOS => {
			'FileHandleClose' => 170
		}
	},
	{#State 89
		ACTIONS => {
			"%{" => 87,
			'WORD' => 172,
			"}" => 173
		},
		GOTOS => {
			'HashDereferenced' => 171,
			'HashEntry' => 174
		}
	},
	{#State 90
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 175,
			'ArrayReference' => 176
		}
	},
	{#State 91
		DEFAULT => -126
	},
	{#State 92
		ACTIONS => {
			'LEFT_PAREN' => 177
		}
	},
	{#State 93
		DEFAULT => -130
	},
	{#State 94
		DEFAULT => -142
	},
	{#State 95
		ACTIONS => {
			"while (" => 178,
			"for my integer" => 181,
			"foreach my" => 182
		},
		GOTOS => {
			'Loop' => 180,
			'LoopWhile' => 183,
			'LoopForEach' => 184,
			'LoopFor' => 179
		}
	},
	{#State 96
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103
		},
		GOTOS => {
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'Expression' => 131,
			'SubExpression' => 185,
			'Operator' => 118
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => 186
		},
		GOTOS => {
			'LoopLabel' => 187
		}
	},
	{#State 98
		DEFAULT => -141
	},
	{#State 99
		ACTIONS => {
			'OP06_REGEX_MATCH' => -124,
			";" => 188,
			'OP16_LOGICAL_OR' => -124,
			'OP14_BITWISE_OR_XOR' => -124,
			'OP15_LOGICAL_AND' => -124,
			'OP11_COMPARE_LT_GT' => -124,
			'OP13_BITWISE_AND' => -124,
			'OP08_MATH_ADD_SUB' => -124,
			'OP12_COMPARE_EQ_NEQ' => -124,
			'OP04_MATH_POW' => -124,
			'OP18_TERNARY' => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP08_STRING_CAT' => -124,
			'OP09_BITWISE_SHIFT' => -124,
			'OP07_MATH_MULT_DIV_MOD' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => -124
		}
	},
	{#State 100
		DEFAULT => -17
	},
	{#State 101
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 189,
			'Expression' => 131,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91
		}
	},
	{#State 102
		DEFAULT => -14
	},
	{#State 103
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 190,
			'Variable' => 132,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93
		}
	},
	{#State 104
		DEFAULT => -83
	},
	{#State 105
		ACTIONS => {
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'Variable' => 132,
			'SubExpression' => 191,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120
		}
	},
	{#State 106
		DEFAULT => -143
	},
	{#State 107
		ACTIONS => {
			"my" => 192,
			'STDIN_STDOUT_STDERR' => 194
		},
		GOTOS => {
			'FileHandleOpen' => 193
		}
	},
	{#State 108
		ACTIONS => {
			'LEFT_PAREN' => -197,
			'COLON' => -199
		}
	},
	{#State 109
		ACTIONS => {
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103
		},
		GOTOS => {
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'Variable' => 132,
			'Expression' => 131,
			'SubExpression' => 195,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120
		}
	},
	{#State 110
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Operator' => 118,
			'SubExpression' => 196,
			'Expression' => 131,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93,
			'Variable' => 132
		}
	},
	{#State 111
		DEFAULT => -128
	},
	{#State 112
		DEFAULT => -125
	},
	{#State 113
		DEFAULT => -129
	},
	{#State 114
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'OP01_QW' => 141,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_NUMBER' => 85,
			";" => -112,
			'OP05_MATH_NEG' => 109,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			"my" => 73
		},
		GOTOS => {
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 142,
			'ListElement' => 140,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93,
			'ListElements' => 198,
			'OPTIONAL-33' => 197,
			'Variable' => 132,
			'TypeInner' => 138
		}
	},
	{#State 115
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			"my" => 73,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'OP01_QW' => 141,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'STDIN_STDOUT_STDERR' => 202,
			"\@{" => 90,
			'LEFT_BRACE' => 201,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109
		},
		GOTOS => {
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Variable' => 132,
			'TypeInner' => 138,
			'ListElements' => 200,
			'Expression' => 131,
			'SubExpression' => 142,
			'ListElement' => 140,
			'Operator' => 118,
			'ArrayReference' => 111,
			'FileHandlePrint' => 199,
			'HashDereferenced' => 120
		}
	},
	{#State 116
		DEFAULT => -139
	},
	{#State 117
		DEFAULT => -137
	},
	{#State 118
		DEFAULT => -121
	},
	{#State 119
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 203
		}
	},
	{#State 120
		DEFAULT => -131
	},
	{#State 121
		DEFAULT => -161,
		GOTOS => {
			'STAR-43' => 204
		}
	},
	{#State 122
		DEFAULT => -53
	},
	{#State 123
		ACTIONS => {
			"our %properties = (" => 207,
			"use constant" => 40
		},
		GOTOS => {
			'Properties' => 206,
			'Constant' => 205
		}
	},
	{#State 124
		ACTIONS => {
			";" => 208
		}
	},
	{#State 125
		ACTIONS => {
			"\$TYPED_" => 209
		}
	},
	{#State 126
		DEFAULT => -42
	},
	{#State 127
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			"for my integer" => -138,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			"my" => 119,
			'OP22_LOGICAL_NOT' => 96,
			'OP19_LOOP_CONTROL' => 97,
			'OP01_PRINT_VOID' => 115,
			'OP01_NAMED_VOID' => 114,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP01_OPEN' => 107,
			'WORD' => 108,
			'LITERAL_STRING' => 83,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			"foreach my" => -138,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			"while (" => -138,
			'OP01_NAMED' => 105,
			"if (" => 80,
			'OP03_MATH_INC_DEC' => 79
		},
		GOTOS => {
			'HashReference' => 93,
			'VariableDeclaration' => 94,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'Conditional' => 116,
			'PAREN-36' => 117,
			'OperatorVoid' => 98,
			'OPTIONAL-37' => 95,
			'PLUS-17' => 211,
			'Expression' => 99,
			'Operator' => 118,
			'Operation' => 210,
			'HashDereferenced' => 120,
			'Statement' => 104,
			'VariableModification' => 106,
			'Variable' => 82,
			'LoopLabel' => 86,
			'SubExpression' => 84,
			'ArrayReference' => 111
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 129
		DEFAULT => -40
	},
	{#State 130
		DEFAULT => -16
	},
	{#State 131
		DEFAULT => -124
	},
	{#State 132
		ACTIONS => {
			'OP16_LOGICAL_OR' => -127,
			";" => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			".." => -127,
			'OP21_LIST_COMMA' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP03_MATH_INC_DEC' => 146,
			'OP15_LOGICAL_AND' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP13_BITWISE_AND' => -127,
			"}" => -127,
			'OP04_MATH_POW' => -127,
			'OP18_TERNARY' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP08_STRING_CAT' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			"]" => -127,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP02_METHOD_THINARROW' => 144,
			")" => -127,
			'OP17_LIST_RANGE' => -127,
			'OP24_LOGICAL_OR_XOR' => -127
		}
	},
	{#State 133
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP04_MATH_POW' => 155,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => 213,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 73,
			'OP22_LOGICAL_NOT' => 96,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78
		},
		GOTOS => {
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'HashReference' => 93,
			'TypeInner' => 138,
			'Variable' => 132,
			'Operator' => 118,
			'ListElement' => 214,
			'SubExpression' => 215,
			'Expression' => 131,
			'HashDereferenced' => 120,
			'ArrayReference' => 111
		}
	},
	{#State 135
		DEFAULT => -88
	},
	{#State 136
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 154,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP04_MATH_POW' => 155,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			")" => 216,
			'OP07_MATH_MULT_DIV_MOD' => 153
		}
	},
	{#State 137
		ACTIONS => {
			"]" => 217
		}
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'Expression' => 131,
			'SubExpression' => 218,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92
		}
	},
	{#State 139
		ACTIONS => {
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 219
		}
	},
	{#State 140
		DEFAULT => -172,
		GOTOS => {
			'STAR-45' => 220
		}
	},
	{#State 141
		ACTIONS => {
			'LEFT_PAREN' => 221
		}
	},
	{#State 142
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -177,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -177,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			";" => -177,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP21_LIST_COMMA' => -177,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 143
		DEFAULT => -180
	},
	{#State 144
		ACTIONS => {
			'WORD' => 222
		}
	},
	{#State 145
		ACTIONS => {
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'STDIN_PROMPT' => 224,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Expression' => 131,
			'SubExpression' => 223,
			'Operator' => 118,
			'SubExpressionOrPrompt' => 225,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Variable' => 132
		}
	},
	{#State 146
		DEFAULT => -89
	},
	{#State 147
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'SubExpression' => 226,
			'Expression' => 131,
			'Variable' => 132,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'HashReference' => 93
		}
	},
	{#State 148
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Expression' => 131,
			'SubExpression' => 227,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Variable' => 132
		}
	},
	{#State 149
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112
		},
		GOTOS => {
			'Expression' => 131,
			'SubExpression' => 228,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Variable' => 132
		}
	},
	{#State 150
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP22_LOGICAL_NOT' => 96,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'LEFT_PAREN' => 78,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_BRACKET' => 81
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'Expression' => 131,
			'SubExpression' => 229,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92
		}
	},
	{#State 151
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 230,
			'Variable' => 132,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'HashReference' => 93
		}
	},
	{#State 152
		ACTIONS => {
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 231,
			'Expression' => 131,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92
		}
	},
	{#State 153
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'SubExpression' => 232,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Variable' => 132
		}
	},
	{#State 154
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88
		},
		GOTOS => {
			'Variable' => 132,
			'HashReference' => 93,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'Expression' => 131,
			'SubExpression' => 233,
			'Operator' => 118
		}
	},
	{#State 155
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105
		},
		GOTOS => {
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'HashReference' => 93,
			'Variable' => 132,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 234,
			'HashDereferenced' => 120,
			'ArrayReference' => 111
		}
	},
	{#State 156
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105
		},
		GOTOS => {
			'Operator' => 118,
			'SubExpression' => 235,
			'Expression' => 131,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93,
			'Variable' => 132
		}
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 236
		}
	},
	{#State 158
		ACTIONS => {
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 237,
			'Variable' => 132,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93
		}
	},
	{#State 159
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79
		},
		GOTOS => {
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'Variable' => 132,
			'SubExpression' => 238,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120
		}
	},
	{#State 160
		ACTIONS => {
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'LEFT_PAREN' => 78,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_BRACKET' => 81,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'SubExpression' => 239,
			'Expression' => 131,
			'Variable' => 132,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'HashReference' => 93
		}
	},
	{#State 161
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 240,
			'Expression' => 131,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91
		}
	},
	{#State 162
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 241
		}
	},
	{#State 163
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'HashReference' => 93,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 242
		}
	},
	{#State 164
		DEFAULT => -136
	},
	{#State 165
		ACTIONS => {
			"}" => 243
		}
	},
	{#State 166
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => 172,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 171,
			'HashEntry' => 174
		}
	},
	{#State 168
		DEFAULT => -205
	},
	{#State 169
		DEFAULT => -204
	},
	{#State 170
		DEFAULT => -87
	},
	{#State 171
		DEFAULT => -188
	},
	{#State 172
		ACTIONS => {
			'OP20_HASH_FATARROW' => 245
		}
	},
	{#State 173
		DEFAULT => -132
	},
	{#State 174
		DEFAULT => -193,
		GOTOS => {
			'STAR-50' => 246
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 247
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 177
		ACTIONS => {
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP01_QW' => 141,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 73,
			'OP22_LOGICAL_NOT' => 96,
			")" => -118
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 142,
			'ListElement' => 140,
			'OPTIONAL-34' => 250,
			'ListElements' => 249,
			'Variable' => 132,
			'TypeInner' => 138,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'HashReference' => 93
		}
	},
	{#State 178
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD_SCOPED' => 26,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78
		},
		GOTOS => {
			'SubExpression' => 251,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Variable' => 132
		}
	},
	{#State 179
		DEFAULT => -151
	},
	{#State 180
		DEFAULT => -140
	},
	{#State 181
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 253
		}
	},
	{#State 183
		DEFAULT => -153
	},
	{#State 184
		DEFAULT => -152
	},
	{#State 185
		ACTIONS => {
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -108,
			'OP14_BITWISE_OR_XOR' => 151,
			".." => -108,
			'OP16_LOGICAL_OR' => 163,
			";" => -108,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => -108,
			")" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			"]" => -108,
			'OP09_BITWISE_SHIFT' => 154,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 155,
			"}" => -108
		}
	},
	{#State 186
		DEFAULT => -199
	},
	{#State 187
		ACTIONS => {
			";" => 254
		}
	},
	{#State 188
		DEFAULT => -82
	},
	{#State 189
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			"]" => -91,
			"}" => -91,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP18_TERNARY' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			")" => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			".." => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91
		}
	},
	{#State 190
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			"}" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 156,
			'OP04_MATH_POW' => 155,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			".." => -99,
			";" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -99
		}
	},
	{#State 191
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			".." => -85,
			";" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			")" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			"]" => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			'OP18_TERNARY' => -85,
			'OP04_MATH_POW' => -85
		}
	},
	{#State 192
		ACTIONS => {
			"filehandle_ref" => 255
		}
	},
	{#State 193
		ACTIONS => {
			'OP21_LIST_COMMA' => 256
		}
	},
	{#State 194
		DEFAULT => -202
	},
	{#State 195
		ACTIONS => {
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP09_BITWISE_SHIFT' => 154,
			")" => 257,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150
		}
	},
	{#State 196
		ACTIONS => {
			";" => -98,
			'OP16_LOGICAL_OR' => -98,
			".." => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP06_REGEX_MATCH' => 162,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -98,
			"}" => -98,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -98
		}
	},
	{#State 197
		ACTIONS => {
			";" => 258
		}
	},
	{#State 198
		DEFAULT => -111
	},
	{#State 199
		ACTIONS => {
			"my" => 73,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			'OP22_LOGICAL_NOT' => 96,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'OP01_QW' => 141,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81
		},
		GOTOS => {
			'SubExpression' => 142,
			'Expression' => 131,
			'ListElement' => 140,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92,
			'TypeInner' => 138,
			'Variable' => 132,
			'ListElements' => 259
		}
	},
	{#State 200
		ACTIONS => {
			";" => 260
		}
	},
	{#State 201
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 261,
			"}" => 173,
			'WORD' => 172,
			"%{" => 87
		},
		GOTOS => {
			'HashEntry' => 174,
			'HashDereferenced' => 171
		}
	},
	{#State 202
		DEFAULT => -206
	},
	{#State 203
		ACTIONS => {
			'VARIABLE_SYMBOL' => 262
		}
	},
	{#State 204
		ACTIONS => {
			'OP16_LOGICAL_OR' => -162,
			";" => -162,
			'OP14_BITWISE_OR_XOR' => -162,
			".." => -162,
			'OP21_LIST_COMMA' => -162,
			'OP06_REGEX_MATCH' => -162,
			'OP19_VARIABLE_ASSIGN_BY' => -162,
			'OP03_MATH_INC_DEC' => -162,
			'OP15_LOGICAL_AND' => -162,
			'OP11_COMPARE_LT_GT' => -162,
			'COLON' => -162,
			'OP12_COMPARE_EQ_NEQ' => -162,
			'OP08_MATH_ADD_SUB' => -162,
			'OP13_BITWISE_AND' => -162,
			"}" => -162,
			'OP02_ARRAY_THINARROW' => 264,
			'OP04_MATH_POW' => -162,
			'OP02_HASH_THINARROW' => 263,
			'OP19_VARIABLE_ASSIGN' => -162,
			'OP18_TERNARY' => -162,
			'OP08_STRING_CAT' => -162,
			'OP23_LOGICAL_AND' => -162,
			'OP09_BITWISE_SHIFT' => -162,
			"]" => -162,
			'OP07_MATH_MULT_DIV_MOD' => -162,
			'OP02_METHOD_THINARROW' => -162,
			")" => -162,
			'OP17_LIST_RANGE' => -162,
			'OP24_LOGICAL_OR_XOR' => -162
		},
		GOTOS => {
			'VariableRetrieval' => 265
		}
	},
	{#State 205
		DEFAULT => -55
	},
	{#State 206
		ACTIONS => {
			"our" => -58,
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 266
		},
		GOTOS => {
			'OPTIONAL-23' => 267,
			'PropertiesClass' => 268
		}
	},
	{#State 207
		ACTIONS => {
			")" => 270,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 269
		}
	},
	{#State 208
		DEFAULT => -41
	},
	{#State 209
		ACTIONS => {
			'WORD' => 271
		}
	},
	{#State 210
		DEFAULT => -45
	},
	{#State 211
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			"for my integer" => -138,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			"my" => 119,
			"}" => 272,
			'OP22_LOGICAL_NOT' => 96,
			'OP19_LOOP_CONTROL' => 97,
			'OP01_NAMED_VOID' => 114,
			'OP01_PRINT_VOID' => 115,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'LITERAL_STRING' => 83,
			'WORD' => 108,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"foreach my" => -138,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			"while (" => -138,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			"if (" => 80
		},
		GOTOS => {
			'Operator' => 118,
			'Expression' => 99,
			'HashDereferenced' => 120,
			'Operation' => 273,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'HashReference' => 93,
			'VariableDeclaration' => 94,
			'OPTIONAL-37' => 95,
			'PAREN-36' => 117,
			'Conditional' => 116,
			'OperatorVoid' => 98,
			'SubExpression' => 84,
			'LoopLabel' => 86,
			'ArrayReference' => 111,
			'Statement' => 104,
			'Variable' => 82,
			'VariableModification' => 106
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 274
		}
	},
	{#State 213
		DEFAULT => -133
	},
	{#State 214
		ACTIONS => {
			'OP21_LIST_COMMA' => 275
		}
	},
	{#State 215
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP08_STRING_CAT' => -85,
			'OP04_MATH_POW' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			")" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP21_LIST_COMMA' => -177,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP15_LOGICAL_AND' => -85
		}
	},
	{#State 216
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 276
		}
	},
	{#State 217
		DEFAULT => -182
	},
	{#State 218
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -178,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -178,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			";" => -178,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -178
		}
	},
	{#State 219
		DEFAULT => -179
	},
	{#State 220
		ACTIONS => {
			"]" => -175,
			";" => -175,
			'OP21_LIST_COMMA' => 279,
			")" => -175
		},
		GOTOS => {
			'PAREN-44' => 278
		}
	},
	{#State 221
		ACTIONS => {
			'WORD' => 280
		},
		GOTOS => {
			'PLUS-46' => 281
		}
	},
	{#State 222
		ACTIONS => {
			'LEFT_PAREN' => 282
		}
	},
	{#State 223
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			";" => -134,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 224
		DEFAULT => -135
	},
	{#State 225
		ACTIONS => {
			";" => 283
		}
	},
	{#State 226
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			";" => 284,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			'OP09_BITWISE_SHIFT' => 154,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP04_MATH_POW' => 155,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 153
		}
	},
	{#State 227
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -110,
			"}" => -110,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP04_MATH_POW' => 155,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -110,
			'OP14_BITWISE_OR_XOR' => 151,
			".." => -110,
			";" => -110,
			'OP16_LOGICAL_OR' => 163,
			'OP21_LIST_COMMA' => -110,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161
		}
	},
	{#State 228
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -109,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -109,
			"}" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			".." => -109,
			'OP14_BITWISE_OR_XOR' => 151,
			";" => -109,
			'OP16_LOGICAL_OR' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -109
		}
	},
	{#State 229
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP13_BITWISE_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 161,
			";" => -101,
			'OP16_LOGICAL_OR' => -101,
			".." => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP06_REGEX_MATCH' => 162,
			'OP17_LIST_RANGE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -101,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -101,
			"}" => -101,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 230
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -103,
			".." => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP16_LOGICAL_OR' => -103,
			";" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 161,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => -103,
			'OP18_TERNARY' => -103,
			'OP04_MATH_POW' => 155,
			"}" => -103,
			"]" => -103,
			'OP09_BITWISE_SHIFT' => 154,
			")" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP17_LIST_RANGE' => -103
		}
	},
	{#State 231
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -106,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 156,
			'OP04_MATH_POW' => 155,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -106,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP14_BITWISE_OR_XOR' => 151,
			".." => -106,
			";" => -106,
			'OP16_LOGICAL_OR' => 163,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 232
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			")" => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			"]" => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => -94,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			"}" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP12_COMPARE_EQ_NEQ' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -94,
			";" => -94,
			".." => -94,
			'OP14_BITWISE_OR_XOR' => -94
		}
	},
	{#State 233
		ACTIONS => {
			'OP21_LIST_COMMA' => -97,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -97,
			";" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			".." => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			"}" => -97,
			"]" => -97,
			'OP09_BITWISE_SHIFT' => -97,
			")" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97
		}
	},
	{#State 234
		ACTIONS => {
			'OP13_BITWISE_AND' => -90,
			'OP12_COMPARE_EQ_NEQ' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			".." => -90,
			'OP16_LOGICAL_OR' => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			")" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"]" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP18_TERNARY' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP04_MATH_POW' => 155,
			"}" => -90
		}
	},
	{#State 235
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			".." => -96,
			'OP16_LOGICAL_OR' => -96,
			";" => -96,
			")" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP08_STRING_CAT' => -96,
			'OP04_MATH_POW' => 155,
			"}" => -96,
			"]" => -96,
			'OP09_BITWISE_SHIFT' => -96
		}
	},
	{#State 236
		ACTIONS => {
			'COLON' => 285
		}
	},
	{#State 237
		ACTIONS => {
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP04_MATH_POW' => 155,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => -102,
			'OP23_LOGICAL_AND' => -102,
			"}" => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 154,
			'OP15_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => 161,
			'OP13_BITWISE_AND' => -102,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP21_LIST_COMMA' => -102,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -102,
			";" => -102,
			".." => -102,
			'OP14_BITWISE_OR_XOR' => -102
		}
	},
	{#State 238
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			".." => -95,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			"]" => -95,
			"}" => -95,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP18_TERNARY' => -95
		}
	},
	{#State 239
		ACTIONS => {
			"]" => -104,
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => -104,
			"}" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP17_LIST_RANGE' => -104,
			")" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP21_LIST_COMMA' => -104,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -104,
			";" => -104,
			".." => -104,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP15_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 161
		}
	},
	{#State 240
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => -100,
			'OP04_MATH_POW' => 155,
			'OP09_BITWISE_SHIFT' => 154,
			"]" => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => -100,
			".." => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			";" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 241
		DEFAULT => -93
	},
	{#State 242
		ACTIONS => {
			"]" => -105,
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 155,
			'OP18_TERNARY' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => 156,
			"}" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP17_LIST_RANGE' => -105,
			")" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP21_LIST_COMMA' => -105,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -105,
			";" => -105,
			".." => -105,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161
		}
	},
	{#State 243
		DEFAULT => -196
	},
	{#State 244
		DEFAULT => -195
	},
	{#State 245
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -186,
			"my" => 73,
			'OP05_LOGICAL_NEG' => -186,
			'OP10_NAMED_UNARY_STRINGIFY' => -186,
			'VARIABLE_SYMBOL' => -186,
			'LEFT_PAREN' => -186,
			'OP01_NAMED' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'LEFT_BRACKET' => -186,
			'WORD' => -186,
			'LITERAL_STRING' => -186,
			'OP01_OPEN' => -186,
			'WORD_SCOPED' => -186,
			'OP05_MATH_NEG' => -186,
			'LITERAL_NUMBER' => -186,
			'OP01_CLOSE' => -186,
			'OP10_NAMED_UNARY' => -186,
			"%{" => -186,
			"undef" => -186,
			"\@{" => -186,
			'LEFT_BRACE' => -186
		},
		GOTOS => {
			'TypeInner' => 287,
			'OPTIONAL-48' => 286
		}
	},
	{#State 246
		ACTIONS => {
			"}" => 289,
			'OP21_LIST_COMMA' => 290
		},
		GOTOS => {
			'PAREN-49' => 288
		}
	},
	{#State 247
		DEFAULT => -183
	},
	{#State 248
		DEFAULT => -184
	},
	{#State 249
		DEFAULT => -117
	},
	{#State 250
		ACTIONS => {
			")" => 291
		}
	},
	{#State 251
		ACTIONS => {
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => 292
		}
	},
	{#State 252
		ACTIONS => {
			'LEFT_PAREN' => 293
		}
	},
	{#State 253
		ACTIONS => {
			'VARIABLE_SYMBOL' => 294
		}
	},
	{#State 254
		DEFAULT => -116
	},
	{#State 255
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 295
		}
	},
	{#State 256
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'Operator' => 118,
			'SubExpression' => 296,
			'Expression' => 131,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93,
			'Variable' => 132
		}
	},
	{#State 257
		DEFAULT => -92
	},
	{#State 258
		DEFAULT => -113
	},
	{#State 259
		ACTIONS => {
			";" => 297
		}
	},
	{#State 260
		DEFAULT => -114
	},
	{#State 261
		ACTIONS => {
			"}" => 298
		}
	},
	{#State 262
		ACTIONS => {
			";" => 300,
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 263
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 301,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'WordScoped' => 92,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'HashReference' => 93,
			'Variable' => 132,
			'Operator' => 118,
			'SubExpression' => 302,
			'Expression' => 131,
			'HashDereferenced' => 120,
			'ArrayReference' => 111
		}
	},
	{#State 264
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'HashReference' => 93,
			'Variable' => 132,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 303,
			'HashDereferenced' => 120,
			'ArrayReference' => 111
		}
	},
	{#State 265
		DEFAULT => -160
	},
	{#State 266
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 304
		}
	},
	{#State 267
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 305
		}
	},
	{#State 268
		DEFAULT => -57
	},
	{#State 269
		ACTIONS => {
			"%{" => 87,
			'WORD' => 307
		},
		GOTOS => {
			'HashDereferenced' => 308,
			'HashEntryTyped' => 306
		}
	},
	{#State 270
		ACTIONS => {
			";" => 309
		}
	},
	{#State 271
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 310
		}
	},
	{#State 272
		ACTIONS => {
			";" => 311
		}
	},
	{#State 273
		DEFAULT => -44
	},
	{#State 274
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 312
		}
	},
	{#State 275
		ACTIONS => {
			"my" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'KEYS_OR_VALUES' => 139,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'OP01_QW' => 141,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 142,
			'Expression' => 131,
			'ListElement' => 140,
			'Operator' => 118,
			'Variable' => 132,
			'TypeInner' => 138,
			'ListElements' => 313,
			'HashReference' => 93,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92
		}
	},
	{#State 276
		DEFAULT => -146,
		GOTOS => {
			'STAR-39' => 314
		}
	},
	{#State 277
		ACTIONS => {
			'OP01_PRINT_VOID' => 115,
			'OP01_NAMED_VOID' => 114,
			'OP22_LOGICAL_NOT' => 96,
			'OP19_LOOP_CONTROL' => 97,
			"my" => 119,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			"for my integer" => -138,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'LEFT_PAREN' => 78,
			"while (" => -138,
			"if (" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			"foreach my" => -138,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'WORD' => 108,
			'OP01_OPEN' => 107,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112
		},
		GOTOS => {
			'OperatorVoid' => 98,
			'PAREN-36' => 117,
			'Conditional' => 116,
			'OPTIONAL-37' => 95,
			'VariableDeclaration' => 94,
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashDereferenced' => 120,
			'Operation' => 316,
			'Expression' => 99,
			'PLUS-42' => 315,
			'Operator' => 118,
			'Variable' => 82,
			'VariableModification' => 106,
			'Statement' => 104,
			'ArrayReference' => 111,
			'LoopLabel' => 86,
			'SubExpression' => 84
		}
	},
	{#State 278
		DEFAULT => -171
	},
	{#State 279
		ACTIONS => {
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			"my" => 73,
			'KEYS_OR_VALUES' => 139,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ListElement' => 317,
			'Expression' => 131,
			'SubExpression' => 142,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'TypeInner' => 138,
			'Variable' => 132
		}
	},
	{#State 280
		DEFAULT => -174
	},
	{#State 281
		ACTIONS => {
			'WORD' => 318,
			")" => 319
		}
	},
	{#State 282
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP01_QW' => 141,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			"my" => 73,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'KEYS_OR_VALUES' => 139,
			'OP05_LOGICAL_NEG' => 101,
			")" => -120,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 142,
			'ListElement' => 140,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'WordScoped' => 92,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'HashReference' => 93,
			'OPTIONAL-35' => 320,
			'ListElements' => 321,
			'TypeInner' => 138,
			'Variable' => 132
		}
	},
	{#State 283
		DEFAULT => -168
	},
	{#State 284
		DEFAULT => -169
	},
	{#State 285
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 322
		}
	},
	{#State 286
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 25,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105
		},
		GOTOS => {
			'SubExpression' => 323,
			'Expression' => 131,
			'Operator' => 118,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'Variable' => 132
		}
	},
	{#State 287
		DEFAULT => -185
	},
	{#State 288
		DEFAULT => -192
	},
	{#State 289
		DEFAULT => -194
	},
	{#State 290
		ACTIONS => {
			'WORD' => 172,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 171,
			'HashEntry' => 324
		}
	},
	{#State 291
		DEFAULT => -122
	},
	{#State 292
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 325
		}
	},
	{#State 293
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"%{" => 87,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'OP05_LOGICAL_NEG' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 326,
			'Expression' => 131,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113
		}
	},
	{#State 294
		ACTIONS => {
			'LEFT_PAREN' => 327
		}
	},
	{#State 295
		DEFAULT => -203
	},
	{#State 296
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP23_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			'OP04_MATH_POW' => 155,
			'OP09_BITWISE_SHIFT' => 154,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP21_LIST_COMMA' => 328,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 297
		DEFAULT => -115
	},
	{#State 298
		DEFAULT => -207
	},
	{#State 299
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'STDIN_PROMPT' => 224,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'WORD' => 25
		},
		GOTOS => {
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92,
			'Variable' => 132,
			'Expression' => 131,
			'SubExpression' => 223,
			'Operator' => 118,
			'SubExpressionOrPrompt' => 329,
			'ArrayReference' => 111,
			'HashDereferenced' => 120
		}
	},
	{#State 300
		DEFAULT => -166
	},
	{#State 301
		ACTIONS => {
			'LEFT_PAREN' => -197,
			"}" => 330
		}
	},
	{#State 302
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 157,
			"}" => 331,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 303
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			"]" => 332,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 304
		ACTIONS => {
			'WORD' => 307,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 308,
			'HashEntryTyped' => 333
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_NUMBER' => 334,
			"our" => 338
		},
		GOTOS => {
			'Method' => 337,
			'Subroutine' => 335,
			'MethodOrSubroutine' => 336
		}
	},
	{#State 306
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 339
		}
	},
	{#State 307
		ACTIONS => {
			'OP20_HASH_FATARROW' => 340
		}
	},
	{#State 308
		DEFAULT => -190
	},
	{#State 309
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 341
		}
	},
	{#State 310
		DEFAULT => -201
	},
	{#State 311
		DEFAULT => -46
	},
	{#State 312
		ACTIONS => {
			")" => 344,
			'OP21_LIST_COMMA' => 342
		},
		GOTOS => {
			'PAREN-18' => 343
		}
	},
	{#State 313
		ACTIONS => {
			")" => 345
		}
	},
	{#State 314
		ACTIONS => {
			"undef" => -149,
			'OP10_NAMED_UNARY' => -149,
			'OP05_MATH_NEG' => -149,
			'OP01_OPEN' => -149,
			'WORD' => -149,
			'WORD_SCOPED' => -149,
			"elsif (" => 350,
			"foreach my" => -149,
			'' => -149,
			'OP01_NAMED' => -149,
			'VARIABLE_SYMBOL' => -149,
			"my" => -149,
			'OP01_PRINT_VOID' => -149,
			'OP01_NAMED_VOID' => -149,
			'LEFT_BRACE' => -149,
			"\@{" => -149,
			'OP01_CLOSE' => -149,
			"else" => 346,
			"%{" => -149,
			'LITERAL_NUMBER' => -149,
			'LITERAL_STRING' => -149,
			'LEFT_BRACKET' => -149,
			"if (" => -149,
			'OP03_MATH_INC_DEC' => -149,
			"while (" => -149,
			'LEFT_PAREN' => -149,
			"for my integer" => -149,
			'OP10_NAMED_UNARY_STRINGIFY' => -149,
			'OP05_LOGICAL_NEG' => -149,
			"}" => -149,
			'OP19_LOOP_CONTROL' => -149,
			'OP22_LOGICAL_NOT' => -149
		},
		GOTOS => {
			'PAREN-40' => 348,
			'OPTIONAL-41' => 347,
			'PAREN-38' => 349
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			"for my integer" => -138,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP05_LOGICAL_NEG' => 101,
			"}" => 351,
			"my" => 119,
			'OP19_LOOP_CONTROL' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_PRINT_VOID' => 115,
			'OP01_NAMED_VOID' => 114,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 108,
			'WORD_SCOPED' => 26,
			"foreach my" => -138,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			"if (" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"while (" => -138,
			'LEFT_PAREN' => 78
		},
		GOTOS => {
			'Operator' => 118,
			'Expression' => 99,
			'HashDereferenced' => 120,
			'Operation' => 352,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'VariableDeclaration' => 94,
			'HashReference' => 93,
			'OPTIONAL-37' => 95,
			'OperatorVoid' => 98,
			'Conditional' => 116,
			'PAREN-36' => 117,
			'SubExpression' => 84,
			'LoopLabel' => 86,
			'ArrayReference' => 111,
			'Statement' => 104,
			'VariableModification' => 106,
			'Variable' => 82
		}
	},
	{#State 316
		DEFAULT => -158
	},
	{#State 317
		DEFAULT => -170
	},
	{#State 318
		DEFAULT => -173
	},
	{#State 319
		DEFAULT => -176
	},
	{#State 320
		ACTIONS => {
			")" => 353
		}
	},
	{#State 321
		DEFAULT => -119
	},
	{#State 322
		DEFAULT => -107
	},
	{#State 323
		ACTIONS => {
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -187,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			'OP09_BITWISE_SHIFT' => 154,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP04_MATH_POW' => 155,
			"}" => -187,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 153
		}
	},
	{#State 324
		DEFAULT => -191
	},
	{#State 325
		DEFAULT => -156
	},
	{#State 326
		ACTIONS => {
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP09_BITWISE_SHIFT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP16_LOGICAL_OR' => 163,
			".." => 354,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 158
		}
	},
	{#State 327
		ACTIONS => {
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'OP01_QW' => 141,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'LEFT_BRACKET' => 81,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_PAREN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'KEYS_OR_VALUES' => 139,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 73,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Variable' => 132,
			'TypeInner' => 138,
			'ListElements' => 355,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92,
			'Literal' => 91,
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'ListElement' => 140,
			'SubExpression' => 142,
			'Expression' => 131,
			'Operator' => 118
		}
	},
	{#State 328
		ACTIONS => {
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78,
			'LEFT_BRACKET' => 81,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			"undef" => 112,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'Expression' => 131,
			'SubExpression' => 356,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'WordScoped' => 92
		}
	},
	{#State 329
		ACTIONS => {
			";" => 357
		}
	},
	{#State 330
		DEFAULT => -165
	},
	{#State 331
		DEFAULT => -164
	},
	{#State 332
		DEFAULT => -163
	},
	{#State 333
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 358
		}
	},
	{#State 334
		ACTIONS => {
			";" => 359
		}
	},
	{#State 335
		DEFAULT => -81
	},
	{#State 336
		DEFAULT => -59
	},
	{#State 337
		DEFAULT => -80
	},
	{#State 338
		ACTIONS => {
			'WORD' => 52,
			'TYPE_METHOD' => 360
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 339
		ACTIONS => {
			")" => 363,
			'OP21_LIST_COMMA' => 361
		},
		GOTOS => {
			'PAREN-25' => 362
		}
	},
	{#State 340
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 364
		}
	},
	{#State 341
		DEFAULT => -66
	},
	{#State 342
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 343
		DEFAULT => -48
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 345
		DEFAULT => -84
	},
	{#State 346
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 367
		}
	},
	{#State 347
		DEFAULT => -150
	},
	{#State 348
		DEFAULT => -148
	},
	{#State 349
		DEFAULT => -145
	},
	{#State 350
		ACTIONS => {
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103
		},
		GOTOS => {
			'ArrayReference' => 111,
			'HashDereferenced' => 120,
			'SubExpression' => 368,
			'Expression' => 131,
			'Operator' => 118,
			'Variable' => 132,
			'HashReference' => 93,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91
		}
	},
	{#State 351
		DEFAULT => -159
	},
	{#State 352
		DEFAULT => -157
	},
	{#State 353
		DEFAULT => -123
	},
	{#State 354
		ACTIONS => {
			'LEFT_BRACKET' => 81,
			'LEFT_PAREN' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103
		},
		GOTOS => {
			'Literal' => 91,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'HashReference' => 93,
			'Variable' => 132,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 369,
			'HashDereferenced' => 120,
			'ArrayReference' => 111
		}
	},
	{#State 355
		ACTIONS => {
			")" => 370
		}
	},
	{#State 356
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP13_BITWISE_AND' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP21_LIST_COMMA' => -86,
			'OP06_REGEX_MATCH' => 162,
			".." => -86,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			";" => -86,
			")" => -86,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP23_LOGICAL_AND' => -86,
			'OP04_MATH_POW' => 155,
			"}" => -86,
			"]" => -86,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 357
		DEFAULT => -167
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 373,
			")" => 372
		},
		GOTOS => {
			'PAREN-27' => 371
		}
	},
	{#State 359
		DEFAULT => -61
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 361
		ACTIONS => {
			'WORD' => 307,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 308,
			'HashEntryTyped' => 375
		}
	},
	{#State 362
		DEFAULT => -63
	},
	{#State 363
		ACTIONS => {
			";" => 376
		}
	},
	{#State 364
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			'OP22_LOGICAL_NOT' => 96,
			"undef" => 112,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 87,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 83,
			'WORD' => 25,
			'OP01_OPEN' => 107,
			'WORD_SCOPED' => 26,
			'LEFT_BRACKET' => 81,
			'OP01_NAMED' => 105,
			'OP03_MATH_INC_DEC' => 79,
			'LEFT_PAREN' => 78
		},
		GOTOS => {
			'Variable' => 132,
			'WordScoped' => 92,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'HashReference' => 93,
			'HashDereferenced' => 120,
			'ArrayReference' => 111,
			'Operator' => 118,
			'Expression' => 131,
			'SubExpression' => 377
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 378
		}
	},
	{#State 366
		ACTIONS => {
			"\@_;" => 379
		}
	},
	{#State 367
		DEFAULT => -147
	},
	{#State 368
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 153,
			")" => 380,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 156,
			'OP04_MATH_POW' => 155,
			'OP09_BITWISE_SHIFT' => 154,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 159,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP16_LOGICAL_OR' => 163,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 369
		ACTIONS => {
			'OP15_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 161,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			")" => 381,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP04_MATH_POW' => 155,
			'OP18_TERNARY' => 157,
			'OP23_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 156,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 370
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 382
		}
	},
	{#State 371
		DEFAULT => -68
	},
	{#State 372
		ACTIONS => {
			";" => 383
		}
	},
	{#State 373
		ACTIONS => {
			"%{" => 87,
			'WORD' => 307
		},
		GOTOS => {
			'HashDereferenced' => 308,
			'HashEntryTyped' => 384
		}
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 385
		}
	},
	{#State 375
		DEFAULT => -62
	},
	{#State 376
		DEFAULT => -65
	},
	{#State 377
		ACTIONS => {
			'OP04_MATH_POW' => 155,
			'OP23_LOGICAL_AND' => 149,
			'OP18_TERNARY' => 157,
			'OP08_STRING_CAT' => 156,
			'OP09_BITWISE_SHIFT' => 154,
			")" => -189,
			'OP07_MATH_MULT_DIV_MOD' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -189,
			'OP16_LOGICAL_OR' => 163,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 160,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 150,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 379
		DEFAULT => -50
	},
	{#State 380
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 381
		ACTIONS => {
			'LEFT_BRACE' => 277
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 382
		DEFAULT => -155
	},
	{#State 383
		DEFAULT => -70
	},
	{#State 384
		DEFAULT => -67
	},
	{#State 385
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'VARIABLE_SYMBOL' => -72,
			"for my integer" => -72,
			"my" => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP01_NAMED_VOID' => -72,
			'OP01_CLOSE' => -72,
			'OP10_NAMED_UNARY' => -72,
			"%{" => -72,
			"undef" => -72,
			'LEFT_BRACE' => -72,
			"\@{" => -72,
			'LITERAL_STRING' => -72,
			'OP01_OPEN' => -72,
			'WORD' => -72,
			'WORD_SCOPED' => -72,
			'OP05_MATH_NEG' => -72,
			'LITERAL_NUMBER' => -72,
			"( my" => 391,
			"foreach my" => -72,
			'LEFT_BRACKET' => -72,
			'LEFT_PAREN' => -72,
			"while (" => -72,
			'OP01_NAMED' => -72,
			'OP03_MATH_INC_DEC' => -72,
			"if (" => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 390,
			'MethodArguments' => 389
		}
	},
	{#State 386
		DEFAULT => -47
	},
	{#State 387
		DEFAULT => -144
	},
	{#State 388
		DEFAULT => -154
	},
	{#State 389
		DEFAULT => -71
	},
	{#State 390
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED_VOID' => 114,
			'OP01_PRINT_VOID' => 115,
			"for my integer" => -138,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'VARIABLE_SYMBOL' => 121,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 119,
			'LEFT_BRACKET' => 81,
			"foreach my" => -138,
			"if (" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			"while (" => -138,
			'LEFT_PAREN' => 78,
			"\@{" => 90,
			'LEFT_BRACE' => 89,
			"undef" => 112,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 110,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			'WORD_SCOPED' => 26,
			'WORD' => 108,
			'OP01_OPEN' => 107,
			'LITERAL_STRING' => 83
		},
		GOTOS => {
			'OPTIONAL-37' => 95,
			'OperatorVoid' => 98,
			'PAREN-36' => 117,
			'Conditional' => 116,
			'WordScoped' => 92,
			'Literal' => 91,
			'ArrayDereferenced' => 113,
			'VariableDeclaration' => 94,
			'HashReference' => 93,
			'HashDereferenced' => 120,
			'Operation' => 392,
			'Operator' => 118,
			'Expression' => 99,
			'VariableModification' => 106,
			'Variable' => 82,
			'Statement' => 104,
			'ArrayReference' => 111,
			'PLUS-30' => 393,
			'SubExpression' => 84,
			'LoopLabel' => 86
		}
	},
	{#State 391
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 394
		}
	},
	{#State 392
		DEFAULT => -74
	},
	{#State 393
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 83,
			'OP01_OPEN' => 107,
			'WORD' => 108,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG' => 109,
			"%{" => 87,
			'OP01_CLOSE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'LEFT_BRACE' => 89,
			"\@{" => 90,
			"undef" => 112,
			'LEFT_PAREN' => 78,
			"while (" => -138,
			"if (" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 105,
			'LEFT_BRACKET' => 81,
			"foreach my" => -138,
			"my" => 119,
			"}" => 396,
			'OP05_LOGICAL_NEG' => 101,
			"for my integer" => -138,
			'VARIABLE_SYMBOL' => 121,
			'OP10_NAMED_UNARY_STRINGIFY' => 103,
			'OP01_PRINT_VOID' => 115,
			'OP01_NAMED_VOID' => 114,
			'OP22_LOGICAL_NOT' => 96,
			'OP19_LOOP_CONTROL' => 97
		},
		GOTOS => {
			'OperatorVoid' => 98,
			'PAREN-36' => 117,
			'Conditional' => 116,
			'OPTIONAL-37' => 95,
			'VariableDeclaration' => 94,
			'HashReference' => 93,
			'ArrayDereferenced' => 113,
			'Literal' => 91,
			'WordScoped' => 92,
			'Operation' => 395,
			'HashDereferenced' => 120,
			'Expression' => 99,
			'Operator' => 118,
			'Variable' => 82,
			'VariableModification' => 106,
			'Statement' => 104,
			'ArrayReference' => 111,
			'SubExpression' => 84,
			'LoopLabel' => 86
		}
	},
	{#State 394
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 397
		}
	},
	{#State 395
		DEFAULT => -73
	},
	{#State 396
		ACTIONS => {
			";" => 398
		}
	},
	{#State 397
		ACTIONS => {
			")" => 400,
			'OP21_LIST_COMMA' => 399
		},
		GOTOS => {
			'PAREN-31' => 401
		}
	},
	{#State 398
		DEFAULT => -75
	},
	{#State 399
		ACTIONS => {
			"my" => 402
		}
	},
	{#State 400
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 401
		DEFAULT => -77
	},
	{#State 402
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 404
		}
	},
	{#State 403
		ACTIONS => {
			"\@_;" => 405
		}
	},
	{#State 404
		ACTIONS => {
			'VARIABLE_SYMBOL' => 406
		}
	},
	{#State 405
		DEFAULT => -79
	},
	{#State 406
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5626 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5633 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5640 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5647 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5658 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5683 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5690 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5697 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5704 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5711 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5718 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5725 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5746 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5753 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5764 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5811 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5818 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5825 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5832 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5839 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5846 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5860 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5878 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5896 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5903 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5939 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5961 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5975 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5982 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5989 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6102 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6188 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6195 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6216 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6234 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6241 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6614 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6665 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_124
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_125
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_134
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_135
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_139
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6962 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_150
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_151
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_154
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_155
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_156
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_159
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_162
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_163
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_166
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_168
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-46', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-46', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_175
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7219 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7277 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_195
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_197
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_199
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule Type_200
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_201
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_202
		 'FileHandleOpen', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_203
		 'FileHandleOpen', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_204
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_205
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_206
		 'FileHandlePrint', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_207
		 'FileHandlePrint', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	]
],
#line 7568 lib/RPerl/Grammar.pm
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
         'ModuleHeader_21', 
         'Module_22', 
         'Module_23', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_32', 
         'Header_33', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_36', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_39', 
         'Include_40', 
         'Constant_41', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_46', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_50', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_61', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_65', 
         'Properties_66', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'PropertiesClass_70', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_75', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_79', 
         'MethodOrSubroutine_80', 
         'MethodOrSubroutine_81', 
         'Operation_82', 
         'Operation_83', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_121', 
         'Expression_122', 
         'Expression_123', 
         'SubExpression_124', 
         'SubExpression_125', 
         'SubExpression_126', 
         'SubExpression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpressionOrPrompt_134', 
         'SubExpressionOrPrompt_135', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_139', 
         'Statement_140', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_150', 
         'Loop_151', 
         'Loop_152', 
         'Loop_153', 
         'LoopFor_154', 
         'LoopForEach_155', 
         'LoopWhile_156', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_159', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_162', 
         'VariableRetrieval_163', 
         'VariableRetrieval_164', 
         'VariableRetrieval_165', 
         'VariableDeclaration_166', 
         'VariableDeclaration_167', 
         'VariableModification_168', 
         'VariableModification_169', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_175', 
         'ListElements_176', 
         'ListElement_177', 
         'ListElement_178', 
         'ListElement_179', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_182', 
         'ArrayDereferenced_183', 
         'ArrayDereferenced_184', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_187', 
         'HashEntry_188', 
         'HashEntryTyped_189', 
         'HashEntryTyped_190', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_194', 
         'HashDereferenced_195', 
         'HashDereferenced_196', 
         'WordScoped_197', 
         'WordScoped_198', 
         'LoopLabel_199', 
         'Type_200', 
         'TypeInner_201', 
         'FileHandleOpen_202', 
         'FileHandleOpen_203', 
         'FileHandleClose_204', 
         'FileHandleClose_205', 
         'FileHandlePrint_206', 
         'FileHandlePrint_207', 
         'Literal_208', 
         'Literal_209', );
  $self;
}

#line 187 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
# NEED FIX: UPDATE!?!
my string__hash_ref $rules = {

CompileUnit_3 => 'RPerl::CompileUnit',
CompileUnit_4 => 'RPerl::CompileUnit',
Program_9 => 'RPerl::CompileUnit::Program',
Module_10 => 'RPerl::CompileUnit::Module',
Module_11 => 'RPerl::CompileUnit::Module',
Package_14 => 'RPerl::CompileUnit::Module::Package',
Subroutine_38 => 'RPerl::CodeBlock::Subroutine',
Class_52 => 'RPerl::CompileUnit::Module::Class',
Properties_55 => 'RPerl::DataStructure::Hash::Properties',
Method_60 => 'RPerl::CodeBlock::Subroutine::Method',
Operation_65 => 'RPerl::Operation',
Operation_66 => 'RPerl::Operation',
Operator_69 => 'RPerl::Operation::Expression::Operator',

}; 
    1;
}

=for None

=cut


#line 7826 lib/RPerl/Grammar.pm



1;
