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
    our $VERSION = 0.000_920;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$class_properties|our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|for\ my\ integer|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|package|\=\ sub\ \{|while\ \(|elsif\ \(|\$TYPED_|undef|if\ \(|\(\ my|else|use|our|\@_\;|qw\(|my|\%\{|\@\{|\;|\}|\)|\])}gc and return ($1, $1);

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
  [ 'Properties_65' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-27', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'PAREN-27' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'PropertiesClass_70' => 'PropertiesClass', [ 'our hash_ref $class_properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-28', '}', ';' ], 0 ],
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
	'our hash_ref $class_properties' => { ISSEMANTIC => 0 },
	'our hash_ref $properties' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 5,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 1,
			'ModuleHeader' => 7,
			'OPTIONAL-9' => 3,
			'Program' => 2,
			'PAREN-1' => 8,
			'CompileUnit' => 4,
			'PLUS-2' => 6
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 4
		ACTIONS => {
			'' => 11
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 13,
			'OPTIONAL-3' => 12
		}
	},
	{#State 6
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 9,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 14,
			'ModuleHeader' => 7,
			'Critic' => 1,
			'OPTIONAL-9' => 3
		}
	},
	{#State 7
		ACTIONS => {
			"use" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 16,
			"our" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Class' => 19,
			'Module' => 15,
			'Package' => 17,
			'STAR-10' => 18
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 21
		}
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
		DEFAULT => 0
	},
	{#State 12
		ACTIONS => {
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 26
		}
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		ACTIONS => {
			"use" => -27,
			"## no critic qw(" => 9,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 29,
			'Critic' => 28
		}
	},
	{#State 19
		DEFAULT => -23
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			'WORD' => 31,
			")" => 30
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
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 37
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 38
		}
	},
	{#State 30
		DEFAULT => -36
	},
	{#State 31
		DEFAULT => -34
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
			"%{" => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			'WORD' => -11,
			'LBRACE' => -11,
			'VARIABLE_SYMBOL' => -11,
			"for my integer" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"## no critic qw(" => 9,
			"undef" => -11,
			'OP01_CLOSE' => -11,
			"while (" => -11,
			"use constant" => -11,
			"\@{" => -11,
			"my" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_SCOPED' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LPAREN' => -11,
			"foreach my" => -11,
			"use" => -11,
			'OP01_PRINT' => -11,
			"if (" => -11,
			"our" => -11,
			'LBRACKET' => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 38
		ACTIONS => {
			"use constant" => 46,
			"our" => 47
		},
		GOTOS => {
			'PLUS-13' => 49,
			'Subroutine' => 45,
			'Constant' => 48
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
		ACTIONS => {
			'WORD' => -13,
			'LBRACE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			"for my integer" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_SCOPED' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"if (" => -13,
			"our" => -13,
			'LBRACKET' => -13,
			'LPAREN' => -13,
			"use" => 37,
			"foreach my" => -13,
			'OP01_PRINT' => -13,
			'OP01_CLOSE' => -13,
			"undef" => -13,
			"use constant" => -13,
			"\@{" => -13,
			"my" => -13,
			"while (" => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		ACTIONS => {
			"use" => 37
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			"qw(" => 54,
			";" => 55
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			'WORD' => 56
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 48
		DEFAULT => -28
	},
	{#State 49
		ACTIONS => {
			"our" => 47,
			'LITERAL_NUMBER' => 60
		},
		GOTOS => {
			'Subroutine' => 59
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP01_CLOSE' => -15,
			"%{" => -15,
			"undef" => -15,
			'LITERAL_STRING' => -15,
			"my" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 46,
			"\@{" => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			"while (" => -15,
			'OP01_NAMED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_OPEN' => -15,
			'LBRACE' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD' => -15,
			'LITERAL_NUMBER' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LBRACKET' => -15,
			'OP10_NAMED_UNARY' => -15,
			"our" => -15,
			"if (" => -15,
			"for my integer" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			'LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			"foreach my" => -15
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
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 64
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 55
		DEFAULT => -39
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		DEFAULT => -209
	},
	{#State 59
		DEFAULT => -30
	},
	{#State 60
		ACTIONS => {
			";" => 69
		}
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"my" => 107,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			"while (" => -147,
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			"our" => 47,
			"if (" => 96,
			"for my integer" => -147,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_PRINT' => 98,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			"foreach my" => -147,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_NAMED_VOID' => 105,
			'OP19_LOOP_CONTROL' => 104,
			'WORD' => 84
		},
		GOTOS => {
			'HashDereferenced' => 83,
			'LoopLabel' => 81,
			'Operation' => 106,
			'Conditional' => 79,
			'ArrayReference' => 80,
			'SubExpression' => 78,
			'OperatorVoid' => 77,
			'Variable' => 97,
			'Subroutine' => 99,
			'PLUS-8' => 76,
			'VariableModification' => 93,
			'VariableDeclaration' => 71,
			'PAREN-39' => 95,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Operator' => 88,
			'Statement' => 113,
			'ArrayDereferenced' => 112,
			'Expression' => 110,
			'Literal' => 89,
			'OPTIONAL-40' => 109
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"## no critic qw(" => 9,
			"use" => -54,
			"use constant" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'STAR-21' => 116,
			'Critic' => 115
		}
	},
	{#State 65
		ACTIONS => {
			'WORD' => 118,
			")" => 117
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		ACTIONS => {
			"my" => 120
		},
		GOTOS => {
			'TypeInner' => 119
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 121
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		DEFAULT => -214
	},
	{#State 71
		DEFAULT => -151
	},
	{#State 72
		ACTIONS => {
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'Literal' => 89,
			'SubExpression' => 122,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'Variable' => 125
		}
	},
	{#State 73
		ACTIONS => {
			"]" => -101,
			"%{" => 91,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'LITERAL_STRING' => 85,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP13_BITWISE_AND' => -101,
			")" => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'WORD' => 24,
			'OP11_COMPARE_LT_GT' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'LBRACE' => 82,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP06_REGEX_MATCH' => -101,
			'VARIABLE_SYMBOL' => 75,
			'OP18_TERNARY' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_CLOSE' => 111,
			"}" => -101,
			"undef" => 114,
			"\@{" => 108,
			'OP07_STRING_REPEAT' => -101,
			'OP01_OPEN' => 103,
			'OP09_BITWISE_SHIFT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP04_MATH_POW' => -101,
			";" => -101,
			'OP16_LOGICAL_OR' => -101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 94,
			'LPAREN' => 100,
			'OP17_LIST_RANGE' => -101,
			'OP08_STRING_CAT' => -101
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 126,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88
		}
	},
	{#State 74
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 127
		}
	},
	{#State 75
		DEFAULT => -170,
		GOTOS => {
			'STAR-46' => 128
		}
	},
	{#State 76
		ACTIONS => {
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 107,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			"foreach my" => -147,
			"for my integer" => -147,
			'OP01_PRINT' => 98,
			'OP05_LOGICAL_NEG' => 74,
			"if (" => 96,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'WORD' => 84,
			'' => -18,
			'LBRACE' => 82,
			'OP19_LOOP_CONTROL' => 104,
			'WORD_SCOPED' => 22,
			'OP01_NAMED_VOID' => 105,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 102,
			'OP03_MATH_INC_DEC' => 101
		},
		GOTOS => {
			'OPTIONAL-40' => 109,
			'WordScoped' => 92,
			'HashReference' => 90,
			'Literal' => 89,
			'ArrayDereferenced' => 112,
			'Expression' => 110,
			'Operator' => 88,
			'Statement' => 113,
			'Variable' => 97,
			'PAREN-39' => 95,
			'VariableModification' => 93,
			'VariableDeclaration' => 71,
			'Operation' => 129,
			'LoopLabel' => 81,
			'HashDereferenced' => 83,
			'SubExpression' => 78,
			'ArrayReference' => 80,
			'Conditional' => 79,
			'OperatorVoid' => 77
		}
	},
	{#State 77
		DEFAULT => -150
	},
	{#State 78
		ACTIONS => {
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 130,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 136,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133
		}
	},
	{#State 79
		DEFAULT => -148
	},
	{#State 80
		DEFAULT => -137
	},
	{#State 81
		ACTIONS => {
			'COLON' => 147
		}
	},
	{#State 82
		ACTIONS => {
			'WORD' => 150,
			"%{" => 91,
			"}" => 151
		},
		GOTOS => {
			'HashEntry' => 148,
			'HashDereferenced' => 149
		}
	},
	{#State 83
		DEFAULT => -140
	},
	{#State 84
		ACTIONS => {
			'LPAREN' => -206,
			'COLON' => -208
		}
	},
	{#State 85
		DEFAULT => -213
	},
	{#State 86
		ACTIONS => {
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114
		},
		GOTOS => {
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 152,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Variable' => 125
		}
	},
	{#State 87
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'SubExpression' => 153,
			'ArrayReference' => 80,
			'Literal' => 89,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'Variable' => 125
		}
	},
	{#State 88
		DEFAULT => -130
	},
	{#State 89
		DEFAULT => -135
	},
	{#State 90
		DEFAULT => -139
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LBRACE' => 155
		},
		GOTOS => {
			'Variable' => 156,
			'HashReference' => 154
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 157
		}
	},
	{#State 93
		DEFAULT => -152
	},
	{#State 94
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"my" => 120,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"]" => -190,
			"%{" => 91,
			"undef" => 114,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'OP01_QW' => 161,
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 125,
			'OPTIONAL-50' => 164,
			'ListElement' => 163,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'TypeInner' => 162,
			'WordScoped' => 92,
			'Operator' => 88,
			'ListElements' => 158,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Literal' => 89,
			'SubExpression' => 160,
			'ArrayReference' => 80
		}
	},
	{#State 95
		DEFAULT => -146
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'SubExpression' => 165,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Variable' => 125
		}
	},
	{#State 97
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 167,
			'OP02_METHOD_THINARROW' => 169,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP19_VARIABLE_ASSIGN_BY' => 168,
			'OP13_BITWISE_AND' => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP08_MATH_ADD_SUB' => -136,
			'OP03_MATH_INC_DEC' => 166,
			'OP04_MATH_POW' => -136,
			'OP16_LOGICAL_OR' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP06_REGEX_MATCH' => -136,
			'OP18_TERNARY' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP08_STRING_CAT' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP15_LOGICAL_AND' => -136
		}
	},
	{#State 98
		ACTIONS => {
			'LBRACE' => -116,
			'OP01_QW' => -116,
			'WORD_SCOPED' => -116,
			'WORD' => -116,
			'OP03_MATH_INC_DEC' => -116,
			'OP01_NAMED' => -116,
			'OP01_OPEN' => -116,
			'OP05_LOGICAL_NEG' => -116,
			'FH_REF_SYMBOL_BRACES' => 171,
			'VARIABLE_SYMBOL' => -116,
			'LPAREN' => -116,
			'LITERAL_NUMBER' => -116,
			'OP22_LOGICAL_NEG' => -116,
			'LBRACKET' => -116,
			'KEYS_OR_VALUES' => -116,
			'OP10_NAMED_UNARY' => -116,
			"%{" => -116,
			"undef" => -116,
			'OP01_CLOSE' => -116,
			'OP10_STRINGIFY_UNARY' => -116,
			'STDOUT_STDERR' => 173,
			'LITERAL_STRING' => -116,
			"my" => -116,
			'OP05_MATH_NEG_LPAREN' => -116,
			"\@{" => -116
		},
		GOTOS => {
			'PAREN-33' => 170,
			'OPTIONAL-34' => 172
		}
	},
	{#State 99
		DEFAULT => -14
	},
	{#State 100
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 175,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_PRINT' => 176,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'SubExpression' => 174,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Variable' => 125
		}
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 177
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114,
			'LITERAL_STRING' => 85,
			"my" => 120,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 125,
			'ListElement' => 178,
			'TypeInner' => 162,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 179
		}
	},
	{#State 103
		ACTIONS => {
			"my" => 180
		}
	},
	{#State 104
		ACTIONS => {
			'WORD' => 183,
			";" => -120
		},
		GOTOS => {
			'LoopLabel' => 182,
			'OPTIONAL-36' => 181
		}
	},
	{#State 105
		ACTIONS => {
			'WORD' => 24,
			";" => -118,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 161,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 120
		},
		GOTOS => {
			'Variable' => 125,
			'ListElement' => 163,
			'OPTIONAL-35' => 184,
			'TypeInner' => 162,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ListElements' => 185,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'ArrayReference' => 80,
			'SubExpression' => 160,
			'Literal' => 89
		}
	},
	{#State 106
		DEFAULT => -17
	},
	{#State 107
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 186
		}
	},
	{#State 108
		ACTIONS => {
			'LBRACKET' => 94,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'ArrayReference' => 188,
			'Variable' => 187
		}
	},
	{#State 109
		ACTIONS => {
			"for my integer" => 194,
			"while (" => 192,
			"foreach my" => 189
		},
		GOTOS => {
			'LoopWhile' => 195,
			'Loop' => 190,
			'LoopFor' => 191,
			'LoopForEach' => 193
		}
	},
	{#State 110
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP16_LOGICAL_OR' => -133,
			";" => 196,
			'OP04_MATH_POW' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP08_STRING_CAT' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP18_TERNARY' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP07_STRING_REPEAT' => -133,
			'OP12_COMPARE_EQ_NE' => -133
		}
	},
	{#State 111
		ACTIONS => {
			'FH_REF_SYMBOL' => 197
		}
	},
	{#State 112
		DEFAULT => -138
	},
	{#State 113
		DEFAULT => -83
	},
	{#State 114
		DEFAULT => -134
	},
	{#State 115
		DEFAULT => -51
	},
	{#State 116
		ACTIONS => {
			"use" => 37,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 199,
			'Include' => 198
		}
	},
	{#State 117
		ACTIONS => {
			";" => 200
		}
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 70
		},
		GOTOS => {
			'Literal' => 201
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 121
		ACTIONS => {
			'LITERAL_STRING' => -43,
			"my" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"\@{" => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			"while (" => -43,
			'OP01_CLOSE' => -43,
			"( my" => 203,
			"%{" => -43,
			"undef" => -43,
			'LITERAL_NUMBER' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'LBRACKET' => -43,
			'OP10_NAMED_UNARY' => -43,
			"if (" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"for my integer" => -43,
			'OP01_PRINT' => -43,
			'VARIABLE_SYMBOL' => -43,
			'LPAREN' => -43,
			"foreach my" => -43,
			'OP01_NAMED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_OPEN' => -43,
			'LBRACE' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'WORD_SCOPED' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 205,
			'SubroutineArguments' => 204
		}
	},
	{#State 122
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -111,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => 139,
			"]" => -111,
			"}" => -111,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP23_LOGICAL_AND' => -111,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -111,
			'OP04_MATH_POW' => 142,
			";" => -111,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132
		}
	},
	{#State 123
		DEFAULT => -133
	},
	{#State 124
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'SubExpression' => 206,
			'Literal' => 89,
			'ArrayReference' => 80,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92
		}
	},
	{#State 125
		ACTIONS => {
			'OP06_REGEX_MATCH' => -136,
			'OP17_LIST_RANGE' => -136,
			'OP23_LOGICAL_AND' => -136,
			'OP15_LOGICAL_AND' => -136,
			'OP08_STRING_CAT' => -136,
			'OP18_TERNARY' => -136,
			'OP04_MATH_POW' => -136,
			'OP03_MATH_INC_DEC' => 166,
			'OP08_MATH_ADD_SUB' => -136,
			")" => -136,
			'OP14_BITWISE_OR_XOR' => -136,
			'OP09_BITWISE_SHIFT' => -136,
			'OP11_COMPARE_LT_GT' => -136,
			'OP07_MATH_MULT_DIV_MOD' => -136,
			'OP16_LOGICAL_OR' => -136,
			";" => -136,
			'OP12_COMPARE_EQ_NE' => -136,
			'OP21_LIST_COMMA' => -136,
			'OP13_BITWISE_AND' => -136,
			'OP07_STRING_REPEAT' => -136,
			'OP24_LOGICAL_OR_XOR' => -136,
			"}" => -136,
			'OP02_METHOD_THINARROW' => 169,
			"]" => -136
		}
	},
	{#State 126
		ACTIONS => {
			"]" => -100,
			"}" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -100,
			'OP04_MATH_POW' => 142,
			";" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => -100,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -100,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP15_LOGICAL_AND' => -100
		}
	},
	{#State 127
		ACTIONS => {
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP16_LOGICAL_OR' => -92,
			";" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			")" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP04_MATH_POW' => 142,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			"]" => -92,
			"}" => -92
		}
	},
	{#State 128
		ACTIONS => {
			'COLON' => -171,
			'OP21_LIST_COMMA' => -171,
			'OP12_COMPARE_EQ_NE' => -171,
			'OP07_STRING_REPEAT' => -171,
			'OP24_LOGICAL_OR_XOR' => -171,
			'OP13_BITWISE_AND' => -171,
			'OP19_VARIABLE_ASSIGN_BY' => -171,
			'OP19_VARIABLE_ASSIGN' => -171,
			"]" => -171,
			"}" => -171,
			'OP02_METHOD_THINARROW' => -171,
			'OP02_HASH_THINARROW' => 209,
			'OP06_REGEX_MATCH' => -171,
			'OP18_TERNARY' => -171,
			'OP23_LOGICAL_AND' => -171,
			'OP17_LIST_RANGE' => -171,
			'OP15_LOGICAL_AND' => -171,
			'OP02_ARRAY_THINARROW' => 207,
			'OP08_STRING_CAT' => -171,
			")" => -171,
			'OP08_MATH_ADD_SUB' => -171,
			'OP14_BITWISE_OR_XOR' => -171,
			'OP09_BITWISE_SHIFT' => -171,
			'OP03_MATH_INC_DEC' => -171,
			'OP04_MATH_POW' => -171,
			'OP16_LOGICAL_OR' => -171,
			";" => -171,
			'OP07_MATH_MULT_DIV_MOD' => -171,
			'OP11_COMPARE_LT_GT' => -171
		},
		GOTOS => {
			'VariableRetrieval' => 208
		}
	},
	{#State 129
		DEFAULT => -16
	},
	{#State 130
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 210,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Variable' => 125
		}
	},
	{#State 131
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'ArrayReference' => 80,
			'SubExpression' => 211,
			'Literal' => 89,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88
		}
	},
	{#State 132
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Variable' => 125,
			'Literal' => 89,
			'SubExpression' => 212,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83
		}
	},
	{#State 133
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 213
		}
	},
	{#State 134
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 70,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'VariableOrLiteral' => 214,
			'Literal' => 216,
			'Variable' => 215
		}
	},
	{#State 135
		ACTIONS => {
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 217
		}
	},
	{#State 136
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Variable' => 125,
			'Literal' => 89,
			'SubExpression' => 218,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90
		}
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 219,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112
		}
	},
	{#State 138
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'SubExpression' => 220,
			'Literal' => 89,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88
		}
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Variable' => 125,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'Literal' => 89,
			'SubExpression' => 221,
			'ArrayReference' => 80,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'SubExpression' => 222,
			'ArrayReference' => 80,
			'Variable' => 125
		}
	},
	{#State 141
		ACTIONS => {
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87
		},
		GOTOS => {
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'ArrayReference' => 80,
			'Literal' => 89,
			'SubExpression' => 223,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Variable' => 125
		}
	},
	{#State 142
		ACTIONS => {
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73
		},
		GOTOS => {
			'Variable' => 125,
			'Literal' => 89,
			'SubExpression' => 224,
			'ArrayReference' => 80,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90
		}
	},
	{#State 143
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100
		},
		GOTOS => {
			'ArrayReference' => 80,
			'SubExpression' => 225,
			'Literal' => 89,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'Variable' => 125
		}
	},
	{#State 144
		ACTIONS => {
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114
		},
		GOTOS => {
			'Variable' => 125,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'SubExpression' => 226,
			'ArrayReference' => 80,
			'Literal' => 89
		}
	},
	{#State 145
		ACTIONS => {
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Literal' => 89,
			'SubExpression' => 227,
			'ArrayReference' => 80,
			'Variable' => 125
		}
	},
	{#State 146
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'SubExpression' => 228,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88
		}
	},
	{#State 147
		DEFAULT => -145
	},
	{#State 148
		DEFAULT => -202,
		GOTOS => {
			'STAR-53' => 229
		}
	},
	{#State 149
		DEFAULT => -197
	},
	{#State 150
		ACTIONS => {
			'OP20_HASH_FATARROW' => 230
		}
	},
	{#State 151
		DEFAULT => -141
	},
	{#State 152
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP13_BITWISE_AND' => 139,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 145,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => 231,
			'OP08_MATH_ADD_SUB' => 130,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => 143,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131
		}
	},
	{#State 153
		ACTIONS => {
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145,
			'OP08_STRING_CAT' => 144,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 130,
			")" => 232,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140
		}
	},
	{#State 154
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 155
		ACTIONS => {
			"%{" => 91,
			'WORD' => 150
		},
		GOTOS => {
			'HashDereferenced' => 149,
			'HashEntry' => 148
		}
	},
	{#State 156
		ACTIONS => {
			"}" => 234
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			"my" => 120,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			")" => -127,
			'OP01_OPEN' => 103,
			'OP01_QW' => 161,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100
		},
		GOTOS => {
			'ListElement' => 163,
			'Variable' => 125,
			'OPTIONAL-37' => 236,
			'SubExpression' => 160,
			'ArrayReference' => 80,
			'Literal' => 89,
			'Expression' => 123,
			'ListElements' => 235,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'WordScoped' => 92,
			'TypeInner' => 162,
			'HashReference' => 90,
			'HashDereferenced' => 83
		}
	},
	{#State 158
		DEFAULT => -189
	},
	{#State 159
		ACTIONS => {
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 237
		}
	},
	{#State 160
		ACTIONS => {
			"]" => -186,
			'OP21_LIST_COMMA' => -186,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -186,
			'OP04_MATH_POW' => 142,
			";" => -186,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145
		}
	},
	{#State 161
		ACTIONS => {
			'LPAREN' => 238
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 239,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Variable' => 125
		}
	},
	{#State 163
		DEFAULT => -181,
		GOTOS => {
			'STAR-48' => 240
		}
	},
	{#State 164
		ACTIONS => {
			"]" => 241
		}
	},
	{#State 165
		ACTIONS => {
			")" => 242,
			'OP08_MATH_ADD_SUB' => 130,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP23_LOGICAL_AND' => 135,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 166
		DEFAULT => -90
	},
	{#State 167
		ACTIONS => {
			'STDIN' => 244,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101
		},
		GOTOS => {
			'SubExpressionOrStdin' => 243,
			'Variable' => 125,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'Literal' => 89,
			'SubExpression' => 245,
			'ArrayReference' => 80
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'SubExpression' => 246,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Variable' => 125
		}
	},
	{#State 169
		ACTIONS => {
			'WORD' => 247
		}
	},
	{#State 170
		DEFAULT => -115
	},
	{#State 171
		ACTIONS => {
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 120,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 161,
			'LBRACE' => 82
		},
		GOTOS => {
			'SubExpression' => 160,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'ListElements' => 248,
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'ListElement' => 163,
			'Variable' => 125
		}
	},
	{#State 172
		ACTIONS => {
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 161,
			'LBRACE' => 82,
			'OP10_NAMED_UNARY' => 73,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 120,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87
		},
		GOTOS => {
			'Operator' => 88,
			'ListElements' => 249,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 160,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ListElement' => 163,
			'Variable' => 125
		}
	},
	{#State 173
		DEFAULT => -114
	},
	{#State 174
		ACTIONS => {
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 130,
			")" => 250,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 136,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 145,
			'OP23_LOGICAL_AND' => 135,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133
		}
	},
	{#State 175
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 120,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'ArrayReference' => 80,
			'SubExpression' => 179,
			'Literal' => 89,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ListElement' => 251,
			'Variable' => 125
		}
	},
	{#State 176
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 252
		}
	},
	{#State 177
		DEFAULT => -89
	},
	{#State 178
		ACTIONS => {
			'OP21_LIST_COMMA' => 253
		}
	},
	{#State 179
		ACTIONS => {
			'OP04_MATH_POW' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			";" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			'OP18_TERNARY' => -85,
			'OP21_LIST_COMMA' => -186,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85
		}
	},
	{#State 180
		ACTIONS => {
			"filehandle_ref" => 254
		}
	},
	{#State 181
		ACTIONS => {
			";" => 255
		}
	},
	{#State 182
		DEFAULT => -119
	},
	{#State 183
		DEFAULT => -208
	},
	{#State 184
		ACTIONS => {
			";" => 256
		}
	},
	{#State 185
		DEFAULT => -117
	},
	{#State 186
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 187
		ACTIONS => {
			"}" => 258
		}
	},
	{#State 188
		ACTIONS => {
			"}" => 259
		}
	},
	{#State 189
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 260
		}
	},
	{#State 190
		DEFAULT => -149
	},
	{#State 191
		DEFAULT => -160
	},
	{#State 192
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 261,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92
		}
	},
	{#State 193
		DEFAULT => -161
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 262
		}
	},
	{#State 195
		DEFAULT => -162
	},
	{#State 196
		DEFAULT => -82
	},
	{#State 197
		DEFAULT => -88
	},
	{#State 198
		DEFAULT => -53
	},
	{#State 199
		ACTIONS => {
			"use constant" => 46,
			"our hash_ref \$properties" => 264
		},
		GOTOS => {
			'Properties' => 265,
			'Constant' => 263
		}
	},
	{#State 200
		DEFAULT => -40
	},
	{#State 201
		ACTIONS => {
			";" => 266
		}
	},
	{#State 202
		ACTIONS => {
			"\$TYPED_" => 267
		}
	},
	{#State 203
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 204
		DEFAULT => -42
	},
	{#State 205
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 107,
			'LITERAL_STRING' => 85,
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 84,
			'OP01_NAMED_VOID' => 105,
			'WORD_SCOPED' => 22,
			'OP19_LOOP_CONTROL' => 104,
			'LBRACE' => 82,
			"if (" => 96,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			"foreach my" => -147,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			"for my integer" => -147,
			'OP01_PRINT' => 98
		},
		GOTOS => {
			'OPTIONAL-40' => 109,
			'Literal' => 89,
			'Expression' => 110,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'Statement' => 113,
			'WordScoped' => 92,
			'HashReference' => 90,
			'PAREN-39' => 95,
			'VariableModification' => 93,
			'VariableDeclaration' => 71,
			'Variable' => 97,
			'OperatorVoid' => 77,
			'ArrayReference' => 80,
			'Conditional' => 79,
			'SubExpression' => 78,
			'PLUS-17' => 269,
			'Operation' => 270,
			'LoopLabel' => 81,
			'HashDereferenced' => 83
		}
	},
	{#State 206
		ACTIONS => {
			"}" => -85,
			"]" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP04_MATH_POW' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			";" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85
		}
	},
	{#State 207
		ACTIONS => {
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70
		},
		GOTOS => {
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'ArrayReference' => 80,
			'SubExpression' => 271,
			'Literal' => 89,
			'Variable' => 125
		}
	},
	{#State 208
		DEFAULT => -169
	},
	{#State 209
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 272,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'SubExpression' => 273,
			'ArrayReference' => 80,
			'Literal' => 89,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Variable' => 125
		}
	},
	{#State 210
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP08_STRING_CAT' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			")" => -97,
			'OP04_MATH_POW' => 142,
			";" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP13_BITWISE_AND' => -97,
			"]" => -97,
			"}" => -97
		}
	},
	{#State 211
		ACTIONS => {
			"]" => -96,
			"}" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			")" => -96,
			'OP04_MATH_POW' => 142,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP08_STRING_CAT' => -96,
			'OP15_LOGICAL_AND' => -96
		}
	},
	{#State 212
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP09_BITWISE_SHIFT' => 140,
			")" => -103,
			'OP08_MATH_ADD_SUB' => 130,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			";" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP06_REGEX_MATCH' => 133,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP18_TERNARY' => -103,
			"}" => -103,
			"]" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP12_COMPARE_EQ_NE' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 213
		DEFAULT => -94
	},
	{#State 214
		ACTIONS => {
			'COLON' => 274
		}
	},
	{#State 215
		DEFAULT => -211
	},
	{#State 216
		DEFAULT => -212
	},
	{#State 217
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			";" => -112,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => -112,
			'OP08_MATH_ADD_SUB' => 130,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -112,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133,
			"}" => -112,
			"]" => -112,
			'OP13_BITWISE_AND' => 139,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -112
		}
	},
	{#State 218
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139,
			"]" => -107,
			"}" => -107,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -107,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -107,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => -107,
			";" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132
		}
	},
	{#State 219
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP16_LOGICAL_OR' => -104,
			";" => -104,
			'OP04_MATH_POW' => 142,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 130,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 144,
			'OP18_TERNARY' => -104,
			'OP06_REGEX_MATCH' => 133,
			"}" => -104,
			"]" => -104,
			'OP13_BITWISE_AND' => -104,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 220
		ACTIONS => {
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP13_BITWISE_AND' => 139,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -113,
			"]" => -113,
			"}" => -113,
			'OP18_TERNARY' => 134,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => 135,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP06_REGEX_MATCH' => 133,
			";" => -113,
			'OP16_LOGICAL_OR' => 143,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -113,
			'OP04_MATH_POW' => 142
		}
	},
	{#State 221
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -105,
			"]" => -105,
			"}" => -105,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -105,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => -105,
			";" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132
		}
	},
	{#State 222
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -99,
			'OP04_MATH_POW' => 142,
			";" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -99,
			"]" => -99,
			"}" => -99
		}
	},
	{#State 223
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => -106,
			";" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -106,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 139,
			"]" => -106,
			"}" => -106
		}
	},
	{#State 224
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -91,
			")" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => -91,
			";" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP18_TERNARY' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP08_STRING_CAT' => -91,
			"]" => -91,
			"}" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP13_BITWISE_AND' => -91
		}
	},
	{#State 225
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -108,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => -108,
			'OP18_TERNARY' => -108,
			'OP04_MATH_POW' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			")" => -108,
			'OP08_MATH_ADD_SUB' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			";" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -108,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_STRING_REPEAT' => 146,
			"}" => -108,
			"]" => -108
		}
	},
	{#State 226
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP21_LIST_COMMA' => -98,
			"]" => -98,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP08_STRING_CAT' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 133,
			'OP16_LOGICAL_OR' => -98,
			";" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => -98,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP04_MATH_POW' => 142
		}
	},
	{#State 227
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 130,
			")" => -109,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => 143,
			";" => -109,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => -109,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -109,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 136,
			"]" => -109,
			"}" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 228
		ACTIONS => {
			'OP13_BITWISE_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			"]" => -95,
			'OP08_STRING_CAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_MATCH' => 133,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP04_MATH_POW' => 142,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			")" => -95,
			'OP08_MATH_ADD_SUB' => -95
		}
	},
	{#State 229
		ACTIONS => {
			"}" => 277,
			'OP21_LIST_COMMA' => 275
		},
		GOTOS => {
			'PAREN-52' => 276
		}
	},
	{#State 230
		ACTIONS => {
			'OP01_OPEN' => -195,
			'OP03_MATH_INC_DEC' => -195,
			'OP01_NAMED' => -195,
			'WORD' => -195,
			'WORD_SCOPED' => -195,
			'LBRACE' => -195,
			'OP10_NAMED_UNARY' => -195,
			'LBRACKET' => -195,
			'OP22_LOGICAL_NEG' => -195,
			'LITERAL_NUMBER' => -195,
			'VARIABLE_SYMBOL' => -195,
			'LPAREN' => -195,
			'OP05_LOGICAL_NEG' => -195,
			'OP01_CLOSE' => -195,
			"undef" => -195,
			"%{" => -195,
			"\@{" => -195,
			'OP05_MATH_NEG_LPAREN' => -195,
			"my" => 120,
			'LITERAL_STRING' => -195,
			'OP10_STRINGIFY_UNARY' => -195
		},
		GOTOS => {
			'OPTIONAL-51' => 279,
			'TypeInner' => 278
		}
	},
	{#State 231
		DEFAULT => -93
	},
	{#State 232
		DEFAULT => -102
	},
	{#State 233
		DEFAULT => -205
	},
	{#State 234
		DEFAULT => -204
	},
	{#State 235
		DEFAULT => -126
	},
	{#State 236
		ACTIONS => {
			")" => 280
		}
	},
	{#State 237
		DEFAULT => -188
	},
	{#State 238
		ACTIONS => {
			'WORD' => 281
		},
		GOTOS => {
			'PLUS-49' => 282
		}
	},
	{#State 239
		ACTIONS => {
			'OP18_TERNARY' => 134,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP23_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 144,
			'OP06_REGEX_MATCH' => 133,
			'OP16_LOGICAL_OR' => 143,
			";" => -187,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP08_MATH_ADD_SUB' => 130,
			")" => -187,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP04_MATH_POW' => 142,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP13_BITWISE_AND' => 139,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -187,
			"]" => -187
		}
	},
	{#State 240
		ACTIONS => {
			";" => -184,
			'OP21_LIST_COMMA' => 284,
			")" => -184,
			"]" => -184
		},
		GOTOS => {
			'PAREN-47' => 283
		}
	},
	{#State 241
		DEFAULT => -191
	},
	{#State 242
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 286
		}
	},
	{#State 243
		ACTIONS => {
			";" => 287
		}
	},
	{#State 244
		DEFAULT => -144
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145,
			'OP15_LOGICAL_AND' => 136,
			'OP08_STRING_CAT' => 144,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 130,
			'OP04_MATH_POW' => 142,
			";" => -143,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 246
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 130,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			";" => 288,
			'OP16_LOGICAL_OR' => 143,
			'OP06_REGEX_MATCH' => 133,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 145,
			'OP18_TERNARY' => 134,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 247
		ACTIONS => {
			'LPAREN' => 289
		}
	},
	{#State 248
		ACTIONS => {
			";" => 290
		}
	},
	{#State 249
		ACTIONS => {
			";" => 291
		}
	},
	{#State 250
		DEFAULT => -142
	},
	{#State 251
		ACTIONS => {
			'OP21_LIST_COMMA' => 292
		}
	},
	{#State 252
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'WORD' => 24,
			'OP01_QW' => 161,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 120,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'ListElement' => 163,
			'Variable' => 125,
			'Operator' => 88,
			'Expression' => 123,
			'ListElements' => 293,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'SubExpression' => 160,
			'ArrayReference' => 80,
			'TypeInner' => 162,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92
		}
	},
	{#State 253
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 161,
			'WORD' => 24,
			'LITERAL_STRING' => 85,
			"my" => 120,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114
		},
		GOTOS => {
			'Variable' => 125,
			'ListElement' => 163,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'WordScoped' => 92,
			'Operator' => 88,
			'ListElements' => 294,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 160
		}
	},
	{#State 254
		ACTIONS => {
			'FH_REF_SYMBOL' => 295
		}
	},
	{#State 255
		DEFAULT => -125
	},
	{#State 256
		DEFAULT => -123
	},
	{#State 257
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 296,
			";" => 297
		}
	},
	{#State 258
		DEFAULT => -192
	},
	{#State 259
		DEFAULT => -193
	},
	{#State 260
		ACTIONS => {
			'VARIABLE_SYMBOL' => 298
		}
	},
	{#State 261
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP08_MATH_ADD_SUB' => 130,
			")" => 299,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP23_LOGICAL_AND' => 135,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP08_STRING_CAT' => 144
		}
	},
	{#State 262
		ACTIONS => {
			'LPAREN' => 300
		}
	},
	{#State 263
		DEFAULT => -55
	},
	{#State 264
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 301
		}
	},
	{#State 265
		ACTIONS => {
			"our hash_ref \$class_properties" => 304,
			"our" => -58,
			'LITERAL_NUMBER' => -58
		},
		GOTOS => {
			'PropertiesClass' => 303,
			'OPTIONAL-23' => 302
		}
	},
	{#State 266
		DEFAULT => -41
	},
	{#State 267
		ACTIONS => {
			'WORD' => 305
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 306
		}
	},
	{#State 269
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			"while (" => -147,
			'LITERAL_STRING' => 85,
			"my" => 107,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			"}" => 308,
			"for my integer" => -147,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_PRINT' => 98,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			"foreach my" => -147,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			"if (" => 96,
			'OP10_NAMED_UNARY' => 73,
			'LBRACE' => 82,
			'OP19_LOOP_CONTROL' => 104,
			'WORD_SCOPED' => 22,
			'OP01_NAMED_VOID' => 105,
			'WORD' => 84,
			'OP01_NAMED' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103
		},
		GOTOS => {
			'PAREN-39' => 95,
			'VariableDeclaration' => 71,
			'VariableModification' => 93,
			'Variable' => 97,
			'SubExpression' => 78,
			'Conditional' => 79,
			'ArrayReference' => 80,
			'OperatorVoid' => 77,
			'Operation' => 307,
			'HashDereferenced' => 83,
			'LoopLabel' => 81,
			'OPTIONAL-40' => 109,
			'Literal' => 89,
			'Statement' => 113,
			'Operator' => 88,
			'Expression' => 110,
			'ArrayDereferenced' => 112,
			'WordScoped' => 92,
			'HashReference' => 90
		}
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			"]" => 309,
			'OP06_REGEX_MATCH' => 133,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 145,
			'OP18_TERNARY' => 134,
			'OP04_MATH_POW' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 130,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP16_LOGICAL_OR' => 143
		}
	},
	{#State 272
		ACTIONS => {
			"}" => 310,
			'LPAREN' => -206
		}
	},
	{#State 273
		ACTIONS => {
			"}" => 311,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP08_MATH_ADD_SUB' => 130,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP15_LOGICAL_AND' => 136,
			'OP23_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 145,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133
		}
	},
	{#State 274
		ACTIONS => {
			'LITERAL_NUMBER' => 70,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 215,
			'Literal' => 216,
			'VariableOrLiteral' => 312
		}
	},
	{#State 275
		ACTIONS => {
			'WORD' => 150,
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 149,
			'HashEntry' => 313
		}
	},
	{#State 276
		DEFAULT => -201
	},
	{#State 277
		DEFAULT => -203
	},
	{#State 278
		DEFAULT => -194
	},
	{#State 279
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY' => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100
		},
		GOTOS => {
			'Variable' => 125,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'ArrayReference' => 80,
			'SubExpression' => 314,
			'Literal' => 89,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112
		}
	},
	{#State 280
		DEFAULT => -131
	},
	{#State 281
		DEFAULT => -183
	},
	{#State 282
		ACTIONS => {
			")" => 316,
			'WORD' => 315
		}
	},
	{#State 283
		DEFAULT => -180
	},
	{#State 284
		ACTIONS => {
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'OP10_NAMED_UNARY' => 73,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"my" => 120,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108
		},
		GOTOS => {
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 160,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'WordScoped' => 92,
			'TypeInner' => 162,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'ListElement' => 317,
			'Variable' => 125
		}
	},
	{#State 285
		ACTIONS => {
			'OP10_NAMED_UNARY' => 73,
			"if (" => 96,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			"foreach my" => -147,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP01_PRINT' => 98,
			"for my integer" => -147,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 102,
			'WORD' => 84,
			'OP01_NAMED_VOID' => 105,
			'WORD_SCOPED' => 22,
			'OP19_LOOP_CONTROL' => 104,
			'LBRACE' => 82,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 107,
			'LITERAL_STRING' => 85,
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91
		},
		GOTOS => {
			'OPTIONAL-40' => 109,
			'WordScoped' => 92,
			'PLUS-45' => 318,
			'HashReference' => 90,
			'Literal' => 89,
			'ArrayDereferenced' => 112,
			'Expression' => 110,
			'Statement' => 113,
			'Operator' => 88,
			'Variable' => 97,
			'PAREN-39' => 95,
			'VariableModification' => 93,
			'VariableDeclaration' => 71,
			'Operation' => 319,
			'LoopLabel' => 81,
			'HashDereferenced' => 83,
			'ArrayReference' => 80,
			'SubExpression' => 78,
			'OperatorVoid' => 77,
			'Conditional' => 79
		}
	},
	{#State 286
		DEFAULT => -155,
		GOTOS => {
			'STAR-42' => 320
		}
	},
	{#State 287
		DEFAULT => -177
	},
	{#State 288
		DEFAULT => -178
	},
	{#State 289
		ACTIONS => {
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			")" => -129,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 161,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 120,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114
		},
		GOTOS => {
			'Variable' => 125,
			'ListElement' => 163,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'WordScoped' => 92,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'ListElements' => 322,
			'Expression' => 123,
			'ArrayReference' => 80,
			'SubExpression' => 160,
			'Literal' => 89,
			'OPTIONAL-38' => 321
		}
	},
	{#State 290
		DEFAULT => -122
	},
	{#State 291
		DEFAULT => -121
	},
	{#State 292
		ACTIONS => {
			'WORD' => 24,
			'LBRACE' => 82,
			'OP01_QW' => 161,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'KEYS_OR_VALUES' => 159,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 120
		},
		GOTOS => {
			'SubExpression' => 160,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Operator' => 88,
			'ListElements' => 323,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'TypeInner' => 162,
			'ListElement' => 163,
			'Variable' => 125
		}
	},
	{#State 293
		ACTIONS => {
			")" => 324
		}
	},
	{#State 294
		ACTIONS => {
			";" => 325
		}
	},
	{#State 295
		ACTIONS => {
			'OP21_LIST_COMMA' => 326
		}
	},
	{#State 296
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'OP10_NAMED_UNARY' => 73,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'STDIN' => 244,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'SubExpressionOrStdin' => 327,
			'Variable' => 125,
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'ArrayReference' => 80,
			'SubExpression' => 245,
			'Literal' => 89,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123
		}
	},
	{#State 297
		DEFAULT => -175
	},
	{#State 298
		ACTIONS => {
			'LPAREN' => 328
		}
	},
	{#State 299
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 329
		}
	},
	{#State 300
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 91,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'Variable' => 125,
			'Operator' => 88,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 330,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92
		}
	},
	{#State 301
		ACTIONS => {
			'LBRACE' => 331
		}
	},
	{#State 302
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 332
		}
	},
	{#State 303
		DEFAULT => -57
	},
	{#State 304
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 333
		}
	},
	{#State 305
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 334
		}
	},
	{#State 306
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 335
		}
	},
	{#State 307
		DEFAULT => -44
	},
	{#State 308
		ACTIONS => {
			";" => 336
		}
	},
	{#State 309
		DEFAULT => -172
	},
	{#State 310
		DEFAULT => -174
	},
	{#State 311
		DEFAULT => -173
	},
	{#State 312
		DEFAULT => -110
	},
	{#State 313
		DEFAULT => -200
	},
	{#State 314
		ACTIONS => {
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 130,
			'OP04_MATH_POW' => 142,
			'OP18_TERNARY' => 134,
			'OP15_LOGICAL_AND' => 136,
			'OP17_LIST_RANGE' => 145,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => 135,
			'OP06_REGEX_MATCH' => 133,
			"}" => -196,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -196
		}
	},
	{#State 315
		DEFAULT => -182
	},
	{#State 316
		DEFAULT => -185
	},
	{#State 317
		DEFAULT => -179
	},
	{#State 318
		ACTIONS => {
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 107,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			"}" => 337,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			"foreach my" => -147,
			'OP05_LOGICAL_NEG' => 74,
			"for my integer" => -147,
			'OP01_PRINT' => 98,
			"if (" => 96,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94,
			'WORD' => 84,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_NAMED_VOID' => 105,
			'OP19_LOOP_CONTROL' => 104,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 102,
			'OP03_MATH_INC_DEC' => 101
		},
		GOTOS => {
			'OPTIONAL-40' => 109,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Operator' => 88,
			'Statement' => 113,
			'ArrayDereferenced' => 112,
			'Expression' => 110,
			'Literal' => 89,
			'Variable' => 97,
			'VariableDeclaration' => 71,
			'VariableModification' => 93,
			'PAREN-39' => 95,
			'HashDereferenced' => 83,
			'LoopLabel' => 81,
			'Operation' => 338,
			'Conditional' => 79,
			'ArrayReference' => 80,
			'OperatorVoid' => 77,
			'SubExpression' => 78
		}
	},
	{#State 319
		DEFAULT => -167
	},
	{#State 320
		ACTIONS => {
			"for my integer" => -158,
			'OP05_LOGICAL_NEG' => -158,
			'VARIABLE_SYMBOL' => -158,
			'LITERAL_NUMBER' => -158,
			'OP22_LOGICAL_NEG' => -158,
			'OP10_NAMED_UNARY' => -158,
			'LBRACE' => -158,
			'' => -158,
			'WORD' => -158,
			"elsif (" => 342,
			'OP10_STRINGIFY_UNARY' => -158,
			'LITERAL_STRING' => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			"%{" => -158,
			'OP01_PRINT' => -158,
			'LPAREN' => -158,
			"foreach my" => -158,
			'LBRACKET' => -158,
			"if (" => -158,
			'OP01_NAMED_VOID' => -158,
			'WORD_SCOPED' => -158,
			'OP19_LOOP_CONTROL' => -158,
			'OP01_NAMED' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'OP01_OPEN' => -158,
			"else" => 341,
			"while (" => -158,
			"my" => -158,
			"\@{" => -158,
			"undef" => -158,
			'OP01_CLOSE' => -158,
			"}" => -158
		},
		GOTOS => {
			'OPTIONAL-44' => 340,
			'PAREN-41' => 343,
			'PAREN-43' => 339
		}
	},
	{#State 321
		ACTIONS => {
			")" => 344
		}
	},
	{#State 322
		DEFAULT => -128
	},
	{#State 323
		ACTIONS => {
			")" => 345
		}
	},
	{#State 324
		DEFAULT => -84
	},
	{#State 325
		DEFAULT => -124
	},
	{#State 326
		ACTIONS => {
			'LITERAL_STRING' => 346
		}
	},
	{#State 327
		ACTIONS => {
			";" => 347
		}
	},
	{#State 328
		ACTIONS => {
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 159,
			'LBRACKET' => 94,
			'WORD' => 24,
			'LBRACE' => 82,
			'OP01_QW' => 161,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			"my" => 120,
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'Operator' => 88,
			'ListElements' => 348,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'SubExpression' => 160,
			'ArrayReference' => 80,
			'TypeInner' => 162,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ListElement' => 163,
			'Variable' => 125
		}
	},
	{#State 329
		DEFAULT => -165
	},
	{#State 330
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP13_BITWISE_AND' => 139,
			'OP06_REGEX_MATCH' => 133,
			'OP18_TERNARY' => 134,
			'OP23_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 349,
			'OP15_LOGICAL_AND' => 136,
			'OP08_MATH_ADD_SUB' => 130,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP04_MATH_POW' => 142,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132
		}
	},
	{#State 331
		ACTIONS => {
			'WORD' => 352,
			"%{" => 91,
			"}" => 350
		},
		GOTOS => {
			'HashDereferenced' => 351,
			'HashEntryTyped' => 353
		}
	},
	{#State 332
		ACTIONS => {
			"our" => 356,
			'LITERAL_NUMBER' => 358
		},
		GOTOS => {
			'Method' => 354,
			'Subroutine' => 355,
			'MethodOrSubroutine' => 357
		}
	},
	{#State 333
		ACTIONS => {
			'LBRACE' => 359
		}
	},
	{#State 334
		DEFAULT => -210
	},
	{#State 335
		ACTIONS => {
			")" => 362,
			'OP21_LIST_COMMA' => 360
		},
		GOTOS => {
			'PAREN-18' => 361
		}
	},
	{#State 336
		DEFAULT => -46
	},
	{#State 337
		DEFAULT => -168
	},
	{#State 338
		DEFAULT => -166
	},
	{#State 339
		DEFAULT => -157
	},
	{#State 340
		DEFAULT => -159
	},
	{#State 341
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 363
		}
	},
	{#State 342
		ACTIONS => {
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LITERAL_STRING' => 85,
			'WORD' => 24,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'LBRACKET' => 94
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 83,
			'HashReference' => 90,
			'WordScoped' => 92,
			'ArrayDereferenced' => 112,
			'Expression' => 123,
			'Operator' => 88,
			'SubExpression' => 364,
			'Literal' => 89,
			'ArrayReference' => 80
		}
	},
	{#State 343
		DEFAULT => -154
	},
	{#State 344
		DEFAULT => -132
	},
	{#State 345
		DEFAULT => -86
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 365
		}
	},
	{#State 347
		DEFAULT => -176
	},
	{#State 348
		ACTIONS => {
			")" => 366
		}
	},
	{#State 349
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 367,
			'Literal' => 89,
			'ArrayReference' => 80,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'WordScoped' => 92,
			'HashDereferenced' => 83,
			'HashReference' => 90
		}
	},
	{#State 350
		ACTIONS => {
			";" => 368
		}
	},
	{#State 351
		DEFAULT => -199
	},
	{#State 352
		ACTIONS => {
			'OP20_HASH_FATARROW' => 369
		}
	},
	{#State 353
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 370
		}
	},
	{#State 354
		DEFAULT => -80
	},
	{#State 355
		DEFAULT => -81
	},
	{#State 356
		ACTIONS => {
			'TYPE_METHOD' => 371,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 357
		DEFAULT => -59
	},
	{#State 358
		ACTIONS => {
			";" => 372
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 352,
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 351,
			'HashEntryTyped' => 373
		}
	},
	{#State 360
		ACTIONS => {
			"my" => 374
		}
	},
	{#State 361
		DEFAULT => -48
	},
	{#State 362
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 375
		}
	},
	{#State 363
		DEFAULT => -156
	},
	{#State 364
		ACTIONS => {
			'OP18_TERNARY' => 134,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145,
			'OP15_LOGICAL_AND' => 136,
			'OP08_STRING_CAT' => 144,
			'OP06_REGEX_MATCH' => 133,
			'OP16_LOGICAL_OR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => 376,
			'OP08_MATH_ADD_SUB' => 130,
			'OP04_MATH_POW' => 142,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP12_COMPARE_EQ_NE' => 137
		}
	},
	{#State 365
		ACTIONS => {
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 85,
			'OP10_STRINGIFY_UNARY' => 87,
			'OP01_CLOSE' => 111,
			"undef" => 114,
			"%{" => 91,
			'OP10_NAMED_UNARY' => 73,
			'LBRACKET' => 94,
			'OP22_LOGICAL_NEG' => 72,
			'LITERAL_NUMBER' => 70,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 74,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'LBRACE' => 82
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'Literal' => 89,
			'ArrayReference' => 80,
			'SubExpression' => 377,
			'Operator' => 88,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Variable' => 125
		}
	},
	{#State 366
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 367
		ACTIONS => {
			'OP04_MATH_POW' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			")" => 379,
			'OP08_MATH_ADD_SUB' => 130,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP16_LOGICAL_OR' => 143,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 136,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -109,
			'OP18_TERNARY' => -109,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 368
		DEFAULT => -66
	},
	{#State 369
		ACTIONS => {
			"my" => 120
		},
		GOTOS => {
			'TypeInner' => 380
		}
	},
	{#State 370
		ACTIONS => {
			'OP21_LIST_COMMA' => 383,
			"}" => 381
		},
		GOTOS => {
			'PAREN-25' => 382
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
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 385
		}
	},
	{#State 374
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 375
		ACTIONS => {
			"\@_;" => 387
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		ACTIONS => {
			'OP06_REGEX_MATCH' => 133,
			'OP15_LOGICAL_AND' => 136,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => -87,
			'OP17_LIST_RANGE' => 145,
			'OP18_TERNARY' => 134,
			'OP04_MATH_POW' => 142,
			")" => -87,
			'OP08_MATH_ADD_SUB' => 130,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP16_LOGICAL_OR' => 143,
			";" => -87,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP21_LIST_COMMA' => -87,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP07_STRING_REPEAT' => 146,
			"}" => -87,
			"]" => -87
		}
	},
	{#State 378
		DEFAULT => -164
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 285
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 380
		ACTIONS => {
			"%{" => 91,
			"undef" => 114,
			'OP01_CLOSE' => 111,
			'OP10_STRINGIFY_UNARY' => 87,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73
		},
		GOTOS => {
			'Variable' => 125,
			'HashReference' => 90,
			'HashDereferenced' => 83,
			'WordScoped' => 92,
			'Expression' => 123,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'SubExpression' => 390,
			'ArrayReference' => 80,
			'Literal' => 89
		}
	},
	{#State 381
		ACTIONS => {
			";" => 391
		}
	},
	{#State 382
		DEFAULT => -63
	},
	{#State 383
		ACTIONS => {
			"%{" => 91,
			'WORD' => 352
		},
		GOTOS => {
			'HashDereferenced' => 351,
			'HashEntryTyped' => 392
		}
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 393
		}
	},
	{#State 385
		ACTIONS => {
			'OP21_LIST_COMMA' => 396,
			"}" => 395
		},
		GOTOS => {
			'PAREN-27' => 394
		}
	},
	{#State 386
		ACTIONS => {
			'VARIABLE_SYMBOL' => 397
		}
	},
	{#State 387
		DEFAULT => -50
	},
	{#State 388
		DEFAULT => -153
	},
	{#State 389
		DEFAULT => -163
	},
	{#State 390
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 131,
			'OP11_COMPARE_LT_GT' => 132,
			'OP16_LOGICAL_OR' => 143,
			'OP04_MATH_POW' => 142,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 130,
			'OP08_STRING_CAT' => 144,
			'OP23_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 145,
			'OP15_LOGICAL_AND' => 136,
			'OP18_TERNARY' => 134,
			'OP06_REGEX_MATCH' => 133,
			"}" => -198,
			'OP13_BITWISE_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 138,
			'OP07_STRING_REPEAT' => 146,
			'OP21_LIST_COMMA' => -198,
			'OP12_COMPARE_EQ_NE' => 137
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		DEFAULT => -62
	},
	{#State 393
		ACTIONS => {
			"if (" => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP22_LOGICAL_NEG' => -72,
			'LITERAL_NUMBER' => -72,
			'LBRACKET' => -72,
			'LPAREN' => -72,
			'VARIABLE_SYMBOL' => -72,
			"foreach my" => -72,
			'OP01_PRINT' => -72,
			"for my integer" => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP01_OPEN' => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_NAMED' => -72,
			'WORD' => -72,
			'LBRACE' => -72,
			'WORD_SCOPED' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP01_NAMED_VOID' => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			"\@{" => -72,
			'LITERAL_STRING' => -72,
			"my" => -72,
			"while (" => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			"( my" => 399,
			'OP01_CLOSE' => -72,
			"%{" => -72,
			"undef" => -72
		},
		GOTOS => {
			'MethodArguments' => 400,
			'OPTIONAL-29' => 398
		}
	},
	{#State 394
		DEFAULT => -68
	},
	{#State 395
		ACTIONS => {
			";" => 401
		}
	},
	{#State 396
		ACTIONS => {
			'WORD' => 352,
			"%{" => 91
		},
		GOTOS => {
			'HashEntryTyped' => 402,
			'HashDereferenced' => 351
		}
	},
	{#State 397
		DEFAULT => -47
	},
	{#State 398
		ACTIONS => {
			"undef" => 114,
			"%{" => 91,
			'OP01_CLOSE' => 111,
			"while (" => -147,
			'OP10_STRINGIFY_UNARY' => 87,
			"\@{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 107,
			'LITERAL_STRING' => 85,
			'WORD' => 84,
			'WORD_SCOPED' => 22,
			'OP01_NAMED_VOID' => 105,
			'OP19_LOOP_CONTROL' => 104,
			'LBRACE' => 82,
			'OP01_OPEN' => 103,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 102,
			"foreach my" => -147,
			'VARIABLE_SYMBOL' => 75,
			'LPAREN' => 100,
			'OP01_PRINT' => 98,
			"for my integer" => -147,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY' => 73,
			"if (" => 96,
			'LBRACKET' => 94,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'PAREN-39' => 95,
			'VariableDeclaration' => 71,
			'VariableModification' => 93,
			'Variable' => 97,
			'OperatorVoid' => 77,
			'SubExpression' => 78,
			'ArrayReference' => 80,
			'Conditional' => 79,
			'Operation' => 404,
			'LoopLabel' => 81,
			'HashDereferenced' => 83,
			'OPTIONAL-40' => 109,
			'Literal' => 89,
			'Expression' => 110,
			'ArrayDereferenced' => 112,
			'Operator' => 88,
			'Statement' => 113,
			'WordScoped' => 92,
			'PLUS-30' => 403,
			'HashReference' => 90
		}
	},
	{#State 399
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 405
		}
	},
	{#State 400
		DEFAULT => -71
	},
	{#State 401
		DEFAULT => -70
	},
	{#State 402
		DEFAULT => -67
	},
	{#State 403
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"}" => 407,
			"%{" => 91,
			"undef" => 114,
			'LITERAL_STRING' => 85,
			"my" => 107,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 108,
			'OP10_STRINGIFY_UNARY' => 87,
			"while (" => -147,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 102,
			'OP01_OPEN' => 103,
			'LBRACE' => 82,
			'WORD_SCOPED' => 22,
			'OP19_LOOP_CONTROL' => 104,
			'OP01_NAMED_VOID' => 105,
			'WORD' => 84,
			'LITERAL_NUMBER' => 70,
			'OP22_LOGICAL_NEG' => 72,
			'LBRACKET' => 94,
			'OP10_NAMED_UNARY' => 73,
			"if (" => 96,
			"for my integer" => -147,
			'OP01_PRINT' => 98,
			'OP05_LOGICAL_NEG' => 74,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 75,
			"foreach my" => -147
		},
		GOTOS => {
			'OPTIONAL-40' => 109,
			'HashReference' => 90,
			'WordScoped' => 92,
			'Operator' => 88,
			'Statement' => 113,
			'Expression' => 110,
			'ArrayDereferenced' => 112,
			'Literal' => 89,
			'Variable' => 97,
			'VariableDeclaration' => 71,
			'VariableModification' => 93,
			'PAREN-39' => 95,
			'HashDereferenced' => 83,
			'LoopLabel' => 81,
			'Operation' => 406,
			'ArrayReference' => 80,
			'SubExpression' => 78,
			'Conditional' => 79,
			'OperatorVoid' => 77
		}
	},
	{#State 404
		DEFAULT => -74
	},
	{#State 405
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 408
		}
	},
	{#State 406
		DEFAULT => -73
	},
	{#State 407
		ACTIONS => {
			";" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'OP21_LIST_COMMA' => 412,
			")" => 411
		},
		GOTOS => {
			'PAREN-31' => 410
		}
	},
	{#State 409
		DEFAULT => -75
	},
	{#State 410
		DEFAULT => -77
	},
	{#State 411
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 412
		ACTIONS => {
			"my" => 414
		}
	},
	{#State 413
		ACTIONS => {
			"\@_;" => 415
		}
	},
	{#State 414
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 416
		}
	},
	{#State 415
		DEFAULT => -79
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 417
		}
	},
	{#State 417
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5918 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5925 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5932 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5939 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5946 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5953 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5960 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5967 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5974 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5981 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6017 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6028 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6095 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6167 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6295 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6309 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6330 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6373 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6384 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6398 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6405 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6416 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6423 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6487 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6498 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6597 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6608 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6619 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6630 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6641 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6652 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6685 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6696 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6707 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6718 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6729 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6896 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6910 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6943 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6954 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_125
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7103 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7158 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7179 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7212 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 4,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7276 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7287 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7309 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_164
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7342 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_165
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7353 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7367 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_168
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7378 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_171
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_172
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_175
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_177
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7501 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_184
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_185
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7577 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_191
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_192
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_193
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7624 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7631 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_196
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_197
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_198
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_199
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-52', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7696 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_203
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7707 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_204
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7718 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_205
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7729 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7740 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7751 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_208
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7762 lib/RPerl/Grammar.pm
	],
	[#Rule Type_209
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7773 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_210
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_211
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7795 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_212
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7806 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_213
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7817 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7828 lib/RPerl/Grammar.pm
	]
],
#line 7831 lib/RPerl/Grammar.pm
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


#line 8094 lib/RPerl/Grammar.pm



1;
