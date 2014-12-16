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
    our $VERSION = 0.000_801;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|__method|\$TYPED_|while\ \(|elsif\ \(|package|\=\ sub\ \{|\<STDIN\>|undef|else|\(\ my|if\ \(|our|use|qw\(|\@_\;|my|\%\{|\{\*|\.\.|\@\{|\{|\]|\(|\}|\[|\)|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
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
      /\G(print\s*\()/gc and return ('OP01_PRINT_VOID_PAREN', $1);
      /\G(print)/gc and return ('OP01_PRINT_VOID', $1);
      /\G((croak|return|exit)\s*\()/gc and return ('OP01_NAMED_VOID_PAREN', $1);
      /\G(croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_QW', $1);
      /\G((open|close)\s*\()/gc and return ('OP01_OPEN_CLOSE_PAREN', $1);
      /\G(open|close)/gc and return ('OP01_OPEN_CLOSE', $1);
      /\G(sin|cos|tan)/gc and return ('OP01_NAMED', $1);
      /\G(([a-zA-Z]\w*(::[a-zA-Z]\w*)+)|(::[a-zA-Z]\w*(::[a-zA-Z]\w*)*))/gc and return ('WORD_SCOPED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);
      /\G:/gc and return ('COLON', $1);


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


#line 118 lib/RPerl/Grammar.pm

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
  [ 'Method_75' => 'Method', [ 'our', 'TypeMethod', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-29', 'PLUS-30', '}', ';' ], 0 ],
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
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP01_OPEN_CLOSE_PAREN', 'FileHandle', 'OPTIONAL-34', ')', ';' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP01_OPEN_CLOSE', 'FileHandle', 'OPTIONAL-35', ';' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'OperatorVoid_126' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-36', ')', ';' ], 0 ],
  [ 'OperatorVoid_127' => 'OperatorVoid', [ 'OP01_PRINT_VOID_PAREN', 'FileHandle', 'OPTIONAL-37', ')', ';' ], 0 ],
  [ 'OperatorVoid_128' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-38', ';' ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'OPTIONAL-39', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandle', 'OPTIONAL-40', ';' ], 0 ],
  [ 'OperatorVoid_131' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_137' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_138' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_139' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_143' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-41', ')' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_147' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_148' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_149' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'PAREN-43' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'OPTIONAL-44', 'Loop' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Conditional_164' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-46', 'OPTIONAL-48' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_168' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_169' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_170' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'PLUS-49', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-49', [ 'Operation' ], 0 ],
  [ 'CodeBlock_173' => 'CodeBlock', [ '{', 'PLUS-49', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'Variable_176' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-50' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'WORD' ], 0 ],
  [ 'ListElements_189' => 'ListElements', [ 'ListElement', 'STAR-52' ], 0 ],
  [ 'ListElements_190' => 'ListElements', [ 'OP01_QW', '(', 'PLUS-53', ')' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'ArrayReference_196' => 'ArrayReference', [ '[', 'OPTIONAL-54', ']' ], 0 ],
  [ 'ArrayDereferenced_197' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_198' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'HashEntry_201' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-55', 'Expression' ], 0 ],
  [ 'HashEntry_202' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_203' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_204' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-56', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [ 'STAR-57', 'PAREN-56' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [  ], 0 ],
  [ 'HashReference_208' => 'HashReference', [ '{', 'HashEntry', 'STAR-57', '}' ], 0 ],
  [ 'HashDereferenced_209' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_210' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_211' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_212' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_213' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_214' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeMethod_215' => 'TypeMethod', [ 'WORD', '__method' ], 0 ],
  [ 'TypeInner_216' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandle_217' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_218' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'Literal_219' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_220' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_OPTIONAL' => 86,
  '_OPTIONAL' => 87,
  '_OPTIONAL' => 88,
  '_OPTIONAL' => 89,
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
  'Operator_114' => 114,
  'Operator_115' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  'OperatorVoid_126' => 126,
  'OperatorVoid_127' => 127,
  'OperatorVoid_128' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  'OperatorVoid_131' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  '_OPTIONAL' => 135,
  'Expression_136' => 136,
  'Expression_137' => 137,
  'Expression_138' => 138,
  'Expression_139' => 139,
  'Expression_140' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'ExpressionOrStdin_148' => 148,
  'ExpressionOrStdin_149' => 149,
  '_PAREN' => 150,
  '_OPTIONAL' => 151,
  '_OPTIONAL' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  'Statement_157' => 157,
  '_PAREN' => 158,
  '_STAR_LIST' => 159,
  '_STAR_LIST' => 160,
  '_PAREN' => 161,
  '_OPTIONAL' => 162,
  '_OPTIONAL' => 163,
  'Conditional_164' => 164,
  'Loop_165' => 165,
  'Loop_166' => 166,
  'Loop_167' => 167,
  'LoopFor_168' => 168,
  'LoopForEach_169' => 169,
  'LoopWhile_170' => 170,
  '_PLUS_LIST' => 171,
  '_PLUS_LIST' => 172,
  'CodeBlock_173' => 173,
  '_STAR_LIST' => 174,
  '_STAR_LIST' => 175,
  'Variable_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableRetrieval_178' => 178,
  'VariableRetrieval_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableModification_182' => 182,
  'VariableModification_183' => 183,
  '_PAREN' => 184,
  '_STAR_LIST' => 185,
  '_STAR_LIST' => 186,
  '_PLUS_LIST' => 187,
  '_PLUS_LIST' => 188,
  'ListElements_189' => 189,
  'ListElements_190' => 190,
  'ListElement_191' => 191,
  'ListElement_192' => 192,
  'ListElement_193' => 193,
  '_OPTIONAL' => 194,
  '_OPTIONAL' => 195,
  'ArrayReference_196' => 196,
  'ArrayDereferenced_197' => 197,
  'ArrayDereferenced_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'HashEntry_201' => 201,
  'HashEntry_202' => 202,
  'HashEntryTyped_203' => 203,
  'HashEntryTyped_204' => 204,
  '_PAREN' => 205,
  '_STAR_LIST' => 206,
  '_STAR_LIST' => 207,
  'HashReference_208' => 208,
  'HashDereferenced_209' => 209,
  'HashDereferenced_210' => 210,
  'WordScoped_211' => 211,
  'WordScoped_212' => 212,
  'LoopLabel_213' => 213,
  'Type_214' => 214,
  'TypeMethod_215' => 215,
  'TypeInner_216' => 216,
  'FileHandle_217' => 217,
  'FileHandle_218' => 218,
  'Literal_219' => 219,
  'Literal_220' => 220,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'<STDIN>' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'__method' => { ISSEMANTIC => 0 },
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
	'{' => { ISSEMANTIC => 0 },
	'{*' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	COLON => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_PAREN => { ISSEMANTIC => 1 },
	OP01_OPEN_CLOSE => { ISSEMANTIC => 1 },
	OP01_OPEN_CLOSE_PAREN => { ISSEMANTIC => 1 },
	OP01_PRINT_VOID => { ISSEMANTIC => 1 },
	OP01_PRINT_VOID_PAREN => { ISSEMANTIC => 1 },
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
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			'SHEBANG' => 5
		},
		GOTOS => {
			'PLUS-2' => 4,
			'OPTIONAL-9' => 1,
			'Critic' => 3,
			'Program' => 7,
			'CompileUnit' => 8,
			'PAREN-1' => 6,
			'ModuleHeader' => 9
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-14' => 11
		}
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 2,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 13,
			'ModuleHeader' => 9,
			'Critic' => 3,
			'OPTIONAL-9' => 1
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 15
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			'' => 16
		}
	},
	{#State 9
		ACTIONS => {
			"use parent qw(" => 20,
			"## no critic qw(" => -25,
			"our" => -25,
			"use" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Package' => 18,
			'STAR-10' => 17,
			'Module' => 21,
			'Class' => 19
		}
	},
	{#State 10
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 11
		ACTIONS => {
			")" => 26,
			'WORD' => 25
		}
	},
	{#State 12
		DEFAULT => -35
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 29,
			'STAR-11' => 30
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		DEFAULT => -23
	},
	{#State 20
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => -1
	},
	{#State 22
		DEFAULT => -212
	},
	{#State 23
		DEFAULT => -211
	},
	{#State 24
		ACTIONS => {
			";" => 32
		}
	},
	{#State 25
		DEFAULT => -34
	},
	{#State 26
		DEFAULT => -36
	},
	{#State 27
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 28
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
		}
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
			'STAR-12' => 37,
			'Include' => 35
		}
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 27
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
			"foreach my" => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			"our" => -11,
			"while (" => -11,
			"use" => -11,
			'OP05_MATH_NEG' => -11,
			"(" => -11,
			"undef" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"for my integer" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_STRING' => -11,
			"\@{" => -11,
			'OP10_NAMED_UNARY' => -11,
			"if (" => -11,
			"use constant" => -11,
			"%{" => -11,
			"[" => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			'OP01_NAMED_VOID' => -11,
			"## no critic qw(" => 2,
			'WORD' => -11,
			'OP01_PRINT_VOID' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED' => -11,
			"{" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			"my" => -11,
			'OP01_OPEN_CLOSE' => -11,
			'WORD_SCOPED' => -11
		},
		GOTOS => {
			'Critic' => 42,
			'STAR-5' => 41
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 46,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 44,
			'PLUS-13' => 48,
			'Constant' => 45
		}
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
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -13,
			"[" => -13,
			"%{" => -13,
			"use constant" => -13,
			'WORD' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_PRINT_VOID' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'LITERAL_NUMBER' => -13,
			'OP22_LOGICAL_NOT' => -13,
			"{" => -13,
			"my" => -13,
			'WORD_SCOPED' => -13,
			'OP01_OPEN_CLOSE' => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			"foreach my" => -13,
			"our" => -13,
			"while (" => -13,
			"(" => -13,
			'OP05_MATH_NEG' => -13,
			"use" => 36,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"for my integer" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY' => -13,
			"\@{" => -13,
			"if (" => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		ACTIONS => {
			";" => 54,
			"qw(" => 53
		}
	},
	{#State 44
		DEFAULT => -31
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			'WORD' => 55
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 48
		ACTIONS => {
			"our" => 47,
			'LITERAL_NUMBER' => 59
		},
		GOTOS => {
			'Subroutine' => 58
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
			'OP01_NAMED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_PRINT_VOID' => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			'LITERAL_NUMBER' => -15,
			'OP22_LOGICAL_NOT' => -15,
			"{" => -15,
			"my" => -15,
			'WORD_SCOPED' => -15,
			'OP01_OPEN_CLOSE' => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			"[" => -15,
			"%{" => -15,
			"use constant" => 46,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_STRING' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"for my integer" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"undef" => -15,
			"\@{" => -15,
			'OP10_NAMED_UNARY' => -15,
			"if (" => -15,
			"foreach my" => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			"our" => -15,
			"while (" => -15,
			"(" => -15,
			'OP05_MATH_NEG' => -15
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
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 64
		}
	},
	{#State 54
		DEFAULT => -39
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 57
		DEFAULT => -214
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			";" => 68
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
			"foreach my" => -152,
			'OP01_PRINT_VOID_PAREN' => 94,
			"our" => 47,
			"while (" => -152,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			"for my integer" => -152,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"if (" => 114,
			'OP01_NAMED_VOID_PAREN' => 73,
			"%{" => 70,
			"[" => 71,
			'WORD' => 77,
			'OP01_NAMED_VOID' => 76,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'OP01_PRINT_VOID' => 86,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{" => 78,
			"my" => 93,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Subroutine' => 96,
			'ArrayReference' => 75,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'PLUS-8' => 72,
			'VariableModification' => 74,
			'OperatorVoid' => 92,
			'Literal' => 115,
			'Expression' => 113,
			'HashReference' => 91,
			'LoopLabel' => 82,
			'WordScoped' => 106,
			'PAREN-43' => 100,
			'VariableDeclaration' => 102,
			'Conditional' => 105,
			'Variable' => 104,
			'Statement' => 89,
			'Operation' => 109,
			'Operator' => 108,
			'OPTIONAL-44' => 84
		}
	},
	{#State 64
		ACTIONS => {
			")" => 117,
			'WORD' => 116
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			"my" => 119
		},
		GOTOS => {
			'TypeInner' => 118
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 120
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			"our %properties = (" => -54,
			"use" => -54,
			"use constant" => -54,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 121,
			'STAR-21' => 122
		}
	},
	{#State 70
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87,
			"{" => 124
		},
		GOTOS => {
			'Variable' => 123,
			'HashReference' => 125
		}
	},
	{#State 71
		ACTIONS => {
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			"[" => 71,
			"%{" => 70,
			"]" => -195,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"my" => 119,
			'OP01_QW' => 128,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107
		},
		GOTOS => {
			'Variable' => 126,
			'ListElements' => 127,
			'WordScoped' => 106,
			'Operator' => 108,
			'OPTIONAL-54' => 132,
			'TypeInner' => 130,
			'Expression' => 129,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'ListElement' => 131,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 72
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"my" => 93,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP01_PRINT_VOID' => 86,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'OP01_NAMED_VOID' => 76,
			'WORD' => 77,
			"[" => 71,
			"%{" => 70,
			'OP01_NAMED_VOID_PAREN' => 73,
			"if (" => 114,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"for my integer" => -152,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"while (" => -152,
			'OP01_PRINT_VOID_PAREN' => 94,
			"foreach my" => -152,
			'' => -18
		},
		GOTOS => {
			'VariableModification' => 74,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'Statement' => 89,
			'OPTIONAL-44' => 84,
			'Operator' => 108,
			'Operation' => 134,
			'WordScoped' => 106,
			'LoopLabel' => 82,
			'Variable' => 104,
			'Conditional' => 105,
			'PAREN-43' => 100,
			'VariableDeclaration' => 102,
			'Literal' => 115,
			'OperatorVoid' => 92,
			'Expression' => 113,
			'HashReference' => 91
		}
	},
	{#State 73
		ACTIONS => {
			'OP01_QW' => 128,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE' => 90,
			"my" => 119,
			"[" => 71,
			"%{" => 70,
			'OP05_MATH_NEG' => 95,
			")" => -117,
			"(" => 97,
			'WORD' => 23
		},
		GOTOS => {
			'TypeInner' => 130,
			'HashReference' => 91,
			'Expression' => 129,
			'Literal' => 115,
			'ArrayReference' => 75,
			'ListElement' => 131,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'ListElements' => 135,
			'WordScoped' => 106,
			'OPTIONAL-36' => 136,
			'Operator' => 108
		}
	},
	{#State 74
		DEFAULT => -157
	},
	{#State 75
		DEFAULT => -139
	},
	{#State 76
		ACTIONS => {
			";" => -121,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"my" => 119,
			'OP01_QW' => 128,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'OPTIONAL-38' => 137,
			'TypeInner' => 130,
			'Expression' => 129,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75,
			'ListElement' => 131,
			'Operator' => 108,
			'Variable' => 126,
			'ListElements' => 138,
			'WordScoped' => 106
		}
	},
	{#State 77
		ACTIONS => {
			'COLON' => -213,
			"(" => -211
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 142,
			"%{" => 70,
			"}" => 139
		},
		GOTOS => {
			'HashEntry' => 141,
			'HashDereferenced' => 140
		}
	},
	{#State 79
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"[" => 71,
			"%{" => 70
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Expression' => 143,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75
		}
	},
	{#State 80
		DEFAULT => -220
	},
	{#State 81
		ACTIONS => {
			"my" => 146,
			"{*" => 145
		},
		GOTOS => {
			'FileHandle' => 144
		}
	},
	{#State 82
		ACTIONS => {
			'COLON' => 147
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"[" => 71,
			"%{" => 70,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"undef" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108,
			'Expression' => 148,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 84
		ACTIONS => {
			"while (" => 153,
			"for my integer" => 150,
			"foreach my" => 155
		},
		GOTOS => {
			'LoopWhile' => 154,
			'Loop' => 152,
			'LoopFor' => 149,
			'LoopForEach' => 151
		}
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 156
		}
	},
	{#State 86
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP01_QW' => 128,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			"{*" => 145,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE' => 90,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			"my" => 157,
			"[" => 71,
			"%{" => 70,
			"(" => 97,
			";" => -123,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 129,
			'TypeInner' => 130,
			'OPTIONAL-39' => 160,
			'ListElement' => 131,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'FileHandle' => 158,
			'WordScoped' => 106,
			'ListElements' => 159,
			'Operator' => 108
		}
	},
	{#State 87
		DEFAULT => -175,
		GOTOS => {
			'STAR-50' => 161
		}
	},
	{#State 88
		ACTIONS => {
			"(" => 162
		}
	},
	{#State 89
		DEFAULT => -83
	},
	{#State 90
		ACTIONS => {
			"{*" => 145,
			"my" => 146
		},
		GOTOS => {
			'FileHandle' => 163
		}
	},
	{#State 91
		DEFAULT => -141
	},
	{#State 92
		DEFAULT => -155
	},
	{#State 93
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 164
		}
	},
	{#State 94
		ACTIONS => {
			"{*" => 145,
			"my" => 146
		},
		GOTOS => {
			'FileHandle' => 165
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78
		},
		GOTOS => {
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Expression' => 166,
			'HashReference' => 91,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98
		}
	},
	{#State 96
		DEFAULT => -14
	},
	{#State 97
		ACTIONS => {
			"%{" => 70,
			"[" => 71,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashReference' => 91,
			'Expression' => 167,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108
		}
	},
	{#State 98
		DEFAULT => -142
	},
	{#State 99
		DEFAULT => -140
	},
	{#State 100
		DEFAULT => -151
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87,
			"[" => 71
		},
		GOTOS => {
			'ArrayReference' => 169,
			'Variable' => 168
		}
	},
	{#State 102
		DEFAULT => -156
	},
	{#State 103
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"undef" => 107,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"%{" => 70,
			"[" => 71
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 170,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108
		}
	},
	{#State 104
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			";" => -138,
			'OP13_BITWISE_AND' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP08_STRING_CAT' => -138,
			'OP19_VARIABLE_ASSIGN' => 174,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP04_MATH_POW' => -138,
			'OP18_TERNARY' => -138,
			'OP02_METHOD_THINARROW' => 172,
			'OP03_MATH_INC_DEC' => 171,
			'OP08_MATH_ADD_SUB' => -138,
			'OP19_VARIABLE_ASSIGN_BY' => 173,
			'OP09_BITWISE_SHIFT' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP16_LOGICAL_OR' => -138
		}
	},
	{#State 105
		DEFAULT => -153
	},
	{#State 106
		ACTIONS => {
			"(" => 175
		}
	},
	{#State 107
		DEFAULT => -136
	},
	{#State 108
		DEFAULT => -144
	},
	{#State 109
		DEFAULT => -17
	},
	{#State 110
		ACTIONS => {
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashReference' => 91,
			'Expression' => 176,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98
		}
	},
	{#State 111
		ACTIONS => {
			'WORD' => 177
		},
		GOTOS => {
			'LoopLabel' => 178
		}
	},
	{#State 112
		DEFAULT => -219
	},
	{#State 113
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			";" => 185,
			'OP13_BITWISE_AND' => 187,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 114
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"%{" => 70,
			"[" => 71,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 196,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98
		}
	},
	{#State 115
		DEFAULT => -137
	},
	{#State 116
		DEFAULT => -37
	},
	{#State 117
		ACTIONS => {
			";" => 197
		}
	},
	{#State 118
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			'LITERAL_STRING' => 112
		},
		GOTOS => {
			'Literal' => 198
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 199
		}
	},
	{#State 120
		ACTIONS => {
			"if (" => -43,
			"for my integer" => -43,
			'LITERAL_STRING' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"undef" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"\@{" => -43,
			'OP10_NAMED_UNARY' => -43,
			"while (" => -43,
			'OP05_MATH_NEG' => -43,
			"( my" => 201,
			"(" => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			"foreach my" => -43,
			"my" => -43,
			'WORD_SCOPED' => -43,
			'OP01_OPEN_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED' => -43,
			'OP01_PRINT_VOID' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"{" => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			'LITERAL_NUMBER' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'WORD' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			"%{" => -43,
			"[" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 200,
			'OPTIONAL-16' => 202
		}
	},
	{#State 121
		DEFAULT => -51
	},
	{#State 122
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
	{#State 123
		ACTIONS => {
			"}" => 205
		}
	},
	{#State 124
		ACTIONS => {
			'WORD' => 142,
			"%{" => 70
		},
		GOTOS => {
			'HashEntry' => 141,
			'HashDereferenced' => 140
		}
	},
	{#State 125
		ACTIONS => {
			"}" => 206
		}
	},
	{#State 126
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP16_LOGICAL_OR' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP18_TERNARY' => -138,
			'OP02_METHOD_THINARROW' => 172,
			'OP03_MATH_INC_DEC' => 171,
			'OP06_REGEX_MATCH' => -138,
			'OP04_MATH_POW' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP21_LIST_COMMA' => -138,
			".." => -138,
			";" => -138,
			")" => -138,
			"}" => -138,
			'OP13_BITWISE_AND' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP08_STRING_CAT' => -138,
			"]" => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP24_LOGICAL_OR_XOR' => -138
		}
	},
	{#State 127
		DEFAULT => -194
	},
	{#State 128
		ACTIONS => {
			"(" => 207
		}
	},
	{#State 129
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => 180,
			'OP13_BITWISE_AND' => 187,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -191,
			";" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -191,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			"]" => -191
		}
	},
	{#State 130
		ACTIONS => {
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 208,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108
		}
	},
	{#State 131
		DEFAULT => -186,
		GOTOS => {
			'STAR-52' => 209
		}
	},
	{#State 132
		ACTIONS => {
			"]" => 210
		}
	},
	{#State 133
		ACTIONS => {
			"%{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 211
		}
	},
	{#State 134
		DEFAULT => -16
	},
	{#State 135
		DEFAULT => -116
	},
	{#State 136
		ACTIONS => {
			")" => 212
		}
	},
	{#State 137
		ACTIONS => {
			";" => 213
		}
	},
	{#State 138
		DEFAULT => -120
	},
	{#State 139
		DEFAULT => -143
	},
	{#State 140
		DEFAULT => -202
	},
	{#State 141
		DEFAULT => -207,
		GOTOS => {
			'STAR-57' => 214
		}
	},
	{#State 142
		ACTIONS => {
			'OP20_HASH_FATARROW' => 215
		}
	},
	{#State 143
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP14_BITWISE_OR_XOR' => 184,
			"]" => -113,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			"}" => -113,
			'OP13_BITWISE_AND' => 187,
			")" => -113,
			";" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -113,
			".." => -113,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 182,
			'OP23_LOGICAL_AND' => -113,
			'OP17_LIST_RANGE' => 181,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192
		}
	},
	{#State 144
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"\@{" => 101,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			'OP01_QW' => 128,
			"my" => 119,
			'OP01_OPEN_CLOSE' => 90,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			"[" => 71,
			"%{" => 70,
			'WORD' => 23,
			"(" => 97,
			")" => -87,
			'OP05_MATH_NEG' => 95
		},
		GOTOS => {
			'TypeInner' => 130,
			'Expression' => 129,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'ListElement' => 131,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'OPTIONAL-34' => 217,
			'Variable' => 126,
			'WordScoped' => 106,
			'ListElements' => 216,
			'Operator' => 108
		}
	},
	{#State 145
		ACTIONS => {
			'WORD' => 218
		}
	},
	{#State 146
		ACTIONS => {
			"filehandle_ref" => 219
		}
	},
	{#State 147
		DEFAULT => -150
	},
	{#State 148
		ACTIONS => {
			";" => -96,
			")" => -96,
			"}" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP21_LIST_COMMA' => -96,
			".." => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP06_REGEX_MATCH' => -96,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -96
		}
	},
	{#State 149
		DEFAULT => -165
	},
	{#State 150
		ACTIONS => {
			'VARIABLE_SYMBOL' => 220
		}
	},
	{#State 151
		DEFAULT => -166
	},
	{#State 152
		DEFAULT => -154
	},
	{#State 153
		ACTIONS => {
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"[" => 71,
			"%{" => 70,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"\@{" => 101,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 221
		}
	},
	{#State 154
		DEFAULT => -167
	},
	{#State 155
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 222
		}
	},
	{#State 156
		DEFAULT => -93
	},
	{#State 157
		ACTIONS => {
			'WORD' => 57,
			"filehandle_ref" => 219
		},
		GOTOS => {
			'Type' => 199
		}
	},
	{#State 158
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_QW' => 128,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			"my" => 119,
			"%{" => 70,
			"[" => 71,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			";" => -125,
			'WORD' => 23
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'ListElements' => 223,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'OPTIONAL-40' => 224,
			'HashReference' => 91,
			'Expression' => 129,
			'TypeInner' => 130,
			'ListElement' => 131,
			'ArrayReference' => 75,
			'Literal' => 115
		}
	},
	{#State 159
		DEFAULT => -122
	},
	{#State 160
		ACTIONS => {
			";" => 225
		}
	},
	{#State 161
		ACTIONS => {
			'OP06_REGEX_MATCH' => -176,
			'OP04_MATH_POW' => -176,
			'OP18_TERNARY' => -176,
			'OP02_METHOD_THINARROW' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP02_HASH_THINARROW' => 227,
			'OP08_MATH_ADD_SUB' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP12_COMPARE_EQ_NEQ' => -176,
			'OP16_LOGICAL_OR' => -176,
			'COLON' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			"]" => -176,
			";" => -176,
			")" => -176,
			"}" => -176,
			'OP13_BITWISE_AND' => -176,
			'OP08_STRING_CAT' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP02_ARRAY_THINARROW' => 228,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP21_LIST_COMMA' => -176,
			".." => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 226
		}
	},
	{#State 162
		ACTIONS => {
			'WORD' => 23,
			")" => -85,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"[" => 71,
			"%{" => 70,
			"my" => 119,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'OP01_QW' => 128,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 106,
			'ListElements' => 230,
			'OPTIONAL-33' => 229,
			'Operator' => 108,
			'Expression' => 129,
			'HashReference' => 91,
			'TypeInner' => 130,
			'ListElement' => 131,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 163
		ACTIONS => {
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			";" => -89,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			"my" => 119,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_QW' => 128,
			"undef" => 107,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 129,
			'TypeInner' => 130,
			'ListElement' => 131,
			'Literal' => 115,
			'ArrayReference' => 75,
			'OPTIONAL-35' => 232,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'ListElements' => 231
		}
	},
	{#State 164
		ACTIONS => {
			'VARIABLE_SYMBOL' => 233
		}
	},
	{#State 165
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE' => 90,
			"my" => 119,
			'OP01_QW' => 128,
			"\@{" => 101,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_MATH_NEG' => 95,
			")" => -119,
			"(" => 97,
			'WORD' => 23,
			"[" => 71,
			"%{" => 70
		},
		GOTOS => {
			'Operator' => 108,
			'OPTIONAL-37' => 234,
			'Variable' => 126,
			'WordScoped' => 106,
			'ListElements' => 235,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'TypeInner' => 130,
			'Expression' => 129,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75,
			'ListElement' => 131
		}
	},
	{#State 166
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 236,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			'OP13_BITWISE_AND' => 187,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP15_LOGICAL_AND' => 182,
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179
		}
	},
	{#State 167
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 237,
			'OP13_BITWISE_AND' => 187,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193
		}
	},
	{#State 168
		ACTIONS => {
			"}" => 238
		}
	},
	{#State 169
		ACTIONS => {
			"}" => 239
		}
	},
	{#State 170
		ACTIONS => {
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP17_LIST_RANGE' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			"]" => -103,
			";" => -103,
			")" => -103,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => -103,
			"}" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			".." => -103
		}
	},
	{#State 171
		DEFAULT => -94
	},
	{#State 172
		ACTIONS => {
			'WORD' => 240
		}
	},
	{#State 173
		ACTIONS => {
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashReference' => 91,
			'Expression' => 241
		}
	},
	{#State 174
		ACTIONS => {
			"%{" => 70,
			"[" => 71,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"undef" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'VARIABLE_SYMBOL' => 87,
			"<STDIN>" => 242,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'ExpressionOrStdin' => 244,
			'Expression' => 243,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => 23,
			")" => -133,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"%{" => 70,
			"[" => 71,
			"my" => 119,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP01_QW' => 128,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'TypeInner' => 130,
			'OPTIONAL-41' => 246,
			'Expression' => 129,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'ListElement' => 131,
			'Operator' => 108,
			'Variable' => 126,
			'ListElements' => 245,
			'WordScoped' => 106
		}
	},
	{#State 176
		ACTIONS => {
			'OP16_LOGICAL_OR' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP21_LIST_COMMA' => -104,
			".." => -104,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP11_COMPARE_LT_GT' => -104,
			'OP08_STRING_CAT' => 186,
			'OP13_BITWISE_AND' => -104,
			"}" => -104,
			")" => -104,
			";" => -104,
			"]" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP14_BITWISE_OR_XOR' => -104
		}
	},
	{#State 177
		DEFAULT => -213
	},
	{#State 178
		ACTIONS => {
			";" => 247
		}
	},
	{#State 179
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 248
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 249
		}
	},
	{#State 181
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashReference' => 91,
			'Expression' => 250
		}
	},
	{#State 182
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashReference' => 91,
			'Expression' => 251
		}
	},
	{#State 183
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'Literal' => 115,
			'ArrayReference' => 75,
			'Expression' => 252,
			'HashReference' => 91,
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126
		}
	},
	{#State 184
		ACTIONS => {
			"[" => 71,
			"%{" => 70,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"\@{" => 101,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 253,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108
		}
	},
	{#State 185
		DEFAULT => -82
	},
	{#State 186
		ACTIONS => {
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"%{" => 70,
			"[" => 71,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 254,
			'Literal' => 115,
			'ArrayReference' => 75
		}
	},
	{#State 187
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"%{" => 70,
			"[" => 71,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Expression' => 255,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115
		}
	},
	{#State 188
		ACTIONS => {
			"[" => 71,
			"%{" => 70,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'Literal' => 115,
			'ArrayReference' => 75,
			'Expression' => 256,
			'HashReference' => 91
		}
	},
	{#State 189
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"%{" => 70,
			"[" => 71,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 257,
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126
		}
	},
	{#State 190
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			"[" => 71,
			"%{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Expression' => 258,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"%{" => 70,
			"[" => 71
		},
		GOTOS => {
			'HashReference' => 91,
			'Expression' => 259,
			'Literal' => 115,
			'ArrayReference' => 75,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108
		}
	},
	{#State 192
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"%{" => 70,
			"[" => 71,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Expression' => 260,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75
		}
	},
	{#State 193
		ACTIONS => {
			"%{" => 70,
			"[" => 71,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Operator' => 108,
			'WordScoped' => 106,
			'Variable' => 126,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 261
		}
	},
	{#State 194
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"%{" => 70,
			"[" => 71,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Expression' => 262,
			'HashReference' => 91,
			'Literal' => 115,
			'ArrayReference' => 75,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 195
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"%{" => 70,
			"[" => 71
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 263,
			'Literal' => 115,
			'ArrayReference' => 75,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 196
		ACTIONS => {
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP13_BITWISE_AND' => 187,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => 264,
			'OP07_MATH_MULT_DIV_MOD' => 195
		}
	},
	{#State 197
		DEFAULT => -40
	},
	{#State 198
		ACTIONS => {
			";" => 265
		}
	},
	{#State 199
		ACTIONS => {
			"\$TYPED_" => 266
		}
	},
	{#State 200
		DEFAULT => -42
	},
	{#State 201
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 267
		}
	},
	{#State 202
		ACTIONS => {
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'OP01_NAMED_VOID' => 76,
			"while (" => -152,
			'WORD' => 77,
			"%{" => 70,
			"[" => 71,
			'OP01_NAMED_VOID_PAREN' => 73,
			'OP01_PRINT_VOID_PAREN' => 94,
			"foreach my" => -152,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"if (" => 114,
			"my" => 93,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP01_PRINT_VOID' => 86,
			"undef" => 107,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED' => 88,
			"for my integer" => -152,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'VariableModification' => 74,
			'ArrayReference' => 75,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'LoopLabel' => 82,
			'WordScoped' => 106,
			'PAREN-43' => 100,
			'PLUS-17' => 268,
			'VariableDeclaration' => 102,
			'Variable' => 104,
			'Conditional' => 105,
			'Statement' => 89,
			'Operation' => 269,
			'OPTIONAL-44' => 84,
			'Operator' => 108,
			'OperatorVoid' => 92,
			'Literal' => 115,
			'Expression' => 113,
			'HashReference' => 91
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		ACTIONS => {
			"use constant" => 46,
			"our %properties = (" => 272
		},
		GOTOS => {
			'Constant' => 271,
			'Properties' => 270
		}
	},
	{#State 205
		DEFAULT => -209
	},
	{#State 206
		DEFAULT => -210
	},
	{#State 207
		ACTIONS => {
			'WORD' => 274
		},
		GOTOS => {
			'PLUS-53' => 273
		}
	},
	{#State 208
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP15_LOGICAL_AND' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -192,
			";" => -192,
			")" => -192,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 187,
			"]" => -192,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193
		}
	},
	{#State 209
		ACTIONS => {
			")" => -189,
			";" => -189,
			"]" => -189,
			'OP21_LIST_COMMA' => 276
		},
		GOTOS => {
			'PAREN-51' => 275
		}
	},
	{#State 210
		DEFAULT => -196
	},
	{#State 211
		DEFAULT => -193
	},
	{#State 212
		ACTIONS => {
			";" => 277
		}
	},
	{#State 213
		DEFAULT => -128
	},
	{#State 214
		ACTIONS => {
			"}" => 280,
			'OP21_LIST_COMMA' => 279
		},
		GOTOS => {
			'PAREN-56' => 278
		}
	},
	{#State 215
		ACTIONS => {
			'LITERAL_NUMBER' => -200,
			'OP01_OPEN_CLOSE_PAREN' => -200,
			'OP22_LOGICAL_NOT' => -200,
			"\@{" => -200,
			"{" => -200,
			'OP10_NAMED_UNARY' => -200,
			'OP01_NAMED' => -200,
			'LITERAL_STRING' => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP10_NAMED_UNARY_STRINGIFY' => -200,
			'OP05_LOGICAL_NEG' => -200,
			'OP03_MATH_INC_DEC' => -200,
			"undef" => -200,
			'WORD_SCOPED' => -200,
			'OP01_OPEN_CLOSE' => -200,
			"my" => 119,
			"[" => -200,
			"%{" => -200,
			"(" => -200,
			'OP05_MATH_NEG' => -200,
			'WORD' => -200
		},
		GOTOS => {
			'OPTIONAL-55' => 281,
			'TypeInner' => 282
		}
	},
	{#State 216
		DEFAULT => -86
	},
	{#State 217
		ACTIONS => {
			")" => 283
		}
	},
	{#State 218
		ACTIONS => {
			"}" => 284
		}
	},
	{#State 219
		ACTIONS => {
			'VARIABLE_SYMBOL' => 285
		}
	},
	{#State 220
		ACTIONS => {
			"(" => 286
		}
	},
	{#State 221
		ACTIONS => {
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => 180,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP13_BITWISE_AND' => 187,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => 287,
			'OP07_MATH_MULT_DIV_MOD' => 195
		}
	},
	{#State 222
		ACTIONS => {
			'VARIABLE_SYMBOL' => 288
		}
	},
	{#State 223
		DEFAULT => -124
	},
	{#State 224
		ACTIONS => {
			";" => 289
		}
	},
	{#State 225
		DEFAULT => -129
	},
	{#State 226
		DEFAULT => -174
	},
	{#State 227
		ACTIONS => {
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"%{" => 70,
			"[" => 71,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 291
		},
		GOTOS => {
			'Expression' => 290,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108
		}
	},
	{#State 228
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"[" => 71,
			"%{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 292,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 229
		ACTIONS => {
			")" => 293
		}
	},
	{#State 230
		DEFAULT => -84
	},
	{#State 231
		DEFAULT => -88
	},
	{#State 232
		ACTIONS => {
			";" => 294
		}
	},
	{#State 233
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 295,
			";" => 296
		}
	},
	{#State 234
		ACTIONS => {
			")" => 297
		}
	},
	{#State 235
		DEFAULT => -118
	},
	{#State 236
		DEFAULT => -97
	},
	{#State 237
		DEFAULT => -147
	},
	{#State 238
		DEFAULT => -197
	},
	{#State 239
		DEFAULT => -198
	},
	{#State 240
		ACTIONS => {
			"(" => 298
		}
	},
	{#State 241
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 187,
			";" => 299,
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP23_LOGICAL_AND' => 191,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190
		}
	},
	{#State 242
		DEFAULT => -149
	},
	{#State 243
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			";" => -148,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			'OP13_BITWISE_AND' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP18_TERNARY' => 180,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183
		}
	},
	{#State 244
		ACTIONS => {
			";" => 300
		}
	},
	{#State 245
		DEFAULT => -132
	},
	{#State 246
		ACTIONS => {
			")" => 301
		}
	},
	{#State 247
		DEFAULT => -131
	},
	{#State 248
		DEFAULT => -98
	},
	{#State 249
		ACTIONS => {
			'COLON' => 302
		}
	},
	{#State 250
		ACTIONS => {
			'OP21_LIST_COMMA' => -111,
			".." => -111,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			";" => -111,
			")" => -111,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 187,
			"}" => -111,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP23_LOGICAL_AND' => -111,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -111,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179
		}
	},
	{#State 251
		ACTIONS => {
			"]" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP14_BITWISE_OR_XOR' => 184,
			".." => -109,
			'OP21_LIST_COMMA' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			"}" => -109,
			'OP13_BITWISE_AND' => 187,
			")" => -109,
			";" => -109,
			'OP18_TERNARY' => -109,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP16_LOGICAL_OR' => -109,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP23_LOGICAL_AND' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190
		}
	},
	{#State 252
		ACTIONS => {
			'OP23_LOGICAL_AND' => -110,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => -110,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => -110,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -110,
			'OP13_BITWISE_AND' => 187,
			"}" => -110,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			")" => -110,
			";" => -110,
			'OP21_LIST_COMMA' => -110,
			".." => -110,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP14_BITWISE_OR_XOR' => 184,
			"]" => -110
		}
	},
	{#State 253
		ACTIONS => {
			'OP16_LOGICAL_OR' => -108,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP23_LOGICAL_AND' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP18_TERNARY' => -108,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -108,
			".." => -108,
			'OP13_BITWISE_AND' => 187,
			"}" => -108,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -108,
			";" => -108,
			"]" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => -108
		}
	},
	{#State 254
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP08_MATH_ADD_SUB' => 190,
			'OP15_LOGICAL_AND' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP21_LIST_COMMA' => -101,
			".." => -101,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			";" => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			"}" => -101,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 255
		ACTIONS => {
			'OP21_LIST_COMMA' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			".." => -107,
			"}" => -107,
			'OP13_BITWISE_AND' => -107,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -107,
			";" => -107,
			"]" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP17_LIST_RANGE' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP18_TERNARY' => -107,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188
		}
	},
	{#State 256
		ACTIONS => {
			"}" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP08_STRING_CAT' => -95,
			")" => -95,
			";" => -95,
			".." => -95,
			'OP21_LIST_COMMA' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"]" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -95
		}
	},
	{#State 257
		ACTIONS => {
			"]" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			".." => -102,
			"}" => -102,
			'OP13_BITWISE_AND' => -102,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => -102,
			")" => -102,
			";" => -102,
			'OP18_TERNARY' => -102,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP16_LOGICAL_OR' => -102,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => -102
		}
	},
	{#State 258
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100,
			";" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			".." => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"]" => -100
		}
	},
	{#State 259
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP23_LOGICAL_AND' => -114,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => 180,
			";" => -114,
			")" => -114,
			"}" => -114,
			'OP13_BITWISE_AND' => 187,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -114,
			".." => -114,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => -114,
			"]" => -114
		}
	},
	{#State 260
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -106,
			".." => -106,
			";" => -106,
			")" => -106,
			'OP13_BITWISE_AND' => -106,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP16_LOGICAL_OR' => -106,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP15_LOGICAL_AND' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP18_TERNARY' => -106,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188
		}
	},
	{#State 261
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP15_LOGICAL_AND' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			"]" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -115,
			".." => -115,
			'OP13_BITWISE_AND' => 187,
			"}" => -115,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => -115,
			";" => -115
		}
	},
	{#State 262
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			"]" => -105,
			"}" => -105,
			'OP13_BITWISE_AND' => -105,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -105,
			";" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -105,
			".." => -105,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105
		}
	},
	{#State 263
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			"]" => -99,
			";" => -99,
			")" => -99,
			'OP13_BITWISE_AND' => -99,
			"}" => -99,
			'OP08_STRING_CAT' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP21_LIST_COMMA' => -99,
			".." => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP16_LOGICAL_OR' => -99
		}
	},
	{#State 264
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 303
		}
	},
	{#State 265
		DEFAULT => -41
	},
	{#State 266
		ACTIONS => {
			'WORD' => 305
		}
	},
	{#State 267
		ACTIONS => {
			'VARIABLE_SYMBOL' => 306
		}
	},
	{#State 268
		ACTIONS => {
			'WORD' => 77,
			'OP01_NAMED_VOID' => 76,
			'OP01_NAMED_VOID_PAREN' => 73,
			"[" => 71,
			"%{" => 70,
			"my" => 93,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP01_PRINT_VOID' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			"{" => 78,
			"while (" => -152,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"}" => 307,
			'OP01_PRINT_VOID_PAREN' => 94,
			"foreach my" => -152,
			"if (" => 114,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			"for my integer" => -152,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 107,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Literal' => 115,
			'OperatorVoid' => 92,
			'HashReference' => 91,
			'Expression' => 113,
			'Statement' => 89,
			'Operation' => 308,
			'OPTIONAL-44' => 84,
			'Operator' => 108,
			'WordScoped' => 106,
			'LoopLabel' => 82,
			'Variable' => 104,
			'Conditional' => 105,
			'VariableDeclaration' => 102,
			'PAREN-43' => 100,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'VariableModification' => 74
		}
	},
	{#State 269
		DEFAULT => -45
	},
	{#State 270
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our" => -58,
			"our %properties_class = (" => 311
		},
		GOTOS => {
			'OPTIONAL-23' => 310,
			'PropertiesClass' => 309
		}
	},
	{#State 271
		DEFAULT => -55
	},
	{#State 272
		ACTIONS => {
			")" => 312,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 313
		}
	},
	{#State 273
		ACTIONS => {
			'WORD' => 315,
			")" => 314
		}
	},
	{#State 274
		DEFAULT => -188
	},
	{#State 275
		DEFAULT => -185
	},
	{#State 276
		ACTIONS => {
			"\@{" => 101,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			"my" => 119,
			"[" => 71,
			"%{" => 70,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108,
			'Literal' => 115,
			'ArrayReference' => 75,
			'ListElement' => 316,
			'TypeInner' => 130,
			'HashReference' => 91,
			'Expression' => 129,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98
		}
	},
	{#State 277
		DEFAULT => -126
	},
	{#State 278
		DEFAULT => -206
	},
	{#State 279
		ACTIONS => {
			"%{" => 70,
			'WORD' => 142
		},
		GOTOS => {
			'HashDereferenced' => 140,
			'HashEntry' => 317
		}
	},
	{#State 280
		DEFAULT => -208
	},
	{#State 281
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 107,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'WORD' => 23,
			"%{" => 70,
			"[" => 71
		},
		GOTOS => {
			'WordScoped' => 106,
			'Variable' => 126,
			'Operator' => 108,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 318,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98
		}
	},
	{#State 282
		DEFAULT => -199
	},
	{#State 283
		ACTIONS => {
			";" => 319
		}
	},
	{#State 284
		DEFAULT => -217
	},
	{#State 285
		DEFAULT => -218
	},
	{#State 286
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"[" => 71,
			"%{" => 70,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"{" => 78,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 320,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 287
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 288
		ACTIONS => {
			"(" => 322
		}
	},
	{#State 289
		DEFAULT => -130
	},
	{#State 290
		ACTIONS => {
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP18_TERNARY' => 180,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP15_LOGICAL_AND' => 182,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			"}" => 323,
			'OP13_BITWISE_AND' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 195
		}
	},
	{#State 291
		ACTIONS => {
			"(" => -211,
			"}" => 324
		}
	},
	{#State 292
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP23_LOGICAL_AND' => 191,
			"]" => 325,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			'OP13_BITWISE_AND' => 187
		}
	},
	{#State 293
		DEFAULT => -90
	},
	{#State 294
		DEFAULT => -92
	},
	{#State 295
		ACTIONS => {
			'OP01_NAMED' => 88,
			"<STDIN>" => 242,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"%{" => 70,
			"[" => 71,
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ExpressionOrStdin' => 326,
			'ArrayDereferenced' => 99,
			'Expression' => 243,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106
		}
	},
	{#State 296
		DEFAULT => -180
	},
	{#State 297
		ACTIONS => {
			";" => 327
		}
	},
	{#State 298
		ACTIONS => {
			"%{" => 70,
			"[" => 71,
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			")" => -135,
			"(" => 97,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_QW' => 128,
			"{" => 78,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			"my" => 119,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 106,
			'ListElements' => 328,
			'Operator' => 108,
			'OPTIONAL-42' => 329,
			'TypeInner' => 130,
			'HashReference' => 91,
			'Expression' => 129,
			'Literal' => 115,
			'ArrayReference' => 75,
			'ListElement' => 131,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 299
		DEFAULT => -183
	},
	{#State 300
		DEFAULT => -182
	},
	{#State 301
		DEFAULT => -145
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 330
		}
	},
	{#State 303
		DEFAULT => -160,
		GOTOS => {
			'STAR-46' => 331
		}
	},
	{#State 304
		ACTIONS => {
			"if (" => 114,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			"my" => 93,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			"for my integer" => -152,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP01_PRINT_VOID' => 86,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"while (" => -152,
			'WORD' => 77,
			'OP01_NAMED_VOID' => 76,
			'OP01_NAMED_VOID_PAREN' => 73,
			"[" => 71,
			"%{" => 70,
			"foreach my" => -152,
			'OP01_PRINT_VOID_PAREN' => 94
		},
		GOTOS => {
			'ArrayReference' => 75,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'VariableModification' => 74,
			'OperatorVoid' => 92,
			'Literal' => 115,
			'HashReference' => 91,
			'Expression' => 113,
			'LoopLabel' => 82,
			'PLUS-49' => 332,
			'WordScoped' => 106,
			'PAREN-43' => 100,
			'VariableDeclaration' => 102,
			'Variable' => 104,
			'Conditional' => 105,
			'Statement' => 89,
			'Operation' => 333,
			'Operator' => 108,
			'OPTIONAL-44' => 84
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
		ACTIONS => {
			";" => 336
		}
	},
	{#State 308
		DEFAULT => -44
	},
	{#State 309
		DEFAULT => -57
	},
	{#State 310
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 337
		}
	},
	{#State 311
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 338
		}
	},
	{#State 312
		ACTIONS => {
			";" => 339
		}
	},
	{#State 313
		ACTIONS => {
			'WORD' => 341,
			"%{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 342,
			'HashEntryTyped' => 340
		}
	},
	{#State 314
		DEFAULT => -190
	},
	{#State 315
		DEFAULT => -187
	},
	{#State 316
		DEFAULT => -184
	},
	{#State 317
		DEFAULT => -205
	},
	{#State 318
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -201,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 187,
			"}" => -201,
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP23_LOGICAL_AND' => 191,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190
		}
	},
	{#State 319
		DEFAULT => -91
	},
	{#State 320
		ACTIONS => {
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP18_TERNARY' => 180,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 187,
			".." => 343,
			'OP07_MATH_MULT_DIV_MOD' => 195
		}
	},
	{#State 321
		DEFAULT => -170
	},
	{#State 322
		ACTIONS => {
			'WORD' => 23,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			"[" => 71,
			"%{" => 70,
			"my" => 119,
			'KEYS_OR_VALUES' => 133,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			'VARIABLE_SYMBOL' => 87,
			'OP05_LOGICAL_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 107,
			'OP01_QW' => 128,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'Literal' => 115,
			'ListElement' => 131,
			'TypeInner' => 130,
			'Expression' => 129,
			'HashReference' => 91,
			'Operator' => 108,
			'WordScoped' => 106,
			'ListElements' => 344,
			'Variable' => 126
		}
	},
	{#State 323
		DEFAULT => -178
	},
	{#State 324
		DEFAULT => -179
	},
	{#State 325
		DEFAULT => -177
	},
	{#State 326
		ACTIONS => {
			";" => 345
		}
	},
	{#State 327
		DEFAULT => -127
	},
	{#State 328
		DEFAULT => -134
	},
	{#State 329
		ACTIONS => {
			")" => 346
		}
	},
	{#State 330
		DEFAULT => -112
	},
	{#State 331
		ACTIONS => {
			"if (" => -163,
			"\@{" => -163,
			'OP10_NAMED_UNARY' => -163,
			"undef" => -163,
			'OP10_NAMED_UNARY_STRINGIFY' => -163,
			"for my integer" => -163,
			'LITERAL_STRING' => -163,
			'OP19_LOOP_CONTROL' => -163,
			"}" => -163,
			'OP05_MATH_NEG' => -163,
			"(" => -163,
			"while (" => -163,
			"foreach my" => -163,
			'OP01_PRINT_VOID_PAREN' => -163,
			'' => -163,
			'OP01_OPEN_CLOSE' => -163,
			'WORD_SCOPED' => -163,
			"my" => -163,
			"{" => -163,
			'OP01_OPEN_CLOSE_PAREN' => -163,
			'LITERAL_NUMBER' => -163,
			'OP22_LOGICAL_NOT' => -163,
			"else" => 349,
			'OP03_MATH_INC_DEC' => -163,
			'OP01_PRINT_VOID' => -163,
			'OP05_LOGICAL_NEG' => -163,
			"elsif (" => 348,
			'VARIABLE_SYMBOL' => -163,
			'OP01_NAMED' => -163,
			'OP01_NAMED_VOID' => -163,
			'WORD' => -163,
			"%{" => -163,
			"[" => -163,
			'OP01_NAMED_VOID_PAREN' => -163
		},
		GOTOS => {
			'PAREN-45' => 347,
			'OPTIONAL-48' => 351,
			'PAREN-47' => 350
		}
	},
	{#State 332
		ACTIONS => {
			'OP01_PRINT_VOID_PAREN' => 94,
			"foreach my" => -152,
			"while (" => -152,
			"}" => 353,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"for my integer" => -152,
			'OP19_LOOP_CONTROL' => 111,
			'LITERAL_STRING' => 112,
			'OP10_NAMED_UNARY' => 103,
			"\@{" => 101,
			"if (" => 114,
			"[" => 71,
			"%{" => 70,
			'OP01_NAMED_VOID_PAREN' => 73,
			'OP01_NAMED_VOID' => 76,
			'WORD' => 77,
			'OP01_PRINT_VOID' => 86,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_LOGICAL_NEG' => 83,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			"my" => 93,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Literal' => 115,
			'OperatorVoid' => 92,
			'HashReference' => 91,
			'Expression' => 113,
			'Statement' => 89,
			'Operator' => 108,
			'Operation' => 352,
			'OPTIONAL-44' => 84,
			'WordScoped' => 106,
			'LoopLabel' => 82,
			'Conditional' => 105,
			'Variable' => 104,
			'VariableDeclaration' => 102,
			'PAREN-43' => 100,
			'ArrayDereferenced' => 99,
			'HashDereferenced' => 98,
			'ArrayReference' => 75,
			'VariableModification' => 74
		}
	},
	{#State 333
		DEFAULT => -172
	},
	{#State 334
		DEFAULT => -216
	},
	{#State 335
		ACTIONS => {
			")" => 354,
			'OP21_LIST_COMMA' => 356
		},
		GOTOS => {
			'PAREN-18' => 355
		}
	},
	{#State 336
		DEFAULT => -46
	},
	{#State 337
		ACTIONS => {
			'LITERAL_NUMBER' => 357,
			"our" => 359
		},
		GOTOS => {
			'Subroutine' => 358,
			'MethodOrSubroutine' => 361,
			'Method' => 360
		}
	},
	{#State 338
		ACTIONS => {
			"%{" => 70,
			'WORD' => 341
		},
		GOTOS => {
			'HashDereferenced' => 342,
			'HashEntryTyped' => 362
		}
	},
	{#State 339
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 363
		}
	},
	{#State 340
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 364
		}
	},
	{#State 341
		ACTIONS => {
			'OP20_HASH_FATARROW' => 365
		}
	},
	{#State 342
		DEFAULT => -204
	},
	{#State 343
		ACTIONS => {
			"[" => 71,
			"%{" => 70,
			"(" => 97,
			'OP05_MATH_NEG' => 95,
			'WORD' => 23,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"undef" => 107,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108,
			'HashReference' => 91,
			'Expression' => 366,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 344
		ACTIONS => {
			")" => 367
		}
	},
	{#State 345
		DEFAULT => -181
	},
	{#State 346
		DEFAULT => -146
	},
	{#State 347
		DEFAULT => -159
	},
	{#State 348
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP01_NAMED' => 88,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_NUMBER' => 80,
			'OP22_LOGICAL_NOT' => 79,
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"[" => 71,
			"%{" => 70
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 106,
			'Operator' => 108,
			'Expression' => 368,
			'HashReference' => 91,
			'ArrayReference' => 75,
			'Literal' => 115,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99
		}
	},
	{#State 349
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 350
		DEFAULT => -162
	},
	{#State 351
		DEFAULT => -164
	},
	{#State 352
		DEFAULT => -171
	},
	{#State 353
		DEFAULT => -173
	},
	{#State 354
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 370
		}
	},
	{#State 355
		DEFAULT => -48
	},
	{#State 356
		ACTIONS => {
			"my" => 371
		}
	},
	{#State 357
		ACTIONS => {
			";" => 372
		}
	},
	{#State 358
		DEFAULT => -81
	},
	{#State 359
		ACTIONS => {
			'WORD' => 373
		},
		GOTOS => {
			'TypeMethod' => 374,
			'Type' => 56
		}
	},
	{#State 360
		DEFAULT => -80
	},
	{#State 361
		DEFAULT => -59
	},
	{#State 362
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 375
		}
	},
	{#State 363
		DEFAULT => -66
	},
	{#State 364
		ACTIONS => {
			'OP21_LIST_COMMA' => 378,
			")" => 376
		},
		GOTOS => {
			'PAREN-25' => 377
		}
	},
	{#State 365
		ACTIONS => {
			"my" => 119
		},
		GOTOS => {
			'TypeInner' => 379
		}
	},
	{#State 366
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP16_LOGICAL_OR' => 183,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP23_LOGICAL_AND' => 191,
			'OP15_LOGICAL_AND' => 182,
			'OP17_LIST_RANGE' => 181,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 380,
			'OP13_BITWISE_AND' => 187,
			'OP08_STRING_CAT' => 186,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 367
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 368
		ACTIONS => {
			'OP13_BITWISE_AND' => 187,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			")" => 382,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP23_LOGICAL_AND' => 191,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 189,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP06_REGEX_MATCH' => 179,
			'OP04_MATH_POW' => 188,
			'OP18_TERNARY' => 180
		}
	},
	{#State 369
		DEFAULT => -161
	},
	{#State 370
		ACTIONS => {
			"\@_;" => 383
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 384
		}
	},
	{#State 372
		DEFAULT => -61
	},
	{#State 373
		ACTIONS => {
			'VARIABLE_SYMBOL' => -214,
			"__method" => 385
		}
	},
	{#State 374
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 375
		ACTIONS => {
			")" => 387,
			'OP21_LIST_COMMA' => 389
		},
		GOTOS => {
			'PAREN-27' => 388
		}
	},
	{#State 376
		ACTIONS => {
			";" => 390
		}
	},
	{#State 377
		DEFAULT => -63
	},
	{#State 378
		ACTIONS => {
			'WORD' => 341,
			"%{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 342,
			'HashEntryTyped' => 391
		}
	},
	{#State 379
		ACTIONS => {
			"[" => 71,
			"%{" => 70,
			'WORD' => 23,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88,
			'LITERAL_STRING' => 112,
			"undef" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 90
		},
		GOTOS => {
			'Operator' => 108,
			'Variable' => 126,
			'WordScoped' => 106,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'HashReference' => 91,
			'Expression' => 392,
			'ArrayReference' => 75,
			'Literal' => 115
		}
	},
	{#State 380
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 393
		}
	},
	{#State 381
		DEFAULT => -169
	},
	{#State 382
		ACTIONS => {
			"{" => 304
		},
		GOTOS => {
			'CodeBlock' => 394
		}
	},
	{#State 383
		DEFAULT => -50
	},
	{#State 384
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 385
		DEFAULT => -215
	},
	{#State 386
		ACTIONS => {
			"= sub {" => 396
		}
	},
	{#State 387
		ACTIONS => {
			";" => 397
		}
	},
	{#State 388
		DEFAULT => -68
	},
	{#State 389
		ACTIONS => {
			'WORD' => 341,
			"%{" => 70
		},
		GOTOS => {
			'HashEntryTyped' => 398,
			'HashDereferenced' => 342
		}
	},
	{#State 390
		DEFAULT => -65
	},
	{#State 391
		DEFAULT => -62
	},
	{#State 392
		ACTIONS => {
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 192,
			'OP23_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 181,
			'OP15_LOGICAL_AND' => 182,
			'OP09_BITWISE_SHIFT' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP18_TERNARY' => 180,
			'OP04_MATH_POW' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP21_LIST_COMMA' => -203,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_STRING_CAT' => 186,
			'OP13_BITWISE_AND' => 187,
			")" => -203,
			'OP24_LOGICAL_OR_XOR' => 193,
			'OP14_BITWISE_OR_XOR' => 184
		}
	},
	{#State 393
		DEFAULT => -168
	},
	{#State 394
		DEFAULT => -158
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		ACTIONS => {
			'OP05_MATH_NEG' => -72,
			"( my" => 399,
			"(" => -72,
			"while (" => -72,
			"foreach my" => -72,
			'OP01_PRINT_VOID_PAREN' => -72,
			"if (" => -72,
			"\@{" => -72,
			'OP10_NAMED_UNARY' => -72,
			"for my integer" => -72,
			'LITERAL_STRING' => -72,
			'OP19_LOOP_CONTROL' => -72,
			"undef" => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'WORD' => -72,
			'OP01_NAMED_VOID' => -72,
			'OP01_NAMED_VOID_PAREN' => -72,
			"%{" => -72,
			"[" => -72,
			'WORD_SCOPED' => -72,
			'OP01_OPEN_CLOSE' => -72,
			"my" => -72,
			"{" => -72,
			'LITERAL_NUMBER' => -72,
			'OP01_OPEN_CLOSE_PAREN' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP01_NAMED' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP03_MATH_INC_DEC' => -72
		},
		GOTOS => {
			'MethodArguments' => 400,
			'OPTIONAL-29' => 401
		}
	},
	{#State 397
		DEFAULT => -70
	},
	{#State 398
		DEFAULT => -67
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
			'OP01_OPEN_CLOSE' => 90,
			"if (" => 114,
			'WORD_SCOPED' => 22,
			"my" => 93,
			'OP10_NAMED_UNARY' => 103,
			"{" => 78,
			"\@{" => 101,
			'LITERAL_NUMBER' => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_LOGICAL_NEG' => 83,
			'OP01_PRINT_VOID' => 86,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -152,
			'VARIABLE_SYMBOL' => 87,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED' => 88,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			'OP01_NAMED_VOID' => 76,
			"while (" => -152,
			'WORD' => 77,
			"[" => 71,
			"%{" => 70,
			'OP01_NAMED_VOID_PAREN' => 73,
			'OP01_PRINT_VOID_PAREN' => 94,
			"foreach my" => -152
		},
		GOTOS => {
			'Expression' => 113,
			'HashReference' => 91,
			'OperatorVoid' => 92,
			'Literal' => 115,
			'VariableDeclaration' => 102,
			'PAREN-43' => 100,
			'Variable' => 104,
			'Conditional' => 105,
			'LoopLabel' => 82,
			'WordScoped' => 106,
			'Operation' => 404,
			'OPTIONAL-44' => 84,
			'Operator' => 108,
			'Statement' => 89,
			'PLUS-30' => 403,
			'ArrayReference' => 75,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'VariableModification' => 74
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
			"}" => 407,
			'OP05_MATH_NEG' => 95,
			"(" => 97,
			"while (" => -152,
			"foreach my" => -152,
			'OP01_PRINT_VOID_PAREN' => 94,
			"if (" => 114,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 103,
			"undef" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"for my integer" => -152,
			'LITERAL_STRING' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED_VOID' => 76,
			'WORD' => 77,
			"[" => 71,
			"%{" => 70,
			'OP01_NAMED_VOID_PAREN' => 73,
			'OP01_OPEN_CLOSE' => 90,
			'WORD_SCOPED' => 22,
			"my" => 93,
			"{" => 78,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_NUMBER' => 80,
			'OP01_PRINT_VOID' => 86,
			'OP05_LOGICAL_NEG' => 83,
			'OP03_MATH_INC_DEC' => 85,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 88
		},
		GOTOS => {
			'Operator' => 108,
			'Operation' => 406,
			'OPTIONAL-44' => 84,
			'Statement' => 89,
			'Variable' => 104,
			'Conditional' => 105,
			'PAREN-43' => 100,
			'VariableDeclaration' => 102,
			'WordScoped' => 106,
			'LoopLabel' => 82,
			'Expression' => 113,
			'HashReference' => 91,
			'Literal' => 115,
			'OperatorVoid' => 92,
			'VariableModification' => 74,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 99,
			'ArrayReference' => 75
		}
	},
	{#State 404
		DEFAULT => -74
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 410,
			")" => 409
		},
		GOTOS => {
			'PAREN-31' => 408
		}
	},
	{#State 406
		DEFAULT => -73
	},
	{#State 407
		ACTIONS => {
			";" => 411
		}
	},
	{#State 408
		DEFAULT => -77
	},
	{#State 409
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 410
		ACTIONS => {
			"my" => 413
		}
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
			'WORD' => 57
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
#line 5603 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5610 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5617 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5624 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5646 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5653 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5660 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5667 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5674 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5681 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5688 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5695 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5702 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5709 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5716 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5723 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5730 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5748 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5755 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5830 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5837 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5844 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5984 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5991 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6236 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6280 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6287 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6597 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6608 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6643 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6671 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_148
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_149
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 4,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7023 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7030 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7276 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_190
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_197
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_198
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_203
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_204
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7443 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_209
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_210
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule TypeMethod_215
		 'TypeMethod', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_216
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_217
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_218
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	]
],
#line 7610 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Operator_114', 
         'Operator_115', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_126', 
         'OperatorVoid_127', 
         'OperatorVoid_128', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         'OperatorVoid_131', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_136', 
         'Expression_137', 
         'Expression_138', 
         'Expression_139', 
         'Expression_140', 
         'Expression_141', 
         'Expression_142', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'ExpressionOrStdin_148', 
         'ExpressionOrStdin_149', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         'Statement_157', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_164', 
         'Loop_165', 
         'Loop_166', 
         'Loop_167', 
         'LoopFor_168', 
         'LoopForEach_169', 
         'LoopWhile_170', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_173', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_176', 
         'VariableRetrieval_177', 
         'VariableRetrieval_178', 
         'VariableRetrieval_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableModification_182', 
         'VariableModification_183', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_189', 
         'ListElements_190', 
         'ListElement_191', 
         'ListElement_192', 
         'ListElement_193', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_196', 
         'ArrayDereferenced_197', 
         'ArrayDereferenced_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_201', 
         'HashEntry_202', 
         'HashEntryTyped_203', 
         'HashEntryTyped_204', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_208', 
         'HashDereferenced_209', 
         'HashDereferenced_210', 
         'WordScoped_211', 
         'WordScoped_212', 
         'LoopLabel_213', 
         'Type_214', 
         'TypeMethod_215', 
         'TypeInner_216', 
         'FileHandle_217', 
         'FileHandle_218', 
         'Literal_219', 
         'Literal_220', );
  $self;
}

#line 182 "lib/RPerl/Grammar.eyp"


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


#line 7879 lib/RPerl/Grammar.pm



1;
