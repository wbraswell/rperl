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
    our $VERSION = 0.000_800;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|__method|package|\<STDIN\>|elsif\ \(|\=\ sub\ \{|\$TYPED_|while\ \(|undef|else|\(\ my|if\ \(|use|qw\(|\@_\;|our|\@\{|\{\*|\.\.|my|\%\{|\)|\}|\(|\{|\[|\;|\]|\/)}gc and return ($1, $1);

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
  [ 'Operator_98' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
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
	'/' => { ISSEMANTIC => 0 },
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
			"## no critic qw(" => 4,
			"package" => -20,
			'SHEBANG' => 3
		},
		GOTOS => {
			'CompileUnit' => 6,
			'Critic' => 5,
			'PLUS-2' => 9,
			'Program' => 1,
			'OPTIONAL-9' => 7,
			'ModuleHeader' => 8,
			'PAREN-1' => 2
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 10,
			'OPTIONAL-3' => 11
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 12
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
			'' => 14
		}
	},
	{#State 7
		ACTIONS => {
			"package" => 15
		}
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => -25,
			"use parent qw(" => 17,
			"our" => -25,
			"use constant" => -25,
			"use" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Package' => 20,
			'Class' => 18,
			'STAR-10' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 4,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'ModuleHeader' => 8,
			'OPTIONAL-9' => 7,
			'PAREN-1' => 21,
			'Critic' => 5
		}
	},
	{#State 10
		DEFAULT => -6
	},
	{#State 11
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 12
		DEFAULT => -35
	},
	{#State 13
		ACTIONS => {
			")" => 25,
			'WORD' => 24
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		DEFAULT => -23
	},
	{#State 19
		ACTIONS => {
			"## no critic qw(" => 4,
			"use" => -27,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 31,
			'Critic' => 30
		}
	},
	{#State 20
		DEFAULT => -22
	},
	{#State 21
		DEFAULT => -2
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
		ACTIONS => {
			";" => 34
		}
	},
	{#State 27
		DEFAULT => -211
	},
	{#State 28
		DEFAULT => -212
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
			"use" => 37,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'Include' => 38,
			'STAR-12' => 36
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"our" => -11,
			'OP05_MATH_NEG' => -11,
			"my" => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			"undef" => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			"if (" => -11,
			'VARIABLE_SYMBOL' => -11,
			"%{" => -11,
			'LITERAL_STRING' => -11,
			"foreach my" => -11,
			'OP01_PRINT_VOID' => -11,
			"(" => -11,
			"while (" => -11,
			"{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_OPEN_CLOSE' => -11,
			"[" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"use" => -11,
			'OP10_NAMED_UNARY' => -11,
			"for my integer" => -11,
			'OP01_NAMED_VOID' => -11,
			"\@{" => -11,
			"use constant" => -11,
			'LITERAL_NUMBER' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 4,
			'WORD' => -11,
			'OP03_MATH_INC_DEC' => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 40
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 48,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 45,
			'PLUS-13' => 44,
			'Constant' => 46
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 49
		}
	},
	{#State 38
		DEFAULT => -26
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_NAMED_VOID' => -13,
			"\@{" => -13,
			"use constant" => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'WORD' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN_CLOSE' => -13,
			"[" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"use" => 37,
			'OP10_NAMED_UNARY' => -13,
			"for my integer" => -13,
			'LITERAL_STRING' => -13,
			'OP01_PRINT_VOID' => -13,
			"foreach my" => -13,
			"(" => -13,
			"while (" => -13,
			"{" => -13,
			"our" => -13,
			"my" => -13,
			'OP05_MATH_NEG' => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			'OP01_NAMED' => -13,
			"undef" => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'OP22_LOGICAL_NOT' => -13,
			"if (" => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"%{" => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		DEFAULT => -21
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
			"our" => 47,
			'LITERAL_NUMBER' => 55
		},
		GOTOS => {
			'Subroutine' => 54
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		DEFAULT => -28
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
			'WORD' => 58
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
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			"if (" => -15,
			"%{" => -15,
			'OP05_MATH_NEG' => -15,
			"my" => -15,
			"our" => -15,
			'OP01_NAMED' => -15,
			"undef" => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			"(" => -15,
			"{" => -15,
			"while (" => -15,
			'LITERAL_STRING' => -15,
			'OP01_PRINT_VOID' => -15,
			"foreach my" => -15,
			"for my integer" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_OPEN_CLOSE' => -15,
			"[" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD' => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15,
			"use constant" => 48,
			'OP01_NAMED_VOID' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 62,
			'Constant' => 63
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
		DEFAULT => -30
	},
	{#State 55
		ACTIONS => {
			";" => 65
		}
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 57
		DEFAULT => -214
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
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
		DEFAULT => -33
	},
	{#State 62
		ACTIONS => {
			"(" => 79,
			"{" => 74,
			"while (" => -152,
			'LITERAL_STRING' => 73,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			'OP01_PRINT_VOID_PAREN' => 95,
			"if (" => 93,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 88,
			'OP05_MATH_NEG' => 86,
			"my" => 85,
			"our" => 47,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_NAMED_VOID_PAREN' => 84,
			'WORD_SCOPED' => 28,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 109,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'OP01_NAMED_VOID' => 102,
			'OP05_LOGICAL_NEG' => 100,
			"for my integer" => -152,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN_CLOSE' => 112,
			'OP19_LOOP_CONTROL' => 113,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110
		},
		GOTOS => {
			'Statement' => 99,
			'Variable' => 98,
			'Subroutine' => 71,
			'OperatorVoid' => 70,
			'HashDereferenced' => 106,
			'LoopLabel' => 76,
			'VariableDeclaration' => 105,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashReference' => 78,
			'Literal' => 77,
			'PLUS-8' => 108,
			'VariableModification' => 80,
			'OPTIONAL-44' => 87,
			'ArrayReference' => 114,
			'Operator' => 90,
			'Conditional' => 91,
			'PAREN-43' => 89,
			'Expression' => 94,
			'Operation' => 97
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"our %properties = (" => -54,
			"## no critic qw(" => 4,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 116,
			'STAR-21' => 117
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 118
		}
	},
	{#State 67
		ACTIONS => {
			"my" => 119
		},
		GOTOS => {
			'TypeInner' => 120
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			'WORD' => 122,
			")" => 121
		}
	},
	{#State 70
		DEFAULT => -155
	},
	{#State 71
		DEFAULT => -14
	},
	{#State 72
		ACTIONS => {
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP01_OPEN_CLOSE' => 112,
			"my" => 123,
			'OP05_MATH_NEG' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP01_QW' => 124,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			";" => -123,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			"{*" => 127,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'ListElements' => 131,
			'Expression' => 126,
			'Literal' => 77,
			'HashReference' => 78,
			'ListElement' => 128,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'TypeInner' => 133,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayReference' => 114,
			'FileHandle' => 129,
			'OPTIONAL-39' => 130,
			'Variable' => 132
		}
	},
	{#State 73
		DEFAULT => -219
	},
	{#State 74
		ACTIONS => {
			'WORD' => 137,
			"%{" => 88,
			"}" => 134
		},
		GOTOS => {
			'HashDereferenced' => 135,
			'HashEntry' => 136
		}
	},
	{#State 75
		DEFAULT => -140
	},
	{#State 76
		ACTIONS => {
			'COLON' => 138
		}
	},
	{#State 77
		DEFAULT => -137
	},
	{#State 78
		DEFAULT => -141
	},
	{#State 79
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 139,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 80
		DEFAULT => -157
	},
	{#State 81
		ACTIONS => {
			"my" => 141,
			"{*" => 127
		},
		GOTOS => {
			'FileHandle' => 140
		}
	},
	{#State 82
		DEFAULT => -136
	},
	{#State 83
		ACTIONS => {
			"(" => 142
		}
	},
	{#State 84
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			'OP01_QW' => 124,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"my" => 119,
			'OP10_NAMED_UNARY' => 115,
			")" => -117,
			"%{" => 88,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'OPTIONAL-36' => 143,
			'ListElement' => 128,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 126,
			'ListElements' => 144,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75
		}
	},
	{#State 85
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 145
		}
	},
	{#State 86
		ACTIONS => {
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayReference' => 114,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Literal' => 77,
			'Expression' => 146,
			'HashReference' => 78
		}
	},
	{#State 87
		ACTIONS => {
			"for my integer" => 153,
			"while (" => 150,
			"foreach my" => 147
		},
		GOTOS => {
			'Loop' => 149,
			'LoopFor' => 152,
			'LoopWhile' => 151,
			'LoopForEach' => 148
		}
	},
	{#State 88
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			"{" => 154
		},
		GOTOS => {
			'Variable' => 156,
			'HashReference' => 155
		}
	},
	{#State 89
		DEFAULT => -151
	},
	{#State 90
		DEFAULT => -144
	},
	{#State 91
		DEFAULT => -153
	},
	{#State 92
		DEFAULT => -175,
		GOTOS => {
			'STAR-50' => 157
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashReference' => 78,
			'Expression' => 158,
			'Literal' => 77,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 94
		ACTIONS => {
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP04_MATH_POW' => 166,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			";" => 160,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 95
		ACTIONS => {
			"{*" => 127,
			"my" => 141
		},
		GOTOS => {
			'FileHandle' => 176
		}
	},
	{#State 96
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101
		},
		GOTOS => {
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 177,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 97
		DEFAULT => -17
	},
	{#State 98
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 178,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP08_STRING_CAT' => -138,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP04_MATH_POW' => -138,
			'OP18_TERNARY' => -138,
			'OP17_LIST_RANGE' => -138,
			";" => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP03_MATH_INC_DEC' => 179,
			'OP16_LOGICAL_OR' => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP19_VARIABLE_ASSIGN' => 181,
			'OP02_METHOD_THINARROW' => 180,
			'OP11_COMPARE_LT_GT' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP13_BITWISE_AND' => -138
		}
	},
	{#State 99
		DEFAULT => -83
	},
	{#State 100
		ACTIONS => {
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"{" => 74
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashReference' => 78,
			'Expression' => 182,
			'Literal' => 77,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 101
		DEFAULT => -220
	},
	{#State 102
		ACTIONS => {
			"my" => 119,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			'OP01_NAMED' => 83,
			"undef" => 82,
			";" => -121,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_QW' => 124,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'TypeInner' => 133,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ListElements' => 184,
			'Expression' => 126,
			'Literal' => 77,
			'HashReference' => 78,
			'ListElement' => 128,
			'Variable' => 132,
			'OPTIONAL-38' => 183,
			'ArrayReference' => 114
		}
	},
	{#State 103
		ACTIONS => {
			"[" => 111,
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'ArrayReference' => 186,
			'Variable' => 185
		}
	},
	{#State 104
		ACTIONS => {
			"(" => 187
		}
	},
	{#State 105
		DEFAULT => -156
	},
	{#State 106
		DEFAULT => -142
	},
	{#State 107
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'Variable' => 188
		}
	},
	{#State 108
		ACTIONS => {
			'' => -18,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP10_NAMED_UNARY' => 115,
			"for my integer" => -152,
			'OP01_NAMED_VOID' => 102,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 109,
			'OP03_MATH_INC_DEC' => 107,
			"my" => 85,
			'OP05_MATH_NEG' => 86,
			'OP01_NAMED_VOID_PAREN' => 84,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_PRINT_VOID_PAREN' => 95,
			'VARIABLE_SYMBOL' => 92,
			"if (" => 93,
			"%{" => 88,
			'LITERAL_STRING' => 73,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			"(" => 79,
			"while (" => -152,
			"{" => 74
		},
		GOTOS => {
			'VariableModification' => 80,
			'OPTIONAL-44' => 87,
			'ArrayReference' => 114,
			'Conditional' => 91,
			'Operator' => 90,
			'PAREN-43' => 89,
			'Operation' => 189,
			'Expression' => 94,
			'OperatorVoid' => 70,
			'Variable' => 98,
			'Statement' => 99,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'LoopLabel' => 76,
			'HashReference' => 78,
			'Literal' => 77
		}
	},
	{#State 109
		ACTIONS => {
			"(" => -211,
			'COLON' => -213
		}
	},
	{#State 110
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'HashReference' => 78,
			'Expression' => 190,
			'Literal' => 77,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 111
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"]" => -195,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_QW' => 124,
			"my" => 119,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'ListElement' => 128,
			'HashReference' => 78,
			'Expression' => 126,
			'Literal' => 77,
			'ListElements' => 191,
			'OPTIONAL-54' => 192,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 112
		ACTIONS => {
			"{*" => 127,
			"my" => 141
		},
		GOTOS => {
			'FileHandle' => 193
		}
	},
	{#State 113
		ACTIONS => {
			'WORD' => 194
		},
		GOTOS => {
			'LoopLabel' => 195
		}
	},
	{#State 114
		DEFAULT => -139
	},
	{#State 115
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 196,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 116
		DEFAULT => -51
	},
	{#State 117
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 37,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 198,
			'Include' => 197
		}
	},
	{#State 118
		ACTIONS => {
			'LITERAL_NUMBER' => -43,
			"\@{" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'WORD' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_OPEN_CLOSE' => -43,
			"[" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"for my integer" => -43,
			'OP10_NAMED_UNARY' => -43,
			'LITERAL_STRING' => -43,
			'OP01_PRINT_VOID' => -43,
			"foreach my" => -43,
			"(" => -43,
			"{" => -43,
			"while (" => -43,
			'OP05_MATH_NEG' => -43,
			"my" => -43,
			"undef" => -43,
			'OP01_NAMED' => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			'WORD_SCOPED' => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			"( my" => 200,
			'OP22_LOGICAL_NOT' => -43,
			"if (" => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			'VARIABLE_SYMBOL' => -43,
			"%{" => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 201,
			'SubroutineArguments' => 199
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 120
		ACTIONS => {
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101
		},
		GOTOS => {
			'Literal' => 203
		}
	},
	{#State 121
		ACTIONS => {
			";" => 204
		}
	},
	{#State 122
		DEFAULT => -37
	},
	{#State 123
		ACTIONS => {
			"filehandle_ref" => 205,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 124
		ACTIONS => {
			"(" => 206
		}
	},
	{#State 125
		ACTIONS => {
			"%{" => 88
		},
		GOTOS => {
			'HashDereferenced' => 207
		}
	},
	{#State 126
		ACTIONS => {
			"]" => -191,
			'OP21_LIST_COMMA' => -191,
			")" => -191,
			'OP04_MATH_POW' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			";" => -191,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 208
		}
	},
	{#State 128
		DEFAULT => -186,
		GOTOS => {
			'STAR-52' => 209
		}
	},
	{#State 129
		ACTIONS => {
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_QW' => 124,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			";" => -125,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88
		},
		GOTOS => {
			'HashReference' => 78,
			'ListElement' => 128,
			'Literal' => 77,
			'Expression' => 126,
			'ListElements' => 211,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'ArrayReference' => 114,
			'OPTIONAL-40' => 210,
			'Variable' => 132
		}
	},
	{#State 130
		ACTIONS => {
			";" => 212
		}
	},
	{#State 131
		DEFAULT => -122
	},
	{#State 132
		ACTIONS => {
			'OP16_LOGICAL_OR' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP03_MATH_INC_DEC' => 179,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP02_METHOD_THINARROW' => 180,
			'OP13_BITWISE_AND' => -138,
			".." => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP23_LOGICAL_AND' => -138,
			")" => -138,
			"}" => -138,
			'OP21_LIST_COMMA' => -138,
			"]" => -138,
			'OP18_TERNARY' => -138,
			'OP17_LIST_RANGE' => -138,
			";" => -138,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP08_STRING_CAT' => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP04_MATH_POW' => -138
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82
		},
		GOTOS => {
			'Expression' => 213,
			'Literal' => 77,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 134
		DEFAULT => -143
	},
	{#State 135
		DEFAULT => -202
	},
	{#State 136
		DEFAULT => -207,
		GOTOS => {
			'STAR-57' => 214
		}
	},
	{#State 137
		ACTIONS => {
			'OP20_HASH_FATARROW' => 215
		}
	},
	{#State 138
		DEFAULT => -150
	},
	{#State 139
		ACTIONS => {
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			")" => 216,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP23_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161
		}
	},
	{#State 140
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_QW' => 124,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			'OP10_NAMED_UNARY' => 115,
			")" => -87,
			"%{" => 88,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayReference' => 114,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashReference' => 78,
			'ListElement' => 128,
			'OPTIONAL-34' => 217,
			'Expression' => 126,
			'Literal' => 77,
			'ListElements' => 218
		}
	},
	{#State 141
		ACTIONS => {
			"filehandle_ref" => 205
		}
	},
	{#State 142
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			")" => -85,
			"%{" => 88,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_QW' => 124,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'ListElement' => 128,
			'HashReference' => 78,
			'Expression' => 126,
			'Literal' => 77,
			'OPTIONAL-33' => 219,
			'ListElements' => 220,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 143
		ACTIONS => {
			")" => 221
		}
	},
	{#State 144
		DEFAULT => -116
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 222
		}
	},
	{#State 146
		ACTIONS => {
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			")" => 223
		}
	},
	{#State 147
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 224
		}
	},
	{#State 148
		DEFAULT => -166
	},
	{#State 149
		DEFAULT => -154
	},
	{#State 150
		ACTIONS => {
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'Literal' => 77,
			'Expression' => 225,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 151
		DEFAULT => -167
	},
	{#State 152
		DEFAULT => -165
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 226
		}
	},
	{#State 154
		ACTIONS => {
			"%{" => 88,
			'WORD' => 137
		},
		GOTOS => {
			'HashEntry' => 136,
			'HashDereferenced' => 135
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 227
		}
	},
	{#State 156
		ACTIONS => {
			"}" => 228
		}
	},
	{#State 157
		ACTIONS => {
			'OP23_LOGICAL_AND' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP02_ARRAY_THINARROW' => 231,
			'OP02_METHOD_THINARROW' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			".." => -176,
			'OP13_BITWISE_AND' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP08_STRING_CAT' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP12_COMPARE_EQ_NEQ' => -176,
			'OP04_MATH_POW' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP18_TERNARY' => -176,
			";" => -176,
			'COLON' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			")" => -176,
			"}" => -176,
			'OP02_HASH_THINARROW' => 229,
			'OP21_LIST_COMMA' => -176,
			"]" => -176
		},
		GOTOS => {
			'VariableRetrieval' => 230
		}
	},
	{#State 158
		ACTIONS => {
			")" => 232,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => 163
		}
	},
	{#State 159
		ACTIONS => {
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'HashReference' => 78,
			'Expression' => 233,
			'Literal' => 77,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75
		}
	},
	{#State 160
		DEFAULT => -82
	},
	{#State 161
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Expression' => 234,
			'Literal' => 77,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 162
		ACTIONS => {
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Literal' => 77,
			'Expression' => 235,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106
		}
	},
	{#State 163
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101
		},
		GOTOS => {
			'Literal' => 77,
			'Expression' => 236,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 164
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Literal' => 77,
			'Expression' => 237,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90
		}
	},
	{#State 165
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110
		},
		GOTOS => {
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 238,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 166
		ACTIONS => {
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayReference' => 114,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Expression' => 239,
			'Literal' => 77,
			'HashReference' => 78
		}
	},
	{#State 167
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'Literal' => 77,
			'Expression' => 240,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 168
		ACTIONS => {
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'Literal' => 77,
			'Expression' => 241,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 169
		ACTIONS => {
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"{" => 74
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Expression' => 242,
			'Literal' => 77,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90
		}
	},
	{#State 170
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'Variable' => 243
		}
	},
	{#State 171
		ACTIONS => {
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Literal' => 77,
			'Expression' => 244,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90
		}
	},
	{#State 172
		ACTIONS => {
			"/" => 245
		}
	},
	{#State 173
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Expression' => 246,
			'Literal' => 77,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashDereferenced' => 106,
			'Operator' => 90
		}
	},
	{#State 174
		ACTIONS => {
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayReference' => 114,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Literal' => 77,
			'Expression' => 247,
			'HashReference' => 78
		}
	},
	{#State 175
		ACTIONS => {
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'Expression' => 248,
			'Literal' => 77,
			'HashReference' => 78,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'Operator' => 90,
			'HashDereferenced' => 106
		}
	},
	{#State 176
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"{" => 74,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NOT' => 96,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			")" => -119,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_QW' => 124,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111
		},
		GOTOS => {
			'OPTIONAL-37' => 249,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Expression' => 126,
			'Literal' => 77,
			'ListElements' => 250,
			'ListElement' => 128,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 177
		ACTIONS => {
			'OP16_LOGICAL_OR' => 173,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			".." => -113,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			"]" => -113,
			"}" => -113,
			")" => -113,
			";" => -113,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP04_MATH_POW' => 166,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169
		}
	},
	{#State 178
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'Expression' => 251,
			'Literal' => 77,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 179
		DEFAULT => -94
	},
	{#State 180
		ACTIONS => {
			'WORD' => 252
		}
	},
	{#State 181
		ACTIONS => {
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			"<STDIN>" => 254,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'ExpressionOrStdin' => 253,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 255,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 182
		ACTIONS => {
			")" => -96,
			"}" => -96,
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP04_MATH_POW' => 166,
			'OP18_TERNARY' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			".." => -96,
			'OP13_BITWISE_AND' => -96,
			'OP09_BITWISE_SHIFT' => -96
		}
	},
	{#State 183
		ACTIONS => {
			";" => 256
		}
	},
	{#State 184
		DEFAULT => -120
	},
	{#State 185
		ACTIONS => {
			"}" => 257
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 258
		}
	},
	{#State 187
		ACTIONS => {
			"my" => 119,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_QW' => 124,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			"%{" => 88,
			")" => -133,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"{" => 74
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'TypeInner' => 133,
			'HashReference' => 78,
			'ListElement' => 128,
			'ListElements' => 259,
			'Literal' => 77,
			'Expression' => 126,
			'OPTIONAL-41' => 260,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 188
		DEFAULT => -93
	},
	{#State 189
		DEFAULT => -16
	},
	{#State 190
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => -104,
			'OP23_LOGICAL_AND' => -104,
			".." => -104,
			'OP13_BITWISE_AND' => -104,
			'OP09_BITWISE_SHIFT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => -104,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			"}" => -104,
			")" => -104,
			'OP04_MATH_POW' => 166,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP08_STRING_CAT' => 169,
			";" => -104,
			'OP17_LIST_RANGE' => -104,
			'OP18_TERNARY' => -104
		}
	},
	{#State 191
		DEFAULT => -194
	},
	{#State 192
		ACTIONS => {
			"]" => 261
		}
	},
	{#State 193
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'OP01_QW' => 124,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			";" => -89,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			'OP01_OPEN_CLOSE' => 112,
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101
		},
		GOTOS => {
			'Operator' => 90,
			'HashDereferenced' => 106,
			'TypeInner' => 133,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashReference' => 78,
			'ListElement' => 128,
			'OPTIONAL-35' => 263,
			'Literal' => 77,
			'Expression' => 126,
			'ListElements' => 262,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 194
		DEFAULT => -213
	},
	{#State 195
		ACTIONS => {
			";" => 264
		}
	},
	{#State 196
		ACTIONS => {
			'OP15_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP16_LOGICAL_OR' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => -103,
			".." => -103,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => -103,
			'OP21_LIST_COMMA' => -103,
			"]" => -103,
			"}" => -103,
			")" => -103,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			";" => -103,
			'OP18_TERNARY' => -103,
			'OP17_LIST_RANGE' => -103
		}
	},
	{#State 197
		DEFAULT => -53
	},
	{#State 198
		ACTIONS => {
			"our %properties = (" => 265,
			"use constant" => 48
		},
		GOTOS => {
			'Properties' => 267,
			'Constant' => 266
		}
	},
	{#State 199
		DEFAULT => -42
	},
	{#State 200
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 201
		ACTIONS => {
			"while (" => -152,
			"{" => 74,
			"(" => 79,
			'WORD' => 109,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			'OP01_NAMED_VOID' => 102,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			"for my integer" => -152,
			'OP01_PRINT_VOID_PAREN' => 95,
			"if (" => 93,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			'OP01_NAMED_VOID_PAREN' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"my" => 85,
			'OP19_LOOP_CONTROL' => 113
		},
		GOTOS => {
			'VariableModification' => 80,
			'OPTIONAL-44' => 87,
			'ArrayReference' => 114,
			'Operator' => 90,
			'Conditional' => 91,
			'PAREN-43' => 89,
			'Expression' => 94,
			'Operation' => 269,
			'Statement' => 99,
			'Variable' => 98,
			'OperatorVoid' => 70,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 75,
			'VariableDeclaration' => 105,
			'WordScoped' => 104,
			'LoopLabel' => 76,
			'HashReference' => 78,
			'Literal' => 77,
			'PLUS-17' => 270
		}
	},
	{#State 202
		ACTIONS => {
			"\$TYPED_" => 271
		}
	},
	{#State 203
		ACTIONS => {
			";" => 272
		}
	},
	{#State 204
		DEFAULT => -40
	},
	{#State 205
		ACTIONS => {
			'VARIABLE_SYMBOL' => 273
		}
	},
	{#State 206
		ACTIONS => {
			'WORD' => 275
		},
		GOTOS => {
			'PLUS-53' => 274
		}
	},
	{#State 207
		DEFAULT => -193
	},
	{#State 208
		ACTIONS => {
			"}" => 276
		}
	},
	{#State 209
		ACTIONS => {
			")" => -189,
			"]" => -189,
			";" => -189,
			'OP21_LIST_COMMA' => 277
		},
		GOTOS => {
			'PAREN-51' => 278
		}
	},
	{#State 210
		ACTIONS => {
			";" => 279
		}
	},
	{#State 211
		DEFAULT => -124
	},
	{#State 212
		DEFAULT => -129
	},
	{#State 213
		ACTIONS => {
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			")" => -192,
			'OP21_LIST_COMMA' => -192,
			"]" => -192,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP04_MATH_POW' => 166,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			";" => -192
		}
	},
	{#State 214
		ACTIONS => {
			"}" => 281,
			'OP21_LIST_COMMA' => 282
		},
		GOTOS => {
			'PAREN-56' => 280
		}
	},
	{#State 215
		ACTIONS => {
			'OP10_NAMED_UNARY' => -200,
			"%{" => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP22_LOGICAL_NOT' => -200,
			'WORD_SCOPED' => -200,
			"[" => -200,
			'OP10_NAMED_UNARY_STRINGIFY' => -200,
			'OP01_OPEN_CLOSE_PAREN' => -200,
			'OP01_NAMED' => -200,
			"undef" => -200,
			'OP05_MATH_NEG' => -200,
			'OP01_OPEN_CLOSE' => -200,
			"my" => 119,
			"{" => -200,
			"(" => -200,
			'WORD' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'OP05_LOGICAL_NEG' => -200,
			"\@{" => -200,
			'LITERAL_STRING' => -200,
			'LITERAL_NUMBER' => -200
		},
		GOTOS => {
			'TypeInner' => 284,
			'OPTIONAL-55' => 283
		}
	},
	{#State 216
		DEFAULT => -147
	},
	{#State 217
		ACTIONS => {
			")" => 285
		}
	},
	{#State 218
		DEFAULT => -86
	},
	{#State 219
		ACTIONS => {
			")" => 286
		}
	},
	{#State 220
		DEFAULT => -84
	},
	{#State 221
		ACTIONS => {
			";" => 287
		}
	},
	{#State 222
		ACTIONS => {
			";" => 289,
			'OP19_VARIABLE_ASSIGN' => 288
		}
	},
	{#State 223
		DEFAULT => -97
	},
	{#State 224
		ACTIONS => {
			'VARIABLE_SYMBOL' => 290
		}
	},
	{#State 225
		ACTIONS => {
			'OP16_LOGICAL_OR' => 173,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => 163,
			")" => 291,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP04_MATH_POW' => 166
		}
	},
	{#State 226
		ACTIONS => {
			"(" => 292
		}
	},
	{#State 227
		DEFAULT => -210
	},
	{#State 228
		DEFAULT => -209
	},
	{#State 229
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			"(" => 79,
			'WORD' => 293,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashReference' => 78,
			'Expression' => 294,
			'Literal' => 77,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 230
		DEFAULT => -174
	},
	{#State 231
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27
		},
		GOTOS => {
			'Expression' => 295,
			'Literal' => 77,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 232
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 297
		}
	},
	{#State 233
		ACTIONS => {
			'OP17_LIST_RANGE' => -108,
			'OP18_TERNARY' => -108,
			";" => -108,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP04_MATH_POW' => 166,
			")" => -108,
			"}" => -108,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP09_BITWISE_SHIFT' => 164,
			".." => -108,
			'OP13_BITWISE_AND' => 174,
			'OP23_LOGICAL_AND' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172
		}
	},
	{#State 234
		ACTIONS => {
			'OP16_LOGICAL_OR' => -109,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 172,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174,
			".." => -109,
			'OP23_LOGICAL_AND' => -109,
			")" => -109,
			"}" => -109,
			'OP21_LIST_COMMA' => -109,
			"]" => -109,
			'OP17_LIST_RANGE' => -109,
			'OP18_TERNARY' => -109,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP04_MATH_POW' => 166
		}
	},
	{#State 235
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			"]" => -100,
			"}" => -100,
			")" => -100,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			";" => -100,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP13_BITWISE_AND' => -100,
			".." => -100,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => -100
		}
	},
	{#State 236
		ACTIONS => {
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			";" => -114,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			")" => -114,
			"}" => -114,
			'OP21_LIST_COMMA' => -114,
			"]" => -114,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP13_BITWISE_AND' => 174,
			".." => -114,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => -114,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161
		}
	},
	{#State 237
		ACTIONS => {
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP13_BITWISE_AND' => -102,
			".." => -102,
			'OP09_BITWISE_SHIFT' => -102,
			")" => -102,
			"}" => -102,
			'OP21_LIST_COMMA' => -102,
			"]" => -102,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			'OP17_LIST_RANGE' => -102,
			'OP18_TERNARY' => -102,
			";" => -102
		}
	},
	{#State 238
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -99,
			".." => -99,
			'OP13_BITWISE_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP04_MATH_POW' => 166,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_STRING_CAT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			"]" => -99,
			'OP21_LIST_COMMA' => -99,
			"}" => -99,
			")" => -99
		}
	},
	{#State 239
		ACTIONS => {
			"]" => -95,
			'OP21_LIST_COMMA' => -95,
			"}" => -95,
			")" => -95,
			'OP04_MATH_POW' => 166,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP08_STRING_CAT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			";" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			".." => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95
		}
	},
	{#State 240
		ACTIONS => {
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 174,
			".." => -115,
			'OP09_BITWISE_SHIFT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP15_LOGICAL_AND' => 161,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => 173,
			'OP04_MATH_POW' => 166,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			";" => -115,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP21_LIST_COMMA' => -115,
			"]" => -115,
			"}" => -115,
			")" => -115
		}
	},
	{#State 241
		ACTIONS => {
			'OP17_LIST_RANGE' => -106,
			'OP18_TERNARY' => -106,
			";" => -106,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP04_MATH_POW' => 166,
			")" => -106,
			"}" => -106,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			".." => -106,
			'OP13_BITWISE_AND' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 172
		}
	},
	{#State 242
		ACTIONS => {
			"]" => -101,
			'OP21_LIST_COMMA' => -101,
			"}" => -101,
			")" => -101,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			";" => -101,
			'OP18_TERNARY' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP13_BITWISE_AND' => -101,
			".." => -101,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => -101
		}
	},
	{#State 243
		ACTIONS => {
			'COLON' => 298
		}
	},
	{#State 244
		ACTIONS => {
			")" => -111,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			'OP18_TERNARY' => -111,
			'OP17_LIST_RANGE' => undef,
			";" => -111,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP04_MATH_POW' => 166,
			'OP16_LOGICAL_OR' => 173,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 164,
			".." => -111,
			'OP13_BITWISE_AND' => 174,
			'OP23_LOGICAL_AND' => -111
		}
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 299
		}
	},
	{#State 246
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			".." => -110,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP18_TERNARY' => -110,
			'OP17_LIST_RANGE' => -110,
			";" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			")" => -110,
			"}" => -110,
			"]" => -110,
			'OP21_LIST_COMMA' => -110
		}
	},
	{#State 247
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			".." => -107,
			'OP13_BITWISE_AND' => -107,
			'OP09_BITWISE_SHIFT' => 164,
			")" => -107,
			"}" => -107,
			"]" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			'OP17_LIST_RANGE' => -107,
			'OP18_TERNARY' => -107,
			";" => -107
		}
	},
	{#State 248
		ACTIONS => {
			'OP13_BITWISE_AND' => -105,
			".." => -105,
			'OP09_BITWISE_SHIFT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			";" => -105,
			'OP18_TERNARY' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			"]" => -105,
			"}" => -105,
			")" => -105
		}
	},
	{#State 249
		ACTIONS => {
			")" => 300
		}
	},
	{#State 250
		DEFAULT => -118
	},
	{#State 251
		ACTIONS => {
			'OP23_LOGICAL_AND' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161,
			'OP06_REGEX_MATCH' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			";" => 301
		}
	},
	{#State 252
		ACTIONS => {
			"(" => 302
		}
	},
	{#State 253
		ACTIONS => {
			";" => 303
		}
	},
	{#State 254
		DEFAULT => -149
	},
	{#State 255
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			";" => -148,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 256
		DEFAULT => -128
	},
	{#State 257
		DEFAULT => -197
	},
	{#State 258
		DEFAULT => -198
	},
	{#State 259
		DEFAULT => -132
	},
	{#State 260
		ACTIONS => {
			")" => 304
		}
	},
	{#State 261
		DEFAULT => -196
	},
	{#State 262
		DEFAULT => -88
	},
	{#State 263
		ACTIONS => {
			";" => 305
		}
	},
	{#State 264
		DEFAULT => -131
	},
	{#State 265
		ACTIONS => {
			"## no critic qw(" => 4,
			")" => 307
		},
		GOTOS => {
			'Critic' => 306
		}
	},
	{#State 266
		DEFAULT => -55
	},
	{#State 267
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 308,
			"our" => -58
		},
		GOTOS => {
			'PropertiesClass' => 310,
			'OPTIONAL-23' => 309
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 311
		}
	},
	{#State 269
		DEFAULT => -45
	},
	{#State 270
		ACTIONS => {
			"my" => 85,
			'OP05_MATH_NEG' => 86,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'WORD_SCOPED' => 28,
			'OP01_NAMED_VOID_PAREN' => 84,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_PRINT_VOID_PAREN' => 95,
			"if (" => 93,
			'VARIABLE_SYMBOL' => 92,
			"%{" => 88,
			'LITERAL_STRING' => 73,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			"(" => 79,
			"{" => 74,
			"while (" => -152,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_OPEN_CLOSE' => 112,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"for my integer" => -152,
			"}" => 313,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'OP01_NAMED_VOID' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 109
		},
		GOTOS => {
			'WordScoped' => 104,
			'VariableDeclaration' => 105,
			'LoopLabel' => 76,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Literal' => 77,
			'HashReference' => 78,
			'OperatorVoid' => 70,
			'Variable' => 98,
			'Statement' => 99,
			'PAREN-43' => 89,
			'Conditional' => 91,
			'Operator' => 90,
			'Operation' => 312,
			'Expression' => 94,
			'VariableModification' => 80,
			'ArrayReference' => 114,
			'OPTIONAL-44' => 87
		}
	},
	{#State 271
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 272
		DEFAULT => -41
	},
	{#State 273
		DEFAULT => -218
	},
	{#State 274
		ACTIONS => {
			'WORD' => 315,
			")" => 316
		}
	},
	{#State 275
		DEFAULT => -188
	},
	{#State 276
		DEFAULT => -217
	},
	{#State 277
		ACTIONS => {
			"{" => 74,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_OPEN_CLOSE' => 112,
			"my" => 119,
			'OP05_MATH_NEG' => 86
		},
		GOTOS => {
			'Variable' => 132,
			'ArrayReference' => 114,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Expression' => 126,
			'Literal' => 77,
			'ListElement' => 317,
			'HashReference' => 78
		}
	},
	{#State 278
		DEFAULT => -185
	},
	{#State 279
		DEFAULT => -130
	},
	{#State 280
		DEFAULT => -206
	},
	{#State 281
		DEFAULT => -208
	},
	{#State 282
		ACTIONS => {
			'WORD' => 137,
			"%{" => 88
		},
		GOTOS => {
			'HashDereferenced' => 135,
			'HashEntry' => 318
		}
	},
	{#State 283
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			"{" => 74,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 319,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104
		}
	},
	{#State 284
		DEFAULT => -199
	},
	{#State 285
		ACTIONS => {
			";" => 320
		}
	},
	{#State 286
		DEFAULT => -90
	},
	{#State 287
		DEFAULT => -126
	},
	{#State 288
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"<STDIN>" => 254,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ExpressionOrStdin' => 321,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'Literal' => 77,
			'Expression' => 255,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 289
		DEFAULT => -180
	},
	{#State 290
		ACTIONS => {
			"(" => 322
		}
	},
	{#State 291
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 292
		ACTIONS => {
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'LITERAL_STRING' => 73,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 27,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"{" => 74
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'HashReference' => 78,
			'Expression' => 324,
			'Literal' => 77,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75
		}
	},
	{#State 293
		ACTIONS => {
			"(" => -211,
			"}" => 325
		}
	},
	{#State 294
		ACTIONS => {
			"}" => 326,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP04_MATH_POW' => 166,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP15_LOGICAL_AND' => 161,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 295
		ACTIONS => {
			"]" => 327,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 163
		}
	},
	{#State 296
		ACTIONS => {
			"while (" => -152,
			"{" => 74,
			'WORD' => 109,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			'LITERAL_STRING' => 73,
			'OP01_NAMED_VOID' => 102,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP10_NAMED_UNARY' => 115,
			"for my integer" => -152,
			"%{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			"if (" => 93,
			'OP01_PRINT_VOID_PAREN' => 95,
			'VARIABLE_SYMBOL' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_NAMED_VOID_PAREN' => 84,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86,
			"my" => 85
		},
		GOTOS => {
			'VariableModification' => 80,
			'OPTIONAL-44' => 87,
			'PLUS-49' => 329,
			'ArrayReference' => 114,
			'Conditional' => 91,
			'Operator' => 90,
			'PAREN-43' => 89,
			'Operation' => 328,
			'Expression' => 94,
			'OperatorVoid' => 70,
			'Statement' => 99,
			'Variable' => 98,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 75,
			'LoopLabel' => 76,
			'WordScoped' => 104,
			'VariableDeclaration' => 105,
			'HashReference' => 78,
			'Literal' => 77
		}
	},
	{#State 297
		DEFAULT => -160,
		GOTOS => {
			'STAR-46' => 330
		}
	},
	{#State 298
		ACTIONS => {
			'VARIABLE_SYMBOL' => 92
		},
		GOTOS => {
			'Variable' => 331
		}
	},
	{#State 299
		ACTIONS => {
			"/" => 332
		}
	},
	{#State 300
		ACTIONS => {
			";" => 333
		}
	},
	{#State 301
		DEFAULT => -183
	},
	{#State 302
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"%{" => 88,
			")" => -135,
			'OP10_NAMED_UNARY' => 115,
			'KEYS_OR_VALUES' => 125,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'OP01_QW' => 124,
			'OP05_MATH_NEG' => 86,
			"my" => 119,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 132,
			'HashReference' => 78,
			'ListElement' => 128,
			'ListElements' => 334,
			'Expression' => 126,
			'Literal' => 77,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'OPTIONAL-42' => 335,
			'ArrayDereferenced' => 75,
			'TypeInner' => 133
		}
	},
	{#State 303
		DEFAULT => -182
	},
	{#State 304
		DEFAULT => -145
	},
	{#State 305
		DEFAULT => -92
	},
	{#State 306
		ACTIONS => {
			'WORD' => 338,
			"%{" => 88
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 336
		}
	},
	{#State 307
		ACTIONS => {
			";" => 339
		}
	},
	{#State 308
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 340
		}
	},
	{#State 309
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 341
		}
	},
	{#State 310
		DEFAULT => -57
	},
	{#State 311
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 342
		}
	},
	{#State 312
		DEFAULT => -44
	},
	{#State 313
		ACTIONS => {
			";" => 343
		}
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 344
		}
	},
	{#State 315
		DEFAULT => -187
	},
	{#State 316
		DEFAULT => -190
	},
	{#State 317
		DEFAULT => -184
	},
	{#State 318
		DEFAULT => -205
	},
	{#State 319
		ACTIONS => {
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP06_REGEX_MATCH' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP23_LOGICAL_AND' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174,
			"}" => -201,
			'OP21_LIST_COMMA' => -201,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP04_MATH_POW' => 166,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171
		}
	},
	{#State 320
		DEFAULT => -91
	},
	{#State 321
		ACTIONS => {
			";" => 345
		}
	},
	{#State 322
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'KEYS_OR_VALUES' => 125,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			'OP01_QW' => 124,
			"my" => 119,
			'OP01_OPEN_CLOSE' => 112,
			'OP05_MATH_NEG' => 86
		},
		GOTOS => {
			'Literal' => 77,
			'Expression' => 126,
			'ListElements' => 346,
			'HashReference' => 78,
			'ListElement' => 128,
			'TypeInner' => 133,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'Operator' => 90,
			'HashDereferenced' => 106,
			'ArrayReference' => 114,
			'Variable' => 132
		}
	},
	{#State 323
		DEFAULT => -170
	},
	{#State 324
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP11_COMPARE_LT_GT' => 175,
			".." => 347,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP04_MATH_POW' => 166
		}
	},
	{#State 325
		DEFAULT => -179
	},
	{#State 326
		DEFAULT => -178
	},
	{#State 327
		DEFAULT => -177
	},
	{#State 328
		DEFAULT => -172
	},
	{#State 329
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 113,
			'OP01_OPEN_CLOSE' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			"}" => 349,
			'OP10_NAMED_UNARY' => 115,
			"for my integer" => -152,
			'OP01_NAMED_VOID' => 102,
			"\@{" => 103,
			'LITERAL_NUMBER' => 101,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 109,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG' => 86,
			"my" => 85,
			'WORD_SCOPED' => 28,
			'OP01_NAMED_VOID_PAREN' => 84,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 92,
			"if (" => 93,
			'OP01_PRINT_VOID_PAREN' => 95,
			"%{" => 88,
			'LITERAL_STRING' => 73,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			"(" => 79,
			"while (" => -152,
			"{" => 74
		},
		GOTOS => {
			'Literal' => 77,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'WordScoped' => 104,
			'VariableDeclaration' => 105,
			'LoopLabel' => 76,
			'HashDereferenced' => 106,
			'OperatorVoid' => 70,
			'Variable' => 98,
			'Statement' => 99,
			'Operation' => 348,
			'Expression' => 94,
			'PAREN-43' => 89,
			'Conditional' => 91,
			'Operator' => 90,
			'ArrayReference' => 114,
			'OPTIONAL-44' => 87,
			'VariableModification' => 80
		}
	},
	{#State 330
		ACTIONS => {
			"elsif (" => 351,
			"%{" => -163,
			'OP01_PRINT_VOID_PAREN' => -163,
			'VARIABLE_SYMBOL' => -163,
			"if (" => -163,
			'OP22_LOGICAL_NOT' => -163,
			'OP01_OPEN_CLOSE_PAREN' => -163,
			'OP01_NAMED' => -163,
			"undef" => -163,
			'WORD_SCOPED' => -163,
			'OP01_NAMED_VOID_PAREN' => -163,
			"my" => -163,
			'OP05_MATH_NEG' => -163,
			"{" => -163,
			"while (" => -163,
			"(" => -163,
			'OP01_PRINT_VOID' => -163,
			"foreach my" => -163,
			'LITERAL_STRING' => -163,
			"for my integer" => -163,
			'OP10_NAMED_UNARY' => -163,
			"}" => -163,
			"[" => -163,
			'OP10_NAMED_UNARY_STRINGIFY' => -163,
			'OP01_OPEN_CLOSE' => -163,
			'OP19_LOOP_CONTROL' => -163,
			'' => -163,
			"else" => 352,
			'OP03_MATH_INC_DEC' => -163,
			'WORD' => -163,
			'OP05_LOGICAL_NEG' => -163,
			'LITERAL_NUMBER' => -163,
			"\@{" => -163,
			'OP01_NAMED_VOID' => -163
		},
		GOTOS => {
			'PAREN-45' => 350,
			'OPTIONAL-48' => 353,
			'PAREN-47' => 354
		}
	},
	{#State 331
		DEFAULT => -112
	},
	{#State 332
		DEFAULT => -98
	},
	{#State 333
		DEFAULT => -127
	},
	{#State 334
		DEFAULT => -134
	},
	{#State 335
		ACTIONS => {
			")" => 355
		}
	},
	{#State 336
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 356
		}
	},
	{#State 337
		DEFAULT => -204
	},
	{#State 338
		ACTIONS => {
			'OP20_HASH_FATARROW' => 357
		}
	},
	{#State 339
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 358
		}
	},
	{#State 340
		ACTIONS => {
			"%{" => 88,
			'WORD' => 338
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 359
		}
	},
	{#State 341
		ACTIONS => {
			'LITERAL_NUMBER' => 360,
			"our" => 362
		},
		GOTOS => {
			'Subroutine' => 363,
			'Method' => 361,
			'MethodOrSubroutine' => 364
		}
	},
	{#State 342
		ACTIONS => {
			'OP21_LIST_COMMA' => 366,
			")" => 365
		},
		GOTOS => {
			'PAREN-18' => 367
		}
	},
	{#State 343
		DEFAULT => -46
	},
	{#State 344
		DEFAULT => -216
	},
	{#State 345
		DEFAULT => -181
	},
	{#State 346
		ACTIONS => {
			")" => 368
		}
	},
	{#State 347
		ACTIONS => {
			"{" => 74,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 27,
			"(" => 79,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 90,
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashReference' => 78,
			'Literal' => 77,
			'Expression' => 369,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 348
		DEFAULT => -171
	},
	{#State 349
		DEFAULT => -173
	},
	{#State 350
		DEFAULT => -159
	},
	{#State 351
		ACTIONS => {
			"{" => 74,
			"(" => 79,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_LOGICAL_NEG' => 100,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'WORD_SCOPED' => 28,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'Expression' => 370,
			'Literal' => 77,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 352
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 371
		}
	},
	{#State 353
		DEFAULT => -164
	},
	{#State 354
		DEFAULT => -162
	},
	{#State 355
		DEFAULT => -146
	},
	{#State 356
		ACTIONS => {
			'OP21_LIST_COMMA' => 373,
			")" => 374
		},
		GOTOS => {
			'PAREN-25' => 372
		}
	},
	{#State 357
		ACTIONS => {
			"my" => 119
		},
		GOTOS => {
			'TypeInner' => 375
		}
	},
	{#State 358
		DEFAULT => -66
	},
	{#State 359
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 376
		}
	},
	{#State 360
		ACTIONS => {
			";" => 377
		}
	},
	{#State 361
		DEFAULT => -80
	},
	{#State 362
		ACTIONS => {
			'WORD' => 378
		},
		GOTOS => {
			'TypeMethod' => 379,
			'Type' => 56
		}
	},
	{#State 363
		DEFAULT => -81
	},
	{#State 364
		DEFAULT => -59
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 366
		ACTIONS => {
			"my" => 381
		}
	},
	{#State 367
		DEFAULT => -48
	},
	{#State 368
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 382
		}
	},
	{#State 369
		ACTIONS => {
			'OP04_MATH_POW' => 166,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP08_STRING_CAT' => 169,
			'OP18_TERNARY' => 170,
			'OP17_LIST_RANGE' => 171,
			")" => 383,
			'OP23_LOGICAL_AND' => 163,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 172,
			'OP15_LOGICAL_AND' => 161,
			'OP08_MATH_ADD_SUB' => 162,
			'OP16_LOGICAL_OR' => 173
		}
	},
	{#State 370
		ACTIONS => {
			'OP16_LOGICAL_OR' => 173,
			'OP15_LOGICAL_AND' => 161,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP23_LOGICAL_AND' => 163,
			")" => 384,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP12_COMPARE_EQ_NEQ' => 168
		}
	},
	{#State 371
		DEFAULT => -161
	},
	{#State 372
		DEFAULT => -63
	},
	{#State 373
		ACTIONS => {
			'WORD' => 338,
			"%{" => 88
		},
		GOTOS => {
			'HashEntryTyped' => 385,
			'HashDereferenced' => 337
		}
	},
	{#State 374
		ACTIONS => {
			";" => 386
		}
	},
	{#State 375
		ACTIONS => {
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'OP05_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 107,
			"(" => 79,
			'WORD' => 27,
			"{" => 74,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			"%{" => 88,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereferenced' => 75,
			'HashDereferenced' => 106,
			'Operator' => 90,
			'Expression' => 387,
			'Literal' => 77,
			'HashReference' => 78,
			'Variable' => 132,
			'ArrayReference' => 114
		}
	},
	{#State 376
		ACTIONS => {
			'OP21_LIST_COMMA' => 388,
			")" => 389
		},
		GOTOS => {
			'PAREN-27' => 390
		}
	},
	{#State 377
		DEFAULT => -61
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => -214,
			"__method" => 391
		}
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 380
		ACTIONS => {
			"\@_;" => 393
		}
	},
	{#State 381
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 394
		}
	},
	{#State 382
		DEFAULT => -169
	},
	{#State 383
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 395
		}
	},
	{#State 384
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 396
		}
	},
	{#State 385
		DEFAULT => -62
	},
	{#State 386
		DEFAULT => -65
	},
	{#State 387
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP23_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 173,
			'OP06_REGEX_MATCH' => 172,
			'OP08_MATH_ADD_SUB' => 162,
			'OP15_LOGICAL_AND' => 161,
			'OP17_LIST_RANGE' => 171,
			'OP18_TERNARY' => 170,
			'OP04_MATH_POW' => 166,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP12_COMPARE_EQ_NEQ' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP21_LIST_COMMA' => -203,
			")" => -203
		}
	},
	{#State 388
		ACTIONS => {
			"%{" => 88,
			'WORD' => 338
		},
		GOTOS => {
			'HashDereferenced' => 337,
			'HashEntryTyped' => 397
		}
	},
	{#State 389
		ACTIONS => {
			";" => 398
		}
	},
	{#State 390
		DEFAULT => -68
	},
	{#State 391
		DEFAULT => -215
	},
	{#State 392
		ACTIONS => {
			"= sub {" => 399
		}
	},
	{#State 393
		DEFAULT => -50
	},
	{#State 394
		ACTIONS => {
			'VARIABLE_SYMBOL' => 400
		}
	},
	{#State 395
		DEFAULT => -168
	},
	{#State 396
		DEFAULT => -158
	},
	{#State 397
		DEFAULT => -67
	},
	{#State 398
		DEFAULT => -70
	},
	{#State 399
		ACTIONS => {
			"(" => -72,
			"while (" => -72,
			"{" => -72,
			'LITERAL_STRING' => -72,
			"foreach my" => -72,
			'OP01_PRINT_VOID' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP01_PRINT_VOID_PAREN' => -72,
			'VARIABLE_SYMBOL' => -72,
			"if (" => -72,
			"%{" => -72,
			"my" => -72,
			'OP05_MATH_NEG' => -72,
			'WORD_SCOPED' => -72,
			'OP01_NAMED_VOID_PAREN' => -72,
			"( my" => 403,
			'OP01_NAMED' => -72,
			"undef" => -72,
			'OP01_OPEN_CLOSE_PAREN' => -72,
			'WORD' => -72,
			'OP03_MATH_INC_DEC' => -72,
			"\@{" => -72,
			'OP01_NAMED_VOID' => -72,
			'LITERAL_NUMBER' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP10_NAMED_UNARY' => -72,
			"for my integer" => -72,
			'OP19_LOOP_CONTROL' => -72,
			'OP01_OPEN_CLOSE' => -72,
			"[" => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72
		},
		GOTOS => {
			'MethodArguments' => 402,
			'OPTIONAL-29' => 401
		}
	},
	{#State 400
		DEFAULT => -47
	},
	{#State 401
		ACTIONS => {
			"if (" => 93,
			'OP01_PRINT_VOID_PAREN' => 95,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 88,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 86,
			'OP01_OPEN_CLOSE' => 112,
			"my" => 85,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED_VOID_PAREN' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			"[" => 111,
			'WORD_SCOPED' => 28,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP01_NAMED' => 83,
			"undef" => 82,
			'WORD' => 109,
			"(" => 79,
			'OP03_MATH_INC_DEC' => 107,
			"while (" => -152,
			"{" => 74,
			'OP01_NAMED_VOID' => 102,
			"\@{" => 103,
			'LITERAL_STRING' => 73,
			'LITERAL_NUMBER' => 101,
			"foreach my" => -152,
			'OP05_LOGICAL_NEG' => 100,
			'OP01_PRINT_VOID' => 72
		},
		GOTOS => {
			'ArrayReference' => 114,
			'OPTIONAL-44' => 87,
			'PLUS-30' => 405,
			'VariableModification' => 80,
			'Operation' => 404,
			'Expression' => 94,
			'PAREN-43' => 89,
			'Conditional' => 91,
			'Operator' => 90,
			'OperatorVoid' => 70,
			'Variable' => 98,
			'Statement' => 99,
			'Literal' => 77,
			'HashReference' => 78,
			'ArrayDereferenced' => 75,
			'VariableDeclaration' => 105,
			'WordScoped' => 104,
			'LoopLabel' => 76,
			'HashDereferenced' => 106
		}
	},
	{#State 402
		DEFAULT => -71
	},
	{#State 403
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 406
		}
	},
	{#State 404
		DEFAULT => -74
	},
	{#State 405
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 109,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 101,
			"\@{" => 103,
			'OP01_NAMED_VOID' => 102,
			"for my integer" => -152,
			'OP10_NAMED_UNARY' => 115,
			"}" => 408,
			"[" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 110,
			'OP01_OPEN_CLOSE' => 112,
			'OP19_LOOP_CONTROL' => 113,
			"{" => 74,
			"while (" => -152,
			"(" => 79,
			"foreach my" => -152,
			'OP01_PRINT_VOID' => 72,
			'LITERAL_STRING' => 73,
			"%{" => 88,
			"if (" => 93,
			'OP01_PRINT_VOID_PAREN' => 95,
			'VARIABLE_SYMBOL' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP01_NAMED' => 83,
			'OP01_NAMED_VOID_PAREN' => 84,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG' => 86,
			"my" => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 75,
			'LoopLabel' => 76,
			'VariableDeclaration' => 105,
			'WordScoped' => 104,
			'HashDereferenced' => 106,
			'Literal' => 77,
			'HashReference' => 78,
			'Variable' => 98,
			'Statement' => 99,
			'OperatorVoid' => 70,
			'PAREN-43' => 89,
			'Operator' => 90,
			'Conditional' => 91,
			'Expression' => 94,
			'Operation' => 407,
			'VariableModification' => 80,
			'ArrayReference' => 114,
			'OPTIONAL-44' => 87
		}
	},
	{#State 406
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 409
		}
	},
	{#State 407
		DEFAULT => -73
	},
	{#State 408
		ACTIONS => {
			";" => 410
		}
	},
	{#State 409
		ACTIONS => {
			'OP21_LIST_COMMA' => 411,
			")" => 412
		},
		GOTOS => {
			'PAREN-31' => 413
		}
	},
	{#State 410
		DEFAULT => -75
	},
	{#State 411
		ACTIONS => {
			"my" => 414
		}
	},
	{#State 412
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 413
		DEFAULT => -77
	},
	{#State 414
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 416
		}
	},
	{#State 415
		ACTIONS => {
			"\@_;" => 417
		}
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 418
		}
	},
	{#State 417
		DEFAULT => -79
	},
	{#State 418
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5614 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5621 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5628 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5646 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5734 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5741 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5956 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5963 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5970 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6002 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6229 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6236 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6280 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6291 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6298 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6305 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6597 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6608 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6619 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_148
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_149
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 4,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7041 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7287 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_190
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7356 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_197
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_198
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_203
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7443 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_204
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7468 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_209
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_210
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule TypeMethod_215
		 'TypeMethod', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_216
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_217
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_218
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	]
],
#line 7621 lib/RPerl/Grammar.pm
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


#line 7890 lib/RPerl/Grammar.pm



1;
