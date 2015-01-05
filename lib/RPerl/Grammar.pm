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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|package|elsif\ \(|while\ \(|\=\ sub\ \{|\$TYPED_|undef|if\ \(|else|\(\ my|our|use|qw\(|\@_\;|\@\{|\%\{|my|\;|\}|\)|\])}gc and return ($1, $1);

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
      /\G(\*|\/|\%|\x)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(\sx\s)/gc and return ('OP07_STRING_REPEAT', $1);
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
			'SHEBANG' => 3,
			"package" => -20,
			"## no critic qw(" => 5
		},
		GOTOS => {
			'CompileUnit' => 7,
			'Program' => 8,
			'ModuleHeader' => 9,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 2,
			'Critic' => 4,
			'PLUS-2' => 6
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 5,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-14' => 14
		}
	},
	{#State 6
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 5,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 15,
			'ModuleHeader' => 9,
			'Critic' => 4
		}
	},
	{#State 7
		ACTIONS => {
			'' => 16
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => -25,
			"use parent qw(" => 20,
			"use constant" => -25,
			"use" => -25,
			"our" => -25
		},
		GOTOS => {
			'Module' => 17,
			'Package' => 19,
			'STAR-10' => 21,
			'Class' => 18
		}
	},
	{#State 10
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			"use strict;" => 26
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 13
		DEFAULT => -35
	},
	{#State 14
		ACTIONS => {
			")" => 28,
			'WORD' => 27
		}
	},
	{#State 15
		DEFAULT => -2
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		DEFAULT => -23
	},
	{#State 19
		DEFAULT => -22
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 21
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"## no critic qw(" => 5,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 31,
			'Critic' => 30
		}
	},
	{#State 22
		DEFAULT => -206
	},
	{#State 23
		DEFAULT => -207
	},
	{#State 24
		ACTIONS => {
			";" => 32
		}
	},
	{#State 25
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 33
		}
	},
	{#State 26
		ACTIONS => {
			"use warnings;" => 34
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
			")" => 35
		}
	},
	{#State 30
		DEFAULT => -24
	},
	{#State 31
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 38
		},
		GOTOS => {
			'Include' => 37,
			'STAR-12' => 36
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 26
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LBRACE' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"our" => -11,
			'OP01_PRINT' => -11,
			'OP01_OPEN' => -11,
			"use" => -11,
			"## no critic qw(" => 5,
			'OP10_STRINGIFY_UNARY' => -11,
			"while (" => -11,
			"if (" => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID' => -11,
			"use constant" => -11,
			'VARIABLE_SYMBOL' => -11,
			"undef" => -11,
			"for my integer" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"my" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"foreach my" => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			'LPAREN' => -11,
			"%{" => -11,
			"\@{" => -11,
			'WORD_SCOPED' => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 40
		}
	},
	{#State 34
		ACTIONS => {
			"use RPerl;" => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			"our" => 48,
			"use constant" => 46
		},
		GOTOS => {
			'Constant' => 44,
			'Subroutine' => 47,
			'PLUS-13' => 45
		}
	},
	{#State 37
		DEFAULT => -26
	},
	{#State 38
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			"use" => 38,
			'OP01_OPEN' => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_VOID' => -13,
			'VARIABLE_SYMBOL' => -13,
			"use constant" => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			"if (" => -13,
			"while (" => -13,
			'LITERAL_STRING' => -13,
			'OP01_CLOSE' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LBRACKET' => -13,
			'LBRACE' => -13,
			'OP01_PRINT' => -13,
			"our" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"\@{" => -13,
			'LPAREN' => -13,
			"%{" => -13,
			'WORD_SCOPED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"my" => -13,
			"undef" => -13,
			"for my integer" => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			"foreach my" => -13,
			'LITERAL_NUMBER' => -13
		},
		GOTOS => {
			'STAR-6' => 50,
			'Include' => 51
		}
	},
	{#State 42
		ACTIONS => {
			"our" => 52
		}
	},
	{#State 43
		ACTIONS => {
			"use" => 38
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			"our" => 48,
			'LITERAL_NUMBER' => 54
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 46
		ACTIONS => {
			'WORD' => 56
		}
	},
	{#State 47
		DEFAULT => -31
	},
	{#State 48
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 49
		ACTIONS => {
			"qw(" => 60,
			";" => 59
		}
	},
	{#State 50
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => -15,
			'WORD_SCOPED' => -15,
			"if (" => -15,
			"while (" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_NAMED' => -15,
			"use constant" => 46,
			'VARIABLE_SYMBOL' => -15,
			'OP01_OPEN' => -15,
			'LPAREN' => -15,
			"%{" => -15,
			"\@{" => -15,
			'OP22_LOGICAL_NEG' => -15,
			"our" => -15,
			'OP10_NAMED_UNARY' => -15,
			"foreach my" => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD' => -15,
			'OP01_PRINT' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"undef" => -15,
			'LBRACKET' => -15,
			'LBRACE' => -15,
			"for my integer" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_STRING' => -15,
			"my" => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 61
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 63
		}
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 64
		}
	},
	{#State 54
		ACTIONS => {
			";" => 65
		}
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 58
		DEFAULT => -209
	},
	{#State 59
		DEFAULT => -39
	},
	{#State 60
		ACTIONS => {
			'WORD' => 68
		},
		GOTOS => {
			'PLUS-15' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			'OP01_NAMED' => 107,
			'OP01_NAMED_VOID' => 108,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"while (" => -147,
			"if (" => 109,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 77,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'OP19_LOOP_CONTROL' => 100,
			"for my integer" => -147,
			'LBRACE' => 99,
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			"our" => 48,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73
		},
		GOTOS => {
			'VariableModification' => 83,
			'PLUS-8' => 82,
			'OPTIONAL-40' => 106,
			'HashDereferenced' => 81,
			'Variable' => 103,
			'Operation' => 105,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'PAREN-39' => 112,
			'Operator' => 111,
			'Statement' => 86,
			'ArrayReference' => 84,
			'Expression' => 71,
			'OperatorVoid' => 72,
			'LoopLabel' => 94,
			'Subroutine' => 75,
			'SubExpression' => 92,
			'Conditional' => 90,
			'VariableDeclaration' => 79,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		DEFAULT => -33
	},
	{#State 64
		ACTIONS => {
			"use constant" => -54,
			"## no critic qw(" => 5,
			"our %properties = (" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 115,
			'STAR-21' => 116
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 117
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 119
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			")" => 120,
			'WORD' => 121
		}
	},
	{#State 70
		ACTIONS => {
			'COLON' => -208,
			'LPAREN' => -206
		}
	},
	{#State 71
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP07_STRING_REPEAT' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP04_MATH_POW' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP18_TERNARY' => -133,
			'OP06_REGEX_MATCH' => -133,
			";" => 122,
			'OP08_STRING_CAT' => -133
		}
	},
	{#State 72
		DEFAULT => -150
	},
	{#State 73
		ACTIONS => {
			'OP08_STRING_CAT' => -101,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			";" => -101,
			'OP05_LOGICAL_NEG' => 101,
			'OP06_REGEX_MATCH' => -101,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP18_TERNARY' => -101,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP01_OPEN' => 113,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP10_STRINGIFY_UNARY' => 110,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP24_LOGICAL_OR_XOR' => -101,
			"undef" => 80,
			"]" => -101,
			"}" => -101,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_NUMBER' => 74,
			'OP16_LOGICAL_OR' => -101,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			'OP12_COMPARE_EQ_NE' => -101,
			")" => -101,
			"%{" => 87,
			'OP23_LOGICAL_AND' => -101,
			'LPAREN' => 89,
			'OP04_MATH_POW' => -101,
			"\@{" => 85,
			'OP21_LIST_COMMA' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP07_STRING_REPEAT' => -101,
			'WORD_SCOPED' => 23,
			'OP09_BITWISE_SHIFT' => -101
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 125,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 74
		DEFAULT => -214
	},
	{#State 75
		DEFAULT => -14
	},
	{#State 76
		ACTIONS => {
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123
		},
		GOTOS => {
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 127,
			'Expression' => 126
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 78
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 129
		}
	},
	{#State 79
		DEFAULT => -151
	},
	{#State 80
		DEFAULT => -134
	},
	{#State 81
		DEFAULT => -140
	},
	{#State 82
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"while (" => -147,
			"if (" => 109,
			'OP01_NAMED_VOID' => 108,
			'' => -18,
			'OP01_NAMED' => 107,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'OP19_LOOP_CONTROL' => 100,
			"for my integer" => -147,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 77,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'LoopLabel' => 94,
			'SubExpression' => 92,
			'Expression' => 71,
			'OperatorVoid' => 72,
			'Conditional' => 90,
			'VariableDeclaration' => 79,
			'HashReference' => 98,
			'WordScoped' => 97,
			'VariableModification' => 83,
			'Operation' => 130,
			'Variable' => 103,
			'HashDereferenced' => 81,
			'OPTIONAL-40' => 106,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Statement' => 86,
			'Operator' => 111,
			'PAREN-39' => 112
		}
	},
	{#State 83
		DEFAULT => -152
	},
	{#State 84
		DEFAULT => -137
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LBRACKET' => 102
		},
		GOTOS => {
			'ArrayReference' => 131,
			'Variable' => 132
		}
	},
	{#State 86
		DEFAULT => -83
	},
	{#State 87
		ACTIONS => {
			'LBRACE' => 134,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 133,
			'HashReference' => 135
		}
	},
	{#State 88
		DEFAULT => -135
	},
	{#State 89
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP01_PRINT' => 137,
			'WORD' => 22,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'SubExpression' => 138,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81
		}
	},
	{#State 90
		DEFAULT => -148
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => -116,
			'OP01_NAMED' => -116,
			'WORD_SCOPED' => -116,
			'OP10_STRINGIFY_UNARY' => -116,
			'OP01_QW' => -116,
			"\@{" => -116,
			'STDOUT_STDERR' => 139,
			"%{" => -116,
			'OP01_OPEN' => -116,
			'LPAREN' => -116,
			'WORD' => -116,
			'OP10_NAMED_UNARY' => -116,
			'LITERAL_NUMBER' => -116,
			'OP05_MATH_NEG_LPAREN' => -116,
			'FH_REF_SYMBOL_BRACES' => 142,
			'OP22_LOGICAL_NEG' => -116,
			'KEYS_OR_VALUES' => -116,
			'LITERAL_STRING' => -116,
			'OP01_CLOSE' => -116,
			"my" => -116,
			'OP03_MATH_INC_DEC' => -116,
			'LBRACE' => -116,
			'OP05_LOGICAL_NEG' => -116,
			"undef" => -116,
			'LBRACKET' => -116
		},
		GOTOS => {
			'PAREN-33' => 141,
			'OPTIONAL-34' => 140
		}
	},
	{#State 92
		ACTIONS => {
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP16_LOGICAL_OR' => 148,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 93
		ACTIONS => {
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 160,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 94
		ACTIONS => {
			'COLON' => 161
		}
	},
	{#State 95
		ACTIONS => {
			'FH_REF_SYMBOL' => 162
		}
	},
	{#State 96
		DEFAULT => -213
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 163
		}
	},
	{#State 98
		DEFAULT => -139
	},
	{#State 99
		ACTIONS => {
			"}" => 165,
			'WORD' => 166,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 164,
			'HashEntry' => 167
		}
	},
	{#State 100
		ACTIONS => {
			";" => -120,
			'WORD' => 168
		},
		GOTOS => {
			'LoopLabel' => 169,
			'OPTIONAL-36' => 170
		}
	},
	{#State 101
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD' => 22,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85
		},
		GOTOS => {
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 171,
			'Expression' => 126
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"]" => -190,
			"my" => 118,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'OP01_QW' => 175,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'SubExpression' => 174,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'OPTIONAL-50' => 172,
			'ListElement' => 177,
			'TypeInner' => 178,
			'ListElements' => 176,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 103
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP19_VARIABLE_ASSIGN' => 181,
			'OP13_BITWISE_AND' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP16_LOGICAL_OR' => -136,
			'OP18_TERNARY' => -136,
			'OP03_MATH_INC_DEC' => 182,
			'OP06_REGEX_MATCH' => -136,
			'OP19_VARIABLE_ASSIGN_BY' => 179,
			'OP08_STRING_CAT' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP02_METHOD_THINARROW' => 180,
			'OP04_MATH_POW' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP23_LOGICAL_AND' => -136
		}
	},
	{#State 104
		DEFAULT => -170,
		GOTOS => {
			'STAR-46' => 183
		}
	},
	{#State 105
		DEFAULT => -17
	},
	{#State 106
		ACTIONS => {
			"foreach my" => 189,
			"for my integer" => 187,
			"while (" => 185
		},
		GOTOS => {
			'LoopWhile' => 186,
			'LoopFor' => 190,
			'Loop' => 184,
			'LoopForEach' => 188
		}
	},
	{#State 107
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"my" => 118,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'WORD' => 22,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'TypeInner' => 178,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'ListElement' => 192,
			'Expression' => 126,
			'SubExpression' => 191
		}
	},
	{#State 108
		ACTIONS => {
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			";" => -118,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 118,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173,
			'WORD' => 22,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'OP01_QW' => 175,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123
		},
		GOTOS => {
			'ListElements' => 193,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'TypeInner' => 178,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'SubExpression' => 174,
			'Expression' => 126,
			'ListElement' => 177,
			'Variable' => 124,
			'OPTIONAL-35' => 194,
			'HashDereferenced' => 81
		}
	},
	{#State 109
		ACTIONS => {
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 195,
			'Expression' => 126
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 196,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84
		}
	},
	{#State 111
		DEFAULT => -130
	},
	{#State 112
		DEFAULT => -146
	},
	{#State 113
		ACTIONS => {
			"my" => 197
		}
	},
	{#State 114
		DEFAULT => -138
	},
	{#State 115
		DEFAULT => -51
	},
	{#State 116
		ACTIONS => {
			"use constant" => -56,
			"use" => 38,
			"our %properties = (" => -56
		},
		GOTOS => {
			'STAR-22' => 198,
			'Include' => 199
		}
	},
	{#State 117
		ACTIONS => {
			'LITERAL_NUMBER' => 74,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'Literal' => 200
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 119
		ACTIONS => {
			"my" => -43,
			'LITERAL_STRING' => -43,
			'OP01_CLOSE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"for my integer" => -43,
			'LBRACE' => -43,
			'LBRACKET' => -43,
			"undef" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'WORD' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LITERAL_NUMBER' => -43,
			"foreach my" => -43,
			'OP10_NAMED_UNARY' => -43,
			"( my" => 202,
			'OP22_LOGICAL_NEG' => -43,
			"\@{" => -43,
			"%{" => -43,
			'LPAREN' => -43,
			'OP01_OPEN' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED' => -43,
			'OP01_NAMED_VOID' => -43,
			"while (" => -43,
			"if (" => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'WORD_SCOPED' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 203,
			'OPTIONAL-16' => 204
		}
	},
	{#State 120
		ACTIONS => {
			";" => 205
		}
	},
	{#State 121
		DEFAULT => -37
	},
	{#State 122
		DEFAULT => -82
	},
	{#State 123
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'WORD' => 22,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 206,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 124
		ACTIONS => {
			'OP23_LOGICAL_AND' => -136,
			'OP04_MATH_POW' => -136,
			'OP21_LIST_COMMA' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP02_METHOD_THINARROW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP08_STRING_CAT' => -136,
			";" => -136,
			"]" => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP18_TERNARY' => -136,
			"}" => -136,
			'OP03_MATH_INC_DEC' => 182,
			'OP16_LOGICAL_OR' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			")" => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP13_BITWISE_AND' => -136
		}
	},
	{#State 125
		ACTIONS => {
			'OP15_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP06_REGEX_MATCH' => 158,
			"]" => -100,
			";" => -100,
			'OP08_STRING_CAT' => 157,
			'OP08_MATH_ADD_SUB' => 156,
			")" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 126
		DEFAULT => -133
	},
	{#State 127
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			";" => -111,
			"]" => -111,
			'OP06_REGEX_MATCH' => 158,
			"}" => -111,
			'OP18_TERNARY' => 159,
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP08_MATH_ADD_SUB' => 156,
			")" => -111,
			'OP13_BITWISE_AND' => 155,
			'OP23_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP09_BITWISE_SHIFT' => 144
		}
	},
	{#State 128
		ACTIONS => {
			'VARIABLE_SYMBOL' => 207
		}
	},
	{#State 129
		DEFAULT => -89
	},
	{#State 130
		DEFAULT => -16
	},
	{#State 131
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 132
		ACTIONS => {
			"}" => 209
		}
	},
	{#State 133
		ACTIONS => {
			"}" => 210
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 166,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 164,
			'HashEntry' => 167
		}
	},
	{#State 135
		ACTIONS => {
			"}" => 211
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"my" => 118,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89
		},
		GOTOS => {
			'ListElement' => 212,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 191,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'TypeInner' => 178
		}
	},
	{#State 137
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 213
		}
	},
	{#State 138
		ACTIONS => {
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			")" => 214,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP08_STRING_CAT' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147
		}
	},
	{#State 139
		DEFAULT => -114
	},
	{#State 140
		ACTIONS => {
			'OP01_QW' => 175,
			"\@{" => 85,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"my" => 118,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'WORD' => 22,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93
		},
		GOTOS => {
			'HashDereferenced' => 81,
			'Variable' => 124,
			'ListElement' => 177,
			'Expression' => 126,
			'SubExpression' => 174,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'TypeInner' => 178,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'ListElements' => 215
		}
	},
	{#State 141
		DEFAULT => -115
	},
	{#State 142
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'OP01_QW' => 175,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173,
			'WORD' => 22,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 118,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'ListElement' => 177,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 174,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ListElements' => 216,
			'TypeInner' => 178
		}
	},
	{#State 143
		ACTIONS => {
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73
		},
		GOTOS => {
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 217
		}
	},
	{#State 144
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD' => 22,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 218,
			'Expression' => 126,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99
		},
		GOTOS => {
			'SubExpression' => 219,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111
		}
	},
	{#State 146
		ACTIONS => {
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 220,
			'Expression' => 126,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 147
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			"\@{" => 85,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Expression' => 126,
			'SubExpression' => 221,
			'HashDereferenced' => 81,
			'Variable' => 124
		}
	},
	{#State 148
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'WORD' => 22,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'Expression' => 126,
			'SubExpression' => 222,
			'HashDereferenced' => 81,
			'Variable' => 124
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'WORD' => 22,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 223,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 22,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 224,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"\@{" => 85,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 225,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 152
		ACTIONS => {
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22
		},
		GOTOS => {
			'SubExpression' => 226,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 153
		ACTIONS => {
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 227,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84
		}
	},
	{#State 154
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP22_LOGICAL_NEG' => 76,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 228,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 155
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD' => 22,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 229,
			'Expression' => 126,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 156
		ACTIONS => {
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"\@{" => 85
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 230,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 157
		ACTIONS => {
			"\@{" => 85,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 22,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 231,
			'Expression' => 126,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 158
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 232
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_STRING' => 96,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 74
		},
		GOTOS => {
			'Literal' => 235,
			'Variable' => 234,
			'VariableOrLiteral' => 233
		}
	},
	{#State 160
		ACTIONS => {
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP08_STRING_CAT' => 157,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			")" => 236,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP16_LOGICAL_OR' => 148
		}
	},
	{#State 161
		DEFAULT => -145
	},
	{#State 162
		DEFAULT => -88
	},
	{#State 163
		ACTIONS => {
			'OP01_QW' => 175,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"my" => 118,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'WORD' => 22,
			")" => -127,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'ListElements' => 238,
			'TypeInner' => 178,
			'ListElement' => 177,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'OPTIONAL-37' => 237,
			'Expression' => 126,
			'SubExpression' => 174
		}
	},
	{#State 164
		DEFAULT => -197
	},
	{#State 165
		DEFAULT => -141
	},
	{#State 166
		ACTIONS => {
			'OP20_HASH_FATARROW' => 239
		}
	},
	{#State 167
		DEFAULT => -202,
		GOTOS => {
			'STAR-53' => 240
		}
	},
	{#State 168
		DEFAULT => -208
	},
	{#State 169
		DEFAULT => -119
	},
	{#State 170
		ACTIONS => {
			";" => 241
		}
	},
	{#State 171
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			"}" => -92,
			'OP18_TERNARY' => -92,
			"]" => -92,
			'OP06_REGEX_MATCH' => -92,
			";" => -92,
			'OP08_STRING_CAT' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			")" => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92
		}
	},
	{#State 172
		ACTIONS => {
			"]" => 242
		}
	},
	{#State 173
		ACTIONS => {
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 243
		}
	},
	{#State 174
		ACTIONS => {
			'OP23_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -186,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_STRING_CAT' => 157,
			";" => -186,
			"]" => -186,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159,
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			")" => -186,
			'OP13_BITWISE_AND' => 155
		}
	},
	{#State 175
		ACTIONS => {
			'LPAREN' => 244
		}
	},
	{#State 176
		DEFAULT => -189
	},
	{#State 177
		DEFAULT => -181,
		GOTOS => {
			'STAR-48' => 245
		}
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102
		},
		GOTOS => {
			'SubExpression' => 246,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 179
		ACTIONS => {
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 247
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => 248
		}
	},
	{#State 181
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'WORD' => 22,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'STDIN' => 251,
			"%{" => 87,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'HashDereferenced' => 81,
			'Variable' => 124,
			'SubExpressionOrStdin' => 250,
			'Expression' => 126,
			'SubExpression' => 249,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 182
		DEFAULT => -90
	},
	{#State 183
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -171,
			'OP24_LOGICAL_OR_XOR' => -171,
			'OP02_HASH_THINARROW' => 253,
			'OP02_ARRAY_THINARROW' => 252,
			'COLON' => -171,
			'OP07_STRING_REPEAT' => -171,
			'OP07_MATH_MULT_DIV_MOD' => -171,
			'OP02_METHOD_THINARROW' => -171,
			'OP21_LIST_COMMA' => -171,
			'OP15_LOGICAL_AND' => -171,
			'OP04_MATH_POW' => -171,
			'OP23_LOGICAL_AND' => -171,
			")" => -171,
			'OP13_BITWISE_AND' => -171,
			'OP08_MATH_ADD_SUB' => -171,
			'OP19_VARIABLE_ASSIGN' => -171,
			'OP12_COMPARE_EQ_NE' => -171,
			'OP11_COMPARE_LT_GT' => -171,
			'OP17_LIST_RANGE' => -171,
			'OP14_BITWISE_OR_XOR' => -171,
			'OP16_LOGICAL_OR' => -171,
			'OP03_MATH_INC_DEC' => -171,
			'OP18_TERNARY' => -171,
			"}" => -171,
			'OP06_REGEX_MATCH' => -171,
			"]" => -171,
			";" => -171,
			'OP19_VARIABLE_ASSIGN_BY' => -171,
			'OP08_STRING_CAT' => -171
		},
		GOTOS => {
			'VariableRetrieval' => 254
		}
	},
	{#State 184
		DEFAULT => -149
	},
	{#State 185
		ACTIONS => {
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22
		},
		GOTOS => {
			'SubExpression' => 255,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 186
		DEFAULT => -162
	},
	{#State 187
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 188
		DEFAULT => -161
	},
	{#State 189
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 190
		DEFAULT => -160
	},
	{#State 191
		ACTIONS => {
			'OP06_REGEX_MATCH' => -85,
			'OP18_TERNARY' => -85,
			'OP08_STRING_CAT' => -85,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP13_BITWISE_AND' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP21_LIST_COMMA' => -186,
			'OP04_MATH_POW' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85
		}
	},
	{#State 192
		ACTIONS => {
			'OP21_LIST_COMMA' => 258
		}
	},
	{#State 193
		DEFAULT => -117
	},
	{#State 194
		ACTIONS => {
			";" => 259
		}
	},
	{#State 195
		ACTIONS => {
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 155,
			")" => 260,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP16_LOGICAL_OR' => 148
		}
	},
	{#State 196
		ACTIONS => {
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => 261,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP08_STRING_CAT' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159
		}
	},
	{#State 197
		ACTIONS => {
			"filehandle_ref" => 262
		}
	},
	{#State 198
		ACTIONS => {
			"our %properties = (" => 265,
			"use constant" => 46
		},
		GOTOS => {
			'Constant' => 264,
			'Properties' => 263
		}
	},
	{#State 199
		DEFAULT => -53
	},
	{#State 200
		ACTIONS => {
			";" => 266
		}
	},
	{#State 201
		ACTIONS => {
			"\$TYPED_" => 267
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 203
		DEFAULT => -42
	},
	{#State 204
		ACTIONS => {
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 77,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'OP19_LOOP_CONTROL' => 100,
			"for my integer" => -147,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 108,
			'OP01_NAMED' => 107,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"while (" => -147,
			"if (" => 109,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'VariableModification' => 83,
			'OPTIONAL-40' => 106,
			'Operation' => 270,
			'Variable' => 103,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'PAREN-39' => 112,
			'Statement' => 86,
			'ArrayReference' => 84,
			'Operator' => 111,
			'SubExpression' => 92,
			'LoopLabel' => 94,
			'OperatorVoid' => 72,
			'Expression' => 71,
			'Conditional' => 90,
			'VariableDeclaration' => 79,
			'PLUS-17' => 269,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 205
		DEFAULT => -40
	},
	{#State 206
		ACTIONS => {
			'OP08_STRING_CAT' => -85,
			";" => -85,
			'OP06_REGEX_MATCH' => -85,
			"]" => -85,
			"}" => -85,
			'OP18_TERNARY' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => -85
		}
	},
	{#State 207
		ACTIONS => {
			";" => 272,
			'OP19_VARIABLE_ASSIGN' => 271
		}
	},
	{#State 208
		DEFAULT => -193
	},
	{#State 209
		DEFAULT => -192
	},
	{#State 210
		DEFAULT => -204
	},
	{#State 211
		DEFAULT => -205
	},
	{#State 212
		ACTIONS => {
			'OP21_LIST_COMMA' => 273
		}
	},
	{#State 213
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'OP01_QW' => 175,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22,
			'LBRACE' => 99,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			"my" => 118,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'TypeInner' => 178,
			'ListElements' => 274,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ListElement' => 177,
			'SubExpression' => 174,
			'Expression' => 126
		}
	},
	{#State 214
		DEFAULT => -142
	},
	{#State 215
		ACTIONS => {
			";" => 275
		}
	},
	{#State 216
		ACTIONS => {
			";" => 276
		}
	},
	{#State 217
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -95,
			")" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP16_LOGICAL_OR' => -95,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_MATCH' => 158,
			"]" => -95,
			";" => -95,
			'OP08_STRING_CAT' => -95
		}
	},
	{#State 218
		ACTIONS => {
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP06_REGEX_MATCH' => 158,
			"]" => -99,
			";" => -99,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP08_MATH_ADD_SUB' => 156,
			'OP11_COMPARE_LT_GT' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143
		}
	},
	{#State 219
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			"}" => -112,
			'OP18_TERNARY' => 159,
			"]" => -112,
			'OP06_REGEX_MATCH' => 158,
			";" => -112,
			'OP08_STRING_CAT' => 157,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			")" => -112,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP16_LOGICAL_OR' => 148
		}
	},
	{#State 220
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			")" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP06_REGEX_MATCH' => -91,
			"]" => -91,
			'OP18_TERNARY' => -91,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			";" => -91
		}
	},
	{#State 221
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			"]" => -107,
			'OP06_REGEX_MATCH' => 158,
			"}" => -107,
			'OP18_TERNARY' => -107,
			'OP08_STRING_CAT' => 157,
			";" => -107,
			'OP17_LIST_RANGE' => -107,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP13_BITWISE_AND' => 155,
			")" => -107,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => -107
		}
	},
	{#State 222
		ACTIONS => {
			'OP16_LOGICAL_OR' => -108,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => -108,
			")" => -108,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP08_STRING_CAT' => 157,
			";" => -108,
			'OP06_REGEX_MATCH' => 158,
			"]" => -108,
			'OP18_TERNARY' => -108,
			"}" => -108,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -108,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 223
		ACTIONS => {
			'OP18_TERNARY' => -104,
			"}" => -104,
			"]" => -104,
			'OP06_REGEX_MATCH' => 158,
			";" => -104,
			'OP08_STRING_CAT' => 157,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP13_BITWISE_AND' => -104,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 224
		ACTIONS => {
			'OP16_LOGICAL_OR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP13_BITWISE_AND' => -96,
			")" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP08_STRING_CAT' => -96,
			";" => -96,
			"]" => -96,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => -96,
			"}" => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP07_STRING_REPEAT' => 143,
			'OP09_BITWISE_SHIFT' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 225
		ACTIONS => {
			";" => -113,
			'OP08_STRING_CAT' => 157,
			"}" => -113,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			"]" => -113,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 155,
			")" => -113,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP23_LOGICAL_AND' => 145,
			'OP21_LIST_COMMA' => -113,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -113
		}
	},
	{#State 226
		ACTIONS => {
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP06_REGEX_MATCH' => 158,
			"]" => -106,
			"}" => -106,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 157,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP17_LIST_RANGE' => -106,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP16_LOGICAL_OR' => -106
		}
	},
	{#State 227
		ACTIONS => {
			'OP16_LOGICAL_OR' => 148,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => undef,
			")" => -109,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP08_STRING_CAT' => 157,
			";" => -109,
			'OP06_REGEX_MATCH' => 158,
			"]" => -109,
			'OP18_TERNARY' => -109,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -109,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 228
		ACTIONS => {
			";" => -103,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => -103,
			"}" => -103,
			"]" => -103,
			'OP06_REGEX_MATCH' => 158,
			'OP16_LOGICAL_OR' => -103,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -103,
			")" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -103
		}
	},
	{#State 229
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			")" => -105,
			'OP13_BITWISE_AND' => -105,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP18_TERNARY' => -105,
			"}" => -105,
			"]" => -105,
			'OP06_REGEX_MATCH' => 158,
			";" => -105,
			'OP08_STRING_CAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 230
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP21_LIST_COMMA' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			")" => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP06_REGEX_MATCH' => 158,
			"]" => -97,
			"}" => -97,
			'OP18_TERNARY' => -97,
			'OP08_STRING_CAT' => -97,
			";" => -97
		}
	},
	{#State 231
		ACTIONS => {
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP09_BITWISE_SHIFT' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			")" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			";" => -98,
			'OP08_STRING_CAT' => -98,
			'OP18_TERNARY' => -98,
			"}" => -98,
			"]" => -98,
			'OP06_REGEX_MATCH' => 158
		}
	},
	{#State 232
		DEFAULT => -94
	},
	{#State 233
		ACTIONS => {
			'COLON' => 277
		}
	},
	{#State 234
		DEFAULT => -211
	},
	{#State 235
		DEFAULT => -212
	},
	{#State 236
		DEFAULT => -93
	},
	{#State 237
		ACTIONS => {
			")" => 278
		}
	},
	{#State 238
		DEFAULT => -126
	},
	{#State 239
		ACTIONS => {
			'VARIABLE_SYMBOL' => -195,
			'OP01_NAMED' => -195,
			'OP10_STRINGIFY_UNARY' => -195,
			'WORD_SCOPED' => -195,
			"\@{" => -195,
			"%{" => -195,
			'LPAREN' => -195,
			'OP01_OPEN' => -195,
			'WORD' => -195,
			'LITERAL_NUMBER' => -195,
			'OP05_MATH_NEG_LPAREN' => -195,
			'OP10_NAMED_UNARY' => -195,
			'OP22_LOGICAL_NEG' => -195,
			"my" => 118,
			'LITERAL_STRING' => -195,
			'OP01_CLOSE' => -195,
			'OP03_MATH_INC_DEC' => -195,
			'LBRACE' => -195,
			"undef" => -195,
			'LBRACKET' => -195,
			'OP05_LOGICAL_NEG' => -195
		},
		GOTOS => {
			'TypeInner' => 279,
			'OPTIONAL-51' => 280
		}
	},
	{#State 240
		ACTIONS => {
			"}" => 283,
			'OP21_LIST_COMMA' => 281
		},
		GOTOS => {
			'PAREN-52' => 282
		}
	},
	{#State 241
		DEFAULT => -125
	},
	{#State 242
		DEFAULT => -191
	},
	{#State 243
		DEFAULT => -188
	},
	{#State 244
		ACTIONS => {
			'WORD' => 284
		},
		GOTOS => {
			'PLUS-49' => 285
		}
	},
	{#State 245
		ACTIONS => {
			";" => -184,
			")" => -184,
			'OP21_LIST_COMMA' => 287,
			"]" => -184
		},
		GOTOS => {
			'PAREN-47' => 286
		}
	},
	{#State 246
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -187,
			'OP23_LOGICAL_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			")" => -187,
			'OP13_BITWISE_AND' => 155,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP16_LOGICAL_OR' => 148,
			'OP18_TERNARY' => 159,
			"]" => -187,
			'OP06_REGEX_MATCH' => 158,
			";" => -187,
			'OP08_STRING_CAT' => 157
		}
	},
	{#State 247
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP08_STRING_CAT' => 157,
			";" => 288,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159
		}
	},
	{#State 248
		ACTIONS => {
			'LPAREN' => 289
		}
	},
	{#State 249
		ACTIONS => {
			";" => -143,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 145,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 250
		ACTIONS => {
			";" => 290
		}
	},
	{#State 251
		DEFAULT => -144
	},
	{#State 252
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'WORD' => 22,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 291,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 253
		ACTIONS => {
			'WORD' => 292,
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 293,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 254
		DEFAULT => -169
	},
	{#State 255
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159,
			'OP16_LOGICAL_OR' => 148,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			")" => 294,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP23_LOGICAL_AND' => 145,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144
		}
	},
	{#State 256
		ACTIONS => {
			'LPAREN' => 295
		}
	},
	{#State 257
		ACTIONS => {
			'VARIABLE_SYMBOL' => 296
		}
	},
	{#State 258
		ACTIONS => {
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 118,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			'OP01_QW' => 175,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ListElement' => 177,
			'SubExpression' => 174,
			'Expression' => 126,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'TypeInner' => 178,
			'ListElements' => 297,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 259
		DEFAULT => -123
	},
	{#State 260
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 299
		}
	},
	{#State 261
		DEFAULT => -102
	},
	{#State 262
		ACTIONS => {
			'FH_REF_SYMBOL' => 300
		}
	},
	{#State 263
		ACTIONS => {
			"our %properties_class = (" => 303,
			'LITERAL_NUMBER' => -58,
			"our" => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 302,
			'PropertiesClass' => 301
		}
	},
	{#State 264
		DEFAULT => -55
	},
	{#State 265
		ACTIONS => {
			"## no critic qw(" => 5,
			")" => 305
		},
		GOTOS => {
			'Critic' => 304
		}
	},
	{#State 266
		DEFAULT => -41
	},
	{#State 267
		ACTIONS => {
			'WORD' => 306
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 307
		}
	},
	{#State 269
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'OP19_LOOP_CONTROL' => 100,
			"for my integer" => -147,
			'LBRACE' => 99,
			"}" => 309,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 77,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"while (" => -147,
			"if (" => 109,
			'OP01_NAMED_VOID' => 108,
			'OP01_NAMED' => 107,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			"\@{" => 85
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 98,
			'VariableDeclaration' => 79,
			'Conditional' => 90,
			'OperatorVoid' => 72,
			'Expression' => 71,
			'LoopLabel' => 94,
			'SubExpression' => 92,
			'Operator' => 111,
			'Statement' => 86,
			'ArrayReference' => 84,
			'PAREN-39' => 112,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'HashDereferenced' => 81,
			'Variable' => 103,
			'Operation' => 308,
			'OPTIONAL-40' => 106,
			'VariableModification' => 83
		}
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		ACTIONS => {
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'WORD' => 22,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87,
			'STDIN' => 251,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'SubExpressionOrStdin' => 310,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 249,
			'Expression' => 126,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 272
		DEFAULT => -175
	},
	{#State 273
		ACTIONS => {
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 118,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACE' => 99,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			'OP01_QW' => 175,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'TypeInner' => 178,
			'ListElements' => 311,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'SubExpression' => 174,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ListElement' => 177
		}
	},
	{#State 274
		ACTIONS => {
			")" => 312
		}
	},
	{#State 275
		DEFAULT => -121
	},
	{#State 276
		DEFAULT => -122
	},
	{#State 277
		ACTIONS => {
			'LITERAL_STRING' => 96,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 74
		},
		GOTOS => {
			'VariableOrLiteral' => 313,
			'Variable' => 234,
			'Literal' => 235
		}
	},
	{#State 278
		DEFAULT => -131
	},
	{#State 279
		DEFAULT => -194
	},
	{#State 280
		ACTIONS => {
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP22_LOGICAL_NEG' => 76,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89
		},
		GOTOS => {
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Expression' => 126,
			'SubExpression' => 314,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Literal' => 88,
			'ArrayDereferenced' => 114
		}
	},
	{#State 281
		ACTIONS => {
			'WORD' => 166,
			"%{" => 87
		},
		GOTOS => {
			'HashEntry' => 315,
			'HashDereferenced' => 164
		}
	},
	{#State 282
		DEFAULT => -201
	},
	{#State 283
		DEFAULT => -203
	},
	{#State 284
		DEFAULT => -183
	},
	{#State 285
		ACTIONS => {
			'WORD' => 316,
			")" => 317
		}
	},
	{#State 286
		DEFAULT => -180
	},
	{#State 287
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			"\@{" => 85,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD' => 22,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'LBRACE' => 99,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"my" => 118
		},
		GOTOS => {
			'SubExpression' => 174,
			'Expression' => 126,
			'ListElement' => 318,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'TypeInner' => 178,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111
		}
	},
	{#State 288
		DEFAULT => -178
	},
	{#State 289
		ACTIONS => {
			"\@{" => 85,
			'OP01_QW' => 175,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			"my" => 118,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'LBRACKET' => 102,
			"undef" => 80,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 22,
			")" => -129,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 174,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'ListElement' => 177,
			'TypeInner' => 178,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ListElements' => 320,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98,
			'OPTIONAL-38' => 319
		}
	},
	{#State 290
		DEFAULT => -177
	},
	{#State 291
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP23_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			"]" => 321,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 157,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 148
		}
	},
	{#State 292
		ACTIONS => {
			'LPAREN' => -206,
			"}" => 322
		}
	},
	{#State 293
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP18_TERNARY' => 159,
			"}" => 323,
			'OP06_REGEX_MATCH' => 158,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => 145
		}
	},
	{#State 294
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 324
		}
	},
	{#State 295
		ACTIONS => {
			"\@{" => 85,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 22,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76
		},
		GOTOS => {
			'Expression' => 126,
			'SubExpression' => 325,
			'HashDereferenced' => 81,
			'Variable' => 124,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Operator' => 111,
			'ArrayReference' => 84,
			'WordScoped' => 97,
			'HashReference' => 98
		}
	},
	{#State 296
		ACTIONS => {
			'LPAREN' => 326
		}
	},
	{#State 297
		ACTIONS => {
			";" => 327
		}
	},
	{#State 298
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"my" => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			"for my integer" => -147,
			'OP05_LOGICAL_NEG' => 101,
			'OP19_LOOP_CONTROL' => 100,
			'LBRACKET' => 102,
			"undef" => 80,
			'WORD' => 70,
			'OP01_PRINT' => 91,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 107,
			'OP01_NAMED_VOID' => 108,
			"if (" => 109,
			"while (" => -147,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110
		},
		GOTOS => {
			'OperatorVoid' => 72,
			'Expression' => 71,
			'LoopLabel' => 94,
			'SubExpression' => 92,
			'Conditional' => 90,
			'PLUS-45' => 328,
			'VariableDeclaration' => 79,
			'WordScoped' => 97,
			'HashReference' => 98,
			'VariableModification' => 83,
			'HashDereferenced' => 81,
			'Operation' => 329,
			'Variable' => 103,
			'OPTIONAL-40' => 106,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'Operator' => 111,
			'Statement' => 86,
			'ArrayReference' => 84,
			'PAREN-39' => 112
		}
	},
	{#State 299
		DEFAULT => -155,
		GOTOS => {
			'STAR-42' => 330
		}
	},
	{#State 300
		ACTIONS => {
			'OP21_LIST_COMMA' => 331
		}
	},
	{#State 301
		DEFAULT => -57
	},
	{#State 302
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 332
		}
	},
	{#State 303
		ACTIONS => {
			"## no critic qw(" => 5
		},
		GOTOS => {
			'Critic' => 333
		}
	},
	{#State 304
		ACTIONS => {
			'WORD' => 335,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 336,
			'HashEntryTyped' => 334
		}
	},
	{#State 305
		ACTIONS => {
			";" => 337
		}
	},
	{#State 306
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 338
		}
	},
	{#State 307
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 339
		}
	},
	{#State 308
		DEFAULT => -44
	},
	{#State 309
		ACTIONS => {
			";" => 340
		}
	},
	{#State 310
		ACTIONS => {
			";" => 341
		}
	},
	{#State 311
		ACTIONS => {
			")" => 342
		}
	},
	{#State 312
		DEFAULT => -84
	},
	{#State 313
		DEFAULT => -110
	},
	{#State 314
		ACTIONS => {
			'OP21_LIST_COMMA' => -196,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP23_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP06_REGEX_MATCH' => 158,
			"}" => -196,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 157,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP16_LOGICAL_OR' => 148
		}
	},
	{#State 315
		DEFAULT => -200
	},
	{#State 316
		DEFAULT => -182
	},
	{#State 317
		DEFAULT => -185
	},
	{#State 318
		DEFAULT => -179
	},
	{#State 319
		ACTIONS => {
			")" => 343
		}
	},
	{#State 320
		DEFAULT => -128
	},
	{#State 321
		DEFAULT => -172
	},
	{#State 322
		DEFAULT => -174
	},
	{#State 323
		DEFAULT => -173
	},
	{#State 324
		DEFAULT => -165
	},
	{#State 325
		ACTIONS => {
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP08_STRING_CAT' => 157,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 344,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP16_LOGICAL_OR' => 148,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP23_LOGICAL_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 326
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			'OP01_QW' => 175,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP22_LOGICAL_NEG' => 76,
			'KEYS_OR_VALUES' => 173,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"my" => 118,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80
		},
		GOTOS => {
			'ListElements' => 345,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'TypeInner' => 178,
			'HashReference' => 98,
			'WordScoped' => 97,
			'ArrayReference' => 84,
			'Operator' => 111,
			'SubExpression' => 174,
			'Expression' => 126,
			'ListElement' => 177,
			'Variable' => 124,
			'HashDereferenced' => 81
		}
	},
	{#State 327
		DEFAULT => -124
	},
	{#State 328
		ACTIONS => {
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			"foreach my" => -147,
			'OP22_LOGICAL_NEG' => 76,
			"my" => 77,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"}" => 346,
			'OP03_MATH_INC_DEC' => 78,
			"for my integer" => -147,
			'LBRACE' => 99,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP19_LOOP_CONTROL' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED_VOID' => 108,
			'OP01_NAMED' => 107,
			"while (" => -147,
			"if (" => 109,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113
		},
		GOTOS => {
			'VariableModification' => 83,
			'Variable' => 103,
			'Operation' => 347,
			'HashDereferenced' => 81,
			'OPTIONAL-40' => 106,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'ArrayReference' => 84,
			'Statement' => 86,
			'Operator' => 111,
			'PAREN-39' => 112,
			'LoopLabel' => 94,
			'SubExpression' => 92,
			'OperatorVoid' => 72,
			'Expression' => 71,
			'Conditional' => 90,
			'VariableDeclaration' => 79,
			'HashReference' => 98,
			'WordScoped' => 97
		}
	},
	{#State 329
		DEFAULT => -167
	},
	{#State 330
		ACTIONS => {
			"else" => 349,
			'OP01_PRINT' => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			'OP01_CLOSE' => -158,
			'LITERAL_STRING' => -158,
			'OP19_LOOP_CONTROL' => -158,
			'OP05_LOGICAL_NEG' => -158,
			'LBRACKET' => -158,
			'LBRACE' => -158,
			'OP01_NAMED' => -158,
			'OP01_NAMED_VOID' => -158,
			'' => -158,
			'VARIABLE_SYMBOL' => -158,
			'OP10_STRINGIFY_UNARY' => -158,
			"if (" => -158,
			"while (" => -158,
			"elsif (" => 348,
			'OP01_OPEN' => -158,
			'WORD' => -158,
			'OP22_LOGICAL_NEG' => -158,
			"foreach my" => -158,
			'OP10_NAMED_UNARY' => -158,
			'LITERAL_NUMBER' => -158,
			'OP03_MATH_INC_DEC' => -158,
			"}" => -158,
			"my" => -158,
			"undef" => -158,
			"for my integer" => -158,
			'WORD_SCOPED' => -158,
			"\@{" => -158,
			'LPAREN' => -158,
			"%{" => -158
		},
		GOTOS => {
			'PAREN-43' => 351,
			'OPTIONAL-44' => 352,
			'PAREN-41' => 350
		}
	},
	{#State 331
		ACTIONS => {
			'LITERAL_STRING' => 353
		}
	},
	{#State 332
		ACTIONS => {
			'LITERAL_NUMBER' => 354,
			"our" => 357
		},
		GOTOS => {
			'Method' => 358,
			'Subroutine' => 355,
			'MethodOrSubroutine' => 356
		}
	},
	{#State 333
		ACTIONS => {
			'WORD' => 335,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 336,
			'HashEntryTyped' => 359
		}
	},
	{#State 334
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 360
		}
	},
	{#State 335
		ACTIONS => {
			'OP20_HASH_FATARROW' => 361
		}
	},
	{#State 336
		DEFAULT => -199
	},
	{#State 337
		ACTIONS => {
			"## no critic qw(" => 5
		},
		GOTOS => {
			'Critic' => 362
		}
	},
	{#State 338
		DEFAULT => -210
	},
	{#State 339
		ACTIONS => {
			'OP21_LIST_COMMA' => 363,
			")" => 365
		},
		GOTOS => {
			'PAREN-18' => 364
		}
	},
	{#State 340
		DEFAULT => -46
	},
	{#State 341
		DEFAULT => -176
	},
	{#State 342
		DEFAULT => -86
	},
	{#State 343
		DEFAULT => -132
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102
		},
		GOTOS => {
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'Expression' => 126,
			'SubExpression' => 366,
			'HashDereferenced' => 81,
			'Variable' => 124
		}
	},
	{#State 345
		ACTIONS => {
			")" => 367
		}
	},
	{#State 346
		DEFAULT => -168
	},
	{#State 347
		DEFAULT => -166
	},
	{#State 348
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 101,
			'LBRACKET' => 102,
			"undef" => 80,
			'WORD' => 22,
			'OP10_NAMED_UNARY' => 73,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP22_LOGICAL_NEG' => 76,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'Variable' => 124,
			'HashDereferenced' => 81,
			'SubExpression' => 368,
			'Expression' => 126
		}
	},
	{#State 349
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 350
		DEFAULT => -154
	},
	{#State 351
		DEFAULT => -157
	},
	{#State 352
		DEFAULT => -159
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 370
		}
	},
	{#State 354
		ACTIONS => {
			";" => 371
		}
	},
	{#State 355
		DEFAULT => -81
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		ACTIONS => {
			'WORD' => 58,
			'TYPE_METHOD' => 372
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 358
		DEFAULT => -80
	},
	{#State 359
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 373
		}
	},
	{#State 360
		ACTIONS => {
			'OP21_LIST_COMMA' => 374,
			")" => 375
		},
		GOTOS => {
			'PAREN-25' => 376
		}
	},
	{#State 361
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 377
		}
	},
	{#State 362
		DEFAULT => -66
	},
	{#State 363
		ACTIONS => {
			"my" => 378
		}
	},
	{#State 364
		DEFAULT => -48
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 366
		ACTIONS => {
			'OP23_LOGICAL_AND' => -109,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => -109,
			'OP06_REGEX_MATCH' => 158,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			")" => 380,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 152
		}
	},
	{#State 367
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 368
		ACTIONS => {
			'OP23_LOGICAL_AND' => 145,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_STRING_CAT' => 157,
			'OP18_TERNARY' => 159,
			'OP06_REGEX_MATCH' => 158,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			")" => 382,
			'OP11_COMPARE_LT_GT' => 154,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153
		}
	},
	{#State 369
		DEFAULT => -156
	},
	{#State 370
		ACTIONS => {
			"\@{" => 85,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			"%{" => 87,
			'OP01_NAMED' => 123,
			'VARIABLE_SYMBOL' => 104,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'LBRACE' => 99,
			'WORD' => 22,
			'OP22_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayDereferenced' => 114,
			'ArrayReference' => 84,
			'Operator' => 111,
			'HashReference' => 98,
			'WordScoped' => 97,
			'SubExpression' => 383,
			'Expression' => 126,
			'Variable' => 124,
			'HashDereferenced' => 81
		}
	},
	{#State 371
		DEFAULT => -61
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
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
			"%{" => 87,
			'WORD' => 335
		},
		GOTOS => {
			'HashDereferenced' => 336,
			'HashEntryTyped' => 388
		}
	},
	{#State 375
		ACTIONS => {
			";" => 389
		}
	},
	{#State 376
		DEFAULT => -63
	},
	{#State 377
		ACTIONS => {
			"%{" => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"\@{" => 85,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 123,
			'LBRACE' => 99,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 76,
			'WORD' => 22
		},
		GOTOS => {
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'WordScoped' => 97,
			'HashReference' => 98,
			'Operator' => 111,
			'ArrayReference' => 84,
			'Expression' => 126,
			'SubExpression' => 390,
			'HashDereferenced' => 81,
			'Variable' => 124
		}
	},
	{#State 378
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 391
		}
	},
	{#State 379
		ACTIONS => {
			"\@_;" => 392
		}
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 393
		}
	},
	{#State 381
		DEFAULT => -164
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 394
		}
	},
	{#State 383
		ACTIONS => {
			"}" => -87,
			'OP18_TERNARY' => 159,
			"]" => -87,
			'OP06_REGEX_MATCH' => 158,
			";" => -87,
			'OP08_STRING_CAT' => 157,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP13_BITWISE_AND' => 155,
			")" => -87,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP16_LOGICAL_OR' => 148,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 385
		DEFAULT => -68
	},
	{#State 386
		ACTIONS => {
			'WORD' => 335,
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 336,
			'HashEntryTyped' => 396
		}
	},
	{#State 387
		ACTIONS => {
			";" => 397
		}
	},
	{#State 388
		DEFAULT => -62
	},
	{#State 389
		DEFAULT => -65
	},
	{#State 390
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP09_BITWISE_SHIFT' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -198,
			'OP15_LOGICAL_AND' => 147,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 153,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 154,
			'OP13_BITWISE_AND' => 155,
			")" => -198,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP18_TERNARY' => 159,
			'OP08_STRING_CAT' => 157
		}
	},
	{#State 391
		ACTIONS => {
			'VARIABLE_SYMBOL' => 398
		}
	},
	{#State 392
		DEFAULT => -50
	},
	{#State 393
		DEFAULT => -163
	},
	{#State 394
		DEFAULT => -153
	},
	{#State 395
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -72,
			'OP01_CLOSE' => -72,
			'LITERAL_STRING' => -72,
			"my" => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'LBRACKET' => -72,
			"undef" => -72,
			'LBRACE' => -72,
			"for my integer" => -72,
			'WORD' => -72,
			'OP01_PRINT' => -72,
			'OP22_LOGICAL_NEG' => -72,
			"( my" => 399,
			"foreach my" => -72,
			'OP10_NAMED_UNARY' => -72,
			'LITERAL_NUMBER' => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			"\@{" => -72,
			'OP01_OPEN' => -72,
			'LPAREN' => -72,
			"%{" => -72,
			'OP01_NAMED_VOID' => -72,
			'OP01_NAMED' => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			'WORD_SCOPED' => -72,
			"if (" => -72,
			"while (" => -72
		},
		GOTOS => {
			'OPTIONAL-29' => 400,
			'MethodArguments' => 401
		}
	},
	{#State 396
		DEFAULT => -67
	},
	{#State 397
		DEFAULT => -70
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 402
		}
	},
	{#State 400
		ACTIONS => {
			'OP01_PRINT' => 91,
			'WORD' => 70,
			'OP22_LOGICAL_NEG' => 76,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 74,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'OP03_MATH_INC_DEC' => 78,
			"my" => 77,
			'LITERAL_STRING' => 96,
			'OP01_CLOSE' => 95,
			"undef" => 80,
			'LBRACKET' => 102,
			'OP19_LOOP_CONTROL' => 100,
			'OP05_LOGICAL_NEG' => 101,
			"for my integer" => -147,
			'LBRACE' => 99,
			'OP01_NAMED_VOID' => 108,
			'OP01_NAMED' => 107,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 23,
			'OP10_STRINGIFY_UNARY' => 110,
			"while (" => -147,
			"if (" => 109,
			"\@{" => 85,
			'LPAREN' => 89,
			'OP01_OPEN' => 113,
			"%{" => 87
		},
		GOTOS => {
			'Conditional' => 90,
			'Expression' => 71,
			'OperatorVoid' => 72,
			'LoopLabel' => 94,
			'SubExpression' => 92,
			'WordScoped' => 97,
			'HashReference' => 98,
			'VariableDeclaration' => 79,
			'PLUS-30' => 404,
			'HashDereferenced' => 81,
			'Operation' => 403,
			'Variable' => 103,
			'OPTIONAL-40' => 106,
			'VariableModification' => 83,
			'Operator' => 111,
			'Statement' => 86,
			'ArrayReference' => 84,
			'PAREN-39' => 112,
			'ArrayDereferenced' => 114,
			'Literal' => 88
		}
	},
	{#State 401
		DEFAULT => -71
	},
	{#State 402
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 405
		}
	},
	{#State 403
		DEFAULT => -74
	},
	{#State 404
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LITERAL_STRING' => 96,
			"my" => 77,
			'OP03_MATH_INC_DEC' => 78,
			"}" => 406,
			'LBRACE' => 99,
			"for my integer" => -147,
			'OP19_LOOP_CONTROL' => 100,
			'OP05_LOGICAL_NEG' => 101,
			"undef" => 80,
			'LBRACKET' => 102,
			'WORD' => 70,
			'OP01_PRINT' => 91,
			"foreach my" => -147,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 74,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 76,
			"\@{" => 85,
			"%{" => 87,
			'OP01_OPEN' => 113,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 107,
			'OP01_NAMED_VOID' => 108,
			"if (" => 109,
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'HashDereferenced' => 81,
			'Operation' => 407,
			'Variable' => 103,
			'OPTIONAL-40' => 106,
			'VariableModification' => 83,
			'Operator' => 111,
			'Statement' => 86,
			'ArrayReference' => 84,
			'PAREN-39' => 112,
			'ArrayDereferenced' => 114,
			'Literal' => 88,
			'Conditional' => 90,
			'Expression' => 71,
			'OperatorVoid' => 72,
			'SubExpression' => 92,
			'LoopLabel' => 94,
			'WordScoped' => 97,
			'HashReference' => 98,
			'VariableDeclaration' => 79
		}
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 409,
			")" => 408
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
			'WORD' => 58
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
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
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
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
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
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6427 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
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
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
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
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
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
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6976 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
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
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
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
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
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
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
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
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
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
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
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
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
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
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
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
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7686 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
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

#line 197 "lib/RPerl/Grammar.eyp"


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
