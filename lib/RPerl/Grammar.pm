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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\=\ sub\ \{|elsif\ \(|package|while\ \(|\$TYPED_|undef|if\ \(|else|\(\ my|qw\(|use|our|\@_\;|\@\{|\.\.|\%\{|my|\)|\}|\;|\])}gc and return ($1, $1);

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
			"## no critic qw(" => 4,
			"package" => -20,
			'SHEBANG' => 9
		},
		GOTOS => {
			'CompileUnit' => 3,
			'Critic' => 8,
			'PLUS-2' => 7,
			'OPTIONAL-9' => 6,
			'PAREN-1' => 5,
			'Program' => 2,
			'ModuleHeader' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"use" => -25,
			"our" => -25,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use parent qw(" => 10
		},
		GOTOS => {
			'Class' => 13,
			'Package' => 14,
			'STAR-10' => 11,
			'Module' => 12
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			'' => 15
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-14' => 17
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			"package" => 18
		}
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 4,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 8,
			'OPTIONAL-9' => 6,
			'PAREN-1' => 19,
			'ModuleHeader' => 1
		}
	},
	{#State 8
		DEFAULT => -19
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 20
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 11
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 25,
			'STAR-11' => 26
		}
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		DEFAULT => -23
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -35
	},
	{#State 17
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 18
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
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
			")" => 32
		}
	},
	{#State 23
		DEFAULT => -198
	},
	{#State 24
		DEFAULT => -197
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		ACTIONS => {
			"use" => 34,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 33
		}
	},
	{#State 27
		DEFAULT => -34
	},
	{#State 28
		DEFAULT => -36
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
		DEFAULT => -26
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 45,
			"our" => 43
		},
		GOTOS => {
			'Constant' => 42,
			'Subroutine' => 41,
			'PLUS-13' => 44
		}
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
			"my" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"while (" => -11,
			'OP01_PRINT_VOID' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"our" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP01_OPEN' => -11,
			'OP05_MATH_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"for my integer" => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'LEFT_PAREN' => -11,
			"use constant" => -11,
			"use" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP01_NAMED' => -11,
			"undef" => -11,
			"if (" => -11,
			"foreach my" => -11,
			'LEFT_BRACKET' => -11,
			"## no critic qw(" => 4,
			'WORD' => -11,
			'LEFT_BRACE' => -11,
			"\@{" => -11
		},
		GOTOS => {
			'Critic' => 48,
			'STAR-5' => 49
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
			";" => 52,
			"qw(" => 51
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		DEFAULT => -28
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 57
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
			'WORD' => -13,
			'LEFT_BRACE' => -13,
			"\@{" => -13,
			"undef" => -13,
			"if (" => -13,
			"foreach my" => -13,
			'LEFT_BRACKET' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP01_NAMED' => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_STRING' => -13,
			"use constant" => -13,
			'LEFT_PAREN' => -13,
			"use" => 34,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_MATH_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_SCOPED' => -13,
			"for my integer" => -13,
			"%{" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP01_OPEN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			"while (" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT_VOID' => -13,
			'OP10_NAMED_UNARY' => -13,
			"our" => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 59
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
			'WORD' => 63
		},
		GOTOS => {
			'PLUS-15' => 62
		}
	},
	{#State 52
		DEFAULT => -39
	},
	{#State 53
		DEFAULT => -200
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
		}
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			";" => 65
		}
	},
	{#State 57
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
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
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_CLOSE' => -15,
			"my" => -15,
			'LITERAL_STRING' => -15,
			"while (" => -15,
			"use constant" => 45,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_PRINT_VOID' => -15,
			'LEFT_PAREN' => -15,
			"our" => -15,
			'WORD' => -15,
			'VARIABLE_SYMBOL' => -15,
			'LEFT_BRACE' => -15,
			'OP01_NAMED_VOID' => -15,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"if (" => -15,
			'OP05_MATH_NEG' => -15,
			"foreach my" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			"for my integer" => -15,
			"%{" => -15,
			'LEFT_BRACKET' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 68
		}
	},
	{#State 61
		ACTIONS => {
			"our %properties = (" => -54,
			"## no critic qw(" => 4,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 70,
			'Critic' => 71
		}
	},
	{#State 62
		ACTIONS => {
			")" => 72,
			'WORD' => 73
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"my" => 75
		},
		GOTOS => {
			'TypeInner' => 76
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'WORD' => 111,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			"undef" => 116,
			"if (" => 117,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			'OP19_LOOP_CONTROL' => 96,
			"foreach my" => -138,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			"while (" => -138,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP01_PRINT_VOID' => 83,
			'OP10_NAMED_UNARY' => 84,
			"our" => 43
		},
		GOTOS => {
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'VariableModification' => 98,
			'Variable' => 89,
			'OperatorVoid' => 87,
			'Subroutine' => 93,
			'PLUS-8' => 92,
			'Literal' => 114,
			'SubExpression' => 90,
			'LoopLabel' => 82,
			'Statement' => 105,
			'Operator' => 104,
			'Expression' => 110,
			'OPTIONAL-37' => 109,
			'VariableDeclaration' => 108,
			'Conditional' => 85,
			'Operation' => 99,
			'PAREN-36' => 101,
			'HashReference' => 79
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"use" => 34,
			"use constant" => -56,
			"our %properties = (" => -56
		},
		GOTOS => {
			'STAR-22' => 122,
			'Include' => 123
		}
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		ACTIONS => {
			";" => 124
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			'OP10_NAMED_UNARY' => -43,
			'OP01_PRINT_VOID' => -43,
			'LEFT_PAREN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"my" => -43,
			'OP01_CLOSE' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LITERAL_STRING' => -43,
			"while (" => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'OP01_OPEN' => -43,
			'OP01_NAMED' => -43,
			'LEFT_BRACKET' => -43,
			"%{" => -43,
			'OP05_MATH_NEG' => -43,
			'LITERAL_NUMBER' => -43,
			"if (" => -43,
			"undef" => -43,
			'WORD_SCOPED' => -43,
			"( my" => 126,
			"for my integer" => -43,
			"foreach my" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"\@{" => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD' => -43,
			'LEFT_BRACE' => -43,
			'VARIABLE_SYMBOL' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 125,
			'OPTIONAL-16' => 127
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'LITERAL_NUMBER' => 95
		},
		GOTOS => {
			'Literal' => 129
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113
		},
		GOTOS => {
			'SubExpression' => 131,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118
		}
	},
	{#State 78
		ACTIONS => {
			"my" => 133,
			'STDIN_STDOUT_STDERR' => 135
		},
		GOTOS => {
			'FileHandleOpen' => 134
		}
	},
	{#State 79
		DEFAULT => -130
	},
	{#State 80
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 136
		}
	},
	{#State 81
		ACTIONS => {
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 137,
			'Variable' => 132,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104
		}
	},
	{#State 82
		ACTIONS => {
			'COLON' => 138
		}
	},
	{#State 83
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'KEYS_OR_VALUES' => 140,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'LEFT_BRACE' => 141,
			'VARIABLE_SYMBOL' => 88,
			'STDIN_STDOUT_STDERR' => 142,
			'WORD' => 24,
			"\@{" => 113,
			'LITERAL_STRING' => 106,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_QW' => 139,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100
		},
		GOTOS => {
			'ListElement' => 143,
			'ArrayReference' => 121,
			'Expression' => 130,
			'FileHandlePrint' => 145,
			'ListElements' => 144,
			'TypeInner' => 146,
			'HashDereferenced' => 120,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 147,
			'Variable' => 132
		}
	},
	{#State 84
		ACTIONS => {
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77
		},
		GOTOS => {
			'SubExpression' => 148,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115
		}
	},
	{#State 85
		DEFAULT => -139
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 149
		}
	},
	{#State 87
		DEFAULT => -141
	},
	{#State 88
		DEFAULT => -161,
		GOTOS => {
			'STAR-43' => 150
		}
	},
	{#State 89
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 152,
			'OP02_METHOD_THINARROW' => 153,
			'OP19_VARIABLE_ASSIGN' => 151,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP08_STRING_CAT' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP18_TERNARY' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP03_MATH_INC_DEC' => 154,
			'OP09_BITWISE_SHIFT' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP04_MATH_POW' => -127
		}
	},
	{#State 90
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 157,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170
		}
	},
	{#State 91
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'KEYS_OR_VALUES' => 140,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113,
			'LITERAL_STRING' => 106,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			";" => -112,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100
		},
		GOTOS => {
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'ListElement' => 143,
			'Expression' => 130,
			'ArrayReference' => 121,
			'ListElements' => 172,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'OPTIONAL-33' => 171,
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 147
		}
	},
	{#State 92
		ACTIONS => {
			"\@{" => 113,
			'' => -18,
			'OP01_NAMED_VOID' => 91,
			'WORD' => 111,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"if (" => 117,
			"undef" => 116,
			"for my integer" => -138,
			'WORD_SCOPED' => 23,
			'OP19_LOOP_CONTROL' => 96,
			"foreach my" => -138,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP01_PRINT_VOID' => 83,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			"my" => 80,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			"while (" => -138,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'Literal' => 114,
			'SubExpression' => 90,
			'Variable' => 89,
			'OperatorVoid' => 87,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'VariableModification' => 98,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'PAREN-36' => 101,
			'HashReference' => 79,
			'Operation' => 173,
			'OPTIONAL-37' => 109,
			'Expression' => 110,
			'VariableDeclaration' => 108,
			'Conditional' => 85,
			'LoopLabel' => 82,
			'Statement' => 105,
			'Operator' => 104
		}
	},
	{#State 93
		DEFAULT => -14
	},
	{#State 94
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 174,
			'Variable' => 132,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 95
		DEFAULT => -209
	},
	{#State 96
		ACTIONS => {
			'WORD' => 175
		},
		GOTOS => {
			'LoopLabel' => 176
		}
	},
	{#State 97
		ACTIONS => {
			'LEFT_BRACE' => 177,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 178,
			'HashReference' => 179
		}
	},
	{#State 98
		DEFAULT => -143
	},
	{#State 99
		DEFAULT => -17
	},
	{#State 100
		ACTIONS => {
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113
		},
		GOTOS => {
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 180
		}
	},
	{#State 101
		DEFAULT => -137
	},
	{#State 102
		ACTIONS => {
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'LITERAL_STRING' => 106,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'LEFT_BRACKET' => 119,
			"%{" => 97
		},
		GOTOS => {
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 181,
			'Variable' => 132
		}
	},
	{#State 103
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 183,
			'STDIN_STDOUT_STDERR' => 182
		},
		GOTOS => {
			'FileHandleClose' => 184
		}
	},
	{#State 104
		DEFAULT => -121
	},
	{#State 105
		DEFAULT => -83
	},
	{#State 106
		DEFAULT => -208
	},
	{#State 107
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 185,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77
		},
		GOTOS => {
			'SubExpression' => 186,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 108
		DEFAULT => -142
	},
	{#State 109
		ACTIONS => {
			"for my integer" => 187,
			"foreach my" => 191,
			"while (" => 188
		},
		GOTOS => {
			'LoopWhile' => 190,
			'Loop' => 193,
			'LoopForEach' => 189,
			'LoopFor' => 192
		}
	},
	{#State 110
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -124,
			'OP08_STRING_CAT' => -124,
			'OP06_REGEX_MATCH' => -124,
			'OP16_LOGICAL_OR' => -124,
			'OP18_TERNARY' => -124,
			'OP13_BITWISE_AND' => -124,
			'OP07_MATH_MULT_DIV_MOD' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP12_COMPARE_EQ_NEQ' => -124,
			'OP14_BITWISE_OR_XOR' => -124,
			'OP04_MATH_POW' => -124,
			'OP11_COMPARE_LT_GT' => -124,
			";" => 194,
			'OP17_LIST_RANGE' => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP09_BITWISE_SHIFT' => -124,
			'OP15_LOGICAL_AND' => -124
		}
	},
	{#State 111
		ACTIONS => {
			'LEFT_PAREN' => -197,
			'COLON' => -199
		}
	},
	{#State 112
		ACTIONS => {
			"%{" => 97,
			"}" => 197,
			'WORD' => 198
		},
		GOTOS => {
			'HashEntry' => 195,
			'HashDereferenced' => 196
		}
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'Variable' => 199,
			'ArrayReference' => 200
		}
	},
	{#State 114
		DEFAULT => -126
	},
	{#State 115
		DEFAULT => -129
	},
	{#State 116
		DEFAULT => -125
	},
	{#State 117
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 201,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120
		}
	},
	{#State 118
		ACTIONS => {
			'LEFT_PAREN' => 202
		}
	},
	{#State 119
		ACTIONS => {
			"]" => -181,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'KEYS_OR_VALUES' => 140,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'LITERAL_STRING' => 106,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'SubExpression' => 147,
			'OPTIONAL-47' => 203,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'ArrayReference' => 121,
			'ListElement' => 143,
			'Expression' => 130,
			'ListElements' => 204,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115
		}
	},
	{#State 120
		DEFAULT => -131
	},
	{#State 121
		DEFAULT => -128
	},
	{#State 122
		ACTIONS => {
			"use constant" => 45,
			"our %properties = (" => 205
		},
		GOTOS => {
			'Properties' => 207,
			'Constant' => 206
		}
	},
	{#State 123
		DEFAULT => -53
	},
	{#State 124
		DEFAULT => -40
	},
	{#State 125
		DEFAULT => -42
	},
	{#State 126
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 127
		ACTIONS => {
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			"if (" => 117,
			'OP05_MATH_NEG' => 94,
			"foreach my" => -138,
			'OP19_LOOP_CONTROL' => 96,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			'WORD' => 111,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP01_PRINT_VOID' => 83,
			'OP10_NAMED_UNARY' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			"while (" => -138,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78
		},
		GOTOS => {
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'VariableModification' => 98,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'OperatorVoid' => 87,
			'Variable' => 89,
			'PLUS-17' => 209,
			'SubExpression' => 90,
			'Literal' => 114,
			'Operator' => 104,
			'LoopLabel' => 82,
			'Statement' => 105,
			'Conditional' => 85,
			'OPTIONAL-37' => 109,
			'Expression' => 110,
			'VariableDeclaration' => 108,
			'Operation' => 210,
			'HashReference' => 79,
			'PAREN-36' => 101
		}
	},
	{#State 128
		ACTIONS => {
			"\$TYPED_" => 211
		}
	},
	{#State 129
		ACTIONS => {
			";" => 212
		}
	},
	{#State 130
		DEFAULT => -124
	},
	{#State 131
		ACTIONS => {
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP16_LOGICAL_OR' => 157,
			".." => -108,
			"]" => -108,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP14_BITWISE_OR_XOR' => 161,
			")" => -108,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -108,
			";" => -108,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP21_LIST_COMMA' => -108,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP23_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => 168
		}
	},
	{#State 132
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			")" => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			"}" => -127,
			'OP02_METHOD_THINARROW' => 153,
			'OP16_LOGICAL_OR' => -127,
			".." => -127,
			'OP18_TERNARY' => -127,
			'OP13_BITWISE_AND' => -127,
			"]" => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP08_STRING_CAT' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP03_MATH_INC_DEC' => 154,
			'OP23_LOGICAL_AND' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP04_MATH_POW' => -127,
			";" => -127,
			'OP21_LIST_COMMA' => -127
		}
	},
	{#State 133
		ACTIONS => {
			"filehandle_ref" => 213
		}
	},
	{#State 134
		ACTIONS => {
			'OP21_LIST_COMMA' => 214
		}
	},
	{#State 135
		DEFAULT => -202
	},
	{#State 136
		ACTIONS => {
			'VARIABLE_SYMBOL' => 215
		}
	},
	{#State 137
		ACTIONS => {
			"]" => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_STRING_CAT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP18_TERNARY' => -91,
			'OP16_LOGICAL_OR' => -91,
			".." => -91,
			"}" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			")" => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			";" => -91,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91
		}
	},
	{#State 138
		DEFAULT => -136
	},
	{#State 139
		ACTIONS => {
			'LEFT_PAREN' => 216
		}
	},
	{#State 140
		ACTIONS => {
			"%{" => 97
		},
		GOTOS => {
			'HashDereferenced' => 217
		}
	},
	{#State 141
		ACTIONS => {
			'FILEHANDLE_REF_SYMBOL' => 218,
			"%{" => 97,
			"}" => 197,
			'WORD' => 198
		},
		GOTOS => {
			'HashDereferenced' => 196,
			'HashEntry' => 195
		}
	},
	{#State 142
		DEFAULT => -206
	},
	{#State 143
		DEFAULT => -172,
		GOTOS => {
			'STAR-45' => 219
		}
	},
	{#State 144
		ACTIONS => {
			";" => 220
		}
	},
	{#State 145
		ACTIONS => {
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			'KEYS_OR_VALUES' => 140,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 75,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'ListElement' => 143,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ListElements' => 221,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'SubExpression' => 147,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132
		}
	},
	{#State 146
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94
		},
		GOTOS => {
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 222,
			'Variable' => 132
		}
	},
	{#State 147
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP12_COMPARE_EQ_NEQ' => 155,
			")" => -177,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP16_LOGICAL_OR' => 157,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => -177,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP21_LIST_COMMA' => -177,
			";" => -177,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169
		}
	},
	{#State 148
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP04_MATH_POW' => 169,
			'OP21_LIST_COMMA' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			")" => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP18_TERNARY' => -98,
			".." => -98,
			'OP16_LOGICAL_OR' => -98,
			"]" => -98,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 149
		DEFAULT => -88
	},
	{#State 150
		ACTIONS => {
			'OP21_LIST_COMMA' => -162,
			";" => -162,
			'OP04_MATH_POW' => -162,
			'OP11_COMPARE_LT_GT' => -162,
			'OP03_MATH_INC_DEC' => -162,
			'OP15_LOGICAL_AND' => -162,
			'OP09_BITWISE_SHIFT' => -162,
			'OP17_LIST_RANGE' => -162,
			'OP23_LOGICAL_AND' => -162,
			'OP18_TERNARY' => -162,
			'OP13_BITWISE_AND' => -162,
			".." => -162,
			'OP16_LOGICAL_OR' => -162,
			'OP08_STRING_CAT' => -162,
			'OP06_REGEX_MATCH' => -162,
			'OP08_MATH_ADD_SUB' => -162,
			'OP02_HASH_THINARROW' => 224,
			"]" => -162,
			'OP19_VARIABLE_ASSIGN' => -162,
			'OP07_MATH_MULT_DIV_MOD' => -162,
			'OP14_BITWISE_OR_XOR' => -162,
			'COLON' => -162,
			'OP24_LOGICAL_OR_XOR' => -162,
			")" => -162,
			'OP12_COMPARE_EQ_NEQ' => -162,
			'OP02_ARRAY_THINARROW' => 225,
			'OP02_METHOD_THINARROW' => -162,
			'OP19_VARIABLE_ASSIGN_BY' => -162,
			"}" => -162
		},
		GOTOS => {
			'VariableRetrieval' => 223
		}
	},
	{#State 151
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"%{" => 97,
			'STDIN_PROMPT' => 226,
			'LEFT_BRACKET' => 119,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94
		},
		GOTOS => {
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 227,
			'Variable' => 132,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'SubExpressionOrPrompt' => 228,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118
		}
	},
	{#State 152
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 229,
			'Variable' => 132,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104
		}
	},
	{#State 153
		ACTIONS => {
			'WORD' => 230
		}
	},
	{#State 154
		DEFAULT => -89
	},
	{#State 155
		ACTIONS => {
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'SubExpression' => 231,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132
		}
	},
	{#State 156
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 232
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77
		},
		GOTOS => {
			'Variable' => 132,
			'SubExpression' => 233,
			'Literal' => 114,
			'HashReference' => 79,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121
		}
	},
	{#State 158
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'SubExpression' => 234,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104
		}
	},
	{#State 159
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 235,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120
		}
	},
	{#State 160
		ACTIONS => {
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78
		},
		GOTOS => {
			'Variable' => 132,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 236,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120
		}
	},
	{#State 161
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113
		},
		GOTOS => {
			'SubExpression' => 237,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'Variable' => 132,
			'SubExpression' => 238,
			'HashReference' => 79,
			'Literal' => 114
		}
	},
	{#State 163
		ACTIONS => {
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 106,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'SubExpression' => 239,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'Variable' => 132,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 240,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120
		}
	},
	{#State 165
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 241
		}
	},
	{#State 166
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97
		},
		GOTOS => {
			'Variable' => 132,
			'SubExpression' => 242,
			'HashReference' => 79,
			'Literal' => 114,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121
		}
	},
	{#State 167
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97
		},
		GOTOS => {
			'SubExpression' => 243,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104
		}
	},
	{#State 168
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'SubExpression' => 244,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132
		}
	},
	{#State 169
		ACTIONS => {
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'LITERAL_STRING' => 106,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'LEFT_BRACKET' => 119,
			"%{" => 97
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'SubExpression' => 245,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132
		}
	},
	{#State 170
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 246,
			'Variable' => 132,
			'Expression' => 130,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 171
		ACTIONS => {
			";" => 247
		}
	},
	{#State 172
		DEFAULT => -111
	},
	{#State 173
		DEFAULT => -16
	},
	{#State 174
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => 248,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP16_LOGICAL_OR' => 157,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170
		}
	},
	{#State 175
		DEFAULT => -199
	},
	{#State 176
		ACTIONS => {
			";" => 249
		}
	},
	{#State 177
		ACTIONS => {
			"%{" => 97,
			'WORD' => 198
		},
		GOTOS => {
			'HashEntry' => 195,
			'HashDereferenced' => 196
		}
	},
	{#State 178
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 179
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 180
		ACTIONS => {
			";" => -99,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => -99,
			"]" => -99,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			'OP18_TERNARY' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			".." => -99,
			"}" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 181
		ACTIONS => {
			'OP23_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP04_MATH_POW' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			"}" => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			")" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			"]" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			".." => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP18_TERNARY' => -85,
			'OP13_BITWISE_AND' => -85
		}
	},
	{#State 182
		DEFAULT => -204
	},
	{#State 183
		DEFAULT => -205
	},
	{#State 184
		DEFAULT => -87
	},
	{#State 185
		ACTIONS => {
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 106,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'KEYS_OR_VALUES' => 140,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			"\@{" => 113,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 132,
			'SubExpression' => 252,
			'Literal' => 114,
			'HashReference' => 79,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'Expression' => 130,
			'ListElement' => 253,
			'ArrayReference' => 121
		}
	},
	{#State 186
		ACTIONS => {
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP16_LOGICAL_OR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => 254,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167
		}
	},
	{#State 187
		ACTIONS => {
			'VARIABLE_SYMBOL' => 255
		}
	},
	{#State 188
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112
		},
		GOTOS => {
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'Variable' => 132,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 256
		}
	},
	{#State 189
		DEFAULT => -152
	},
	{#State 190
		DEFAULT => -153
	},
	{#State 191
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 192
		DEFAULT => -151
	},
	{#State 193
		DEFAULT => -140
	},
	{#State 194
		DEFAULT => -82
	},
	{#State 195
		DEFAULT => -193,
		GOTOS => {
			'STAR-50' => 258
		}
	},
	{#State 196
		DEFAULT => -188
	},
	{#State 197
		DEFAULT => -132
	},
	{#State 198
		ACTIONS => {
			'OP20_HASH_FATARROW' => 259
		}
	},
	{#State 199
		ACTIONS => {
			"}" => 260
		}
	},
	{#State 200
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 201
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP12_COMPARE_EQ_NEQ' => 155,
			")" => 262,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP16_LOGICAL_OR' => 157,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158
		}
	},
	{#State 202
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			")" => -118,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'KEYS_OR_VALUES' => 140,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112
		},
		GOTOS => {
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 147,
			'OPTIONAL-34' => 264,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'ListElements' => 263,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ListElement' => 143,
			'HashDereferenced' => 120,
			'TypeInner' => 146
		}
	},
	{#State 203
		ACTIONS => {
			"]" => 265
		}
	},
	{#State 204
		DEFAULT => -180
	},
	{#State 205
		ACTIONS => {
			")" => 267,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 266
		}
	},
	{#State 206
		DEFAULT => -55
	},
	{#State 207
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 269,
			"our" => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 270,
			'PropertiesClass' => 268
		}
	},
	{#State 208
		ACTIONS => {
			'VARIABLE_SYMBOL' => 271
		}
	},
	{#State 209
		ACTIONS => {
			'LITERAL_STRING' => 106,
			"while (" => -138,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP01_PRINT_VOID' => 83,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			"foreach my" => -138,
			'OP19_LOOP_CONTROL' => 96,
			"for my integer" => -138,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			"if (" => 117,
			'LITERAL_NUMBER' => 95,
			"}" => 273,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 111,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113
		},
		GOTOS => {
			'Variable' => 89,
			'OperatorVoid' => 87,
			'Literal' => 114,
			'SubExpression' => 90,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'ArrayReference' => 121,
			'VariableModification' => 98,
			'HashDereferenced' => 120,
			'Operation' => 272,
			'HashReference' => 79,
			'PAREN-36' => 101,
			'Statement' => 105,
			'LoopLabel' => 82,
			'Operator' => 104,
			'VariableDeclaration' => 108,
			'OPTIONAL-37' => 109,
			'Expression' => 110,
			'Conditional' => 85
		}
	},
	{#State 210
		DEFAULT => -45
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
			'FILEHANDLE_REF_SYMBOL' => 275
		}
	},
	{#State 214
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 132,
			'SubExpression' => 276,
			'HashReference' => 79,
			'Literal' => 114,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130
		}
	},
	{#State 215
		ACTIONS => {
			";" => 278,
			'OP19_VARIABLE_ASSIGN' => 277
		}
	},
	{#State 216
		ACTIONS => {
			'WORD' => 279
		},
		GOTOS => {
			'PLUS-46' => 280
		}
	},
	{#State 217
		DEFAULT => -179
	},
	{#State 218
		ACTIONS => {
			"}" => 281
		}
	},
	{#State 219
		ACTIONS => {
			")" => -175,
			"]" => -175,
			";" => -175,
			'OP21_LIST_COMMA' => 283
		},
		GOTOS => {
			'PAREN-44' => 282
		}
	},
	{#State 220
		DEFAULT => -114
	},
	{#State 221
		ACTIONS => {
			";" => 284
		}
	},
	{#State 222
		ACTIONS => {
			'OP21_LIST_COMMA' => -178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			";" => -178,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			"]" => -178,
			'OP16_LOGICAL_OR' => 157,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP12_COMPARE_EQ_NEQ' => 155,
			")" => -178,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP14_BITWISE_OR_XOR' => 161
		}
	},
	{#State 223
		DEFAULT => -160
	},
	{#State 224
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 285,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112
		},
		GOTOS => {
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 286,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120
		}
	},
	{#State 225
		ACTIONS => {
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 23,
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102
		},
		GOTOS => {
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'SubExpression' => 287,
			'HashReference' => 79,
			'Literal' => 114,
			'Variable' => 132
		}
	},
	{#State 226
		DEFAULT => -135
	},
	{#State 227
		ACTIONS => {
			";" => -134,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP16_LOGICAL_OR' => 157,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 228
		ACTIONS => {
			";" => 288
		}
	},
	{#State 229
		ACTIONS => {
			";" => 289,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP16_LOGICAL_OR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => 162
		}
	},
	{#State 230
		ACTIONS => {
			'LEFT_PAREN' => 290
		}
	},
	{#State 231
		ACTIONS => {
			'OP16_LOGICAL_OR' => -101,
			".." => -101,
			'OP18_TERNARY' => -101,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP24_LOGICAL_OR_XOR' => -101,
			")" => -101,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -101,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 166,
			'OP23_LOGICAL_AND' => -101,
			'OP17_LIST_RANGE' => -101
		}
	},
	{#State 232
		ACTIONS => {
			'COLON' => 291
		}
	},
	{#State 233
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			";" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			"]" => -105,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP16_LOGICAL_OR' => -105,
			".." => -105,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => -105,
			"}" => -105,
			")" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 234
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -96,
			'OP18_TERNARY' => -96,
			'OP13_BITWISE_AND' => -96,
			".." => -96,
			'OP16_LOGICAL_OR' => -96,
			"]" => -96,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => -96,
			'OP08_MATH_ADD_SUB' => 159,
			'OP09_BITWISE_SHIFT' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP04_MATH_POW' => 169,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			")" => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			".." => -95,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			"]" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			";" => -95,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => -95
		}
	},
	{#State 236
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			")" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			"}" => -109,
			'OP16_LOGICAL_OR' => 157,
			".." => -109,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			"]" => -109,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -109
		}
	},
	{#State 237
		ACTIONS => {
			";" => -103,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP21_LIST_COMMA' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP09_BITWISE_SHIFT' => 166,
			"]" => -103,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => -103,
			'OP16_LOGICAL_OR' => -103,
			".." => -103,
			"}" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP12_COMPARE_EQ_NEQ' => 155,
			")" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 238
		ACTIONS => {
			'OP16_LOGICAL_OR' => 157,
			".." => -110,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			"]" => -110,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			")" => -110,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -110,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168
		}
	},
	{#State 239
		ACTIONS => {
			"}" => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			")" => -94,
			'OP12_COMPARE_EQ_NEQ' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => -94,
			"]" => -94,
			".." => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP18_TERNARY' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP04_MATH_POW' => 169,
			";" => -94
		}
	},
	{#State 240
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -102,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP23_LOGICAL_AND' => -102,
			".." => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => -102,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => -102,
			"}" => -102
		}
	},
	{#State 241
		DEFAULT => -93
	},
	{#State 242
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP12_COMPARE_EQ_NEQ' => -97,
			")" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			".." => -97,
			'OP13_BITWISE_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP08_MATH_ADD_SUB' => 159,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			"]" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP04_MATH_POW' => 169,
			";" => -97
		}
	},
	{#State 243
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			";" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			")" => -104,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -104,
			".." => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => -104,
			"]" => -104,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165
		}
	},
	{#State 244
		ACTIONS => {
			'OP16_LOGICAL_OR' => 157,
			".." => -106,
			'OP18_TERNARY' => -106,
			'OP13_BITWISE_AND' => 164,
			"]" => -106,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			")" => -106,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -106,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 245
		ACTIONS => {
			"}" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP12_COMPARE_EQ_NEQ' => -90,
			")" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			"]" => -90,
			'OP18_TERNARY' => -90,
			'OP13_BITWISE_AND' => -90,
			".." => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP21_LIST_COMMA' => -90,
			";" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP04_MATH_POW' => 169
		}
	},
	{#State 246
		ACTIONS => {
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			".." => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 169,
			";" => -100,
			'OP21_LIST_COMMA' => -100
		}
	},
	{#State 247
		DEFAULT => -113
	},
	{#State 248
		DEFAULT => -92
	},
	{#State 249
		DEFAULT => -116
	},
	{#State 250
		DEFAULT => -195
	},
	{#State 251
		DEFAULT => -196
	},
	{#State 252
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_STRING_CAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			")" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -177,
			'OP04_MATH_POW' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85
		}
	},
	{#State 253
		ACTIONS => {
			'OP21_LIST_COMMA' => 292
		}
	},
	{#State 254
		DEFAULT => -133
	},
	{#State 255
		ACTIONS => {
			'LEFT_PAREN' => 293
		}
	},
	{#State 256
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP12_COMPARE_EQ_NEQ' => 155,
			")" => 294,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP16_LOGICAL_OR' => 157,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170
		}
	},
	{#State 257
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 258
		ACTIONS => {
			'OP21_LIST_COMMA' => 298,
			"}" => 297
		},
		GOTOS => {
			'PAREN-49' => 296
		}
	},
	{#State 259
		ACTIONS => {
			'OP01_NAMED' => -186,
			'OP01_OPEN' => -186,
			'OP10_NAMED_UNARY_STRINGIFY' => -186,
			'OP22_LOGICAL_NOT' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'LEFT_PAREN' => -186,
			'OP10_NAMED_UNARY' => -186,
			'LITERAL_STRING' => -186,
			'OP05_LOGICAL_NEG' => -186,
			'OP01_CLOSE' => -186,
			"my" => 75,
			"\@{" => -186,
			'VARIABLE_SYMBOL' => -186,
			'LEFT_BRACE' => -186,
			'WORD' => -186,
			"%{" => -186,
			'LEFT_BRACKET' => -186,
			'WORD_SCOPED' => -186,
			"undef" => -186,
			'LITERAL_NUMBER' => -186,
			'OP05_MATH_NEG' => -186
		},
		GOTOS => {
			'OPTIONAL-48' => 299,
			'TypeInner' => 300
		}
	},
	{#State 260
		DEFAULT => -183
	},
	{#State 261
		DEFAULT => -184
	},
	{#State 262
		ACTIONS => {
			'LEFT_BRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 301
		}
	},
	{#State 263
		DEFAULT => -117
	},
	{#State 264
		ACTIONS => {
			")" => 303
		}
	},
	{#State 265
		DEFAULT => -182
	},
	{#State 266
		ACTIONS => {
			"%{" => 97,
			'WORD' => 305
		},
		GOTOS => {
			'HashDereferenced' => 306,
			'HashEntryTyped' => 304
		}
	},
	{#State 267
		ACTIONS => {
			";" => 307
		}
	},
	{#State 268
		DEFAULT => -57
	},
	{#State 269
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 308
		}
	},
	{#State 270
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 309
		}
	},
	{#State 271
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 310
		}
	},
	{#State 272
		DEFAULT => -44
	},
	{#State 273
		ACTIONS => {
			";" => 311
		}
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 275
		DEFAULT => -203
	},
	{#State 276
		ACTIONS => {
			'OP21_LIST_COMMA' => 313,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP16_LOGICAL_OR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 155
		}
	},
	{#State 277
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			"\@{" => 113,
			'WORD_SCOPED' => 23,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"%{" => 97,
			'STDIN_PROMPT' => 226,
			'LEFT_BRACKET' => 119,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'LITERAL_STRING' => 106,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107
		},
		GOTOS => {
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'SubExpressionOrPrompt' => 314,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'Variable' => 132,
			'SubExpression' => 227,
			'Literal' => 114,
			'HashReference' => 79
		}
	},
	{#State 278
		DEFAULT => -166
	},
	{#State 279
		DEFAULT => -174
	},
	{#State 280
		ACTIONS => {
			'WORD' => 315,
			")" => 316
		}
	},
	{#State 281
		DEFAULT => -207
	},
	{#State 282
		DEFAULT => -171
	},
	{#State 283
		ACTIONS => {
			'OP05_MATH_NEG' => 94,
			'KEYS_OR_VALUES' => 140,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113,
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102
		},
		GOTOS => {
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'ArrayReference' => 121,
			'ListElement' => 317,
			'Expression' => 130,
			'TypeInner' => 146,
			'HashDereferenced' => 120,
			'Variable' => 132,
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 147
		}
	},
	{#State 284
		DEFAULT => -115
	},
	{#State 285
		ACTIONS => {
			"}" => 318,
			'LEFT_PAREN' => -197
		}
	},
	{#State 286
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 157,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			"}" => 319,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166
		}
	},
	{#State 287
		ACTIONS => {
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			"]" => 320,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP16_LOGICAL_OR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => 162
		}
	},
	{#State 288
		DEFAULT => -168
	},
	{#State 289
		DEFAULT => -169
	},
	{#State 290
		ACTIONS => {
			"my" => 75,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_QW' => 139,
			'LITERAL_STRING' => 106,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'KEYS_OR_VALUES' => 140,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			")" => -120,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113
		},
		GOTOS => {
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'Expression' => 130,
			'ListElement' => 143,
			'ArrayReference' => 121,
			'ListElements' => 322,
			'OPTIONAL-35' => 321,
			'Variable' => 132,
			'SubExpression' => 147,
			'Literal' => 114,
			'HashReference' => 79
		}
	},
	{#State 291
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 323
		}
	},
	{#State 292
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 75,
			'LITERAL_STRING' => 106,
			"\@{" => 113,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			"undef" => 116,
			'KEYS_OR_VALUES' => 140,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 147,
			'Variable' => 132,
			'ListElement' => 143,
			'Expression' => 130,
			'ArrayReference' => 121,
			'ListElements' => 324,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115
		}
	},
	{#State 293
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'Variable' => 132,
			'SubExpression' => 325,
			'Literal' => 114,
			'HashReference' => 79,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130
		}
	},
	{#State 294
		ACTIONS => {
			'LEFT_BRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 295
		ACTIONS => {
			'LEFT_PAREN' => 327
		}
	},
	{#State 296
		DEFAULT => -192
	},
	{#State 297
		DEFAULT => -194
	},
	{#State 298
		ACTIONS => {
			'WORD' => 198,
			"%{" => 97
		},
		GOTOS => {
			'HashEntry' => 328,
			'HashDereferenced' => 196
		}
	},
	{#State 299
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD' => 24,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			"\@{" => 113
		},
		GOTOS => {
			'SubExpression' => 329,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'Expression' => 130,
			'ArrayReference' => 121,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayDereferenced' => 115
		}
	},
	{#State 300
		DEFAULT => -185
	},
	{#State 301
		DEFAULT => -146,
		GOTOS => {
			'STAR-39' => 330
		}
	},
	{#State 302
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			"my" => 80,
			'OP01_CLOSE' => 103,
			"while (" => -138,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP01_PRINT_VOID' => 83,
			'WORD' => 111,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			"if (" => 117,
			'OP05_MATH_NEG' => 94,
			'OP19_LOOP_CONTROL' => 96,
			"foreach my" => -138,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'PLUS-42' => 331,
			'HashReference' => 79,
			'PAREN-36' => 101,
			'Operation' => 332,
			'Conditional' => 85,
			'VariableDeclaration' => 108,
			'Expression' => 110,
			'OPTIONAL-37' => 109,
			'Operator' => 104,
			'Statement' => 105,
			'LoopLabel' => 82,
			'SubExpression' => 90,
			'Literal' => 114,
			'OperatorVoid' => 87,
			'Variable' => 89,
			'VariableModification' => 98,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118
		}
	},
	{#State 303
		DEFAULT => -122
	},
	{#State 304
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 333
		}
	},
	{#State 305
		ACTIONS => {
			'OP20_HASH_FATARROW' => 334
		}
	},
	{#State 306
		DEFAULT => -190
	},
	{#State 307
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 335
		}
	},
	{#State 308
		ACTIONS => {
			"%{" => 97,
			'WORD' => 305
		},
		GOTOS => {
			'HashDereferenced' => 306,
			'HashEntryTyped' => 336
		}
	},
	{#State 309
		ACTIONS => {
			'LITERAL_NUMBER' => 337,
			"our" => 339
		},
		GOTOS => {
			'Subroutine' => 338,
			'Method' => 340,
			'MethodOrSubroutine' => 341
		}
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 344,
			")" => 343
		},
		GOTOS => {
			'PAREN-18' => 342
		}
	},
	{#State 311
		DEFAULT => -46
	},
	{#State 312
		DEFAULT => -201
	},
	{#State 313
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 23,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113
		},
		GOTOS => {
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 345,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Operator' => 104,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120
		}
	},
	{#State 314
		ACTIONS => {
			";" => 346
		}
	},
	{#State 315
		DEFAULT => -173
	},
	{#State 316
		DEFAULT => -176
	},
	{#State 317
		DEFAULT => -170
	},
	{#State 318
		DEFAULT => -165
	},
	{#State 319
		DEFAULT => -164
	},
	{#State 320
		DEFAULT => -163
	},
	{#State 321
		ACTIONS => {
			")" => 347
		}
	},
	{#State 322
		DEFAULT => -119
	},
	{#State 323
		DEFAULT => -107
	},
	{#State 324
		ACTIONS => {
			")" => 348
		}
	},
	{#State 325
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP14_BITWISE_OR_XOR' => 161,
			".." => 349,
			'OP16_LOGICAL_OR' => 157,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP17_LIST_RANGE' => 168,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169
		}
	},
	{#State 326
		DEFAULT => -156
	},
	{#State 327
		ACTIONS => {
			"\@{" => 113,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'OP05_MATH_NEG' => 94,
			"undef" => 116,
			'KEYS_OR_VALUES' => 140,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 23,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_CLOSE' => 103,
			"my" => 75,
			'OP01_QW' => 139,
			'OP05_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 106
		},
		GOTOS => {
			'SubExpression' => 147,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'TypeInner' => 146,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ListElement' => 143,
			'ListElements' => 350,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 328
		DEFAULT => -191
	},
	{#State 329
		ACTIONS => {
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP16_LOGICAL_OR' => 157,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP08_MATH_ADD_SUB' => 159,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -187,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			'OP21_LIST_COMMA' => -187,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168
		}
	},
	{#State 330
		ACTIONS => {
			'OP01_NAMED_VOID' => -149,
			'VARIABLE_SYMBOL' => -149,
			"elsif (" => 352,
			"%{" => -149,
			'OP05_MATH_NEG' => -149,
			'LITERAL_NUMBER' => -149,
			"for my integer" => -149,
			'WORD_SCOPED' => -149,
			'OP19_LOOP_CONTROL' => -149,
			'OP22_LOGICAL_NOT' => -149,
			'OP01_OPEN' => -149,
			'OP10_NAMED_UNARY' => -149,
			'OP01_PRINT_VOID' => -149,
			'OP03_MATH_INC_DEC' => -149,
			"my" => -149,
			'OP05_LOGICAL_NEG' => -149,
			"while (" => -149,
			"\@{" => -149,
			'' => -149,
			'WORD' => -149,
			'LEFT_BRACE' => -149,
			'LEFT_BRACKET' => -149,
			"}" => -149,
			"if (" => -149,
			"undef" => -149,
			"foreach my" => -149,
			'OP10_NAMED_UNARY_STRINGIFY' => -149,
			'OP01_NAMED' => -149,
			'LEFT_PAREN' => -149,
			"else" => 354,
			'OP01_CLOSE' => -149,
			'LITERAL_STRING' => -149
		},
		GOTOS => {
			'PAREN-40' => 355,
			'PAREN-38' => 351,
			'OPTIONAL-41' => 353
		}
	},
	{#State 331
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			"while (" => -138,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP01_PRINT_VOID' => 83,
			'WORD' => 111,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			"undef" => 116,
			"if (" => 117,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"}" => 356,
			'OP19_LOOP_CONTROL' => 96,
			"foreach my" => -138,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'Operation' => 357,
			'PAREN-36' => 101,
			'HashReference' => 79,
			'Statement' => 105,
			'LoopLabel' => 82,
			'Operator' => 104,
			'VariableDeclaration' => 108,
			'Expression' => 110,
			'OPTIONAL-37' => 109,
			'Conditional' => 85,
			'Variable' => 89,
			'OperatorVoid' => 87,
			'Literal' => 114,
			'SubExpression' => 90,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'ArrayReference' => 121,
			'HashDereferenced' => 120,
			'VariableModification' => 98
		}
	},
	{#State 332
		DEFAULT => -158
	},
	{#State 333
		ACTIONS => {
			")" => 358,
			'OP21_LIST_COMMA' => 359
		},
		GOTOS => {
			'PAREN-25' => 360
		}
	},
	{#State 334
		ACTIONS => {
			"my" => 75
		},
		GOTOS => {
			'TypeInner' => 361
		}
	},
	{#State 335
		DEFAULT => -66
	},
	{#State 336
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 362
		}
	},
	{#State 337
		ACTIONS => {
			";" => 363
		}
	},
	{#State 338
		DEFAULT => -81
	},
	{#State 339
		ACTIONS => {
			'TYPE_METHOD' => 364,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 340
		DEFAULT => -80
	},
	{#State 341
		DEFAULT => -59
	},
	{#State 342
		DEFAULT => -48
	},
	{#State 343
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 344
		ACTIONS => {
			"my" => 366
		}
	},
	{#State 345
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP23_LOGICAL_AND' => -86,
			'OP17_LIST_RANGE' => 168,
			";" => -86,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 169,
			'OP21_LIST_COMMA' => -86,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => -86,
			")" => -86,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -86,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			".." => -86,
			'OP16_LOGICAL_OR' => 157,
			"]" => -86,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 158,
			'OP08_MATH_ADD_SUB' => 159
		}
	},
	{#State 346
		DEFAULT => -167
	},
	{#State 347
		DEFAULT => -123
	},
	{#State 348
		DEFAULT => -84
	},
	{#State 349
		ACTIONS => {
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78
		},
		GOTOS => {
			'HashReference' => 79,
			'Literal' => 114,
			'SubExpression' => 367,
			'Variable' => 132,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 350
		ACTIONS => {
			")" => 368
		}
	},
	{#State 351
		DEFAULT => -145
	},
	{#State 352
		ACTIONS => {
			"\@{" => 113,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 119,
			"%{" => 97,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG' => 94,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			'OP01_OPEN' => 78,
			'OP01_NAMED' => 102,
			'OP22_LOGICAL_NOT' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 106,
			'OP01_CLOSE' => 103,
			'OP05_LOGICAL_NEG' => 81
		},
		GOTOS => {
			'Operator' => 104,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115,
			'ArrayReference' => 121,
			'Expression' => 130,
			'HashDereferenced' => 120,
			'Variable' => 132,
			'Literal' => 114,
			'HashReference' => 79,
			'SubExpression' => 369
		}
	},
	{#State 353
		DEFAULT => -150
	},
	{#State 354
		ACTIONS => {
			'LEFT_BRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 370
		}
	},
	{#State 355
		DEFAULT => -148
	},
	{#State 356
		DEFAULT => -159
	},
	{#State 357
		DEFAULT => -157
	},
	{#State 358
		ACTIONS => {
			";" => 371
		}
	},
	{#State 359
		ACTIONS => {
			"%{" => 97,
			'WORD' => 305
		},
		GOTOS => {
			'HashDereferenced' => 306,
			'HashEntryTyped' => 372
		}
	},
	{#State 360
		DEFAULT => -63
	},
	{#State 361
		ACTIONS => {
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			"\@{" => 113,
			"undef" => 116,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			'WORD_SCOPED' => 23,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107
		},
		GOTOS => {
			'SubExpression' => 373,
			'Literal' => 114,
			'HashReference' => 79,
			'Variable' => 132,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'Expression' => 130,
			'ArrayDereferenced' => 115,
			'Operator' => 104,
			'WordScoped' => 118
		}
	},
	{#State 362
		ACTIONS => {
			")" => 374,
			'OP21_LIST_COMMA' => 375
		},
		GOTOS => {
			'PAREN-27' => 376
		}
	},
	{#State 363
		DEFAULT => -61
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 377
		}
	},
	{#State 365
		ACTIONS => {
			"\@_;" => 378
		}
	},
	{#State 366
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 379
		}
	},
	{#State 367
		ACTIONS => {
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP18_TERNARY' => 156,
			'OP13_BITWISE_AND' => 164,
			'OP16_LOGICAL_OR' => 157,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 159,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => 380,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 368
		ACTIONS => {
			'LEFT_BRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 369
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => 382,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 157,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP15_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170
		}
	},
	{#State 370
		DEFAULT => -147
	},
	{#State 371
		DEFAULT => -65
	},
	{#State 372
		DEFAULT => -62
	},
	{#State 373
		ACTIONS => {
			'OP04_MATH_POW' => 169,
			'OP11_COMPARE_LT_GT' => 170,
			'OP21_LIST_COMMA' => -189,
			'OP23_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 168,
			'OP09_BITWISE_SHIFT' => 166,
			'OP15_LOGICAL_AND' => 167,
			'OP08_MATH_ADD_SUB' => 159,
			'OP08_STRING_CAT' => 158,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 157,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 156,
			")" => -189,
			'OP12_COMPARE_EQ_NEQ' => 155,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP14_BITWISE_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 374
		ACTIONS => {
			";" => 383
		}
	},
	{#State 375
		ACTIONS => {
			"%{" => 97,
			'WORD' => 305
		},
		GOTOS => {
			'HashEntryTyped' => 384,
			'HashDereferenced' => 306
		}
	},
	{#State 376
		DEFAULT => -68
	},
	{#State 377
		ACTIONS => {
			"= sub {" => 385
		}
	},
	{#State 378
		DEFAULT => -50
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 380
		ACTIONS => {
			'LEFT_BRACE' => 302
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
			'LEFT_BRACE' => 302
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
			'OP01_NAMED' => -72,
			'OP01_OPEN' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP10_NAMED_UNARY' => -72,
			'LEFT_PAREN' => -72,
			'LITERAL_STRING' => -72,
			"while (" => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP01_CLOSE' => -72,
			"my" => -72,
			'OP01_NAMED_VOID' => -72,
			"\@{" => -72,
			'LEFT_BRACE' => -72,
			'VARIABLE_SYMBOL' => -72,
			'WORD' => -72,
			"%{" => -72,
			'LEFT_BRACKET' => -72,
			'OP19_LOOP_CONTROL' => -72,
			"foreach my" => -72,
			"for my integer" => -72,
			'WORD_SCOPED' => -72,
			"( my" => 389,
			'LITERAL_NUMBER' => -72,
			"undef" => -72,
			"if (" => -72,
			'OP05_MATH_NEG' => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 390,
			'MethodArguments' => 391
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
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 392
		}
	},
	{#State 390
		ACTIONS => {
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_PRINT_VOID' => 83,
			'LEFT_PAREN' => 107,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 106,
			"while (" => -138,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			'LEFT_BRACE' => 112,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 111,
			"%{" => 97,
			'LEFT_BRACKET' => 119,
			'OP19_LOOP_CONTROL' => 96,
			"foreach my" => -138,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			'LITERAL_NUMBER' => 95,
			"undef" => 116,
			"if (" => 117,
			'OP05_MATH_NEG' => 94
		},
		GOTOS => {
			'ArrayReference' => 121,
			'VariableModification' => 98,
			'HashDereferenced' => 120,
			'ArrayDereferenced' => 115,
			'WordScoped' => 118,
			'Literal' => 114,
			'SubExpression' => 90,
			'Variable' => 89,
			'OperatorVoid' => 87,
			'VariableDeclaration' => 108,
			'OPTIONAL-37' => 109,
			'Expression' => 110,
			'Conditional' => 85,
			'Statement' => 105,
			'LoopLabel' => 82,
			'Operator' => 104,
			'PAREN-36' => 101,
			'HashReference' => 79,
			'PLUS-30' => 394,
			'Operation' => 393
		}
	},
	{#State 391
		DEFAULT => -71
	},
	{#State 392
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 395
		}
	},
	{#State 393
		DEFAULT => -74
	},
	{#State 394
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 100,
			'OP22_LOGICAL_NOT' => 77,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 78,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_CLOSE' => 103,
			"my" => 80,
			"while (" => -138,
			'LITERAL_STRING' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'OP10_NAMED_UNARY' => 84,
			'LEFT_PAREN' => 107,
			'OP01_PRINT_VOID' => 83,
			'WORD' => 111,
			'VARIABLE_SYMBOL' => 88,
			'LEFT_BRACE' => 112,
			'OP01_NAMED_VOID' => 91,
			"\@{" => 113,
			"undef" => 116,
			"if (" => 117,
			'LITERAL_NUMBER' => 95,
			'OP05_MATH_NEG' => 94,
			"}" => 397,
			"foreach my" => -138,
			'OP19_LOOP_CONTROL' => 96,
			'WORD_SCOPED' => 23,
			"for my integer" => -138,
			"%{" => 97,
			'LEFT_BRACKET' => 119
		},
		GOTOS => {
			'PAREN-36' => 101,
			'HashReference' => 79,
			'Operation' => 396,
			'Conditional' => 85,
			'OPTIONAL-37' => 109,
			'Expression' => 110,
			'VariableDeclaration' => 108,
			'Operator' => 104,
			'LoopLabel' => 82,
			'Statement' => 105,
			'SubExpression' => 90,
			'Literal' => 114,
			'OperatorVoid' => 87,
			'Variable' => 89,
			'VariableModification' => 98,
			'HashDereferenced' => 120,
			'ArrayReference' => 121,
			'WordScoped' => 118,
			'ArrayDereferenced' => 115
		}
	},
	{#State 395
		ACTIONS => {
			'OP21_LIST_COMMA' => 400,
			")" => 398
		},
		GOTOS => {
			'PAREN-31' => 399
		}
	},
	{#State 396
		DEFAULT => -73
	},
	{#State 397
		ACTIONS => {
			";" => 401
		}
	},
	{#State 398
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 399
		DEFAULT => -77
	},
	{#State 400
		ACTIONS => {
			"my" => 403
		}
	},
	{#State 401
		DEFAULT => -75
	},
	{#State 402
		ACTIONS => {
			"\@_;" => 404
		}
	},
	{#State 403
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 405
		}
	},
	{#State 404
		DEFAULT => -79
	},
	{#State 405
		ACTIONS => {
			'VARIABLE_SYMBOL' => 406
		}
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
