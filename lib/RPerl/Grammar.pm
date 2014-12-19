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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|for\ my\ integer|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|elsif\ \(|\$TYPED_|\=\ sub\ \{|package|while\ \(|undef|if\ \(|else|\(\ my|use|our|\@_\;|qw\(|\%\{|\.\.|\@\{|my|\;|\)|\]|\})}gc and return ($1, $1);

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
  [ 'Operator_84' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'LEFT_PAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_OPEN', 'FileHandleOpen', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
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
			"## no critic qw(" => 1,
			'SHEBANG' => 7
		},
		GOTOS => {
			'CompileUnit' => 5,
			'PLUS-2' => 6,
			'ModuleHeader' => 2,
			'OPTIONAL-9' => 3,
			'Program' => 8,
			'Critic' => 9,
			'PAREN-1' => 4
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-14' => 11
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => -25,
			"use parent qw(" => 15,
			"use" => -25,
			"use constant" => -25,
			"our" => -25
		},
		GOTOS => {
			'Module' => 13,
			'Package' => 14,
			'Class' => 12,
			'STAR-10' => 16
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 17
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'' => 18
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 1,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'PAREN-1' => 19,
			'Critic' => 9,
			'ModuleHeader' => 2
		}
	},
	{#State 7
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'OPTIONAL-3' => 20,
			'Critic' => 21
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -35
	},
	{#State 11
		ACTIONS => {
			")" => 23,
			'WORD' => 22
		}
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 16
		ACTIONS => {
			"use constant" => -27,
			"use" => -27,
			"our" => -27,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 28
		}
	},
	{#State 17
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 31
		}
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -36
	},
	{#State 24
		DEFAULT => -197
	},
	{#State 25
		DEFAULT => -198
	},
	{#State 26
		ACTIONS => {
			")" => 32
		}
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 34
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 33
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			";" => 36
		}
	},
	{#State 30
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 31
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 38
		}
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"our" => 41,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 44,
			'Subroutine' => 42,
			'PLUS-13' => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 24
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
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			"\@{" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LEFT_BRACE' => -11,
			"use constant" => -11,
			'OP05_MATH_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"undef" => -11,
			'OP01_OPEN' => -11,
			'OP10_NAMED_UNARY' => -11,
			"## no critic qw(" => 1,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			'LEFT_BRACKET' => -11,
			'LEFT_PAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP22_LOGICAL_NOT' => -11,
			"our" => -11,
			"foreach my" => -11,
			'WORD' => -11,
			"if (" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_PRINT_VOID' => -11,
			"my" => -11,
			"for my integer" => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			"use" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_SCOPED' => -11,
			"while (" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11
		},
		GOTOS => {
			'STAR-5' => 49,
			'Critic' => 48
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
			'LITERAL_NUMBER' => 51,
			"our" => 41
		},
		GOTOS => {
			'Subroutine' => 52
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			'WORD' => 55
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			"qw(" => 56,
			";" => 57
		}
	},
	{#State 46
		DEFAULT => -21
	},
	{#State 47
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			'OP01_OPEN' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED' => -13,
			'LITERAL_STRING' => -13,
			"\@{" => -13,
			'VARIABLE_SYMBOL' => -13,
			'LEFT_BRACE' => -13,
			"use constant" => -13,
			'OP05_MATH_NEG' => -13,
			'LITERAL_NUMBER' => -13,
			"undef" => -13,
			"my" => -13,
			'OP01_PRINT_VOID' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_CLOSE' => -13,
			"for my integer" => -13,
			"%{" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_SCOPED' => -13,
			"use" => 34,
			'OP19_LOOP_CONTROL' => -13,
			"while (" => -13,
			'LEFT_BRACKET' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LEFT_PAREN' => -13,
			'OP22_LOGICAL_NOT' => -13,
			"our" => -13,
			"foreach my" => -13,
			"if (" => -13,
			'WORD' => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 60
		}
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 61
		}
	},
	{#State 51
		ACTIONS => {
			";" => 62
		}
	},
	{#State 52
		DEFAULT => -30
	},
	{#State 53
		DEFAULT => -200
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 56
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
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
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			"foreach my" => -15,
			'OP05_MATH_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"if (" => -15,
			'WORD' => -15,
			'LEFT_BRACKET' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LEFT_PAREN' => -15,
			"\@{" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'LEFT_BRACE' => -15,
			"our" => -15,
			"use constant" => 43,
			'OP01_CLOSE' => -15,
			"for my integer" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"while (" => -15,
			'WORD_SCOPED' => -15,
			'OP01_OPEN' => -15,
			"my" => -15,
			'OP01_PRINT_VOID' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"## no critic qw(" => 1,
			"our %properties = (" => -54,
			"use" => -54,
			"use constant" => -54
		},
		GOTOS => {
			'STAR-21' => 71,
			'Critic' => 70
		}
	},
	{#State 62
		DEFAULT => -32
	},
	{#State 63
		ACTIONS => {
			"= sub {" => 72
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 74
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			")" => 76,
			'WORD' => 75
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			"our" => 41,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			"undef" => 77,
			"if (" => 96,
			'WORD' => 95,
			'LITERAL_NUMBER' => 79,
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			"my" => 118,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_PRINT_VOID' => 116,
			'OP01_OPEN' => 94,
			'OP01_NAMED_VOID' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			"while (" => -138,
			'WORD_SCOPED' => 25,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_CLOSE' => 113,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'LoopLabel' => 112,
			'PLUS-8' => 90,
			'Operation' => 111,
			'PAREN-36' => 110,
			'SubExpression' => 119,
			'Operator' => 120,
			'VariableDeclaration' => 121,
			'OPTIONAL-37' => 93,
			'VariableModification' => 92,
			'HashDereferenced' => 115,
			'Subroutine' => 114,
			'ArrayDereferenced' => 99,
			'Statement' => 100,
			'Variable' => 80,
			'HashReference' => 98,
			'Literal' => 97,
			'OperatorVoid' => 78,
			'Expression' => 105,
			'WordScoped' => 87,
			'ArrayReference' => 86,
			'Conditional' => 83
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		DEFAULT => -51
	},
	{#State 71
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 34,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 123,
			'STAR-22' => 122
		}
	},
	{#State 72
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -43,
			'LEFT_BRACE' => -43,
			'LEFT_BRACKET' => -43,
			"\@{" => -43,
			'VARIABLE_SYMBOL' => -43,
			'LEFT_PAREN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"( my" => 125,
			'LITERAL_NUMBER' => -43,
			'WORD' => -43,
			"if (" => -43,
			"undef" => -43,
			'OP05_MATH_NEG' => -43,
			"foreach my" => -43,
			'OP01_OPEN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT_VOID' => -43,
			"my" => -43,
			"%{" => -43,
			'LITERAL_STRING' => -43,
			'OP01_NAMED' => -43,
			"while (" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'WORD_SCOPED' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'OP01_NAMED_VOID' => -43,
			"for my integer" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_CLOSE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 126,
			'OPTIONAL-16' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_STRING' => 88,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Literal' => 128
		}
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			";" => 129
		}
	},
	{#State 77
		DEFAULT => -125
	},
	{#State 78
		DEFAULT => -141
	},
	{#State 79
		DEFAULT => -209
	},
	{#State 80
		ACTIONS => {
			'OP15_LOGICAL_AND' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP03_MATH_INC_DEC' => 131,
			'OP18_TERNARY' => -127,
			'OP04_MATH_POW' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP19_VARIABLE_ASSIGN_BY' => 132,
			'OP17_LIST_RANGE' => -127,
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP19_VARIABLE_ASSIGN' => 130,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP02_METHOD_THINARROW' => 133,
			'OP08_STRING_CAT' => -127
		}
	},
	{#State 81
		ACTIONS => {
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'ArrayReference' => 86,
			'Operator' => 120,
			'SubExpression' => 136,
			'WordScoped' => 87,
			'Expression' => 135,
			'HashDereferenced' => 115,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 82
		ACTIONS => {
			"%{" => 109,
			'WORD' => 137,
			"}" => 138
		},
		GOTOS => {
			'HashDereferenced' => 139,
			'HashEntry' => 140
		}
	},
	{#State 83
		DEFAULT => -139
	},
	{#State 84
		DEFAULT => -161,
		GOTOS => {
			'STAR-43' => 141
		}
	},
	{#State 85
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 84
		},
		GOTOS => {
			'ArrayReference' => 142,
			'Variable' => 143
		}
	},
	{#State 86
		DEFAULT => -128
	},
	{#State 87
		ACTIONS => {
			'LEFT_PAREN' => 144
		}
	},
	{#State 88
		DEFAULT => -208
	},
	{#State 89
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'ArrayReference' => 86,
			'SubExpression' => 145,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'HashDereferenced' => 115,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 90
		ACTIONS => {
			'OP01_PRINT_VOID' => 116,
			'' => -18,
			'OP05_LOGICAL_NEG' => 117,
			"my" => 118,
			'OP01_OPEN' => 94,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP19_LOOP_CONTROL' => 106,
			"while (" => -138,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_NAMED_VOID' => 108,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			"foreach my" => -138,
			'WORD' => 95,
			"if (" => 96,
			"undef" => 77,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'SubExpression' => 119,
			'Operator' => 120,
			'VariableDeclaration' => 121,
			'OPTIONAL-37' => 93,
			'VariableModification' => 92,
			'HashDereferenced' => 115,
			'LoopLabel' => 112,
			'Operation' => 146,
			'PAREN-36' => 110,
			'WordScoped' => 87,
			'Expression' => 105,
			'ArrayReference' => 86,
			'Conditional' => 83,
			'ArrayDereferenced' => 99,
			'Statement' => 100,
			'HashReference' => 98,
			'Variable' => 80,
			'Literal' => 97,
			'OperatorVoid' => 78
		}
	},
	{#State 91
		ACTIONS => {
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'SubExpression' => 147
		}
	},
	{#State 92
		DEFAULT => -143
	},
	{#State 93
		ACTIONS => {
			"while (" => 152,
			"for my integer" => 148,
			"foreach my" => 153
		},
		GOTOS => {
			'LoopWhile' => 151,
			'LoopFor' => 154,
			'LoopForEach' => 149,
			'Loop' => 150
		}
	},
	{#State 94
		ACTIONS => {
			'STDIN_STDOUT_STDERR' => 155,
			"my" => 157
		},
		GOTOS => {
			'FileHandleOpen' => 156
		}
	},
	{#State 95
		ACTIONS => {
			'COLON' => -199,
			'LEFT_PAREN' => -197
		}
	},
	{#State 96
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'ArrayReference' => 86,
			'SubExpression' => 158,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'HashDereferenced' => 115,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 97
		DEFAULT => -126
	},
	{#State 98
		DEFAULT => -130
	},
	{#State 99
		DEFAULT => -129
	},
	{#State 100
		DEFAULT => -83
	},
	{#State 101
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'LEFT_BRACKET' => 104,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'SubExpression' => 159,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86,
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134
		}
	},
	{#State 102
		ACTIONS => {
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'LEFT_BRACKET' => 104,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 160,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'SubExpression' => 161,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'HashDereferenced' => 115
		}
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 84
		},
		GOTOS => {
			'Variable' => 162
		}
	},
	{#State 104
		ACTIONS => {
			'KEYS_OR_VALUES' => 165,
			'OP01_OPEN' => 94,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			"%{" => 109,
			"]" => -181,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NOT' => 101,
			'OP01_QW' => 169,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'ListElement' => 163,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97,
			'Expression' => 135,
			'WordScoped' => 87,
			'OPTIONAL-47' => 167,
			'TypeInner' => 168,
			'Operator' => 120,
			'SubExpression' => 164,
			'ArrayReference' => 86,
			'ListElements' => 166,
			'HashDereferenced' => 115
		}
	},
	{#State 105
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -124,
			'OP15_LOGICAL_AND' => -124,
			'OP06_REGEX_MATCH' => -124,
			'OP14_BITWISE_OR_XOR' => -124,
			'OP11_COMPARE_LT_GT' => -124,
			'OP13_BITWISE_AND' => -124,
			'OP18_TERNARY' => -124,
			'OP04_MATH_POW' => -124,
			'OP12_COMPARE_EQ_NEQ' => -124,
			'OP17_LIST_RANGE' => -124,
			";" => 170,
			'OP08_MATH_ADD_SUB' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP16_LOGICAL_OR' => -124,
			'OP07_MATH_MULT_DIV_MOD' => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP08_STRING_CAT' => -124
		}
	},
	{#State 106
		ACTIONS => {
			'WORD' => 171
		},
		GOTOS => {
			'LoopLabel' => 172
		}
	},
	{#State 107
		ACTIONS => {
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85
		},
		GOTOS => {
			'Literal' => 97,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'Operator' => 120,
			'SubExpression' => 173
		}
	},
	{#State 108
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			";" => -112,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			"my" => 73,
			'KEYS_OR_VALUES' => 165,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'OP22_LOGICAL_NOT' => 101,
			'OP01_QW' => 169,
			'LEFT_BRACE' => 82
		},
		GOTOS => {
			'Literal' => 97,
			'OPTIONAL-33' => 175,
			'ArrayDereferenced' => 99,
			'Variable' => 134,
			'HashReference' => 98,
			'ListElement' => 163,
			'ListElements' => 174,
			'HashDereferenced' => 115,
			'Operator' => 120,
			'TypeInner' => 168,
			'SubExpression' => 164,
			'Expression' => 135,
			'WordScoped' => 87,
			'ArrayReference' => 86
		}
	},
	{#State 109
		ACTIONS => {
			'LEFT_BRACE' => 177,
			'VARIABLE_SYMBOL' => 84
		},
		GOTOS => {
			'Variable' => 178,
			'HashReference' => 176
		}
	},
	{#State 110
		DEFAULT => -137
	},
	{#State 111
		DEFAULT => -17
	},
	{#State 112
		ACTIONS => {
			'COLON' => 179
		}
	},
	{#State 113
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 181,
			'STDIN_STDOUT_STDERR' => 182
		},
		GOTOS => {
			'FileHandleClose' => 180
		}
	},
	{#State 114
		DEFAULT => -14
	},
	{#State 115
		DEFAULT => -131
	},
	{#State 116
		ACTIONS => {
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'KEYS_OR_VALUES' => 165,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'STDIN_STDOUT_STDERR' => 184,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 185,
			'OP22_LOGICAL_NOT' => 101,
			'OP01_QW' => 169,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Expression' => 135,
			'WordScoped' => 87,
			'TypeInner' => 168,
			'SubExpression' => 164,
			'Operator' => 120,
			'ArrayReference' => 86,
			'FileHandlePrint' => 186,
			'ListElements' => 183,
			'HashDereferenced' => 115,
			'ArrayDereferenced' => 99,
			'ListElement' => 163,
			'Variable' => 134,
			'HashReference' => 98,
			'Literal' => 97
		}
	},
	{#State 117
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'Operator' => 120,
			'SubExpression' => 187,
			'HashDereferenced' => 115
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 188
		}
	},
	{#State 119
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189,
			'OP11_COMPARE_LT_GT' => 197,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP13_BITWISE_AND' => 198,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202
		}
	},
	{#State 120
		DEFAULT => -121
	},
	{#State 121
		DEFAULT => -142
	},
	{#State 122
		ACTIONS => {
			"our %properties = (" => 206,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 207,
			'Properties' => 205
		}
	},
	{#State 123
		DEFAULT => -53
	},
	{#State 124
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 79,
			'WORD' => 95,
			"if (" => 96,
			"undef" => 77,
			'OP05_MATH_NEG' => 81,
			"foreach my" => -138,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_PRINT_VOID' => 116,
			"my" => 118,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'OP19_LOOP_CONTROL' => 106,
			"while (" => -138,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_NAMED_VOID' => 108,
			'OP10_NAMED_UNARY' => 91,
			"for my integer" => -138,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'Statement' => 100,
			'Variable' => 80,
			'HashReference' => 98,
			'Literal' => 97,
			'PLUS-17' => 209,
			'OperatorVoid' => 78,
			'WordScoped' => 87,
			'Expression' => 105,
			'ArrayReference' => 86,
			'Conditional' => 83,
			'LoopLabel' => 112,
			'Operation' => 208,
			'PAREN-36' => 110,
			'Operator' => 120,
			'SubExpression' => 119,
			'VariableDeclaration' => 121,
			'OPTIONAL-37' => 93,
			'VariableModification' => 92,
			'HashDereferenced' => 115
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 210
		}
	},
	{#State 126
		DEFAULT => -42
	},
	{#State 127
		ACTIONS => {
			"\$TYPED_" => 211
		}
	},
	{#State 128
		ACTIONS => {
			";" => 212
		}
	},
	{#State 129
		DEFAULT => -40
	},
	{#State 130
		ACTIONS => {
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'STDIN_PROMPT' => 215
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'SubExpressionOrPrompt' => 213,
			'ArrayReference' => 86,
			'SubExpression' => 214,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'Literal' => 97,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99
		}
	},
	{#State 131
		DEFAULT => -89
	},
	{#State 132
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'SubExpression' => 216,
			'ArrayReference' => 86,
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'Variable' => 134,
			'HashReference' => 98
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 217
		}
	},
	{#State 134
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 133,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP08_STRING_CAT' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP04_MATH_POW' => -127,
			'OP18_TERNARY' => -127,
			"]" => -127,
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP17_LIST_RANGE' => -127,
			";" => -127,
			'OP21_LIST_COMMA' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			"}" => -127,
			'OP03_MATH_INC_DEC' => 131,
			".." => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			")" => -127
		}
	},
	{#State 135
		DEFAULT => -124
	},
	{#State 136
		ACTIONS => {
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP16_LOGICAL_OR' => 201,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => 198,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP06_REGEX_MATCH' => 190,
			")" => 218,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP11_COMPARE_LT_GT' => 197
		}
	},
	{#State 137
		ACTIONS => {
			'OP20_HASH_FATARROW' => 219
		}
	},
	{#State 138
		DEFAULT => -132
	},
	{#State 139
		DEFAULT => -188
	},
	{#State 140
		DEFAULT => -193,
		GOTOS => {
			'STAR-50' => 220
		}
	},
	{#State 141
		ACTIONS => {
			".." => -162,
			'OP09_BITWISE_SHIFT' => -162,
			'OP15_LOGICAL_AND' => -162,
			'OP06_REGEX_MATCH' => -162,
			")" => -162,
			'OP14_BITWISE_OR_XOR' => -162,
			'OP02_ARRAY_THINARROW' => 221,
			"}" => -162,
			'OP11_COMPARE_LT_GT' => -162,
			'OP02_HASH_THINARROW' => 222,
			'OP03_MATH_INC_DEC' => -162,
			'OP13_BITWISE_AND' => -162,
			'OP18_TERNARY' => -162,
			"]" => -162,
			'OP04_MATH_POW' => -162,
			";" => -162,
			'OP19_VARIABLE_ASSIGN_BY' => -162,
			'OP12_COMPARE_EQ_NEQ' => -162,
			'OP17_LIST_RANGE' => -162,
			'COLON' => -162,
			'OP16_LOGICAL_OR' => -162,
			'OP21_LIST_COMMA' => -162,
			'OP08_MATH_ADD_SUB' => -162,
			'OP24_LOGICAL_OR_XOR' => -162,
			'OP07_MATH_MULT_DIV_MOD' => -162,
			'OP02_METHOD_THINARROW' => -162,
			'OP23_LOGICAL_AND' => -162,
			'OP19_VARIABLE_ASSIGN' => -162,
			'OP08_STRING_CAT' => -162
		},
		GOTOS => {
			'VariableRetrieval' => 223
		}
	},
	{#State 142
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 143
		ACTIONS => {
			"}" => 225
		}
	},
	{#State 144
		ACTIONS => {
			'OP01_OPEN' => 94,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'KEYS_OR_VALUES' => 165,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'OP01_QW' => 169,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			")" => -118,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ListElements' => 226,
			'ArrayReference' => 86,
			'OPTIONAL-34' => 227,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'TypeInner' => 168,
			'SubExpression' => 164,
			'Literal' => 97,
			'ListElement' => 163,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99
		}
	},
	{#State 145
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP08_STRING_CAT' => -84,
			'OP13_BITWISE_AND' => -84,
			"]" => -84,
			'OP18_TERNARY' => -84,
			'OP04_MATH_POW' => -84,
			'OP12_COMPARE_EQ_NEQ' => -84,
			'OP17_LIST_RANGE' => -84,
			";" => -84,
			'OP21_LIST_COMMA' => -84,
			'OP16_LOGICAL_OR' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			"}" => -84,
			'OP09_BITWISE_SHIFT' => -84,
			".." => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			")" => -84
		}
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		ACTIONS => {
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => -98,
			".." => -98,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 195,
			";" => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP04_MATH_POW' => 192,
			"]" => -98,
			'OP18_TERNARY' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 202
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 228
		}
	},
	{#State 149
		DEFAULT => -152
	},
	{#State 150
		DEFAULT => -140
	},
	{#State 151
		DEFAULT => -153
	},
	{#State 152
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'Operator' => 120,
			'SubExpression' => 229,
			'Expression' => 135,
			'WordScoped' => 87,
			'ArrayReference' => 86,
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134
		}
	},
	{#State 153
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 230
		}
	},
	{#State 154
		DEFAULT => -151
	},
	{#State 155
		DEFAULT => -202
	},
	{#State 156
		ACTIONS => {
			'OP21_LIST_COMMA' => 231
		}
	},
	{#State 157
		ACTIONS => {
			"filehandle_ref" => 232
		}
	},
	{#State 158
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => 233,
			'OP11_COMPARE_LT_GT' => 197,
			'OP13_BITWISE_AND' => 198,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 159
		ACTIONS => {
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP21_LIST_COMMA' => -108,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP16_LOGICAL_OR' => 201,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			";" => -108,
			'OP18_TERNARY' => 193,
			"]" => -108,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -108,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -108,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 196,
			".." => -108,
			'OP09_BITWISE_SHIFT' => 189
		}
	},
	{#State 160
		ACTIONS => {
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'KEYS_OR_VALUES' => 165,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'Variable' => 134,
			'HashReference' => 98,
			'ListElement' => 234,
			'Literal' => 97,
			'TypeInner' => 168,
			'Operator' => 120,
			'SubExpression' => 235,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 161
		ACTIONS => {
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP13_BITWISE_AND' => 198,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP11_COMPARE_LT_GT' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => 236,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196
		}
	},
	{#State 162
		DEFAULT => -88
	},
	{#State 163
		DEFAULT => -172,
		GOTOS => {
			'STAR-45' => 237
		}
	},
	{#State 164
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			'OP06_REGEX_MATCH' => 190,
			")" => -177,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			";" => -177,
			'OP21_LIST_COMMA' => -177,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP13_BITWISE_AND' => 198,
			"]" => -177,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192
		}
	},
	{#State 165
		ACTIONS => {
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 238
		}
	},
	{#State 166
		DEFAULT => -180
	},
	{#State 167
		ACTIONS => {
			"]" => 239
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'SubExpression' => 240,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 169
		ACTIONS => {
			'LEFT_PAREN' => 241
		}
	},
	{#State 170
		DEFAULT => -82
	},
	{#State 171
		DEFAULT => -199
	},
	{#State 172
		ACTIONS => {
			";" => 242
		}
	},
	{#State 173
		ACTIONS => {
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => -99,
			"]" => -99,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => -99,
			")" => -99,
			".." => -99,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => -99,
			"}" => -99,
			'OP11_COMPARE_LT_GT' => -99
		}
	},
	{#State 174
		DEFAULT => -111
	},
	{#State 175
		ACTIONS => {
			";" => 243
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => 137,
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 139,
			'HashEntry' => 140
		}
	},
	{#State 178
		ACTIONS => {
			"}" => 245
		}
	},
	{#State 179
		DEFAULT => -136
	},
	{#State 180
		DEFAULT => -87
	},
	{#State 181
		DEFAULT => -205
	},
	{#State 182
		DEFAULT => -204
	},
	{#State 183
		ACTIONS => {
			";" => 246
		}
	},
	{#State 184
		DEFAULT => -206
	},
	{#State 185
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 247,
			"}" => 138,
			'WORD' => 137,
			"%{" => 109
		},
		GOTOS => {
			'HashEntry' => 140,
			'HashDereferenced' => 139
		}
	},
	{#State 186
		ACTIONS => {
			'KEYS_OR_VALUES' => 165,
			'OP01_OPEN' => 94,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_QW' => 169,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'ListElement' => 163,
			'ListElements' => 248,
			'HashDereferenced' => 115,
			'Operator' => 120,
			'TypeInner' => 168,
			'SubExpression' => 164,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86
		}
	},
	{#State 187
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -91,
			")" => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP15_LOGICAL_AND' => -91,
			".." => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			"}" => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91,
			'OP18_TERNARY' => -91,
			"]" => -91,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91
		}
	},
	{#State 188
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 189
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'Operator' => 120,
			'SubExpression' => 250
		}
	},
	{#State 190
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 251
		}
	},
	{#State 191
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'SubExpression' => 252,
			'HashDereferenced' => 115
		}
	},
	{#State 192
		ACTIONS => {
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97,
			'Operator' => 120,
			'SubExpression' => 253,
			'Expression' => 135,
			'WordScoped' => 87,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 84
		},
		GOTOS => {
			'Variable' => 254
		}
	},
	{#State 194
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'Variable' => 134,
			'HashReference' => 98,
			'HashDereferenced' => 115,
			'SubExpression' => 255,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86
		}
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'Operator' => 120,
			'SubExpression' => 256,
			'Expression' => 135,
			'WordScoped' => 87,
			'HashDereferenced' => 115
		}
	},
	{#State 196
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'SubExpression' => 257,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 197
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'SubExpression' => 258,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86,
			'HashDereferenced' => 115,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97
		}
	},
	{#State 198
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'SubExpression' => 259,
			'Operator' => 120,
			'Expression' => 135,
			'WordScoped' => 87,
			'HashDereferenced' => 115
		}
	},
	{#State 199
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayReference' => 86,
			'SubExpression' => 260,
			'Operator' => 120,
			'Expression' => 135,
			'WordScoped' => 87,
			'HashDereferenced' => 115,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 200
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP05_MATH_NEG' => 81,
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'Operator' => 120,
			'SubExpression' => 261,
			'Expression' => 135,
			'WordScoped' => 87,
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 201
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'SubExpression' => 262,
			'Operator' => 120,
			'Expression' => 135,
			'WordScoped' => 87,
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 202
		ACTIONS => {
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'SubExpression' => 263,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86,
			'Literal' => 97,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134
		}
	},
	{#State 203
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'SubExpression' => 264,
			'HashDereferenced' => 115
		}
	},
	{#State 204
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'Operator' => 120,
			'SubExpression' => 265,
			'Expression' => 135,
			'WordScoped' => 87,
			'ArrayReference' => 86,
			'HashDereferenced' => 115,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97
		}
	},
	{#State 205
		ACTIONS => {
			"our %properties_class = (" => 267,
			'LITERAL_NUMBER' => -58,
			"our" => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 268,
			'PropertiesClass' => 266
		}
	},
	{#State 206
		ACTIONS => {
			")" => 270,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 269
		}
	},
	{#State 207
		DEFAULT => -55
	},
	{#State 208
		DEFAULT => -45
	},
	{#State 209
		ACTIONS => {
			'OP01_CLOSE' => 113,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED_VOID' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP19_LOOP_CONTROL' => 106,
			"while (" => -138,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 94,
			"my" => 118,
			'OP01_PRINT_VOID' => 116,
			'OP05_LOGICAL_NEG' => 117,
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 95,
			"if (" => 96,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP22_LOGICAL_NOT' => 101,
			"}" => 272,
			'LEFT_BRACE' => 82
		},
		GOTOS => {
			'Conditional' => 83,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 105,
			'OperatorVoid' => 78,
			'Literal' => 97,
			'Variable' => 80,
			'HashReference' => 98,
			'Statement' => 100,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'VariableModification' => 92,
			'OPTIONAL-37' => 93,
			'VariableDeclaration' => 121,
			'SubExpression' => 119,
			'Operator' => 120,
			'PAREN-36' => 110,
			'Operation' => 271,
			'LoopLabel' => 112
		}
	},
	{#State 210
		ACTIONS => {
			'VARIABLE_SYMBOL' => 273
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 274
		}
	},
	{#State 212
		DEFAULT => -41
	},
	{#State 213
		ACTIONS => {
			";" => 275
		}
	},
	{#State 214
		ACTIONS => {
			'OP13_BITWISE_AND' => 198,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			";" => -134,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP11_COMPARE_LT_GT' => 197
		}
	},
	{#State 215
		DEFAULT => -135
	},
	{#State 216
		ACTIONS => {
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 201,
			";" => 276,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP11_COMPARE_LT_GT' => 197,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189
		}
	},
	{#State 217
		ACTIONS => {
			'LEFT_PAREN' => 277
		}
	},
	{#State 218
		DEFAULT => -92
	},
	{#State 219
		ACTIONS => {
			"my" => 73,
			'OP05_LOGICAL_NEG' => -186,
			'OP01_OPEN' => -186,
			'OP01_CLOSE' => -186,
			'OP10_NAMED_UNARY' => -186,
			'OP10_NAMED_UNARY_STRINGIFY' => -186,
			'WORD_SCOPED' => -186,
			'OP01_NAMED' => -186,
			"%{" => -186,
			'LITERAL_STRING' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'LEFT_PAREN' => -186,
			'VARIABLE_SYMBOL' => -186,
			"\@{" => -186,
			'LEFT_BRACKET' => -186,
			'LEFT_BRACE' => -186,
			'OP22_LOGICAL_NOT' => -186,
			'OP05_MATH_NEG' => -186,
			"undef" => -186,
			'WORD' => -186,
			'LITERAL_NUMBER' => -186
		},
		GOTOS => {
			'OPTIONAL-48' => 279,
			'TypeInner' => 278
		}
	},
	{#State 220
		ACTIONS => {
			'OP21_LIST_COMMA' => 282,
			"}" => 281
		},
		GOTOS => {
			'PAREN-49' => 280
		}
	},
	{#State 221
		ACTIONS => {
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'Operator' => 120,
			'SubExpression' => 283
		}
	},
	{#State 222
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 285,
			'LITERAL_NUMBER' => 79,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'Variable' => 134,
			'HashReference' => 98,
			'Literal' => 97,
			'WordScoped' => 87,
			'Expression' => 135,
			'SubExpression' => 284,
			'Operator' => 120,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 223
		DEFAULT => -160
	},
	{#State 224
		DEFAULT => -184
	},
	{#State 225
		DEFAULT => -183
	},
	{#State 226
		DEFAULT => -117
	},
	{#State 227
		ACTIONS => {
			")" => 286
		}
	},
	{#State 228
		ACTIONS => {
			'LEFT_PAREN' => 287
		}
	},
	{#State 229
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => 288,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => 198,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200
		}
	},
	{#State 230
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 231
		ACTIONS => {
			'LITERAL_STRING' => 290
		}
	},
	{#State 232
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 291
		}
	},
	{#State 233
		ACTIONS => {
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 292
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => 294
		}
	},
	{#State 235
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP21_LIST_COMMA' => -177,
			'OP16_LOGICAL_OR' => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP12_COMPARE_EQ_NEQ' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP04_MATH_POW' => -84,
			'OP18_TERNARY' => -84,
			'OP13_BITWISE_AND' => -84,
			'OP08_STRING_CAT' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			")" => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			'OP11_COMPARE_LT_GT' => -84
		}
	},
	{#State 236
		DEFAULT => -133
	},
	{#State 237
		ACTIONS => {
			'OP21_LIST_COMMA' => 296,
			")" => -175,
			";" => -175,
			"]" => -175
		},
		GOTOS => {
			'PAREN-44' => 295
		}
	},
	{#State 238
		DEFAULT => -179
	},
	{#State 239
		DEFAULT => -182
	},
	{#State 240
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => 198,
			"]" => -178,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			";" => -178,
			'OP21_LIST_COMMA' => -178,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200
		}
	},
	{#State 241
		ACTIONS => {
			'WORD' => 297
		},
		GOTOS => {
			'PLUS-46' => 298
		}
	},
	{#State 242
		DEFAULT => -116
	},
	{#State 243
		DEFAULT => -113
	},
	{#State 244
		DEFAULT => -196
	},
	{#State 245
		DEFAULT => -195
	},
	{#State 246
		DEFAULT => -114
	},
	{#State 247
		ACTIONS => {
			"}" => 299
		}
	},
	{#State 248
		ACTIONS => {
			";" => 300
		}
	},
	{#State 249
		ACTIONS => {
			";" => 301,
			'OP19_VARIABLE_ASSIGN' => 302
		}
	},
	{#State 250
		ACTIONS => {
			'OP04_MATH_POW' => 192,
			"]" => -97,
			'OP18_TERNARY' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP12_COMPARE_EQ_NEQ' => -97,
			";" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => -97,
			".." => -97,
			'OP09_BITWISE_SHIFT' => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => -97,
			"}" => -97
		}
	},
	{#State 251
		DEFAULT => -93
	},
	{#State 252
		ACTIONS => {
			'OP18_TERNARY' => -103,
			"]" => -103,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP21_LIST_COMMA' => -103,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			";" => -103,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => -103,
			'OP09_BITWISE_SHIFT' => 189,
			".." => -103,
			")" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP06_REGEX_MATCH' => 190,
			"}" => -103,
			'OP11_COMPARE_LT_GT' => 197
		}
	},
	{#State 253
		ACTIONS => {
			'OP13_BITWISE_AND' => -90,
			"]" => -90,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP12_COMPARE_EQ_NEQ' => -90,
			";" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			".." => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90
		}
	},
	{#State 254
		ACTIONS => {
			'COLON' => 303
		}
	},
	{#State 255
		ACTIONS => {
			")" => -106,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 196,
			".." => -106,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => 197,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			";" => -106,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 202
		}
	},
	{#State 256
		ACTIONS => {
			'OP08_STRING_CAT' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP04_MATH_POW' => 192,
			"]" => -95,
			'OP18_TERNARY' => -95,
			'OP13_BITWISE_AND' => -95,
			"}" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			")" => -95,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			".." => -95
		}
	},
	{#State 257
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 189,
			".." => -104,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -104,
			'OP06_REGEX_MATCH' => 190,
			"}" => -104,
			'OP11_COMPARE_LT_GT' => 197,
			'OP18_TERNARY' => -104,
			"]" => -104,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP16_LOGICAL_OR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_MATH_ADD_SUB' => 195,
			";" => -104,
			'OP17_LIST_RANGE' => -104,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP23_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 258
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP17_LIST_RANGE' => -100,
			";" => -100,
			'OP08_MATH_ADD_SUB' => 195,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -100,
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 190,
			")" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			".." => -100,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -100
		}
	},
	{#State 259
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -102,
			'OP15_LOGICAL_AND' => -102,
			".." => -102,
			'OP09_BITWISE_SHIFT' => 189,
			'OP14_BITWISE_OR_XOR' => -102,
			")" => -102,
			'OP06_REGEX_MATCH' => 190,
			'OP23_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP18_TERNARY' => -102,
			"]" => -102,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => -102,
			";" => -102
		}
	},
	{#State 260
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -101,
			".." => -101,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 190,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NEQ' => undef,
			";" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 261
		ACTIONS => {
			'OP18_TERNARY' => 193,
			"]" => -110,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP08_MATH_ADD_SUB' => 195,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => 201,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			";" => -110,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP15_LOGICAL_AND' => 196,
			".." => -110,
			'OP09_BITWISE_SHIFT' => 189,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -110,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -110
		}
	},
	{#State 262
		ACTIONS => {
			".." => -105,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -105,
			"}" => -105,
			'OP11_COMPARE_LT_GT' => 197,
			'OP13_BITWISE_AND' => 198,
			"]" => -105,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -105,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP21_LIST_COMMA' => -105,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 263
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => -94,
			")" => -94,
			".." => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP15_LOGICAL_AND' => -94,
			"}" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			";" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP12_COMPARE_EQ_NEQ' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP13_BITWISE_AND' => -94,
			"]" => -94,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP23_LOGICAL_AND' => -94
		}
	},
	{#State 264
		ACTIONS => {
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189,
			".." => -109,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -109,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -109,
			'OP04_MATH_POW' => 192,
			"]" => -109,
			'OP18_TERNARY' => 193,
			'OP13_BITWISE_AND' => 198,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			";" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 265
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			")" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			".." => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP15_LOGICAL_AND' => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			";" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => -96,
			'OP08_STRING_CAT' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -96
		}
	},
	{#State 266
		DEFAULT => -57
	},
	{#State 267
		ACTIONS => {
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 304
		}
	},
	{#State 268
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 305
		}
	},
	{#State 269
		ACTIONS => {
			"%{" => 109,
			'WORD' => 308
		},
		GOTOS => {
			'HashDereferenced' => 307,
			'HashEntryTyped' => 306
		}
	},
	{#State 270
		ACTIONS => {
			";" => 309
		}
	},
	{#State 271
		DEFAULT => -44
	},
	{#State 272
		ACTIONS => {
			";" => 310
		}
	},
	{#State 273
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 311
		}
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 275
		DEFAULT => -168
	},
	{#State 276
		DEFAULT => -169
	},
	{#State 277
		ACTIONS => {
			'OP01_QW' => 169,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81,
			")" => -120,
			'KEYS_OR_VALUES' => 165,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			"my" => 73,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'ArrayReference' => 86,
			'Operator' => 120,
			'SubExpression' => 164,
			'TypeInner' => 168,
			'Expression' => 135,
			'WordScoped' => 87,
			'HashDereferenced' => 115,
			'ListElements' => 314,
			'Variable' => 134,
			'HashReference' => 98,
			'OPTIONAL-35' => 313,
			'ListElement' => 163,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 278
		DEFAULT => -185
	},
	{#State 279
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'ArrayReference' => 86,
			'SubExpression' => 315,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'HashDereferenced' => 115,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 280
		DEFAULT => -192
	},
	{#State 281
		DEFAULT => -194
	},
	{#State 282
		ACTIONS => {
			"%{" => 109,
			'WORD' => 137
		},
		GOTOS => {
			'HashDereferenced' => 139,
			'HashEntry' => 316
		}
	},
	{#State 283
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 201,
			'OP13_BITWISE_AND' => 198,
			"]" => 317,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP08_STRING_CAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP11_COMPARE_LT_GT' => 197
		}
	},
	{#State 284
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			"}" => 318,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => 198,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 201,
			'OP24_LOGICAL_OR_XOR' => 200
		}
	},
	{#State 285
		ACTIONS => {
			"}" => 319,
			'LEFT_PAREN' => -197
		}
	},
	{#State 286
		DEFAULT => -122
	},
	{#State 287
		ACTIONS => {
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'Operator' => 120,
			'SubExpression' => 320,
			'Literal' => 97,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99
		}
	},
	{#State 288
		ACTIONS => {
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 289
		ACTIONS => {
			'LEFT_PAREN' => 322
		}
	},
	{#State 290
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 291
		DEFAULT => -203
	},
	{#State 292
		DEFAULT => -146,
		GOTOS => {
			'STAR-39' => 324
		}
	},
	{#State 293
		ACTIONS => {
			'OP01_CLOSE' => 113,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED_VOID' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP19_LOOP_CONTROL' => 106,
			"while (" => -138,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 94,
			"my" => 118,
			'OP01_PRINT_VOID' => 116,
			'OP05_LOGICAL_NEG' => 117,
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			"if (" => 96,
			'WORD' => 95,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'VariableModification' => 92,
			'OPTIONAL-37' => 93,
			'SubExpression' => 119,
			'Operator' => 120,
			'VariableDeclaration' => 121,
			'PAREN-36' => 110,
			'Operation' => 325,
			'LoopLabel' => 112,
			'Conditional' => 83,
			'PLUS-42' => 326,
			'ArrayReference' => 86,
			'Expression' => 105,
			'WordScoped' => 87,
			'OperatorVoid' => 78,
			'Literal' => 97,
			'HashReference' => 98,
			'Variable' => 80,
			'ArrayDereferenced' => 99,
			'Statement' => 100
		}
	},
	{#State 294
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			'OP01_QW' => 169,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'OP05_MATH_NEG' => 81,
			'KEYS_OR_VALUES' => 165,
			'OP01_OPEN' => 94,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'WordScoped' => 87,
			'Expression' => 135,
			'SubExpression' => 164,
			'TypeInner' => 168,
			'Operator' => 120,
			'ArrayReference' => 86,
			'ListElements' => 327,
			'HashDereferenced' => 115,
			'ArrayDereferenced' => 99,
			'ListElement' => 163,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97
		}
	},
	{#State 295
		DEFAULT => -171
	},
	{#State 296
		ACTIONS => {
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 94,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'KEYS_OR_VALUES' => 165
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'ListElement' => 328,
			'Variable' => 134,
			'HashReference' => 98,
			'Literal' => 97,
			'Expression' => 135,
			'WordScoped' => 87,
			'TypeInner' => 168,
			'Operator' => 120,
			'SubExpression' => 164,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 297
		DEFAULT => -174
	},
	{#State 298
		ACTIONS => {
			")" => 329,
			'WORD' => 330
		}
	},
	{#State 299
		DEFAULT => -207
	},
	{#State 300
		DEFAULT => -115
	},
	{#State 301
		DEFAULT => -166
	},
	{#State 302
		ACTIONS => {
			'WORD' => 24,
			"undef" => 77,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 81,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_BRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'STDIN_PROMPT' => 215,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'ArrayReference' => 86,
			'Expression' => 135,
			'WordScoped' => 87,
			'Operator' => 120,
			'SubExpression' => 214,
			'HashDereferenced' => 115,
			'SubExpressionOrPrompt' => 331,
			'HashReference' => 98,
			'Variable' => 134,
			'ArrayDereferenced' => 99,
			'Literal' => 97
		}
	},
	{#State 303
		ACTIONS => {
			'VARIABLE_SYMBOL' => 84
		},
		GOTOS => {
			'Variable' => 332
		}
	},
	{#State 304
		ACTIONS => {
			"%{" => 109,
			'WORD' => 308
		},
		GOTOS => {
			'HashEntryTyped' => 333,
			'HashDereferenced' => 307
		}
	},
	{#State 305
		ACTIONS => {
			"our" => 334,
			'LITERAL_NUMBER' => 336
		},
		GOTOS => {
			'MethodOrSubroutine' => 338,
			'Method' => 337,
			'Subroutine' => 335
		}
	},
	{#State 306
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 339
		}
	},
	{#State 307
		DEFAULT => -190
	},
	{#State 308
		ACTIONS => {
			'OP20_HASH_FATARROW' => 340
		}
	},
	{#State 309
		ACTIONS => {
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 341
		}
	},
	{#State 310
		DEFAULT => -46
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 343,
			")" => 344
		},
		GOTOS => {
			'PAREN-18' => 342
		}
	},
	{#State 312
		DEFAULT => -201
	},
	{#State 313
		ACTIONS => {
			")" => 345
		}
	},
	{#State 314
		DEFAULT => -119
	},
	{#State 315
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			"}" => -187,
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP13_BITWISE_AND' => 198,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP21_LIST_COMMA' => -187,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199
		}
	},
	{#State 316
		DEFAULT => -191
	},
	{#State 317
		DEFAULT => -163
	},
	{#State 318
		DEFAULT => -164
	},
	{#State 319
		DEFAULT => -165
	},
	{#State 320
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => 198,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP16_LOGICAL_OR' => 201,
			'OP11_COMPARE_LT_GT' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			".." => 346,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191
		}
	},
	{#State 321
		DEFAULT => -156
	},
	{#State 322
		ACTIONS => {
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'KEYS_OR_VALUES' => 165,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP01_QW' => 169,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 98,
			'ListElement' => 163,
			'ArrayDereferenced' => 99,
			'Literal' => 97,
			'ArrayReference' => 86,
			'TypeInner' => 168,
			'SubExpression' => 164,
			'Operator' => 120,
			'Expression' => 135,
			'WordScoped' => 87,
			'HashDereferenced' => 115,
			'ListElements' => 347
		}
	},
	{#State 323
		ACTIONS => {
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'LEFT_BRACKET' => 104,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'WordScoped' => 87,
			'Expression' => 135,
			'SubExpression' => 348,
			'Operator' => 120,
			'ArrayReference' => 86,
			'HashDereferenced' => 115,
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97
		}
	},
	{#State 324
		ACTIONS => {
			'OP10_NAMED_UNARY' => -149,
			'LITERAL_STRING' => -149,
			'OP01_NAMED' => -149,
			'OP01_OPEN' => -149,
			'' => -149,
			'OP05_MATH_NEG' => -149,
			'LITERAL_NUMBER' => -149,
			"undef" => -149,
			"\@{" => -149,
			'VARIABLE_SYMBOL' => -149,
			'LEFT_BRACE' => -149,
			"for my integer" => -149,
			'OP01_CLOSE' => -149,
			"%{" => -149,
			'WORD_SCOPED' => -149,
			"while (" => -149,
			'OP19_LOOP_CONTROL' => -149,
			'OP01_NAMED_VOID' => -149,
			'OP10_NAMED_UNARY_STRINGIFY' => -149,
			"elsif (" => 353,
			'OP01_PRINT_VOID' => -149,
			'OP05_LOGICAL_NEG' => -149,
			"my" => -149,
			"foreach my" => -149,
			"else" => 350,
			"if (" => -149,
			'WORD' => -149,
			'LEFT_BRACKET' => -149,
			'LEFT_PAREN' => -149,
			'OP03_MATH_INC_DEC' => -149,
			'OP22_LOGICAL_NOT' => -149,
			"}" => -149
		},
		GOTOS => {
			'PAREN-40' => 349,
			'OPTIONAL-41' => 351,
			'PAREN-38' => 352
		}
	},
	{#State 325
		DEFAULT => -158
	},
	{#State 326
		ACTIONS => {
			"}" => 355,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'LEFT_BRACKET' => 104,
			"undef" => 77,
			"if (" => 96,
			'WORD' => 95,
			'LITERAL_NUMBER' => 79,
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			"my" => 118,
			'OP01_PRINT_VOID' => 116,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP01_NAMED_VOID' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			"while (" => -138,
			'OP19_LOOP_CONTROL' => 106,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP01_CLOSE' => 113,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'OperatorVoid' => 78,
			'Literal' => 97,
			'HashReference' => 98,
			'Variable' => 80,
			'ArrayDereferenced' => 99,
			'Statement' => 100,
			'Conditional' => 83,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 105,
			'PAREN-36' => 110,
			'Operation' => 354,
			'LoopLabel' => 112,
			'HashDereferenced' => 115,
			'VariableModification' => 92,
			'OPTIONAL-37' => 93,
			'Operator' => 120,
			'SubExpression' => 119,
			'VariableDeclaration' => 121
		}
	},
	{#State 327
		ACTIONS => {
			")" => 356
		}
	},
	{#State 328
		DEFAULT => -170
	},
	{#State 329
		DEFAULT => -176
	},
	{#State 330
		DEFAULT => -173
	},
	{#State 331
		ACTIONS => {
			";" => 357
		}
	},
	{#State 332
		DEFAULT => -107
	},
	{#State 333
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 358
		}
	},
	{#State 334
		ACTIONS => {
			'WORD' => 53,
			'TYPE_METHOD' => 359
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 335
		DEFAULT => -81
	},
	{#State 336
		ACTIONS => {
			";" => 360
		}
	},
	{#State 337
		DEFAULT => -80
	},
	{#State 338
		DEFAULT => -59
	},
	{#State 339
		ACTIONS => {
			")" => 361,
			'OP21_LIST_COMMA' => 362
		},
		GOTOS => {
			'PAREN-25' => 363
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
		DEFAULT => -48
	},
	{#State 343
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 345
		DEFAULT => -123
	},
	{#State 346
		ACTIONS => {
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 24,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'Literal' => 97,
			'Variable' => 134,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 115,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 135,
			'SubExpression' => 367,
			'Operator' => 120
		}
	},
	{#State 347
		ACTIONS => {
			")" => 368
		}
	},
	{#State 348
		ACTIONS => {
			"}" => -86,
			'OP11_COMPARE_LT_GT' => 197,
			".." => -86,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			")" => -86,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => 204,
			'OP13_BITWISE_AND' => 198,
			"]" => -86,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			";" => -86,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP17_LIST_RANGE' => 194,
			'OP21_LIST_COMMA' => -86,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -86
		}
	},
	{#State 349
		DEFAULT => -148
	},
	{#State 350
		ACTIONS => {
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 351
		DEFAULT => -150
	},
	{#State 352
		DEFAULT => -145
	},
	{#State 353
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP05_LOGICAL_NEG' => 117,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP01_NAMED' => 89,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 113,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 84,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 79,
			'WORD' => 24,
			"undef" => 77,
			'OP05_MATH_NEG' => 81
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97,
			'SubExpression' => 370,
			'Operator' => 120,
			'WordScoped' => 87,
			'Expression' => 135,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 354
		DEFAULT => -157
	},
	{#State 355
		DEFAULT => -159
	},
	{#State 356
		DEFAULT => -85
	},
	{#State 357
		DEFAULT => -167
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 373,
			")" => 371
		},
		GOTOS => {
			'PAREN-27' => 372
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 360
		DEFAULT => -61
	},
	{#State 361
		ACTIONS => {
			";" => 375
		}
	},
	{#State 362
		ACTIONS => {
			"%{" => 109,
			'WORD' => 308
		},
		GOTOS => {
			'HashDereferenced' => 307,
			'HashEntryTyped' => 376
		}
	},
	{#State 363
		DEFAULT => -63
	},
	{#State 364
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_BRACKET' => 104,
			'LEFT_BRACE' => 82,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 81,
			"undef" => 77,
			'WORD' => 24,
			'LITERAL_NUMBER' => 79,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'WORD_SCOPED' => 25,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashReference' => 98,
			'Variable' => 134,
			'Literal' => 97,
			'WordScoped' => 87,
			'Expression' => 135,
			'SubExpression' => 377,
			'Operator' => 120,
			'ArrayReference' => 86,
			'HashDereferenced' => 115
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 53
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
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			")" => 380,
			'OP14_BITWISE_OR_XOR' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_STRING_CAT' => 204,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP13_BITWISE_AND' => 198
		}
	},
	{#State 368
		ACTIONS => {
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 369
		DEFAULT => -147
	},
	{#State 370
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => 382,
			'OP11_COMPARE_LT_GT' => 197,
			'OP13_BITWISE_AND' => 198,
			'OP18_TERNARY' => 193,
			'OP04_MATH_POW' => 192,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP23_LOGICAL_AND' => 203,
			'OP08_STRING_CAT' => 204
		}
	},
	{#State 371
		ACTIONS => {
			";" => 383
		}
	},
	{#State 372
		DEFAULT => -68
	},
	{#State 373
		ACTIONS => {
			"%{" => 109,
			'WORD' => 308
		},
		GOTOS => {
			'HashEntryTyped' => 384,
			'HashDereferenced' => 307
		}
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 385
		}
	},
	{#State 375
		DEFAULT => -65
	},
	{#State 376
		DEFAULT => -62
	},
	{#State 377
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 197,
			'OP15_LOGICAL_AND' => 196,
			'OP09_BITWISE_SHIFT' => 189,
			'OP14_BITWISE_OR_XOR' => 191,
			")" => -189,
			'OP06_REGEX_MATCH' => 190,
			'OP23_LOGICAL_AND' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 202,
			'OP08_STRING_CAT' => 204,
			'OP04_MATH_POW' => 192,
			'OP18_TERNARY' => 193,
			'OP13_BITWISE_AND' => 198,
			'OP24_LOGICAL_OR_XOR' => 200,
			'OP21_LIST_COMMA' => -189,
			'OP16_LOGICAL_OR' => 201,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 194,
			'OP12_COMPARE_EQ_NEQ' => 199
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
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 381
		DEFAULT => -155
	},
	{#State 382
		ACTIONS => {
			'LEFT_BRACE' => 293
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 383
		DEFAULT => -70
	},
	{#State 384
		DEFAULT => -67
	},
	{#State 385
		ACTIONS => {
			'LITERAL_NUMBER' => -72,
			'WORD' => -72,
			"if (" => -72,
			"undef" => -72,
			'OP05_MATH_NEG' => -72,
			"foreach my" => -72,
			'OP22_LOGICAL_NOT' => -72,
			'LEFT_BRACE' => -72,
			'LEFT_BRACKET' => -72,
			"\@{" => -72,
			'VARIABLE_SYMBOL' => -72,
			'LEFT_PAREN' => -72,
			'OP03_MATH_INC_DEC' => -72,
			"( my" => 391,
			"%{" => -72,
			'LITERAL_STRING' => -72,
			'OP01_NAMED' => -72,
			"while (" => -72,
			'OP19_LOOP_CONTROL' => -72,
			'WORD_SCOPED' => -72,
			'OP01_NAMED_VOID' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			"for my integer" => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP01_CLOSE' => -72,
			'OP01_OPEN' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP05_LOGICAL_NEG' => -72,
			"my" => -72
		},
		GOTOS => {
			'MethodArguments' => 389,
			'OPTIONAL-29' => 390
		}
	},
	{#State 386
		DEFAULT => -47
	},
	{#State 387
		DEFAULT => -154
	},
	{#State 388
		DEFAULT => -144
	},
	{#State 389
		DEFAULT => -71
	},
	{#State 390
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'LEFT_PAREN' => 102,
			"\@{" => 85,
			'VARIABLE_SYMBOL' => 84,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 82,
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			'WORD' => 95,
			"if (" => 96,
			'OP01_OPEN' => 94,
			"my" => 118,
			'OP01_PRINT_VOID' => 116,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 91,
			"for my integer" => -138,
			'OP01_NAMED' => 89,
			"%{" => 109,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_NAMED_VOID' => 108,
			'OP19_LOOP_CONTROL' => 106,
			"while (" => -138,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 80,
			'Statement' => 100,
			'ArrayDereferenced' => 99,
			'OperatorVoid' => 78,
			'Literal' => 97,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 105,
			'Conditional' => 83,
			'PLUS-30' => 393,
			'Operation' => 392,
			'LoopLabel' => 112,
			'PAREN-36' => 110,
			'OPTIONAL-37' => 93,
			'VariableDeclaration' => 121,
			'Operator' => 120,
			'SubExpression' => 119,
			'HashDereferenced' => 115,
			'VariableModification' => 92
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
			"foreach my" => -138,
			'OP05_MATH_NEG' => 81,
			'LITERAL_NUMBER' => 79,
			"undef" => 77,
			"if (" => 96,
			'WORD' => 95,
			'LEFT_BRACKET' => 104,
			'OP03_MATH_INC_DEC' => 103,
			'VARIABLE_SYMBOL' => 84,
			"\@{" => 85,
			'LEFT_PAREN' => 102,
			'OP22_LOGICAL_NOT' => 101,
			"}" => 396,
			'LEFT_BRACE' => 82,
			'OP01_CLOSE' => 113,
			"for my integer" => -138,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED' => 89,
			'LITERAL_STRING' => 88,
			"%{" => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 107,
			'OP01_NAMED_VOID' => 108,
			'WORD_SCOPED' => 25,
			"while (" => -138,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_OPEN' => 94,
			"my" => 118,
			'OP05_LOGICAL_NEG' => 117,
			'OP01_PRINT_VOID' => 116
		},
		GOTOS => {
			'OperatorVoid' => 78,
			'Literal' => 97,
			'Variable' => 80,
			'HashReference' => 98,
			'ArrayDereferenced' => 99,
			'Statement' => 100,
			'Conditional' => 83,
			'ArrayReference' => 86,
			'WordScoped' => 87,
			'Expression' => 105,
			'PAREN-36' => 110,
			'Operation' => 395,
			'LoopLabel' => 112,
			'HashDereferenced' => 115,
			'VariableModification' => 92,
			'OPTIONAL-37' => 93,
			'Operator' => 120,
			'SubExpression' => 119,
			'VariableDeclaration' => 121
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
			'WORD' => 53
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
#line 5579 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5586 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5593 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5600 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5611 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5622 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5643 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5650 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5731 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5742 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5753 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5764 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5842 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5849 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5874 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5892 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5903 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5953 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5960 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5974 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6223 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6234 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6245 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6311 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6632 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_124
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_125
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6705 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6782 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_134
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_135
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_139
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6869 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6880 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6887 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_150
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_151
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_154
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_155
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_156
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6999 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_159
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_162
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_163
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_166
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_168
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-46', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-46', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_175
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7277 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7342 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7353 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_195
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_197
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_199
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule Type_200
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_201
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_202
		 'FileHandleOpen', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_203
		 'FileHandleOpen', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_204
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_205
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_206
		 'FileHandlePrint', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7485 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_207
		 'FileHandlePrint', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7518 lib/RPerl/Grammar.pm
	]
],
#line 7521 lib/RPerl/Grammar.pm
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


#line 7779 lib/RPerl/Grammar.pm



1;
