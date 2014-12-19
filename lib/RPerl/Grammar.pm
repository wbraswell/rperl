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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\$TYPED_|package|\=\ sub\ \{|while\ \(|elsif\ \(|undef|if\ \(|\(\ my|else|qw\(|use|our|\@_\;|\%\{|my|\.\.|\@\{|\;|\}|\]|\))}gc and return ($1, $1);

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
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Expression_125' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'WordScoped', 'LEFT_PAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LEFT_PAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'LEFT_BRACE', '}' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'LEFT_PAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_138' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_139' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'OPTIONAL-39', 'Loop' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'PAREN-40' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'PAREN-42' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Conditional_154' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-41', 'OPTIONAL-43' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_158' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'SubExpression', '..', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_159' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LEFT_PAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_160' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'CodeBlock_163' => 'CodeBlock', [ 'LEFT_BRACE', 'PLUS-44', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'Variable_166' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-45' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_170' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_171' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_172' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_173' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'PLUS-48', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'WORD' ], 0 ],
  [ 'ListElements_179' => 'ListElements', [ 'ListElement', 'STAR-47' ], 0 ],
  [ 'ListElements_180' => 'ListElements', [ 'OP01_QW', 'LEFT_PAREN', 'PLUS-48', ')' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayReference_186' => 'ArrayReference', [ 'LEFT_BRACKET', 'OPTIONAL-49', ']' ], 0 ],
  [ 'ArrayDereferenced_187' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_188' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_191' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_192' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_193' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_194' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_198' => 'HashReference', [ 'LEFT_BRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashDereferenced_199' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_200' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_201' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_202' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_203' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_204' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_205' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Literal_206' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_207' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  'Expression_125' => 125,
  'Expression_126' => 126,
  'Expression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpressionOrStdin_138' => 138,
  'SubExpressionOrStdin_139' => 139,
  '_PAREN' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  '_PAREN' => 148,
  '_STAR_LIST' => 149,
  '_STAR_LIST' => 150,
  '_PAREN' => 151,
  '_OPTIONAL' => 152,
  '_OPTIONAL' => 153,
  'Conditional_154' => 154,
  'Loop_155' => 155,
  'Loop_156' => 156,
  'Loop_157' => 157,
  'LoopFor_158' => 158,
  'LoopForEach_159' => 159,
  'LoopWhile_160' => 160,
  '_PLUS_LIST' => 161,
  '_PLUS_LIST' => 162,
  'CodeBlock_163' => 163,
  '_STAR_LIST' => 164,
  '_STAR_LIST' => 165,
  'Variable_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableRetrieval_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableDeclaration_170' => 170,
  'VariableDeclaration_171' => 171,
  'VariableModification_172' => 172,
  'VariableModification_173' => 173,
  '_PAREN' => 174,
  '_STAR_LIST' => 175,
  '_STAR_LIST' => 176,
  '_PLUS_LIST' => 177,
  '_PLUS_LIST' => 178,
  'ListElements_179' => 179,
  'ListElements_180' => 180,
  'ListElement_181' => 181,
  'ListElement_182' => 182,
  'ListElement_183' => 183,
  '_OPTIONAL' => 184,
  '_OPTIONAL' => 185,
  'ArrayReference_186' => 186,
  'ArrayDereferenced_187' => 187,
  'ArrayDereferenced_188' => 188,
  '_OPTIONAL' => 189,
  '_OPTIONAL' => 190,
  'HashEntry_191' => 191,
  'HashEntry_192' => 192,
  'HashEntryTyped_193' => 193,
  'HashEntryTyped_194' => 194,
  '_PAREN' => 195,
  '_STAR_LIST' => 196,
  '_STAR_LIST' => 197,
  'HashReference_198' => 198,
  'HashDereferenced_199' => 199,
  'HashDereferenced_200' => 200,
  'WordScoped_201' => 201,
  'WordScoped_202' => 202,
  'LoopLabel_203' => 203,
  'Type_204' => 204,
  'TypeInner_205' => 205,
  'Literal_206' => 206,
  'Literal_207' => 207,
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
			'SHEBANG' => 7,
			"## no critic qw(" => 4,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 6,
			'CompileUnit' => 5,
			'OPTIONAL-9' => 9,
			'PAREN-1' => 8,
			'Program' => 3,
			'ModuleHeader' => 2,
			'PLUS-2' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 4,
			'' => -5
		},
		GOTOS => {
			'Critic' => 6,
			'OPTIONAL-9' => 9,
			'PAREN-1' => 10,
			'ModuleHeader' => 2
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"use parent qw(" => 12
		},
		GOTOS => {
			'Module' => 15,
			'Package' => 14,
			'Class' => 11,
			'STAR-10' => 13
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'WORD' => 17
		},
		GOTOS => {
			'PLUS-14' => 16
		}
	},
	{#State 5
		ACTIONS => {
			'' => 18
		}
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-3' => 20,
			'Critic' => 19
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
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -23
	},
	{#State 12
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 13
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 4,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 25
		}
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 17
		DEFAULT => -35
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -202
	},
	{#State 23
		ACTIONS => {
			")" => 32
		}
	},
	{#State 24
		DEFAULT => -201
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		ACTIONS => {
			"use" => 35,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 34,
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
			"use warnings;" => 36
		}
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			";" => 38
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
			"use constant" => 41,
			"our" => 43
		},
		GOTOS => {
			'PLUS-13' => 44,
			'Constant' => 42,
			'Subroutine' => 40
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 36
		ACTIONS => {
			"use RPerl;" => 46
		}
	},
	{#State 37
		ACTIONS => {
			"if (" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP01_OPEN' => -11,
			'WORD_SCOPED' => -11,
			"use" => -11,
			'OP10_NAMED_UNARY' => -11,
			'LITERAL_NUMBER' => -11,
			"for my integer" => -11,
			"my" => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			"## no critic qw(" => 4,
			"undef" => -11,
			"\@{" => -11,
			'LEFT_BRACKET' => -11,
			"while (" => -11,
			'WORD' => -11,
			"use constant" => -11,
			'LITERAL_STRING' => -11,
			'OP05_MATH_NEG' => -11,
			'LEFT_PAREN' => -11,
			"our" => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LEFT_BRACE' => -11,
			"foreach my" => -11,
			'OP01_PRINT' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP05_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'Critic' => 47,
			'STAR-5' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		DEFAULT => -31
	},
	{#State 41
		ACTIONS => {
			'WORD' => 51
		}
	},
	{#State 42
		DEFAULT => -28
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL_NUMBER' => 54,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 45
		ACTIONS => {
			";" => 57,
			"qw(" => 56
		}
	},
	{#State 46
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => -13,
			"if (" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP01_OPEN' => -13,
			"%{" => -13,
			"my" => -13,
			'OP01_CLOSE' => -13,
			"for my integer" => -13,
			'LITERAL_NUMBER' => -13,
			'OP10_NAMED_UNARY' => -13,
			"use" => 35,
			'LEFT_PAREN' => -13,
			"our" => -13,
			'OP05_MATH_NEG' => -13,
			'LITERAL_STRING' => -13,
			"use constant" => -13,
			'LEFT_BRACKET' => -13,
			"while (" => -13,
			'WORD' => -13,
			"\@{" => -13,
			"undef" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LEFT_BRACE' => -13,
			"foreach my" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED' => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 60
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 62
		}
	},
	{#State 52
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 53
		DEFAULT => -204
	},
	{#State 54
		ACTIONS => {
			";" => 64
		}
	},
	{#State 55
		DEFAULT => -30
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
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LEFT_BRACE' => -15,
			"foreach my" => -15,
			'OP01_CLOSE' => -15,
			'VARIABLE_SYMBOL' => -15,
			"my" => -15,
			"for my integer" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_PRINT' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"%{" => -15,
			"undef" => -15,
			'WORD' => -15,
			"while (" => -15,
			'LEFT_BRACKET' => -15,
			"\@{" => -15,
			'LITERAL_STRING' => -15,
			'OP01_OPEN' => -15,
			'OP22_LOGICAL_NOT' => -15,
			"if (" => -15,
			"use constant" => 41,
			"our" => -15,
			'LEFT_PAREN' => -15,
			'OP05_MATH_NEG' => -15,
			'WORD_SCOPED' => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"## no critic qw(" => 4,
			"our %properties = (" => -54,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 72
		}
	},
	{#State 63
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 76,
			")" => 75
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			"if (" => 90,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			"our" => 43,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 110,
			"while (" => -142,
			'LEFT_BRACKET' => 111,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_PRINT' => 106,
			'OP01_CLOSE' => 81,
			"my" => 82,
			'VARIABLE_SYMBOL' => 102,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED_VOID' => 94,
			'LEFT_BRACE' => 100,
			"foreach my" => -142,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79
		},
		GOTOS => {
			'Literal' => 87,
			'PAREN-38' => 117,
			'WordScoped' => 115,
			'HashReference' => 116,
			'PLUS-8' => 118,
			'Expression' => 91,
			'Operation' => 119,
			'Subroutine' => 85,
			'HashDereferenced' => 113,
			'SubExpression' => 86,
			'OPTIONAL-39' => 104,
			'LoopLabel' => 83,
			'Statement' => 107,
			'Conditional' => 93,
			'Variable' => 92,
			'Operator' => 77,
			'OperatorVoid' => 97,
			'ArrayReference' => 80,
			'VariableDeclaration' => 99,
			'ArrayDereferenced' => 98,
			'VariableModification' => 101
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 35,
			"use constant" => -56
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
			'LITERAL_STRING' => 114,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Literal' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 125
		}
	},
	{#State 74
		ACTIONS => {
			"( my" => 127,
			'OP05_LOGICAL_NEG' => -43,
			"%{" => -43,
			'VARIABLE_SYMBOL' => -43,
			"my" => -43,
			'OP01_CLOSE' => -43,
			'OP01_PRINT' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"for my integer" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LITERAL_NUMBER' => -43,
			"foreach my" => -43,
			'LEFT_BRACE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED' => -43,
			'LEFT_PAREN' => -43,
			'WORD_SCOPED' => -43,
			'OP05_MATH_NEG' => -43,
			'LITERAL_STRING' => -43,
			"if (" => -43,
			'OP01_OPEN' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'LEFT_BRACKET' => -43,
			"while (" => -43,
			'WORD' => -43,
			"\@{" => -43,
			"undef" => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 126,
			'SubroutineArguments' => 128
		}
	},
	{#State 75
		ACTIONS => {
			";" => 129
		}
	},
	{#State 76
		DEFAULT => -37
	},
	{#State 77
		DEFAULT => -125
	},
	{#State 78
		DEFAULT => -207
	},
	{#State 79
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111
		},
		GOTOS => {
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 131,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 80
		DEFAULT => -132
	},
	{#State 81
		ACTIONS => {
			'FH_REF_SYMBOL' => 133
		}
	},
	{#State 82
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 134
		}
	},
	{#State 83
		ACTIONS => {
			'COLON' => 135
		}
	},
	{#State 84
		ACTIONS => {
			'LEFT_BRACE' => 138,
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'Variable' => 137,
			'HashReference' => 136
		}
	},
	{#State 85
		DEFAULT => -14
	},
	{#State 86
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149
		}
	},
	{#State 87
		DEFAULT => -130
	},
	{#State 88
		ACTIONS => {
			"my" => 155
		}
	},
	{#State 89
		ACTIONS => {
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'Variable' => 130,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 156,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Expression' => 132
		}
	},
	{#State 90
		ACTIONS => {
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'HashDereferenced' => 113,
			'SubExpression' => 157,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 91
		ACTIONS => {
			'OP23_LOGICAL_AND' => -128,
			'OP11_COMPARE_LT_GT' => -128,
			'OP18_TERNARY' => -128,
			'OP14_BITWISE_OR_XOR' => -128,
			'OP07_MATH_MULT_DIV_MOD' => -128,
			'OP17_LIST_RANGE' => -128,
			'OP04_MATH_POW' => -128,
			'OP09_BITWISE_SHIFT' => -128,
			'OP08_STRING_CAT' => -128,
			'OP15_LOGICAL_AND' => -128,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP13_BITWISE_AND' => -128,
			'OP16_LOGICAL_OR' => -128,
			'OP08_MATH_ADD_SUB' => -128,
			";" => 158,
			'OP06_REGEX_MATCH' => -128,
			'OP12_COMPARE_EQ_NEQ' => -128
		}
	},
	{#State 92
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -131,
			'OP18_TERNARY' => -131,
			'OP23_LOGICAL_AND' => -131,
			'OP03_MATH_INC_DEC' => 161,
			'OP11_COMPARE_LT_GT' => -131,
			'OP08_STRING_CAT' => -131,
			'OP09_BITWISE_SHIFT' => -131,
			'OP04_MATH_POW' => -131,
			'OP07_MATH_MULT_DIV_MOD' => -131,
			'OP17_LIST_RANGE' => -131,
			'OP02_METHOD_THINARROW' => 160,
			'OP13_BITWISE_AND' => -131,
			'OP24_LOGICAL_OR_XOR' => -131,
			'OP15_LOGICAL_AND' => -131,
			'OP19_VARIABLE_ASSIGN' => 159,
			'OP06_REGEX_MATCH' => -131,
			'OP12_COMPARE_EQ_NEQ' => -131,
			'OP19_VARIABLE_ASSIGN_BY' => 162,
			'OP08_MATH_ADD_SUB' => -131,
			'OP16_LOGICAL_OR' => -131
		}
	},
	{#State 93
		DEFAULT => -143
	},
	{#State 94
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			";" => -116,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			'OP01_QW' => 167,
			"undef" => 109
		},
		GOTOS => {
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'TypeInner' => 164,
			'HashReference' => 116,
			'ArrayReference' => 80,
			'ListElements' => 169,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'ListElement' => 166,
			'SubExpression' => 168,
			'HashDereferenced' => 113,
			'OPTIONAL-35' => 165,
			'Variable' => 130
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'Variable' => 170
		}
	},
	{#State 96
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120
		},
		GOTOS => {
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'HashDereferenced' => 113,
			'SubExpression' => 171,
			'Variable' => 130
		}
	},
	{#State 97
		DEFAULT => -145
	},
	{#State 98
		DEFAULT => -133
	},
	{#State 99
		DEFAULT => -146
	},
	{#State 100
		ACTIONS => {
			"}" => 172,
			'WORD' => 174,
			"%{" => 84
		},
		GOTOS => {
			'HashEntry' => 173,
			'HashDereferenced' => 175
		}
	},
	{#State 101
		DEFAULT => -147
	},
	{#State 102
		DEFAULT => -165,
		GOTOS => {
			'STAR-45' => 176
		}
	},
	{#State 103
		ACTIONS => {
			'WORD' => 177
		},
		GOTOS => {
			'LoopLabel' => 178
		}
	},
	{#State 104
		ACTIONS => {
			"while (" => 179,
			"foreach my" => 183,
			"for my integer" => 185
		},
		GOTOS => {
			'Loop' => 182,
			'LoopWhile' => 184,
			'LoopFor' => 181,
			'LoopForEach' => 180
		}
	},
	{#State 105
		ACTIONS => {
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 186,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 106
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -114,
			"%{" => -114,
			'OP01_CLOSE' => -114,
			"my" => -114,
			'VARIABLE_SYMBOL' => -114,
			'OP10_NAMED_UNARY_STRINGIFY' => -114,
			'OP10_NAMED_UNARY' => -114,
			'LITERAL_NUMBER' => -114,
			'LEFT_BRACE' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'OP01_NAMED' => -114,
			'LEFT_PAREN' => -114,
			'OP05_MATH_NEG' => -114,
			'WORD_SCOPED' => -114,
			'STDOUT_STDERR' => 188,
			'LITERAL_STRING' => -114,
			'OP01_OPEN' => -114,
			'OP22_LOGICAL_NOT' => -114,
			'KEYS_OR_VALUES' => -114,
			'WORD' => -114,
			'LEFT_BRACKET' => -114,
			"\@{" => -114,
			'FH_REF_SYMBOL_BRACES' => 190,
			"undef" => -114,
			'OP01_QW' => -114
		},
		GOTOS => {
			'PAREN-33' => 189,
			'OPTIONAL-34' => 187
		}
	},
	{#State 107
		DEFAULT => -83
	},
	{#State 108
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120
		},
		GOTOS => {
			'SubExpression' => 191,
			'HashDereferenced' => 113,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Variable' => 130,
			'Expression' => 132,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87
		}
	},
	{#State 109
		DEFAULT => -129
	},
	{#State 110
		ACTIONS => {
			'LEFT_PAREN' => -201,
			'COLON' => -203
		}
	},
	{#State 111
		ACTIONS => {
			"undef" => 109,
			'OP01_QW' => 167,
			"\@{" => 112,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			"]" => -185,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"my" => 73,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84
		},
		GOTOS => {
			'Variable' => 130,
			'SubExpression' => 168,
			'ListElement' => 166,
			'HashDereferenced' => 113,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'ListElements' => 192,
			'Operator' => 77,
			'OPTIONAL-49' => 193,
			'TypeInner' => 164,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'Expression' => 132
		}
	},
	{#State 112
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'ArrayReference' => 195,
			'Variable' => 194
		}
	},
	{#State 113
		DEFAULT => -135
	},
	{#State 114
		DEFAULT => -206
	},
	{#State 115
		ACTIONS => {
			'LEFT_PAREN' => 196
		}
	},
	{#State 116
		DEFAULT => -134
	},
	{#State 117
		DEFAULT => -141
	},
	{#State 118
		ACTIONS => {
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			"while (" => -142,
			'WORD' => 110,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'' => -18,
			'LEFT_PAREN' => 120,
			"if (" => 90,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'LEFT_BRACE' => 100,
			"foreach my" => -142,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED_VOID' => 94,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_PRINT' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			"my" => 82,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81
		},
		GOTOS => {
			'Statement' => 107,
			'LoopLabel' => 83,
			'OPTIONAL-39' => 104,
			'VariableModification' => 101,
			'VariableDeclaration' => 99,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'OperatorVoid' => 97,
			'Operator' => 77,
			'Conditional' => 93,
			'Variable' => 92,
			'Operation' => 197,
			'Expression' => 91,
			'PAREN-38' => 117,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'SubExpression' => 86,
			'HashDereferenced' => 113
		}
	},
	{#State 119
		DEFAULT => -17
	},
	{#State 120
		ACTIONS => {
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_NAMED' => 198,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_PRINT' => 199,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108
		},
		GOTOS => {
			'Variable' => 130,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 200,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Expression' => 132
		}
	},
	{#State 121
		ACTIONS => {
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'HashDereferenced' => 113,
			'SubExpression' => 201,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77
		}
	},
	{#State 122
		ACTIONS => {
			"use constant" => 41,
			"our %properties = (" => 203
		},
		GOTOS => {
			'Constant' => 204,
			'Properties' => 202
		}
	},
	{#State 123
		DEFAULT => -53
	},
	{#State 124
		ACTIONS => {
			";" => 205
		}
	},
	{#State 125
		ACTIONS => {
			"\$TYPED_" => 206
		}
	},
	{#State 126
		ACTIONS => {
			"\@{" => 112,
			'WORD' => 110,
			"while (" => -142,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			"if (" => 90,
			'LITERAL_STRING' => 114,
			'LEFT_BRACE' => 100,
			"foreach my" => -142,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP01_NAMED_VOID' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_PRINT' => 106,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"my" => 82
		},
		GOTOS => {
			'OPTIONAL-39' => 104,
			'Statement' => 107,
			'LoopLabel' => 83,
			'Conditional' => 93,
			'Variable' => 92,
			'VariableModification' => 101,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'VariableDeclaration' => 99,
			'Operator' => 77,
			'OperatorVoid' => 97,
			'PAREN-38' => 117,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Operation' => 208,
			'Expression' => 91,
			'SubExpression' => 86,
			'HashDereferenced' => 113,
			'PLUS-17' => 207
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 209
		}
	},
	{#State 128
		DEFAULT => -42
	},
	{#State 129
		DEFAULT => -40
	},
	{#State 130
		ACTIONS => {
			'OP18_TERNARY' => -131,
			'OP11_COMPARE_LT_GT' => -131,
			'OP23_LOGICAL_AND' => -131,
			'OP03_MATH_INC_DEC' => 161,
			"]" => -131,
			'OP14_BITWISE_OR_XOR' => -131,
			'OP17_LIST_RANGE' => -131,
			'OP07_MATH_MULT_DIV_MOD' => -131,
			'OP02_METHOD_THINARROW' => 160,
			'OP08_STRING_CAT' => -131,
			")" => -131,
			'OP04_MATH_POW' => -131,
			'OP09_BITWISE_SHIFT' => -131,
			"}" => -131,
			'OP24_LOGICAL_OR_XOR' => -131,
			'OP13_BITWISE_AND' => -131,
			'OP15_LOGICAL_AND' => -131,
			'OP16_LOGICAL_OR' => -131,
			'OP21_LIST_COMMA' => -131,
			".." => -131,
			'OP06_REGEX_MATCH' => -131,
			'OP12_COMPARE_EQ_NEQ' => -131,
			";" => -131,
			'OP08_MATH_ADD_SUB' => -131
		}
	},
	{#State 131
		ACTIONS => {
			'OP21_LIST_COMMA' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => -99,
			";" => -99,
			".." => -99,
			'OP06_REGEX_MATCH' => 152,
			"}" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			")" => -99,
			'OP08_STRING_CAT' => 141,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP18_TERNARY' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			"]" => -99
		}
	},
	{#State 132
		DEFAULT => -128
	},
	{#State 133
		DEFAULT => -88
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 210
		}
	},
	{#State 135
		DEFAULT => -140
	},
	{#State 136
		ACTIONS => {
			"}" => 211
		}
	},
	{#State 137
		ACTIONS => {
			"}" => 212
		}
	},
	{#State 138
		ACTIONS => {
			"%{" => 84,
			'WORD' => 174
		},
		GOTOS => {
			'HashEntry' => 173,
			'HashDereferenced' => 175
		}
	},
	{#State 139
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'HashDereferenced' => 113,
			'SubExpression' => 213,
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Variable' => 130,
			'Expression' => 132,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87
		}
	},
	{#State 140
		ACTIONS => {
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96
		},
		GOTOS => {
			'SubExpression' => 214,
			'HashDereferenced' => 113,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'Variable' => 130,
			'Expression' => 132,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87
		}
	},
	{#State 141
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"undef" => 109,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Expression' => 132,
			'Variable' => 130,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'SubExpression' => 215,
			'HashDereferenced' => 113
		}
	},
	{#State 142
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111
		},
		GOTOS => {
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 216,
			'Variable' => 130
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'Variable' => 217
		}
	},
	{#State 144
		ACTIONS => {
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'SubExpression' => 218,
			'HashDereferenced' => 113,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77
		}
	},
	{#State 145
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109
		},
		GOTOS => {
			'Variable' => 130,
			'SubExpression' => 219,
			'HashDereferenced' => 113,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Expression' => 132
		}
	},
	{#State 146
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 113,
			'SubExpression' => 220,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'HashDereferenced' => 113,
			'SubExpression' => 221,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77
		}
	},
	{#State 148
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 222,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 149
		ACTIONS => {
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81
		},
		GOTOS => {
			'Expression' => 132,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'HashDereferenced' => 113,
			'SubExpression' => 223,
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Variable' => 130
		}
	},
	{#State 150
		ACTIONS => {
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114
		},
		GOTOS => {
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Expression' => 132,
			'Variable' => 130,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'SubExpression' => 224,
			'HashDereferenced' => 113
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Expression' => 132,
			'Variable' => 130,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'SubExpression' => 225,
			'HashDereferenced' => 113
		}
	},
	{#State 152
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 226
		}
	},
	{#State 153
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'Expression' => 132,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'HashDereferenced' => 113,
			'SubExpression' => 227,
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Variable' => 130
		}
	},
	{#State 154
		ACTIONS => {
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114
		},
		GOTOS => {
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'HashDereferenced' => 113,
			'SubExpression' => 228,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 155
		ACTIONS => {
			"filehandle_ref" => 229
		}
	},
	{#State 156
		ACTIONS => {
			"}" => -109,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP13_BITWISE_AND' => 145,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => 153,
			";" => -109,
			".." => -109,
			'OP06_REGEX_MATCH' => 152,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => -109,
			'OP18_TERNARY' => 143,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -109,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			")" => -109,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141
		}
	},
	{#State 157
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => 230
		}
	},
	{#State 158
		DEFAULT => -82
	},
	{#State 159
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'STDIN' => 231,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			"undef" => 109,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'SubExpression' => 232,
			'HashDereferenced' => 113,
			'SubExpressionOrStdin' => 233,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116
		}
	},
	{#State 160
		ACTIONS => {
			'WORD' => 234
		}
	},
	{#State 161
		DEFAULT => -90
	},
	{#State 162
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 113,
			'SubExpression' => 235,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 163
		ACTIONS => {
			"%{" => 84
		},
		GOTOS => {
			'HashDereferenced' => 236
		}
	},
	{#State 164
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109
		},
		GOTOS => {
			'Variable' => 130,
			'HashDereferenced' => 113,
			'SubExpression' => 237,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Expression' => 132
		}
	},
	{#State 165
		ACTIONS => {
			";" => 238
		}
	},
	{#State 166
		DEFAULT => -176,
		GOTOS => {
			'STAR-47' => 239
		}
	},
	{#State 167
		ACTIONS => {
			'LEFT_PAREN' => 240
		}
	},
	{#State 168
		ACTIONS => {
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => 143,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -181,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			")" => -181,
			'OP08_STRING_CAT' => 141,
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP21_LIST_COMMA' => -181,
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 151,
			'OP06_REGEX_MATCH' => 152,
			";" => -181,
			'OP12_COMPARE_EQ_NEQ' => 153
		}
	},
	{#State 169
		DEFAULT => -115
	},
	{#State 170
		DEFAULT => -89
	},
	{#State 171
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -85,
			";" => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			".." => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP13_BITWISE_AND' => -85,
			"}" => -85,
			")" => -85,
			'OP04_MATH_POW' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			"]" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85
		}
	},
	{#State 172
		DEFAULT => -136
	},
	{#State 173
		DEFAULT => -197,
		GOTOS => {
			'STAR-52' => 241
		}
	},
	{#State 174
		ACTIONS => {
			'OP20_HASH_FATARROW' => 242
		}
	},
	{#State 175
		DEFAULT => -192
	},
	{#State 176
		ACTIONS => {
			'OP16_LOGICAL_OR' => -166,
			'OP21_LIST_COMMA' => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP12_COMPARE_EQ_NEQ' => -166,
			'OP06_REGEX_MATCH' => -166,
			";" => -166,
			".." => -166,
			'OP08_MATH_ADD_SUB' => -166,
			"}" => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP13_BITWISE_AND' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP17_LIST_RANGE' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'COLON' => -166,
			'OP02_ARRAY_THINARROW' => 244,
			'OP02_METHOD_THINARROW' => -166,
			'OP02_HASH_THINARROW' => 243,
			'OP08_STRING_CAT' => -166,
			")" => -166,
			'OP09_BITWISE_SHIFT' => -166,
			'OP04_MATH_POW' => -166,
			'OP18_TERNARY' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP03_MATH_INC_DEC' => -166,
			'OP23_LOGICAL_AND' => -166,
			"]" => -166,
			'OP14_BITWISE_OR_XOR' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 245
		}
	},
	{#State 177
		DEFAULT => -203
	},
	{#State 178
		ACTIONS => {
			";" => 246
		}
	},
	{#State 179
		ACTIONS => {
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114
		},
		GOTOS => {
			'Expression' => 132,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'HashDereferenced' => 113,
			'SubExpression' => 247,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'Variable' => 130
		}
	},
	{#State 180
		DEFAULT => -156
	},
	{#State 181
		DEFAULT => -155
	},
	{#State 182
		DEFAULT => -144
	},
	{#State 183
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 248
		}
	},
	{#State 184
		DEFAULT => -157
	},
	{#State 185
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 186
		ACTIONS => {
			"}" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP08_MATH_ADD_SUB' => 151,
			".." => -100,
			";" => -100,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			")" => -100,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141
		}
	},
	{#State 187
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109,
			'OP01_QW' => 167
		},
		GOTOS => {
			'Variable' => 130,
			'ListElement' => 166,
			'SubExpression' => 168,
			'HashDereferenced' => 113,
			'ListElements' => 250,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77,
			'TypeInner' => 164,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Expression' => 132
		}
	},
	{#State 188
		DEFAULT => -112
	},
	{#State 189
		DEFAULT => -113
	},
	{#State 190
		ACTIONS => {
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'WORD' => 24,
			'KEYS_OR_VALUES' => 163,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			"undef" => 109,
			'OP01_QW' => 167,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"my" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96
		},
		GOTOS => {
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'TypeInner' => 164,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'ListElements' => 251,
			'Operator' => 77,
			'ListElement' => 166,
			'SubExpression' => 168,
			'HashDereferenced' => 113,
			'Variable' => 130
		}
	},
	{#State 191
		ACTIONS => {
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			";" => -92,
			".." => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			"}" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP08_STRING_CAT' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 146,
			")" => -92,
			'OP18_TERNARY' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			"]" => -92,
			'OP14_BITWISE_OR_XOR' => -92
		}
	},
	{#State 192
		DEFAULT => -184
	},
	{#State 193
		ACTIONS => {
			"]" => 252
		}
	},
	{#State 194
		ACTIONS => {
			"}" => 253
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 254
		}
	},
	{#State 196
		ACTIONS => {
			"undef" => 109,
			'OP01_QW' => 167,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"my" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			")" => -122,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84
		},
		GOTOS => {
			'Variable' => 130,
			'OPTIONAL-36' => 255,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ListElements' => 256,
			'ArrayReference' => 80,
			'ListElement' => 166,
			'HashDereferenced' => 113,
			'SubExpression' => 168,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'TypeInner' => 164,
			'Expression' => 132
		}
	},
	{#State 197
		DEFAULT => -16
	},
	{#State 198
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			'KEYS_OR_VALUES' => 163,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'VARIABLE_SYMBOL' => 102,
			"my" => 73,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'HashDereferenced' => 113,
			'ListElement' => 258,
			'SubExpression' => 257,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'TypeInner' => 164
		}
	},
	{#State 199
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 259
		}
	},
	{#State 200
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			")" => 260,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP18_TERNARY' => 143,
			'OP14_BITWISE_OR_XOR' => 149
		}
	},
	{#State 201
		ACTIONS => {
			'OP18_TERNARY' => 143,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP08_STRING_CAT' => 141,
			")" => 261,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151
		}
	},
	{#State 202
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our" => -58,
			"our %properties_class = (" => 262
		},
		GOTOS => {
			'PropertiesClass' => 264,
			'OPTIONAL-23' => 263
		}
	},
	{#State 203
		ACTIONS => {
			"## no critic qw(" => 4,
			")" => 265
		},
		GOTOS => {
			'Critic' => 266
		}
	},
	{#State 204
		DEFAULT => -55
	},
	{#State 205
		DEFAULT => -41
	},
	{#State 206
		ACTIONS => {
			'WORD' => 267
		}
	},
	{#State 207
		ACTIONS => {
			"}" => 268,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 110,
			"while (" => -142,
			"if (" => 90,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED_VOID' => 94,
			"foreach my" => -142,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_PRINT' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			"my" => 82,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84
		},
		GOTOS => {
			'SubExpression' => 86,
			'HashDereferenced' => 113,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'PAREN-38' => 117,
			'Expression' => 91,
			'Operation' => 269,
			'Conditional' => 93,
			'Variable' => 92,
			'Operator' => 77,
			'OperatorVoid' => 97,
			'VariableDeclaration' => 99,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'VariableModification' => 101,
			'OPTIONAL-39' => 104,
			'LoopLabel' => 83,
			'Statement' => 107
		}
	},
	{#State 208
		DEFAULT => -45
	},
	{#State 209
		ACTIONS => {
			'VARIABLE_SYMBOL' => 270
		}
	},
	{#State 210
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 272,
			";" => 271
		}
	},
	{#State 211
		DEFAULT => -200
	},
	{#State 212
		DEFAULT => -199
	},
	{#State 213
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => -107,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => -107,
			'OP08_STRING_CAT' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP13_BITWISE_AND' => 145,
			"}" => -107,
			'OP08_MATH_ADD_SUB' => 151,
			".." => -107,
			";" => -107,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP21_LIST_COMMA' => -107,
			'OP16_LOGICAL_OR' => 150
		}
	},
	{#State 214
		ACTIONS => {
			"}" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			";" => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			".." => -95,
			'OP06_REGEX_MATCH' => 152,
			'OP23_LOGICAL_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP18_TERNARY' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => -95,
			")" => -95,
			'OP08_STRING_CAT' => -95
		}
	},
	{#State 215
		ACTIONS => {
			'OP08_STRING_CAT' => -97,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => -97,
			")" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -97,
			"]" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			";" => -97,
			'OP12_COMPARE_EQ_NEQ' => -97,
			".." => -97,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP16_LOGICAL_OR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			"}" => -97
		}
	},
	{#State 216
		ACTIONS => {
			'OP18_TERNARY' => 143,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => -110,
			"]" => -110,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP08_STRING_CAT' => 141,
			")" => -110,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			"}" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => -110,
			'OP06_REGEX_MATCH' => 152,
			";" => -110,
			".." => -110,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151
		}
	},
	{#State 217
		ACTIONS => {
			'COLON' => 273
		}
	},
	{#State 218
		ACTIONS => {
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_MATH_ADD_SUB' => 151,
			".." => -105,
			";" => -105,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			"}" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -105,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => -105,
			'OP08_STRING_CAT' => 141,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => -105,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -105
		}
	},
	{#State 219
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -103,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			")" => -103,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP12_COMPARE_EQ_NEQ' => 153,
			";" => -103,
			".." => -103,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			"}" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103
		}
	},
	{#State 220
		ACTIONS => {
			'OP18_TERNARY' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP08_STRING_CAT' => -91,
			")" => -91,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP06_REGEX_MATCH' => -91,
			";" => -91,
			".." => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP08_MATH_ADD_SUB' => -91
		}
	},
	{#State 221
		ACTIONS => {
			"]" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 141,
			")" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP13_BITWISE_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			"}" => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			";" => -98,
			".." => -98,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98
		}
	},
	{#State 222
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -101,
			"]" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => -101,
			'OP08_STRING_CAT' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			"}" => -101,
			'OP08_MATH_ADD_SUB' => 151,
			'OP06_REGEX_MATCH' => 152,
			";" => -101,
			".." => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 223
		ACTIONS => {
			";" => -104,
			'OP12_COMPARE_EQ_NEQ' => 153,
			".." => -104,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP16_LOGICAL_OR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP15_LOGICAL_AND' => -104,
			"}" => -104,
			'OP08_STRING_CAT' => 141,
			")" => -104,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			'OP17_LIST_RANGE' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			"]" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP18_TERNARY' => -104,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 224
		ACTIONS => {
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => -106,
			'OP21_LIST_COMMA' => -106,
			";" => -106,
			'OP12_COMPARE_EQ_NEQ' => 153,
			".." => -106,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP18_TERNARY' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -106,
			'OP08_STRING_CAT' => 141,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => -106
		}
	},
	{#State 225
		ACTIONS => {
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			"]" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => -96,
			'OP08_STRING_CAT' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP04_MATH_POW' => 146,
			")" => -96,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP21_LIST_COMMA' => -96,
			";" => -96,
			'OP06_REGEX_MATCH' => 152,
			".." => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP08_MATH_ADD_SUB' => -96
		}
	},
	{#State 226
		DEFAULT => -94
	},
	{#State 227
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			")" => -102,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141,
			"}" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP08_MATH_ADD_SUB' => 151,
			";" => -102,
			'OP06_REGEX_MATCH' => 152,
			".." => -102,
			'OP12_COMPARE_EQ_NEQ' => undef
		}
	},
	{#State 228
		ACTIONS => {
			"}" => -111,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => -111,
			";" => -111,
			".." => -111,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			")" => -111
		}
	},
	{#State 229
		ACTIONS => {
			'FH_REF_SYMBOL' => 274
		}
	},
	{#State 230
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 276
		}
	},
	{#State 231
		DEFAULT => -139
	},
	{#State 232
		ACTIONS => {
			";" => -138,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148
		}
	},
	{#State 233
		ACTIONS => {
			";" => 277
		}
	},
	{#State 234
		ACTIONS => {
			'LEFT_PAREN' => 278
		}
	},
	{#State 235
		ACTIONS => {
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP08_MATH_ADD_SUB' => 151,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			";" => 279,
			'OP16_LOGICAL_OR' => 150,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => 143,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139
		}
	},
	{#State 236
		DEFAULT => -183
	},
	{#State 237
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => 153,
			";" => -182,
			'OP06_REGEX_MATCH' => 152,
			'OP21_LIST_COMMA' => -182,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			")" => -182,
			'OP08_STRING_CAT' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -182,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => 143
		}
	},
	{#State 238
		DEFAULT => -119
	},
	{#State 239
		ACTIONS => {
			'OP21_LIST_COMMA' => 281,
			"]" => -179,
			";" => -179,
			")" => -179
		},
		GOTOS => {
			'PAREN-46' => 280
		}
	},
	{#State 240
		ACTIONS => {
			'WORD' => 283
		},
		GOTOS => {
			'PLUS-48' => 282
		}
	},
	{#State 241
		ACTIONS => {
			'OP21_LIST_COMMA' => 286,
			"}" => 285
		},
		GOTOS => {
			'PAREN-51' => 284
		}
	},
	{#State 242
		ACTIONS => {
			'OP01_NAMED' => -190,
			'OP03_MATH_INC_DEC' => -190,
			'LEFT_BRACE' => -190,
			'LITERAL_NUMBER' => -190,
			'OP10_NAMED_UNARY' => -190,
			'OP10_NAMED_UNARY_STRINGIFY' => -190,
			'OP01_CLOSE' => -190,
			"my" => 73,
			'VARIABLE_SYMBOL' => -190,
			'OP05_LOGICAL_NEG' => -190,
			"%{" => -190,
			"undef" => -190,
			"\@{" => -190,
			'WORD' => -190,
			'LEFT_BRACKET' => -190,
			'OP22_LOGICAL_NOT' => -190,
			'OP01_OPEN' => -190,
			'LITERAL_STRING' => -190,
			'OP05_MATH_NEG' => -190,
			'WORD_SCOPED' => -190,
			'LEFT_PAREN' => -190
		},
		GOTOS => {
			'OPTIONAL-50' => 288,
			'TypeInner' => 287
		}
	},
	{#State 243
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LEFT_BRACKET' => 111,
			'WORD' => 290,
			"\@{" => 112,
			"undef" => 109
		},
		GOTOS => {
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'SubExpression' => 289,
			'HashDereferenced' => 113,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 244
		ACTIONS => {
			"undef" => 109,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84
		},
		GOTOS => {
			'SubExpression' => 291,
			'HashDereferenced' => 113,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Variable' => 130,
			'Expression' => 132,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87
		}
	},
	{#State 245
		DEFAULT => -164
	},
	{#State 246
		DEFAULT => -120
	},
	{#State 247
		ACTIONS => {
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => 292,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151
		}
	},
	{#State 248
		ACTIONS => {
			'VARIABLE_SYMBOL' => 293
		}
	},
	{#State 249
		ACTIONS => {
			'LEFT_PAREN' => 294
		}
	},
	{#State 250
		ACTIONS => {
			";" => 295
		}
	},
	{#State 251
		ACTIONS => {
			";" => 296
		}
	},
	{#State 252
		DEFAULT => -186
	},
	{#State 253
		DEFAULT => -187
	},
	{#State 254
		DEFAULT => -188
	},
	{#State 255
		ACTIONS => {
			")" => 297
		}
	},
	{#State 256
		DEFAULT => -121
	},
	{#State 257
		ACTIONS => {
			'OP23_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP04_MATH_POW' => -85,
			")" => -85,
			'OP08_STRING_CAT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -181,
			'OP16_LOGICAL_OR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85
		}
	},
	{#State 258
		ACTIONS => {
			'OP21_LIST_COMMA' => 298
		}
	},
	{#State 259
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			'OP01_QW' => 167,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 115,
			'TypeInner' => 164,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'ListElement' => 166,
			'HashDereferenced' => 113,
			'SubExpression' => 168,
			'ArrayDereferenced' => 98,
			'ListElements' => 299,
			'ArrayReference' => 80,
			'Operator' => 77
		}
	},
	{#State 260
		DEFAULT => -137
	},
	{#State 261
		DEFAULT => -93
	},
	{#State 262
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 300
		}
	},
	{#State 263
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 301
		}
	},
	{#State 264
		DEFAULT => -57
	},
	{#State 265
		ACTIONS => {
			";" => 302
		}
	},
	{#State 266
		ACTIONS => {
			'WORD' => 303,
			"%{" => 84
		},
		GOTOS => {
			'HashEntryTyped' => 305,
			'HashDereferenced' => 304
		}
	},
	{#State 267
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 306
		}
	},
	{#State 268
		ACTIONS => {
			";" => 307
		}
	},
	{#State 269
		DEFAULT => -44
	},
	{#State 270
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 308
		}
	},
	{#State 271
		DEFAULT => -170
	},
	{#State 272
		ACTIONS => {
			"undef" => 109,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'STDIN' => 231
		},
		GOTOS => {
			'SubExpression' => 232,
			'HashDereferenced' => 113,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'Variable' => 130,
			'SubExpressionOrStdin' => 309,
			'Expression' => 132,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87
		}
	},
	{#State 273
		ACTIONS => {
			'VARIABLE_SYMBOL' => 102
		},
		GOTOS => {
			'Variable' => 310
		}
	},
	{#State 274
		ACTIONS => {
			'OP21_LIST_COMMA' => 311
		}
	},
	{#State 275
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED_VOID' => 94,
			"foreach my" => -142,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_PRINT' => 106,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			'VARIABLE_SYMBOL' => 102,
			"my" => 82,
			'OP01_CLOSE' => 81,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 110,
			"while (" => -142,
			"if (" => 90,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120
		},
		GOTOS => {
			'Statement' => 107,
			'LoopLabel' => 83,
			'OPTIONAL-39' => 104,
			'PLUS-44' => 312,
			'VariableModification' => 101,
			'Operator' => 77,
			'OperatorVoid' => 97,
			'VariableDeclaration' => 99,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Conditional' => 93,
			'Variable' => 92,
			'Expression' => 91,
			'Operation' => 313,
			'PAREN-38' => 117,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'SubExpression' => 86,
			'HashDereferenced' => 113
		}
	},
	{#State 276
		DEFAULT => -150,
		GOTOS => {
			'STAR-41' => 314
		}
	},
	{#State 277
		DEFAULT => -172
	},
	{#State 278
		ACTIONS => {
			"undef" => 109,
			'OP01_QW' => 167,
			"\@{" => 112,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			")" => -124
		},
		GOTOS => {
			'Expression' => 132,
			'OPTIONAL-37' => 316,
			'Literal' => 87,
			'WordScoped' => 115,
			'HashReference' => 116,
			'TypeInner' => 164,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ListElements' => 315,
			'ArrayReference' => 80,
			'HashDereferenced' => 113,
			'SubExpression' => 168,
			'ListElement' => 166,
			'Variable' => 130
		}
	},
	{#State 279
		DEFAULT => -173
	},
	{#State 280
		DEFAULT => -175
	},
	{#State 281
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'KEYS_OR_VALUES' => 163,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'Literal' => 87,
			'TypeInner' => 164,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Expression' => 132,
			'Variable' => 130,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Operator' => 77,
			'ListElement' => 317,
			'HashDereferenced' => 113,
			'SubExpression' => 168
		}
	},
	{#State 282
		ACTIONS => {
			")" => 319,
			'WORD' => 318
		}
	},
	{#State 283
		DEFAULT => -178
	},
	{#State 284
		DEFAULT => -196
	},
	{#State 285
		DEFAULT => -198
	},
	{#State 286
		ACTIONS => {
			'WORD' => 174,
			"%{" => 84
		},
		GOTOS => {
			'HashEntry' => 320,
			'HashDereferenced' => 175
		}
	},
	{#State 287
		DEFAULT => -189
	},
	{#State 288
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Expression' => 132,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'SubExpression' => 321,
			'HashDereferenced' => 113,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'Variable' => 130
		}
	},
	{#State 289
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP16_LOGICAL_OR' => 150,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP08_MATH_ADD_SUB' => 151,
			"}" => 322,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144
		}
	},
	{#State 290
		ACTIONS => {
			'LEFT_PAREN' => -201,
			"}" => 323
		}
	},
	{#State 291
		ACTIONS => {
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP08_MATH_ADD_SUB' => 151,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP18_TERNARY' => 143,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => 324,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141
		}
	},
	{#State 292
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 325
		}
	},
	{#State 293
		ACTIONS => {
			'LEFT_PAREN' => 326
		}
	},
	{#State 294
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			"undef" => 109,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashDereferenced' => 113,
			'SubExpression' => 327,
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Variable' => 130,
			'Expression' => 132,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87
		}
	},
	{#State 295
		DEFAULT => -118
	},
	{#State 296
		DEFAULT => -117
	},
	{#State 297
		DEFAULT => -126
	},
	{#State 298
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			'KEYS_OR_VALUES' => 163,
			"\@{" => 112,
			'OP01_QW' => 167,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"my" => 73,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'TypeInner' => 164,
			'Expression' => 132,
			'Variable' => 130,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ListElements' => 328,
			'ArrayReference' => 80,
			'SubExpression' => 168,
			'HashDereferenced' => 113,
			'ListElement' => 166
		}
	},
	{#State 299
		ACTIONS => {
			")" => 329
		}
	},
	{#State 300
		ACTIONS => {
			"%{" => 84,
			'WORD' => 303
		},
		GOTOS => {
			'HashEntryTyped' => 330,
			'HashDereferenced' => 304
		}
	},
	{#State 301
		ACTIONS => {
			"our" => 332,
			'LITERAL_NUMBER' => 334
		},
		GOTOS => {
			'MethodOrSubroutine' => 331,
			'Method' => 333,
			'Subroutine' => 335
		}
	},
	{#State 302
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 336
		}
	},
	{#State 303
		ACTIONS => {
			'OP20_HASH_FATARROW' => 337
		}
	},
	{#State 304
		DEFAULT => -194
	},
	{#State 305
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 338
		}
	},
	{#State 306
		DEFAULT => -205
	},
	{#State 307
		DEFAULT => -46
	},
	{#State 308
		ACTIONS => {
			'OP21_LIST_COMMA' => 340,
			")" => 341
		},
		GOTOS => {
			'PAREN-18' => 339
		}
	},
	{#State 309
		ACTIONS => {
			";" => 342
		}
	},
	{#State 310
		DEFAULT => -108
	},
	{#State 311
		ACTIONS => {
			'LITERAL_STRING' => 343
		}
	},
	{#State 312
		ACTIONS => {
			'VARIABLE_SYMBOL' => 102,
			"my" => 82,
			'OP01_CLOSE' => 81,
			'OP01_PRINT' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP19_LOOP_CONTROL' => 103,
			"for my integer" => -142,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED_VOID' => 94,
			'OP01_NAMED' => 96,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			"foreach my" => -142,
			'LITERAL_STRING' => 114,
			"if (" => 90,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			"undef" => 109,
			"}" => 344,
			'LEFT_BRACKET' => 111,
			'WORD' => 110,
			"while (" => -142,
			"\@{" => 112
		},
		GOTOS => {
			'PAREN-38' => 117,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Operation' => 345,
			'Expression' => 91,
			'SubExpression' => 86,
			'HashDereferenced' => 113,
			'OPTIONAL-39' => 104,
			'Statement' => 107,
			'LoopLabel' => 83,
			'Variable' => 92,
			'Conditional' => 93,
			'VariableModification' => 101,
			'VariableDeclaration' => 99,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'OperatorVoid' => 97,
			'Operator' => 77
		}
	},
	{#State 313
		DEFAULT => -162
	},
	{#State 314
		ACTIONS => {
			'LITERAL_STRING' => -153,
			'OP05_MATH_NEG' => -153,
			'' => -153,
			'LEFT_PAREN' => -153,
			"undef" => -153,
			"\@{" => -153,
			"while (" => -153,
			'WORD' => -153,
			'LEFT_BRACKET' => -153,
			"else" => 348,
			'OP19_LOOP_CONTROL' => -153,
			'OP10_NAMED_UNARY_STRINGIFY' => -153,
			'OP01_PRINT' => -153,
			'VARIABLE_SYMBOL' => -153,
			'OP05_LOGICAL_NEG' => -153,
			'OP01_NAMED' => -153,
			'OP01_NAMED_VOID' => -153,
			'OP03_MATH_INC_DEC' => -153,
			'LEFT_BRACE' => -153,
			"foreach my" => -153,
			'OP22_LOGICAL_NOT' => -153,
			'OP01_OPEN' => -153,
			"if (" => -153,
			'WORD_SCOPED' => -153,
			"}" => -153,
			"for my integer" => -153,
			'OP01_CLOSE' => -153,
			"my" => -153,
			"%{" => -153,
			"elsif (" => 350,
			'LITERAL_NUMBER' => -153,
			'OP10_NAMED_UNARY' => -153
		},
		GOTOS => {
			'PAREN-42' => 349,
			'OPTIONAL-43' => 346,
			'PAREN-40' => 347
		}
	},
	{#State 315
		DEFAULT => -123
	},
	{#State 316
		ACTIONS => {
			")" => 351
		}
	},
	{#State 317
		DEFAULT => -174
	},
	{#State 318
		DEFAULT => -177
	},
	{#State 319
		DEFAULT => -180
	},
	{#State 320
		DEFAULT => -195
	},
	{#State 321
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			'OP08_STRING_CAT' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP18_TERNARY' => 143,
			'OP08_MATH_ADD_SUB' => 151,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP21_LIST_COMMA' => -191,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			"}" => -191
		}
	},
	{#State 322
		DEFAULT => -168
	},
	{#State 323
		DEFAULT => -169
	},
	{#State 324
		DEFAULT => -167
	},
	{#State 325
		DEFAULT => -160
	},
	{#State 326
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			"my" => 73,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LITERAL_STRING' => 114,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			"undef" => 109,
			'OP01_QW' => 167,
			"\@{" => 112,
			'WORD' => 24,
			'KEYS_OR_VALUES' => 163,
			'LEFT_BRACKET' => 111
		},
		GOTOS => {
			'TypeInner' => 164,
			'WordScoped' => 115,
			'HashReference' => 116,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'ListElement' => 166,
			'SubExpression' => 168,
			'HashDereferenced' => 113,
			'Operator' => 77,
			'ArrayReference' => 80,
			'ListElements' => 352,
			'ArrayDereferenced' => 98
		}
	},
	{#State 327
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_MATCH' => 152,
			".." => 353,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144
		}
	},
	{#State 328
		ACTIONS => {
			")" => 354
		}
	},
	{#State 329
		DEFAULT => -84
	},
	{#State 330
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 355
		}
	},
	{#State 331
		DEFAULT => -59
	},
	{#State 332
		ACTIONS => {
			'TYPE_METHOD' => 356,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 333
		DEFAULT => -80
	},
	{#State 334
		ACTIONS => {
			";" => 357
		}
	},
	{#State 335
		DEFAULT => -81
	},
	{#State 336
		DEFAULT => -66
	},
	{#State 337
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 358
		}
	},
	{#State 338
		ACTIONS => {
			'OP21_LIST_COMMA' => 361,
			")" => 359
		},
		GOTOS => {
			'PAREN-25' => 360
		}
	},
	{#State 339
		DEFAULT => -48
	},
	{#State 340
		ACTIONS => {
			"my" => 362
		}
	},
	{#State 341
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 342
		DEFAULT => -171
	},
	{#State 343
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 344
		DEFAULT => -163
	},
	{#State 345
		DEFAULT => -161
	},
	{#State 346
		DEFAULT => -154
	},
	{#State 347
		DEFAULT => -149
	},
	{#State 348
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 349
		DEFAULT => -152
	},
	{#State 350
		ACTIONS => {
			"undef" => 109,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'SubExpression' => 366,
			'HashDereferenced' => 113,
			'Variable' => 130,
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 351
		DEFAULT => -127
	},
	{#State 352
		ACTIONS => {
			")" => 367
		}
	},
	{#State 353
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			'LEFT_BRACE' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP05_LOGICAL_NEG' => 108,
			"%{" => 84,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'SubExpression' => 368,
			'HashDereferenced' => 113,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'Operator' => 77
		}
	},
	{#State 354
		DEFAULT => -86
	},
	{#State 355
		ACTIONS => {
			")" => 371,
			'OP21_LIST_COMMA' => 369
		},
		GOTOS => {
			'PAREN-27' => 370
		}
	},
	{#State 356
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 357
		DEFAULT => -61
	},
	{#State 358
		ACTIONS => {
			"undef" => 109,
			'LEFT_BRACKET' => 111,
			'WORD' => 24,
			"\@{" => 112,
			'LITERAL_STRING' => 114,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'LEFT_BRACE' => 100,
			'VARIABLE_SYMBOL' => 102,
			'OP01_CLOSE' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108
		},
		GOTOS => {
			'HashReference' => 116,
			'WordScoped' => 115,
			'Literal' => 87,
			'Expression' => 132,
			'Variable' => 130,
			'HashDereferenced' => 113,
			'SubExpression' => 373,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80
		}
	},
	{#State 359
		ACTIONS => {
			";" => 374
		}
	},
	{#State 360
		DEFAULT => -63
	},
	{#State 361
		ACTIONS => {
			"%{" => 84,
			'WORD' => 303
		},
		GOTOS => {
			'HashDereferenced' => 304,
			'HashEntryTyped' => 375
		}
	},
	{#State 362
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 376
		}
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 377
		}
	},
	{#State 364
		ACTIONS => {
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_CLOSE' => 81,
			'VARIABLE_SYMBOL' => 102,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 120,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			"\@{" => 112,
			'WORD' => 24,
			'LEFT_BRACKET' => 111,
			"undef" => 109
		},
		GOTOS => {
			'Expression' => 132,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'Operator' => 77,
			'ArrayDereferenced' => 98,
			'ArrayReference' => 80,
			'SubExpression' => 378,
			'HashDereferenced' => 113,
			'Variable' => 130
		}
	},
	{#State 365
		DEFAULT => -151
	},
	{#State 366
		ACTIONS => {
			")" => 379,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			'OP08_STRING_CAT' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP18_TERNARY' => 143,
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 154
		}
	},
	{#State 367
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 368
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP06_REGEX_MATCH' => 152,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP08_MATH_ADD_SUB' => 151,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP08_STRING_CAT' => 141,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => 381,
			'OP18_TERNARY' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP11_COMPARE_LT_GT' => 148,
			'OP14_BITWISE_OR_XOR' => 149
		}
	},
	{#State 369
		ACTIONS => {
			"%{" => 84,
			'WORD' => 303
		},
		GOTOS => {
			'HashDereferenced' => 304,
			'HashEntryTyped' => 382
		}
	},
	{#State 370
		DEFAULT => -68
	},
	{#State 371
		ACTIONS => {
			";" => 383
		}
	},
	{#State 372
		ACTIONS => {
			"= sub {" => 384
		}
	},
	{#State 373
		ACTIONS => {
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 145,
			'OP08_MATH_ADD_SUB' => 151,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP21_LIST_COMMA' => -193,
			'OP16_LOGICAL_OR' => 150,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP18_TERNARY' => 143,
			")" => -193,
			'OP09_BITWISE_SHIFT' => 147,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 140
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
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 377
		DEFAULT => -50
	},
	{#State 378
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 147,
			")" => -87,
			'OP08_STRING_CAT' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 140,
			'OP17_LIST_RANGE' => 139,
			'OP14_BITWISE_OR_XOR' => 149,
			"]" => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP11_COMPARE_LT_GT' => 148,
			'OP18_TERNARY' => 143,
			'OP08_MATH_ADD_SUB' => 151,
			".." => -87,
			";" => -87,
			'OP12_COMPARE_EQ_NEQ' => 153,
			'OP06_REGEX_MATCH' => 152,
			'OP21_LIST_COMMA' => -87,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => -87,
			"}" => -87
		}
	},
	{#State 379
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 386
		}
	},
	{#State 380
		DEFAULT => -159
	},
	{#State 381
		ACTIONS => {
			'LEFT_BRACE' => 275
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 382
		DEFAULT => -67
	},
	{#State 383
		DEFAULT => -70
	},
	{#State 384
		ACTIONS => {
			"( my" => 388,
			"%{" => -72,
			'OP05_LOGICAL_NEG' => -72,
			'VARIABLE_SYMBOL' => -72,
			"my" => -72,
			'OP01_CLOSE' => -72,
			'OP01_PRINT' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			"for my integer" => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP10_NAMED_UNARY' => -72,
			'LITERAL_NUMBER' => -72,
			'LEFT_BRACE' => -72,
			"foreach my" => -72,
			'OP01_NAMED_VOID' => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_NAMED' => -72,
			'LEFT_PAREN' => -72,
			'WORD_SCOPED' => -72,
			'OP05_MATH_NEG' => -72,
			'LITERAL_STRING' => -72,
			"if (" => -72,
			'OP01_OPEN' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'LEFT_BRACKET' => -72,
			'WORD' => -72,
			"while (" => -72,
			"\@{" => -72,
			"undef" => -72
		},
		GOTOS => {
			'MethodArguments' => 390,
			'OPTIONAL-29' => 389
		}
	},
	{#State 385
		DEFAULT => -47
	},
	{#State 386
		DEFAULT => -148
	},
	{#State 387
		DEFAULT => -158
	},
	{#State 388
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 391
		}
	},
	{#State 389
		ACTIONS => {
			'LEFT_BRACKET' => 111,
			"while (" => -142,
			'WORD' => 110,
			"\@{" => 112,
			"undef" => 109,
			'LEFT_PAREN' => 120,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LITERAL_STRING' => 114,
			"if (" => 90,
			'OP01_OPEN' => 88,
			'OP22_LOGICAL_NOT' => 89,
			'OP10_NAMED_UNARY' => 79,
			'LITERAL_NUMBER' => 78,
			"foreach my" => -142,
			'LEFT_BRACE' => 100,
			'OP01_NAMED_VOID' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			'VARIABLE_SYMBOL' => 102,
			"my" => 82,
			'OP01_CLOSE' => 81,
			'OP01_PRINT' => 106,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP19_LOOP_CONTROL' => 103,
			"for my integer" => -142
		},
		GOTOS => {
			'LoopLabel' => 83,
			'Statement' => 107,
			'PLUS-30' => 393,
			'OPTIONAL-39' => 104,
			'OperatorVoid' => 97,
			'Operator' => 77,
			'VariableDeclaration' => 99,
			'ArrayReference' => 80,
			'ArrayDereferenced' => 98,
			'VariableModification' => 101,
			'Variable' => 92,
			'Conditional' => 93,
			'Expression' => 91,
			'Operation' => 392,
			'Literal' => 87,
			'HashReference' => 116,
			'WordScoped' => 115,
			'PAREN-38' => 117,
			'SubExpression' => 86,
			'HashDereferenced' => 113
		}
	},
	{#State 390
		DEFAULT => -71
	},
	{#State 391
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 394
		}
	},
	{#State 392
		DEFAULT => -74
	},
	{#State 393
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP01_NAMED_VOID' => 94,
			'OP03_MATH_INC_DEC' => 95,
			"foreach my" => -142,
			'LEFT_BRACE' => 100,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 105,
			'OP01_PRINT' => 106,
			"for my integer" => -142,
			'OP19_LOOP_CONTROL' => 103,
			'VARIABLE_SYMBOL' => 102,
			"my" => 82,
			'OP01_CLOSE' => 81,
			"%{" => 84,
			'OP05_LOGICAL_NEG' => 108,
			"}" => 396,
			"undef" => 109,
			"\@{" => 112,
			'LEFT_BRACKET' => 111,
			'WORD' => 110,
			"while (" => -142,
			"if (" => 90,
			'OP22_LOGICAL_NOT' => 89,
			'OP01_OPEN' => 88,
			'LITERAL_STRING' => 114,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 121,
			'LEFT_PAREN' => 120
		},
		GOTOS => {
			'OPTIONAL-39' => 104,
			'Statement' => 107,
			'LoopLabel' => 83,
			'Variable' => 92,
			'Conditional' => 93,
			'VariableModification' => 101,
			'Operator' => 77,
			'OperatorVoid' => 97,
			'ArrayReference' => 80,
			'VariableDeclaration' => 99,
			'ArrayDereferenced' => 98,
			'HashReference' => 116,
			'WordScoped' => 115,
			'PAREN-38' => 117,
			'Literal' => 87,
			'Expression' => 91,
			'Operation' => 395,
			'SubExpression' => 86,
			'HashDereferenced' => 113
		}
	},
	{#State 394
		ACTIONS => {
			")" => 398,
			'OP21_LIST_COMMA' => 399
		},
		GOTOS => {
			'PAREN-31' => 397
		}
	},
	{#State 395
		DEFAULT => -73
	},
	{#State 396
		ACTIONS => {
			";" => 400
		}
	},
	{#State 397
		DEFAULT => -77
	},
	{#State 398
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 399
		ACTIONS => {
			"my" => 402
		}
	},
	{#State 400
		DEFAULT => -75
	},
	{#State 401
		ACTIONS => {
			"\@_;" => 403
		}
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
		DEFAULT => -79
	},
	{#State 404
		ACTIONS => {
			'VARIABLE_SYMBOL' => 405
		}
	},
	{#State 405
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5627 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5634 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5641 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5648 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5659 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5670 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5677 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5684 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5691 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5698 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5705 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5719 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5726 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5733 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5740 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5747 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5754 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5790 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5812 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5819 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5840 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5847 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6022 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6089 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6103 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6114 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6304 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6337 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6619 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6698 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6705 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6712 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_138
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6898 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6949 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6960 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6974 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_154
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_158
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_159
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_160
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_163
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_166
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_170
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7184 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_172
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_179
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_180
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_186
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_187
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_188
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_191
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_192
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7379 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_193
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_194
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_198
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_199
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_200
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_201
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_203
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule Type_204
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_205
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_206
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	]
],
#line 7535 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_125', 
         'Expression_126', 
         'Expression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpressionOrStdin_138', 
         'SubExpressionOrStdin_139', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_154', 
         'Loop_155', 
         'Loop_156', 
         'Loop_157', 
         'LoopFor_158', 
         'LoopForEach_159', 
         'LoopWhile_160', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_163', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_166', 
         'VariableRetrieval_167', 
         'VariableRetrieval_168', 
         'VariableRetrieval_169', 
         'VariableDeclaration_170', 
         'VariableDeclaration_171', 
         'VariableModification_172', 
         'VariableModification_173', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_179', 
         'ListElements_180', 
         'ListElement_181', 
         'ListElement_182', 
         'ListElement_183', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_186', 
         'ArrayDereferenced_187', 
         'ArrayDereferenced_188', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_191', 
         'HashEntry_192', 
         'HashEntryTyped_193', 
         'HashEntryTyped_194', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_198', 
         'HashDereferenced_199', 
         'HashDereferenced_200', 
         'WordScoped_201', 
         'WordScoped_202', 
         'LoopLabel_203', 
         'Type_204', 
         'TypeInner_205', 
         'Literal_206', 
         'Literal_207', );
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


#line 7791 lib/RPerl/Grammar.pm



1;
