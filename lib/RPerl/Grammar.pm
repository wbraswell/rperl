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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|elsif\ \(|package|\$TYPED_|while\ \(|\=\ sub\ \{|undef|if\ \(|else|\(\ my|qw\(|our|\@_\;|use|my|\%\{|\@\{|\]|\;|\)|\})}gc and return ($1, $1);

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
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
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


#line 124 lib/RPerl/Grammar.pm

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
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP10_STRINGIFY_UNARY', 'SubExpression', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'LoopLabel' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_124' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'OPTIONAL-36', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LPAREN', 'OPTIONAL-38', ')' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_142' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_143' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'OPTIONAL-40', 'Loop' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [ 'STAR-42', 'PAREN-41' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [  ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'PAREN-43' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Conditional_158' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-42', 'OPTIONAL-44' ], 0 ],
  [ 'Loop_159' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_160' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_162' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_163' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_164' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'Operation' ], 0 ],
  [ 'CodeBlock_167' => 'CodeBlock', [ 'LBRACE', 'PLUS-45', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'Variable_170' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-46' ], 0 ],
  [ 'VariableRetrieval_171' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_172' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_173' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_174' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_175' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_176' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_177' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'PLUS-49', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'WORD' ], 0 ],
  [ 'ListElements_183' => 'ListElements', [ 'ListElement', 'STAR-48' ], 0 ],
  [ 'ListElements_184' => 'ListElements', [ 'OP01_QW', 'LPAREN', 'PLUS-49', ')' ], 0 ],
  [ 'ListElement_185' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_186' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'ArrayReference_190' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-50', ']' ], 0 ],
  [ 'ArrayDereferenced_191' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_192' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashEntry_195' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-51', 'SubExpression' ], 0 ],
  [ 'HashEntry_196' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_197' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_198' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-52', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'PAREN-52' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'HashReference_202' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-53', '}' ], 0 ],
  [ 'HashDereferenced_203' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_204' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_205' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_207' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_208' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_209' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_210' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_211' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_212' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_213' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PAREN' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  'OperatorVoid_124' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
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
  'SubExpression_141' => 141,
  'SubExpressionOrStdin_142' => 142,
  'SubExpressionOrStdin_143' => 143,
  '_PAREN' => 144,
  '_OPTIONAL' => 145,
  '_OPTIONAL' => 146,
  'Statement_147' => 147,
  'Statement_148' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  '_PAREN' => 152,
  '_STAR_LIST' => 153,
  '_STAR_LIST' => 154,
  '_PAREN' => 155,
  '_OPTIONAL' => 156,
  '_OPTIONAL' => 157,
  'Conditional_158' => 158,
  'Loop_159' => 159,
  'Loop_160' => 160,
  'Loop_161' => 161,
  'LoopFor_162' => 162,
  'LoopForEach_163' => 163,
  'LoopWhile_164' => 164,
  '_PLUS_LIST' => 165,
  '_PLUS_LIST' => 166,
  'CodeBlock_167' => 167,
  '_STAR_LIST' => 168,
  '_STAR_LIST' => 169,
  'Variable_170' => 170,
  'VariableRetrieval_171' => 171,
  'VariableRetrieval_172' => 172,
  'VariableRetrieval_173' => 173,
  'VariableDeclaration_174' => 174,
  'VariableDeclaration_175' => 175,
  'VariableModification_176' => 176,
  'VariableModification_177' => 177,
  '_PAREN' => 178,
  '_STAR_LIST' => 179,
  '_STAR_LIST' => 180,
  '_PLUS_LIST' => 181,
  '_PLUS_LIST' => 182,
  'ListElements_183' => 183,
  'ListElements_184' => 184,
  'ListElement_185' => 185,
  'ListElement_186' => 186,
  'ListElement_187' => 187,
  '_OPTIONAL' => 188,
  '_OPTIONAL' => 189,
  'ArrayReference_190' => 190,
  'ArrayDereferenced_191' => 191,
  'ArrayDereferenced_192' => 192,
  '_OPTIONAL' => 193,
  '_OPTIONAL' => 194,
  'HashEntry_195' => 195,
  'HashEntry_196' => 196,
  'HashEntryTyped_197' => 197,
  'HashEntryTyped_198' => 198,
  '_PAREN' => 199,
  '_STAR_LIST' => 200,
  '_STAR_LIST' => 201,
  'HashReference_202' => 202,
  'HashDereferenced_203' => 203,
  'HashDereferenced_204' => 204,
  'WordScoped_205' => 205,
  'WordScoped_206' => 206,
  'LoopLabel_207' => 207,
  'Type_208' => 208,
  'TypeInner_209' => 209,
  'VariableOrLiteral_210' => 210,
  'VariableOrLiteral_211' => 211,
  'Literal_212' => 212,
  'Literal_213' => 213,
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
			"## no critic qw(" => 8,
			'SHEBANG' => 3,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 4,
			'Critic' => 1,
			'ModuleHeader' => 9,
			'OPTIONAL-9' => 2,
			'Program' => 5,
			'CompileUnit' => 7,
			'PLUS-2' => 6
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 8,
			'' => -5
		},
		GOTOS => {
			'Critic' => 1,
			'PAREN-1' => 13,
			'OPTIONAL-9' => 2,
			'ModuleHeader' => 9
		}
	},
	{#State 7
		ACTIONS => {
			'' => 14
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-14' => 15
		}
	},
	{#State 9
		ACTIONS => {
			"use constant" => -25,
			"use" => -25,
			"our" => -25,
			"use parent qw(" => 21,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Class' => 17,
			'Package' => 19,
			'Module' => 20,
			'STAR-10' => 18
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
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 26
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		ACTIONS => {
			")" => 27,
			'WORD' => 28
		}
	},
	{#State 16
		DEFAULT => -35
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		ACTIONS => {
			"## no critic qw(" => 8,
			"our" => -27,
			"use" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 29,
			'STAR-11' => 30
		}
	},
	{#State 19
		DEFAULT => -22
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -206
	},
	{#State 24
		DEFAULT => -205
	},
	{#State 25
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 26
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
		}
	},
	{#State 27
		DEFAULT => -36
	},
	{#State 28
		DEFAULT => -34
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		ACTIONS => {
			"use constant" => -29,
			"use" => 36,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 37
		}
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_OPEN' => -11,
			"## no critic qw(" => 8,
			'OP22_LOGICAL_NEG' => -11,
			"use constant" => -11,
			'WORD' => -11,
			'WORD_SCOPED' => -11,
			'LPAREN' => -11,
			'OP01_PRINT' => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY' => -11,
			"while (" => -11,
			"our" => -11,
			"foreach my" => -11,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"\@{" => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"for my integer" => -11,
			"my" => -11,
			"%{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			"use" => -11,
			'OP01_NAMED' => -11,
			"if (" => -11,
			'OP01_CLOSE' => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 42
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 43,
			"our" => 45
		},
		GOTOS => {
			'PLUS-13' => 47,
			'Subroutine' => 46,
			'Constant' => 44
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 37
		DEFAULT => -26
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'VARIABLE_SYMBOL' => -13,
			"undef" => -13,
			'LBRACKET' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			'LPAREN' => -13,
			'WORD_SCOPED' => -13,
			'WORD' => -13,
			"use constant" => -13,
			'OP10_NAMED_UNARY' => -13,
			"while (" => -13,
			'LITERAL_STRING' => -13,
			'OP01_PRINT' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			"\@{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"foreach my" => -13,
			"our" => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			"%{" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			"for my integer" => -13,
			'OP01_CLOSE' => -13,
			'LBRACE' => -13,
			"if (" => -13,
			"use" => 36,
			'OP01_NAMED' => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		ACTIONS => {
			"our" => 45,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 48
		ACTIONS => {
			"qw(" => 59,
			";" => 58
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"our" => -15,
			'LBRACKET' => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"foreach my" => -15,
			"\@{" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_STRING' => -15,
			"if (" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_CLOSE' => -15,
			'LBRACE' => -15,
			"while (" => -15,
			"for my integer" => -15,
			'WORD' => -15,
			"use constant" => 43,
			"my" => -15,
			'WORD_SCOPED' => -15,
			'LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID' => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 63
		}
	},
	{#State 52
		DEFAULT => -10
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 54
		DEFAULT => -208
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 56
		DEFAULT => -30
	},
	{#State 57
		ACTIONS => {
			";" => 66
		}
	},
	{#State 58
		DEFAULT => -39
	},
	{#State 59
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 68
		}
	},
	{#State 60
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 69
		}
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			"if (" => 78,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			"while (" => -146,
			'OP01_PRINT' => 102,
			'OP01_NAMED' => 79,
			'LITERAL_STRING' => 98,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'OP01_NAMED_VOID' => 70,
			"for my integer" => -146,
			'WORD' => 94,
			'WORD_SCOPED' => 23,
			"my" => 73,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL' => 110,
			"foreach my" => -146,
			'LBRACKET' => 108,
			"undef" => 109,
			"our" => 45,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Statement' => 91,
			'PLUS-8' => 89,
			'Operator' => 90,
			'LoopLabel' => 113,
			'VariableDeclaration' => 83,
			'OPTIONAL-40' => 106,
			'SubExpression' => 104,
			'Operation' => 103,
			'OperatorVoid' => 86,
			'Subroutine' => 85,
			'ArrayDereferenced' => 107,
			'WordScoped' => 97,
			'VariableModification' => 77,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Variable' => 100,
			'PAREN-39' => 99,
			'Expression' => 93,
			'Conditional' => 74
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 116
		},
		GOTOS => {
			'TypeInner' => 115
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			'WORD' => 119,
			")" => 118
		}
	},
	{#State 69
		ACTIONS => {
			"## no critic qw(" => 8,
			"our %properties = (" => -54,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 121,
			'STAR-21' => 120
		}
	},
	{#State 70
		ACTIONS => {
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_QW' => 123,
			";" => -117,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 126,
			'ListElement' => 127,
			'OPTIONAL-35' => 130,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'Literal' => 96,
			'TypeInner' => 131,
			'WordScoped' => 97,
			'HashReference' => 112,
			'ListElements' => 122,
			'HashDereferenced' => 87
		}
	},
	{#State 71
		ACTIONS => {
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76
		},
		GOTOS => {
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 132
		}
	},
	{#State 72
		ACTIONS => {
			'LBRACE' => 135,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'HashReference' => 134,
			'Variable' => 133
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 136
		}
	},
	{#State 74
		DEFAULT => -147
	},
	{#State 75
		ACTIONS => {
			'FH_REF_SYMBOL' => 137
		}
	},
	{#State 76
		ACTIONS => {
			'WORD' => 139,
			"}" => 138,
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 141,
			'HashEntry' => 140
		}
	},
	{#State 77
		DEFAULT => -151
	},
	{#State 78
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 142,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96
		}
	},
	{#State 79
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'WORD' => 24,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 143,
			'ListElement' => 144,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'TypeInner' => 131,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112
		}
	},
	{#State 80
		ACTIONS => {
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 145
		}
	},
	{#State 81
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 146
		}
	},
	{#State 82
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Variable' => 147,
			'ArrayReference' => 148
		}
	},
	{#State 83
		DEFAULT => -150
	},
	{#State 84
		DEFAULT => -213
	},
	{#State 85
		DEFAULT => -14
	},
	{#State 86
		DEFAULT => -149
	},
	{#State 87
		DEFAULT => -139
	},
	{#State 88
		ACTIONS => {
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114
		},
		GOTOS => {
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'SubExpression' => 149,
			'Expression' => 128,
			'ArrayDereferenced' => 107
		}
	},
	{#State 89
		ACTIONS => {
			"for my integer" => -146,
			'WORD' => 94,
			"my" => 73,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_NAMED_VOID' => 70,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 102,
			'LITERAL_STRING' => 98,
			"if (" => 78,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			"while (" => -146,
			'LBRACE' => 76,
			'OP19_LOOP_CONTROL' => 110,
			'LITERAL_NUMBER' => 84,
			"foreach my" => -146,
			'LBRACKET' => 108,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'' => -18,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Literal' => 96,
			'VariableModification' => 77,
			'WordScoped' => 97,
			'Variable' => 100,
			'PAREN-39' => 99,
			'ArrayReference' => 101,
			'Conditional' => 74,
			'Expression' => 93,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'LoopLabel' => 113,
			'Operator' => 90,
			'Statement' => 91,
			'Operation' => 150,
			'SubExpression' => 104,
			'OPTIONAL-40' => 106,
			'VariableDeclaration' => 83,
			'ArrayDereferenced' => 107,
			'OperatorVoid' => 86
		}
	},
	{#State 90
		DEFAULT => -129
	},
	{#State 91
		DEFAULT => -83
	},
	{#State 92
		ACTIONS => {
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 153,
			'OP01_PRINT' => 152,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 151
		}
	},
	{#State 93
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP18_TERNARY' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			";" => 154,
			'OP06_REGEX_MATCH' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP04_MATH_POW' => -132
		}
	},
	{#State 94
		ACTIONS => {
			'LPAREN' => -205,
			'COLON' => -207
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP09_BITWISE_SHIFT' => -100,
			'LBRACKET' => 108,
			"undef" => 109,
			'OP18_TERNARY' => -100,
			'OP22_LOGICAL_NEG' => 111,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP01_OPEN' => 114,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_STRING_CAT' => -100,
			"}" => -100,
			'LPAREN' => 92,
			'OP14_BITWISE_OR_XOR' => -100,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP15_LOGICAL_AND' => -100,
			'OP10_NAMED_UNARY' => 95,
			'OP04_MATH_POW' => -100,
			'LITERAL_STRING' => 98,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP23_LOGICAL_AND' => -100,
			'OP10_STRINGIFY_UNARY' => 80,
			")" => -100,
			'OP13_BITWISE_AND' => -100,
			'LITERAL_NUMBER' => 84,
			'OP17_LIST_RANGE' => -100,
			"]" => -100,
			'OP05_MATH_NEG_LPAREN' => 88,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			";" => -100,
			'OP06_REGEX_MATCH' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP01_NAMED' => 124,
			'OP11_COMPARE_LT_GT' => -100
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 155,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97
		}
	},
	{#State 96
		DEFAULT => -134
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 156
		}
	},
	{#State 98
		DEFAULT => -212
	},
	{#State 99
		DEFAULT => -145
	},
	{#State 100
		ACTIONS => {
			'OP13_BITWISE_AND' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP03_MATH_INC_DEC' => 160,
			'OP19_VARIABLE_ASSIGN' => 158,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP08_STRING_CAT' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP18_TERNARY' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 159,
			'OP15_LOGICAL_AND' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP02_METHOD_THINARROW' => 157,
			'OP04_MATH_POW' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP16_LOGICAL_OR' => -135
		}
	},
	{#State 101
		DEFAULT => -136
	},
	{#State 102
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => -115,
			'VARIABLE_SYMBOL' => -115,
			'OP03_MATH_INC_DEC' => -115,
			"\@{" => -115,
			'LBRACKET' => -115,
			'LITERAL_NUMBER' => -115,
			"undef" => -115,
			'OP22_LOGICAL_NEG' => -115,
			'OP05_MATH_NEG_LPAREN' => -115,
			'OP01_OPEN' => -115,
			'STDOUT_STDERR' => 164,
			'LPAREN' => -115,
			"%{" => -115,
			'OP05_LOGICAL_NEG' => -115,
			"my" => -115,
			'WORD_SCOPED' => -115,
			'WORD' => -115,
			'OP01_CLOSE' => -115,
			'OP10_NAMED_UNARY' => -115,
			'LBRACE' => -115,
			'KEYS_OR_VALUES' => -115,
			'LITERAL_STRING' => -115,
			'FH_REF_SYMBOL_BRACES' => 162,
			'OP01_QW' => -115,
			'OP01_NAMED' => -115
		},
		GOTOS => {
			'PAREN-33' => 161,
			'OPTIONAL-34' => 163
		}
	},
	{#State 103
		DEFAULT => -17
	},
	{#State 104
		ACTIONS => {
			'OP15_LOGICAL_AND' => 173,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 169,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180
		}
	},
	{#State 105
		DEFAULT => -169,
		GOTOS => {
			'STAR-46' => 181
		}
	},
	{#State 106
		ACTIONS => {
			"while (" => 187,
			"foreach my" => 183,
			"for my integer" => 186
		},
		GOTOS => {
			'LoopFor' => 184,
			'LoopForEach' => 185,
			'LoopWhile' => 182,
			'Loop' => 188
		}
	},
	{#State 107
		DEFAULT => -137
	},
	{#State 108
		ACTIONS => {
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_QW' => 123,
			'OP01_NAMED' => 124,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			"]" => -189,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'ListElement' => 127,
			'OPTIONAL-50' => 190,
			'ListElements' => 189,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126
		}
	},
	{#State 109
		DEFAULT => -133
	},
	{#State 110
		ACTIONS => {
			'WORD' => 192,
			";" => -119
		},
		GOTOS => {
			'LoopLabel' => 191,
			'OPTIONAL-36' => 193
		}
	},
	{#State 111
		ACTIONS => {
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76
		},
		GOTOS => {
			'Literal' => 96,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'SubExpression' => 194,
			'ArrayDereferenced' => 107,
			'Expression' => 128
		}
	},
	{#State 112
		DEFAULT => -138
	},
	{#State 113
		ACTIONS => {
			'COLON' => 195
		}
	},
	{#State 114
		ACTIONS => {
			"my" => 196
		}
	},
	{#State 115
		ACTIONS => {
			'LITERAL_STRING' => 98,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Literal' => 197
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 198
		}
	},
	{#State 117
		ACTIONS => {
			"\@{" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LITERAL_NUMBER' => -43,
			"foreach my" => -43,
			'LBRACKET' => -43,
			"undef" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_OPEN' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LPAREN' => -43,
			"%{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_NAMED_VOID' => -43,
			"for my integer" => -43,
			'WORD' => -43,
			'WORD_SCOPED' => -43,
			"my" => -43,
			"if (" => -43,
			'OP01_CLOSE' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LBRACE' => -43,
			"while (" => -43,
			'OP01_NAMED' => -43,
			'OP01_PRINT' => -43,
			'LITERAL_STRING' => -43,
			"( my" => 199
		},
		GOTOS => {
			'OPTIONAL-16' => 201,
			'SubroutineArguments' => 200
		}
	},
	{#State 118
		ACTIONS => {
			";" => 202
		}
	},
	{#State 119
		DEFAULT => -37
	},
	{#State 120
		ACTIONS => {
			"use" => 36,
			"use constant" => -56,
			"our %properties = (" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 204
		}
	},
	{#State 121
		DEFAULT => -51
	},
	{#State 122
		DEFAULT => -116
	},
	{#State 123
		ACTIONS => {
			'LPAREN' => 205
		}
	},
	{#State 124
		ACTIONS => {
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76
		},
		GOTOS => {
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'SubExpression' => 206,
			'Expression' => 128,
			'ArrayDereferenced' => 107
		}
	},
	{#State 125
		ACTIONS => {
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 207
		}
	},
	{#State 126
		ACTIONS => {
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -185,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP21_LIST_COMMA' => -185,
			'OP16_LOGICAL_OR' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			")" => -185,
			'OP23_LOGICAL_AND' => 171,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -185,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172
		}
	},
	{#State 127
		DEFAULT => -180,
		GOTOS => {
			'STAR-48' => 208
		}
	},
	{#State 128
		DEFAULT => -132
	},
	{#State 129
		ACTIONS => {
			'OP06_REGEX_MATCH' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			";" => -135,
			"}" => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 157,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			")" => -135,
			'OP03_MATH_INC_DEC' => 160,
			'OP23_LOGICAL_AND' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP08_STRING_CAT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			"]" => -135,
			'OP18_TERNARY' => -135,
			'OP17_LIST_RANGE' => -135
		}
	},
	{#State 130
		ACTIONS => {
			";" => 209
		}
	},
	{#State 131
		ACTIONS => {
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'SubExpression' => 210,
			'Expression' => 128,
			'ArrayDereferenced' => 107
		}
	},
	{#State 132
		ACTIONS => {
			'OP06_REGEX_MATCH' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP15_LOGICAL_AND' => -92,
			"}" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			";" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP23_LOGICAL_AND' => -92,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			"]" => -92,
			'OP08_STRING_CAT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92
		}
	},
	{#State 133
		ACTIONS => {
			"}" => 211
		}
	},
	{#State 134
		ACTIONS => {
			"}" => 212
		}
	},
	{#State 135
		ACTIONS => {
			"%{" => 72,
			'WORD' => 139
		},
		GOTOS => {
			'HashEntry' => 140,
			'HashDereferenced' => 141
		}
	},
	{#State 136
		ACTIONS => {
			'VARIABLE_SYMBOL' => 213
		}
	},
	{#State 137
		DEFAULT => -88
	},
	{#State 138
		DEFAULT => -140
	},
	{#State 139
		ACTIONS => {
			'OP20_HASH_FATARROW' => 214
		}
	},
	{#State 140
		DEFAULT => -201,
		GOTOS => {
			'STAR-53' => 215
		}
	},
	{#State 141
		DEFAULT => -196
	},
	{#State 142
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 169,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP23_LOGICAL_AND' => 171,
			")" => 216,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178
		}
	},
	{#State 143
		ACTIONS => {
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP21_LIST_COMMA' => -185,
			'OP16_LOGICAL_OR' => -85,
			'OP04_MATH_POW' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			")" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP18_TERNARY' => -85,
			'OP08_STRING_CAT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85
		}
	},
	{#State 144
		ACTIONS => {
			'OP21_LIST_COMMA' => 217
		}
	},
	{#State 145
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			")" => 218,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169
		}
	},
	{#State 146
		DEFAULT => -89
	},
	{#State 147
		ACTIONS => {
			"}" => 219
		}
	},
	{#State 148
		ACTIONS => {
			"}" => 220
		}
	},
	{#State 149
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP23_LOGICAL_AND' => 171,
			")" => 221,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP14_BITWISE_OR_XOR' => 174
		}
	},
	{#State 150
		DEFAULT => -16
	},
	{#State 151
		ACTIONS => {
			'OP23_LOGICAL_AND' => 171,
			")" => 222,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP16_LOGICAL_OR' => 169,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168
		}
	},
	{#State 152
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 223
		}
	},
	{#State 153
		ACTIONS => {
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'KEYS_OR_VALUES' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'SubExpression' => 143,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'ListElement' => 224
		}
	},
	{#State 154
		DEFAULT => -82
	},
	{#State 155
		ACTIONS => {
			")" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => -99,
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			"}" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP21_LIST_COMMA' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99
		}
	},
	{#State 156
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			")" => -126,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD' => 24,
			"my" => 116,
			'WORD_SCOPED' => 23,
			'KEYS_OR_VALUES' => 125,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'OP01_QW' => 123,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'SubExpression' => 126,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'ListElements' => 225,
			'TypeInner' => 131,
			'Literal' => 96,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'OPTIONAL-37' => 226,
			'ListElement' => 127
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 227
		}
	},
	{#State 158
		ACTIONS => {
			'OP01_NAMED' => 124,
			'STDIN' => 229,
			'LITERAL_STRING' => 98,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80
		},
		GOTOS => {
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'SubExpression' => 228,
			'Expression' => 128,
			'SubExpressionOrStdin' => 230,
			'ArrayDereferenced' => 107
		}
	},
	{#State 159
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'SubExpression' => 231,
			'Expression' => 128,
			'ArrayDereferenced' => 107
		}
	},
	{#State 160
		DEFAULT => -90
	},
	{#State 161
		DEFAULT => -114
	},
	{#State 162
		ACTIONS => {
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_QW' => 123,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'KEYS_OR_VALUES' => 125,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76
		},
		GOTOS => {
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'ListElement' => 127,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'ListElements' => 232,
			'HashReference' => 112,
			'TypeInner' => 131,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			"my" => 116,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_QW' => 123,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'KEYS_OR_VALUES' => 125
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'ListElement' => 127,
			'ListElements' => 233,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131
		}
	},
	{#State 164
		DEFAULT => -113
	},
	{#State 165
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 234
		}
	},
	{#State 166
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'SubExpression' => 235,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129
		}
	},
	{#State 167
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 236,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96
		}
	},
	{#State 168
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 237,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'Literal' => 96,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87
		}
	},
	{#State 169
		ACTIONS => {
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 238,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97
		}
	},
	{#State 170
		ACTIONS => {
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 239
		}
	},
	{#State 171
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'Literal' => 96,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 240
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Literal' => 96,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'SubExpression' => 241,
			'ArrayDereferenced' => 107,
			'Expression' => 128
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 242,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96
		}
	},
	{#State 174
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71
		},
		GOTOS => {
			'SubExpression' => 243,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'Literal' => 96,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90
		}
	},
	{#State 175
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpression' => 244,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'Literal' => 96,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129
		}
	},
	{#State 176
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'SubExpression' => 245,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101
		}
	},
	{#State 177
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 246
		}
	},
	{#State 178
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 247,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96
		}
	},
	{#State 179
		ACTIONS => {
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 248,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'Literal' => 96,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_STRING' => 98,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Literal' => 251,
			'Variable' => 250,
			'VariableOrLiteral' => 249
		}
	},
	{#State 181
		ACTIONS => {
			'OP08_STRING_CAT' => -170,
			'OP12_COMPARE_EQ_NE' => -170,
			"]" => -170,
			'OP19_VARIABLE_ASSIGN' => -170,
			'OP07_MATH_MULT_DIV_MOD' => -170,
			'OP17_LIST_RANGE' => -170,
			'OP19_VARIABLE_ASSIGN_BY' => -170,
			'OP18_TERNARY' => -170,
			'OP02_HASH_THINARROW' => 252,
			'OP09_BITWISE_SHIFT' => -170,
			'OP13_BITWISE_AND' => -170,
			'OP02_ARRAY_THINARROW' => 253,
			")" => -170,
			'OP23_LOGICAL_AND' => -170,
			'OP03_MATH_INC_DEC' => -170,
			'OP02_METHOD_THINARROW' => -170,
			'OP11_COMPARE_LT_GT' => -170,
			'OP04_MATH_POW' => -170,
			'OP24_LOGICAL_OR_XOR' => -170,
			'OP21_LIST_COMMA' => -170,
			'OP16_LOGICAL_OR' => -170,
			'COLON' => -170,
			'OP15_LOGICAL_AND' => -170,
			'OP06_REGEX_MATCH' => -170,
			'OP08_MATH_ADD_SUB' => -170,
			";" => -170,
			'OP14_BITWISE_OR_XOR' => -170,
			"}" => -170
		},
		GOTOS => {
			'VariableRetrieval' => 254
		}
	},
	{#State 182
		DEFAULT => -161
	},
	{#State 183
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 255
		}
	},
	{#State 184
		DEFAULT => -159
	},
	{#State 185
		DEFAULT => -160
	},
	{#State 186
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 187
		ACTIONS => {
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'SubExpression' => 257,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90
		}
	},
	{#State 188
		DEFAULT => -148
	},
	{#State 189
		DEFAULT => -188
	},
	{#State 190
		ACTIONS => {
			"]" => 258
		}
	},
	{#State 191
		DEFAULT => -118
	},
	{#State 192
		DEFAULT => -207
	},
	{#State 193
		ACTIONS => {
			";" => 259
		}
	},
	{#State 194
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => 169,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -110,
			"}" => -110,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -110,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			")" => -110,
			'OP23_LOGICAL_AND' => -110
		}
	},
	{#State 195
		DEFAULT => -144
	},
	{#State 196
		ACTIONS => {
			"filehandle_ref" => 260
		}
	},
	{#State 197
		ACTIONS => {
			";" => 261
		}
	},
	{#State 198
		ACTIONS => {
			"\$TYPED_" => 262
		}
	},
	{#State 199
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 263
		}
	},
	{#State 200
		DEFAULT => -42
	},
	{#State 201
		ACTIONS => {
			"foreach my" => -146,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'OP19_LOOP_CONTROL' => 110,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			"my" => 73,
			'WORD_SCOPED' => 23,
			'WORD' => 94,
			"for my integer" => -146,
			'OP01_NAMED_VOID' => 70,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 102,
			'LBRACE' => 76,
			"while (" => -146,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			"if (" => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'OperatorVoid' => 86,
			'Operation' => 265,
			'SubExpression' => 104,
			'OPTIONAL-40' => 106,
			'VariableDeclaration' => 83,
			'LoopLabel' => 113,
			'Operator' => 90,
			'Statement' => 91,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'Conditional' => 74,
			'Expression' => 93,
			'PLUS-17' => 264,
			'Variable' => 100,
			'PAREN-39' => 99,
			'ArrayReference' => 101,
			'Literal' => 96,
			'VariableModification' => 77,
			'WordScoped' => 97
		}
	},
	{#State 202
		DEFAULT => -40
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		ACTIONS => {
			"our %properties = (" => 268,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 267,
			'Constant' => 266
		}
	},
	{#State 205
		ACTIONS => {
			'WORD' => 270
		},
		GOTOS => {
			'PLUS-49' => 269
		}
	},
	{#State 206
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP04_MATH_POW' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			"}" => -85,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			"]" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP08_STRING_CAT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP18_TERNARY' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP23_LOGICAL_AND' => -85,
			")" => -85
		}
	},
	{#State 207
		DEFAULT => -187
	},
	{#State 208
		ACTIONS => {
			"]" => -183,
			")" => -183,
			'OP21_LIST_COMMA' => 272,
			";" => -183
		},
		GOTOS => {
			'PAREN-47' => 271
		}
	},
	{#State 209
		DEFAULT => -122
	},
	{#State 210
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -186,
			")" => -186,
			'OP23_LOGICAL_AND' => 171,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP21_LIST_COMMA' => -186,
			'OP16_LOGICAL_OR' => 169,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -186,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => 173
		}
	},
	{#State 211
		DEFAULT => -203
	},
	{#State 212
		DEFAULT => -204
	},
	{#State 213
		ACTIONS => {
			";" => 274,
			'OP19_VARIABLE_ASSIGN' => 273
		}
	},
	{#State 214
		ACTIONS => {
			'WORD_SCOPED' => -194,
			"my" => 116,
			'WORD' => -194,
			'LPAREN' => -194,
			"%{" => -194,
			'OP05_LOGICAL_NEG' => -194,
			'LITERAL_STRING' => -194,
			'OP01_NAMED' => -194,
			'OP01_CLOSE' => -194,
			'OP10_NAMED_UNARY' => -194,
			'LBRACE' => -194,
			'LBRACKET' => -194,
			'LITERAL_NUMBER' => -194,
			"undef" => -194,
			'OP10_STRINGIFY_UNARY' => -194,
			'VARIABLE_SYMBOL' => -194,
			'OP03_MATH_INC_DEC' => -194,
			"\@{" => -194,
			'OP05_MATH_NEG_LPAREN' => -194,
			'OP01_OPEN' => -194,
			'OP22_LOGICAL_NEG' => -194
		},
		GOTOS => {
			'OPTIONAL-51' => 275,
			'TypeInner' => 276
		}
	},
	{#State 215
		ACTIONS => {
			"}" => 279,
			'OP21_LIST_COMMA' => 278
		},
		GOTOS => {
			'PAREN-52' => 277
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 280
		}
	},
	{#State 217
		ACTIONS => {
			'WORD' => 24,
			"my" => 116,
			'WORD_SCOPED' => 23,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'OP01_NAMED' => 124,
			'OP01_QW' => 123,
			'LITERAL_STRING' => 98,
			'KEYS_OR_VALUES' => 125,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'ListElements' => 282,
			'WordScoped' => 97,
			'TypeInner' => 131,
			'Literal' => 96,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'ListElement' => 127,
			'SubExpression' => 126,
			'Expression' => 128,
			'ArrayDereferenced' => 107
		}
	},
	{#State 218
		DEFAULT => -101
	},
	{#State 219
		DEFAULT => -191
	},
	{#State 220
		DEFAULT => -192
	},
	{#State 221
		DEFAULT => -93
	},
	{#State 222
		DEFAULT => -141
	},
	{#State 223
		ACTIONS => {
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_QW' => 123,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			"my" => 116,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'ListElement' => 127,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'ListElements' => 283,
			'TypeInner' => 131,
			'Literal' => 96
		}
	},
	{#State 224
		ACTIONS => {
			'OP21_LIST_COMMA' => 284
		}
	},
	{#State 225
		DEFAULT => -125
	},
	{#State 226
		ACTIONS => {
			")" => 285
		}
	},
	{#State 227
		ACTIONS => {
			'LPAREN' => 286
		}
	},
	{#State 228
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -142,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169
		}
	},
	{#State 229
		DEFAULT => -143
	},
	{#State 230
		ACTIONS => {
			";" => 287
		}
	},
	{#State 231
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP23_LOGICAL_AND' => 171,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			";" => 288,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 169
		}
	},
	{#State 232
		ACTIONS => {
			";" => 289
		}
	},
	{#State 233
		ACTIONS => {
			";" => 290
		}
	},
	{#State 234
		DEFAULT => -94
	},
	{#State 235
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => -96,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP13_BITWISE_AND' => -96,
			")" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP17_LIST_RANGE' => -96,
			'OP18_TERNARY' => -96
		}
	},
	{#State 236
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169,
			'OP21_LIST_COMMA' => -112,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			"}" => -112,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -112,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP23_LOGICAL_AND' => 171,
			")" => -112
		}
	},
	{#State 237
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => -102,
			"}" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			";" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -102,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => -102,
			'OP18_TERNARY' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => -102,
			'OP23_LOGICAL_AND' => -102,
			")" => -102
		}
	},
	{#State 238
		ACTIONS => {
			'OP18_TERNARY' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -107,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP23_LOGICAL_AND' => -107,
			")" => -107,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			"}" => -107,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -107,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => 173
		}
	},
	{#State 239
		ACTIONS => {
			'OP23_LOGICAL_AND' => -104,
			")" => -104,
			'OP13_BITWISE_AND' => -104,
			'OP09_BITWISE_SHIFT' => 176,
			'OP18_TERNARY' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -104,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			"}" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			";" => -104,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 240
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			")" => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			"]" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => 174,
			"}" => -111,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => 169
		}
	},
	{#State 241
		ACTIONS => {
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => 173,
			"}" => -108,
			'OP14_BITWISE_OR_XOR' => 174,
			";" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169,
			'OP21_LIST_COMMA' => -108,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => -108,
			")" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -108,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP18_TERNARY' => -108,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 242
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => 174,
			"}" => -106,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			"]" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP17_LIST_RANGE' => -106,
			'OP18_TERNARY' => -106,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			")" => -106,
			'OP23_LOGICAL_AND' => -106
		}
	},
	{#State 243
		ACTIONS => {
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			";" => -105,
			"}" => -105,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => -105,
			'OP18_TERNARY' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -105,
			")" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170
		}
	},
	{#State 244
		ACTIONS => {
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP23_LOGICAL_AND' => -91,
			")" => -91,
			"]" => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP08_STRING_CAT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP18_TERNARY' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"}" => -91,
			";" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91
		}
	},
	{#State 245
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP08_STRING_CAT' => 178,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP23_LOGICAL_AND' => -98,
			")" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			'OP15_LOGICAL_AND' => -98,
			"}" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			";" => -98
		}
	},
	{#State 246
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => -95,
			";" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP08_STRING_CAT' => -95,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			")" => -95,
			'OP23_LOGICAL_AND' => -95
		}
	},
	{#State 247
		ACTIONS => {
			'OP18_TERNARY' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => -97,
			'OP08_STRING_CAT' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP23_LOGICAL_AND' => -97,
			")" => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => -97,
			"}" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => -97
		}
	},
	{#State 248
		ACTIONS => {
			"]" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP17_LIST_RANGE' => -103,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => -103,
			'OP23_LOGICAL_AND' => -103,
			")" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			"}" => -103,
			";" => -103,
			'OP14_BITWISE_OR_XOR' => -103
		}
	},
	{#State 249
		ACTIONS => {
			'COLON' => 291
		}
	},
	{#State 250
		DEFAULT => -210
	},
	{#State 251
		DEFAULT => -211
	},
	{#State 252
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 293
		},
		GOTOS => {
			'SubExpression' => 292,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101
		}
	},
	{#State 253
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 294
		}
	},
	{#State 254
		DEFAULT => -168
	},
	{#State 255
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 256
		ACTIONS => {
			'LPAREN' => 296
		}
	},
	{#State 257
		ACTIONS => {
			'OP16_LOGICAL_OR' => 169,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			")" => 297,
			'OP23_LOGICAL_AND' => 171,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176
		}
	},
	{#State 258
		DEFAULT => -190
	},
	{#State 259
		DEFAULT => -124
	},
	{#State 260
		ACTIONS => {
			'FH_REF_SYMBOL' => 298
		}
	},
	{#State 261
		DEFAULT => -41
	},
	{#State 262
		ACTIONS => {
			'WORD' => 299
		}
	},
	{#State 263
		ACTIONS => {
			'VARIABLE_SYMBOL' => 300
		}
	},
	{#State 264
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'LBRACKET' => 108,
			"foreach my" => -146,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP19_LOOP_CONTROL' => 110,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP01_NAMED_VOID' => 70,
			"}" => 301,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			"my" => 73,
			'WORD_SCOPED' => 23,
			"for my integer" => -146,
			'WORD' => 94,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			"while (" => -146,
			'LBRACE' => 76,
			"if (" => 78,
			'LITERAL_STRING' => 98,
			'OP01_PRINT' => 102,
			'OP01_NAMED' => 79
		},
		GOTOS => {
			'Conditional' => 74,
			'Expression' => 93,
			'ArrayReference' => 101,
			'PAREN-39' => 99,
			'Variable' => 100,
			'Literal' => 96,
			'WordScoped' => 97,
			'VariableModification' => 77,
			'ArrayDereferenced' => 107,
			'OperatorVoid' => 86,
			'OPTIONAL-40' => 106,
			'SubExpression' => 104,
			'Operation' => 302,
			'VariableDeclaration' => 83,
			'LoopLabel' => 113,
			'Statement' => 91,
			'Operator' => 90,
			'HashReference' => 112,
			'HashDereferenced' => 87
		}
	},
	{#State 265
		DEFAULT => -45
	},
	{#State 266
		DEFAULT => -55
	},
	{#State 267
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our" => -58,
			"our %properties_class = (" => 305
		},
		GOTOS => {
			'OPTIONAL-23' => 304,
			'PropertiesClass' => 303
		}
	},
	{#State 268
		ACTIONS => {
			"## no critic qw(" => 8,
			")" => 307
		},
		GOTOS => {
			'Critic' => 306
		}
	},
	{#State 269
		ACTIONS => {
			'WORD' => 308,
			")" => 309
		}
	},
	{#State 270
		DEFAULT => -182
	},
	{#State 271
		DEFAULT => -179
	},
	{#State 272
		ACTIONS => {
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'KEYS_OR_VALUES' => 125,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'ListElement' => 310,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101,
			'TypeInner' => 131,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 126
		}
	},
	{#State 273
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'LITERAL_STRING' => 98,
			'STDIN' => 229,
			'OP01_NAMED' => 124,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpressionOrStdin' => 311,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 228,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Literal' => 96
		}
	},
	{#State 274
		DEFAULT => -174
	},
	{#State 275
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76
		},
		GOTOS => {
			'SubExpression' => 312,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'Literal' => 96,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Operator' => 90,
			'Variable' => 129,
			'ArrayReference' => 101
		}
	},
	{#State 276
		DEFAULT => -193
	},
	{#State 277
		DEFAULT => -200
	},
	{#State 278
		ACTIONS => {
			"%{" => 72,
			'WORD' => 139
		},
		GOTOS => {
			'HashEntry' => 313,
			'HashDereferenced' => 141
		}
	},
	{#State 279
		DEFAULT => -202
	},
	{#State 280
		DEFAULT => -154,
		GOTOS => {
			'STAR-42' => 314
		}
	},
	{#State 281
		ACTIONS => {
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'OP19_LOOP_CONTROL' => 110,
			"foreach my" => -146,
			'LITERAL_NUMBER' => 84,
			"undef" => 109,
			'LBRACKET' => 108,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 102,
			'LITERAL_STRING' => 98,
			"if (" => 78,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			"while (" => -146,
			'LBRACE' => 76,
			"for my integer" => -146,
			'WORD' => 94,
			'WORD_SCOPED' => 23,
			"my" => 73,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'OP01_NAMED_VOID' => 70
		},
		GOTOS => {
			'VariableDeclaration' => 83,
			'SubExpression' => 104,
			'OPTIONAL-40' => 106,
			'Operation' => 315,
			'OperatorVoid' => 86,
			'ArrayDereferenced' => 107,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'Statement' => 91,
			'Operator' => 90,
			'LoopLabel' => 113,
			'PLUS-45' => 316,
			'Expression' => 93,
			'Conditional' => 74,
			'WordScoped' => 97,
			'VariableModification' => 77,
			'Literal' => 96,
			'ArrayReference' => 101,
			'PAREN-39' => 99,
			'Variable' => 100
		}
	},
	{#State 282
		ACTIONS => {
			";" => 317
		}
	},
	{#State 283
		ACTIONS => {
			")" => 318
		}
	},
	{#State 284
		ACTIONS => {
			"my" => 116,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LITERAL_STRING' => 98,
			'OP01_QW' => 123,
			'OP01_NAMED' => 124,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76,
			'KEYS_OR_VALUES' => 125,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'SubExpression' => 126,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'WordScoped' => 97,
			'HashReference' => 112,
			'ListElements' => 319,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'ListElement' => 127
		}
	},
	{#State 285
		DEFAULT => -130
	},
	{#State 286
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			")" => -128,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'LBRACE' => 76,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP01_QW' => 123,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			"my" => 116,
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'ListElement' => 127,
			'OPTIONAL-38' => 321,
			'HashReference' => 112,
			'ListElements' => 320,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131
		}
	},
	{#State 287
		DEFAULT => -176
	},
	{#State 288
		DEFAULT => -177
	},
	{#State 289
		DEFAULT => -121
	},
	{#State 290
		DEFAULT => -120
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 98,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Literal' => 251,
			'Variable' => 250,
			'VariableOrLiteral' => 322
		}
	},
	{#State 292
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 173,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 166,
			"}" => 323,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP16_LOGICAL_OR' => 169
		}
	},
	{#State 293
		ACTIONS => {
			"}" => 324,
			'LPAREN' => -205
		}
	},
	{#State 294
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 169,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			"]" => 325,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP23_LOGICAL_AND' => 171
		}
	},
	{#State 295
		ACTIONS => {
			'LPAREN' => 326
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'LPAREN' => 92,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP22_LOGICAL_NEG' => 111,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'SubExpression' => 327,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'HashReference' => 112,
			'WordScoped' => 97,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129
		}
	},
	{#State 297
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 328
		}
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 329
		}
	},
	{#State 299
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 330
		}
	},
	{#State 300
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 331
		}
	},
	{#State 301
		ACTIONS => {
			";" => 332
		}
	},
	{#State 302
		DEFAULT => -44
	},
	{#State 303
		DEFAULT => -57
	},
	{#State 304
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 333
		}
	},
	{#State 305
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 334
		}
	},
	{#State 306
		ACTIONS => {
			'WORD' => 336,
			"%{" => 72
		},
		GOTOS => {
			'HashEntryTyped' => 337,
			'HashDereferenced' => 335
		}
	},
	{#State 307
		ACTIONS => {
			";" => 338
		}
	},
	{#State 308
		DEFAULT => -181
	},
	{#State 309
		DEFAULT => -184
	},
	{#State 310
		DEFAULT => -178
	},
	{#State 311
		ACTIONS => {
			";" => 339
		}
	},
	{#State 312
		ACTIONS => {
			'OP23_LOGICAL_AND' => 171,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			"}" => -195,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP16_LOGICAL_OR' => 169,
			'OP21_LIST_COMMA' => -195,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168
		}
	},
	{#State 313
		DEFAULT => -199
	},
	{#State 314
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -157,
			"foreach my" => -157,
			'LITERAL_NUMBER' => -157,
			'OP10_STRINGIFY_UNARY' => -157,
			'' => -157,
			"\@{" => -157,
			'OP03_MATH_INC_DEC' => -157,
			'OP01_NAMED' => -157,
			'OP01_CLOSE' => -157,
			'LBRACE' => -157,
			"if (" => -157,
			"my" => -157,
			"elsif (" => 343,
			"for my integer" => -157,
			'OP01_NAMED_VOID' => -157,
			'OP05_LOGICAL_NEG' => -157,
			"%{" => -157,
			'OP01_OPEN' => -157,
			'OP22_LOGICAL_NEG' => -157,
			'LBRACKET' => -157,
			"undef" => -157,
			'OP19_LOOP_CONTROL' => -157,
			'VARIABLE_SYMBOL' => -157,
			'LITERAL_STRING' => -157,
			'OP01_PRINT' => -157,
			'OP10_NAMED_UNARY' => -157,
			"while (" => -157,
			'WORD_SCOPED' => -157,
			'WORD' => -157,
			"}" => -157,
			'LPAREN' => -157,
			"else" => 340
		},
		GOTOS => {
			'OPTIONAL-44' => 342,
			'PAREN-41' => 341,
			'PAREN-43' => 344
		}
	},
	{#State 315
		DEFAULT => -166
	},
	{#State 316
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			"}" => 345,
			'LPAREN' => 92,
			'OP01_NAMED_VOID' => 70,
			'WORD' => 94,
			"for my integer" => -146,
			'WORD_SCOPED' => 23,
			"my" => 73,
			"if (" => 78,
			'LBRACE' => 76,
			"while (" => -146,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 102,
			'LITERAL_STRING' => 98,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP19_LOOP_CONTROL' => 110,
			"foreach my" => -146,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'OperatorVoid' => 86,
			'ArrayDereferenced' => 107,
			'VariableDeclaration' => 83,
			'Operation' => 346,
			'OPTIONAL-40' => 106,
			'SubExpression' => 104,
			'Operator' => 90,
			'Statement' => 91,
			'LoopLabel' => 113,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'Expression' => 93,
			'Conditional' => 74,
			'Variable' => 100,
			'PAREN-39' => 99,
			'ArrayReference' => 101,
			'VariableModification' => 77,
			'WordScoped' => 97,
			'Literal' => 96
		}
	},
	{#State 317
		DEFAULT => -123
	},
	{#State 318
		DEFAULT => -84
	},
	{#State 319
		ACTIONS => {
			")" => 347
		}
	},
	{#State 320
		DEFAULT => -127
	},
	{#State 321
		ACTIONS => {
			")" => 348
		}
	},
	{#State 322
		DEFAULT => -109
	},
	{#State 323
		DEFAULT => -172
	},
	{#State 324
		DEFAULT => -173
	},
	{#State 325
		DEFAULT => -171
	},
	{#State 326
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'KEYS_OR_VALUES' => 125,
			'LITERAL_STRING' => 98,
			'OP01_QW' => 123,
			'OP01_NAMED' => 124,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD_SCOPED' => 23,
			"my" => 116,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90,
			'ListElement' => 127,
			'HashReference' => 112,
			'WordScoped' => 97,
			'ListElements' => 349,
			'HashDereferenced' => 87,
			'Literal' => 96,
			'TypeInner' => 131,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 126
		}
	},
	{#State 327
		ACTIONS => {
			'OP23_LOGICAL_AND' => 171,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 350,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP16_LOGICAL_OR' => 169,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => 167
		}
	},
	{#State 328
		DEFAULT => -164
	},
	{#State 329
		ACTIONS => {
			'LITERAL_STRING' => 351
		}
	},
	{#State 330
		DEFAULT => -209
	},
	{#State 331
		ACTIONS => {
			'OP21_LIST_COMMA' => 354,
			")" => 352
		},
		GOTOS => {
			'PAREN-18' => 353
		}
	},
	{#State 332
		DEFAULT => -46
	},
	{#State 333
		ACTIONS => {
			'LITERAL_NUMBER' => 359,
			"our" => 358
		},
		GOTOS => {
			'Subroutine' => 357,
			'MethodOrSubroutine' => 355,
			'Method' => 356
		}
	},
	{#State 334
		ACTIONS => {
			'WORD' => 336,
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 335,
			'HashEntryTyped' => 360
		}
	},
	{#State 335
		DEFAULT => -198
	},
	{#State 336
		ACTIONS => {
			'OP20_HASH_FATARROW' => 361
		}
	},
	{#State 337
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 362
		}
	},
	{#State 338
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 363
		}
	},
	{#State 339
		DEFAULT => -175
	},
	{#State 340
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 364
		}
	},
	{#State 341
		DEFAULT => -153
	},
	{#State 342
		DEFAULT => -158
	},
	{#State 343
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LITERAL_STRING' => 98,
			'OP01_NAMED' => 124,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpression' => 365,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'Literal' => 96,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'ArrayReference' => 101,
			'Variable' => 129,
			'Operator' => 90
		}
	},
	{#State 344
		DEFAULT => -156
	},
	{#State 345
		DEFAULT => -167
	},
	{#State 346
		DEFAULT => -165
	},
	{#State 347
		DEFAULT => -86
	},
	{#State 348
		DEFAULT => -131
	},
	{#State 349
		ACTIONS => {
			")" => 366
		}
	},
	{#State 350
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108,
			"undef" => 109,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			'LBRACE' => 76
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Operator' => 90,
			'Variable' => 129,
			'Literal' => 96,
			'WordScoped' => 97,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'ArrayDereferenced' => 107,
			'Expression' => 128,
			'SubExpression' => 367
		}
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 368
		}
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 369
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		ACTIONS => {
			"my" => 370
		}
	},
	{#State 355
		DEFAULT => -59
	},
	{#State 356
		DEFAULT => -80
	},
	{#State 357
		DEFAULT => -81
	},
	{#State 358
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 371
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 359
		ACTIONS => {
			";" => 372
		}
	},
	{#State 360
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 373
		}
	},
	{#State 361
		ACTIONS => {
			"my" => 116
		},
		GOTOS => {
			'TypeInner' => 374
		}
	},
	{#State 362
		ACTIONS => {
			")" => 377,
			'OP21_LIST_COMMA' => 375
		},
		GOTOS => {
			'PAREN-25' => 376
		}
	},
	{#State 363
		DEFAULT => -66
	},
	{#State 364
		DEFAULT => -155
	},
	{#State 365
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 169,
			'OP15_LOGICAL_AND' => 173,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			")" => 378
		}
	},
	{#State 366
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 367
		ACTIONS => {
			'OP16_LOGICAL_OR' => 169,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP18_TERNARY' => -108,
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP23_LOGICAL_AND' => -108,
			")" => 380,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176
		}
	},
	{#State 368
		ACTIONS => {
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LBRACE' => 76,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'LPAREN' => 92,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			"undef" => 109,
			'LBRACKET' => 108,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 81,
			"\@{" => 82,
			'VARIABLE_SYMBOL' => 105,
			'OP10_STRINGIFY_UNARY' => 80
		},
		GOTOS => {
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'WordScoped' => 97,
			'Literal' => 96,
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 381
		}
	},
	{#State 369
		ACTIONS => {
			"\@_;" => 382
		}
	},
	{#State 370
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 383
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 372
		DEFAULT => -61
	},
	{#State 373
		ACTIONS => {
			")" => 387,
			'OP21_LIST_COMMA' => 386
		},
		GOTOS => {
			'PAREN-27' => 385
		}
	},
	{#State 374
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 98,
			'LPAREN' => 92,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 71,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereferenced' => 107,
			'SubExpression' => 388,
			'Variable' => 129,
			'Operator' => 90,
			'ArrayReference' => 101,
			'HashDereferenced' => 87,
			'WordScoped' => 97,
			'HashReference' => 112,
			'Literal' => 96
		}
	},
	{#State 375
		ACTIONS => {
			'WORD' => 336,
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 335,
			'HashEntryTyped' => 389
		}
	},
	{#State 376
		DEFAULT => -63
	},
	{#State 377
		ACTIONS => {
			";" => 390
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 379
		DEFAULT => -163
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 381
		ACTIONS => {
			'OP23_LOGICAL_AND' => -87,
			")" => -87,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 176,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 180,
			"]" => -87,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP08_STRING_CAT' => 178,
			'OP12_COMPARE_EQ_NE' => 179,
			"}" => -87,
			";" => -87,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP15_LOGICAL_AND' => 173,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP16_LOGICAL_OR' => 169,
			'OP21_LIST_COMMA' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP04_MATH_POW' => 175,
			'OP11_COMPARE_LT_GT' => 168
		}
	},
	{#State 382
		DEFAULT => -50
	},
	{#State 383
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 394
		}
	},
	{#State 385
		DEFAULT => -68
	},
	{#State 386
		ACTIONS => {
			"%{" => 72,
			'WORD' => 336
		},
		GOTOS => {
			'HashEntryTyped' => 395,
			'HashDereferenced' => 335
		}
	},
	{#State 387
		ACTIONS => {
			";" => 396
		}
	},
	{#State 388
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP11_COMPARE_LT_GT' => 168,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 169,
			'OP21_LIST_COMMA' => -197,
			'OP08_MATH_ADD_SUB' => 166,
			'OP06_REGEX_MATCH' => 165,
			'OP15_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 177,
			'OP12_COMPARE_EQ_NE' => 179,
			'OP08_STRING_CAT' => 178,
			'OP18_TERNARY' => 180,
			'OP17_LIST_RANGE' => 172,
			'OP09_BITWISE_SHIFT' => 176,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 171,
			")" => -197
		}
	},
	{#State 389
		DEFAULT => -62
	},
	{#State 390
		DEFAULT => -65
	},
	{#State 391
		DEFAULT => -152
	},
	{#State 392
		DEFAULT => -162
	},
	{#State 393
		DEFAULT => -47
	},
	{#State 394
		ACTIONS => {
			'WORD_SCOPED' => -72,
			"my" => -72,
			"for my integer" => -72,
			'WORD' => -72,
			'OP01_NAMED_VOID' => -72,
			'LPAREN' => -72,
			"%{" => -72,
			'OP05_LOGICAL_NEG' => -72,
			'LITERAL_STRING' => -72,
			"( my" => 397,
			'OP01_NAMED' => -72,
			'OP01_PRINT' => -72,
			'OP01_CLOSE' => -72,
			'OP10_NAMED_UNARY' => -72,
			'LBRACE' => -72,
			"while (" => -72,
			"if (" => -72,
			"undef" => -72,
			'LITERAL_NUMBER' => -72,
			'LBRACKET' => -72,
			"foreach my" => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP03_MATH_INC_DEC' => -72,
			"\@{" => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			'OP01_OPEN' => -72,
			'OP22_LOGICAL_NEG' => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 398,
			'MethodArguments' => 399
		}
	},
	{#State 395
		DEFAULT => -67
	},
	{#State 396
		DEFAULT => -70
	},
	{#State 397
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 400
		}
	},
	{#State 398
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 110,
			'LBRACKET' => 108,
			"foreach my" => -146,
			"undef" => 109,
			'LITERAL_NUMBER' => 84,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP22_LOGICAL_NEG' => 111,
			"for my integer" => -146,
			'WORD' => 94,
			"my" => 73,
			'WORD_SCOPED' => 23,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'OP01_NAMED_VOID' => 70,
			'OP01_PRINT' => 102,
			'OP01_NAMED' => 79,
			'LITERAL_STRING' => 98,
			"if (" => 78,
			'OP01_CLOSE' => 75,
			'OP10_NAMED_UNARY' => 95,
			"while (" => -146,
			'LBRACE' => 76
		},
		GOTOS => {
			'LoopLabel' => 113,
			'Statement' => 91,
			'Operator' => 90,
			'HashReference' => 112,
			'HashDereferenced' => 87,
			'ArrayDereferenced' => 107,
			'OperatorVoid' => 86,
			'SubExpression' => 104,
			'OPTIONAL-40' => 106,
			'Operation' => 402,
			'VariableDeclaration' => 83,
			'ArrayReference' => 101,
			'PAREN-39' => 99,
			'Variable' => 100,
			'Literal' => 96,
			'PLUS-30' => 401,
			'WordScoped' => 97,
			'VariableModification' => 77,
			'Conditional' => 74,
			'Expression' => 93
		}
	},
	{#State 399
		DEFAULT => -71
	},
	{#State 400
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 403
		}
	},
	{#State 401
		ACTIONS => {
			"if (" => 78,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 75,
			'LBRACE' => 76,
			"while (" => -146,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 102,
			'LITERAL_STRING' => 98,
			"}" => 405,
			'LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 71,
			"%{" => 72,
			'OP01_NAMED_VOID' => 70,
			"for my integer" => -146,
			'WORD' => 94,
			'WORD_SCOPED' => 23,
			"my" => 73,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 88,
			"\@{" => 82,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_STRINGIFY_UNARY' => 80,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL' => 110,
			"foreach my" => -146,
			'LBRACKET' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Operation' => 404,
			'OPTIONAL-40' => 106,
			'SubExpression' => 104,
			'VariableDeclaration' => 83,
			'ArrayDereferenced' => 107,
			'OperatorVoid' => 86,
			'HashDereferenced' => 87,
			'HashReference' => 112,
			'LoopLabel' => 113,
			'Operator' => 90,
			'Statement' => 91,
			'Conditional' => 74,
			'Expression' => 93,
			'Literal' => 96,
			'VariableModification' => 77,
			'WordScoped' => 97,
			'PAREN-39' => 99,
			'Variable' => 100,
			'ArrayReference' => 101
		}
	},
	{#State 402
		DEFAULT => -74
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 406,
			")" => 408
		},
		GOTOS => {
			'PAREN-31' => 407
		}
	},
	{#State 404
		DEFAULT => -73
	},
	{#State 405
		ACTIONS => {
			";" => 409
		}
	},
	{#State 406
		ACTIONS => {
			"my" => 410
		}
	},
	{#State 407
		DEFAULT => -77
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 409
		DEFAULT => -75
	},
	{#State 410
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 411
		ACTIONS => {
			"\@_;" => 413
		}
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 413
		DEFAULT => -79
	},
	{#State 414
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5750 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5757 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5764 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5782 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5814 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5821 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5828 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5835 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5842 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5849 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5913 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5956 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5963 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5970 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5984 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5991 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6002 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6038 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6045 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6063 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6280 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6287 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6351 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6372 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6383 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6394 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6405 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6416 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6427 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6438 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6449 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6471 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6482 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6493 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6504 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6515 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6526 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6537 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6548 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6559 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6570 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6581 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6592 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6614 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6753 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6878 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6999 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_142
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 4,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_158
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_159
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_162
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_163
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_164
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_167
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7277 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_170
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_171
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_172
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_174
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_175
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_176
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7354 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_177
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7379 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7393 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_183
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_184
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_185
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_190
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_191
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_192
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_195
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_196
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_197
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_198
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-52', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_202
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_203
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7603 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_204
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_205
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7625 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_207
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule Type_208
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_209
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_211
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_212
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7702 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_213
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7713 lib/RPerl/Grammar.pm
	]
],
#line 7716 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         'OperatorVoid_124', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'SubExpression_141', 
         'SubExpressionOrStdin_142', 
         'SubExpressionOrStdin_143', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_147', 
         'Statement_148', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_158', 
         'Loop_159', 
         'Loop_160', 
         'Loop_161', 
         'LoopFor_162', 
         'LoopForEach_163', 
         'LoopWhile_164', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_167', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_170', 
         'VariableRetrieval_171', 
         'VariableRetrieval_172', 
         'VariableRetrieval_173', 
         'VariableDeclaration_174', 
         'VariableDeclaration_175', 
         'VariableModification_176', 
         'VariableModification_177', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_183', 
         'ListElements_184', 
         'ListElement_185', 
         'ListElement_186', 
         'ListElement_187', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_190', 
         'ArrayDereferenced_191', 
         'ArrayDereferenced_192', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_195', 
         'HashEntry_196', 
         'HashEntryTyped_197', 
         'HashEntryTyped_198', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_202', 
         'HashDereferenced_203', 
         'HashDereferenced_204', 
         'WordScoped_205', 
         'WordScoped_206', 
         'LoopLabel_207', 
         'Type_208', 
         'TypeInner_209', 
         'VariableOrLiteral_210', 
         'VariableOrLiteral_211', 
         'Literal_212', 
         'Literal_213', );
  $self;
}

#line 191 "lib/RPerl/Grammar.eyp"


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


#line 7978 lib/RPerl/Grammar.pm



1;
