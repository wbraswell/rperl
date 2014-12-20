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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|elsif\ \(|while\ \(|\$TYPED_|package|undef|\(\ my|if\ \(|else|our|\@_\;|qw\(|use|\@\{|\.\.|\%\{|my|\;|\}|\]|\))}gc and return ($1, $1);

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
  [ 'LoopFor_159' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'SubExpression', '..', 'SubExpression', ')', 'CodeBlock' ], 0 ],
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
			'SHEBANG' => 7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 5,
			'OPTIONAL-9' => 4,
			'PAREN-1' => 3,
			'PLUS-2' => 2,
			'Program' => 8,
			'CompileUnit' => 1,
			'ModuleHeader' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 9,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'ModuleHeader' => 6,
			'PAREN-1' => 11,
			'OPTIONAL-9' => 4,
			'Critic' => 5
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"package" => 12
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			"use constant" => -25,
			"our" => -25,
			"use" => -25,
			"use parent qw(" => 15,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Module' => 17,
			'Package' => 16,
			'Class' => 14,
			'STAR-10' => 13
		}
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 9,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 19,
			'OPTIONAL-3' => 18
		}
	},
	{#State 8
		DEFAULT => -4
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
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -2
	},
	{#State 12
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 13
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-11' => 25,
			'Critic' => 26
		}
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		DEFAULT => -22
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -202
	},
	{#State 24
		DEFAULT => -203
	},
	{#State 25
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 34
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 33
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
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 29
		ACTIONS => {
			"use warnings;" => 38
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
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		DEFAULT => -26
	},
	{#State 34
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 41,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 42,
			'PLUS-13' => 44,
			'Constant' => 45
		}
	},
	{#State 36
		ACTIONS => {
			";" => 46
		}
	},
	{#State 37
		ACTIONS => {
			"\@{" => -11,
			'LEFT_BRACKET' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP05_MATH_NEG' => -11,
			"my" => -11,
			'WORD' => -11,
			"undef" => -11,
			'LEFT_BRACE' => -11,
			"## no critic qw(" => 9,
			'OP05_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED_VOID' => -11,
			"our" => -11,
			"foreach my" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LEFT_PAREN' => -11,
			"if (" => -11,
			"for my integer" => -11,
			"%{" => -11,
			'OP22_LOGICAL_NOT' => -11,
			"while (" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_OPEN' => -11,
			"use" => -11,
			'WORD_SCOPED' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11
		},
		GOTOS => {
			'Critic' => 47,
			'STAR-5' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use RPerl;" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			";" => 50,
			"qw(" => 51
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 52
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 43,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'LEFT_BRACKET' => -13,
			"\@{" => -13,
			"undef" => -13,
			'WORD' => -13,
			"my" => -13,
			'OP05_MATH_NEG' => -13,
			'OP01_CLOSE' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LEFT_BRACE' => -13,
			'LITERAL_STRING' => -13,
			'VARIABLE_SYMBOL' => -13,
			"foreach my" => -13,
			'LEFT_PAREN' => -13,
			"our" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NOT' => -13,
			"for my integer" => -13,
			"%{" => -13,
			"if (" => -13,
			'OP01_OPEN' => -13,
			"use" => 34,
			'LITERAL_NUMBER' => -13,
			"while (" => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'WORD_SCOPED' => -13
		},
		GOTOS => {
			'STAR-6' => 59,
			'Include' => 58
		}
	},
	{#State 49
		ACTIONS => {
			"our" => 60
		}
	},
	{#State 50
		DEFAULT => -39
	},
	{#State 51
		ACTIONS => {
			'WORD' => 62
		},
		GOTOS => {
			'PLUS-15' => 61
		}
	},
	{#State 52
		ACTIONS => {
			'OP20_HASH_FATARROW' => 63
		}
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
		}
	},
	{#State 54
		DEFAULT => -205
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
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 66
		}
	},
	{#State 58
		DEFAULT => -10
	},
	{#State 59
		ACTIONS => {
			"our" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'VARIABLE_SYMBOL' => -15,
			"foreach my" => -15,
			'LEFT_PAREN' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"\@{" => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			'LEFT_BRACKET' => -15,
			"for my integer" => -15,
			"%{" => -15,
			'OP22_LOGICAL_NOT' => -15,
			"undef" => -15,
			'OP05_MATH_NEG' => -15,
			"if (" => -15,
			"my" => -15,
			'WORD' => -15,
			'OP01_CLOSE' => -15,
			'OP01_OPEN' => -15,
			"while (" => -15,
			'LEFT_BRACE' => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LITERAL_STRING' => -15,
			"use constant" => 41,
			'WORD_SCOPED' => -15,
			'OP03_MATH_INC_DEC' => -15
		},
		GOTOS => {
			'STAR-7' => 67,
			'Constant' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 61
		ACTIONS => {
			'WORD' => 70,
			")" => 71
		}
	},
	{#State 62
		DEFAULT => -38
	},
	{#State 63
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 72
		}
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
			"use constant" => -54,
			"use" => -54,
			"our %properties = (" => -54,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 76,
			'STAR-21' => 75
		}
	},
	{#State 67
		ACTIONS => {
			"for my integer" => -143,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			"if (" => 104,
			'WORD' => 80,
			"my" => 81,
			"our" => 43,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"foreach my" => -143,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP01_NAMED' => 111,
			'OP19_LOOP_CONTROL' => 112,
			"\@{" => 87,
			'OP01_PRINT' => 109,
			'OP01_NAMED_VOID' => 110,
			'LEFT_BRACKET' => 86,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			"while (" => -143,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98
		},
		GOTOS => {
			'PLUS-8' => 108,
			'OperatorVoid' => 107,
			'Operator' => 85,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Operation' => 77,
			'OPTIONAL-39' => 82,
			'Subroutine' => 94,
			'Variable' => 118,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Conditional' => 97,
			'Expression' => 114,
			'LoopLabel' => 90,
			'PAREN-38' => 113,
			'Statement' => 89,
			'VariableModification' => 88,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'VariableDeclaration' => 93,
			'SubExpression' => 116
		}
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -37
	},
	{#State 71
		ACTIONS => {
			";" => 122
		}
	},
	{#State 72
		ACTIONS => {
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'Literal' => 123
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 74
		ACTIONS => {
			'LEFT_BRACE' => -43,
			"while (" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_CLOSE' => -43,
			"( my" => 125,
			'OP01_OPEN' => -43,
			'WORD_SCOPED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LITERAL_STRING' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_PRINT' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"\@{" => -43,
			'OP01_NAMED' => -43,
			'LEFT_BRACKET' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'LEFT_PAREN' => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach my" => -43,
			"if (" => -43,
			'OP05_MATH_NEG' => -43,
			'WORD' => -43,
			"my" => -43,
			"%{" => -43,
			"for my integer" => -43,
			"undef" => -43,
			'OP22_LOGICAL_NOT' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 126,
			'SubroutineArguments' => 127
		}
	},
	{#State 75
		ACTIONS => {
			"use" => 34,
			"our %properties = (" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 129,
			'STAR-22' => 128
		}
	},
	{#State 76
		DEFAULT => -51
	},
	{#State 77
		DEFAULT => -17
	},
	{#State 78
		DEFAULT => -130
	},
	{#State 79
		DEFAULT => -134
	},
	{#State 80
		ACTIONS => {
			'LEFT_PAREN' => -202,
			'COLON' => -204
		}
	},
	{#State 81
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 82
		ACTIONS => {
			"foreach my" => 133,
			"for my integer" => 134,
			"while (" => 135
		},
		GOTOS => {
			'LoopForEach' => 131,
			'Loop' => 136,
			'LoopWhile' => 132,
			'LoopFor' => 137
		}
	},
	{#State 83
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 141,
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121
		}
	},
	{#State 84
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23
		},
		GOTOS => {
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 142,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139
		}
	},
	{#State 85
		DEFAULT => -126
	},
	{#State 86
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			"]" => -186,
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'LEFT_BRACE' => 99,
			'OP01_QW' => 144,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"my" => 73,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'TypeInner' => 146,
			'SubExpression' => 149,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'WordScoped' => 121,
			'ListElements' => 148,
			'Operator' => 85,
			'ArrayReference' => 100,
			'ListElement' => 143,
			'OPTIONAL-49' => 147,
			'Variable' => 139
		}
	},
	{#State 87
		ACTIONS => {
			'LEFT_BRACKET' => 86,
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'ArrayReference' => 150,
			'Variable' => 151
		}
	},
	{#State 88
		DEFAULT => -148
	},
	{#State 89
		DEFAULT => -83
	},
	{#State 90
		ACTIONS => {
			'COLON' => 152
		}
	},
	{#State 91
		DEFAULT => -207
	},
	{#State 92
		DEFAULT => -136
	},
	{#State 93
		DEFAULT => -147
	},
	{#State 94
		DEFAULT => -14
	},
	{#State 95
		ACTIONS => {
			'FH_REF_SYMBOL' => 153
		}
	},
	{#State 96
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 154,
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121
		}
	},
	{#State 97
		DEFAULT => -144
	},
	{#State 98
		ACTIONS => {
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 155,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 159,
			"}" => 156,
			"%{" => 103
		},
		GOTOS => {
			'HashEntry' => 158,
			'HashDereferenced' => 157
		}
	},
	{#State 100
		DEFAULT => -133
	},
	{#State 101
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'SubExpression' => 160,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 102
		DEFAULT => -135
	},
	{#State 103
		ACTIONS => {
			'LEFT_BRACE' => 163,
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'Variable' => 162,
			'HashReference' => 161
		}
	},
	{#State 104
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 164,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102
		}
	},
	{#State 105
		ACTIONS => {
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 165,
			"\@{" => 87,
			'OP01_PRINT' => 166,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 167,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140
		}
	},
	{#State 106
		DEFAULT => -166,
		GOTOS => {
			'STAR-45' => 168
		}
	},
	{#State 107
		DEFAULT => -146
	},
	{#State 108
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"foreach my" => -143,
			'OP01_PRINT' => 109,
			'OP01_NAMED_VOID' => 110,
			'OP19_LOOP_CONTROL' => 112,
			"\@{" => 87,
			'OP01_NAMED' => 111,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			'' => -18,
			"for my integer" => -143,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"if (" => 104,
			'OP05_MATH_NEG' => 83,
			'WORD' => 80,
			"my" => 81,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			"while (" => -143,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'OperatorVoid' => 107,
			'Operator' => 85,
			'OPTIONAL-39' => 82,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Operation' => 169,
			'WordScoped' => 121,
			'Conditional' => 97,
			'ArrayReference' => 100,
			'Variable' => 118,
			'SubExpression' => 116,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'VariableDeclaration' => 93,
			'PAREN-38' => 113,
			'VariableModification' => 88,
			'Statement' => 89,
			'Expression' => 114,
			'LoopLabel' => 90
		}
	},
	{#State 109
		ACTIONS => {
			'OP01_OPEN' => -114,
			'OP01_CLOSE' => -114,
			'LITERAL_NUMBER' => -114,
			'OP10_NAMED_UNARY' => -114,
			'OP05_LOGICAL_NEG' => -114,
			'OP01_QW' => -114,
			'LEFT_BRACE' => -114,
			'FH_REF_SYMBOL_BRACES' => 170,
			'LITERAL_STRING' => -114,
			'KEYS_OR_VALUES' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'WORD_SCOPED' => -114,
			'VARIABLE_SYMBOL' => -114,
			'LEFT_PAREN' => -114,
			'OP10_NAMED_UNARY_STRINGIFY' => -114,
			'LEFT_BRACKET' => -114,
			'OP01_NAMED' => -114,
			"\@{" => -114,
			'OP22_LOGICAL_NOT' => -114,
			"undef" => -114,
			"%{" => -114,
			"my" => -114,
			'WORD' => -114,
			'STDOUT_STDERR' => 173,
			'OP05_MATH_NEG' => -114
		},
		GOTOS => {
			'OPTIONAL-34' => 171,
			'PAREN-33' => 172
		}
	},
	{#State 110
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_QW' => 144,
			'OP10_NAMED_UNARY' => 96,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			"my" => 73,
			";" => -116,
			'OP05_MATH_NEG' => 83,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87
		},
		GOTOS => {
			'Operator' => 85,
			'ListElements' => 174,
			'WordScoped' => 121,
			'ListElement' => 143,
			'ArrayReference' => 100,
			'Variable' => 139,
			'OPTIONAL-35' => 175,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 111
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'WORD' => 23,
			"my" => 73,
			'OP05_MATH_NEG' => 83,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'TypeInner' => 146,
			'SubExpression' => 177,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'Variable' => 139,
			'Operator' => 85,
			'WordScoped' => 121,
			'ListElement' => 176,
			'ArrayReference' => 100
		}
	},
	{#State 112
		ACTIONS => {
			'WORD' => 179
		},
		GOTOS => {
			'LoopLabel' => 178
		}
	},
	{#State 113
		DEFAULT => -142
	},
	{#State 114
		ACTIONS => {
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			";" => 180,
			'OP16_LOGICAL_OR' => -129,
			'OP04_MATH_POW' => -129,
			'OP12_COMPARE_EQ_NEQ' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP08_STRING_CAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP18_TERNARY' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP09_BITWISE_SHIFT' => -129
		}
	},
	{#State 115
		ACTIONS => {
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'Variable' => 181
		}
	},
	{#State 116
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP16_LOGICAL_OR' => 186,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP15_LOGICAL_AND' => 193,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 182
		}
	},
	{#State 117
		DEFAULT => -131
	},
	{#State 118
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP19_VARIABLE_ASSIGN' => 198,
			'OP11_COMPARE_LT_GT' => -132,
			'OP03_MATH_INC_DEC' => 200,
			'OP09_BITWISE_SHIFT' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP18_TERNARY' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP04_MATH_POW' => -132,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 199,
			'OP08_MATH_ADD_SUB' => -132,
			'OP08_STRING_CAT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP02_METHOD_THINARROW' => 201
		}
	},
	{#State 119
		ACTIONS => {
			"my" => 202
		}
	},
	{#State 120
		DEFAULT => -208
	},
	{#State 121
		ACTIONS => {
			'LEFT_PAREN' => 203
		}
	},
	{#State 122
		DEFAULT => -40
	},
	{#State 123
		ACTIONS => {
			";" => 204
		}
	},
	{#State 124
		ACTIONS => {
			"\$TYPED_" => 205
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 206
		}
	},
	{#State 126
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			"while (" => -143,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			"foreach my" => -143,
			'LEFT_PAREN' => 105,
			'OP19_LOOP_CONTROL' => 112,
			'OP01_NAMED' => 111,
			"\@{" => 87,
			'OP01_NAMED_VOID' => 110,
			'OP01_PRINT' => 109,
			'LEFT_BRACKET' => 86,
			"for my integer" => -143,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			"if (" => 104,
			'WORD' => 80,
			"my" => 81
		},
		GOTOS => {
			'WordScoped' => 121,
			'Conditional' => 97,
			'ArrayReference' => 100,
			'Variable' => 118,
			'SubExpression' => 116,
			'Literal' => 117,
			'VariableDeclaration' => 93,
			'HashDereferenced' => 92,
			'PAREN-38' => 113,
			'Statement' => 89,
			'VariableModification' => 88,
			'Expression' => 114,
			'LoopLabel' => 90,
			'OperatorVoid' => 107,
			'Operator' => 85,
			'PLUS-17' => 207,
			'OPTIONAL-39' => 82,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Operation' => 208
		}
	},
	{#State 127
		DEFAULT => -42
	},
	{#State 128
		ACTIONS => {
			"our %properties = (" => 211,
			"use constant" => 41
		},
		GOTOS => {
			'Constant' => 210,
			'Properties' => 209
		}
	},
	{#State 129
		DEFAULT => -53
	},
	{#State 130
		ACTIONS => {
			'VARIABLE_SYMBOL' => 212
		}
	},
	{#State 131
		DEFAULT => -157
	},
	{#State 132
		DEFAULT => -158
	},
	{#State 133
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 214
		}
	},
	{#State 135
		ACTIONS => {
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78
		},
		GOTOS => {
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 215,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140
		}
	},
	{#State 136
		DEFAULT => -145
	},
	{#State 137
		DEFAULT => -156
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 216,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102
		}
	},
	{#State 139
		ACTIONS => {
			'OP18_TERNARY' => -132,
			'OP06_REGEX_MATCH' => -132,
			")" => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP03_MATH_INC_DEC' => 200,
			"]" => -132,
			"}" => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP02_METHOD_THINARROW' => 201,
			'OP08_STRING_CAT' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			".." => -132,
			'OP13_BITWISE_AND' => -132,
			";" => -132,
			'OP17_LIST_RANGE' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP04_MATH_POW' => -132,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132
		}
	},
	{#State 140
		DEFAULT => -129
	},
	{#State 141
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			")" => 217,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => 186,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197
		}
	},
	{#State 142
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP16_LOGICAL_OR' => -100,
			".." => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			"}" => -100,
			"]" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -100
		}
	},
	{#State 143
		DEFAULT => -177,
		GOTOS => {
			'STAR-47' => 218
		}
	},
	{#State 144
		ACTIONS => {
			'LEFT_PAREN' => 219
		}
	},
	{#State 145
		ACTIONS => {
			"%{" => 103
		},
		GOTOS => {
			'HashDereferenced' => 220
		}
	},
	{#State 146
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 221,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 147
		ACTIONS => {
			"]" => 222
		}
	},
	{#State 148
		DEFAULT => -185
	},
	{#State 149
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			"]" => -182,
			'OP11_COMPARE_LT_GT' => 184,
			'OP06_REGEX_MATCH' => 190,
			")" => -182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 182,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP21_LIST_COMMA' => -182,
			'OP13_BITWISE_AND' => 197,
			";" => -182,
			'OP17_LIST_RANGE' => 196,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185
		}
	},
	{#State 150
		ACTIONS => {
			"}" => 223
		}
	},
	{#State 151
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 152
		DEFAULT => -141
	},
	{#State 153
		DEFAULT => -88
	},
	{#State 154
		ACTIONS => {
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			".." => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP23_LOGICAL_AND' => -99,
			"]" => -99,
			"}" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP06_REGEX_MATCH' => 190,
			")" => -99,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -99
		}
	},
	{#State 155
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			".." => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP23_LOGICAL_AND' => -92,
			"]" => -92,
			"}" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			")" => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP18_TERNARY' => -92
		}
	},
	{#State 156
		DEFAULT => -137
	},
	{#State 157
		DEFAULT => -193
	},
	{#State 158
		DEFAULT => -198,
		GOTOS => {
			'STAR-52' => 225
		}
	},
	{#State 159
		ACTIONS => {
			'OP20_HASH_FATARROW' => 226
		}
	},
	{#State 160
		ACTIONS => {
			'OP15_LOGICAL_AND' => 193,
			".." => -109,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP21_LIST_COMMA' => -109,
			";" => -109,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP16_LOGICAL_OR' => 186,
			'OP18_TERNARY' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -109,
			"}" => -109,
			"]" => -109,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => -109
		}
	},
	{#State 161
		ACTIONS => {
			"}" => 227
		}
	},
	{#State 162
		ACTIONS => {
			"}" => 228
		}
	},
	{#State 163
		ACTIONS => {
			"%{" => 103,
			'WORD' => 159
		},
		GOTOS => {
			'HashEntry' => 158,
			'HashDereferenced' => 157
		}
	},
	{#State 164
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => 229,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP16_LOGICAL_OR' => 186,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197
		}
	},
	{#State 165
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'WORD' => 23,
			"my" => 73,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 177,
			'TypeInner' => 146,
			'Variable' => 139,
			'ListElement' => 230,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121
		}
	},
	{#State 166
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 231
		}
	},
	{#State 167
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => 232,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197
		}
	},
	{#State 168
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -167,
			")" => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP18_TERNARY' => -167,
			'OP23_LOGICAL_AND' => -167,
			'OP19_VARIABLE_ASSIGN' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			"}" => -167,
			"]" => -167,
			'OP03_MATH_INC_DEC' => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			'OP08_STRING_CAT' => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			'OP15_LOGICAL_AND' => -167,
			".." => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			'COLON' => -167,
			'OP02_ARRAY_THINARROW' => 233,
			'OP02_METHOD_THINARROW' => -167,
			'OP16_LOGICAL_OR' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			'OP04_MATH_POW' => -167,
			'OP12_COMPARE_EQ_NEQ' => -167,
			";" => -167,
			'OP17_LIST_RANGE' => -167,
			'OP13_BITWISE_AND' => -167,
			'OP02_HASH_THINARROW' => 235,
			'OP21_LIST_COMMA' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 234
		}
	},
	{#State 169
		DEFAULT => -16
	},
	{#State 170
		ACTIONS => {
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 144,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			'WORD' => 23,
			"my" => 73,
			'OP05_MATH_NEG' => 83,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 121,
			'ListElements' => 236,
			'Operator' => 85,
			'ArrayReference' => 100,
			'ListElement' => 143,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'Literal' => 117,
			'HashDereferenced' => 92
		}
	},
	{#State 171
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP01_QW' => 144,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			"my" => 73,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86
		},
		GOTOS => {
			'ListElement' => 143,
			'ArrayReference' => 100,
			'Operator' => 85,
			'ListElements' => 237,
			'WordScoped' => 121,
			'Variable' => 139,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 149,
			'TypeInner' => 146,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102
		}
	},
	{#State 172
		DEFAULT => -113
	},
	{#State 173
		DEFAULT => -112
	},
	{#State 174
		DEFAULT => -115
	},
	{#State 175
		ACTIONS => {
			";" => 238
		}
	},
	{#State 176
		ACTIONS => {
			'OP21_LIST_COMMA' => 239
		}
	},
	{#State 177
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			")" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP21_LIST_COMMA' => -182,
			'OP16_LOGICAL_OR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP04_MATH_POW' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP08_STRING_CAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP14_BITWISE_OR_XOR' => -85
		}
	},
	{#State 178
		ACTIONS => {
			";" => 240
		}
	},
	{#State 179
		DEFAULT => -204
	},
	{#State 180
		DEFAULT => -82
	},
	{#State 181
		DEFAULT => -89
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'Variable' => 241
		}
	},
	{#State 183
		ACTIONS => {
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'SubExpression' => 242,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 184
		ACTIONS => {
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Variable' => 139,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 243,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79
		}
	},
	{#State 185
		ACTIONS => {
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120
		},
		GOTOS => {
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 244,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 186
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 245
		}
	},
	{#State 187
		ACTIONS => {
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Variable' => 139,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 246,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79
		}
	},
	{#State 188
		ACTIONS => {
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'SubExpression' => 247,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 189
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86
		},
		GOTOS => {
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 248,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 190
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 249
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 250
		}
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 251,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140
		}
	},
	{#State 193
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23
		},
		GOTOS => {
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 252,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140
		}
	},
	{#State 194
		ACTIONS => {
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103
		},
		GOTOS => {
			'SubExpression' => 253,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 195
		ACTIONS => {
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101
		},
		GOTOS => {
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 254,
			'Variable' => 139,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85
		}
	},
	{#State 196
		ACTIONS => {
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120
		},
		GOTOS => {
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 255,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Variable' => 139
		}
	},
	{#State 197
		ACTIONS => {
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'SubExpression' => 256,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140,
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 198
		ACTIONS => {
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'STDIN' => 259,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'SubExpressionOrStdin' => 258,
			'Literal' => 117,
			'SubExpression' => 257,
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121
		}
	},
	{#State 199
		ACTIONS => {
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 260
		}
	},
	{#State 200
		DEFAULT => -90
	},
	{#State 201
		ACTIONS => {
			'WORD' => 261
		}
	},
	{#State 202
		ACTIONS => {
			"filehandle_ref" => 262
		}
	},
	{#State 203
		ACTIONS => {
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			"my" => 73,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP01_OPEN' => 119,
			")" => -123,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 144,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'SubExpression' => 149,
			'TypeInner' => 146,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'Variable' => 139,
			'OPTIONAL-36' => 264,
			'ListElements' => 263,
			'Operator' => 85,
			'WordScoped' => 121,
			'ListElement' => 143,
			'ArrayReference' => 100
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
			'VARIABLE_SYMBOL' => 266
		}
	},
	{#State 207
		ACTIONS => {
			"for my integer" => -143,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			"if (" => 104,
			"my" => 81,
			'WORD' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"foreach my" => -143,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP19_LOOP_CONTROL' => 112,
			"\@{" => 87,
			'OP01_NAMED' => 111,
			'OP01_NAMED_VOID' => 110,
			'OP01_PRINT' => 109,
			'LEFT_BRACKET' => 86,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			"}" => 268,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			"while (" => -143,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96
		},
		GOTOS => {
			'Variable' => 118,
			'Conditional' => 97,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Statement' => 89,
			'VariableModification' => 88,
			'PAREN-38' => 113,
			'LoopLabel' => 90,
			'Expression' => 114,
			'SubExpression' => 116,
			'HashDereferenced' => 92,
			'VariableDeclaration' => 93,
			'Literal' => 117,
			'Operator' => 85,
			'OperatorVoid' => 107,
			'Operation' => 267,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'OPTIONAL-39' => 82
		}
	},
	{#State 208
		DEFAULT => -45
	},
	{#State 209
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 270,
			"our" => -58
		},
		GOTOS => {
			'PropertiesClass' => 269,
			'OPTIONAL-23' => 271
		}
	},
	{#State 210
		DEFAULT => -55
	},
	{#State 211
		ACTIONS => {
			"## no critic qw(" => 9,
			")" => 272
		},
		GOTOS => {
			'Critic' => 273
		}
	},
	{#State 212
		ACTIONS => {
			";" => 275,
			'OP19_VARIABLE_ASSIGN' => 274
		}
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 276
		}
	},
	{#State 214
		ACTIONS => {
			'LEFT_PAREN' => 277
		}
	},
	{#State 215
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => 191,
			'OP18_TERNARY' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => 278,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => 186,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192
		}
	},
	{#State 216
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -85,
			"]" => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP06_REGEX_MATCH' => -85,
			")" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP04_MATH_POW' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			".." => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85
		}
	},
	{#State 217
		DEFAULT => -93
	},
	{#State 218
		ACTIONS => {
			")" => -180,
			";" => -180,
			'OP21_LIST_COMMA' => 279,
			"]" => -180
		},
		GOTOS => {
			'PAREN-46' => 280
		}
	},
	{#State 219
		ACTIONS => {
			'WORD' => 281
		},
		GOTOS => {
			'PLUS-48' => 282
		}
	},
	{#State 220
		DEFAULT => -184
	},
	{#State 221
		ACTIONS => {
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP17_LIST_RANGE' => 196,
			";" => -183,
			'OP13_BITWISE_AND' => 197,
			'OP21_LIST_COMMA' => -183,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			"]" => -183,
			'OP09_BITWISE_SHIFT' => 183,
			")" => -183,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 182
		}
	},
	{#State 222
		DEFAULT => -187
	},
	{#State 223
		DEFAULT => -189
	},
	{#State 224
		DEFAULT => -188
	},
	{#State 225
		ACTIONS => {
			"}" => 283,
			'OP21_LIST_COMMA' => 284
		},
		GOTOS => {
			'PAREN-51' => 285
		}
	},
	{#State 226
		ACTIONS => {
			'LEFT_BRACE' => -191,
			'LITERAL_NUMBER' => -191,
			'OP05_LOGICAL_NEG' => -191,
			'OP10_NAMED_UNARY' => -191,
			'OP01_CLOSE' => -191,
			'OP01_OPEN' => -191,
			'WORD_SCOPED' => -191,
			'OP03_MATH_INC_DEC' => -191,
			'LITERAL_STRING' => -191,
			'OP01_NAMED' => -191,
			"\@{" => -191,
			'LEFT_BRACKET' => -191,
			'OP10_NAMED_UNARY_STRINGIFY' => -191,
			'VARIABLE_SYMBOL' => -191,
			'LEFT_PAREN' => -191,
			'OP05_MATH_NEG' => -191,
			"my" => 73,
			'WORD' => -191,
			"%{" => -191,
			'OP22_LOGICAL_NOT' => -191,
			"undef" => -191
		},
		GOTOS => {
			'TypeInner' => 286,
			'OPTIONAL-50' => 287
		}
	},
	{#State 227
		DEFAULT => -201
	},
	{#State 228
		DEFAULT => -200
	},
	{#State 229
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 288
		}
	},
	{#State 230
		ACTIONS => {
			'OP21_LIST_COMMA' => 290
		}
	},
	{#State 231
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP01_QW' => 144,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			'WORD' => 23,
			"my" => 73,
			'OP05_MATH_NEG' => 83,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'SubExpression' => 149,
			'TypeInner' => 146,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'Variable' => 139,
			'Operator' => 85,
			'ListElements' => 291,
			'WordScoped' => 121,
			'ListElement' => 143,
			'ArrayReference' => 100
		}
	},
	{#State 232
		DEFAULT => -138
	},
	{#State 233
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23
		},
		GOTOS => {
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 292,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139
		}
	},
	{#State 234
		DEFAULT => -165
	},
	{#State 235
		ACTIONS => {
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 294,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'WordScoped' => 121,
			'Operator' => 85,
			'ArrayReference' => 100,
			'Variable' => 139,
			'SubExpression' => 293,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Expression' => 140
		}
	},
	{#State 236
		ACTIONS => {
			";" => 295
		}
	},
	{#State 237
		ACTIONS => {
			";" => 296
		}
	},
	{#State 238
		DEFAULT => -119
	},
	{#State 239
		ACTIONS => {
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"my" => 73,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_QW' => 144,
			'LITERAL_NUMBER' => 120,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'ListElement' => 143,
			'WordScoped' => 121,
			'Operator' => 85,
			'ListElements' => 297,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'TypeInner' => 146,
			'SubExpression' => 149
		}
	},
	{#State 240
		DEFAULT => -121
	},
	{#State 241
		ACTIONS => {
			'COLON' => 298
		}
	},
	{#State 242
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP04_MATH_POW' => 188,
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			".." => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			"}" => -98,
			"]" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			")" => -98,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => -98
		}
	},
	{#State 243
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -101,
			".." => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => -101,
			";" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			"]" => -101,
			"}" => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 244
		ACTIONS => {
			".." => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP08_STRING_CAT' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP21_LIST_COMMA' => -96,
			";" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP06_REGEX_MATCH' => 190,
			")" => -96,
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			"}" => -96,
			"]" => -96,
			'OP11_COMPARE_LT_GT' => -96
		}
	},
	{#State 245
		ACTIONS => {
			'OP16_LOGICAL_OR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP17_LIST_RANGE' => -106,
			";" => -106,
			'OP13_BITWISE_AND' => 197,
			'OP21_LIST_COMMA' => -106,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			".." => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP23_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => 184,
			"}" => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -106,
			'OP18_TERNARY' => -106
		}
	},
	{#State 246
		ACTIONS => {
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			")" => -95,
			'OP06_REGEX_MATCH' => 190,
			"}" => -95,
			"]" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			".." => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP08_STRING_CAT' => -95,
			'OP21_LIST_COMMA' => -95,
			";" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP16_LOGICAL_OR' => -95
		}
	},
	{#State 247
		ACTIONS => {
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91,
			'OP15_LOGICAL_AND' => -91,
			".." => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP08_MATH_ADD_SUB' => -91
		}
	},
	{#State 248
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => 184,
			"]" => -102,
			"}" => -102,
			'OP06_REGEX_MATCH' => 190,
			")" => -102,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP13_BITWISE_AND' => -102,
			";" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			".." => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => -102
		}
	},
	{#State 249
		DEFAULT => -94
	},
	{#State 250
		ACTIONS => {
			")" => -110,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => -110,
			"]" => -110,
			"}" => -110,
			'OP11_COMPARE_LT_GT' => 184,
			".." => -110,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP21_LIST_COMMA' => -110,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			";" => -110
		}
	},
	{#State 251
		ACTIONS => {
			".." => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP17_LIST_RANGE' => -97,
			";" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP06_REGEX_MATCH' => 190,
			")" => -97,
			'OP18_TERNARY' => -97,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			"]" => -97,
			'OP11_COMPARE_LT_GT' => -97
		}
	},
	{#State 252
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 184,
			"]" => -105,
			"}" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP18_TERNARY' => -105,
			'OP06_REGEX_MATCH' => 190,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 183,
			'OP13_BITWISE_AND' => 197,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			".." => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => -105
		}
	},
	{#State 253
		ACTIONS => {
			'OP17_LIST_RANGE' => 196,
			";" => -111,
			'OP13_BITWISE_AND' => 197,
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			".." => -111,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => 193,
			'OP11_COMPARE_LT_GT' => 184,
			"}" => -111,
			"]" => -111,
			'OP23_LOGICAL_AND' => 191,
			'OP18_TERNARY' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			")" => -111,
			'OP06_REGEX_MATCH' => 190
		}
	},
	{#State 254
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => -104,
			";" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			".." => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP23_LOGICAL_AND' => -104,
			"]" => -104,
			"}" => -104,
			'OP11_COMPARE_LT_GT' => 184,
			'OP06_REGEX_MATCH' => 190,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -104
		}
	},
	{#State 255
		ACTIONS => {
			'OP21_LIST_COMMA' => -107,
			'OP17_LIST_RANGE' => undef,
			";" => -107,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP16_LOGICAL_OR' => 186,
			".." => -107,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			"}" => -107,
			"]" => -107,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => -107,
			'OP18_TERNARY' => -107,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -107
		}
	},
	{#State 256
		ACTIONS => {
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -103,
			'OP11_COMPARE_LT_GT' => 184,
			"}" => -103,
			"]" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP14_BITWISE_OR_XOR' => -103,
			".." => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			";" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188
		}
	},
	{#State 257
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP13_BITWISE_AND' => 197,
			";" => -139,
			'OP17_LIST_RANGE' => 196
		}
	},
	{#State 258
		ACTIONS => {
			";" => 299
		}
	},
	{#State 259
		DEFAULT => -140
	},
	{#State 260
		ACTIONS => {
			'OP18_TERNARY' => 182,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => 191,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			";" => 300,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186
		}
	},
	{#State 261
		ACTIONS => {
			'LEFT_PAREN' => 301
		}
	},
	{#State 262
		ACTIONS => {
			'FH_REF_SYMBOL' => 302
		}
	},
	{#State 263
		DEFAULT => -122
	},
	{#State 264
		ACTIONS => {
			")" => 303
		}
	},
	{#State 265
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 304
		}
	},
	{#State 266
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 305
		}
	},
	{#State 267
		DEFAULT => -44
	},
	{#State 268
		ACTIONS => {
			";" => 306
		}
	},
	{#State 269
		DEFAULT => -57
	},
	{#State 270
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 307
		}
	},
	{#State 271
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 308
		}
	},
	{#State 272
		ACTIONS => {
			";" => 309
		}
	},
	{#State 273
		ACTIONS => {
			"%{" => 103,
			'WORD' => 312
		},
		GOTOS => {
			'HashDereferenced' => 311,
			'HashEntryTyped' => 310
		}
	},
	{#State 274
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'WORD' => 23,
			'STDIN' => 259,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84
		},
		GOTOS => {
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'SubExpressionOrStdin' => 313,
			'HashDereferenced' => 92,
			'SubExpression' => 257,
			'Variable' => 139,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85
		}
	},
	{#State 275
		DEFAULT => -171
	},
	{#State 276
		ACTIONS => {
			'LEFT_PAREN' => 314
		}
	},
	{#State 277
		ACTIONS => {
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 315
		}
	},
	{#State 278
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 316
		}
	},
	{#State 279
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			"my" => 73,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'ListElement' => 317,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102
		}
	},
	{#State 280
		DEFAULT => -176
	},
	{#State 281
		DEFAULT => -179
	},
	{#State 282
		ACTIONS => {
			")" => 319,
			'WORD' => 318
		}
	},
	{#State 283
		DEFAULT => -199
	},
	{#State 284
		ACTIONS => {
			"%{" => 103,
			'WORD' => 159
		},
		GOTOS => {
			'HashEntry' => 320,
			'HashDereferenced' => 157
		}
	},
	{#State 285
		DEFAULT => -197
	},
	{#State 286
		DEFAULT => -190
	},
	{#State 287
		ACTIONS => {
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Variable' => 139,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 321,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79
		}
	},
	{#State 288
		DEFAULT => -151,
		GOTOS => {
			'STAR-41' => 322
		}
	},
	{#State 289
		ACTIONS => {
			'OP01_NAMED' => 111,
			"\@{" => 87,
			'OP19_LOOP_CONTROL' => 112,
			'OP01_NAMED_VOID' => 110,
			'OP01_PRINT' => 109,
			'LEFT_BRACKET' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			"foreach my" => -143,
			'LEFT_PAREN' => 105,
			'OP05_MATH_NEG' => 83,
			"if (" => 104,
			'WORD' => 80,
			"my" => 81,
			"for my integer" => -143,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"while (" => -143,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'Variable' => 118,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Conditional' => 97,
			'Expression' => 114,
			'LoopLabel' => 90,
			'PAREN-38' => 113,
			'VariableModification' => 88,
			'Statement' => 89,
			'Literal' => 117,
			'VariableDeclaration' => 93,
			'HashDereferenced' => 92,
			'SubExpression' => 116,
			'OperatorVoid' => 107,
			'Operator' => 85,
			'PLUS-44' => 324,
			'HashReference' => 102,
			'Operation' => 323,
			'ArrayDereferenced' => 79,
			'OPTIONAL-39' => 82
		}
	},
	{#State 290
		ACTIONS => {
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 144,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"my" => 73,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103
		},
		GOTOS => {
			'Literal' => 117,
			'HashDereferenced' => 92,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'ArrayReference' => 100,
			'ListElement' => 143,
			'WordScoped' => 121,
			'ListElements' => 325,
			'Operator' => 85,
			'Variable' => 139
		}
	},
	{#State 291
		ACTIONS => {
			")" => 326
		}
	},
	{#State 292
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			"]" => 327,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP16_LOGICAL_OR' => 186,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196
		}
	},
	{#State 293
		ACTIONS => {
			'OP18_TERNARY' => 182,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP11_COMPARE_LT_GT' => 184,
			"}" => 328,
			'OP23_LOGICAL_AND' => 191,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			'OP16_LOGICAL_OR' => 186,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187
		}
	},
	{#State 294
		ACTIONS => {
			"}" => 329,
			'LEFT_PAREN' => -202
		}
	},
	{#State 295
		DEFAULT => -118
	},
	{#State 296
		DEFAULT => -117
	},
	{#State 297
		ACTIONS => {
			";" => 330
		}
	},
	{#State 298
		ACTIONS => {
			'VARIABLE_SYMBOL' => 106
		},
		GOTOS => {
			'Variable' => 331
		}
	},
	{#State 299
		DEFAULT => -173
	},
	{#State 300
		DEFAULT => -174
	},
	{#State 301
		ACTIONS => {
			'KEYS_OR_VALUES' => 145,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			")" => -125,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP01_QW' => 144,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			"my" => 73,
			'OP05_MATH_NEG' => 83,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'SubExpression' => 149,
			'TypeInner' => 146,
			'OPTIONAL-37' => 333,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'Variable' => 139,
			'ListElements' => 332,
			'Operator' => 85,
			'WordScoped' => 121,
			'ListElement' => 143,
			'ArrayReference' => 100
		}
	},
	{#State 302
		ACTIONS => {
			'OP21_LIST_COMMA' => 334
		}
	},
	{#State 303
		DEFAULT => -127
	},
	{#State 304
		DEFAULT => -206
	},
	{#State 305
		ACTIONS => {
			")" => 336,
			'OP21_LIST_COMMA' => 335
		},
		GOTOS => {
			'PAREN-18' => 337
		}
	},
	{#State 306
		DEFAULT => -46
	},
	{#State 307
		ACTIONS => {
			"%{" => 103,
			'WORD' => 312
		},
		GOTOS => {
			'HashEntryTyped' => 338,
			'HashDereferenced' => 311
		}
	},
	{#State 308
		ACTIONS => {
			"our" => 339,
			'LITERAL_NUMBER' => 340
		},
		GOTOS => {
			'MethodOrSubroutine' => 342,
			'Subroutine' => 343,
			'Method' => 341
		}
	},
	{#State 309
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 344
		}
	},
	{#State 310
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 345
		}
	},
	{#State 311
		DEFAULT => -195
	},
	{#State 312
		ACTIONS => {
			'OP20_HASH_FATARROW' => 346
		}
	},
	{#State 313
		ACTIONS => {
			";" => 347
		}
	},
	{#State 314
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'KEYS_OR_VALUES' => 145,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP01_QW' => 144,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			"my" => 73,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'TypeInner' => 146,
			'SubExpression' => 149,
			'Variable' => 139,
			'ArrayReference' => 100,
			'ListElement' => 143,
			'WordScoped' => 121,
			'ListElements' => 348,
			'Operator' => 85
		}
	},
	{#State 315
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			'OP18_TERNARY' => 182,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			".." => 349,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP14_BITWISE_OR_XOR' => 195
		}
	},
	{#State 316
		DEFAULT => -161
	},
	{#State 317
		DEFAULT => -175
	},
	{#State 318
		DEFAULT => -178
	},
	{#State 319
		DEFAULT => -181
	},
	{#State 320
		DEFAULT => -196
	},
	{#State 321
		ACTIONS => {
			'OP21_LIST_COMMA' => -192,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP15_LOGICAL_AND' => 193,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			"}" => -192,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => 191,
			'OP18_TERNARY' => 182,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 322
		ACTIONS => {
			'OP01_PRINT' => -154,
			'OP01_NAMED_VOID' => -154,
			'OP19_LOOP_CONTROL' => -154,
			'OP01_NAMED' => -154,
			'LEFT_PAREN' => -154,
			'VARIABLE_SYMBOL' => -154,
			"foreach my" => -154,
			"if (" => -154,
			'OP22_LOGICAL_NOT' => -154,
			"%{" => -154,
			"elsif (" => 352,
			"for my integer" => -154,
			'LITERAL_NUMBER' => -154,
			"while (" => -154,
			'OP01_OPEN' => -154,
			'OP03_MATH_INC_DEC' => -154,
			'WORD_SCOPED' => -154,
			'LEFT_BRACKET' => -154,
			"\@{" => -154,
			'OP10_NAMED_UNARY_STRINGIFY' => -154,
			"else" => 350,
			'WORD' => -154,
			"my" => -154,
			'OP05_MATH_NEG' => -154,
			"undef" => -154,
			'' => -154,
			'OP10_NAMED_UNARY' => -154,
			'OP05_LOGICAL_NEG' => -154,
			'LEFT_BRACE' => -154,
			'OP01_CLOSE' => -154,
			"}" => -154,
			'LITERAL_STRING' => -154
		},
		GOTOS => {
			'PAREN-40' => 351,
			'OPTIONAL-43' => 353,
			'PAREN-42' => 354
		}
	},
	{#State 323
		DEFAULT => -163
	},
	{#State 324
		ACTIONS => {
			'LEFT_PAREN' => 105,
			"foreach my" => -143,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED_VOID' => 110,
			'OP01_PRINT' => 109,
			'OP01_NAMED' => 111,
			"\@{" => 87,
			'OP19_LOOP_CONTROL' => 112,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			"for my integer" => -143,
			"my" => 81,
			'WORD' => 80,
			"if (" => 104,
			'OP05_MATH_NEG' => 83,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			"while (" => -143,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			"}" => 356,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'OPTIONAL-39' => 82,
			'HashReference' => 102,
			'Operation' => 355,
			'ArrayDereferenced' => 79,
			'Operator' => 85,
			'OperatorVoid' => 107,
			'SubExpression' => 116,
			'Literal' => 117,
			'VariableDeclaration' => 93,
			'HashDereferenced' => 92,
			'PAREN-38' => 113,
			'VariableModification' => 88,
			'Statement' => 89,
			'Expression' => 114,
			'LoopLabel' => 90,
			'WordScoped' => 121,
			'Conditional' => 97,
			'ArrayReference' => 100,
			'Variable' => 118
		}
	},
	{#State 325
		ACTIONS => {
			")" => 357
		}
	},
	{#State 326
		DEFAULT => -84
	},
	{#State 327
		DEFAULT => -168
	},
	{#State 328
		DEFAULT => -169
	},
	{#State 329
		DEFAULT => -170
	},
	{#State 330
		DEFAULT => -120
	},
	{#State 331
		DEFAULT => -108
	},
	{#State 332
		DEFAULT => -124
	},
	{#State 333
		ACTIONS => {
			")" => 358
		}
	},
	{#State 334
		ACTIONS => {
			'LITERAL_STRING' => 359
		}
	},
	{#State 335
		ACTIONS => {
			"my" => 360
		}
	},
	{#State 336
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 361
		}
	},
	{#State 337
		DEFAULT => -48
	},
	{#State 338
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 362
		}
	},
	{#State 339
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 363
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 340
		ACTIONS => {
			";" => 364
		}
	},
	{#State 341
		DEFAULT => -80
	},
	{#State 342
		DEFAULT => -59
	},
	{#State 343
		DEFAULT => -81
	},
	{#State 344
		DEFAULT => -66
	},
	{#State 345
		ACTIONS => {
			")" => 365,
			'OP21_LIST_COMMA' => 367
		},
		GOTOS => {
			'PAREN-25' => 366
		}
	},
	{#State 346
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 368
		}
	},
	{#State 347
		DEFAULT => -172
	},
	{#State 348
		ACTIONS => {
			")" => 369
		}
	},
	{#State 349
		ACTIONS => {
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LEFT_BRACE' => 99,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"%{" => 103,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Variable' => 139,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 370,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102
		}
	},
	{#State 350
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 371
		}
	},
	{#State 351
		DEFAULT => -150
	},
	{#State 352
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			"%{" => 103,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_BRACKET' => 86
		},
		GOTOS => {
			'SubExpression' => 372,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'Expression' => 140,
			'Operator' => 85,
			'WordScoped' => 121,
			'ArrayReference' => 100,
			'Variable' => 139
		}
	},
	{#State 353
		DEFAULT => -155
	},
	{#State 354
		DEFAULT => -153
	},
	{#State 355
		DEFAULT => -162
	},
	{#State 356
		DEFAULT => -164
	},
	{#State 357
		DEFAULT => -86
	},
	{#State 358
		DEFAULT => -128
	},
	{#State 359
		ACTIONS => {
			'OP21_LIST_COMMA' => 373
		}
	},
	{#State 360
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 374
		}
	},
	{#State 361
		ACTIONS => {
			"\@_;" => 375
		}
	},
	{#State 362
		ACTIONS => {
			")" => 378,
			'OP21_LIST_COMMA' => 377
		},
		GOTOS => {
			'PAREN-27' => 376
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 364
		DEFAULT => -61
	},
	{#State 365
		ACTIONS => {
			";" => 380
		}
	},
	{#State 366
		DEFAULT => -63
	},
	{#State 367
		ACTIONS => {
			'WORD' => 312,
			"%{" => 103
		},
		GOTOS => {
			'HashEntryTyped' => 381,
			'HashDereferenced' => 311
		}
	},
	{#State 368
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 91,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 138,
			"\@{" => 87,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'WORD' => 23,
			'OP05_MATH_NEG' => 83,
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 100,
			'Operator' => 85,
			'WordScoped' => 121,
			'Expression' => 140,
			'ArrayDereferenced' => 79,
			'HashReference' => 102,
			'HashDereferenced' => 92,
			'Literal' => 117,
			'SubExpression' => 382
		}
	},
	{#State 369
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 370
		ACTIONS => {
			'OP18_TERNARY' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			")" => 384,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => 191,
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP17_LIST_RANGE' => 196,
			'OP13_BITWISE_AND' => 197,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188
		}
	},
	{#State 371
		DEFAULT => -152
	},
	{#State 372
		ACTIONS => {
			'OP15_LOGICAL_AND' => 193,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP18_TERNARY' => 182,
			")" => 385,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP11_COMPARE_LT_GT' => 184,
			'OP23_LOGICAL_AND' => 191
		}
	},
	{#State 373
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 106,
			'LEFT_PAREN' => 105,
			"\@{" => 87,
			'OP01_NAMED' => 138,
			'LEFT_BRACKET' => 86,
			"%{" => 103,
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			'OP05_MATH_NEG' => 83,
			'WORD' => 23,
			'OP01_CLOSE' => 95,
			'OP01_OPEN' => 119,
			'LEFT_BRACE' => 99,
			'LITERAL_NUMBER' => 120,
			'OP10_NAMED_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 98,
			'LITERAL_STRING' => 91,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 115
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Operator' => 85,
			'Variable' => 139,
			'Literal' => 117,
			'HashDereferenced' => 92,
			'SubExpression' => 386,
			'Expression' => 140,
			'HashReference' => 102,
			'ArrayDereferenced' => 79
		}
	},
	{#State 374
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 375
		DEFAULT => -50
	},
	{#State 376
		DEFAULT => -68
	},
	{#State 377
		ACTIONS => {
			'WORD' => 312,
			"%{" => 103
		},
		GOTOS => {
			'HashDereferenced' => 311,
			'HashEntryTyped' => 388
		}
	},
	{#State 378
		ACTIONS => {
			";" => 389
		}
	},
	{#State 379
		ACTIONS => {
			"= sub {" => 390
		}
	},
	{#State 380
		DEFAULT => -65
	},
	{#State 381
		DEFAULT => -62
	},
	{#State 382
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 195,
			'OP15_LOGICAL_AND' => 193,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_STRING_CAT' => 192,
			'OP08_MATH_ADD_SUB' => 185,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP21_LIST_COMMA' => -194,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 196,
			")" => -194,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 184
		}
	},
	{#State 383
		DEFAULT => -160
	},
	{#State 384
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 385
		ACTIONS => {
			'LEFT_BRACE' => 289
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 386
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 185,
			'OP08_STRING_CAT' => 192,
			'OP24_LOGICAL_OR_XOR' => -87,
			".." => -87,
			'OP15_LOGICAL_AND' => 193,
			'OP14_BITWISE_OR_XOR' => 195,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 189,
			'OP17_LIST_RANGE' => 196,
			";" => -87,
			'OP13_BITWISE_AND' => 197,
			'OP21_LIST_COMMA' => -87,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 190,
			")" => -87,
			'OP18_TERNARY' => 182,
			'OP23_LOGICAL_AND' => -87,
			'OP11_COMPARE_LT_GT' => 184,
			"}" => -87,
			"]" => -87
		}
	},
	{#State 387
		DEFAULT => -47
	},
	{#State 388
		DEFAULT => -67
	},
	{#State 389
		DEFAULT => -70
	},
	{#State 390
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'VARIABLE_SYMBOL' => -72,
			"foreach my" => -72,
			'LEFT_PAREN' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP01_NAMED' => -72,
			"\@{" => -72,
			'OP01_PRINT' => -72,
			'OP01_NAMED_VOID' => -72,
			'LEFT_BRACKET' => -72,
			"for my integer" => -72,
			"%{" => -72,
			'OP22_LOGICAL_NOT' => -72,
			"undef" => -72,
			'OP05_MATH_NEG' => -72,
			"if (" => -72,
			'WORD' => -72,
			"my" => -72,
			'OP01_CLOSE' => -72,
			"( my" => 394,
			'OP01_OPEN' => -72,
			"while (" => -72,
			'LEFT_BRACE' => -72,
			'LITERAL_NUMBER' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP10_NAMED_UNARY' => -72,
			'LITERAL_STRING' => -72,
			'WORD_SCOPED' => -72,
			'OP03_MATH_INC_DEC' => -72
		},
		GOTOS => {
			'MethodArguments' => 395,
			'OPTIONAL-29' => 393
		}
	},
	{#State 391
		DEFAULT => -159
	},
	{#State 392
		DEFAULT => -149
	},
	{#State 393
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 101,
			"undef" => 78,
			"for my integer" => -143,
			"%{" => 103,
			"my" => 81,
			'WORD' => 80,
			'OP05_MATH_NEG' => 83,
			"if (" => 104,
			'VARIABLE_SYMBOL' => 106,
			"foreach my" => -143,
			'LEFT_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED' => 111,
			'OP19_LOOP_CONTROL' => 112,
			"\@{" => 87,
			'OP01_PRINT' => 109,
			'OP01_NAMED_VOID' => 110,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 120,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			"while (" => -143,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'Literal' => 117,
			'HashDereferenced' => 92,
			'VariableDeclaration' => 93,
			'SubExpression' => 116,
			'Expression' => 114,
			'LoopLabel' => 90,
			'PAREN-38' => 113,
			'Statement' => 89,
			'VariableModification' => 88,
			'ArrayReference' => 100,
			'WordScoped' => 121,
			'Conditional' => 97,
			'PLUS-30' => 396,
			'Variable' => 118,
			'OPTIONAL-39' => 82,
			'HashReference' => 102,
			'ArrayDereferenced' => 79,
			'Operation' => 397,
			'OperatorVoid' => 107,
			'Operator' => 85
		}
	},
	{#State 394
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 398
		}
	},
	{#State 395
		DEFAULT => -71
	},
	{#State 396
		ACTIONS => {
			"undef" => 78,
			'OP22_LOGICAL_NOT' => 101,
			"%{" => 103,
			"for my integer" => -143,
			"my" => 81,
			'WORD' => 80,
			"if (" => 104,
			'OP05_MATH_NEG' => 83,
			'LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 106,
			"foreach my" => -143,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LEFT_BRACKET' => 86,
			'OP01_NAMED_VOID' => 110,
			'OP01_PRINT' => 109,
			'OP01_NAMED' => 111,
			'OP19_LOOP_CONTROL' => 112,
			"\@{" => 87,
			'LITERAL_STRING' => 91,
			'OP03_MATH_INC_DEC' => 115,
			"}" => 399,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 119,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 98,
			'OP10_NAMED_UNARY' => 96,
			'LITERAL_NUMBER' => 120,
			'LEFT_BRACE' => 99,
			"while (" => -143
		},
		GOTOS => {
			'PAREN-38' => 113,
			'VariableModification' => 88,
			'Statement' => 89,
			'Expression' => 114,
			'LoopLabel' => 90,
			'SubExpression' => 116,
			'Literal' => 117,
			'VariableDeclaration' => 93,
			'HashDereferenced' => 92,
			'Variable' => 118,
			'WordScoped' => 121,
			'Conditional' => 97,
			'ArrayReference' => 100,
			'HashReference' => 102,
			'Operation' => 400,
			'ArrayDereferenced' => 79,
			'OPTIONAL-39' => 82,
			'OperatorVoid' => 107,
			'Operator' => 85
		}
	},
	{#State 397
		DEFAULT => -74
	},
	{#State 398
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 401
		}
	},
	{#State 399
		ACTIONS => {
			";" => 402
		}
	},
	{#State 400
		DEFAULT => -73
	},
	{#State 401
		ACTIONS => {
			'OP21_LIST_COMMA' => 405,
			")" => 403
		},
		GOTOS => {
			'PAREN-31' => 404
		}
	},
	{#State 402
		DEFAULT => -75
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 404
		DEFAULT => -77
	},
	{#State 405
		ACTIONS => {
			"my" => 407
		}
	},
	{#State 406
		ACTIONS => {
			"\@_;" => 408
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 409
		}
	},
	{#State 408
		DEFAULT => -79
	},
	{#State 409
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 410
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5725 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5746 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5757 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5768 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5782 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5899 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6002 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6038 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6049 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6255 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6262 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6276 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6287 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6677 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6699 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6710 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6789 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6949 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6960 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6971 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6982 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7025 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7058 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_155
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_159
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_160
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_161
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_164
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_167
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_180
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_181
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_187
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_188
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_189
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_192
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_194
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_199
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_200
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_201
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7586 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7608 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_206
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7619 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7630 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7641 lib/RPerl/Grammar.pm
	]
],
#line 7644 lib/RPerl/Grammar.pm
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


#line 7901 lib/RPerl/Grammar.pm



1;
