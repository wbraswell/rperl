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
    our $VERSION = 0.000_911;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \$class_properties\ \=\ \{|our\ \$properties\ \=\ \{|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\$TYPED_|package|\=\ sub\ \{|elsif\ \(|while\ \(|undef|\(\ my|else|if\ \(|qw\(|use|our|\@_\;|\@\{|\%\{|my|\;|\]|\)|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(or|xor)/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NEG', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next|last)/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NE', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(chdir|rand|scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
      /\G((?:main)?::[a-zA-Z]\w*__stringify\()/gc and return ('OP10_STRINGIFY_UNARY', $1);
      /\G(\+=|-=|\*=|\/=|\.=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x\s)/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print)/gc and return ('OP01_PRINT', $1);
      /\G(croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_QW', $1);
      /\G(open)/gc and return ('OP01_OPEN', $1);
      /\G(close)/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|ETC)/gc and return ('OP01_NAMED', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G(([a-zA-Z]\w*(::[a-zA-Z]\w*)+)|(::[a-zA-Z]\w*(::[a-zA-Z]\w*)*))/gc and return ('WORD_SCOPED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);
      /\G:/gc and return ('COLON', $1);
      /\G\(/gc and return ('LPAREN', $1);
      /\G\[/gc and return ('LBRACKET', $1);
      /\G\{/gc and return ('LBRACE', $1);


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


#line 125 lib/RPerl/Grammar.pm

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
  [ 'Properties_65' => 'Properties', [ 'our $properties = {', 'Critic', 'HashEntryTyped', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our $properties = {', '}', ';', 'Critic' ], 0 ],
  [ '_PAREN' => 'PAREN-27', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'PAREN-27' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'PropertiesClass_70' => 'PropertiesClass', [ 'our $class_properties = {', 'Critic', 'HashEntryTyped', 'STAR-28', '}', ';' ], 0 ],
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
  [ 'Operator_84' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_OPEN', 'my', 'filehandle_ref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP10_STRINGIFY_UNARY', 'SubExpression', ')' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'LoopLabel' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_124' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_125' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'OPTIONAL-36', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LPAREN', 'OPTIONAL-38', ')' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_143' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_144' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'OPTIONAL-40', 'Loop' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [ 'STAR-42', 'PAREN-41' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [  ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'PAREN-43' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Conditional_159' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-42', 'OPTIONAL-44' ], 0 ],
  [ 'Loop_160' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_163' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_164' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_165' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'Operation' ], 0 ],
  [ 'CodeBlock_168' => 'CodeBlock', [ 'LBRACE', 'PLUS-45', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'Variable_171' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-46' ], 0 ],
  [ 'VariableRetrieval_172' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_173' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_175' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_176' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_177' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_178' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'PLUS-49', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'WORD' ], 0 ],
  [ 'ListElements_184' => 'ListElements', [ 'ListElement', 'STAR-48' ], 0 ],
  [ 'ListElements_185' => 'ListElements', [ 'OP01_QW', 'LPAREN', 'PLUS-49', ')' ], 0 ],
  [ 'ListElement_186' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'ArrayReference_191' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-50', ']' ], 0 ],
  [ 'ArrayDereferenced_192' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_193' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashEntry_196' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-51', 'SubExpression' ], 0 ],
  [ 'HashEntry_197' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_198' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_199' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-52', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'PAREN-52' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'HashReference_203' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-53', '}' ], 0 ],
  [ 'HashDereferenced_204' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_205' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_208' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_209' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_210' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_211' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_212' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_213' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_214' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'Operator_111' => 111,
  'Operator_112' => 112,
  'Operator_113' => 113,
  '_PAREN' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  'OperatorVoid_124' => 124,
  'OperatorVoid_125' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpressionOrStdin_143' => 143,
  'SubExpressionOrStdin_144' => 144,
  '_PAREN' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  'Statement_148' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  '_PAREN' => 153,
  '_STAR_LIST' => 154,
  '_STAR_LIST' => 155,
  '_PAREN' => 156,
  '_OPTIONAL' => 157,
  '_OPTIONAL' => 158,
  'Conditional_159' => 159,
  'Loop_160' => 160,
  'Loop_161' => 161,
  'Loop_162' => 162,
  'LoopFor_163' => 163,
  'LoopForEach_164' => 164,
  'LoopWhile_165' => 165,
  '_PLUS_LIST' => 166,
  '_PLUS_LIST' => 167,
  'CodeBlock_168' => 168,
  '_STAR_LIST' => 169,
  '_STAR_LIST' => 170,
  'Variable_171' => 171,
  'VariableRetrieval_172' => 172,
  'VariableRetrieval_173' => 173,
  'VariableRetrieval_174' => 174,
  'VariableDeclaration_175' => 175,
  'VariableDeclaration_176' => 176,
  'VariableModification_177' => 177,
  'VariableModification_178' => 178,
  '_PAREN' => 179,
  '_STAR_LIST' => 180,
  '_STAR_LIST' => 181,
  '_PLUS_LIST' => 182,
  '_PLUS_LIST' => 183,
  'ListElements_184' => 184,
  'ListElements_185' => 185,
  'ListElement_186' => 186,
  'ListElement_187' => 187,
  'ListElement_188' => 188,
  '_OPTIONAL' => 189,
  '_OPTIONAL' => 190,
  'ArrayReference_191' => 191,
  'ArrayDereferenced_192' => 192,
  'ArrayDereferenced_193' => 193,
  '_OPTIONAL' => 194,
  '_OPTIONAL' => 195,
  'HashEntry_196' => 196,
  'HashEntry_197' => 197,
  'HashEntryTyped_198' => 198,
  'HashEntryTyped_199' => 199,
  '_PAREN' => 200,
  '_STAR_LIST' => 201,
  '_STAR_LIST' => 202,
  'HashReference_203' => 203,
  'HashDereferenced_204' => 204,
  'HashDereferenced_205' => 205,
  'WordScoped_206' => 206,
  'WordScoped_207' => 207,
  'LoopLabel_208' => 208,
  'Type_209' => 209,
  'TypeInner_210' => 210,
  'VariableOrLiteral_211' => 211,
  'VariableOrLiteral_212' => 212,
  'Literal_213' => 213,
  'Literal_214' => 214,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
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
	'our $class_properties = {' => { ISSEMANTIC => 0 },
	'our $properties = {' => { ISSEMANTIC => 0 },
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
	FH_REF_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_OPEN => { ISSEMANTIC => 1 },
	OP01_PRINT => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
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
	OP10_STRINGIFY_UNARY => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NE => { ISSEMANTIC => 1 },
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
	OP22_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 7,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'Program' => 2,
			'ModuleHeader' => 3,
			'PLUS-2' => 6,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 5,
			'Critic' => 9,
			'CompileUnit' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"use parent qw(" => 12,
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'STAR-10' => 14,
			'Class' => 15,
			'Module' => 13,
			'Package' => 11
		}
	},
	{#State 4
		ACTIONS => {
			'' => 16
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 9,
			'OPTIONAL-9' => 1,
			'ModuleHeader' => 3,
			'PAREN-1' => 17
		}
	},
	{#State 7
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 18,
			'OPTIONAL-3' => 19
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 21
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 11
		DEFAULT => -22
	},
	{#State 12
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 8,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 26
		}
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => -6
	},
	{#State 19
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 29
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			'WORD' => 30,
			")" => 31
		}
	},
	{#State 22
		DEFAULT => -207
	},
	{#State 23
		ACTIONS => {
			";" => 32
		}
	},
	{#State 24
		DEFAULT => -206
	},
	{#State 25
		ACTIONS => {
			")" => 33
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use" => 35,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 36,
			'Include' => 34
		}
	},
	{#State 28
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 29
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 38
		}
	},
	{#State 30
		DEFAULT => -34
	},
	{#State 31
		DEFAULT => -36
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			";" => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 43,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 42,
			'Constant' => 46,
			'PLUS-13' => 45
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			"while (" => -11,
			"for my integer" => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_NAMED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LITERAL_NUMBER' => -11,
			"my" => -11,
			"## no critic qw(" => 8,
			"use constant" => -11,
			'OP01_OPEN' => -11,
			'LBRACE' => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'WORD_SCOPED' => -11,
			'WORD' => -11,
			"%{" => -11,
			'LITERAL_STRING' => -11,
			"foreach my" => -11,
			"our" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"if (" => -11,
			'VARIABLE_SYMBOL' => -11,
			"\@{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_PRINT' => -11,
			'OP01_CLOSE' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LPAREN' => -11,
			"use" => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 48
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			";" => 51,
			"qw(" => 52
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 45
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 48
		ACTIONS => {
			'LITERAL_NUMBER' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"undef" => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACKET' => -13,
			"while (" => -13,
			"for my integer" => -13,
			'WORD_SCOPED' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			'LBRACE' => -13,
			"use constant" => -13,
			'OP01_OPEN' => -13,
			"my" => -13,
			'VARIABLE_SYMBOL' => -13,
			"our" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"if (" => -13,
			"foreach my" => -13,
			'LITERAL_STRING' => -13,
			'WORD' => -13,
			"%{" => -13,
			"use" => 35,
			'LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_PRINT' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"\@{" => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 60
		}
	},
	{#State 49
		DEFAULT => -8
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 61
		}
	},
	{#State 51
		DEFAULT => -39
	},
	{#State 52
		ACTIONS => {
			'WORD' => 62
		},
		GOTOS => {
			'PLUS-15' => 63
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 54
		DEFAULT => -209
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 56
		ACTIONS => {
			";" => 66
		}
	},
	{#State 57
		DEFAULT => -30
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
			'LBRACE' => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_CLOSE' => -15,
			'WORD_SCOPED' => -15,
			'LPAREN' => -15,
			"my" => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"use constant" => 43,
			"\@{" => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			"if (" => -15,
			"our" => -15,
			"undef" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"for my integer" => -15,
			"while (" => -15,
			"%{" => -15,
			'LBRACKET' => -15,
			'WORD' => -15,
			"foreach my" => -15,
			'LITERAL_STRING' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 68
		}
	},
	{#State 61
		ACTIONS => {
			"our \$properties = {" => -54,
			"use" => -54,
			"## no critic qw(" => 8,
			"use constant" => -54
		},
		GOTOS => {
			'STAR-21' => 70,
			'Critic' => 71
		}
	},
	{#State 62
		DEFAULT => -38
	},
	{#State 63
		ACTIONS => {
			")" => 73,
			'WORD' => 72
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 74
		},
		GOTOS => {
			'TypeInner' => 75
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 76
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP19_LOOP_CONTROL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 90,
			'VARIABLE_SYMBOL' => 110,
			"our" => 44,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			"if (" => 113,
			'OP01_NAMED_VOID' => 95,
			"foreach my" => -147,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 116,
			"%{" => 118,
			"while (" => -147,
			"for my integer" => -147,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'OP01_PRINT' => 105,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			"my" => 83
		},
		GOTOS => {
			'VariableModification' => 108,
			'PAREN-39' => 81,
			'ArrayDereferenced' => 84,
			'SubExpression' => 102,
			'Operation' => 77,
			'Expression' => 101,
			'OperatorVoid' => 78,
			'Literal' => 96,
			'HashReference' => 97,
			'Subroutine' => 117,
			'Conditional' => 99,
			'OPTIONAL-40' => 119,
			'PLUS-8' => 121,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'LoopLabel' => 91,
			'Statement' => 89,
			'Operator' => 109,
			'VariableDeclaration' => 94,
			'Variable' => 114,
			'WordScoped' => 111
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"our \$properties = {" => -56,
			"use constant" => -56,
			"use" => 35
		},
		GOTOS => {
			'Include' => 122,
			'STAR-22' => 123
		}
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			";" => 124
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 125
		}
	},
	{#State 75
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'Literal' => 126
		}
	},
	{#State 76
		ACTIONS => {
			"my" => -43,
			'OP01_OPEN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"\@{" => -43,
			'OP01_PRINT' => -43,
			'LBRACE' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'OP01_CLOSE' => -43,
			'OP10_NAMED_UNARY' => -43,
			"( my" => 129,
			'WORD_SCOPED' => -43,
			'LPAREN' => -43,
			"for my integer" => -43,
			"while (" => -43,
			"%{" => -43,
			'WORD' => -43,
			'LBRACKET' => -43,
			"foreach my" => -43,
			'LITERAL_STRING' => -43,
			"if (" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"undef" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED' => -43,
			'LITERAL_NUMBER' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP03_MATH_INC_DEC' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 128,
			'OPTIONAL-16' => 127
		}
	},
	{#State 77
		DEFAULT => -17
	},
	{#State 78
		DEFAULT => -150
	},
	{#State 79
		ACTIONS => {
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 115,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 131,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 80
		ACTIONS => {
			"}" => 134,
			"%{" => 118,
			'WORD' => 135
		},
		GOTOS => {
			'HashDereferenced' => 137,
			'HashEntry' => 136
		}
	},
	{#State 81
		DEFAULT => -146
	},
	{#State 82
		ACTIONS => {
			"my" => 138
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 139
		}
	},
	{#State 84
		DEFAULT => -138
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 110
		},
		GOTOS => {
			'Variable' => 140
		}
	},
	{#State 86
		DEFAULT => -214
	},
	{#State 87
		ACTIONS => {
			";" => -120,
			'WORD' => 142
		},
		GOTOS => {
			'OPTIONAL-36' => 141,
			'LoopLabel' => 143
		}
	},
	{#State 88
		DEFAULT => -140
	},
	{#State 89
		DEFAULT => -83
	},
	{#State 90
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			"my" => 74,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96,
			'WordScoped' => 111,
			'Variable' => 132,
			'ListElement' => 146,
			'Operator' => 109,
			'Expression' => 130,
			'TypeInner' => 147,
			'SubExpression' => 144,
			'HashDereferenced' => 88
		}
	},
	{#State 91
		ACTIONS => {
			'COLON' => 148
		}
	},
	{#State 92
		DEFAULT => -134
	},
	{#State 93
		ACTIONS => {
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118
		},
		GOTOS => {
			'Expression' => 130,
			'SubExpression' => 149,
			'HashDereferenced' => 88,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84
		}
	},
	{#State 94
		DEFAULT => -151
	},
	{#State 95
		ACTIONS => {
			"my" => 74,
			";" => -118,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_QW' => 152,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'KEYS_OR_VALUES' => 145
		},
		GOTOS => {
			'WordScoped' => 111,
			'Variable' => 132,
			'OPTIONAL-35' => 154,
			'ListElement' => 153,
			'Operator' => 109,
			'TypeInner' => 147,
			'Expression' => 130,
			'SubExpression' => 151,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'ListElements' => 150,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 96
		DEFAULT => -135
	},
	{#State 97
		DEFAULT => -139
	},
	{#State 98
		ACTIONS => {
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			"my" => 74,
			'LPAREN' => 100,
			'OP01_QW' => 152,
			"]" => -190,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'OPTIONAL-50' => 155,
			'ArrayDereferenced' => 84,
			'ListElements' => 156,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'TypeInner' => 147,
			'Expression' => 130,
			'Operator' => 109,
			'ListElement' => 153,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 99
		DEFAULT => -148
	},
	{#State 100
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_PRINT' => 159,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 157,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98
		},
		GOTOS => {
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 158,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 101
		ACTIONS => {
			'OP18_TERNARY' => -133,
			'OP04_MATH_POW' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP08_STRING_CAT' => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP07_STRING_REPEAT' => -133,
			";" => 160,
			'OP08_MATH_ADD_SUB' => -133
		}
	},
	{#State 102
		ACTIONS => {
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 169,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 103
		ACTIONS => {
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP04_MATH_POW' => -101,
			'OP06_REGEX_MATCH' => -101,
			'LBRACKET' => 98,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'OP08_STRING_CAT' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			"]" => -101,
			'WORD_SCOPED' => 22,
			'OP16_LOGICAL_OR' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP01_OPEN' => 82,
			'VARIABLE_SYMBOL' => 110,
			'OP18_TERNARY' => -101,
			'OP05_MATH_NEG_LPAREN' => 112,
			"}" => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'LITERAL_STRING' => 115,
			'WORD' => 24,
			"%{" => 118,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LPAREN' => 100,
			'OP21_LIST_COMMA' => -101,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP07_STRING_REPEAT' => -101,
			";" => -101,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'Literal' => 96,
			'HashReference' => 97,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'SubExpression' => 178,
			'Expression' => 130,
			'HashDereferenced' => 88
		}
	},
	{#State 104
		ACTIONS => {
			'FH_REF_SYMBOL' => 179
		}
	},
	{#State 105
		ACTIONS => {
			"my" => -116,
			'OP05_LOGICAL_NEG' => -116,
			"\@{" => -116,
			'OP01_OPEN' => -116,
			'OP01_CLOSE' => -116,
			'OP10_STRINGIFY_UNARY' => -116,
			'OP10_NAMED_UNARY' => -116,
			'LBRACE' => -116,
			'OP01_QW' => -116,
			'LPAREN' => -116,
			'WORD_SCOPED' => -116,
			'FH_REF_SYMBOL_BRACES' => 181,
			'STDOUT_STDERR' => 183,
			'LITERAL_STRING' => -116,
			'WORD' => -116,
			'LBRACKET' => -116,
			"%{" => -116,
			'OP01_NAMED' => -116,
			'VARIABLE_SYMBOL' => -116,
			"undef" => -116,
			'OP22_LOGICAL_NEG' => -116,
			'OP05_MATH_NEG_LPAREN' => -116,
			'OP03_MATH_INC_DEC' => -116,
			'LITERAL_NUMBER' => -116,
			'KEYS_OR_VALUES' => -116
		},
		GOTOS => {
			'OPTIONAL-34' => 180,
			'PAREN-33' => 182
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80
		},
		GOTOS => {
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'SubExpression' => 184,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 107
		ACTIONS => {
			'VARIABLE_SYMBOL' => 110,
			'LBRACKET' => 98
		},
		GOTOS => {
			'ArrayReference' => 186,
			'Variable' => 185
		}
	},
	{#State 108
		DEFAULT => -152
	},
	{#State 109
		DEFAULT => -130
	},
	{#State 110
		DEFAULT => -170,
		GOTOS => {
			'STAR-46' => 187
		}
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => 188
		}
	},
	{#State 112
		ACTIONS => {
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 115,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'SubExpression' => 189,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109
		}
	},
	{#State 113
		ACTIONS => {
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 190,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 114
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 194,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP19_VARIABLE_ASSIGN_BY' => 193,
			'OP18_TERNARY' => -136,
			'OP03_MATH_INC_DEC' => 192,
			'OP04_MATH_POW' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP19_VARIABLE_ASSIGN' => 191,
			'OP13_BITWISE_AND' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP08_STRING_CAT' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP16_LOGICAL_OR' => -136
		}
	},
	{#State 115
		DEFAULT => -213
	},
	{#State 116
		ACTIONS => {
			'COLON' => -208,
			'LPAREN' => -206
		}
	},
	{#State 117
		DEFAULT => -14
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 110,
			'LBRACE' => 195
		},
		GOTOS => {
			'HashReference' => 196,
			'Variable' => 197
		}
	},
	{#State 119
		ACTIONS => {
			"foreach my" => 204,
			"for my integer" => 201,
			"while (" => 200
		},
		GOTOS => {
			'Loop' => 198,
			'LoopWhile' => 203,
			'LoopForEach' => 199,
			'LoopFor' => 202
		}
	},
	{#State 120
		DEFAULT => -137
	},
	{#State 121
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 87,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'' => -18,
			'OP01_NAMED' => 90,
			'OP01_NAMED_VOID' => 95,
			"if (" => 113,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			"foreach my" => -147,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 116,
			"for my integer" => -147,
			"while (" => -147,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'OP01_PRINT' => 105,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			"my" => 83
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'Conditional' => 99,
			'OPTIONAL-40' => 119,
			'HashDereferenced' => 88,
			'VariableDeclaration' => 94,
			'Variable' => 114,
			'WordScoped' => 111,
			'LoopLabel' => 91,
			'Statement' => 89,
			'Operator' => 109,
			'VariableModification' => 108,
			'PAREN-39' => 81,
			'ArrayDereferenced' => 84,
			'SubExpression' => 102,
			'Operation' => 205,
			'Expression' => 101,
			'OperatorVoid' => 78
		}
	},
	{#State 122
		DEFAULT => -53
	},
	{#State 123
		ACTIONS => {
			"use constant" => 43,
			"our \$properties = {" => 208
		},
		GOTOS => {
			'Properties' => 207,
			'Constant' => 206
		}
	},
	{#State 124
		DEFAULT => -40
	},
	{#State 125
		ACTIONS => {
			"\$TYPED_" => 209
		}
	},
	{#State 126
		ACTIONS => {
			";" => 210
		}
	},
	{#State 127
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP19_LOOP_CONTROL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 90,
			"if (" => 113,
			'OP01_NAMED_VOID' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			"foreach my" => -147,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 116,
			"for my integer" => -147,
			"while (" => -147,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'OP01_PRINT' => 105,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			"my" => 83
		},
		GOTOS => {
			'OperatorVoid' => 78,
			'Expression' => 101,
			'Operation' => 211,
			'SubExpression' => 102,
			'ArrayDereferenced' => 84,
			'PAREN-39' => 81,
			'VariableModification' => 108,
			'PLUS-17' => 212,
			'WordScoped' => 111,
			'VariableDeclaration' => 94,
			'Variable' => 114,
			'Operator' => 109,
			'Statement' => 89,
			'LoopLabel' => 91,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 128
		DEFAULT => -42
	},
	{#State 129
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 130
		DEFAULT => -133
	},
	{#State 131
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 175,
			")" => 214,
			'OP16_LOGICAL_OR' => 166,
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP08_STRING_CAT' => 164,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 169
		}
	},
	{#State 132
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -136,
			'OP07_STRING_REPEAT' => -136,
			";" => -136,
			'OP13_BITWISE_AND' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			")" => -136,
			'OP16_LOGICAL_OR' => -136,
			"]" => -136,
			'OP17_LIST_RANGE' => -136,
			'OP21_LIST_COMMA' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP08_STRING_CAT' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP02_METHOD_THINARROW' => 194,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP04_MATH_POW' => -136,
			'OP03_MATH_INC_DEC' => 192,
			"}" => -136,
			'OP18_TERNARY' => -136
		}
	},
	{#State 133
		ACTIONS => {
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 215,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120
		}
	},
	{#State 134
		DEFAULT => -141
	},
	{#State 135
		ACTIONS => {
			'OP20_HASH_FATARROW' => 216
		}
	},
	{#State 136
		DEFAULT => -202,
		GOTOS => {
			'STAR-53' => 217
		}
	},
	{#State 137
		DEFAULT => -197
	},
	{#State 138
		ACTIONS => {
			"filehandle_ref" => 218
		}
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 219
		}
	},
	{#State 140
		DEFAULT => -89
	},
	{#State 141
		ACTIONS => {
			";" => 220
		}
	},
	{#State 142
		DEFAULT => -208
	},
	{#State 143
		DEFAULT => -119
	},
	{#State 144
		ACTIONS => {
			'OP18_TERNARY' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP04_MATH_POW' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_STRING_CAT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP21_LIST_COMMA' => -186,
			'OP13_BITWISE_AND' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			";" => -85,
			'OP07_STRING_REPEAT' => -85
		}
	},
	{#State 145
		ACTIONS => {
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 221
		}
	},
	{#State 146
		ACTIONS => {
			'OP21_LIST_COMMA' => 222
		}
	},
	{#State 147
		ACTIONS => {
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 115,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 223,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120
		}
	},
	{#State 148
		DEFAULT => -145
	},
	{#State 149
		ACTIONS => {
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 161,
			"}" => -111,
			'OP18_TERNARY' => 169,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			"]" => -111,
			'OP17_LIST_RANGE' => 174,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => 165,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			";" => -111,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			")" => -111,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => -111
		}
	},
	{#State 150
		DEFAULT => -117
	},
	{#State 151
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -186,
			"]" => -186,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			";" => -186,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -186,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 224
		}
	},
	{#State 153
		DEFAULT => -181,
		GOTOS => {
			'STAR-48' => 225
		}
	},
	{#State 154
		ACTIONS => {
			";" => 226
		}
	},
	{#State 155
		ACTIONS => {
			"]" => 227
		}
	},
	{#State 156
		DEFAULT => -189
	},
	{#State 157
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'KEYS_OR_VALUES' => 145,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			"my" => 74
		},
		GOTOS => {
			'SubExpression' => 144,
			'Expression' => 130,
			'TypeInner' => 147,
			'HashDereferenced' => 88,
			'ListElement' => 228,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84
		}
	},
	{#State 158
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 175,
			")" => 229,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP16_LOGICAL_OR' => 166,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP04_MATH_POW' => 161
		}
	},
	{#State 159
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 230
		}
	},
	{#State 160
		DEFAULT => -82
	},
	{#State 161
		ACTIONS => {
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80
		},
		GOTOS => {
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'SubExpression' => 231,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 115,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 232,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 163
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 233
		}
	},
	{#State 164
		ACTIONS => {
			'LBRACE' => 80,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'Literal' => 96,
			'HashReference' => 97,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 234,
			'HashDereferenced' => 88
		}
	},
	{#State 165
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 235,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 115,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133
		},
		GOTOS => {
			'SubExpression' => 236,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84
		}
	},
	{#State 167
		ACTIONS => {
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'Expression' => 130,
			'SubExpression' => 237,
			'HashDereferenced' => 88,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 238,
			'HashDereferenced' => 88
		}
	},
	{#State 169
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 115,
			'VARIABLE_SYMBOL' => 110
		},
		GOTOS => {
			'Literal' => 239,
			'VariableOrLiteral' => 240,
			'Variable' => 241
		}
	},
	{#State 170
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109,
			'SubExpression' => 242,
			'Expression' => 130,
			'HashDereferenced' => 88
		}
	},
	{#State 171
		ACTIONS => {
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashReference' => 97,
			'Literal' => 96,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 243
		}
	},
	{#State 172
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107
		},
		GOTOS => {
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 244,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 173
		ACTIONS => {
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 245,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132
		}
	},
	{#State 174
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 246
		}
	},
	{#State 175
		ACTIONS => {
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 247,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_STRING' => 115,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'SubExpression' => 248,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'WordScoped' => 111,
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120
		}
	},
	{#State 177
		ACTIONS => {
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'SubExpression' => 249,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109
		}
	},
	{#State 178
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP21_LIST_COMMA' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP16_LOGICAL_OR' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			";" => -100,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -100
		}
	},
	{#State 179
		DEFAULT => -88
	},
	{#State 180
		ACTIONS => {
			'OP01_QW' => 152,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			"my" => 74,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ListElements' => 250,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'TypeInner' => 147,
			'Expression' => 130,
			'Operator' => 109,
			'ListElement' => 153,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 181
		ACTIONS => {
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_STRING' => 115,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			"my" => 74,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 152,
			'LPAREN' => 100
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ListElements' => 251,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'SubExpression' => 151,
			'Expression' => 130,
			'TypeInner' => 147,
			'HashDereferenced' => 88,
			'Variable' => 132,
			'ListElement' => 153,
			'WordScoped' => 111,
			'Operator' => 109
		}
	},
	{#State 182
		DEFAULT => -115
	},
	{#State 183
		DEFAULT => -114
	},
	{#State 184
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			"}" => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			"]" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP08_STRING_CAT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP07_STRING_REPEAT' => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			")" => -92,
			'OP12_COMPARE_EQ_NE' => -92
		}
	},
	{#State 185
		ACTIONS => {
			"}" => 252
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 253
		}
	},
	{#State 187
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -171,
			'OP04_MATH_POW' => -171,
			'OP02_HASH_THINARROW' => 255,
			'OP07_MATH_MULT_DIV_MOD' => -171,
			'OP15_LOGICAL_AND' => -171,
			'OP09_BITWISE_SHIFT' => -171,
			'OP18_TERNARY' => -171,
			"}" => -171,
			'OP24_LOGICAL_OR_XOR' => -171,
			'OP14_BITWISE_OR_XOR' => -171,
			'OP06_REGEX_MATCH' => -171,
			'OP19_VARIABLE_ASSIGN_BY' => -171,
			'OP02_METHOD_THINARROW' => -171,
			'OP11_COMPARE_LT_GT' => -171,
			'OP21_LIST_COMMA' => -171,
			'COLON' => -171,
			"]" => -171,
			'OP17_LIST_RANGE' => -171,
			'OP16_LOGICAL_OR' => -171,
			'OP08_STRING_CAT' => -171,
			";" => -171,
			'OP07_STRING_REPEAT' => -171,
			'OP02_ARRAY_THINARROW' => 256,
			'OP08_MATH_ADD_SUB' => -171,
			")" => -171,
			'OP12_COMPARE_EQ_NE' => -171,
			'OP23_LOGICAL_AND' => -171,
			'OP19_VARIABLE_ASSIGN' => -171,
			'OP13_BITWISE_AND' => -171
		},
		GOTOS => {
			'VariableRetrieval' => 254
		}
	},
	{#State 188
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_QW' => 152,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			")" => -127,
			"my" => 74,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'OPTIONAL-37' => 257,
			'ArrayDereferenced' => 84,
			'ListElements' => 258,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'TypeInner' => 147,
			'Expression' => 130,
			'Operator' => 109,
			'ListElement' => 153,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 189
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			")" => 259,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP18_TERNARY' => 169,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 190
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP18_TERNARY' => 169,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => 260,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP08_STRING_CAT' => 164,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166
		}
	},
	{#State 191
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'LITERAL_STRING' => 115,
			'STDIN' => 263,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 262,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'SubExpressionOrStdin' => 261,
			'WordScoped' => 111
		}
	},
	{#State 192
		DEFAULT => -90
	},
	{#State 193
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_STRING' => 115,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 264,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120
		}
	},
	{#State 194
		ACTIONS => {
			'WORD' => 265
		}
	},
	{#State 195
		ACTIONS => {
			"%{" => 118,
			'WORD' => 135
		},
		GOTOS => {
			'HashDereferenced' => 137,
			'HashEntry' => 136
		}
	},
	{#State 196
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 197
		ACTIONS => {
			"}" => 267
		}
	},
	{#State 198
		DEFAULT => -149
	},
	{#State 199
		DEFAULT => -161
	},
	{#State 200
		ACTIONS => {
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'LBRACE' => 80,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'HashReference' => 97,
			'Literal' => 96,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 268,
			'HashDereferenced' => 88
		}
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 269
		}
	},
	{#State 202
		DEFAULT => -160
	},
	{#State 203
		DEFAULT => -162
	},
	{#State 204
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 270
		}
	},
	{#State 205
		DEFAULT => -16
	},
	{#State 206
		DEFAULT => -55
	},
	{#State 207
		ACTIONS => {
			"our" => -58,
			"our \$class_properties = {" => 271,
			'LITERAL_NUMBER' => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 272,
			'PropertiesClass' => 273
		}
	},
	{#State 208
		ACTIONS => {
			"## no critic qw(" => 8,
			"}" => 275
		},
		GOTOS => {
			'Critic' => 274
		}
	},
	{#State 209
		ACTIONS => {
			'WORD' => 276
		}
	},
	{#State 210
		DEFAULT => -41
	},
	{#State 211
		DEFAULT => -45
	},
	{#State 212
		ACTIONS => {
			"my" => 83,
			'OP01_PRINT' => 105,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			"while (" => -147,
			"for my integer" => -147,
			'LITERAL_STRING' => 115,
			"foreach my" => -147,
			'LBRACKET' => 98,
			'WORD' => 116,
			"%{" => 118,
			'OP01_NAMED' => 90,
			'VARIABLE_SYMBOL' => 110,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP01_NAMED_VOID' => 95,
			"}" => 277,
			"if (" => 113,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 87
		},
		GOTOS => {
			'ArrayReference' => 120,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'HashReference' => 97,
			'Literal' => 96,
			'WordScoped' => 111,
			'VariableDeclaration' => 94,
			'Variable' => 114,
			'Operator' => 109,
			'Statement' => 89,
			'LoopLabel' => 91,
			'HashDereferenced' => 88,
			'ArrayDereferenced' => 84,
			'PAREN-39' => 81,
			'VariableModification' => 108,
			'OperatorVoid' => 78,
			'Operation' => 278,
			'Expression' => 101,
			'SubExpression' => 102
		}
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 279
		}
	},
	{#State 214
		DEFAULT => -102
	},
	{#State 215
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			"}" => -85,
			'OP04_MATH_POW' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP13_BITWISE_AND' => -85,
			")" => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			";" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			"]" => -85,
			'OP17_LIST_RANGE' => -85
		}
	},
	{#State 216
		ACTIONS => {
			'WORD' => -195,
			'LBRACKET' => -195,
			"%{" => -195,
			'LITERAL_STRING' => -195,
			'LITERAL_NUMBER' => -195,
			'OP03_MATH_INC_DEC' => -195,
			'OP22_LOGICAL_NEG' => -195,
			"undef" => -195,
			'OP05_MATH_NEG_LPAREN' => -195,
			'OP01_NAMED' => -195,
			'VARIABLE_SYMBOL' => -195,
			'OP05_LOGICAL_NEG' => -195,
			"\@{" => -195,
			'OP01_OPEN' => -195,
			"my" => 74,
			'LPAREN' => -195,
			'WORD_SCOPED' => -195,
			'LBRACE' => -195,
			'OP10_STRINGIFY_UNARY' => -195,
			'OP10_NAMED_UNARY' => -195,
			'OP01_CLOSE' => -195
		},
		GOTOS => {
			'TypeInner' => 280,
			'OPTIONAL-51' => 281
		}
	},
	{#State 217
		ACTIONS => {
			'OP21_LIST_COMMA' => 282,
			"}" => 283
		},
		GOTOS => {
			'PAREN-52' => 284
		}
	},
	{#State 218
		ACTIONS => {
			'FH_REF_SYMBOL' => 285
		}
	},
	{#State 219
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 287,
			";" => 286
		}
	},
	{#State 220
		DEFAULT => -125
	},
	{#State 221
		DEFAULT => -188
	},
	{#State 222
		ACTIONS => {
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_QW' => 152,
			"my" => 74,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98
		},
		GOTOS => {
			'Operator' => 109,
			'ListElement' => 153,
			'Variable' => 132,
			'WordScoped' => 111,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'Expression' => 130,
			'TypeInner' => 147,
			'ArrayDereferenced' => 84,
			'ListElements' => 288,
			'ArrayReference' => 120,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 223
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -187,
			'OP17_LIST_RANGE' => 174,
			"]" => -187,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			";" => -187,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			")" => -187,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 224
		ACTIONS => {
			'WORD' => 289
		},
		GOTOS => {
			'PLUS-49' => 290
		}
	},
	{#State 225
		ACTIONS => {
			"]" => -184,
			";" => -184,
			'OP21_LIST_COMMA' => 291,
			")" => -184
		},
		GOTOS => {
			'PAREN-47' => 292
		}
	},
	{#State 226
		DEFAULT => -123
	},
	{#State 227
		DEFAULT => -191
	},
	{#State 228
		ACTIONS => {
			'OP21_LIST_COMMA' => 293
		}
	},
	{#State 229
		DEFAULT => -142
	},
	{#State 230
		ACTIONS => {
			"my" => 74,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LPAREN' => 100,
			'OP01_QW' => 152,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ListElements' => 294,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'Expression' => 130,
			'TypeInner' => 147,
			'Operator' => 109,
			'Variable' => 132,
			'ListElement' => 153,
			'WordScoped' => 111
		}
	},
	{#State 231
		ACTIONS => {
			'OP21_LIST_COMMA' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			"]" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP08_STRING_CAT' => -91,
			";" => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			")" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP18_TERNARY' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP06_REGEX_MATCH' => -91
		}
	},
	{#State 232
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			";" => -106,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -106,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => -106,
			'OP13_BITWISE_AND' => 167,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP18_TERNARY' => -106,
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 233
		DEFAULT => -94
	},
	{#State 234
		ACTIONS => {
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_STRING_CAT' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			")" => -98,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -98,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 235
		ACTIONS => {
			'OP15_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP04_MATH_POW' => 161,
			"}" => -103,
			'OP18_TERNARY' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP06_REGEX_MATCH' => 163,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP11_COMPARE_LT_GT' => undef,
			'OP21_LIST_COMMA' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			";" => -103,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => -103,
			")" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP23_LOGICAL_AND' => -103
		}
	},
	{#State 236
		ACTIONS => {
			")" => -108,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => -108,
			'OP13_BITWISE_AND' => 167,
			'OP07_STRING_REPEAT' => 177,
			";" => -108,
			'OP08_MATH_ADD_SUB' => 168,
			'OP08_STRING_CAT' => 164,
			'OP21_LIST_COMMA' => -108,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => -108,
			"]" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP18_TERNARY' => -108,
			"}" => -108,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 171
		}
	},
	{#State 237
		ACTIONS => {
			";" => -105,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -105,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -105,
			'OP17_LIST_RANGE' => -105,
			"]" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_STRING_CAT' => 164,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP06_REGEX_MATCH' => 163,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP18_TERNARY' => -105,
			"}" => -105
		}
	},
	{#State 238
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => -97,
			'OP18_TERNARY' => -97,
			"}" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP08_STRING_CAT' => -97,
			'OP07_STRING_REPEAT' => 177,
			";" => -97,
			'OP08_MATH_ADD_SUB' => -97,
			")" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP13_BITWISE_AND' => -97
		}
	},
	{#State 239
		DEFAULT => -212
	},
	{#State 240
		ACTIONS => {
			'COLON' => 295
		}
	},
	{#State 241
		DEFAULT => -211
	},
	{#State 242
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 163,
			'OP18_TERNARY' => -96,
			"}" => -96,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP15_LOGICAL_AND' => -96,
			")" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_STRING_REPEAT' => 177,
			";" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP08_STRING_CAT' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP16_LOGICAL_OR' => -96
		}
	},
	{#State 243
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => -107,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -107,
			'OP17_LIST_RANGE' => -107,
			"]" => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP13_BITWISE_AND' => 167,
			")" => -107,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -107,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => -107,
			"}" => -107,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => -107,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => -107
		}
	},
	{#State 244
		ACTIONS => {
			'OP18_TERNARY' => -99,
			"}" => -99,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP17_LIST_RANGE' => -99,
			"]" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -99,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 245
		ACTIONS => {
			'OP21_LIST_COMMA' => -113,
			'OP11_COMPARE_LT_GT' => 165,
			"]" => -113,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 177,
			";" => -113,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -113,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP18_TERNARY' => 169,
			"}" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163
		}
	},
	{#State 246
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP21_LIST_COMMA' => -109,
			'OP11_COMPARE_LT_GT' => 165,
			"]" => -109,
			'OP17_LIST_RANGE' => undef,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -109,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => -109,
			'OP13_BITWISE_AND' => 167,
			")" => -109,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => -109,
			"}" => -109,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => -109
		}
	},
	{#State 247
		ACTIONS => {
			";" => -104,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -104,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -104,
			'OP17_LIST_RANGE' => -104,
			"]" => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP08_STRING_CAT' => 164,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 163,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => -104,
			'OP18_TERNARY' => -104,
			"}" => -104
		}
	},
	{#State 248
		ACTIONS => {
			";" => -112,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -112,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => -112,
			'OP13_BITWISE_AND' => 167,
			'OP21_LIST_COMMA' => -112,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			"]" => -112,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			"}" => -112
		}
	},
	{#State 249
		ACTIONS => {
			'OP16_LOGICAL_OR' => -95,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP08_STRING_CAT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			";" => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			")" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP04_MATH_POW' => 161,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95
		}
	},
	{#State 250
		ACTIONS => {
			";" => 296
		}
	},
	{#State 251
		ACTIONS => {
			";" => 297
		}
	},
	{#State 252
		DEFAULT => -192
	},
	{#State 253
		DEFAULT => -193
	},
	{#State 254
		DEFAULT => -169
	},
	{#State 255
		ACTIONS => {
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 298,
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 299,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120
		}
	},
	{#State 256
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97,
			'Operator' => 109,
			'Variable' => 132,
			'WordScoped' => 111,
			'HashDereferenced' => 88,
			'SubExpression' => 300,
			'Expression' => 130
		}
	},
	{#State 257
		ACTIONS => {
			")" => 301
		}
	},
	{#State 258
		DEFAULT => -126
	},
	{#State 259
		DEFAULT => -93
	},
	{#State 260
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 302
		}
	},
	{#State 261
		ACTIONS => {
			";" => 304
		}
	},
	{#State 262
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -143,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 263
		DEFAULT => -144
	},
	{#State 264
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 169,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			";" => 305,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP08_STRING_CAT' => 164,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166
		}
	},
	{#State 265
		ACTIONS => {
			'LPAREN' => 306
		}
	},
	{#State 266
		DEFAULT => -205
	},
	{#State 267
		DEFAULT => -204
	},
	{#State 268
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			")" => 307,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 269
		ACTIONS => {
			'LPAREN' => 308
		}
	},
	{#State 270
		ACTIONS => {
			'VARIABLE_SYMBOL' => 309
		}
	},
	{#State 271
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 310
		}
	},
	{#State 272
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 311
		}
	},
	{#State 273
		DEFAULT => -57
	},
	{#State 274
		ACTIONS => {
			'WORD' => 314,
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 312,
			'HashEntryTyped' => 313
		}
	},
	{#State 275
		ACTIONS => {
			";" => 315
		}
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 316
		}
	},
	{#State 277
		ACTIONS => {
			";" => 317
		}
	},
	{#State 278
		DEFAULT => -44
	},
	{#State 279
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 318
		}
	},
	{#State 280
		DEFAULT => -194
	},
	{#State 281
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashReference' => 97,
			'Literal' => 96,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 319
		}
	},
	{#State 282
		ACTIONS => {
			"%{" => 118,
			'WORD' => 135
		},
		GOTOS => {
			'HashDereferenced' => 137,
			'HashEntry' => 320
		}
	},
	{#State 283
		DEFAULT => -203
	},
	{#State 284
		DEFAULT => -201
	},
	{#State 285
		ACTIONS => {
			'OP21_LIST_COMMA' => 321
		}
	},
	{#State 286
		DEFAULT => -175
	},
	{#State 287
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'LITERAL_STRING' => 115,
			'STDIN' => 263,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'LBRACE' => 80,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 262,
			'Operator' => 109,
			'SubExpressionOrStdin' => 322,
			'WordScoped' => 111,
			'Variable' => 132
		}
	},
	{#State 288
		ACTIONS => {
			";" => 323
		}
	},
	{#State 289
		DEFAULT => -183
	},
	{#State 290
		ACTIONS => {
			'WORD' => 325,
			")" => 324
		}
	},
	{#State 291
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			"my" => 74,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'KEYS_OR_VALUES' => 145,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98
		},
		GOTOS => {
			'Operator' => 109,
			'WordScoped' => 111,
			'ListElement' => 326,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'TypeInner' => 147,
			'SubExpression' => 151,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 292
		DEFAULT => -180
	},
	{#State 293
		ACTIONS => {
			"my" => 74,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 152,
			'LPAREN' => 100,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'KEYS_OR_VALUES' => 145
		},
		GOTOS => {
			'Operator' => 109,
			'Variable' => 132,
			'ListElement' => 153,
			'WordScoped' => 111,
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'TypeInner' => 147,
			'Expression' => 130,
			'ArrayDereferenced' => 84,
			'ListElements' => 327,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97
		}
	},
	{#State 294
		ACTIONS => {
			")" => 328
		}
	},
	{#State 295
		ACTIONS => {
			'VARIABLE_SYMBOL' => 110,
			'LITERAL_STRING' => 115,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Variable' => 241,
			'VariableOrLiteral' => 329,
			'Literal' => 239
		}
	},
	{#State 296
		DEFAULT => -121
	},
	{#State 297
		DEFAULT => -122
	},
	{#State 298
		ACTIONS => {
			"}" => 330,
			'LPAREN' => -206
		}
	},
	{#State 299
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			"}" => 331,
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => 166,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 300
		ACTIONS => {
			'OP16_LOGICAL_OR' => 166,
			"]" => 332,
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 169,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 301
		DEFAULT => -131
	},
	{#State 302
		DEFAULT => -155,
		GOTOS => {
			'STAR-42' => 333
		}
	},
	{#State 303
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 87,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 90,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP01_NAMED_VOID' => 95,
			"if (" => 113,
			"foreach my" => -147,
			'LITERAL_STRING' => 115,
			'WORD' => 116,
			'LBRACKET' => 98,
			"%{" => 118,
			"while (" => -147,
			"for my integer" => -147,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'OP01_PRINT' => 105,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			"my" => 83
		},
		GOTOS => {
			'PLUS-45' => 335,
			'OperatorVoid' => 78,
			'Operation' => 334,
			'Expression' => 101,
			'SubExpression' => 102,
			'ArrayDereferenced' => 84,
			'PAREN-39' => 81,
			'VariableModification' => 108,
			'WordScoped' => 111,
			'Variable' => 114,
			'VariableDeclaration' => 94,
			'Operator' => 109,
			'Statement' => 89,
			'LoopLabel' => 91,
			'HashDereferenced' => 88,
			'ArrayReference' => 120,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'HashReference' => 97,
			'Literal' => 96
		}
	},
	{#State 304
		DEFAULT => -177
	},
	{#State 305
		DEFAULT => -178
	},
	{#State 306
		ACTIONS => {
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'WORD' => 24,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'KEYS_OR_VALUES' => 145,
			"my" => 74,
			")" => -129,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_QW' => 152
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'SubExpression' => 151,
			'TypeInner' => 147,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'ListElement' => 153,
			'WordScoped' => 111,
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ListElements' => 336,
			'OPTIONAL-38' => 337,
			'ArrayReference' => 120
		}
	},
	{#State 307
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 338
		}
	},
	{#State 308
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'LITERAL_STRING' => 115,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'SubExpression' => 339,
			'Expression' => 130,
			'HashDereferenced' => 88,
			'Variable' => 132,
			'WordScoped' => 111,
			'Operator' => 109
		}
	},
	{#State 309
		ACTIONS => {
			'LPAREN' => 340
		}
	},
	{#State 310
		ACTIONS => {
			'WORD' => 314,
			"%{" => 118
		},
		GOTOS => {
			'HashEntryTyped' => 341,
			'HashDereferenced' => 312
		}
	},
	{#State 311
		ACTIONS => {
			"our" => 342,
			'LITERAL_NUMBER' => 345
		},
		GOTOS => {
			'MethodOrSubroutine' => 344,
			'Subroutine' => 343,
			'Method' => 346
		}
	},
	{#State 312
		DEFAULT => -199
	},
	{#State 313
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 347
		}
	},
	{#State 314
		ACTIONS => {
			'OP20_HASH_FATARROW' => 348
		}
	},
	{#State 315
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 349
		}
	},
	{#State 316
		DEFAULT => -210
	},
	{#State 317
		DEFAULT => -46
	},
	{#State 318
		ACTIONS => {
			'OP21_LIST_COMMA' => 351,
			")" => 352
		},
		GOTOS => {
			'PAREN-18' => 350
		}
	},
	{#State 319
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			"}" => -196,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP21_LIST_COMMA' => -196,
			'OP11_COMPARE_LT_GT' => 165,
			'OP17_LIST_RANGE' => 174,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 320
		DEFAULT => -200
	},
	{#State 321
		ACTIONS => {
			'LITERAL_STRING' => 353
		}
	},
	{#State 322
		ACTIONS => {
			";" => 354
		}
	},
	{#State 323
		DEFAULT => -124
	},
	{#State 324
		DEFAULT => -185
	},
	{#State 325
		DEFAULT => -182
	},
	{#State 326
		DEFAULT => -179
	},
	{#State 327
		ACTIONS => {
			")" => 355
		}
	},
	{#State 328
		DEFAULT => -84
	},
	{#State 329
		DEFAULT => -110
	},
	{#State 330
		DEFAULT => -174
	},
	{#State 331
		DEFAULT => -173
	},
	{#State 332
		DEFAULT => -172
	},
	{#State 333
		ACTIONS => {
			"%{" => -158,
			'WORD' => -158,
			'LITERAL_STRING' => -158,
			"foreach my" => -158,
			"}" => -158,
			"if (" => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			"else" => 360,
			'VARIABLE_SYMBOL' => -158,
			"elsif (" => 359,
			"\@{" => -158,
			'OP05_LOGICAL_NEG' => -158,
			'OP01_PRINT' => -158,
			'OP01_CLOSE' => -158,
			'OP10_NAMED_UNARY' => -158,
			'LPAREN' => -158,
			"for my integer" => -158,
			"while (" => -158,
			'LBRACKET' => -158,
			'OP01_NAMED_VOID' => -158,
			"undef" => -158,
			'OP22_LOGICAL_NEG' => -158,
			'OP01_NAMED' => -158,
			'' => -158,
			'LITERAL_NUMBER' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'OP19_LOOP_CONTROL' => -158,
			"my" => -158,
			'OP01_OPEN' => -158,
			'LBRACE' => -158,
			'OP10_STRINGIFY_UNARY' => -158,
			'WORD_SCOPED' => -158
		},
		GOTOS => {
			'OPTIONAL-44' => 356,
			'PAREN-43' => 357,
			'PAREN-41' => 358
		}
	},
	{#State 334
		DEFAULT => -167
	},
	{#State 335
		ACTIONS => {
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP01_PRINT' => 105,
			"my" => 83,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP01_CLOSE' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP10_STRINGIFY_UNARY' => 79,
			'LBRACKET' => 98,
			'WORD' => 116,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			"foreach my" => -147,
			"while (" => -147,
			"for my integer" => -147,
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP01_NAMED_VOID' => 95,
			"if (" => 113,
			"}" => 362,
			'OP01_NAMED' => 90,
			'VARIABLE_SYMBOL' => 110
		},
		GOTOS => {
			'PAREN-39' => 81,
			'VariableModification' => 108,
			'ArrayDereferenced' => 84,
			'Operation' => 361,
			'Expression' => 101,
			'SubExpression' => 102,
			'OperatorVoid' => 78,
			'Literal' => 96,
			'HashReference' => 97,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'Operator' => 109,
			'Statement' => 89,
			'LoopLabel' => 91,
			'WordScoped' => 111,
			'VariableDeclaration' => 94,
			'Variable' => 114
		}
	},
	{#State 336
		DEFAULT => -128
	},
	{#State 337
		ACTIONS => {
			")" => 363
		}
	},
	{#State 338
		DEFAULT => -165
	},
	{#State 339
		ACTIONS => {
			'OP18_TERNARY' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => 166,
			'OP17_LIST_RANGE' => 364,
			'OP11_COMPARE_LT_GT' => 165,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 340
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'KEYS_OR_VALUES' => 145,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 152,
			'LPAREN' => 100,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			"my" => 74
		},
		GOTOS => {
			'Literal' => 96,
			'HashReference' => 97,
			'ArrayReference' => 120,
			'ListElements' => 365,
			'ArrayDereferenced' => 84,
			'Expression' => 130,
			'TypeInner' => 147,
			'SubExpression' => 151,
			'HashDereferenced' => 88,
			'WordScoped' => 111,
			'Variable' => 132,
			'ListElement' => 153,
			'Operator' => 109
		}
	},
	{#State 341
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 366
		}
	},
	{#State 342
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 367
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 343
		DEFAULT => -81
	},
	{#State 344
		DEFAULT => -59
	},
	{#State 345
		ACTIONS => {
			";" => 368
		}
	},
	{#State 346
		DEFAULT => -80
	},
	{#State 347
		ACTIONS => {
			"}" => 369,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-25' => 371
		}
	},
	{#State 348
		ACTIONS => {
			"my" => 74
		},
		GOTOS => {
			'TypeInner' => 372
		}
	},
	{#State 349
		DEFAULT => -66
	},
	{#State 350
		DEFAULT => -48
	},
	{#State 351
		ACTIONS => {
			"my" => 373
		}
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 374
		}
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 375
		}
	},
	{#State 354
		DEFAULT => -176
	},
	{#State 355
		DEFAULT => -86
	},
	{#State 356
		DEFAULT => -159
	},
	{#State 357
		DEFAULT => -157
	},
	{#State 358
		DEFAULT => -154
	},
	{#State 359
		ACTIONS => {
			'LITERAL_STRING' => 115,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			"undef" => 92,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 80
		},
		GOTOS => {
			'ArrayReference' => 120,
			'ArrayDereferenced' => 84,
			'Literal' => 96,
			'HashReference' => 97,
			'WordScoped' => 111,
			'Variable' => 132,
			'Operator' => 109,
			'Expression' => 130,
			'SubExpression' => 376,
			'HashDereferenced' => 88
		}
	},
	{#State 360
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 361
		DEFAULT => -166
	},
	{#State 362
		DEFAULT => -168
	},
	{#State 363
		DEFAULT => -132
	},
	{#State 364
		ACTIONS => {
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 115,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashReference' => 97,
			'Literal' => 96,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 378
		}
	},
	{#State 365
		ACTIONS => {
			")" => 379
		}
	},
	{#State 366
		ACTIONS => {
			'OP21_LIST_COMMA' => 380,
			"}" => 382
		},
		GOTOS => {
			'PAREN-27' => 381
		}
	},
	{#State 367
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 368
		DEFAULT => -61
	},
	{#State 369
		ACTIONS => {
			";" => 384
		}
	},
	{#State 370
		ACTIONS => {
			'WORD' => 314,
			"%{" => 118
		},
		GOTOS => {
			'HashEntryTyped' => 385,
			'HashDereferenced' => 312
		}
	},
	{#State 371
		DEFAULT => -63
	},
	{#State 372
		ACTIONS => {
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			'LBRACE' => 80,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			"undef" => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'WORD' => 24,
			'LBRACKET' => 98,
			"%{" => 118,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 96,
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'HashDereferenced' => 88,
			'SubExpression' => 386,
			'Expression' => 130,
			'Operator' => 109,
			'Variable' => 132,
			'WordScoped' => 111
		}
	},
	{#State 373
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 387
		}
	},
	{#State 374
		ACTIONS => {
			"\@_;" => 388
		}
	},
	{#State 375
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 104,
			'LBRACE' => 80,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_OPEN' => 82,
			'OP01_NAMED' => 133,
			'VARIABLE_SYMBOL' => 110,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 98,
			'WORD' => 24,
			"%{" => 118
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97,
			'Operator' => 109,
			'WordScoped' => 111,
			'Variable' => 132,
			'HashDereferenced' => 88,
			'Expression' => 130,
			'SubExpression' => 389
		}
	},
	{#State 376
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP15_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 169,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			")" => 390,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 377
		DEFAULT => -156
	},
	{#State 378
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 165,
			'OP16_LOGICAL_OR' => 166,
			'OP12_COMPARE_EQ_NE' => 175,
			")" => 391,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => -109,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP18_TERNARY' => -109,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 161,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 380
		ACTIONS => {
			"%{" => 118,
			'WORD' => 314
		},
		GOTOS => {
			'HashEntryTyped' => 393,
			'HashDereferenced' => 312
		}
	},
	{#State 381
		DEFAULT => -68
	},
	{#State 382
		ACTIONS => {
			";" => 394
		}
	},
	{#State 383
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 384
		DEFAULT => -65
	},
	{#State 385
		DEFAULT => -62
	},
	{#State 386
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 176,
			'OP13_BITWISE_AND' => 167,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP16_LOGICAL_OR' => 166,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -198,
			'OP17_LIST_RANGE' => 174,
			'OP08_STRING_CAT' => 164,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP09_BITWISE_SHIFT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP18_TERNARY' => 169,
			"}" => -198
		}
	},
	{#State 387
		ACTIONS => {
			'VARIABLE_SYMBOL' => 396
		}
	},
	{#State 388
		DEFAULT => -50
	},
	{#State 389
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 161,
			"}" => -87,
			'OP18_TERNARY' => 169,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP06_REGEX_MATCH' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			"]" => -87,
			'OP17_LIST_RANGE' => 174,
			'OP11_COMPARE_LT_GT' => 165,
			'OP21_LIST_COMMA' => -87,
			'OP16_LOGICAL_OR' => 166,
			'OP08_STRING_CAT' => 164,
			";" => -87,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 175,
			")" => -87,
			'OP13_BITWISE_AND' => 167,
			'OP23_LOGICAL_AND' => -87
		}
	},
	{#State 390
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 391
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 398
		}
	},
	{#State 392
		DEFAULT => -164
	},
	{#State 393
		DEFAULT => -67
	},
	{#State 394
		DEFAULT => -70
	},
	{#State 395
		ACTIONS => {
			"( my" => 399,
			'WORD_SCOPED' => -72,
			'LPAREN' => -72,
			'LBRACE' => -72,
			'OP01_CLOSE' => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP01_OPEN' => -72,
			"\@{" => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP01_PRINT' => -72,
			"my" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'LITERAL_NUMBER' => -72,
			"if (" => -72,
			'OP01_NAMED_VOID' => -72,
			'OP22_LOGICAL_NEG' => -72,
			"undef" => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP01_NAMED' => -72,
			"%{" => -72,
			'WORD' => -72,
			'LBRACKET' => -72,
			'LITERAL_STRING' => -72,
			"foreach my" => -72,
			"for my integer" => -72,
			"while (" => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 401,
			'MethodArguments' => 400
		}
	},
	{#State 396
		DEFAULT => -47
	},
	{#State 397
		DEFAULT => -153
	},
	{#State 398
		DEFAULT => -163
	},
	{#State 399
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 402
		}
	},
	{#State 400
		DEFAULT => -71
	},
	{#State 401
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			"undef" => 92,
			"if (" => 113,
			'OP01_NAMED_VOID' => 95,
			'OP01_NAMED' => 90,
			'VARIABLE_SYMBOL' => 110,
			'LITERAL_NUMBER' => 86,
			'OP19_LOOP_CONTROL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			"while (" => -147,
			"for my integer" => -147,
			'WORD' => 116,
			'LBRACKET' => 98,
			"%{" => 118,
			'LITERAL_STRING' => 115,
			"foreach my" => -147,
			'LBRACE' => 80,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'LPAREN' => 100,
			'WORD_SCOPED' => 22,
			"my" => 83,
			'OP05_LOGICAL_NEG' => 106,
			"\@{" => 107,
			'OP01_OPEN' => 82,
			'OP01_PRINT' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 84,
			'VariableModification' => 108,
			'PAREN-39' => 81,
			'OperatorVoid' => 78,
			'SubExpression' => 102,
			'Expression' => 101,
			'Operation' => 404,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'ArrayReference' => 120,
			'Literal' => 96,
			'HashReference' => 97,
			'PLUS-30' => 403,
			'LoopLabel' => 91,
			'Operator' => 109,
			'Statement' => 89,
			'Variable' => 114,
			'VariableDeclaration' => 94,
			'WordScoped' => 111,
			'HashDereferenced' => 88
		}
	},
	{#State 402
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 405
		}
	},
	{#State 403
		ACTIONS => {
			"my" => 83,
			'OP01_OPEN' => 82,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_PRINT' => 105,
			'LBRACE' => 80,
			'OP01_CLOSE' => 104,
			'OP10_STRINGIFY_UNARY' => 79,
			'OP10_NAMED_UNARY' => 103,
			'WORD_SCOPED' => 22,
			'LPAREN' => 100,
			"for my integer" => -147,
			"while (" => -147,
			"%{" => 118,
			'LBRACKET' => 98,
			'WORD' => 116,
			"foreach my" => -147,
			'LITERAL_STRING' => 115,
			"}" => 406,
			'OP01_NAMED_VOID' => 95,
			"if (" => 113,
			"undef" => 92,
			'OP05_MATH_NEG_LPAREN' => 112,
			'OP22_LOGICAL_NEG' => 93,
			'VARIABLE_SYMBOL' => 110,
			'OP01_NAMED' => 90,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 87
		},
		GOTOS => {
			'SubExpression' => 102,
			'Expression' => 101,
			'Operation' => 407,
			'OperatorVoid' => 78,
			'VariableModification' => 108,
			'PAREN-39' => 81,
			'ArrayDereferenced' => 84,
			'HashDereferenced' => 88,
			'LoopLabel' => 91,
			'Statement' => 89,
			'Operator' => 109,
			'VariableDeclaration' => 94,
			'Variable' => 114,
			'WordScoped' => 111,
			'Literal' => 96,
			'HashReference' => 97,
			'OPTIONAL-40' => 119,
			'Conditional' => 99,
			'ArrayReference' => 120
		}
	},
	{#State 404
		DEFAULT => -74
	},
	{#State 405
		ACTIONS => {
			")" => 408,
			'OP21_LIST_COMMA' => 409
		},
		GOTOS => {
			'PAREN-31' => 410
		}
	},
	{#State 406
		ACTIONS => {
			";" => 411
		}
	},
	{#State 407
		DEFAULT => -73
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 409
		ACTIONS => {
			"my" => 413
		}
	},
	{#State 410
		DEFAULT => -77
	},
	{#State 411
		DEFAULT => -75
	},
	{#State 412
		ACTIONS => {
			"\@_;" => 414
		}
	},
	{#State 413
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 415
		}
	},
	{#State 414
		DEFAULT => -79
	},
	{#State 415
		ACTIONS => {
			'VARIABLE_SYMBOL' => 416
		}
	},
	{#State 416
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5858 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5872 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5996 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6121 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6153 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6160 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6182 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6427 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6810 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_125
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6976 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7030 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7041 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 4,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_164
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_165
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_168
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_171
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_172
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_175
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_177
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_184
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_185
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_191
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_192
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7610 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_193
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_196
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7646 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_197
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7657 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_198
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_199
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7679 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-52', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7686 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_203
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_204
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_205
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_208
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule Type_209
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_210
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_211
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_212
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_213
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	]
],
#line 7835 lib/RPerl/Grammar.pm
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
         'Operator_111', 
         'Operator_112', 
         'Operator_113', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         'OperatorVoid_124', 
         'OperatorVoid_125', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpressionOrStdin_143', 
         'SubExpressionOrStdin_144', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_148', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_159', 
         'Loop_160', 
         'Loop_161', 
         'Loop_162', 
         'LoopFor_163', 
         'LoopForEach_164', 
         'LoopWhile_165', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_168', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_171', 
         'VariableRetrieval_172', 
         'VariableRetrieval_173', 
         'VariableRetrieval_174', 
         'VariableDeclaration_175', 
         'VariableDeclaration_176', 
         'VariableModification_177', 
         'VariableModification_178', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_184', 
         'ListElements_185', 
         'ListElement_186', 
         'ListElement_187', 
         'ListElement_188', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_191', 
         'ArrayDereferenced_192', 
         'ArrayDereferenced_193', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_196', 
         'HashEntry_197', 
         'HashEntryTyped_198', 
         'HashEntryTyped_199', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_203', 
         'HashDereferenced_204', 
         'HashDereferenced_205', 
         'WordScoped_206', 
         'WordScoped_207', 
         'LoopLabel_208', 
         'Type_209', 
         'TypeInner_210', 
         'VariableOrLiteral_211', 
         'VariableOrLiteral_212', 
         'Literal_213', 
         'Literal_214', );
  $self;
}

#line 199 "lib/RPerl/Grammar.eyp"


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


#line 8098 lib/RPerl/Grammar.pm



1;
