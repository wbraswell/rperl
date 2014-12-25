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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|package|\$TYPED_|\=\ sub\ \{|while\ \(|elsif\ \(|undef|else|\(\ my|if\ \(|\@_\;|use|qw\(|our|\@\{|\%\{|my|\]|\;|\)|\})}gc and return ($1, $1);

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
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NEQ', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(::[a-zA-Z]\w*__stringify)/gc and return ('OP10_NAMED_UNARY_STRINGIFY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LEFT_PAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<|>|<=|>=|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
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
  [ 'Operator_84' => 'Operator', [ 'LEFT_PAREN', 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'LEFT_PAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_OPEN', 'my', 'filehandle_ref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG_LEFT_PAREN', 'SubExpression', ')' ], 0 ],
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
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'WordScoped', 'LEFT_PAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LEFT_PAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'LEFT_BRACE', '}' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'LEFT_PAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_139' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_140' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'OPTIONAL-39', 'Loop' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'PAREN-40' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'PAREN-42' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Conditional_155' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-41', 'OPTIONAL-43' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_158' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_159' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_160' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_161' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'CodeBlock_164' => 'CodeBlock', [ 'LEFT_BRACE', 'PLUS-44', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'Variable_167' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-45' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_170' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_171' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_173' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'PLUS-48', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'WORD' ], 0 ],
  [ 'ListElements_180' => 'ListElements', [ 'ListElement', 'STAR-47' ], 0 ],
  [ 'ListElements_181' => 'ListElements', [ 'OP01_QW', 'LEFT_PAREN', 'PLUS-48', ')' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_184' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayReference_187' => 'ArrayReference', [ 'LEFT_BRACKET', 'OPTIONAL-49', ']' ], 0 ],
  [ 'ArrayDereferenced_188' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_189' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_192' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_194' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_199' => 'HashReference', [ 'LEFT_BRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashDereferenced_200' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_201' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_202' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_203' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_204' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_205' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_206' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Literal_207' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_208' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PAREN' => 112,
  '_OPTIONAL' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
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
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpressionOrStdin_139' => 139,
  'SubExpressionOrStdin_140' => 140,
  '_PAREN' => 141,
  '_OPTIONAL' => 142,
  '_OPTIONAL' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  'Statement_148' => 148,
  '_PAREN' => 149,
  '_STAR_LIST' => 150,
  '_STAR_LIST' => 151,
  '_PAREN' => 152,
  '_OPTIONAL' => 153,
  '_OPTIONAL' => 154,
  'Conditional_155' => 155,
  'Loop_156' => 156,
  'Loop_157' => 157,
  'Loop_158' => 158,
  'LoopFor_159' => 159,
  'LoopForEach_160' => 160,
  'LoopWhile_161' => 161,
  '_PLUS_LIST' => 162,
  '_PLUS_LIST' => 163,
  'CodeBlock_164' => 164,
  '_STAR_LIST' => 165,
  '_STAR_LIST' => 166,
  'Variable_167' => 167,
  'VariableRetrieval_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableRetrieval_170' => 170,
  'VariableDeclaration_171' => 171,
  'VariableDeclaration_172' => 172,
  'VariableModification_173' => 173,
  'VariableModification_174' => 174,
  '_PAREN' => 175,
  '_STAR_LIST' => 176,
  '_STAR_LIST' => 177,
  '_PLUS_LIST' => 178,
  '_PLUS_LIST' => 179,
  'ListElements_180' => 180,
  'ListElements_181' => 181,
  'ListElement_182' => 182,
  'ListElement_183' => 183,
  'ListElement_184' => 184,
  '_OPTIONAL' => 185,
  '_OPTIONAL' => 186,
  'ArrayReference_187' => 187,
  'ArrayDereferenced_188' => 188,
  'ArrayDereferenced_189' => 189,
  '_OPTIONAL' => 190,
  '_OPTIONAL' => 191,
  'HashEntry_192' => 192,
  'HashEntry_193' => 193,
  'HashEntryTyped_194' => 194,
  'HashEntryTyped_195' => 195,
  '_PAREN' => 196,
  '_STAR_LIST' => 197,
  '_STAR_LIST' => 198,
  'HashReference_199' => 199,
  'HashDereferenced_200' => 200,
  'HashDereferenced_201' => 201,
  'WordScoped_202' => 202,
  'WordScoped_203' => 203,
  'LoopLabel_204' => 204,
  'Type_205' => 205,
  'TypeInner_206' => 206,
  'Literal_207' => 207,
  'Literal_208' => 208,
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
	LEFT_BRACE => { ISSEMANTIC => 1 },
	LEFT_BRACKET => { ISSEMANTIC => 1 },
	LEFT_PAREN => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
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
	OP05_MATH_NEG_LEFT_PAREN => { ISSEMANTIC => 1 },
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
			"package" => -20,
			'SHEBANG' => 1,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'PLUS-2' => 7,
			'PAREN-1' => 8,
			'ModuleHeader' => 6,
			'Critic' => 5,
			'Program' => 3,
			'CompileUnit' => 2,
			'OPTIONAL-9' => 9
		}
	},
	{#State 1
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'' => 12
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'WORD' => 14
		},
		GOTOS => {
			'PLUS-14' => 13
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25,
			"use" => -25,
			"use parent qw(" => 16
		},
		GOTOS => {
			'STAR-10' => 15,
			'Class' => 18,
			'Package' => 17,
			'Module' => 19
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 4,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'PAREN-1' => 20,
			'Critic' => 5,
			'ModuleHeader' => 6
		}
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
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			")" => 25,
			'WORD' => 24
		}
	},
	{#State 14
		DEFAULT => -35
	},
	{#State 15
		ACTIONS => {
			"## no critic qw(" => 4,
			"use constant" => -27,
			"our" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 26
		}
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		DEFAULT => -23
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		ACTIONS => {
			"use warnings;" => 32
		}
	},
	{#State 23
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 33
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
			"use" => 34,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 36
		}
	},
	{#State 28
		DEFAULT => -202
	},
	{#State 29
		ACTIONS => {
			")" => 37
		}
	},
	{#State 30
		DEFAULT => -203
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'OP01_NAMED' => -11,
			"for my integer" => -11,
			"## no critic qw(" => 4,
			"foreach my" => -11,
			"undef" => -11,
			'LEFT_PAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"%{" => -11,
			'WORD' => -11,
			'LEFT_BRACE' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_OPEN' => -11,
			'OP22_LOGICAL_NOT' => -11,
			"\@{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"our" => -11,
			'OP10_NAMED_UNARY' => -11,
			'LEFT_BRACKET' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP01_PRINT' => -11,
			'OP01_CLOSE' => -11,
			"use" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"if (" => -11,
			'OP01_NAMED_VOID' => -11,
			"while (" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_STRING' => -11,
			"my" => -11,
			'OP05_MATH_NEG_LEFT_PAREN' => -11,
			"use constant" => -11,
			'WORD_SCOPED' => -11
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-5' => 41
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 42
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 47,
			"our" => 44
		},
		GOTOS => {
			'Constant' => 46,
			'PLUS-13' => 45,
			'Subroutine' => 43
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			";" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			"our" => -13,
			"\@{" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'LEFT_BRACKET' => -13,
			'OP10_NAMED_UNARY' => -13,
			"for my integer" => -13,
			"undef" => -13,
			"foreach my" => -13,
			'OP01_NAMED' => -13,
			'LEFT_BRACE' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD' => -13,
			"%{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LEFT_PAREN' => -13,
			'LITERAL_STRING' => -13,
			"my" => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			"use constant" => -13,
			'OP05_MATH_NEG_LEFT_PAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP01_PRINT' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"while (" => -13,
			"if (" => -13,
			'OP01_NAMED_VOID' => -13,
			"use" => 34
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 42
		ACTIONS => {
			"qw(" => 53,
			";" => 54
		}
	},
	{#State 43
		DEFAULT => -31
	},
	{#State 44
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			'WORD' => 59
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'OP01_CLOSE' => -15,
			"for my integer" => -15,
			"undef" => -15,
			"foreach my" => -15,
			"%{" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LEFT_PAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LEFT_BRACE' => -15,
			'LITERAL_NUMBER' => -15,
			"if (" => -15,
			"while (" => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_OPEN' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'LITERAL_STRING' => -15,
			"my" => -15,
			"our" => -15,
			"\@{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'LEFT_BRACKET' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG_LEFT_PAREN' => -15,
			"use constant" => 47,
			'WORD_SCOPED' => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 62
		}
	},
	{#State 52
		DEFAULT => -10
	},
	{#State 53
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 54
		DEFAULT => -39
	},
	{#State 55
		DEFAULT => -205
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
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
		ACTIONS => {
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'OP19_LOOP_CONTROL' => 74,
			"while (" => -143,
			'LITERAL_NUMBER' => 97,
			"if (" => 76,
			'OP01_NAMED_VOID' => 75,
			'WORD' => 99,
			'OP01_NAMED' => 93,
			'OP01_PRINT' => 73,
			"for my integer" => -143,
			'OP01_CLOSE' => 72,
			"foreach my" => -143,
			"undef" => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"my" => 78,
			"our" => 44,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104
		},
		GOTOS => {
			'Conditional' => 98,
			'PLUS-8' => 96,
			'VariableDeclaration' => 103,
			'Variable' => 71,
			'Subroutine' => 90,
			'OperatorVoid' => 70,
			'HashDereferenced' => 89,
			'PAREN-38' => 88,
			'Expression' => 94,
			'ArrayDereferenced' => 92,
			'Operator' => 82,
			'Literal' => 83,
			'LoopLabel' => 84,
			'WordScoped' => 110,
			'Operation' => 86,
			'HashReference' => 111,
			'VariableModification' => 85,
			'ArrayReference' => 107,
			'OPTIONAL-39' => 106,
			'Statement' => 81,
			'SubExpression' => 80
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		DEFAULT => -38
	},
	{#State 65
		ACTIONS => {
			")" => 115,
			'WORD' => 116
		}
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 119
		}
	},
	{#State 69
		ACTIONS => {
			"our %properties = (" => -54,
			"use" => -54,
			"## no critic qw(" => 4,
			"use constant" => -54
		},
		GOTOS => {
			'Critic' => 120,
			'STAR-21' => 121
		}
	},
	{#State 70
		DEFAULT => -146
	},
	{#State 71
		ACTIONS => {
			'OP17_LIST_RANGE' => -132,
			'OP19_VARIABLE_ASSIGN' => 125,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP04_MATH_POW' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 122,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP02_METHOD_THINARROW' => 124,
			'OP03_MATH_INC_DEC' => 123,
			'OP08_STRING_CAT' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP18_TERNARY' => -132
		}
	},
	{#State 72
		ACTIONS => {
			'FH_REF_SYMBOL' => 126
		}
	},
	{#State 73
		ACTIONS => {
			'VARIABLE_SYMBOL' => -114,
			'FH_REF_SYMBOL_BRACES' => 128,
			'OP01_OPEN' => -114,
			'OP22_LOGICAL_NOT' => -114,
			'LITERAL_STRING' => -114,
			'KEYS_OR_VALUES' => -114,
			"my" => -114,
			'OP05_LOGICAL_NEG' => -114,
			"\@{" => -114,
			'OP10_NAMED_UNARY_STRINGIFY' => -114,
			'OP10_NAMED_UNARY' => -114,
			'LEFT_BRACKET' => -114,
			'OP05_MATH_NEG_LEFT_PAREN' => -114,
			'STDOUT_STDERR' => 129,
			'WORD_SCOPED' => -114,
			'OP01_NAMED' => -114,
			'OP01_QW' => -114,
			'OP01_CLOSE' => -114,
			"undef" => -114,
			"%{" => -114,
			'OP03_MATH_INC_DEC' => -114,
			'LEFT_PAREN' => -114,
			'LEFT_BRACE' => -114,
			'LITERAL_NUMBER' => -114,
			'WORD' => -114
		},
		GOTOS => {
			'OPTIONAL-34' => 130,
			'PAREN-33' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'LoopLabel' => 132
		}
	},
	{#State 75
		ACTIONS => {
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			";" => -116,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 118,
			'LITERAL_STRING' => 77,
			'KEYS_OR_VALUES' => 136
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'TypeInner' => 137,
			'OPTIONAL-35' => 140,
			'Expression' => 134,
			'SubExpression' => 142,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Literal' => 83,
			'Operator' => 82,
			'ListElement' => 138,
			'ListElements' => 133,
			'WordScoped' => 110,
			'HashReference' => 111
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 143,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 77
		DEFAULT => -207
	},
	{#State 78
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 144
		}
	},
	{#State 79
		DEFAULT => -166,
		GOTOS => {
			'STAR-45' => 145
		}
	},
	{#State 80
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158
		}
	},
	{#State 81
		DEFAULT => -83
	},
	{#State 82
		DEFAULT => -126
	},
	{#State 83
		DEFAULT => -131
	},
	{#State 84
		ACTIONS => {
			'COLON' => 162
		}
	},
	{#State 85
		DEFAULT => -148
	},
	{#State 86
		DEFAULT => -17
	},
	{#State 87
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 163,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 88
		DEFAULT => -142
	},
	{#State 89
		DEFAULT => -136
	},
	{#State 90
		DEFAULT => -14
	},
	{#State 91
		DEFAULT => -130
	},
	{#State 92
		DEFAULT => -134
	},
	{#State 93
		ACTIONS => {
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'WORD_SCOPED' => 30,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			"my" => 118,
			'LITERAL_STRING' => 77,
			'KEYS_OR_VALUES' => 136,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'ListElement' => 164,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'TypeInner' => 137,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 165
		}
	},
	{#State 94
		ACTIONS => {
			";" => 166,
			'OP08_MATH_ADD_SUB' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP12_COMPARE_EQ_NEQ' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP08_STRING_CAT' => -129
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => 168,
			"}" => 170,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 167,
			'HashEntry' => 169
		}
	},
	{#State 96
		ACTIONS => {
			'OP01_CLOSE' => 72,
			"for my integer" => -143,
			"undef" => 91,
			"foreach my" => -143,
			'OP01_NAMED' => 93,
			'' => -18,
			'OP01_PRINT' => 73,
			'LEFT_BRACE' => 95,
			'OP19_LOOP_CONTROL' => 74,
			"while (" => -143,
			'OP01_NAMED_VOID' => 75,
			"if (" => 76,
			'LITERAL_NUMBER' => 97,
			'WORD' => 99,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_STRING' => 77,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87
		},
		GOTOS => {
			'VariableDeclaration' => 103,
			'Conditional' => 98,
			'ArrayDereferenced' => 92,
			'Expression' => 94,
			'PAREN-38' => 88,
			'HashDereferenced' => 89,
			'OperatorVoid' => 70,
			'Variable' => 71,
			'VariableModification' => 85,
			'HashReference' => 111,
			'Operation' => 171,
			'WordScoped' => 110,
			'LoopLabel' => 84,
			'Operator' => 82,
			'Literal' => 83,
			'SubExpression' => 80,
			'Statement' => 81,
			'ArrayReference' => 107,
			'OPTIONAL-39' => 106
		}
	},
	{#State 97
		DEFAULT => -208
	},
	{#State 98
		DEFAULT => -144
	},
	{#State 99
		ACTIONS => {
			'LEFT_PAREN' => -202,
			'COLON' => -204
		}
	},
	{#State 100
		ACTIONS => {
			'LEFT_BRACE' => 174,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 172,
			'HashReference' => 173
		}
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 175
		}
	},
	{#State 102
		ACTIONS => {
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_PRINT' => 176,
			'OP01_NAMED' => 178,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 177,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 103
		DEFAULT => -147
	},
	{#State 104
		ACTIONS => {
			'LEFT_BRACKET' => 114,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'ArrayReference' => 179,
			'Variable' => 180
		}
	},
	{#State 105
		ACTIONS => {
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114
		},
		GOTOS => {
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 181,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110
		}
	},
	{#State 106
		ACTIONS => {
			"for my integer" => 183,
			"foreach my" => 182,
			"while (" => 185
		},
		GOTOS => {
			'LoopFor' => 186,
			'LoopWhile' => 187,
			'LoopForEach' => 184,
			'Loop' => 188
		}
	},
	{#State 107
		DEFAULT => -133
	},
	{#State 108
		ACTIONS => {
			"my" => 189
		}
	},
	{#State 109
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72
		},
		GOTOS => {
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 190,
			'Expression' => 134
		}
	},
	{#State 110
		ACTIONS => {
			'LEFT_PAREN' => 191
		}
	},
	{#State 111
		DEFAULT => -135
	},
	{#State 112
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 192,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Expression' => 134
		}
	},
	{#State 113
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 193,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 114
		ACTIONS => {
			"my" => 118,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			"]" => -186,
			'OP01_QW' => 141,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'ListElement' => 138,
			'ListElements' => 195,
			'Operator' => 82,
			'Literal' => 83,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 142,
			'Expression' => 134,
			'TypeInner' => 137,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'OPTIONAL-49' => 194
		}
	},
	{#State 115
		ACTIONS => {
			";" => 196
		}
	},
	{#State 116
		DEFAULT => -37
	},
	{#State 117
		ACTIONS => {
			'OP05_MATH_NEG_LEFT_PAREN' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LEFT_BRACKET' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"( my" => 197,
			'WORD_SCOPED' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP01_OPEN' => -43,
			'VARIABLE_SYMBOL' => -43,
			"\@{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"my" => -43,
			'LITERAL_STRING' => -43,
			'LEFT_PAREN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"%{" => -43,
			'WORD' => -43,
			"while (" => -43,
			"if (" => -43,
			'OP01_NAMED_VOID' => -43,
			'LITERAL_NUMBER' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LEFT_BRACE' => -43,
			'OP01_PRINT' => -43,
			'OP01_NAMED' => -43,
			"undef" => -43,
			"foreach my" => -43,
			"for my integer" => -43,
			'OP01_CLOSE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 199,
			'OPTIONAL-16' => 198
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 200
		}
	},
	{#State 119
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 97
		},
		GOTOS => {
			'Literal' => 201
		}
	},
	{#State 120
		DEFAULT => -51
	},
	{#State 121
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 34,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 202,
			'STAR-22' => 203
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 204
		}
	},
	{#State 123
		DEFAULT => -90
	},
	{#State 124
		ACTIONS => {
			'WORD' => 205
		}
	},
	{#State 125
		ACTIONS => {
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'STDIN' => 206,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104
		},
		GOTOS => {
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111,
			'SubExpressionOrStdin' => 207,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 208,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Expression' => 134
		}
	},
	{#State 126
		DEFAULT => -88
	},
	{#State 127
		DEFAULT => -113
	},
	{#State 128
		ACTIONS => {
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			"my" => 118,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97
		},
		GOTOS => {
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'ListElements' => 209,
			'ListElement' => 138,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'TypeInner' => 137,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 142
		}
	},
	{#State 129
		DEFAULT => -112
	},
	{#State 130
		ACTIONS => {
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			'WORD_SCOPED' => 30,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 118,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 142,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'TypeInner' => 137,
			'Expression' => 134,
			'ListElement' => 138,
			'ListElements' => 210,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 131
		DEFAULT => -204
	},
	{#State 132
		ACTIONS => {
			";" => 211
		}
	},
	{#State 133
		DEFAULT => -115
	},
	{#State 134
		DEFAULT => -129
	},
	{#State 135
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79,
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 212,
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111
		}
	},
	{#State 136
		ACTIONS => {
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 213
		}
	},
	{#State 137
		ACTIONS => {
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 214,
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111
		}
	},
	{#State 138
		DEFAULT => -177,
		GOTOS => {
			'STAR-47' => 215
		}
	},
	{#State 139
		ACTIONS => {
			'OP08_STRING_CAT' => -132,
			'OP18_TERNARY' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP02_METHOD_THINARROW' => 124,
			'OP03_MATH_INC_DEC' => 123,
			'OP11_COMPARE_LT_GT' => -132,
			"]" => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP04_MATH_POW' => -132,
			")" => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP21_LIST_COMMA' => -132,
			"}" => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			";" => -132
		}
	},
	{#State 140
		ACTIONS => {
			";" => 216
		}
	},
	{#State 141
		ACTIONS => {
			'LEFT_PAREN' => 217
		}
	},
	{#State 142
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -182,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			";" => -182,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			")" => -182,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP21_LIST_COMMA' => -182,
			'OP24_LOGICAL_OR_XOR' => 158
		}
	},
	{#State 143
		ACTIONS => {
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 156,
			")" => 218,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 159
		}
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 219
		}
	},
	{#State 145
		ACTIONS => {
			'OP02_HASH_THINARROW' => 220,
			'COLON' => -167,
			";" => -167,
			'OP02_ARRAY_THINARROW' => 221,
			'OP09_BITWISE_SHIFT' => -167,
			"}" => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			'OP21_LIST_COMMA' => -167,
			'OP19_VARIABLE_ASSIGN' => -167,
			'OP17_LIST_RANGE' => -167,
			")" => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			'OP23_LOGICAL_AND' => -167,
			'OP04_MATH_POW' => -167,
			'OP16_LOGICAL_OR' => -167,
			'OP13_BITWISE_AND' => -167,
			'OP12_COMPARE_EQ_NEQ' => -167,
			"]" => -167,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			'OP03_MATH_INC_DEC' => -167,
			'OP02_METHOD_THINARROW' => -167,
			'OP18_TERNARY' => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			'OP15_LOGICAL_AND' => -167,
			'OP08_STRING_CAT' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 222
		}
	},
	{#State 146
		ACTIONS => {
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 30,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 112
		},
		GOTOS => {
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'SubExpression' => 223,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92
		}
	},
	{#State 147
		ACTIONS => {
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 224,
			'Expression' => 134,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 148
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'SubExpression' => 225,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92
		}
	},
	{#State 149
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91
		},
		GOTOS => {
			'Expression' => 134,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 226,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110
		}
	},
	{#State 150
		ACTIONS => {
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 227,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 151
		ACTIONS => {
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 228,
			'Expression' => 134
		}
	},
	{#State 152
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 229
		}
	},
	{#State 153
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 230,
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111
		}
	},
	{#State 154
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72
		},
		GOTOS => {
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 231,
			'Expression' => 134
		}
	},
	{#State 155
		ACTIONS => {
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'SubExpression' => 232,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'HashReference' => 111
		}
	},
	{#State 156
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'SubExpression' => 233,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92
		}
	},
	{#State 157
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95
		},
		GOTOS => {
			'HashReference' => 111,
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 234,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 158
		ACTIONS => {
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 235,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 159
		ACTIONS => {
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 236,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'HashReference' => 111,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82
		}
	},
	{#State 160
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 237
		}
	},
	{#State 161
		ACTIONS => {
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 238,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 162
		DEFAULT => -141
	},
	{#State 163
		ACTIONS => {
			'OP08_STRING_CAT' => 151,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => 152,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP11_COMPARE_LT_GT' => 155,
			'OP17_LIST_RANGE' => 156,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 157,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => 239
		}
	},
	{#State 164
		ACTIONS => {
			'OP21_LIST_COMMA' => 240
		}
	},
	{#State 165
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP08_STRING_CAT' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -182,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP06_REGEX_MATCH' => -85,
			")" => -85,
			'OP04_MATH_POW' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85
		}
	},
	{#State 166
		DEFAULT => -82
	},
	{#State 167
		DEFAULT => -193
	},
	{#State 168
		ACTIONS => {
			'OP20_HASH_FATARROW' => 241
		}
	},
	{#State 169
		DEFAULT => -198,
		GOTOS => {
			'STAR-52' => 242
		}
	},
	{#State 170
		DEFAULT => -137
	},
	{#State 171
		DEFAULT => -16
	},
	{#State 172
		ACTIONS => {
			"}" => 243
		}
	},
	{#State 173
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 174
		ACTIONS => {
			'WORD' => 168,
			"%{" => 100
		},
		GOTOS => {
			'HashEntry' => 169,
			'HashDereferenced' => 167
		}
	},
	{#State 175
		DEFAULT => -89
	},
	{#State 176
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 245
		}
	},
	{#State 177
		ACTIONS => {
			")" => 246,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 156,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			'OP11_COMPARE_LT_GT' => 155,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			"my" => 118,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'ListElement' => 247,
			'Literal' => 83,
			'Operator' => 82,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 165,
			'Expression' => 134,
			'TypeInner' => 137,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 179
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 180
		ACTIONS => {
			"}" => 249
		}
	},
	{#State 181
		ACTIONS => {
			'OP08_STRING_CAT' => -92,
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP15_LOGICAL_AND' => -92,
			"]" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			"}" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 159,
			")" => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP06_REGEX_MATCH' => -92,
			";" => -92
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 250
		}
	},
	{#State 183
		ACTIONS => {
			'VARIABLE_SYMBOL' => 251
		}
	},
	{#State 184
		DEFAULT => -157
	},
	{#State 185
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 252,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 186
		DEFAULT => -156
	},
	{#State 187
		DEFAULT => -158
	},
	{#State 188
		DEFAULT => -145
	},
	{#State 189
		ACTIONS => {
			"filehandle_ref" => 253
		}
	},
	{#State 190
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			"]" => -109,
			'OP11_COMPARE_LT_GT' => 155,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			";" => -109,
			'OP09_BITWISE_SHIFT' => 157,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP17_LIST_RANGE' => 156,
			")" => -109,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -109,
			'OP04_MATH_POW' => 159
		}
	},
	{#State 191
		ACTIONS => {
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'OP01_QW' => 141,
			")" => -123,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LITERAL_STRING' => 77,
			'KEYS_OR_VALUES' => 136,
			"my" => 118,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109
		},
		GOTOS => {
			'HashReference' => 111,
			'OPTIONAL-36' => 255,
			'ListElement' => 138,
			'ListElements' => 254,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'SubExpression' => 142,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'TypeInner' => 137,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 192
		ACTIONS => {
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			"}" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => 157,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => -100,
			"]" => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_STRING_CAT' => 151,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP18_TERNARY' => -100
		}
	},
	{#State 193
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -99,
			"]" => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP08_STRING_CAT' => 151,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			";" => -99,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			"}" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP09_BITWISE_SHIFT' => 157
		}
	},
	{#State 194
		ACTIONS => {
			"]" => 256
		}
	},
	{#State 195
		DEFAULT => -185
	},
	{#State 196
		DEFAULT => -40
	},
	{#State 197
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 198
		ACTIONS => {
			"if (" => 76,
			"while (" => -143,
			'OP01_NAMED_VOID' => 75,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'OP19_LOOP_CONTROL' => 74,
			'WORD' => 99,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			"foreach my" => -143,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			"for my integer" => -143,
			'OP01_NAMED' => 93,
			'OP01_PRINT' => 73,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			"my" => 78,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108
		},
		GOTOS => {
			'Variable' => 71,
			'OperatorVoid' => 70,
			'PAREN-38' => 88,
			'HashDereferenced' => 89,
			'Expression' => 94,
			'ArrayDereferenced' => 92,
			'Conditional' => 98,
			'VariableDeclaration' => 103,
			'ArrayReference' => 107,
			'OPTIONAL-39' => 106,
			'Statement' => 81,
			'SubExpression' => 80,
			'Operator' => 82,
			'Literal' => 83,
			'PLUS-17' => 258,
			'LoopLabel' => 84,
			'WordScoped' => 110,
			'Operation' => 259,
			'HashReference' => 111,
			'VariableModification' => 85
		}
	},
	{#State 199
		DEFAULT => -42
	},
	{#State 200
		ACTIONS => {
			"\$TYPED_" => 260
		}
	},
	{#State 201
		ACTIONS => {
			";" => 261
		}
	},
	{#State 202
		DEFAULT => -53
	},
	{#State 203
		ACTIONS => {
			"use constant" => 47,
			"our %properties = (" => 262
		},
		GOTOS => {
			'Properties' => 264,
			'Constant' => 263
		}
	},
	{#State 204
		ACTIONS => {
			'OP17_LIST_RANGE' => 156,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 157,
			'OP04_MATH_POW' => 159,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			";" => 265,
			'OP08_STRING_CAT' => 151,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => 152,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 205
		ACTIONS => {
			'LEFT_PAREN' => 266
		}
	},
	{#State 206
		DEFAULT => -140
	},
	{#State 207
		ACTIONS => {
			";" => 267
		}
	},
	{#State 208
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			";" => -139,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 209
		ACTIONS => {
			";" => 268
		}
	},
	{#State 210
		ACTIONS => {
			";" => 269
		}
	},
	{#State 211
		DEFAULT => -121
	},
	{#State 212
		ACTIONS => {
			'OP23_LOGICAL_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP04_MATH_POW' => -85,
			")" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP21_LIST_COMMA' => -85,
			"}" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			";" => -85,
			'OP08_STRING_CAT' => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			"]" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85
		}
	},
	{#State 213
		DEFAULT => -184
	},
	{#State 214
		ACTIONS => {
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			")" => -183,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP21_LIST_COMMA' => -183,
			";" => -183,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -183,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154
		}
	},
	{#State 215
		ACTIONS => {
			'OP21_LIST_COMMA' => 271,
			";" => -180,
			"]" => -180,
			")" => -180
		},
		GOTOS => {
			'PAREN-46' => 270
		}
	},
	{#State 216
		DEFAULT => -119
	},
	{#State 217
		ACTIONS => {
			'WORD' => 272
		},
		GOTOS => {
			'PLUS-48' => 273
		}
	},
	{#State 218
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 275
		}
	},
	{#State 219
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 276,
			";" => 277
		}
	},
	{#State 220
		ACTIONS => {
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'WORD' => 278,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 279,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 221
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'HashReference' => 111,
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 280
		}
	},
	{#State 222
		DEFAULT => -165
	},
	{#State 223
		ACTIONS => {
			'OP17_LIST_RANGE' => -105,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 159,
			")" => -105,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			";" => -105,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => 147,
			"]" => -105,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => -105,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 224
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP18_TERNARY' => -104,
			'OP08_STRING_CAT' => 151,
			'OP11_COMPARE_LT_GT' => 155,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => -104,
			'OP13_BITWISE_AND' => 153,
			"]" => -104,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => -104,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -104,
			"}" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP09_BITWISE_SHIFT' => 157,
			'OP17_LIST_RANGE' => -104,
			";" => -104
		}
	},
	{#State 225
		ACTIONS => {
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			")" => -106,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -106,
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP09_BITWISE_SHIFT' => 157,
			'OP17_LIST_RANGE' => -106,
			";" => -106,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 151,
			'OP11_COMPARE_LT_GT' => 155,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => -106,
			'OP13_BITWISE_AND' => 153,
			"]" => -106
		}
	},
	{#State 226
		ACTIONS => {
			'OP18_TERNARY' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			"]" => -95,
			")" => -95,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => -95,
			"}" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP17_LIST_RANGE' => -95,
			";" => -95
		}
	},
	{#State 227
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -110,
			'OP04_MATH_POW' => 159,
			")" => -110,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP21_LIST_COMMA' => -110,
			"}" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			";" => -110,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -110,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154
		}
	},
	{#State 228
		ACTIONS => {
			'OP17_LIST_RANGE' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			"}" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => -97,
			";" => -97,
			'OP08_STRING_CAT' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			"]" => -97,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP11_COMPARE_LT_GT' => -97
		}
	},
	{#State 229
		ACTIONS => {
			'COLON' => 281
		}
	},
	{#State 230
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP16_LOGICAL_OR' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP12_COMPARE_EQ_NEQ' => 154,
			"]" => -103,
			'OP18_TERNARY' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP08_STRING_CAT' => 151,
			";" => -103,
			")" => -103,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP23_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => 157,
			"}" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP17_LIST_RANGE' => -103
		}
	},
	{#State 231
		ACTIONS => {
			'OP17_LIST_RANGE' => -102,
			'OP09_BITWISE_SHIFT' => 157,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -102,
			'OP04_MATH_POW' => 159,
			")" => -102,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			";" => -102,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			"]" => -102,
			'OP13_BITWISE_AND' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 232
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP18_TERNARY' => -101,
			'OP08_STRING_CAT' => 151,
			";" => -101,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			")" => -101,
			'OP04_MATH_POW' => 159,
			'OP23_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			"}" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP09_BITWISE_SHIFT' => 157,
			'OP17_LIST_RANGE' => -101
		}
	},
	{#State 233
		ACTIONS => {
			";" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 159,
			")" => -107,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => -107,
			"}" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -107,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => -107,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 234
		ACTIONS => {
			")" => -98,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => -98,
			"}" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			'OP18_TERNARY' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_STRING_CAT' => 151,
			'OP11_COMPARE_LT_GT' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			"]" => -98
		}
	},
	{#State 235
		ACTIONS => {
			"]" => -111,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP11_COMPARE_LT_GT' => 155,
			'OP08_STRING_CAT' => 151,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => 152,
			";" => -111,
			'OP17_LIST_RANGE' => 156,
			'OP21_LIST_COMMA' => -111,
			"}" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP09_BITWISE_SHIFT' => 157,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			")" => -111
		}
	},
	{#State 236
		ACTIONS => {
			'OP17_LIST_RANGE' => -91,
			'OP21_LIST_COMMA' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			")" => -91,
			";" => -91,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP18_TERNARY' => -91,
			"]" => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91
		}
	},
	{#State 237
		DEFAULT => -94
	},
	{#State 238
		ACTIONS => {
			"]" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP08_STRING_CAT' => -96,
			'OP18_TERNARY' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			";" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			"}" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -96,
			'OP04_MATH_POW' => 159,
			")" => -96,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => -96
		}
	},
	{#State 239
		DEFAULT => -93
	},
	{#State 240
		ACTIONS => {
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'OP01_QW' => 141,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			"my" => 118,
			'LITERAL_STRING' => 77,
			'KEYS_OR_VALUES' => 136,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108
		},
		GOTOS => {
			'HashReference' => 111,
			'ListElement' => 138,
			'ListElements' => 282,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'SubExpression' => 142,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'TypeInner' => 137,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 241
		ACTIONS => {
			'LEFT_PAREN' => -191,
			'OP03_MATH_INC_DEC' => -191,
			"%{" => -191,
			'WORD' => -191,
			'LITERAL_NUMBER' => -191,
			'LEFT_BRACE' => -191,
			'OP01_NAMED' => -191,
			"undef" => -191,
			'OP01_CLOSE' => -191,
			'OP05_MATH_NEG_LEFT_PAREN' => -191,
			'LEFT_BRACKET' => -191,
			'OP10_NAMED_UNARY' => -191,
			'OP10_NAMED_UNARY_STRINGIFY' => -191,
			'WORD_SCOPED' => -191,
			'OP22_LOGICAL_NOT' => -191,
			'OP01_OPEN' => -191,
			'VARIABLE_SYMBOL' => -191,
			"\@{" => -191,
			'OP05_LOGICAL_NEG' => -191,
			"my" => 118,
			'LITERAL_STRING' => -191
		},
		GOTOS => {
			'TypeInner' => 284,
			'OPTIONAL-50' => 283
		}
	},
	{#State 242
		ACTIONS => {
			"}" => 286,
			'OP21_LIST_COMMA' => 287
		},
		GOTOS => {
			'PAREN-51' => 285
		}
	},
	{#State 243
		DEFAULT => -200
	},
	{#State 244
		DEFAULT => -201
	},
	{#State 245
		ACTIONS => {
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			"my" => 118,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97
		},
		GOTOS => {
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'ListElement' => 138,
			'ListElements' => 288,
			'WordScoped' => 110,
			'TypeInner' => 137,
			'Expression' => 134,
			'SubExpression' => 142,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 246
		DEFAULT => -138
	},
	{#State 247
		ACTIONS => {
			'OP21_LIST_COMMA' => 289
		}
	},
	{#State 248
		DEFAULT => -189
	},
	{#State 249
		DEFAULT => -188
	},
	{#State 250
		ACTIONS => {
			'VARIABLE_SYMBOL' => 290
		}
	},
	{#State 251
		ACTIONS => {
			'LEFT_PAREN' => 291
		}
	},
	{#State 252
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 159,
			")" => 292,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158
		}
	},
	{#State 253
		ACTIONS => {
			'FH_REF_SYMBOL' => 293
		}
	},
	{#State 254
		DEFAULT => -122
	},
	{#State 255
		ACTIONS => {
			")" => 294
		}
	},
	{#State 256
		DEFAULT => -187
	},
	{#State 257
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 258
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"my" => 78,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"}" => 297,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 93,
			'OP01_PRINT' => 73,
			'OP01_CLOSE' => 72,
			"for my integer" => -143,
			"foreach my" => -143,
			"undef" => 91,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'OP19_LOOP_CONTROL' => 74,
			'LEFT_BRACE' => 95,
			'OP01_NAMED_VOID' => 75,
			"while (" => -143,
			'LITERAL_NUMBER' => 97,
			"if (" => 76,
			'WORD' => 99
		},
		GOTOS => {
			'Conditional' => 98,
			'VariableDeclaration' => 103,
			'HashDereferenced' => 89,
			'PAREN-38' => 88,
			'OperatorVoid' => 70,
			'Variable' => 71,
			'ArrayDereferenced' => 92,
			'Expression' => 94,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'LoopLabel' => 84,
			'HashReference' => 111,
			'VariableModification' => 85,
			'Operation' => 296,
			'OPTIONAL-39' => 106,
			'ArrayReference' => 107,
			'SubExpression' => 80,
			'Statement' => 81
		}
	},
	{#State 259
		DEFAULT => -45
	},
	{#State 260
		ACTIONS => {
			'WORD' => 298
		}
	},
	{#State 261
		DEFAULT => -41
	},
	{#State 262
		ACTIONS => {
			"## no critic qw(" => 4,
			")" => 300
		},
		GOTOS => {
			'Critic' => 299
		}
	},
	{#State 263
		DEFAULT => -55
	},
	{#State 264
		ACTIONS => {
			"our %properties_class = (" => 303,
			'LITERAL_NUMBER' => -58,
			"our" => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 301,
			'PropertiesClass' => 302
		}
	},
	{#State 265
		DEFAULT => -174
	},
	{#State 266
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 118,
			'LITERAL_STRING' => 77,
			'KEYS_OR_VALUES' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			")" => -125,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 142,
			'Expression' => 134,
			'TypeInner' => 137,
			'HashDereferenced' => 89,
			'OPTIONAL-37' => 305,
			'Variable' => 139,
			'HashReference' => 111,
			'WordScoped' => 110,
			'ListElement' => 138,
			'ListElements' => 304,
			'Operator' => 82,
			'Literal' => 83
		}
	},
	{#State 267
		DEFAULT => -173
	},
	{#State 268
		DEFAULT => -118
	},
	{#State 269
		DEFAULT => -117
	},
	{#State 270
		DEFAULT => -176
	},
	{#State 271
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			"my" => 118,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashReference' => 111,
			'Operator' => 82,
			'Literal' => 83,
			'ListElement' => 306,
			'WordScoped' => 110,
			'TypeInner' => 137,
			'Expression' => 134,
			'SubExpression' => 142,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 272
		DEFAULT => -179
	},
	{#State 273
		ACTIONS => {
			'WORD' => 308,
			")" => 307
		}
	},
	{#State 274
		ACTIONS => {
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 99,
			'OP19_LOOP_CONTROL' => 74,
			'LEFT_BRACE' => 95,
			"while (" => -143,
			'LITERAL_NUMBER' => 97,
			"if (" => 76,
			'OP01_NAMED_VOID' => 75,
			'OP01_PRINT' => 73,
			'OP01_NAMED' => 93,
			'OP01_CLOSE' => 72,
			"for my integer" => -143,
			"undef" => 91,
			"foreach my" => -143,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77,
			"my" => 78
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'PAREN-38' => 88,
			'Variable' => 71,
			'OperatorVoid' => 70,
			'ArrayDereferenced' => 92,
			'Expression' => 94,
			'Conditional' => 98,
			'VariableDeclaration' => 103,
			'SubExpression' => 80,
			'Statement' => 81,
			'ArrayReference' => 107,
			'OPTIONAL-39' => 106,
			'WordScoped' => 110,
			'PLUS-44' => 310,
			'LoopLabel' => 84,
			'Literal' => 83,
			'Operator' => 82,
			'VariableModification' => 85,
			'HashReference' => 111,
			'Operation' => 309
		}
	},
	{#State 275
		DEFAULT => -151,
		GOTOS => {
			'STAR-41' => 311
		}
	},
	{#State 276
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'WORD_SCOPED' => 30,
			'STDIN' => 206,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 89,
			'Expression' => 134,
			'SubExpression' => 208,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Operator' => 82,
			'Literal' => 83,
			'WordScoped' => 110,
			'SubExpressionOrStdin' => 312,
			'HashReference' => 111
		}
	},
	{#State 277
		DEFAULT => -171
	},
	{#State 278
		ACTIONS => {
			"}" => 313,
			'LEFT_PAREN' => -202
		}
	},
	{#State 279
		ACTIONS => {
			"}" => 314,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 157,
			'OP17_LIST_RANGE' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => 152,
			'OP08_STRING_CAT' => 151,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 280
		ACTIONS => {
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 156,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			'OP11_COMPARE_LT_GT' => 155,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			"]" => 315
		}
	},
	{#State 281
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 316
		}
	},
	{#State 282
		ACTIONS => {
			";" => 317
		}
	},
	{#State 283
		ACTIONS => {
			'LITERAL_STRING' => 77,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111,
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 318,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Expression' => 134
		}
	},
	{#State 284
		DEFAULT => -190
	},
	{#State 285
		DEFAULT => -197
	},
	{#State 286
		DEFAULT => -199
	},
	{#State 287
		ACTIONS => {
			"%{" => 100,
			'WORD' => 168
		},
		GOTOS => {
			'HashEntry' => 319,
			'HashDereferenced' => 167
		}
	},
	{#State 288
		ACTIONS => {
			")" => 320
		}
	},
	{#State 289
		ACTIONS => {
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			"my" => 118,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_QW' => 141,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'SubExpression' => 142,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'TypeInner' => 137,
			'Expression' => 134,
			'ListElements' => 321,
			'ListElement' => 138,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 290
		ACTIONS => {
			'LEFT_PAREN' => 322
		}
	},
	{#State 291
		ACTIONS => {
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED' => 135,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 323,
			'Expression' => 134,
			'HashDereferenced' => 89,
			'Variable' => 139
		}
	},
	{#State 292
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 324
		}
	},
	{#State 293
		ACTIONS => {
			'OP21_LIST_COMMA' => 325
		}
	},
	{#State 294
		DEFAULT => -127
	},
	{#State 295
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 326
		}
	},
	{#State 296
		DEFAULT => -44
	},
	{#State 297
		ACTIONS => {
			";" => 327
		}
	},
	{#State 298
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 328
		}
	},
	{#State 299
		ACTIONS => {
			'WORD' => 330,
			"%{" => 100
		},
		GOTOS => {
			'HashEntryTyped' => 331,
			'HashDereferenced' => 329
		}
	},
	{#State 300
		ACTIONS => {
			";" => 332
		}
	},
	{#State 301
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 333
		}
	},
	{#State 302
		DEFAULT => -57
	},
	{#State 303
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 334
		}
	},
	{#State 304
		DEFAULT => -124
	},
	{#State 305
		ACTIONS => {
			")" => 335
		}
	},
	{#State 306
		DEFAULT => -175
	},
	{#State 307
		DEFAULT => -181
	},
	{#State 308
		DEFAULT => -178
	},
	{#State 309
		DEFAULT => -163
	},
	{#State 310
		ACTIONS => {
			'LITERAL_STRING' => 77,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"}" => 336,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			"for my integer" => -143,
			'OP01_CLOSE' => 72,
			"foreach my" => -143,
			"undef" => 91,
			'OP01_NAMED' => 93,
			'OP01_PRINT' => 73,
			'OP19_LOOP_CONTROL' => 74,
			'LEFT_BRACE' => 95,
			"while (" => -143,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED_VOID' => 75,
			"if (" => 76,
			'WORD' => 99,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'ArrayReference' => 107,
			'OPTIONAL-39' => 106,
			'Statement' => 81,
			'SubExpression' => 80,
			'WordScoped' => 110,
			'Literal' => 83,
			'Operator' => 82,
			'LoopLabel' => 84,
			'HashReference' => 111,
			'VariableModification' => 85,
			'Operation' => 337,
			'HashDereferenced' => 89,
			'PAREN-38' => 88,
			'OperatorVoid' => 70,
			'Variable' => 71,
			'ArrayDereferenced' => 92,
			'Expression' => 94,
			'Conditional' => 98,
			'VariableDeclaration' => 103
		}
	},
	{#State 311
		ACTIONS => {
			'OP01_NAMED' => -154,
			'' => -154,
			"for my integer" => -154,
			"undef" => -154,
			"foreach my" => -154,
			'OP03_MATH_INC_DEC' => -154,
			"%{" => -154,
			'LEFT_PAREN' => -154,
			'LEFT_BRACE' => -154,
			'LITERAL_NUMBER' => -154,
			'WORD' => -154,
			'OP01_OPEN' => -154,
			"else" => 341,
			'OP22_LOGICAL_NOT' => -154,
			"\@{" => -154,
			'OP05_LOGICAL_NEG' => -154,
			'OP10_NAMED_UNARY_STRINGIFY' => -154,
			'OP10_NAMED_UNARY' => -154,
			'LEFT_BRACKET' => -154,
			'OP01_PRINT' => -154,
			'OP01_CLOSE' => -154,
			'OP19_LOOP_CONTROL' => -154,
			"if (" => -154,
			"while (" => -154,
			'OP01_NAMED_VOID' => -154,
			'VARIABLE_SYMBOL' => -154,
			'LITERAL_STRING' => -154,
			"my" => -154,
			"}" => -154,
			"elsif (" => 339,
			'OP05_MATH_NEG_LEFT_PAREN' => -154,
			'WORD_SCOPED' => -154
		},
		GOTOS => {
			'OPTIONAL-43' => 338,
			'PAREN-40' => 340,
			'PAREN-42' => 342
		}
	},
	{#State 312
		ACTIONS => {
			";" => 343
		}
	},
	{#State 313
		DEFAULT => -170
	},
	{#State 314
		DEFAULT => -169
	},
	{#State 315
		DEFAULT => -168
	},
	{#State 316
		DEFAULT => -108
	},
	{#State 317
		DEFAULT => -120
	},
	{#State 318
		ACTIONS => {
			'OP04_MATH_POW' => 159,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => 156,
			'OP21_LIST_COMMA' => -192,
			"}" => -192,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 157,
			'OP11_COMPARE_LT_GT' => 155,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP08_STRING_CAT' => 151,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP18_TERNARY' => 152
		}
	},
	{#State 319
		DEFAULT => -196
	},
	{#State 320
		DEFAULT => -84
	},
	{#State 321
		ACTIONS => {
			")" => 344
		}
	},
	{#State 322
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_QW' => 141,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			"my" => 118,
			'KEYS_OR_VALUES' => 136,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'ListElements' => 345,
			'ListElement' => 138,
			'WordScoped' => 110,
			'TypeInner' => 137,
			'Expression' => 134,
			'SubExpression' => 142,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 323
		ACTIONS => {
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP17_LIST_RANGE' => 346,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => 150,
			'OP04_MATH_POW' => 159,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160
		}
	},
	{#State 324
		DEFAULT => -161
	},
	{#State 325
		ACTIONS => {
			'LITERAL_STRING' => 347
		}
	},
	{#State 326
		ACTIONS => {
			'OP21_LIST_COMMA' => 349,
			")" => 350
		},
		GOTOS => {
			'PAREN-18' => 348
		}
	},
	{#State 327
		DEFAULT => -46
	},
	{#State 328
		DEFAULT => -206
	},
	{#State 329
		DEFAULT => -195
	},
	{#State 330
		ACTIONS => {
			'OP20_HASH_FATARROW' => 351
		}
	},
	{#State 331
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 352
		}
	},
	{#State 332
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 353
		}
	},
	{#State 333
		ACTIONS => {
			"our" => 357,
			'LITERAL_NUMBER' => 354
		},
		GOTOS => {
			'Subroutine' => 355,
			'Method' => 356,
			'MethodOrSubroutine' => 358
		}
	},
	{#State 334
		ACTIONS => {
			'WORD' => 330,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 329,
			'HashEntryTyped' => 359
		}
	},
	{#State 335
		DEFAULT => -128
	},
	{#State 336
		DEFAULT => -164
	},
	{#State 337
		DEFAULT => -162
	},
	{#State 338
		DEFAULT => -155
	},
	{#State 339
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayDereferenced' => 92,
			'ArrayReference' => 107,
			'SubExpression' => 360,
			'Expression' => 134,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 340
		DEFAULT => -150
	},
	{#State 341
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 361
		}
	},
	{#State 342
		DEFAULT => -153
	},
	{#State 343
		DEFAULT => -172
	},
	{#State 344
		DEFAULT => -86
	},
	{#State 345
		ACTIONS => {
			")" => 362
		}
	},
	{#State 346
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			"undef" => 91,
			'OP01_CLOSE' => 72,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'Expression' => 134,
			'SubExpression' => 363,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 347
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 348
		DEFAULT => -48
	},
	{#State 349
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 351
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 367
		}
	},
	{#State 352
		ACTIONS => {
			'OP21_LIST_COMMA' => 369,
			")" => 368
		},
		GOTOS => {
			'PAREN-25' => 370
		}
	},
	{#State 353
		DEFAULT => -66
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
		DEFAULT => -80
	},
	{#State 357
		ACTIONS => {
			'TYPE_METHOD' => 372,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 358
		DEFAULT => -59
	},
	{#State 359
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 373
		}
	},
	{#State 360
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 151,
			")" => 374,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 156
		}
	},
	{#State 361
		DEFAULT => -152
	},
	{#State 362
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 375
		}
	},
	{#State 363
		ACTIONS => {
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			")" => 376,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP11_COMPARE_LT_GT' => 155,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 148,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => -107,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147
		}
	},
	{#State 364
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 109,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'LEFT_PAREN' => 102,
			'LITERAL_NUMBER' => 97,
			'LEFT_BRACE' => 95,
			'WORD' => 28,
			'OP01_NAMED' => 135,
			"undef" => 91,
			'OP01_CLOSE' => 72
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Variable' => 139,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 377,
			'Expression' => 134,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'HashReference' => 111
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 55
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
			'WORD_SCOPED' => 30,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'WORD' => 28,
			'LEFT_BRACE' => 95,
			'LITERAL_NUMBER' => 97,
			'LEFT_PAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			"%{" => 100,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'HashReference' => 111,
			'Literal' => 83,
			'Operator' => 82,
			'WordScoped' => 110,
			'Expression' => 134,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 92,
			'SubExpression' => 380,
			'Variable' => 139,
			'HashDereferenced' => 89
		}
	},
	{#State 368
		ACTIONS => {
			";" => 381
		}
	},
	{#State 369
		ACTIONS => {
			"%{" => 100,
			'WORD' => 330
		},
		GOTOS => {
			'HashDereferenced' => 329,
			'HashEntryTyped' => 382
		}
	},
	{#State 370
		DEFAULT => -63
	},
	{#State 371
		DEFAULT => -61
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 373
		ACTIONS => {
			")" => 384,
			'OP21_LIST_COMMA' => 385
		},
		GOTOS => {
			'PAREN-27' => 386
		}
	},
	{#State 374
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 375
		DEFAULT => -160
	},
	{#State 376
		ACTIONS => {
			'LEFT_BRACE' => 274
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		ACTIONS => {
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP15_LOGICAL_AND' => 146,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -87,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP23_LOGICAL_AND' => -87,
			'OP04_MATH_POW' => 159,
			")" => -87,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP21_LIST_COMMA' => -87,
			"}" => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			";" => -87
		}
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 379
		DEFAULT => -50
	},
	{#State 380
		ACTIONS => {
			'OP17_LIST_RANGE' => 156,
			'OP09_BITWISE_SHIFT' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP21_LIST_COMMA' => -194,
			'OP23_LOGICAL_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 149,
			'OP04_MATH_POW' => 159,
			")" => -194,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 151,
			'OP18_TERNARY' => 152,
			'OP14_BITWISE_OR_XOR' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 148,
			'OP13_BITWISE_AND' => 153,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 381
		DEFAULT => -65
	},
	{#State 382
		DEFAULT => -62
	},
	{#State 383
		ACTIONS => {
			"= sub {" => 390
		}
	},
	{#State 384
		ACTIONS => {
			";" => 391
		}
	},
	{#State 385
		ACTIONS => {
			'WORD' => 330,
			"%{" => 100
		},
		GOTOS => {
			'HashEntryTyped' => 392,
			'HashDereferenced' => 329
		}
	},
	{#State 386
		DEFAULT => -68
	},
	{#State 387
		DEFAULT => -149
	},
	{#State 388
		DEFAULT => -159
	},
	{#State 389
		DEFAULT => -47
	},
	{#State 390
		ACTIONS => {
			"%{" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'LEFT_PAREN' => -72,
			'LEFT_BRACE' => -72,
			'OP19_LOOP_CONTROL' => -72,
			"if (" => -72,
			"while (" => -72,
			'LITERAL_NUMBER' => -72,
			'OP01_NAMED_VOID' => -72,
			'WORD' => -72,
			'OP01_NAMED' => -72,
			'OP01_PRINT' => -72,
			'OP01_CLOSE' => -72,
			"for my integer" => -72,
			"undef" => -72,
			"foreach my" => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'OP10_NAMED_UNARY' => -72,
			'LEFT_BRACKET' => -72,
			'OP05_MATH_NEG_LEFT_PAREN' => -72,
			'WORD_SCOPED' => -72,
			"( my" => 395,
			'VARIABLE_SYMBOL' => -72,
			'OP01_OPEN' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'LITERAL_STRING' => -72,
			"my" => -72,
			"\@{" => -72,
			'OP05_LOGICAL_NEG' => -72
		},
		GOTOS => {
			'MethodArguments' => 393,
			'OPTIONAL-29' => 394
		}
	},
	{#State 391
		DEFAULT => -70
	},
	{#State 392
		DEFAULT => -67
	},
	{#State 393
		DEFAULT => -71
	},
	{#State 394
		ACTIONS => {
			"\@{" => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LITERAL_STRING' => 77,
			"my" => 78,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 113,
			'LEFT_BRACKET' => 114,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"for my integer" => -143,
			'OP01_CLOSE' => 72,
			"undef" => 91,
			"foreach my" => -143,
			'OP01_PRINT' => 73,
			'OP01_NAMED' => 93,
			'WORD' => 99,
			'OP19_LOOP_CONTROL' => 74,
			'LEFT_BRACE' => 95,
			"if (" => 76,
			"while (" => -143,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED_VOID' => 75,
			'LEFT_PAREN' => 102,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101
		},
		GOTOS => {
			'Conditional' => 98,
			'VariableDeclaration' => 103,
			'PAREN-38' => 88,
			'HashDereferenced' => 89,
			'Variable' => 71,
			'OperatorVoid' => 70,
			'ArrayDereferenced' => 92,
			'PLUS-30' => 397,
			'Expression' => 94,
			'WordScoped' => 110,
			'Operator' => 82,
			'Literal' => 83,
			'LoopLabel' => 84,
			'HashReference' => 111,
			'VariableModification' => 85,
			'Operation' => 396,
			'OPTIONAL-39' => 106,
			'ArrayReference' => 107,
			'SubExpression' => 80,
			'Statement' => 81
		}
	},
	{#State 395
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 398
		}
	},
	{#State 396
		DEFAULT => -74
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 108,
			'OP22_LOGICAL_NOT' => 109,
			'LITERAL_STRING' => 77,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 112,
			"}" => 400,
			'LEFT_BRACKET' => 114,
			'OP10_NAMED_UNARY' => 113,
			'OP05_MATH_NEG_LEFT_PAREN' => 87,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 93,
			'OP01_PRINT' => 73,
			'OP01_CLOSE' => 72,
			"for my integer" => -143,
			"foreach my" => -143,
			"undef" => 91,
			"%{" => 100,
			'OP03_MATH_INC_DEC' => 101,
			'LEFT_PAREN' => 102,
			'OP19_LOOP_CONTROL' => 74,
			'LEFT_BRACE' => 95,
			"while (" => -143,
			"if (" => 76,
			'LITERAL_NUMBER' => 97,
			'OP01_NAMED_VOID' => 75,
			'WORD' => 99
		},
		GOTOS => {
			'Statement' => 81,
			'SubExpression' => 80,
			'OPTIONAL-39' => 106,
			'ArrayReference' => 107,
			'VariableModification' => 85,
			'HashReference' => 111,
			'Operation' => 399,
			'WordScoped' => 110,
			'LoopLabel' => 84,
			'Operator' => 82,
			'Literal' => 83,
			'ArrayDereferenced' => 92,
			'Expression' => 94,
			'HashDereferenced' => 89,
			'PAREN-38' => 88,
			'OperatorVoid' => 70,
			'Variable' => 71,
			'VariableDeclaration' => 103,
			'Conditional' => 98
		}
	},
	{#State 398
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 401
		}
	},
	{#State 399
		DEFAULT => -73
	},
	{#State 400
		ACTIONS => {
			";" => 402
		}
	},
	{#State 401
		ACTIONS => {
			'OP21_LIST_COMMA' => 403,
			")" => 404
		},
		GOTOS => {
			'PAREN-31' => 405
		}
	},
	{#State 402
		DEFAULT => -75
	},
	{#State 403
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 404
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 405
		DEFAULT => -77
	},
	{#State 406
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 408
		}
	},
	{#State 407
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 409
		DEFAULT => -79
	},
	{#State 410
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5701 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5708 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5715 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5722 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5733 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5814 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5821 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5828 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5864 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5893 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5900 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5907 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5953 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5989 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5996 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6003 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6025 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6064 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6089 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6096 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6107 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6114 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6188 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6195 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6252 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6284 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6291 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6309 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6411 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6532 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6554 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6576 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6587 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6707 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6721 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6732 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6743 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6754 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6976 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7001 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7023 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_155
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_159
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_160
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_161
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_164
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_167
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7225 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7312 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_180
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_181
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_187
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_188
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_189
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7435 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_192
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_194
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_199
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_200
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7529 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_201
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_206
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	]
],
#line 7620 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpressionOrStdin_139', 
         'SubExpressionOrStdin_140', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_144', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         'Statement_148', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_155', 
         'Loop_156', 
         'Loop_157', 
         'Loop_158', 
         'LoopFor_159', 
         'LoopForEach_160', 
         'LoopWhile_161', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_164', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_167', 
         'VariableRetrieval_168', 
         'VariableRetrieval_169', 
         'VariableRetrieval_170', 
         'VariableDeclaration_171', 
         'VariableDeclaration_172', 
         'VariableModification_173', 
         'VariableModification_174', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_180', 
         'ListElements_181', 
         'ListElement_182', 
         'ListElement_183', 
         'ListElement_184', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_187', 
         'ArrayDereferenced_188', 
         'ArrayDereferenced_189', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_192', 
         'HashEntry_193', 
         'HashEntryTyped_194', 
         'HashEntryTyped_195', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_199', 
         'HashDereferenced_200', 
         'HashDereferenced_201', 
         'WordScoped_202', 
         'WordScoped_203', 
         'LoopLabel_204', 
         'Type_205', 
         'TypeInner_206', 
         'Literal_207', 
         'Literal_208', );
  $self;
}

#line 190 "lib/RPerl/Grammar.eyp"


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


#line 7877 lib/RPerl/Grammar.pm



1;
