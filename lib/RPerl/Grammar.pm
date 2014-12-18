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
    our $VERSION = 0.000_900;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\$TYPED_|elsif\ \(|package|while\ \(|\=\ sub\ \{|undef|\(\ my|else|if\ \(|\@_\;|our|use|qw\(|\%\{|\@\{|my|\.\.|\)|\;|\]|\})}gc and return ($1, $1);

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
      /\G(sin|cos|ETC)/gc and return ('OP01_NAMED', $1);
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
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_NAMED', 'LEFT_PAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_OPEN', 'FileHandleOpen', 'OP21_LIST_COMMA', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP01_CLOSE', 'FileHandleClose' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG', 'SubExpression', ')' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NEQ', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP22_LOGICAL_NOT', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-34', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandlePrint', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Expression_122' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_123' => 'Expression', [ 'WordScoped', 'LEFT_PAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LEFT_PAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'SubExpression_125' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_126' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_127' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'LEFT_BRACE', '}' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'LEFT_PAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrPrompt_135' => 'SubExpressionOrPrompt', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrPrompt_136' => 'SubExpressionOrPrompt', [ 'STDIN_PROMPT' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Statement_140' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'OPTIONAL-38', 'Loop' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'PAREN-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Conditional_151' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-40', 'OPTIONAL-42' ], 0 ],
  [ 'Loop_152' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_155' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'SubExpression', '..', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_156' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_157' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_160' => 'CodeBlock', [ 'LEFT_BRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_163' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_164' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_166' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_167' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_168' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrPrompt', ';' ], 0 ],
  [ 'VariableModification_169' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrPrompt', ';' ], 0 ],
  [ 'VariableModification_170' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'PLUS-47', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'WORD' ], 0 ],
  [ 'ListElements_176' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ 'ListElements_177' => 'ListElements', [ 'OP01_QW', 'LEFT_PAREN', 'PLUS-47', ')' ], 0 ],
  [ 'ListElement_178' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_180' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayReference_183' => 'ArrayReference', [ 'LEFT_BRACKET', 'OPTIONAL-48', ']' ], 0 ],
  [ 'ArrayDereferenced_184' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_185' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'HashEntry_188' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-49', 'SubExpression' ], 0 ],
  [ 'HashEntry_189' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_190' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_191' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [ 'STAR-51', 'PAREN-50' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [  ], 0 ],
  [ 'HashReference_195' => 'HashReference', [ 'LEFT_BRACE', 'HashEntry', 'STAR-51', '}' ], 0 ],
  [ 'HashDereferenced_196' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_197' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_198' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_199' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_200' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_201' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_202' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandleOpen_203' => 'FileHandleOpen', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandleOpen_204' => 'FileHandleOpen', [ 'my', 'filehandle_ref', 'FILEHANDLE_REF_SYMBOL' ], 0 ],
  [ 'FileHandleClose_205' => 'FileHandleClose', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandleClose_206' => 'FileHandleClose', [ 'FILEHANDLE_REF_SYMBOL' ], 0 ],
  [ 'FileHandlePrint_207' => 'FileHandlePrint', [ 'STDIN_STDOUT_STDERR' ], 0 ],
  [ 'FileHandlePrint_208' => 'FileHandlePrint', [ 'LEFT_BRACE', 'FILEHANDLE_REF_SYMBOL', '}' ], 0 ],
  [ 'Literal_209' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_210' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_OPTIONAL' => 84,
  '_OPTIONAL' => 85,
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
  '_OPTIONAL' => 112,
  '_OPTIONAL' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  'Expression_122' => 122,
  'Expression_123' => 123,
  'Expression_124' => 124,
  'SubExpression_125' => 125,
  'SubExpression_126' => 126,
  'SubExpression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpressionOrPrompt_135' => 135,
  'SubExpressionOrPrompt_136' => 136,
  '_PAREN' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  'Statement_140' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  '_PAREN' => 145,
  '_STAR_LIST' => 146,
  '_STAR_LIST' => 147,
  '_PAREN' => 148,
  '_OPTIONAL' => 149,
  '_OPTIONAL' => 150,
  'Conditional_151' => 151,
  'Loop_152' => 152,
  'Loop_153' => 153,
  'Loop_154' => 154,
  'LoopFor_155' => 155,
  'LoopForEach_156' => 156,
  'LoopWhile_157' => 157,
  '_PLUS_LIST' => 158,
  '_PLUS_LIST' => 159,
  'CodeBlock_160' => 160,
  '_STAR_LIST' => 161,
  '_STAR_LIST' => 162,
  'Variable_163' => 163,
  'VariableRetrieval_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableRetrieval_166' => 166,
  'VariableDeclaration_167' => 167,
  'VariableDeclaration_168' => 168,
  'VariableModification_169' => 169,
  'VariableModification_170' => 170,
  '_PAREN' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  '_PLUS_LIST' => 174,
  '_PLUS_LIST' => 175,
  'ListElements_176' => 176,
  'ListElements_177' => 177,
  'ListElement_178' => 178,
  'ListElement_179' => 179,
  'ListElement_180' => 180,
  '_OPTIONAL' => 181,
  '_OPTIONAL' => 182,
  'ArrayReference_183' => 183,
  'ArrayDereferenced_184' => 184,
  'ArrayDereferenced_185' => 185,
  '_OPTIONAL' => 186,
  '_OPTIONAL' => 187,
  'HashEntry_188' => 188,
  'HashEntry_189' => 189,
  'HashEntryTyped_190' => 190,
  'HashEntryTyped_191' => 191,
  '_PAREN' => 192,
  '_STAR_LIST' => 193,
  '_STAR_LIST' => 194,
  'HashReference_195' => 195,
  'HashDereferenced_196' => 196,
  'HashDereferenced_197' => 197,
  'WordScoped_198' => 198,
  'WordScoped_199' => 199,
  'LoopLabel_200' => 200,
  'Type_201' => 201,
  'TypeInner_202' => 202,
  'FileHandleOpen_203' => 203,
  'FileHandleOpen_204' => 204,
  'FileHandleClose_205' => 205,
  'FileHandleClose_206' => 206,
  'FileHandlePrint_207' => 207,
  'FileHandlePrint_208' => 208,
  'Literal_209' => 209,
  'Literal_210' => 210,
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
			"## no critic qw(" => 4,
			"package" => -20,
			'SHEBANG' => 8
		},
		GOTOS => {
			'CompileUnit' => 1,
			'Program' => 5,
			'PAREN-1' => 9,
			'ModuleHeader' => 3,
			'PLUS-2' => 7,
			'OPTIONAL-9' => 2,
			'Critic' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"package" => 11
		}
	},
	{#State 3
		ACTIONS => {
			"our" => -25,
			"use" => -25,
			"use parent qw(" => 16,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Module' => 15,
			'STAR-10' => 14,
			'Class' => 12,
			'Package' => 13
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 17
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 4,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'ModuleHeader' => 3,
			'PAREN-1' => 19,
			'OPTIONAL-9' => 2,
			'Critic' => 6
		}
	},
	{#State 8
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 21
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"use" => -27,
			"use constant" => -27,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 25
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 17
		ACTIONS => {
			'WORD' => 29,
			")" => 28
		}
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 31
		}
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -199
	},
	{#State 24
		DEFAULT => -198
	},
	{#State 25
		ACTIONS => {
			"use constant" => -29,
			"use" => 35,
			"our" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 33
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			")" => 36
		}
	},
	{#State 28
		DEFAULT => -36
	},
	{#State 29
		DEFAULT => -34
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
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => 40,
			"our" => 42
		},
		GOTOS => {
			'PLUS-13' => 43,
			'Constant' => 44,
			'Subroutine' => 41
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 36
		ACTIONS => {
			";" => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			'WORD_SCOPED' => -11,
			'LEFT_PAREN' => -11,
			'LITERAL_NUMBER' => -11,
			'LEFT_BRACKET' => -11,
			'OP01_NAMED' => -11,
			'OP01_PRINT_VOID' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LEFT_BRACE' => -11,
			"## no critic qw(" => 4,
			"use" => -11,
			"foreach my" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"our" => -11,
			'LITERAL_STRING' => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			"while (" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_MATH_NEG' => -11,
			'OP01_OPEN' => -11,
			"if (" => -11,
			"\@{" => -11,
			"my" => -11,
			'WORD' => -11,
			"for my integer" => -11,
			"use constant" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP05_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'STAR-5' => 48,
			'Critic' => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			'WORD' => 50
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 51
		}
	},
	{#State 43
		ACTIONS => {
			'LITERAL_NUMBER' => 53,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 54
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			";" => 56,
			"qw(" => 55
		}
	},
	{#State 46
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 47
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 35,
			"foreach my" => -13,
			"our" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP01_NAMED' => -13,
			'LEFT_PAREN' => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			'LEFT_BRACKET' => -13,
			'LEFT_BRACE' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_PRINT_VOID' => -13,
			"undef" => -13,
			"if (" => -13,
			"\@{" => -13,
			"my" => -13,
			"%{" => -13,
			"while (" => -13,
			'OP05_MATH_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_OPEN' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"for my integer" => -13,
			'WORD' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY' => -13,
			"use constant" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'LITERAL_STRING' => -13,
			'OP01_CLOSE' => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 59
		}
	},
	{#State 49
		DEFAULT => -8
	},
	{#State 50
		ACTIONS => {
			'OP20_HASH_FATARROW' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'VARIABLE_SYMBOL' => 62
		}
	},
	{#State 52
		DEFAULT => -201
	},
	{#State 53
		ACTIONS => {
			";" => 63
		}
	},
	{#State 54
		DEFAULT => -30
	},
	{#State 55
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 56
		DEFAULT => -39
	},
	{#State 57
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 66
		}
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
			'WORD' => -15,
			"for my integer" => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"use constant" => 40,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"our" => -15,
			"while (" => -15,
			"%{" => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG' => -15,
			"my" => -15,
			"foreach my" => -15,
			"\@{" => -15,
			"if (" => -15,
			'OP01_PRINT_VOID' => -15,
			"undef" => -15,
			'OP01_CLOSE' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LEFT_BRACE' => -15,
			'LITERAL_NUMBER' => -15,
			'LEFT_PAREN' => -15,
			'WORD_SCOPED' => -15,
			'LEFT_BRACKET' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_STRING' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 68
		}
	},
	{#State 61
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"= sub {" => 72
		}
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		DEFAULT => -38
	},
	{#State 65
		ACTIONS => {
			'WORD' => 73,
			")" => 74
		}
	},
	{#State 66
		ACTIONS => {
			"use" => -54,
			"our %properties = (" => -54,
			"## no critic qw(" => 4,
			"use constant" => -54
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-21' => 76
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			"if (" => 114,
			"foreach my" => -139,
			"my" => 113,
			"\@{" => 112,
			"%{" => 121,
			"while (" => -139,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'VARIABLE_SYMBOL' => 105,
			"our" => 42,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 111,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79,
			'OP01_PRINT_VOID' => 83,
			'OP01_CLOSE' => 100,
			"undef" => 80
		},
		GOTOS => {
			'Variable' => 92,
			'Operator' => 116,
			'HashReference' => 93,
			'VariableModification' => 120,
			'SubExpression' => 119,
			'Subroutine' => 107,
			'LoopLabel' => 106,
			'Operation' => 90,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'OperatorVoid' => 77,
			'HashDereferenced' => 96,
			'VariableDeclaration' => 95,
			'Expression' => 94,
			'ArrayDereferenced' => 98,
			'Statement' => 97,
			'OPTIONAL-38' => 82,
			'Literal' => 99,
			'PAREN-37' => 81,
			'PLUS-8' => 101,
			'Conditional' => 84
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 88
		},
		GOTOS => {
			'Literal' => 122
		}
	},
	{#State 71
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 123
		}
	},
	{#State 72
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'WORD' => -43,
			"for my integer" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_MATH_NEG' => -43,
			'OP01_OPEN' => -43,
			"( my" => 126,
			"%{" => -43,
			"while (" => -43,
			"if (" => -43,
			"my" => -43,
			"foreach my" => -43,
			"\@{" => -43,
			'OP01_CLOSE' => -43,
			"undef" => -43,
			'OP01_PRINT_VOID' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LEFT_BRACE' => -43,
			'LEFT_BRACKET' => -43,
			'LEFT_PAREN' => -43,
			'WORD_SCOPED' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED' => -43,
			'LITERAL_STRING' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 124,
			'OPTIONAL-16' => 125
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			";" => 127
		}
	},
	{#State 75
		DEFAULT => -51
	},
	{#State 76
		ACTIONS => {
			"use" => 35,
			"use constant" => -56,
			"our %properties = (" => -56
		},
		GOTOS => {
			'STAR-22' => 128,
			'Include' => 129
		}
	},
	{#State 77
		DEFAULT => -142
	},
	{#State 78
		ACTIONS => {
			'WORD' => 133,
			"%{" => 121,
			"}" => 130
		},
		GOTOS => {
			'HashEntry' => 131,
			'HashDereferenced' => 132
		}
	},
	{#State 79
		ACTIONS => {
			'WORD' => 135
		},
		GOTOS => {
			'LoopLabel' => 134
		}
	},
	{#State 80
		DEFAULT => -126
	},
	{#State 81
		DEFAULT => -138
	},
	{#State 82
		ACTIONS => {
			"foreach my" => 142,
			"for my integer" => 137,
			"while (" => 138
		},
		GOTOS => {
			'Loop' => 139,
			'LoopWhile' => 136,
			'LoopFor' => 141,
			'LoopForEach' => 140
		}
	},
	{#State 83
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'KEYS_OR_VALUES' => 150,
			'OP01_QW' => 144,
			'LEFT_BRACE' => 145,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'STDIN_STDOUT_STDERR' => 146,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112,
			"my" => 71
		},
		GOTOS => {
			'ListElements' => 152,
			'FileHandlePrint' => 149,
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 153,
			'ArrayReference' => 103,
			'Operator' => 116,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'ListElement' => 147,
			'HashDereferenced' => 96,
			'Literal' => 99,
			'TypeInner' => 143
		}
	},
	{#State 84
		DEFAULT => -140
	},
	{#State 85
		ACTIONS => {
			'LEFT_PAREN' => 154
		}
	},
	{#State 86
		ACTIONS => {
			'LEFT_PAREN' => 155
		}
	},
	{#State 87
		ACTIONS => {
			"\@{" => 112,
			"my" => 71,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 24,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			"]" => -182,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'KEYS_OR_VALUES' => 150,
			'OP01_CLOSE' => 100,
			'OP01_QW' => 144
		},
		GOTOS => {
			'ListElements' => 156,
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 153,
			'ArrayReference' => 103,
			'Operator' => 116,
			'OPTIONAL-48' => 157,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ListElement' => 147,
			'TypeInner' => 143,
			'Literal' => 99
		}
	},
	{#State 88
		DEFAULT => -210
	},
	{#State 89
		ACTIONS => {
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118
		},
		GOTOS => {
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 158,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 90
		DEFAULT => -17
	},
	{#State 91
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108
		},
		GOTOS => {
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98,
			'Literal' => 99,
			'Variable' => 148,
			'WordScoped' => 86,
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 159,
			'HashReference' => 93
		}
	},
	{#State 92
		ACTIONS => {
			'OP08_STRING_CAT' => -128,
			'OP14_BITWISE_OR_XOR' => -128,
			'OP03_MATH_INC_DEC' => 163,
			'OP04_MATH_POW' => -128,
			'OP09_BITWISE_SHIFT' => -128,
			'OP17_LIST_RANGE' => -128,
			'OP13_BITWISE_AND' => -128,
			'OP08_MATH_ADD_SUB' => -128,
			'OP06_REGEX_MATCH' => -128,
			'OP18_TERNARY' => -128,
			'OP02_METHOD_THINARROW' => 160,
			'OP12_COMPARE_EQ_NEQ' => -128,
			'OP07_MATH_MULT_DIV_MOD' => -128,
			'OP16_LOGICAL_OR' => -128,
			'OP15_LOGICAL_AND' => -128,
			'OP19_VARIABLE_ASSIGN' => 161,
			'OP19_VARIABLE_ASSIGN_BY' => 162,
			'OP11_COMPARE_LT_GT' => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP24_LOGICAL_OR_XOR' => -128
		}
	},
	{#State 93
		DEFAULT => -131
	},
	{#State 94
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP11_COMPARE_LT_GT' => -125,
			'OP23_LOGICAL_AND' => -125,
			";" => 164,
			'OP15_LOGICAL_AND' => -125,
			'OP16_LOGICAL_OR' => -125,
			'OP12_COMPARE_EQ_NEQ' => -125,
			'OP07_MATH_MULT_DIV_MOD' => -125,
			'OP06_REGEX_MATCH' => -125,
			'OP18_TERNARY' => -125,
			'OP08_MATH_ADD_SUB' => -125,
			'OP17_LIST_RANGE' => -125,
			'OP13_BITWISE_AND' => -125,
			'OP09_BITWISE_SHIFT' => -125,
			'OP04_MATH_POW' => -125,
			'OP14_BITWISE_OR_XOR' => -125,
			'OP08_STRING_CAT' => -125
		}
	},
	{#State 95
		DEFAULT => -143
	},
	{#State 96
		DEFAULT => -132
	},
	{#State 97
		DEFAULT => -83
	},
	{#State 98
		DEFAULT => -130
	},
	{#State 99
		DEFAULT => -127
	},
	{#State 100
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 167,
			'STDIN_STDOUT_STDERR' => 165
		},
		GOTOS => {
			'FileHandleClose' => 166
		}
	},
	{#State 101
		ACTIONS => {
			'OP01_PRINT_VOID' => 83,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'WORD' => 111,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'' => -18,
			"%{" => 121,
			"while (" => -139,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"if (" => 114,
			"foreach my" => -139,
			"\@{" => 112,
			"my" => 113
		},
		GOTOS => {
			'Expression' => 94,
			'OperatorVoid' => 77,
			'HashDereferenced' => 96,
			'VariableDeclaration' => 95,
			'ArrayDereferenced' => 98,
			'Statement' => 97,
			'Literal' => 99,
			'PAREN-37' => 81,
			'OPTIONAL-38' => 82,
			'Conditional' => 84,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'LoopLabel' => 106,
			'Operation' => 168,
			'Variable' => 92,
			'Operator' => 116,
			'SubExpression' => 119,
			'HashReference' => 93,
			'VariableModification' => 120
		}
	},
	{#State 102
		DEFAULT => -209
	},
	{#State 103
		DEFAULT => -129
	},
	{#State 104
		ACTIONS => {
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 169,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 105
		DEFAULT => -162,
		GOTOS => {
			'STAR-44' => 170
		}
	},
	{#State 106
		ACTIONS => {
			'COLON' => 171
		}
	},
	{#State 107
		DEFAULT => -14
	},
	{#State 108
		ACTIONS => {
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 172,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 109
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"\@{" => 112,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 173,
			'ArrayReference' => 103,
			'Operator' => 116,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'Literal' => 99
		}
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 174
		}
	},
	{#State 111
		ACTIONS => {
			'COLON' => -200,
			'LEFT_PAREN' => -198
		}
	},
	{#State 112
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'ArrayReference' => 176,
			'Variable' => 175
		}
	},
	{#State 113
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 177
		}
	},
	{#State 114
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			"\@{" => 112,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 178,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 115
		ACTIONS => {
			"my" => 181,
			'STDIN_STDOUT_STDERR' => 179
		},
		GOTOS => {
			'FileHandleOpen' => 180
		}
	},
	{#State 116
		DEFAULT => -122
	},
	{#State 117
		ACTIONS => {
			"my" => 71,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_QW' => 144,
			";" => -113,
			"undef" => 80,
			'KEYS_OR_VALUES' => 150,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'WordScoped' => 86,
			'ListElements' => 182,
			'Variable' => 148,
			'OPTIONAL-34' => 183,
			'SubExpression' => 153,
			'HashReference' => 93,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'ListElement' => 147,
			'HashDereferenced' => 96,
			'TypeInner' => 143,
			'Literal' => 99
		}
	},
	{#State 118
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 184,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 119
		ACTIONS => {
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP23_LOGICAL_AND' => 200,
			'OP11_COMPARE_LT_GT' => 199,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187
		}
	},
	{#State 120
		DEFAULT => -144
	},
	{#State 121
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'LEFT_BRACE' => 201
		},
		GOTOS => {
			'HashReference' => 202,
			'Variable' => 203
		}
	},
	{#State 122
		ACTIONS => {
			";" => 204
		}
	},
	{#State 123
		ACTIONS => {
			"\$TYPED_" => 205
		}
	},
	{#State 124
		DEFAULT => -42
	},
	{#State 125
		ACTIONS => {
			"while (" => -139,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			"foreach my" => -139,
			"\@{" => 112,
			"my" => 113,
			"if (" => 114,
			"for my integer" => -139,
			'WORD' => 111,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'OP01_PRINT_VOID' => 83,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79
		},
		GOTOS => {
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'Conditional' => 84,
			'Literal' => 99,
			'PAREN-37' => 81,
			'OPTIONAL-38' => 82,
			'PLUS-17' => 206,
			'Statement' => 97,
			'ArrayDereferenced' => 98,
			'Expression' => 94,
			'HashDereferenced' => 96,
			'OperatorVoid' => 77,
			'VariableDeclaration' => 95,
			'VariableModification' => 120,
			'SubExpression' => 119,
			'HashReference' => 93,
			'Operator' => 116,
			'Variable' => 92,
			'LoopLabel' => 106,
			'Operation' => 207
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 127
		DEFAULT => -40
	},
	{#State 128
		ACTIONS => {
			"our %properties = (" => 211,
			"use constant" => 40
		},
		GOTOS => {
			'Constant' => 209,
			'Properties' => 210
		}
	},
	{#State 129
		DEFAULT => -53
	},
	{#State 130
		DEFAULT => -133
	},
	{#State 131
		DEFAULT => -194,
		GOTOS => {
			'STAR-51' => 212
		}
	},
	{#State 132
		DEFAULT => -189
	},
	{#State 133
		ACTIONS => {
			'OP20_HASH_FATARROW' => 213
		}
	},
	{#State 134
		ACTIONS => {
			";" => 214
		}
	},
	{#State 135
		DEFAULT => -200
	},
	{#State 136
		DEFAULT => -154
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 215
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 216,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 139
		DEFAULT => -141
	},
	{#State 140
		DEFAULT => -153
	},
	{#State 141
		DEFAULT => -152
	},
	{#State 142
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 143
		ACTIONS => {
			"\@{" => 112,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80
		},
		GOTOS => {
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 218,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98
		}
	},
	{#State 144
		ACTIONS => {
			'LEFT_PAREN' => 219
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 130,
			'FILEHANDLE_REF_SYMBOL' => 220,
			'WORD' => 133,
			"%{" => 121
		},
		GOTOS => {
			'HashDereferenced' => 132,
			'HashEntry' => 131
		}
	},
	{#State 146
		DEFAULT => -207
	},
	{#State 147
		DEFAULT => -173,
		GOTOS => {
			'STAR-46' => 221
		}
	},
	{#State 148
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -128,
			")" => -128,
			'OP23_LOGICAL_AND' => -128,
			".." => -128,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP21_LIST_COMMA' => -128,
			'OP12_COMPARE_EQ_NEQ' => -128,
			'OP02_METHOD_THINARROW' => 160,
			'OP07_MATH_MULT_DIV_MOD' => -128,
			'OP18_TERNARY' => -128,
			'OP06_REGEX_MATCH' => -128,
			'OP08_MATH_ADD_SUB' => -128,
			"]" => -128,
			'OP15_LOGICAL_AND' => -128,
			";" => -128,
			'OP16_LOGICAL_OR' => -128,
			"}" => -128,
			'OP17_LIST_RANGE' => -128,
			'OP13_BITWISE_AND' => -128,
			'OP09_BITWISE_SHIFT' => -128,
			'OP14_BITWISE_OR_XOR' => -128,
			'OP08_STRING_CAT' => -128,
			'OP04_MATH_POW' => -128,
			'OP03_MATH_INC_DEC' => 163
		}
	},
	{#State 149
		ACTIONS => {
			'OP01_QW' => 144,
			'OP01_CLOSE' => 100,
			'KEYS_OR_VALUES' => 150,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"\@{" => 112,
			"my" => 71
		},
		GOTOS => {
			'ListElements' => 222,
			'WordScoped' => 86,
			'Variable' => 148,
			'SubExpression' => 153,
			'HashReference' => 93,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'ListElement' => 147,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'TypeInner' => 143,
			'Literal' => 99
		}
	},
	{#State 150
		ACTIONS => {
			"%{" => 121
		},
		GOTOS => {
			'HashDereferenced' => 223
		}
	},
	{#State 151
		DEFAULT => -125
	},
	{#State 152
		ACTIONS => {
			";" => 224
		}
	},
	{#State 153
		ACTIONS => {
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			"]" => -178,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => 188,
			";" => -178,
			'OP15_LOGICAL_AND' => 195,
			")" => -178,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP21_LIST_COMMA' => -178,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193
		}
	},
	{#State 154
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			"my" => 71,
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'LEFT_BRACE' => 78,
			'OP01_QW' => 144,
			'OP01_CLOSE' => 100,
			'KEYS_OR_VALUES' => 150,
			"undef" => 80,
			")" => -85,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'HashDereferenced' => 96,
			'ListElement' => 147,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99,
			'TypeInner' => 143,
			'Variable' => 148,
			'OPTIONAL-33' => 225,
			'WordScoped' => 86,
			'ListElements' => 226,
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 153
		}
	},
	{#State 155
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112,
			"my" => 71,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'KEYS_OR_VALUES' => 150,
			'OP01_QW' => 144,
			'LEFT_BRACE' => 78,
			'LEFT_BRACKET' => 87,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			")" => -119,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'OPTIONAL-35' => 228,
			'TypeInner' => 143,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ListElement' => 147,
			'ArrayDereferenced' => 98,
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 153,
			'Variable' => 148,
			'WordScoped' => 86,
			'ListElements' => 227
		}
	},
	{#State 156
		DEFAULT => -181
	},
	{#State 157
		ACTIONS => {
			"]" => 229
		}
	},
	{#State 158
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP11_COMPARE_LT_GT' => 199,
			")" => 230,
			'OP23_LOGICAL_AND' => 200,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196
		}
	},
	{#State 159
		ACTIONS => {
			"}" => -100,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => 185,
			".." => -100,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			"]" => -100,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			";" => -100
		}
	},
	{#State 160
		ACTIONS => {
			'WORD' => 231
		}
	},
	{#State 161
		ACTIONS => {
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'STDIN_PROMPT' => 234,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'HashReference' => 93,
			'SubExpression' => 232,
			'Operator' => 116,
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'Variable' => 148,
			'SubExpressionOrPrompt' => 233,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151
		}
	},
	{#State 162
		ACTIONS => {
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'HashReference' => 93,
			'SubExpression' => 235,
			'Operator' => 116,
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151
		}
	},
	{#State 163
		DEFAULT => -90
	},
	{#State 164
		DEFAULT => -82
	},
	{#State 165
		DEFAULT => -205
	},
	{#State 166
		DEFAULT => -88
	},
	{#State 167
		DEFAULT => -206
	},
	{#State 168
		DEFAULT => -16
	},
	{#State 169
		ACTIONS => {
			";" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP18_TERNARY' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			")" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			".." => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			"}" => -92
		}
	},
	{#State 170
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP13_BITWISE_AND' => -163,
			"}" => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP04_MATH_POW' => -163,
			'OP08_STRING_CAT' => -163,
			'COLON' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP02_ARRAY_THINARROW' => 236,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP02_HASH_THINARROW' => 237,
			")" => -163,
			'OP11_COMPARE_LT_GT' => -163,
			".." => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP15_LOGICAL_AND' => -163,
			";" => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP18_TERNARY' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			"]" => -163,
			'OP12_COMPARE_EQ_NEQ' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 238
		}
	},
	{#State 171
		DEFAULT => -137
	},
	{#State 172
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			"]" => -109,
			'OP15_LOGICAL_AND' => 195,
			";" => -109,
			'OP16_LOGICAL_OR' => 188,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			".." => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185,
			"}" => -109,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194
		}
	},
	{#State 173
		ACTIONS => {
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			".." => -99,
			'OP23_LOGICAL_AND' => -99,
			")" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP04_MATH_POW' => 185,
			"}" => -99,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => -99,
			'OP17_LIST_RANGE' => -99
		}
	},
	{#State 174
		DEFAULT => -89
	},
	{#State 175
		ACTIONS => {
			"}" => 239
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 177
		ACTIONS => {
			'VARIABLE_SYMBOL' => 241
		}
	},
	{#State 178
		ACTIONS => {
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187,
			'OP09_BITWISE_SHIFT' => 194,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP23_LOGICAL_AND' => 200,
			")" => 242,
			'OP11_COMPARE_LT_GT' => 199,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190
		}
	},
	{#State 179
		DEFAULT => -203
	},
	{#State 180
		ACTIONS => {
			'OP21_LIST_COMMA' => 243
		}
	},
	{#State 181
		ACTIONS => {
			"filehandle_ref" => 244
		}
	},
	{#State 182
		DEFAULT => -112
	},
	{#State 183
		ACTIONS => {
			";" => 245
		}
	},
	{#State 184
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP11_COMPARE_LT_GT' => 199,
			")" => 246,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195
		}
	},
	{#State 185
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			"\@{" => 112,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'SubExpression' => 247,
			'HashReference' => 93,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 186
		ACTIONS => {
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 248,
			'ArrayReference' => 103,
			'Operator' => 116,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 187
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'HashReference' => 93,
			'SubExpression' => 249,
			'Operator' => 116,
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151
		}
	},
	{#State 188
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			"\@{" => 112,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'HashReference' => 93,
			'SubExpression' => 250,
			'ArrayReference' => 103,
			'Operator' => 116,
			'WordScoped' => 86,
			'Variable' => 148
		}
	},
	{#State 189
		ACTIONS => {
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			"\@{" => 112,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78
		},
		GOTOS => {
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 251,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98
		}
	},
	{#State 190
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 252
		}
	},
	{#State 191
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 253
		}
	},
	{#State 192
		ACTIONS => {
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 254,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 193
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'WORD' => 24,
			"\@{" => 112,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89
		},
		GOTOS => {
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 255,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 194
		ACTIONS => {
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Operator' => 116,
			'SubExpression' => 256,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 257,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'Literal' => 99
		}
	},
	{#State 196
		ACTIONS => {
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"\@{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78
		},
		GOTOS => {
			'SubExpression' => 258,
			'HashReference' => 93,
			'ArrayReference' => 103,
			'Operator' => 116,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96
		}
	},
	{#State 197
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"\@{" => 112
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'SubExpression' => 259,
			'HashReference' => 93,
			'ArrayReference' => 103,
			'Operator' => 116,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 198
		ACTIONS => {
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			"\@{" => 112,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'SubExpression' => 260,
			'HashReference' => 93,
			'Operator' => 116,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'Literal' => 99
		}
	},
	{#State 199
		ACTIONS => {
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"\@{" => 112,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99,
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 261,
			'ArrayReference' => 103,
			'Operator' => 116
		}
	},
	{#State 200
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"\@{" => 112,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 262,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 201
		ACTIONS => {
			"%{" => 121,
			'WORD' => 133
		},
		GOTOS => {
			'HashEntry' => 131,
			'HashDereferenced' => 132
		}
	},
	{#State 202
		ACTIONS => {
			"}" => 263
		}
	},
	{#State 203
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 204
		DEFAULT => -41
	},
	{#State 205
		ACTIONS => {
			'WORD' => 265
		}
	},
	{#State 206
		ACTIONS => {
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'OP01_PRINT_VOID' => 83,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP19_LOOP_CONTROL' => 79,
			'LEFT_BRACE' => 78,
			"%{" => 121,
			"while (" => -139,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"if (" => 114,
			"my" => 113,
			"foreach my" => -139,
			"\@{" => 112,
			"}" => 266,
			"for my integer" => -139,
			'WORD' => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'Operation' => 267,
			'LoopLabel' => 106,
			'VariableModification' => 120,
			'SubExpression' => 119,
			'HashReference' => 93,
			'Operator' => 116,
			'Variable' => 92,
			'Conditional' => 84,
			'OPTIONAL-38' => 82,
			'PAREN-37' => 81,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'Statement' => 97,
			'OperatorVoid' => 77,
			'VariableDeclaration' => 95,
			'HashDereferenced' => 96,
			'Expression' => 94,
			'ArrayReference' => 103,
			'WordScoped' => 86
		}
	},
	{#State 207
		DEFAULT => -45
	},
	{#State 208
		ACTIONS => {
			'VARIABLE_SYMBOL' => 268
		}
	},
	{#State 209
		DEFAULT => -55
	},
	{#State 210
		ACTIONS => {
			"our" => -58,
			"our %properties_class = (" => 269,
			'LITERAL_NUMBER' => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 271,
			'PropertiesClass' => 270
		}
	},
	{#State 211
		ACTIONS => {
			")" => 273,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 272
		}
	},
	{#State 212
		ACTIONS => {
			'OP21_LIST_COMMA' => 275,
			"}" => 276
		},
		GOTOS => {
			'PAREN-50' => 274
		}
	},
	{#State 213
		ACTIONS => {
			'OP05_MATH_NEG' => -187,
			'OP01_OPEN' => -187,
			"%{" => -187,
			"\@{" => -187,
			"my" => 71,
			'OP03_MATH_INC_DEC' => -187,
			'OP10_NAMED_UNARY' => -187,
			'OP10_NAMED_UNARY_STRINGIFY' => -187,
			'OP22_LOGICAL_NOT' => -187,
			'WORD' => -187,
			'OP05_LOGICAL_NEG' => -187,
			'VARIABLE_SYMBOL' => -187,
			'LEFT_BRACKET' => -187,
			'LEFT_PAREN' => -187,
			'WORD_SCOPED' => -187,
			'LITERAL_NUMBER' => -187,
			'LITERAL_STRING' => -187,
			'OP01_NAMED' => -187,
			'OP01_CLOSE' => -187,
			"undef" => -187,
			'LEFT_BRACE' => -187
		},
		GOTOS => {
			'TypeInner' => 277,
			'OPTIONAL-49' => 278
		}
	},
	{#State 214
		DEFAULT => -117
	},
	{#State 215
		ACTIONS => {
			'LEFT_PAREN' => 279
		}
	},
	{#State 216
		ACTIONS => {
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187,
			'OP09_BITWISE_SHIFT' => 194,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP23_LOGICAL_AND' => 200,
			'OP11_COMPARE_LT_GT' => 199,
			")" => 280,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191
		}
	},
	{#State 217
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 218
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			"]" => -179,
			'OP15_LOGICAL_AND' => 195,
			";" => -179,
			'OP16_LOGICAL_OR' => 188,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -179,
			'OP23_LOGICAL_AND' => 200,
			'OP21_LIST_COMMA' => -179,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194
		}
	},
	{#State 219
		ACTIONS => {
			'WORD' => 282
		},
		GOTOS => {
			'PLUS-47' => 283
		}
	},
	{#State 220
		ACTIONS => {
			"}" => 284
		}
	},
	{#State 221
		ACTIONS => {
			")" => -176,
			"]" => -176,
			'OP21_LIST_COMMA' => 285,
			";" => -176
		},
		GOTOS => {
			'PAREN-45' => 286
		}
	},
	{#State 222
		ACTIONS => {
			";" => 287
		}
	},
	{#State 223
		DEFAULT => -180
	},
	{#State 224
		DEFAULT => -115
	},
	{#State 225
		ACTIONS => {
			")" => 288
		}
	},
	{#State 226
		DEFAULT => -84
	},
	{#State 227
		DEFAULT => -118
	},
	{#State 228
		ACTIONS => {
			")" => 289
		}
	},
	{#State 229
		DEFAULT => -183
	},
	{#State 230
		DEFAULT => -134
	},
	{#State 231
		ACTIONS => {
			'LEFT_PAREN' => 290
		}
	},
	{#State 232
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 195,
			";" => -135,
			'OP16_LOGICAL_OR' => 188,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185
		}
	},
	{#State 233
		ACTIONS => {
			";" => 291
		}
	},
	{#State 234
		DEFAULT => -136
	},
	{#State 235
		ACTIONS => {
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP15_LOGICAL_AND' => 195,
			";" => 292,
			'OP16_LOGICAL_OR' => 188
		}
	},
	{#State 236
		ACTIONS => {
			"\@{" => 112,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'WORD' => 24,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 293,
			'HashReference' => 93,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 237
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"\@{" => 112,
			'WORD' => 295,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 294,
			'ArrayReference' => 103,
			'Operator' => 116,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'Literal' => 99
		}
	},
	{#State 238
		DEFAULT => -161
	},
	{#State 239
		DEFAULT => -184
	},
	{#State 240
		DEFAULT => -185
	},
	{#State 241
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 297,
			";" => 296
		}
	},
	{#State 242
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 298
		}
	},
	{#State 243
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 24,
			"\@{" => 112,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"%{" => 121,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_BRACKET' => 87,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'Literal' => 99,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 300,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86
		}
	},
	{#State 244
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 301
		}
	},
	{#State 245
		DEFAULT => -114
	},
	{#State 246
		DEFAULT => -93
	},
	{#State 247
		ACTIONS => {
			")" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP23_LOGICAL_AND' => -91,
			".." => -91,
			'OP21_LIST_COMMA' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP18_TERNARY' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"]" => -91,
			'OP15_LOGICAL_AND' => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			"}" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP04_MATH_POW' => 185
		}
	},
	{#State 248
		ACTIONS => {
			'OP16_LOGICAL_OR' => -97,
			'OP15_LOGICAL_AND' => -97,
			";" => -97,
			"]" => -97,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP23_LOGICAL_AND' => -97,
			".." => -97,
			")" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			"}" => -97
		}
	},
	{#State 249
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => undef,
			"}" => -107,
			'OP16_LOGICAL_OR' => 188,
			";" => -107,
			'OP15_LOGICAL_AND' => 195,
			"]" => -107,
			'OP18_TERNARY' => -107,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP23_LOGICAL_AND' => -107,
			".." => -107,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -107
		}
	},
	{#State 250
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => -106,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194,
			"}" => -106,
			";" => -106,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => -106,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -106,
			'OP06_REGEX_MATCH' => 190,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			")" => -106,
			'OP11_COMPARE_LT_GT' => 199,
			".." => -106,
			'OP23_LOGICAL_AND' => -106
		}
	},
	{#State 251
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => -102,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => -102,
			".." => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP15_LOGICAL_AND' => -102,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -102,
			'OP06_REGEX_MATCH' => 190,
			"]" => -102,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => -102,
			'OP13_BITWISE_AND' => -102,
			"}" => -102,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => -102
		}
	},
	{#State 252
		DEFAULT => -94
	},
	{#State 253
		ACTIONS => {
			'COLON' => 302
		}
	},
	{#State 254
		ACTIONS => {
			"}" => -104,
			'OP17_LIST_RANGE' => -104,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			".." => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -104,
			'OP06_REGEX_MATCH' => 190,
			"]" => -104,
			'OP15_LOGICAL_AND' => -104,
			";" => -104,
			'OP16_LOGICAL_OR' => -104
		}
	},
	{#State 255
		ACTIONS => {
			'OP13_BITWISE_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP09_BITWISE_SHIFT' => 194,
			"}" => -103,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP08_STRING_CAT' => 186,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			".." => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -103,
			";" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			"]" => -103,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -103,
			'OP06_REGEX_MATCH' => 190
		}
	},
	{#State 256
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -98,
			")" => -98,
			'OP23_LOGICAL_AND' => -98,
			".." => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => -98,
			"]" => -98,
			";" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185
		}
	},
	{#State 257
		ACTIONS => {
			"}" => -105,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => -105,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			".." => -105,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 199,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			"]" => -105,
			'OP18_TERNARY' => -105,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => -105,
			";" => -105,
			'OP15_LOGICAL_AND' => -105
		}
	},
	{#State 258
		ACTIONS => {
			'OP08_STRING_CAT' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP04_MATH_POW' => 185,
			"}" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_MATCH' => 190,
			"]" => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP15_LOGICAL_AND' => -95,
			";" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			".." => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95
		}
	},
	{#State 259
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP13_BITWISE_AND' => -96,
			"}" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			";" => -96,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			"]" => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			")" => -96,
			'OP23_LOGICAL_AND' => -96,
			".." => -96
		}
	},
	{#State 260
		ACTIONS => {
			'OP21_LIST_COMMA' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP23_LOGICAL_AND' => 200,
			".." => -111,
			")" => -111,
			'OP11_COMPARE_LT_GT' => 199,
			'OP16_LOGICAL_OR' => 188,
			";" => -111,
			'OP15_LOGICAL_AND' => 195,
			"]" => -111,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187,
			"}" => -111,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192
		}
	},
	{#State 261
		ACTIONS => {
			")" => -101,
			'OP11_COMPARE_LT_GT' => undef,
			".." => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => -101,
			'OP06_REGEX_MATCH' => 190,
			"]" => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => -101,
			";" => -101,
			"}" => -101,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP04_MATH_POW' => 185
		}
	},
	{#State 262
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187,
			"}" => -110,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			";" => -110,
			"]" => -110,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP21_LIST_COMMA' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			".." => -110,
			")" => -110,
			'OP11_COMPARE_LT_GT' => 199
		}
	},
	{#State 263
		DEFAULT => -197
	},
	{#State 264
		DEFAULT => -196
	},
	{#State 265
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 303
		}
	},
	{#State 266
		ACTIONS => {
			";" => 304
		}
	},
	{#State 267
		DEFAULT => -44
	},
	{#State 268
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 305
		}
	},
	{#State 269
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 306
		}
	},
	{#State 270
		DEFAULT => -57
	},
	{#State 271
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 307
		}
	},
	{#State 272
		ACTIONS => {
			'WORD' => 310,
			"%{" => 121
		},
		GOTOS => {
			'HashEntryTyped' => 308,
			'HashDereferenced' => 309
		}
	},
	{#State 273
		ACTIONS => {
			";" => 311
		}
	},
	{#State 274
		DEFAULT => -193
	},
	{#State 275
		ACTIONS => {
			'WORD' => 133,
			"%{" => 121
		},
		GOTOS => {
			'HashDereferenced' => 132,
			'HashEntry' => 312
		}
	},
	{#State 276
		DEFAULT => -195
	},
	{#State 277
		DEFAULT => -186
	},
	{#State 278
		ACTIONS => {
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Operator' => 116,
			'SubExpression' => 313,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 279
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"\@{" => 112,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Operator' => 116,
			'SubExpression' => 314,
			'HashReference' => 93,
			'Variable' => 148,
			'WordScoped' => 86,
			'Literal' => 99,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98
		}
	},
	{#State 280
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 315
		}
	},
	{#State 281
		ACTIONS => {
			'LEFT_PAREN' => 316
		}
	},
	{#State 282
		DEFAULT => -175
	},
	{#State 283
		ACTIONS => {
			'WORD' => 318,
			")" => 317
		}
	},
	{#State 284
		DEFAULT => -208
	},
	{#State 285
		ACTIONS => {
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"my" => 71,
			"\@{" => 112,
			'OP01_CLOSE' => 100,
			'KEYS_OR_VALUES' => 150,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'HashReference' => 93,
			'SubExpression' => 153,
			'ArrayReference' => 103,
			'Operator' => 116,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'TypeInner' => 143,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ListElement' => 319
		}
	},
	{#State 286
		DEFAULT => -172
	},
	{#State 287
		DEFAULT => -116
	},
	{#State 288
		DEFAULT => -86
	},
	{#State 289
		DEFAULT => -123
	},
	{#State 290
		ACTIONS => {
			'LEFT_BRACE' => 78,
			'OP01_QW' => 144,
			'KEYS_OR_VALUES' => 150,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			")" => -121,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"\@{" => 112,
			"my" => 71,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118
		},
		GOTOS => {
			'Literal' => 99,
			'TypeInner' => 143,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96,
			'ListElement' => 147,
			'SubExpression' => 153,
			'HashReference' => 93,
			'OPTIONAL-36' => 320,
			'ArrayReference' => 103,
			'Operator' => 116,
			'WordScoped' => 86,
			'ListElements' => 321,
			'Variable' => 148
		}
	},
	{#State 291
		DEFAULT => -169
	},
	{#State 292
		DEFAULT => -170
	},
	{#State 293
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			"]" => 322,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 188,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP04_MATH_POW' => 185,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194
		}
	},
	{#State 294
		ACTIONS => {
			"}" => 323,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195
		}
	},
	{#State 295
		ACTIONS => {
			"}" => 324,
			'LEFT_PAREN' => -198
		}
	},
	{#State 296
		DEFAULT => -167
	},
	{#State 297
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'STDIN_PROMPT' => 234,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'Operator' => 116,
			'ArrayReference' => 103,
			'SubExpression' => 232,
			'HashReference' => 93,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99,
			'SubExpressionOrPrompt' => 325
		}
	},
	{#State 298
		DEFAULT => -147,
		GOTOS => {
			'STAR-40' => 326
		}
	},
	{#State 299
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			"for my integer" => -139,
			'WORD' => 111,
			"if (" => 114,
			"my" => 113,
			"foreach my" => -139,
			"\@{" => 112,
			'OP05_MATH_NEG' => 118,
			'OP01_NAMED_VOID' => 117,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"while (" => -139,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_PRINT_VOID' => 83,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'Statement' => 97,
			'HashDereferenced' => 96,
			'VariableDeclaration' => 95,
			'OperatorVoid' => 77,
			'Expression' => 94,
			'Conditional' => 84,
			'OPTIONAL-38' => 82,
			'PAREN-37' => 81,
			'Literal' => 99,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'Operation' => 327,
			'LoopLabel' => 106,
			'PLUS-43' => 328,
			'Variable' => 92,
			'SubExpression' => 119,
			'VariableModification' => 120,
			'HashReference' => 93,
			'Operator' => 116
		}
	},
	{#State 300
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP21_LIST_COMMA' => 329,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193
		}
	},
	{#State 301
		DEFAULT => -204
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 330
		}
	},
	{#State 303
		DEFAULT => -202
	},
	{#State 304
		DEFAULT => -46
	},
	{#State 305
		ACTIONS => {
			'OP21_LIST_COMMA' => 331,
			")" => 332
		},
		GOTOS => {
			'PAREN-18' => 333
		}
	},
	{#State 306
		ACTIONS => {
			"%{" => 121,
			'WORD' => 310
		},
		GOTOS => {
			'HashEntryTyped' => 334,
			'HashDereferenced' => 309
		}
	},
	{#State 307
		ACTIONS => {
			'LITERAL_NUMBER' => 339,
			"our" => 338
		},
		GOTOS => {
			'MethodOrSubroutine' => 337,
			'Method' => 336,
			'Subroutine' => 335
		}
	},
	{#State 308
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 340
		}
	},
	{#State 309
		DEFAULT => -191
	},
	{#State 310
		ACTIONS => {
			'OP20_HASH_FATARROW' => 341
		}
	},
	{#State 311
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 342
		}
	},
	{#State 312
		DEFAULT => -192
	},
	{#State 313
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			"}" => -188,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP21_LIST_COMMA' => -188,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 314
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP11_COMPARE_LT_GT' => 199,
			".." => 343,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195
		}
	},
	{#State 315
		DEFAULT => -157
	},
	{#State 316
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'LITERAL_NUMBER' => 88,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_QW' => 144,
			"undef" => 80,
			'KEYS_OR_VALUES' => 150,
			'OP01_CLOSE' => 100,
			"my" => 71,
			"\@{" => 112,
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110
		},
		GOTOS => {
			'Expression' => 151,
			'ListElement' => 147,
			'HashDereferenced' => 96,
			'ArrayDereferenced' => 98,
			'TypeInner' => 143,
			'Literal' => 99,
			'Variable' => 148,
			'ListElements' => 344,
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 153
		}
	},
	{#State 317
		DEFAULT => -177
	},
	{#State 318
		DEFAULT => -174
	},
	{#State 319
		DEFAULT => -171
	},
	{#State 320
		ACTIONS => {
			")" => 345
		}
	},
	{#State 321
		DEFAULT => -120
	},
	{#State 322
		DEFAULT => -164
	},
	{#State 323
		DEFAULT => -165
	},
	{#State 324
		DEFAULT => -166
	},
	{#State 325
		ACTIONS => {
			";" => 346
		}
	},
	{#State 326
		ACTIONS => {
			'WORD' => -150,
			"for my integer" => -150,
			'OP22_LOGICAL_NOT' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'OP10_NAMED_UNARY' => -150,
			'VARIABLE_SYMBOL' => -150,
			'' => -150,
			'OP05_LOGICAL_NEG' => -150,
			"while (" => -150,
			"%{" => -150,
			'OP01_OPEN' => -150,
			'OP05_MATH_NEG' => -150,
			'OP01_NAMED_VOID' => -150,
			"\@{" => -150,
			"my" => -150,
			"if (" => -150,
			'OP01_CLOSE' => -150,
			"elsif (" => 348,
			'LITERAL_STRING' => -150,
			'OP10_NAMED_UNARY_STRINGIFY' => -150,
			"foreach my" => -150,
			"}" => -150,
			'OP01_PRINT_VOID' => -150,
			"undef" => -150,
			'OP19_LOOP_CONTROL' => -150,
			'LEFT_BRACE' => -150,
			"else" => 351,
			'LITERAL_NUMBER' => -150,
			'LEFT_PAREN' => -150,
			'WORD_SCOPED' => -150,
			'LEFT_BRACKET' => -150,
			'OP01_NAMED' => -150
		},
		GOTOS => {
			'PAREN-41' => 350,
			'OPTIONAL-42' => 349,
			'PAREN-39' => 347
		}
	},
	{#State 327
		DEFAULT => -159
	},
	{#State 328
		ACTIONS => {
			'LEFT_BRACKET' => 87,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_PRINT_VOID' => 83,
			'OP19_LOOP_CONTROL' => 79,
			'LEFT_BRACE' => 78,
			'OP05_MATH_NEG' => 118,
			'OP01_NAMED_VOID' => 117,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"while (" => -139,
			"}" => 353,
			"if (" => 114,
			"\@{" => 112,
			"foreach my" => -139,
			"my" => 113,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 111,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'PAREN-37' => 81,
			'Literal' => 99,
			'OPTIONAL-38' => 82,
			'Conditional' => 84,
			'Expression' => 94,
			'HashDereferenced' => 96,
			'VariableDeclaration' => 95,
			'OperatorVoid' => 77,
			'Statement' => 97,
			'ArrayDereferenced' => 98,
			'Operator' => 116,
			'SubExpression' => 119,
			'HashReference' => 93,
			'VariableModification' => 120,
			'Variable' => 92,
			'Operation' => 352,
			'LoopLabel' => 106
		}
	},
	{#State 329
		ACTIONS => {
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80
		},
		GOTOS => {
			'Variable' => 148,
			'WordScoped' => 86,
			'Operator' => 116,
			'ArrayReference' => 103,
			'HashReference' => 93,
			'SubExpression' => 354,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'ArrayDereferenced' => 98,
			'Literal' => 99
		}
	},
	{#State 330
		DEFAULT => -108
	},
	{#State 331
		ACTIONS => {
			"my" => 355
		}
	},
	{#State 332
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 356
		}
	},
	{#State 333
		DEFAULT => -48
	},
	{#State 334
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 357
		}
	},
	{#State 335
		DEFAULT => -81
	},
	{#State 336
		DEFAULT => -80
	},
	{#State 337
		DEFAULT => -59
	},
	{#State 338
		ACTIONS => {
			'TYPE_METHOD' => 358,
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 51
		}
	},
	{#State 339
		ACTIONS => {
			";" => 359
		}
	},
	{#State 340
		ACTIONS => {
			'OP21_LIST_COMMA' => 361,
			")" => 360
		},
		GOTOS => {
			'PAREN-25' => 362
		}
	},
	{#State 341
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 363
		}
	},
	{#State 342
		DEFAULT => -66
	},
	{#State 343
		ACTIONS => {
			"%{" => 121,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG' => 118,
			"\@{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 110,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_NUMBER' => 88,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			"undef" => 80,
			'OP01_CLOSE' => 100,
			'LEFT_BRACE' => 78
		},
		GOTOS => {
			'SubExpression' => 364,
			'HashReference' => 93,
			'ArrayReference' => 103,
			'Operator' => 116,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96
		}
	},
	{#State 344
		ACTIONS => {
			")" => 365
		}
	},
	{#State 345
		DEFAULT => -124
	},
	{#State 346
		DEFAULT => -168
	},
	{#State 347
		DEFAULT => -146
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP22_LOGICAL_NOT' => 108,
			"\@{" => 112,
			"%{" => 121,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			'LEFT_BRACE' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 96,
			'Expression' => 151,
			'Literal' => 99,
			'WordScoped' => 86,
			'Variable' => 148,
			'HashReference' => 93,
			'SubExpression' => 366,
			'Operator' => 116,
			'ArrayReference' => 103
		}
	},
	{#State 349
		DEFAULT => -151
	},
	{#State 350
		DEFAULT => -149
	},
	{#State 351
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 367
		}
	},
	{#State 352
		DEFAULT => -158
	},
	{#State 353
		DEFAULT => -160
	},
	{#State 354
		ACTIONS => {
			"]" => -87,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			";" => -87,
			".." => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			"}" => -87,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187
		}
	},
	{#State 355
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 368
		}
	},
	{#State 356
		ACTIONS => {
			"\@_;" => 369
		}
	},
	{#State 357
		ACTIONS => {
			'OP21_LIST_COMMA' => 370,
			")" => 372
		},
		GOTOS => {
			'PAREN-27' => 371
		}
	},
	{#State 358
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 359
		DEFAULT => -61
	},
	{#State 360
		ACTIONS => {
			";" => 374
		}
	},
	{#State 361
		ACTIONS => {
			"%{" => 121,
			'WORD' => 310
		},
		GOTOS => {
			'HashDereferenced' => 309,
			'HashEntryTyped' => 375
		}
	},
	{#State 362
		DEFAULT => -63
	},
	{#State 363
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"\@{" => 112,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'LEFT_BRACKET' => 87,
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'OP01_NAMED' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'SubExpression' => 376,
			'HashReference' => 93,
			'Operator' => 116,
			'ArrayReference' => 103,
			'WordScoped' => 86,
			'Variable' => 148,
			'Literal' => 99,
			'ArrayDereferenced' => 98,
			'Expression' => 151,
			'HashDereferenced' => 96
		}
	},
	{#State 364
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 194,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP04_MATH_POW' => 185,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP24_LOGICAL_OR_XOR' => 198,
			")" => 377,
			'OP11_COMPARE_LT_GT' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP08_MATH_ADD_SUB' => 197,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196
		}
	},
	{#State 365
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 366
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 197,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 191,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => 188,
			'OP15_LOGICAL_AND' => 195,
			'OP23_LOGICAL_AND' => 200,
			")" => 379,
			'OP11_COMPARE_LT_GT' => 199,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP08_STRING_CAT' => 186,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 194,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 187
		}
	},
	{#State 367
		DEFAULT => -148
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 369
		DEFAULT => -50
	},
	{#State 370
		ACTIONS => {
			"%{" => 121,
			'WORD' => 310
		},
		GOTOS => {
			'HashDereferenced' => 309,
			'HashEntryTyped' => 381
		}
	},
	{#State 371
		DEFAULT => -68
	},
	{#State 372
		ACTIONS => {
			";" => 382
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 374
		DEFAULT => -65
	},
	{#State 375
		DEFAULT => -62
	},
	{#State 376
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP08_STRING_CAT' => 186,
			'OP17_LIST_RANGE' => 187,
			'OP13_BITWISE_AND' => 193,
			'OP09_BITWISE_SHIFT' => 194,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP06_REGEX_MATCH' => 190,
			'OP08_MATH_ADD_SUB' => 197,
			'OP18_TERNARY' => 191,
			'OP24_LOGICAL_OR_XOR' => 198,
			'OP21_LIST_COMMA' => -190,
			'OP11_COMPARE_LT_GT' => 199,
			")" => -190,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 377
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 384
		}
	},
	{#State 378
		DEFAULT => -156
	},
	{#State 379
		ACTIONS => {
			'LEFT_BRACE' => 299
		},
		GOTOS => {
			'CodeBlock' => 385
		}
	},
	{#State 380
		DEFAULT => -47
	},
	{#State 381
		DEFAULT => -67
	},
	{#State 382
		DEFAULT => -70
	},
	{#State 383
		ACTIONS => {
			"if (" => -72,
			"foreach my" => -72,
			"\@{" => -72,
			"my" => -72,
			"%{" => -72,
			"while (" => -72,
			'OP05_MATH_NEG' => -72,
			'OP01_NAMED_VOID' => -72,
			"( my" => 386,
			'OP01_OPEN' => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'WORD' => -72,
			"for my integer" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'LITERAL_STRING' => -72,
			'OP01_NAMED' => -72,
			'LEFT_PAREN' => -72,
			'WORD_SCOPED' => -72,
			'LITERAL_NUMBER' => -72,
			'LEFT_BRACKET' => -72,
			'LEFT_BRACE' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP01_CLOSE' => -72,
			"undef" => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 388,
			'MethodArguments' => 387
		}
	},
	{#State 384
		DEFAULT => -155
	},
	{#State 385
		DEFAULT => -145
	},
	{#State 386
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 389
		}
	},
	{#State 387
		DEFAULT => -71
	},
	{#State 388
		ACTIONS => {
			'LEFT_PAREN' => 89,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 88,
			'LEFT_BRACKET' => 87,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85,
			'OP01_PRINT_VOID' => 83,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79,
			"%{" => 121,
			"while (" => -139,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"if (" => 114,
			"foreach my" => -139,
			"my" => 113,
			"\@{" => 112,
			"for my integer" => -139,
			'WORD' => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'PLUS-30' => 390,
			'LoopLabel' => 106,
			'Operation' => 391,
			'HashReference' => 93,
			'VariableModification' => 120,
			'SubExpression' => 119,
			'Operator' => 116,
			'Variable' => 92,
			'Conditional' => 84,
			'OPTIONAL-38' => 82,
			'PAREN-37' => 81,
			'Literal' => 99,
			'Statement' => 97,
			'ArrayDereferenced' => 98,
			'OperatorVoid' => 77,
			'VariableDeclaration' => 95,
			'HashDereferenced' => 96,
			'Expression' => 94,
			'ArrayReference' => 103,
			'WordScoped' => 86
		}
	},
	{#State 389
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 392
		}
	},
	{#State 390
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP03_MATH_INC_DEC' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'WORD' => 111,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG' => 118,
			'OP01_OPEN' => 115,
			"%{" => 121,
			"while (" => -139,
			"}" => 393,
			"if (" => 114,
			"foreach my" => -139,
			"\@{" => 112,
			"my" => 113,
			'OP01_CLOSE' => 100,
			"undef" => 80,
			'OP01_PRINT_VOID' => 83,
			'LEFT_BRACE' => 78,
			'OP19_LOOP_CONTROL' => 79,
			'LEFT_BRACKET' => 87,
			'WORD_SCOPED' => 23,
			'LEFT_PAREN' => 89,
			'LITERAL_NUMBER' => 88,
			'LITERAL_STRING' => 102,
			'OP01_NAMED' => 85
		},
		GOTOS => {
			'WordScoped' => 86,
			'ArrayReference' => 103,
			'HashDereferenced' => 96,
			'OperatorVoid' => 77,
			'VariableDeclaration' => 95,
			'Expression' => 94,
			'ArrayDereferenced' => 98,
			'Statement' => 97,
			'OPTIONAL-38' => 82,
			'Literal' => 99,
			'PAREN-37' => 81,
			'Conditional' => 84,
			'Variable' => 92,
			'Operator' => 116,
			'VariableModification' => 120,
			'HashReference' => 93,
			'SubExpression' => 119,
			'LoopLabel' => 106,
			'Operation' => 394
		}
	},
	{#State 391
		DEFAULT => -74
	},
	{#State 392
		ACTIONS => {
			'OP21_LIST_COMMA' => 396,
			")" => 397
		},
		GOTOS => {
			'PAREN-31' => 395
		}
	},
	{#State 393
		ACTIONS => {
			";" => 398
		}
	},
	{#State 394
		DEFAULT => -73
	},
	{#State 395
		DEFAULT => -77
	},
	{#State 396
		ACTIONS => {
			"my" => 399
		}
	},
	{#State 397
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 400
		}
	},
	{#State 398
		DEFAULT => -75
	},
	{#State 399
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 401
		}
	},
	{#State 400
		ACTIONS => {
			"\@_;" => 402
		}
	},
	{#State 401
		ACTIONS => {
			'VARIABLE_SYMBOL' => 403
		}
	},
	{#State 402
		DEFAULT => -79
	},
	{#State 403
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5509 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5516 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5523 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5530 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5541 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5552 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5559 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5566 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5573 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5580 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5587 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5594 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5601 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5608 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5615 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5622 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5629 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5636 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5661 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5672 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5683 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5694 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5701 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5708 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5715 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5722 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5729 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5736 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5743 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5750 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5761 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5797 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5804 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5811 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5822 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5844 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5872 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5996 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6003 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6017 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6028 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6153 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6175 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6255 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6266 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6376 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6398 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6464 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6475 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6486 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6493 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6500 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6511 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6522 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6533 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6544 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6558 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6572 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6583 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6594 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6605 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_125
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6616 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6671 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6704 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_135
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrPrompt_136
		 'SubExpressionOrPrompt', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6841 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6866 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6877 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6888 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6899 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6910 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6946 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6971 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6982 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7127 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_180
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7163 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_183
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_185
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7243 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7254 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7261 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7330 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_202
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_203
		 'FileHandleOpen', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleOpen_204
		 'FileHandleOpen', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_205
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandleClose_206
		 'FileHandleClose', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_207
		 'FileHandlePrint', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandlePrint_208
		 'FileHandlePrint', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_210
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	]
],
#line 7454 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_122', 
         'Expression_123', 
         'Expression_124', 
         'SubExpression_125', 
         'SubExpression_126', 
         'SubExpression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpressionOrPrompt_135', 
         'SubExpressionOrPrompt_136', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_140', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         'Statement_144', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_151', 
         'Loop_152', 
         'Loop_153', 
         'Loop_154', 
         'LoopFor_155', 
         'LoopForEach_156', 
         'LoopWhile_157', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_160', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_163', 
         'VariableRetrieval_164', 
         'VariableRetrieval_165', 
         'VariableRetrieval_166', 
         'VariableDeclaration_167', 
         'VariableDeclaration_168', 
         'VariableModification_169', 
         'VariableModification_170', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_176', 
         'ListElements_177', 
         'ListElement_178', 
         'ListElement_179', 
         'ListElement_180', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_183', 
         'ArrayDereferenced_184', 
         'ArrayDereferenced_185', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_188', 
         'HashEntry_189', 
         'HashEntryTyped_190', 
         'HashEntryTyped_191', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_195', 
         'HashDereferenced_196', 
         'HashDereferenced_197', 
         'WordScoped_198', 
         'WordScoped_199', 
         'LoopLabel_200', 
         'Type_201', 
         'TypeInner_202', 
         'FileHandleOpen_203', 
         'FileHandleOpen_204', 
         'FileHandleClose_205', 
         'FileHandleClose_206', 
         'FileHandlePrint_207', 
         'FileHandlePrint_208', 
         'Literal_209', 
         'Literal_210', );
  $self;
}

#line 189 "lib/RPerl/Grammar.eyp"


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


#line 7713 lib/RPerl/Grammar.pm



1;
