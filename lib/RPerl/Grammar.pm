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
    our $VERSION = 0.000_910;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|while\ \(|\$TYPED_|package|elsif\ \(|\=\ sub\ \{|undef|if\ \(|else|\(\ my|qw\(|\@_\;|use|our|my|\@\{|\%\{|\;|\]|\)|\})}gc and return ($1, $1);

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
  [ 'Operator_110' => 'Operator', [ 'OP22_LOGICAL_NOT', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LPAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_140' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_141' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'OPTIONAL-39', 'Loop' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'PAREN-40' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'PAREN-42' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Conditional_156' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-41', 'OPTIONAL-43' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_158' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_159' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_160' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_161' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_162' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'CodeBlock_165' => 'CodeBlock', [ 'LBRACE', 'PLUS-44', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'Variable_168' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-45' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_170' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_171' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_173' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_175' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'PLUS-48', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'WORD' ], 0 ],
  [ 'ListElements_181' => 'ListElements', [ 'ListElement', 'STAR-47' ], 0 ],
  [ 'ListElements_182' => 'ListElements', [ 'OP01_QW', 'LPAREN', 'PLUS-48', ')' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_184' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_185' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayReference_188' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-49', ']' ], 0 ],
  [ 'ArrayDereferenced_189' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_190' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_200' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashDereferenced_201' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_202' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_203' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_204' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_205' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_206' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_207' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_208' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_209' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_210' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_211' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  'Expression_127' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpressionOrStdin_140' => 140,
  'SubExpressionOrStdin_141' => 141,
  '_PAREN' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  'Statement_148' => 148,
  'Statement_149' => 149,
  '_PAREN' => 150,
  '_STAR_LIST' => 151,
  '_STAR_LIST' => 152,
  '_PAREN' => 153,
  '_OPTIONAL' => 154,
  '_OPTIONAL' => 155,
  'Conditional_156' => 156,
  'Loop_157' => 157,
  'Loop_158' => 158,
  'Loop_159' => 159,
  'LoopFor_160' => 160,
  'LoopForEach_161' => 161,
  'LoopWhile_162' => 162,
  '_PLUS_LIST' => 163,
  '_PLUS_LIST' => 164,
  'CodeBlock_165' => 165,
  '_STAR_LIST' => 166,
  '_STAR_LIST' => 167,
  'Variable_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableRetrieval_170' => 170,
  'VariableRetrieval_171' => 171,
  'VariableDeclaration_172' => 172,
  'VariableDeclaration_173' => 173,
  'VariableModification_174' => 174,
  'VariableModification_175' => 175,
  '_PAREN' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  '_PLUS_LIST' => 179,
  '_PLUS_LIST' => 180,
  'ListElements_181' => 181,
  'ListElements_182' => 182,
  'ListElement_183' => 183,
  'ListElement_184' => 184,
  'ListElement_185' => 185,
  '_OPTIONAL' => 186,
  '_OPTIONAL' => 187,
  'ArrayReference_188' => 188,
  'ArrayDereferenced_189' => 189,
  'ArrayDereferenced_190' => 190,
  '_OPTIONAL' => 191,
  '_OPTIONAL' => 192,
  'HashEntry_193' => 193,
  'HashEntry_194' => 194,
  'HashEntryTyped_195' => 195,
  'HashEntryTyped_196' => 196,
  '_PAREN' => 197,
  '_STAR_LIST' => 198,
  '_STAR_LIST' => 199,
  'HashReference_200' => 200,
  'HashDereferenced_201' => 201,
  'HashDereferenced_202' => 202,
  'WordScoped_203' => 203,
  'WordScoped_204' => 204,
  'LoopLabel_205' => 205,
  'Type_206' => 206,
  'TypeInner_207' => 207,
  'VariableOrLiteral_208' => 208,
  'VariableOrLiteral_209' => 209,
  'Literal_210' => 210,
  'Literal_211' => 211,
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
	OP22_LOGICAL_NOT => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 4,
			'SHEBANG' => 2,
			"package" => -20
		},
		GOTOS => {
			'Program' => 6,
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 8,
			'CompileUnit' => 7,
			'PLUS-2' => 1,
			'Critic' => 9,
			'PAREN-1' => 3
		}
	},
	{#State 1
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 4,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 9,
			'PAREN-1' => 10,
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 8
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-14' => 14
		}
	},
	{#State 5
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"use" => -25,
			"use parent qw(" => 19,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Package' => 17,
			'STAR-10' => 18,
			'Class' => 15
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			'' => 20
		}
	},
	{#State 8
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 22
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -35
	},
	{#State 14
		ACTIONS => {
			")" => 25,
			'WORD' => 24
		}
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		ACTIONS => {
			"## no critic qw(" => 4,
			"use constant" => -27,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 27
		}
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 32
		}
	},
	{#State 23
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 24
		DEFAULT => -34
	},
	{#State 25
		DEFAULT => -36
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 34
		}
	},
	{#State 28
		ACTIONS => {
			")" => 37
		}
	},
	{#State 29
		DEFAULT => -203
	},
	{#State 30
		DEFAULT => -204
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"for my integer" => -11,
			"foreach my" => -11,
			"undef" => -11,
			'OP01_NAMED' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"## no critic qw(" => 4,
			'WORD' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"use" => -11,
			'OP01_OPEN' => -11,
			"\@{" => -11,
			"our" => -11,
			'LPAREN' => -11,
			"use constant" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_STRING' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_PRINT' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			"my" => -11,
			'LBRACKET' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_NUMBER' => -11,
			"while (" => -11,
			"if (" => -11,
			"%{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_SCOPED' => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'STAR-5' => 40,
			'Critic' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 41
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			"use constant" => 43,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 44,
			'PLUS-13' => 45,
			'Constant' => 46
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 47
		}
	},
	{#State 37
		ACTIONS => {
			";" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		DEFAULT => -8
	},
	{#State 40
		ACTIONS => {
			"for my integer" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"foreach my" => -13,
			'OP01_NAMED' => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD' => -13,
			"use" => 36,
			'OP05_MATH_NEG_LPAREN' => -13,
			"use constant" => -13,
			'LPAREN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			'OP01_PRINT' => -13,
			'LITERAL_STRING' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_CLOSE' => -13,
			'LBRACKET' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			"while (" => -13,
			"if (" => -13,
			"%{" => -13
		},
		GOTOS => {
			'Include' => 50,
			'STAR-6' => 51
		}
	},
	{#State 41
		ACTIONS => {
			"our" => 52
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 55
		}
	},
	{#State 44
		DEFAULT => -31
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			"qw(" => 59,
			";" => 58
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -10
	},
	{#State 51
		ACTIONS => {
			'WORD_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"use constant" => 43,
			'LBRACE' => -15,
			"while (" => -15,
			'OP01_OPEN' => -15,
			"\@{" => -15,
			"%{" => -15,
			"if (" => -15,
			"our" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD' => -15,
			'LITERAL_NUMBER' => -15,
			'LBRACKET' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID' => -15,
			"my" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			"undef" => -15,
			"foreach my" => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_PRINT' => -15,
			"for my integer" => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 61
		}
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 63
		}
	},
	{#State 53
		DEFAULT => -206
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
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
		ACTIONS => {
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP19_LOOP_CONTROL' => 101,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"while (" => -144,
			"\@{" => 74,
			"our" => 42,
			"if (" => 98,
			"%{" => 99,
			'OP01_PRINT' => 107,
			"for my integer" => -144,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_NAMED_VOID' => 89,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 114,
			"foreach my" => -144,
			"undef" => 84,
			'OP01_NAMED' => 85,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112
		},
		GOTOS => {
			'Subroutine' => 113,
			'VariableDeclaration' => 91,
			'OPTIONAL-39' => 108,
			'SubExpression' => 86,
			'Literal' => 109,
			'Variable' => 88,
			'HashReference' => 111,
			'PAREN-38' => 106,
			'OperatorVoid' => 82,
			'LoopLabel' => 83,
			'Statement' => 104,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'Conditional' => 79,
			'HashDereferenced' => 75,
			'Expression' => 95,
			'Operation' => 96,
			'VariableModification' => 97,
			'Operator' => 76,
			'PLUS-8' => 100,
			'ArrayDereferenced' => 72
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
			"= sub {" => 115
		}
	},
	{#State 65
		ACTIONS => {
			"my" => 117
		},
		GOTOS => {
			'TypeInner' => 116
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
			"our %properties = (" => -54,
			"use constant" => -54,
			"use" => -54,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 120,
			'STAR-21' => 121
		}
	},
	{#State 70
		ACTIONS => {
			'LPAREN' => -203,
			'COLON' => -205
		}
	},
	{#State 71
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 124,
			'Expression' => 122,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111
		}
	},
	{#State 72
		DEFAULT => -135
	},
	{#State 73
		ACTIONS => {
			"my" => 126
		}
	},
	{#State 74
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Variable' => 127,
			'ArrayReference' => 128
		}
	},
	{#State 75
		DEFAULT => -137
	},
	{#State 76
		DEFAULT => -127
	},
	{#State 77
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 130,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_PRINT' => 131,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111,
			'SubExpression' => 129,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109
		}
	},
	{#State 78
		DEFAULT => -167,
		GOTOS => {
			'STAR-45' => 132
		}
	},
	{#State 79
		DEFAULT => -145
	},
	{#State 80
		ACTIONS => {
			'LPAREN' => 133
		}
	},
	{#State 81
		DEFAULT => -134
	},
	{#State 82
		DEFAULT => -147
	},
	{#State 83
		ACTIONS => {
			'COLON' => 134
		}
	},
	{#State 84
		DEFAULT => -131
	},
	{#State 85
		ACTIONS => {
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LITERAL_NUMBER' => 94,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'KEYS_OR_VALUES' => 135,
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117
		},
		GOTOS => {
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76,
			'Literal' => 109,
			'SubExpression' => 138,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'ListElement' => 137,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'TypeInner' => 136
		}
	},
	{#State 86
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 87
		ACTIONS => {
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'OP23_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_NAMED_UNARY' => 87,
			'OP08_STRING_CAT' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP03_MATH_INC_DEC' => 90,
			'OP17_LIST_RANGE' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP18_TERNARY' => -100,
			"]" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			"%{" => 99,
			'OP08_MATH_ADD_SUB' => -100,
			'WORD_SCOPED' => 30,
			'OP04_MATH_POW' => -100,
			'LBRACE' => 102,
			")" => -100,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			";" => -100,
			'LITERAL_NUMBER' => 94,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => -100,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP11_COMPARE_LT_GT' => -100,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"}" => -100
		},
		GOTOS => {
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76,
			'SubExpression' => 155,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81
		}
	},
	{#State 88
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -133,
			'OP03_MATH_INC_DEC' => 156,
			'OP19_VARIABLE_ASSIGN' => 158,
			'OP13_BITWISE_AND' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP08_STRING_CAT' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP19_VARIABLE_ASSIGN_BY' => 157,
			'OP17_LIST_RANGE' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP04_MATH_POW' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP18_TERNARY' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP02_METHOD_THINARROW' => 159,
			'OP23_LOGICAL_AND' => -133
		}
	},
	{#State 89
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'KEYS_OR_VALUES' => 135,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			";" => -117,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'SubExpression' => 164,
			'Literal' => 109,
			'Expression' => 122,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ListElements' => 160,
			'OPTIONAL-35' => 161,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163
		}
	},
	{#State 90
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 165
		}
	},
	{#State 91
		DEFAULT => -148
	},
	{#State 92
		ACTIONS => {
			'FH_REF_SYMBOL' => 166
		}
	},
	{#State 93
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"]" => -187,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP01_QW' => 162,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'Expression' => 122,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 164,
			'Variable' => 123,
			'Operator' => 76,
			'ListElements' => 168,
			'HashReference' => 111,
			'OPTIONAL-49' => 167,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163
		}
	},
	{#State 94
		DEFAULT => -211
	},
	{#State 95
		ACTIONS => {
			'OP18_TERNARY' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP04_MATH_POW' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP23_LOGICAL_AND' => -130,
			";" => 169,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP08_STRING_CAT' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP17_LIST_RANGE' => -130
		}
	},
	{#State 96
		DEFAULT => -17
	},
	{#State 97
		DEFAULT => -149
	},
	{#State 98
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 170,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111
		}
	},
	{#State 99
		ACTIONS => {
			'LBRACE' => 173,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 171,
			'HashReference' => 172
		}
	},
	{#State 100
		ACTIONS => {
			'' => -18,
			'LITERAL_NUMBER' => 94,
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LBRACE' => 102,
			'OP19_LOOP_CONTROL' => 101,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			"if (" => 98,
			"%{" => 99,
			"while (" => -144,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"for my integer" => -144,
			'OP01_PRINT' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 114,
			'OP01_NAMED_VOID' => 89,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			"foreach my" => -144,
			"undef" => 84,
			'OP01_NAMED' => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'Operator' => 76,
			'VariableModification' => 97,
			'Expression' => 95,
			'Operation' => 174,
			'HashDereferenced' => 75,
			'Conditional' => 79,
			'Statement' => 104,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'PAREN-38' => 106,
			'OperatorVoid' => 82,
			'LoopLabel' => 83,
			'Variable' => 88,
			'HashReference' => 111,
			'OPTIONAL-39' => 108,
			'Literal' => 109,
			'SubExpression' => 86,
			'VariableDeclaration' => 91
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 176
		},
		GOTOS => {
			'LoopLabel' => 175
		}
	},
	{#State 102
		ACTIONS => {
			"}" => 177,
			'WORD' => 178,
			"%{" => 99
		},
		GOTOS => {
			'HashEntry' => 180,
			'HashDereferenced' => 179
		}
	},
	{#State 103
		DEFAULT => -210
	},
	{#State 104
		DEFAULT => -83
	},
	{#State 105
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102
		},
		GOTOS => {
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 181,
			'Expression' => 122,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 106
		DEFAULT => -143
	},
	{#State 107
		ACTIONS => {
			'LITERAL_STRING' => -115,
			'STDOUT_STDERR' => 185,
			'OP05_LOGICAL_NEG' => -115,
			'OP01_NAMED' => -115,
			"undef" => -115,
			'OP10_STRINGIFY_UNARY' => -115,
			'OP22_LOGICAL_NOT' => -115,
			'OP10_NAMED_UNARY' => -115,
			"my" => -115,
			'OP03_MATH_INC_DEC' => -115,
			'LBRACKET' => -115,
			'OP01_CLOSE' => -115,
			'OP05_MATH_NEG_LPAREN' => -115,
			'WORD' => -115,
			'OP01_QW' => -115,
			'LITERAL_NUMBER' => -115,
			'OP01_OPEN' => -115,
			"\@{" => -115,
			"%{" => -115,
			'WORD_SCOPED' => -115,
			'VARIABLE_SYMBOL' => -115,
			'LPAREN' => -115,
			'LBRACE' => -115,
			'KEYS_OR_VALUES' => -115,
			'FH_REF_SYMBOL_BRACES' => 183
		},
		GOTOS => {
			'PAREN-33' => 184,
			'OPTIONAL-34' => 182
		}
	},
	{#State 108
		ACTIONS => {
			"foreach my" => 186,
			"while (" => 190,
			"for my integer" => 188
		},
		GOTOS => {
			'Loop' => 191,
			'LoopWhile' => 189,
			'LoopForEach' => 187,
			'LoopFor' => 192
		}
	},
	{#State 109
		DEFAULT => -132
	},
	{#State 110
		ACTIONS => {
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LBRACE' => 102,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Expression' => 122,
			'SubExpression' => 193,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80
		}
	},
	{#State 111
		DEFAULT => -136
	},
	{#State 112
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102
		},
		GOTOS => {
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 194,
			'Expression' => 122,
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80
		}
	},
	{#State 113
		DEFAULT => -14
	},
	{#State 114
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 195
		}
	},
	{#State 115
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -43,
			'LPAREN' => -43,
			'WORD_SCOPED' => -43,
			'VARIABLE_SYMBOL' => -43,
			'LBRACE' => -43,
			'OP01_OPEN' => -43,
			"\@{" => -43,
			"while (" => -43,
			"if (" => -43,
			"%{" => -43,
			'WORD' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_CLOSE' => -43,
			'LBRACKET' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"my" => -43,
			"foreach my" => -43,
			"undef" => -43,
			'OP01_NAMED' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'OP01_PRINT' => -43,
			"for my integer" => -43,
			"( my" => 198,
			'LITERAL_STRING' => -43,
			'OP05_LOGICAL_NEG' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 197,
			'OPTIONAL-16' => 196
		}
	},
	{#State 116
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'Literal' => 199
		}
	},
	{#State 117
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 200
		}
	},
	{#State 118
		ACTIONS => {
			";" => 201
		}
	},
	{#State 119
		DEFAULT => -37
	},
	{#State 120
		DEFAULT => -51
	},
	{#State 121
		ACTIONS => {
			"use constant" => -56,
			"use" => 36,
			"our %properties = (" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 202
		}
	},
	{#State 122
		DEFAULT => -130
	},
	{#State 123
		ACTIONS => {
			'OP18_TERNARY' => -133,
			"]" => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP04_MATH_POW' => -133,
			")" => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP02_METHOD_THINARROW' => 159,
			'OP23_LOGICAL_AND' => -133,
			";" => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP21_LIST_COMMA' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP08_STRING_CAT' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP03_MATH_INC_DEC' => 156,
			'OP11_COMPARE_LT_GT' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP17_LIST_RANGE' => -133,
			"}" => -133
		}
	},
	{#State 124
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			'OP08_MATH_ADD_SUB' => 141,
			")" => 204,
			'OP04_MATH_POW' => 142,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 125
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93
		},
		GOTOS => {
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'SubExpression' => 205,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'Expression' => 122,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72
		}
	},
	{#State 126
		ACTIONS => {
			"filehandle_ref" => 206
		}
	},
	{#State 127
		ACTIONS => {
			"}" => 207
		}
	},
	{#State 128
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 129
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			")" => 209,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 130
		ACTIONS => {
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'Expression' => 122,
			'SubExpression' => 138,
			'Literal' => 109,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ListElement' => 210,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72
		}
	},
	{#State 131
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 211
		}
	},
	{#State 132
		ACTIONS => {
			'OP06_REGEX_MATCH' => -168,
			'OP08_STRING_CAT' => -168,
			'OP11_COMPARE_LT_GT' => -168,
			'OP03_MATH_INC_DEC' => -168,
			'OP13_BITWISE_AND' => -168,
			'OP19_VARIABLE_ASSIGN' => -168,
			'COLON' => -168,
			'OP07_MATH_MULT_DIV_MOD' => -168,
			'OP19_VARIABLE_ASSIGN_BY' => -168,
			"}" => -168,
			'OP17_LIST_RANGE' => -168,
			'OP16_LOGICAL_OR' => -168,
			'OP09_BITWISE_SHIFT' => -168,
			'OP18_TERNARY' => -168,
			"]" => -168,
			'OP02_ARRAY_THINARROW' => 212,
			")" => -168,
			'OP04_MATH_POW' => -168,
			'OP08_MATH_ADD_SUB' => -168,
			'OP14_BITWISE_OR_XOR' => -168,
			'OP02_HASH_THINARROW' => 213,
			'OP02_METHOD_THINARROW' => -168,
			'OP23_LOGICAL_AND' => -168,
			'OP15_LOGICAL_AND' => -168,
			'OP24_LOGICAL_OR_XOR' => -168,
			'OP21_LIST_COMMA' => -168,
			";" => -168,
			'OP12_COMPARE_EQ_NE' => -168
		},
		GOTOS => {
			'VariableRetrieval' => 214
		}
	},
	{#State 133
		ACTIONS => {
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'KEYS_OR_VALUES' => 135,
			")" => -124,
			'LBRACE' => 102,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'OPTIONAL-36' => 215,
			'Expression' => 122,
			'SubExpression' => 164,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ListElements' => 216,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72
		}
	},
	{#State 134
		DEFAULT => -142
	},
	{#State 135
		ACTIONS => {
			"%{" => 99
		},
		GOTOS => {
			'HashDereferenced' => 217
		}
	},
	{#State 136
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'SubExpression' => 218,
			'Literal' => 109,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76
		}
	},
	{#State 137
		ACTIONS => {
			'OP21_LIST_COMMA' => 219
		}
	},
	{#State 138
		ACTIONS => {
			'OP13_BITWISE_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP04_MATH_POW' => -85,
			")" => -85,
			'OP18_TERNARY' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -183,
			'OP15_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP14_BITWISE_OR_XOR' => -85
		}
	},
	{#State 139
		ACTIONS => {
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LBRACE' => 102,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Literal' => 109,
			'SubExpression' => 220,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72
		}
	},
	{#State 140
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'SubExpression' => 221
		}
	},
	{#State 141
		ACTIONS => {
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 222,
			'HashDereferenced' => 75,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'Literal' => 109,
			'Expression' => 122,
			'SubExpression' => 223,
			'HashDereferenced' => 75,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'VariableOrLiteral' => 225,
			'Literal' => 226,
			'Variable' => 224
		}
	},
	{#State 144
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 122,
			'SubExpression' => 227,
			'HashDereferenced' => 75,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80
		}
	},
	{#State 145
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93
		},
		GOTOS => {
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 228,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123
		}
	},
	{#State 146
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 229
		}
	},
	{#State 147
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LITERAL_NUMBER' => 94,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'Literal' => 109,
			'Expression' => 122,
			'SubExpression' => 230,
			'HashDereferenced' => 75,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 231,
			'Expression' => 122,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 149
		ACTIONS => {
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LITERAL_NUMBER' => 94,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP03_MATH_INC_DEC' => 90,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 232,
			'HashDereferenced' => 75,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 233,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72
		}
	},
	{#State 151
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'LITERAL_NUMBER' => 94,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73
		},
		GOTOS => {
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 234,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123
		}
	},
	{#State 152
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 235,
			'Expression' => 122,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'HashDereferenced' => 75,
			'SubExpression' => 236,
			'Expression' => 122,
			'Literal' => 109,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123
		}
	},
	{#State 154
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'SubExpression' => 237,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 155
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -99,
			'OP18_TERNARY' => -99,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => 144,
			'OP12_COMPARE_EQ_NE' => -99,
			";" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 156
		DEFAULT => -90
	},
	{#State 157
		ACTIONS => {
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 238,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90,
			'STDIN' => 239,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77
		},
		GOTOS => {
			'SubExpressionOrStdin' => 241,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 240
		}
	},
	{#State 159
		ACTIONS => {
			'WORD' => 242
		}
	},
	{#State 160
		DEFAULT => -116
	},
	{#State 161
		ACTIONS => {
			";" => 243
		}
	},
	{#State 162
		ACTIONS => {
			'LPAREN' => 244
		}
	},
	{#State 163
		DEFAULT => -178,
		GOTOS => {
			'STAR-47' => 245
		}
	},
	{#State 164
		ACTIONS => {
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -183,
			'OP15_LOGICAL_AND' => 140,
			'OP21_LIST_COMMA' => -183,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP18_TERNARY' => 143,
			"]" => -183,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -183,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145
		}
	},
	{#State 165
		DEFAULT => -89
	},
	{#State 166
		DEFAULT => -88
	},
	{#State 167
		ACTIONS => {
			"]" => 246
		}
	},
	{#State 168
		DEFAULT => -186
	},
	{#State 169
		DEFAULT => -82
	},
	{#State 170
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => 247,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 171
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 172
		ACTIONS => {
			"}" => 249
		}
	},
	{#State 173
		ACTIONS => {
			"%{" => 99,
			'WORD' => 178
		},
		GOTOS => {
			'HashDereferenced' => 179,
			'HashEntry' => 180
		}
	},
	{#State 174
		DEFAULT => -16
	},
	{#State 175
		ACTIONS => {
			";" => 250
		}
	},
	{#State 176
		DEFAULT => -205
	},
	{#State 177
		DEFAULT => -138
	},
	{#State 178
		ACTIONS => {
			'OP20_HASH_FATARROW' => 251
		}
	},
	{#State 179
		DEFAULT => -194
	},
	{#State 180
		DEFAULT => -199,
		GOTOS => {
			'STAR-52' => 252
		}
	},
	{#State 181
		ACTIONS => {
			'OP18_TERNARY' => -92,
			"]" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 142,
			")" => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP23_LOGICAL_AND' => -92,
			";" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP08_STRING_CAT' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP17_LIST_RANGE' => -92
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'SubExpression' => 164,
			'Expression' => 122,
			'Literal' => 109,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ListElements' => 253,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72
		}
	},
	{#State 183
		ACTIONS => {
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'KEYS_OR_VALUES' => 135,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72,
			'Expression' => 122,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 164,
			'HashReference' => 111,
			'ListElements' => 254,
			'Variable' => 123,
			'Operator' => 76
		}
	},
	{#State 184
		DEFAULT => -114
	},
	{#State 185
		DEFAULT => -113
	},
	{#State 186
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 255
		}
	},
	{#State 187
		DEFAULT => -158
	},
	{#State 188
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 189
		DEFAULT => -159
	},
	{#State 190
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74
		},
		GOTOS => {
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 257,
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72
		}
	},
	{#State 191
		DEFAULT => -146
	},
	{#State 192
		DEFAULT => -157
	},
	{#State 193
		ACTIONS => {
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => 151,
			"}" => -110,
			'OP16_LOGICAL_OR' => 150,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			"]" => -110,
			")" => -110,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => -110,
			'OP15_LOGICAL_AND' => 140,
			'OP21_LIST_COMMA' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			";" => -110,
			'OP12_COMPARE_EQ_NE' => 147
		}
	},
	{#State 194
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			")" => 258,
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 259
		}
	},
	{#State 196
		ACTIONS => {
			'LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 101,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"while (" => -144,
			"\@{" => 74,
			"if (" => 98,
			"%{" => 99,
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP01_NAMED_VOID' => 89,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 114,
			"foreach my" => -144,
			"undef" => 84,
			'OP01_NAMED' => 85,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP01_PRINT' => 107,
			"for my integer" => -144,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'LoopLabel' => 83,
			'PAREN-38' => 106,
			'OperatorVoid' => 82,
			'PLUS-17' => 261,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'Statement' => 104,
			'VariableDeclaration' => 91,
			'SubExpression' => 86,
			'Literal' => 109,
			'OPTIONAL-39' => 108,
			'HashReference' => 111,
			'Variable' => 88,
			'ArrayDereferenced' => 72,
			'Conditional' => 79,
			'Operation' => 260,
			'Expression' => 95,
			'HashDereferenced' => 75,
			'Operator' => 76,
			'VariableModification' => 97
		}
	},
	{#State 197
		DEFAULT => -42
	},
	{#State 198
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 262
		}
	},
	{#State 199
		ACTIONS => {
			";" => 263
		}
	},
	{#State 200
		ACTIONS => {
			"\$TYPED_" => 264
		}
	},
	{#State 201
		DEFAULT => -40
	},
	{#State 202
		ACTIONS => {
			"our %properties = (" => 266,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 265,
			'Constant' => 267
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		DEFAULT => -93
	},
	{#State 205
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			"}" => -85,
			'OP17_LIST_RANGE' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP18_TERNARY' => -85,
			"]" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			")" => -85,
			'OP04_MATH_POW' => -85
		}
	},
	{#State 206
		ACTIONS => {
			'FH_REF_SYMBOL' => 268
		}
	},
	{#State 207
		DEFAULT => -189
	},
	{#State 208
		DEFAULT => -190
	},
	{#State 209
		DEFAULT => -139
	},
	{#State 210
		ACTIONS => {
			'OP21_LIST_COMMA' => 269
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112
		},
		GOTOS => {
			'TypeInner' => 136,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ListElement' => 163,
			'HashDereferenced' => 75,
			'SubExpression' => 164,
			'Expression' => 122,
			'Literal' => 109,
			'Operator' => 76,
			'Variable' => 123,
			'HashReference' => 111,
			'ListElements' => 270
		}
	},
	{#State 212
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP03_MATH_INC_DEC' => 90,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACE' => 102
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'Literal' => 109,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'SubExpression' => 271,
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76
		}
	},
	{#State 213
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'WORD' => 272,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP01_NAMED' => 125,
			"undef" => 84
		},
		GOTOS => {
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'Expression' => 122,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 273
		}
	},
	{#State 214
		DEFAULT => -166
	},
	{#State 215
		ACTIONS => {
			")" => 274
		}
	},
	{#State 216
		DEFAULT => -123
	},
	{#State 217
		DEFAULT => -185
	},
	{#State 218
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -184,
			'OP18_TERNARY' => 143,
			"]" => -184,
			'OP09_BITWISE_SHIFT' => 144,
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -184,
			'OP21_LIST_COMMA' => -184,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 219
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP01_QW' => 162,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73
		},
		GOTOS => {
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ListElements' => 275,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 164,
			'ListElement' => 163,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72,
			'TypeInner' => 136
		}
	},
	{#State 220
		ACTIONS => {
			'OP18_TERNARY' => 143,
			"]" => -112,
			'OP09_BITWISE_SHIFT' => 144,
			'OP04_MATH_POW' => 142,
			")" => -112,
			'OP08_MATH_ADD_SUB' => 141,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			";" => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => 150,
			"}" => -112,
			'OP17_LIST_RANGE' => 151
		}
	},
	{#State 221
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => 144,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			"}" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP16_LOGICAL_OR' => -106
		}
	},
	{#State 222
		ACTIONS => {
			'OP08_STRING_CAT' => -96,
			'OP06_REGEX_MATCH' => 146,
			'OP11_COMPARE_LT_GT' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			"}" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP18_TERNARY' => -96,
			"]" => -96,
			")" => -96,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP15_LOGICAL_AND' => -96,
			";" => -96,
			'OP12_COMPARE_EQ_NE' => -96
		}
	},
	{#State 223
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP17_LIST_RANGE' => -91,
			"}" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_STRING_CAT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			";" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP23_LOGICAL_AND' => -91,
			")" => -91,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			"]" => -91,
			'OP18_TERNARY' => -91
		}
	},
	{#State 224
		DEFAULT => -208
	},
	{#State 225
		ACTIONS => {
			'COLON' => 276
		}
	},
	{#State 226
		DEFAULT => -209
	},
	{#State 227
		ACTIONS => {
			'OP17_LIST_RANGE' => -98,
			"}" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP13_BITWISE_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			";" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 141,
			")" => -98,
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => -98,
			"]" => -98,
			'OP18_TERNARY' => -98
		}
	},
	{#State 228
		ACTIONS => {
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP11_COMPARE_LT_GT' => undef,
			'OP13_BITWISE_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => -102,
			"}" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => -102,
			"]" => -102,
			")" => -102,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => -102,
			";" => -102,
			'OP12_COMPARE_EQ_NE' => -102
		}
	},
	{#State 229
		DEFAULT => -94
	},
	{#State 230
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			";" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP12_COMPARE_EQ_NE' => undef,
			"]" => -103,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 144,
			'OP04_MATH_POW' => 142,
			")" => -103,
			'OP08_MATH_ADD_SUB' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => -103,
			"}" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => -103
		}
	},
	{#State 231
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			"}" => -111,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 142,
			")" => -111,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => 143,
			"]" => -111,
			'OP09_BITWISE_SHIFT' => 144,
			";" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => -111
		}
	},
	{#State 232
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => -105,
			"}" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -105,
			'OP18_TERNARY' => -105,
			"]" => -105,
			'OP09_BITWISE_SHIFT' => 144,
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105
		}
	},
	{#State 233
		ACTIONS => {
			")" => -107,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => -107,
			"]" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP15_LOGICAL_AND' => 140,
			";" => -107,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => -107,
			"}" => -107,
			'OP17_LIST_RANGE' => -107
		}
	},
	{#State 234
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP15_LOGICAL_AND' => 140,
			'OP23_LOGICAL_AND' => -108,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -108,
			"]" => -108,
			'OP18_TERNARY' => -108,
			'OP09_BITWISE_SHIFT' => 144,
			"}" => -108,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146
		}
	},
	{#State 235
		ACTIONS => {
			"]" => -95,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP04_MATH_POW' => 142,
			")" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			";" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP16_LOGICAL_OR' => -95,
			"}" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95
		}
	},
	{#State 236
		ACTIONS => {
			"]" => -104,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP13_BITWISE_AND' => -104,
			'OP11_COMPARE_LT_GT' => 145,
			"}" => -104,
			'OP17_LIST_RANGE' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 237
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 152,
			"}" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => -97,
			";" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 142,
			")" => -97,
			'OP08_MATH_ADD_SUB' => 141,
			"]" => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => -97
		}
	},
	{#State 238
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			";" => 277,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148
		}
	},
	{#State 239
		DEFAULT => -141
	},
	{#State 240
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			";" => -140,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141
		}
	},
	{#State 241
		ACTIONS => {
			";" => 278
		}
	},
	{#State 242
		ACTIONS => {
			'LPAREN' => 279
		}
	},
	{#State 243
		DEFAULT => -120
	},
	{#State 244
		ACTIONS => {
			'WORD' => 281
		},
		GOTOS => {
			'PLUS-48' => 280
		}
	},
	{#State 245
		ACTIONS => {
			"]" => -181,
			'OP21_LIST_COMMA' => 283,
			")" => -181,
			";" => -181
		},
		GOTOS => {
			'PAREN-46' => 282
		}
	},
	{#State 246
		DEFAULT => -188
	},
	{#State 247
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 285
		}
	},
	{#State 248
		DEFAULT => -201
	},
	{#State 249
		DEFAULT => -202
	},
	{#State 250
		DEFAULT => -122
	},
	{#State 251
		ACTIONS => {
			'LBRACE' => -192,
			'LPAREN' => -192,
			'WORD_SCOPED' => -192,
			'VARIABLE_SYMBOL' => -192,
			"%{" => -192,
			'OP01_OPEN' => -192,
			"\@{" => -192,
			'LITERAL_NUMBER' => -192,
			'WORD' => -192,
			'OP05_MATH_NEG_LPAREN' => -192,
			'OP01_CLOSE' => -192,
			'LBRACKET' => -192,
			'OP03_MATH_INC_DEC' => -192,
			"my" => 117,
			'OP10_NAMED_UNARY' => -192,
			'OP22_LOGICAL_NOT' => -192,
			'OP10_STRINGIFY_UNARY' => -192,
			'OP01_NAMED' => -192,
			"undef" => -192,
			'OP05_LOGICAL_NEG' => -192,
			'LITERAL_STRING' => -192
		},
		GOTOS => {
			'TypeInner' => 287,
			'OPTIONAL-50' => 286
		}
	},
	{#State 252
		ACTIONS => {
			'OP21_LIST_COMMA' => 289,
			"}" => 288
		},
		GOTOS => {
			'PAREN-51' => 290
		}
	},
	{#State 253
		ACTIONS => {
			";" => 291
		}
	},
	{#State 254
		ACTIONS => {
			";" => 292
		}
	},
	{#State 255
		ACTIONS => {
			'VARIABLE_SYMBOL' => 293
		}
	},
	{#State 256
		ACTIONS => {
			'LPAREN' => 294
		}
	},
	{#State 257
		ACTIONS => {
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			'OP08_MATH_ADD_SUB' => 141,
			")" => 295,
			'OP04_MATH_POW' => 142,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140
		}
	},
	{#State 258
		DEFAULT => -101
	},
	{#State 259
		ACTIONS => {
			";" => 297,
			'OP19_VARIABLE_ASSIGN' => 296
		}
	},
	{#State 260
		DEFAULT => -45
	},
	{#State 261
		ACTIONS => {
			"%{" => 99,
			"if (" => 98,
			"\@{" => 74,
			"while (" => -144,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 101,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 70,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP01_NAMED' => 85,
			"undef" => 84,
			"foreach my" => -144,
			"my" => 114,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED_VOID' => 89,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			"for my integer" => -144,
			'OP01_PRINT' => 107,
			"}" => 298
		},
		GOTOS => {
			'VariableModification' => 97,
			'Operator' => 76,
			'Operation' => 299,
			'Expression' => 95,
			'HashDereferenced' => 75,
			'Conditional' => 79,
			'ArrayDereferenced' => 72,
			'Variable' => 88,
			'HashReference' => 111,
			'OPTIONAL-39' => 108,
			'SubExpression' => 86,
			'Literal' => 109,
			'VariableDeclaration' => 91,
			'Statement' => 104,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'OperatorVoid' => 82,
			'PAREN-38' => 106,
			'LoopLabel' => 83
		}
	},
	{#State 262
		ACTIONS => {
			'VARIABLE_SYMBOL' => 300
		}
	},
	{#State 263
		DEFAULT => -41
	},
	{#State 264
		ACTIONS => {
			'WORD' => 301
		}
	},
	{#State 265
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our" => -58,
			"our %properties_class = (" => 302
		},
		GOTOS => {
			'OPTIONAL-23' => 303,
			'PropertiesClass' => 304
		}
	},
	{#State 266
		ACTIONS => {
			"## no critic qw(" => 4,
			")" => 305
		},
		GOTOS => {
			'Critic' => 306
		}
	},
	{#State 267
		DEFAULT => -55
	},
	{#State 268
		ACTIONS => {
			'OP21_LIST_COMMA' => 307
		}
	},
	{#State 269
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"undef" => 84,
			'OP01_NAMED' => 125,
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP01_QW' => 162,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'KEYS_OR_VALUES' => 135,
			'LBRACE' => 102,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77
		},
		GOTOS => {
			'SubExpression' => 164,
			'Literal' => 109,
			'Expression' => 122,
			'HashDereferenced' => 75,
			'ListElements' => 308,
			'HashReference' => 111,
			'Variable' => 123,
			'Operator' => 76,
			'TypeInner' => 136,
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ListElement' => 163
		}
	},
	{#State 270
		ACTIONS => {
			")" => 309
		}
	},
	{#State 271
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => 143,
			"]" => 310,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150
		}
	},
	{#State 272
		ACTIONS => {
			"}" => 311,
			'LPAREN' => -203
		}
	},
	{#State 273
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			"}" => 312,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP09_BITWISE_SHIFT' => 144,
			'OP18_TERNARY' => 143,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148
		}
	},
	{#State 274
		DEFAULT => -128
	},
	{#State 275
		ACTIONS => {
			";" => 313
		}
	},
	{#State 276
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'VariableOrLiteral' => 314,
			'Literal' => 226,
			'Variable' => 224
		}
	},
	{#State 277
		DEFAULT => -175
	},
	{#State 278
		DEFAULT => -174
	},
	{#State 279
		ACTIONS => {
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			")" => -126,
			'KEYS_OR_VALUES' => 135,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP01_QW' => 162,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'TypeInner' => 136,
			'ListElement' => 163,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'OPTIONAL-37' => 316,
			'Operator' => 76,
			'Variable' => 123,
			'ListElements' => 315,
			'HashReference' => 111,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 164
		}
	},
	{#State 280
		ACTIONS => {
			'WORD' => 318,
			")" => 317
		}
	},
	{#State 281
		DEFAULT => -180
	},
	{#State 282
		DEFAULT => -177
	},
	{#State 283
		ACTIONS => {
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			"my" => 117,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'ListElement' => 319,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'TypeInner' => 136,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Expression' => 122,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 164
		}
	},
	{#State 284
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 101,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"while (" => -144,
			"\@{" => 74,
			"%{" => 99,
			"if (" => 98,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 70,
			'LITERAL_NUMBER' => 94,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP01_NAMED_VOID' => 89,
			"my" => 114,
			'OP03_MATH_INC_DEC' => 90,
			"undef" => 84,
			'OP01_NAMED' => 85,
			"foreach my" => -144,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP01_PRINT' => 107,
			"for my integer" => -144,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Expression' => 95,
			'Operation' => 320,
			'HashDereferenced' => 75,
			'Operator' => 76,
			'VariableModification' => 97,
			'Conditional' => 79,
			'PLUS-44' => 321,
			'ArrayDereferenced' => 72,
			'SubExpression' => 86,
			'Literal' => 109,
			'OPTIONAL-39' => 108,
			'HashReference' => 111,
			'Variable' => 88,
			'VariableDeclaration' => 91,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'Statement' => 104,
			'LoopLabel' => 83,
			'OperatorVoid' => 82,
			'PAREN-38' => 106
		}
	},
	{#State 285
		DEFAULT => -152,
		GOTOS => {
			'STAR-41' => 322
		}
	},
	{#State 286
		ACTIONS => {
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'OP03_MATH_INC_DEC' => 90,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_STRINGIFY_UNARY' => 112,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 323,
			'Expression' => 122
		}
	},
	{#State 287
		DEFAULT => -191
	},
	{#State 288
		DEFAULT => -200
	},
	{#State 289
		ACTIONS => {
			'WORD' => 178,
			"%{" => 99
		},
		GOTOS => {
			'HashEntry' => 324,
			'HashDereferenced' => 179
		}
	},
	{#State 290
		DEFAULT => -198
	},
	{#State 291
		DEFAULT => -118
	},
	{#State 292
		DEFAULT => -119
	},
	{#State 293
		ACTIONS => {
			'LPAREN' => 325
		}
	},
	{#State 294
		ACTIONS => {
			"\@{" => 74,
			'OP01_OPEN' => 73,
			"%{" => 99,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'SubExpression' => 326,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81
		}
	},
	{#State 295
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 327
		}
	},
	{#State 296
		ACTIONS => {
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			"%{" => 99,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 90,
			'STDIN' => 239
		},
		GOTOS => {
			'SubExpressionOrStdin' => 328,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'SubExpression' => 240,
			'Expression' => 122,
			'Literal' => 109,
			'HashDereferenced' => 75
		}
	},
	{#State 297
		DEFAULT => -172
	},
	{#State 298
		ACTIONS => {
			";" => 329
		}
	},
	{#State 299
		DEFAULT => -44
	},
	{#State 300
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 330
		}
	},
	{#State 301
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 331
		}
	},
	{#State 302
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 332
		}
	},
	{#State 303
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 333
		}
	},
	{#State 304
		DEFAULT => -57
	},
	{#State 305
		ACTIONS => {
			";" => 334
		}
	},
	{#State 306
		ACTIONS => {
			"%{" => 99,
			'WORD' => 336
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 335
		}
	},
	{#State 307
		ACTIONS => {
			'LITERAL_STRING' => 338
		}
	},
	{#State 308
		ACTIONS => {
			")" => 339
		}
	},
	{#State 309
		DEFAULT => -84
	},
	{#State 310
		DEFAULT => -169
	},
	{#State 311
		DEFAULT => -171
	},
	{#State 312
		DEFAULT => -170
	},
	{#State 313
		DEFAULT => -121
	},
	{#State 314
		DEFAULT => -109
	},
	{#State 315
		DEFAULT => -125
	},
	{#State 316
		ACTIONS => {
			")" => 340
		}
	},
	{#State 317
		DEFAULT => -182
	},
	{#State 318
		DEFAULT => -179
	},
	{#State 319
		DEFAULT => -176
	},
	{#State 320
		DEFAULT => -164
	},
	{#State 321
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			"my" => 114,
			'OP01_NAMED_VOID' => 89,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			"foreach my" => -144,
			"undef" => 84,
			'OP01_NAMED' => 85,
			"for my integer" => -144,
			"}" => 342,
			'OP01_PRINT' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'LBRACE' => 102,
			'OP19_LOOP_CONTROL' => 101,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			"if (" => 98,
			"%{" => 99,
			"while (" => -144,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			'LITERAL_NUMBER' => 94,
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'Statement' => 104,
			'LoopLabel' => 83,
			'OperatorVoid' => 82,
			'PAREN-38' => 106,
			'SubExpression' => 86,
			'Literal' => 109,
			'OPTIONAL-39' => 108,
			'HashReference' => 111,
			'Variable' => 88,
			'VariableDeclaration' => 91,
			'ArrayDereferenced' => 72,
			'Operation' => 341,
			'Expression' => 95,
			'HashDereferenced' => 75,
			'VariableModification' => 97,
			'Operator' => 76,
			'Conditional' => 79
		}
	},
	{#State 322
		ACTIONS => {
			"else" => 346,
			'OP05_MATH_NEG_LPAREN' => -155,
			'WORD' => -155,
			'OP01_OPEN' => -155,
			"\@{" => -155,
			"elsif (" => 344,
			'VARIABLE_SYMBOL' => -155,
			'LPAREN' => -155,
			"for my integer" => -155,
			'OP10_NAMED_UNARY' => -155,
			"undef" => -155,
			'OP01_NAMED' => -155,
			"foreach my" => -155,
			'OP03_MATH_INC_DEC' => -155,
			'OP01_NAMED_VOID' => -155,
			'LBRACKET' => -155,
			'OP01_CLOSE' => -155,
			'' => -155,
			'LITERAL_NUMBER' => -155,
			"%{" => -155,
			"if (" => -155,
			"while (" => -155,
			'LBRACE' => -155,
			'WORD_SCOPED' => -155,
			'OP19_LOOP_CONTROL' => -155,
			'OP05_LOGICAL_NEG' => -155,
			'LITERAL_STRING' => -155,
			'OP01_PRINT' => -155,
			"}" => -155,
			'OP10_STRINGIFY_UNARY' => -155,
			'OP22_LOGICAL_NOT' => -155,
			"my" => -155
		},
		GOTOS => {
			'OPTIONAL-43' => 347,
			'PAREN-40' => 343,
			'PAREN-42' => 345
		}
	},
	{#State 323
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP21_LIST_COMMA' => -193,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => 151,
			"}" => -193,
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153
		}
	},
	{#State 324
		DEFAULT => -197
	},
	{#State 325
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 117,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'LPAREN' => 77,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LBRACE' => 102,
			'KEYS_OR_VALUES' => 135,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LITERAL_NUMBER' => 94,
			'OP01_QW' => 162
		},
		GOTOS => {
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'ListElements' => 348,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Literal' => 109,
			'SubExpression' => 164,
			'ArrayDereferenced' => 72,
			'TypeInner' => 136,
			'ListElement' => 163,
			'ArrayReference' => 81,
			'WordScoped' => 80
		}
	},
	{#State 326
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 349
		}
	},
	{#State 327
		DEFAULT => -162
	},
	{#State 328
		ACTIONS => {
			";" => 350
		}
	},
	{#State 329
		DEFAULT => -46
	},
	{#State 330
		ACTIONS => {
			'OP21_LIST_COMMA' => 352,
			")" => 351
		},
		GOTOS => {
			'PAREN-18' => 353
		}
	},
	{#State 331
		DEFAULT => -207
	},
	{#State 332
		ACTIONS => {
			'WORD' => 336,
			"%{" => 99
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 354
		}
	},
	{#State 333
		ACTIONS => {
			"our" => 355,
			'LITERAL_NUMBER' => 359
		},
		GOTOS => {
			'Subroutine' => 356,
			'Method' => 358,
			'MethodOrSubroutine' => 357
		}
	},
	{#State 334
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 360
		}
	},
	{#State 335
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 361
		}
	},
	{#State 336
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 337
		DEFAULT => -196
	},
	{#State 338
		ACTIONS => {
			'OP21_LIST_COMMA' => 363
		}
	},
	{#State 339
		DEFAULT => -86
	},
	{#State 340
		DEFAULT => -129
	},
	{#State 341
		DEFAULT => -163
	},
	{#State 342
		DEFAULT => -165
	},
	{#State 343
		DEFAULT => -151
	},
	{#State 344
		ACTIONS => {
			'LBRACE' => 102,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LITERAL_NUMBER' => 94,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 71,
			'OP01_CLOSE' => 92,
			'LBRACKET' => 93,
			'OP03_MATH_INC_DEC' => 90,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'ArrayDereferenced' => 72,
			'SubExpression' => 364,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'Expression' => 122,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111
		}
	},
	{#State 345
		DEFAULT => -154
	},
	{#State 346
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 347
		DEFAULT => -156
	},
	{#State 348
		ACTIONS => {
			")" => 366
		}
	},
	{#State 349
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 30,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99
		},
		GOTOS => {
			'ArrayReference' => 81,
			'WordScoped' => 80,
			'ArrayDereferenced' => 72,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'Literal' => 109,
			'HashDereferenced' => 75,
			'SubExpression' => 367,
			'Expression' => 122
		}
	},
	{#State 350
		DEFAULT => -173
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 368
		}
	},
	{#State 352
		ACTIONS => {
			"my" => 369
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 370
		}
	},
	{#State 355
		ACTIONS => {
			'TYPE_METHOD' => 371,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 356
		DEFAULT => -81
	},
	{#State 357
		DEFAULT => -59
	},
	{#State 358
		DEFAULT => -80
	},
	{#State 359
		ACTIONS => {
			";" => 372
		}
	},
	{#State 360
		DEFAULT => -66
	},
	{#State 361
		ACTIONS => {
			'OP21_LIST_COMMA' => 375,
			")" => 374
		},
		GOTOS => {
			'PAREN-25' => 373
		}
	},
	{#State 362
		ACTIONS => {
			"my" => 117
		},
		GOTOS => {
			'TypeInner' => 376
		}
	},
	{#State 363
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACE' => 102,
			'OP01_OPEN' => 73,
			"\@{" => 74,
			"%{" => 99,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_NAMED' => 125,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87
		},
		GOTOS => {
			'Expression' => 122,
			'HashDereferenced' => 75,
			'SubExpression' => 377,
			'Literal' => 109,
			'HashReference' => 111,
			'Operator' => 76,
			'Variable' => 123,
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81
		}
	},
	{#State 364
		ACTIONS => {
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => 378,
			'OP23_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 152
		}
	},
	{#State 365
		DEFAULT => -153
	},
	{#State 366
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 367
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 142,
			")" => 380,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => -108,
			'OP09_BITWISE_SHIFT' => 144,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 368
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 369
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 382
		}
	},
	{#State 370
		ACTIONS => {
			")" => 383,
			'OP21_LIST_COMMA' => 385
		},
		GOTOS => {
			'PAREN-27' => 384
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 372
		DEFAULT => -61
	},
	{#State 373
		DEFAULT => -63
	},
	{#State 374
		ACTIONS => {
			";" => 387
		}
	},
	{#State 375
		ACTIONS => {
			'WORD' => 336,
			"%{" => 99
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 388
		}
	},
	{#State 376
		ACTIONS => {
			"%{" => 99,
			"\@{" => 74,
			'OP01_OPEN' => 73,
			'LBRACE' => 102,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 29,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			"undef" => 84,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 72,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'Variable' => 123,
			'Operator' => 76,
			'HashReference' => 111,
			'HashDereferenced' => 75,
			'Literal' => 109,
			'SubExpression' => 389,
			'Expression' => 122
		}
	},
	{#State 377
		ACTIONS => {
			"}" => -87,
			'OP17_LIST_RANGE' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 145,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP12_COMPARE_EQ_NE' => 147,
			";" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 141,
			'OP04_MATH_POW' => 142,
			")" => -87,
			"]" => -87,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 379
		DEFAULT => -161
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => 284
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 381
		DEFAULT => -50
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 383
		ACTIONS => {
			";" => 393
		}
	},
	{#State 384
		DEFAULT => -68
	},
	{#State 385
		ACTIONS => {
			'WORD' => 336,
			"%{" => 99
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 394
		}
	},
	{#State 386
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 387
		DEFAULT => -65
	},
	{#State 388
		DEFAULT => -62
	},
	{#State 389
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP17_LIST_RANGE' => 151,
			'OP06_REGEX_MATCH' => 146,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 145,
			'OP13_BITWISE_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 139,
			'OP21_LIST_COMMA' => -195,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 144,
			'OP04_MATH_POW' => 142,
			")" => -195,
			'OP08_MATH_ADD_SUB' => 141
		}
	},
	{#State 390
		DEFAULT => -150
	},
	{#State 391
		DEFAULT => -160
	},
	{#State 392
		DEFAULT => -47
	},
	{#State 393
		DEFAULT => -70
	},
	{#State 394
		DEFAULT => -67
	},
	{#State 395
		ACTIONS => {
			'OP01_OPEN' => -72,
			"while (" => -72,
			"\@{" => -72,
			"%{" => -72,
			"if (" => -72,
			'VARIABLE_SYMBOL' => -72,
			'WORD_SCOPED' => -72,
			'LPAREN' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'LBRACE' => -72,
			'LBRACKET' => -72,
			'OP01_CLOSE' => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			'WORD' => -72,
			'LITERAL_NUMBER' => -72,
			'OP01_NAMED' => -72,
			"undef" => -72,
			"foreach my" => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP01_NAMED_VOID' => -72,
			"my" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'LITERAL_STRING' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP01_PRINT' => -72,
			"( my" => 398,
			"for my integer" => -72
		},
		GOTOS => {
			'MethodArguments' => 396,
			'OPTIONAL-29' => 397
		}
	},
	{#State 396
		DEFAULT => -71
	},
	{#State 397
		ACTIONS => {
			"for my integer" => -144,
			'OP01_PRINT' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 103,
			'OP03_MATH_INC_DEC' => 90,
			"my" => 114,
			'OP01_NAMED_VOID' => 89,
			'OP22_LOGICAL_NOT' => 110,
			'OP10_NAMED_UNARY' => 87,
			'OP10_STRINGIFY_UNARY' => 112,
			"foreach my" => -144,
			'OP01_NAMED' => 85,
			"undef" => 84,
			'LITERAL_NUMBER' => 94,
			'WORD' => 70,
			'OP05_MATH_NEG_LPAREN' => 71,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'LBRACE' => 102,
			'OP19_LOOP_CONTROL' => 101,
			'LPAREN' => 77,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			"if (" => 98,
			"%{" => 99,
			"while (" => -144,
			'OP01_OPEN' => 73,
			"\@{" => 74
		},
		GOTOS => {
			'Statement' => 104,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'OperatorVoid' => 82,
			'PAREN-38' => 106,
			'LoopLabel' => 83,
			'OPTIONAL-39' => 108,
			'SubExpression' => 86,
			'Literal' => 109,
			'Variable' => 88,
			'HashReference' => 111,
			'VariableDeclaration' => 91,
			'PLUS-30' => 399,
			'ArrayDereferenced' => 72,
			'Operation' => 400,
			'Expression' => 95,
			'HashDereferenced' => 75,
			'VariableModification' => 97,
			'Operator' => 76,
			'Conditional' => 79
		}
	},
	{#State 398
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 401
		}
	},
	{#State 399
		ACTIONS => {
			'OP01_PRINT' => 107,
			"}" => 403,
			"for my integer" => -144,
			'LITERAL_STRING' => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_NAMED_VOID' => 89,
			"my" => 114,
			'OP03_MATH_INC_DEC' => 90,
			"undef" => 84,
			'OP01_NAMED' => 85,
			"foreach my" => -144,
			'OP10_STRINGIFY_UNARY' => 112,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NOT' => 110,
			'OP05_MATH_NEG_LPAREN' => 71,
			'WORD' => 70,
			'LITERAL_NUMBER' => 94,
			'LBRACKET' => 93,
			'OP01_CLOSE' => 92,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 78,
			'LPAREN' => 77,
			'OP19_LOOP_CONTROL' => 101,
			'LBRACE' => 102,
			"\@{" => 74,
			"while (" => -144,
			'OP01_OPEN' => 73,
			"%{" => 99,
			"if (" => 98
		},
		GOTOS => {
			'PAREN-38' => 106,
			'OperatorVoid' => 82,
			'LoopLabel' => 83,
			'Statement' => 104,
			'WordScoped' => 80,
			'ArrayReference' => 81,
			'VariableDeclaration' => 91,
			'OPTIONAL-39' => 108,
			'SubExpression' => 86,
			'Literal' => 109,
			'Variable' => 88,
			'HashReference' => 111,
			'ArrayDereferenced' => 72,
			'Conditional' => 79,
			'Expression' => 95,
			'HashDereferenced' => 75,
			'Operation' => 402,
			'VariableModification' => 97,
			'Operator' => 76
		}
	},
	{#State 400
		DEFAULT => -74
	},
	{#State 401
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 404
		}
	},
	{#State 402
		DEFAULT => -73
	},
	{#State 403
		ACTIONS => {
			";" => 405
		}
	},
	{#State 404
		ACTIONS => {
			")" => 407,
			'OP21_LIST_COMMA' => 406
		},
		GOTOS => {
			'PAREN-31' => 408
		}
	},
	{#State 405
		DEFAULT => -75
	},
	{#State 406
		ACTIONS => {
			"my" => 409
		}
	},
	{#State 407
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 408
		DEFAULT => -77
	},
	{#State 409
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 411
		}
	},
	{#State 410
		ACTIONS => {
			"\@_;" => 412
		}
	},
	{#State 411
		ACTIONS => {
			'VARIABLE_SYMBOL' => 413
		}
	},
	{#State 412
		DEFAULT => -79
	},
	{#State 413
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5741 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5748 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5755 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5762 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5805 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5812 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5819 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5840 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5847 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5893 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5954 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5961 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5975 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5982 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6083 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6168 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6175 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6182 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6317 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6342 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6374 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6396 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6418 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6429 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6440 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6451 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6484 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6495 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6539 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6550 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6561 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6572 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6583 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6594 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6605 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6616 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6671 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6704 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6841 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6866 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6877 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6888 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6899 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6910 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6943 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6954 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6976 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_141
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7041 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7103 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7124 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_156
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_159
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_160
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_161
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_162
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_165
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7254 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_168
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7265 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7276 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7287 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_171
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7309 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_173
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_175
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7342 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7356 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_181
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_182
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_185
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7446 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_188
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7457 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_189
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7468 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_190
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7479 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7558 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_200
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7569 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_201
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_202
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7591 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7602 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_204
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7613 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_205
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7624 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7646 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_208
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7657 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_210
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7679 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_211
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7690 lib/RPerl/Grammar.pm
	]
],
#line 7693 lib/RPerl/Grammar.pm
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
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_127', 
         'Expression_128', 
         'Expression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpressionOrStdin_140', 
         'SubExpressionOrStdin_141', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         'Statement_148', 
         'Statement_149', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_156', 
         'Loop_157', 
         'Loop_158', 
         'Loop_159', 
         'LoopFor_160', 
         'LoopForEach_161', 
         'LoopWhile_162', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_165', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_168', 
         'VariableRetrieval_169', 
         'VariableRetrieval_170', 
         'VariableRetrieval_171', 
         'VariableDeclaration_172', 
         'VariableDeclaration_173', 
         'VariableModification_174', 
         'VariableModification_175', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_181', 
         'ListElements_182', 
         'ListElement_183', 
         'ListElement_184', 
         'ListElement_185', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_188', 
         'ArrayDereferenced_189', 
         'ArrayDereferenced_190', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_193', 
         'HashEntry_194', 
         'HashEntryTyped_195', 
         'HashEntryTyped_196', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_200', 
         'HashDereferenced_201', 
         'HashDereferenced_202', 
         'WordScoped_203', 
         'WordScoped_204', 
         'LoopLabel_205', 
         'Type_206', 
         'TypeInner_207', 
         'VariableOrLiteral_208', 
         'VariableOrLiteral_209', 
         'Literal_210', 
         'Literal_211', );
  $self;
}

#line 192 "lib/RPerl/Grammar.eyp"


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


#line 7953 lib/RPerl/Grammar.pm



1;
