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
    our $VERSION = 0.000_803;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|package|\<STDIN\>|\$TYPED_|while\ \(|elsif\ \(|\=\ sub\ \{|undef|else|if\ \(|\(\ my|\@_\;|our|qw\(|use|\%\{|\@\{|my|\.\.|\{\*|\{|\;|\}|\]|\(|\)|\[)}gc and return ($1, $1);

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
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
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


#line 119 lib/RPerl/Grammar.pm

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
  [ 'TypeInner_215' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandle_216' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_217' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'Literal_218' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_219' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'TypeInner_215' => 215,
  'FileHandle_216' => 216,
  'FileHandle_217' => 217,
  'Literal_218' => 218,
  'Literal_219' => 219,
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
			"## no critic qw(" => 6,
			'SHEBANG' => 3,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 2,
			'ModuleHeader' => 4,
			'Program' => 1,
			'Critic' => 5,
			'CompileUnit' => 7,
			'PAREN-1' => 9,
			'PLUS-2' => 8
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use" => -25,
			"use parent qw(" => 15,
			"our" => -25
		},
		GOTOS => {
			'Package' => 14,
			'Class' => 17,
			'STAR-10' => 13,
			'Module' => 16
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 7
		ACTIONS => {
			'' => 20
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 2,
			'Critic' => 5,
			'PAREN-1' => 21
		}
	},
	{#State 9
		DEFAULT => -3
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
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 6,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 27,
			'STAR-11' => 28
		}
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			'WORD' => 30,
			")" => 31
		}
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		DEFAULT => -212
	},
	{#State 23
		ACTIONS => {
			";" => 32
		}
	},
	{#State 24
		DEFAULT => -211
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
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 37
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 35
		}
	},
	{#State 29
		ACTIONS => {
			")" => 38
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
			"[" => -11,
			'LITERAL_STRING' => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_OPEN_CLOSE' => -11,
			"use" => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"use constant" => -11,
			"for my integer" => -11,
			'OP05_MATH_NEG' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			"(" => -11,
			'WORD' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'OP22_LOGICAL_NOT' => -11,
			"my" => -11,
			'VARIABLE_SYMBOL' => -11,
			"{" => -11,
			"while (" => -11,
			"undef" => -11,
			"if (" => -11,
			"\@{" => -11,
			'LITERAL_NUMBER' => -11,
			"foreach my" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_PRINT_VOID' => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			'OP01_NAMED_VOID' => -11,
			"## no critic qw(" => 6,
			"%{" => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 42
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 45,
			"our" => 44
		},
		GOTOS => {
			'Constant' => 47,
			'PLUS-13' => 46,
			'Subroutine' => 43
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 48
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
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -13,
			"our" => -13,
			'OP10_NAMED_UNARY' => -13,
			'VARIABLE_SYMBOL' => -13,
			"my" => -13,
			'OP01_PRINT_VOID' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			"{" => -13,
			"if (" => -13,
			"\@{" => -13,
			"undef" => -13,
			'LITERAL_NUMBER' => -13,
			"foreach my" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"while (" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN_CLOSE' => -13,
			"use" => 37,
			'OP01_NAMED' => -13,
			"[" => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_STRING' => -13,
			'OP05_MATH_NEG' => -13,
			"for my integer" => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD' => -13,
			"(" => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"use constant" => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 43
		DEFAULT => -31
	},
	{#State 44
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 55
		}
	},
	{#State 46
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 47
		DEFAULT => -28
	},
	{#State 48
		ACTIONS => {
			"qw(" => 58,
			";" => 59
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 37
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
			"{" => -15,
			"while (" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			"if (" => -15,
			"\@{" => -15,
			"undef" => -15,
			"foreach my" => -15,
			'OP01_PRINT_VOID' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP22_LOGICAL_NOT' => -15,
			"our" => -15,
			"my" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			"use constant" => 45,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			"for my integer" => -15,
			'OP05_MATH_NEG' => -15,
			"(" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD' => -15,
			"[" => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15
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
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
		}
	},
	{#State 54
		DEFAULT => -214
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
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
			'WORD' => 68
		},
		GOTOS => {
			'PLUS-15' => 67
		}
	},
	{#State 59
		DEFAULT => -39
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
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			"(" => 110,
			'WORD' => 109,
			'OP19_LOOP_CONTROL' => 108,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP01_PRINT_VOID_PAREN' => 112,
			"my" => 74,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			"our" => 44,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED_VOID_PAREN' => 81,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			'OP01_PRINT_VOID' => 78,
			"while (" => -152,
			"foreach my" => -152,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"if (" => 88,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'Subroutine' => 93,
			'Operator' => 71,
			'VariableDeclaration' => 92,
			'Literal' => 91,
			'VariableModification' => 101,
			'Variable' => 100,
			'Expression' => 77,
			'PLUS-8' => 104,
			'Conditional' => 103,
			'PAREN-43' => 75,
			'OperatorVoid' => 97,
			'ArrayDereferenced' => 76,
			'LoopLabel' => 98,
			'HashReference' => 107,
			'OPTIONAL-44' => 87,
			'Statement' => 90,
			'HashDereferenced' => 82,
			'Operation' => 114,
			'WordScoped' => 113,
			'ArrayReference' => 111
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"= sub {" => 116
		}
	},
	{#State 65
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 117
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		ACTIONS => {
			'WORD' => 120,
			")" => 119
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			"use" => -54,
			"use constant" => -54,
			"our %properties = (" => -54,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 122,
			'STAR-21' => 121
		}
	},
	{#State 70
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'Expression' => 123,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71
		}
	},
	{#State 71
		DEFAULT => -144
	},
	{#State 72
		ACTIONS => {
			"{" => 83,
			"\@{" => 86,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'Expression' => 125,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107
		}
	},
	{#State 73
		DEFAULT => -175,
		GOTOS => {
			'STAR-50' => 126
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 127
		}
	},
	{#State 75
		DEFAULT => -151
	},
	{#State 76
		DEFAULT => -140
	},
	{#State 77
		ACTIONS => {
			'OP18_TERNARY' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			";" => 138,
			'OP09_BITWISE_SHIFT' => 137,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128
		}
	},
	{#State 78
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP01_QW' => 153,
			"[" => 99,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			"my" => 152,
			'OP01_NAMED' => 96,
			"{*" => 149,
			'OP22_LOGICAL_NOT' => 70,
			";" => -123,
			'OP10_NAMED_UNARY' => 72,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105
		},
		GOTOS => {
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'OPTIONAL-39' => 150,
			'Variable' => 124,
			'TypeInner' => 151,
			'ListElements' => 148,
			'Expression' => 154,
			'Operator' => 71,
			'ListElement' => 145,
			'Literal' => 91,
			'HashReference' => 107,
			'FileHandle' => 146
		}
	},
	{#State 79
		ACTIONS => {
			"{" => 157,
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'HashReference' => 156,
			'Variable' => 155
		}
	},
	{#State 80
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_QW' => 153,
			'OP01_NAMED' => 96,
			"my" => 118,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP10_NAMED_UNARY' => 72,
			";" => -121,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"{" => 83,
			'KEYS_OR_VALUES' => 147,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106
		},
		GOTOS => {
			'Literal' => 91,
			'OPTIONAL-38' => 159,
			'Operator' => 71,
			'ListElement' => 145,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ListElements' => 158,
			'TypeInner' => 151,
			'Expression' => 154,
			'Variable' => 124
		}
	},
	{#State 81
		ACTIONS => {
			'OP01_NAMED' => 96,
			"my" => 118,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_QW' => 153,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			")" => -117,
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"{" => 83,
			'KEYS_OR_VALUES' => 147
		},
		GOTOS => {
			'Variable' => 124,
			'ListElements' => 161,
			'TypeInner' => 151,
			'Expression' => 154,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'ListElement' => 145,
			'Operator' => 71,
			'OPTIONAL-36' => 160,
			'Literal' => 91
		}
	},
	{#State 82
		DEFAULT => -142
	},
	{#State 83
		ACTIONS => {
			'WORD' => 163,
			"}" => 162,
			"%{" => 79
		},
		GOTOS => {
			'HashEntry' => 164,
			'HashDereferenced' => 165
		}
	},
	{#State 84
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'Expression' => 166,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107
		}
	},
	{#State 85
		DEFAULT => -219
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73,
			"[" => 99
		},
		GOTOS => {
			'ArrayReference' => 167,
			'Variable' => 168
		}
	},
	{#State 87
		ACTIONS => {
			"for my integer" => 172,
			"while (" => 175,
			"foreach my" => 174
		},
		GOTOS => {
			'Loop' => 170,
			'LoopWhile' => 171,
			'LoopForEach' => 169,
			'LoopFor' => 173
		}
	},
	{#State 88
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			"{" => 83,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 176,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 89
		DEFAULT => -136
	},
	{#State 90
		DEFAULT => -83
	},
	{#State 91
		DEFAULT => -137
	},
	{#State 92
		DEFAULT => -156
	},
	{#State 93
		DEFAULT => -14
	},
	{#State 94
		ACTIONS => {
			"{*" => 149,
			"my" => 178
		},
		GOTOS => {
			'FileHandle' => 177
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'Variable' => 179
		}
	},
	{#State 96
		ACTIONS => {
			"(" => 180
		}
	},
	{#State 97
		DEFAULT => -155
	},
	{#State 98
		ACTIONS => {
			'COLON' => 181
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"undef" => 89,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			"my" => 118,
			'OP01_NAMED' => 96,
			"]" => -195,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP01_QW' => 153,
			"[" => 99
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 154,
			'OPTIONAL-54' => 183,
			'ListElements' => 182,
			'TypeInner' => 151,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'Operator' => 71,
			'ListElement' => 145,
			'Literal' => 91
		}
	},
	{#State 100
		ACTIONS => {
			'OP23_LOGICAL_AND' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP18_TERNARY' => -138,
			'OP19_VARIABLE_ASSIGN' => 184,
			'OP13_BITWISE_AND' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP16_LOGICAL_OR' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP04_MATH_POW' => -138,
			'OP08_STRING_CAT' => -138,
			'OP02_METHOD_THINARROW' => 185,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP19_VARIABLE_ASSIGN_BY' => 187,
			'OP06_REGEX_MATCH' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP03_MATH_INC_DEC' => 186,
			'OP14_BITWISE_OR_XOR' => -138,
			";" => -138,
			'OP09_BITWISE_SHIFT' => -138
		}
	},
	{#State 101
		DEFAULT => -157
	},
	{#State 102
		DEFAULT => -218
	},
	{#State 103
		DEFAULT => -153
	},
	{#State 104
		ACTIONS => {
			"for my integer" => -152,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"(" => 110,
			'OP19_LOOP_CONTROL' => 108,
			'WORD' => 109,
			'OP01_PRINT_VOID_PAREN' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			'OP01_PRINT_VOID' => 78,
			'OP01_NAMED_VOID_PAREN' => 81,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			'' => -18,
			"{" => 83,
			"while (" => -152,
			"foreach my" => -152,
			"undef" => 89,
			"\@{" => 86,
			"if (" => 88,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			"my" => 74,
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'LoopLabel' => 98,
			'ArrayDereferenced' => 76,
			'PAREN-43' => 75,
			'OperatorVoid' => 97,
			'Expression' => 77,
			'Conditional' => 103,
			'Variable' => 100,
			'VariableModification' => 101,
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'Operator' => 71,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'Operation' => 188,
			'HashDereferenced' => 82,
			'Statement' => 90,
			'OPTIONAL-44' => 87,
			'HashReference' => 107
		}
	},
	{#State 105
		ACTIONS => {
			"my" => 178,
			"{*" => 149
		},
		GOTOS => {
			'FileHandle' => 189
		}
	},
	{#State 106
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91,
			'Variable' => 124,
			'Expression' => 190,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76
		}
	},
	{#State 107
		DEFAULT => -141
	},
	{#State 108
		ACTIONS => {
			'WORD' => 192
		},
		GOTOS => {
			'LoopLabel' => 191
		}
	},
	{#State 109
		ACTIONS => {
			'COLON' => -213,
			"(" => -211
		}
	},
	{#State 110
		ACTIONS => {
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			"{" => 83,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110
		},
		GOTOS => {
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 193,
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107
		}
	},
	{#State 111
		DEFAULT => -139
	},
	{#State 112
		ACTIONS => {
			"my" => 178,
			"{*" => 149
		},
		GOTOS => {
			'FileHandle' => 194
		}
	},
	{#State 113
		ACTIONS => {
			"(" => 195
		}
	},
	{#State 114
		DEFAULT => -17
	},
	{#State 115
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105
		},
		GOTOS => {
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 196,
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107
		}
	},
	{#State 116
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -43,
			'OP10_NAMED_UNARY' => -43,
			'VARIABLE_SYMBOL' => -43,
			"my" => -43,
			"{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"( my" => 199,
			"if (" => -43,
			"\@{" => -43,
			"undef" => -43,
			'LITERAL_NUMBER' => -43,
			"foreach my" => -43,
			"while (" => -43,
			'OP01_PRINT_VOID' => -43,
			'OP01_NAMED_VOID' => -43,
			"%{" => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			"[" => -43,
			'WORD_SCOPED' => -43,
			'LITERAL_STRING' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_OPEN_CLOSE' => -43,
			'OP01_NAMED' => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			"for my integer" => -43,
			'OP05_MATH_NEG' => -43,
			'WORD' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"(" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 197,
			'OPTIONAL-16' => 198
		}
	},
	{#State 117
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'Literal' => 200
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 119
		ACTIONS => {
			";" => 202
		}
	},
	{#State 120
		DEFAULT => -37
	},
	{#State 121
		ACTIONS => {
			"use" => 37,
			"use constant" => -56,
			"our %properties = (" => -56
		},
		GOTOS => {
			'Include' => 204,
			'STAR-22' => 203
		}
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			")" => -113,
			"}" => -113,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => -113,
			'OP18_TERNARY' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP21_LIST_COMMA' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			".." => -113,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP14_BITWISE_OR_XOR' => 128,
			";" => -113,
			"]" => -113,
			'OP09_BITWISE_SHIFT' => 137
		}
	},
	{#State 124
		ACTIONS => {
			'OP16_LOGICAL_OR' => -138,
			'OP21_LIST_COMMA' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			'OP18_TERNARY' => -138,
			"}" => -138,
			")" => -138,
			'OP23_LOGICAL_AND' => -138,
			'OP17_LIST_RANGE' => -138,
			";" => -138,
			'OP09_BITWISE_SHIFT' => -138,
			"]" => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP03_MATH_INC_DEC' => 186,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP02_METHOD_THINARROW' => 185,
			".." => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP08_STRING_CAT' => -138,
			'OP04_MATH_POW' => -138
		}
	},
	{#State 125
		ACTIONS => {
			'OP21_LIST_COMMA' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP08_MATH_ADD_SUB' => 141,
			'OP17_LIST_RANGE' => -103,
			'OP23_LOGICAL_AND' => -103,
			"}" => -103,
			")" => -103,
			'OP18_TERNARY' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 131,
			'OP09_BITWISE_SHIFT' => 137,
			"]" => -103,
			";" => -103,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			".." => -103,
			'OP12_COMPARE_EQ_NEQ' => -103
		}
	},
	{#State 126
		ACTIONS => {
			'OP15_LOGICAL_AND' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			";" => -176,
			'OP09_BITWISE_SHIFT' => -176,
			"]" => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP04_MATH_POW' => -176,
			'OP08_STRING_CAT' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP02_METHOD_THINARROW' => -176,
			'OP12_COMPARE_EQ_NEQ' => -176,
			".." => -176,
			'OP02_HASH_THINARROW' => 207,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP02_ARRAY_THINARROW' => 206,
			'OP16_LOGICAL_OR' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP13_BITWISE_AND' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			"}" => -176,
			")" => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP17_LIST_RANGE' => -176,
			'COLON' => -176,
			'OP18_TERNARY' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 205
		}
	},
	{#State 127
		ACTIONS => {
			'VARIABLE_SYMBOL' => 208
		}
	},
	{#State 128
		ACTIONS => {
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99
		},
		GOTOS => {
			'Expression' => 209,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71
		}
	},
	{#State 129
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Expression' => 210,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71
		}
	},
	{#State 130
		ACTIONS => {
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91,
			'Variable' => 124,
			'Expression' => 211,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'ArrayDereferenced' => 76
		}
	},
	{#State 131
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 212
		}
	},
	{#State 132
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83
		},
		GOTOS => {
			'Expression' => 213,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71
		}
	},
	{#State 133
		ACTIONS => {
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			"{" => 83,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110
		},
		GOTOS => {
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'Expression' => 214,
			'Variable' => 124
		}
	},
	{#State 134
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			"{" => 83,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Expression' => 215,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107
		}
	},
	{#State 135
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"{" => 83,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91,
			'Variable' => 124,
			'Expression' => 216,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76
		}
	},
	{#State 136
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 217
		}
	},
	{#State 137
		ACTIONS => {
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 218,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 138
		DEFAULT => -82
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'Expression' => 219,
			'Variable' => 124
		}
	},
	{#State 140
		ACTIONS => {
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			"{" => 83,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 220,
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107
		}
	},
	{#State 141
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71,
			'Expression' => 221,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113
		}
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'Variable' => 222
		}
	},
	{#State 143
		ACTIONS => {
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			"{" => 83,
			"\@{" => 86,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'Expression' => 223,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107
		}
	},
	{#State 144
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'Expression' => 224,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71
		}
	},
	{#State 145
		DEFAULT => -186,
		GOTOS => {
			'STAR-52' => 225
		}
	},
	{#State 146
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_QW' => 153,
			'OP01_NAMED' => 96,
			"my" => 118,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP10_NAMED_UNARY' => 72,
			";" => -125,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83,
			'KEYS_OR_VALUES' => 147,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106
		},
		GOTOS => {
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71,
			'ListElement' => 145,
			'ListElements' => 226,
			'TypeInner' => 151,
			'Expression' => 154,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'OPTIONAL-40' => 227,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111
		}
	},
	{#State 147
		ACTIONS => {
			"%{" => 79
		},
		GOTOS => {
			'HashDereferenced' => 228
		}
	},
	{#State 148
		DEFAULT => -122
	},
	{#State 149
		ACTIONS => {
			'WORD' => 229
		}
	},
	{#State 150
		ACTIONS => {
			";" => 230
		}
	},
	{#State 151
		ACTIONS => {
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			"{" => 83,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110
		},
		GOTOS => {
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 231
		}
	},
	{#State 152
		ACTIONS => {
			"filehandle_ref" => 232,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 153
		ACTIONS => {
			"(" => 233
		}
	},
	{#State 154
		ACTIONS => {
			'OP21_LIST_COMMA' => -191,
			'OP16_LOGICAL_OR' => 135,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP18_TERNARY' => 142,
			")" => -191,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			";" => -191,
			'OP09_BITWISE_SHIFT' => 137,
			"]" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 234
		}
	},
	{#State 156
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 79,
			'WORD' => 163
		},
		GOTOS => {
			'HashEntry' => 164,
			'HashDereferenced' => 165
		}
	},
	{#State 158
		DEFAULT => -120
	},
	{#State 159
		ACTIONS => {
			";" => 236
		}
	},
	{#State 160
		ACTIONS => {
			")" => 237
		}
	},
	{#State 161
		DEFAULT => -116
	},
	{#State 162
		DEFAULT => -143
	},
	{#State 163
		ACTIONS => {
			'OP20_HASH_FATARROW' => 238
		}
	},
	{#State 164
		DEFAULT => -207,
		GOTOS => {
			'STAR-57' => 239
		}
	},
	{#State 165
		DEFAULT => -202
	},
	{#State 166
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			'OP06_REGEX_MATCH' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			"]" => -96,
			";" => -96,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			".." => -96,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			"}" => -96,
			")" => -96,
			'OP18_TERNARY' => -96
		}
	},
	{#State 167
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 168
		ACTIONS => {
			"}" => 241
		}
	},
	{#State 169
		DEFAULT => -166
	},
	{#State 170
		DEFAULT => -154
	},
	{#State 171
		DEFAULT => -167
	},
	{#State 172
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 173
		DEFAULT => -165
	},
	{#State 174
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 243
		}
	},
	{#State 175
		ACTIONS => {
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 244,
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107
		}
	},
	{#State 176
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 137,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP18_TERNARY' => 142,
			")" => 245,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143
		}
	},
	{#State 177
		ACTIONS => {
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP01_QW' => 153,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			";" => -89,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			"my" => 118
		},
		GOTOS => {
			'ListElement' => 145,
			'Operator' => 71,
			'OPTIONAL-35' => 247,
			'Literal' => 91,
			'HashReference' => 107,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 154,
			'TypeInner' => 151,
			'ListElements' => 246
		}
	},
	{#State 178
		ACTIONS => {
			"filehandle_ref" => 232
		}
	},
	{#State 179
		DEFAULT => -93
	},
	{#State 180
		ACTIONS => {
			"[" => 99,
			'OP01_QW' => 153,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			"my" => 118,
			'OP01_NAMED' => 96,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			"{" => 83,
			'KEYS_OR_VALUES' => 147,
			")" => -85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'OPTIONAL-33' => 248,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ListElements' => 249,
			'TypeInner' => 151,
			'Expression' => 154,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'ListElement' => 145,
			'HashReference' => 107
		}
	},
	{#State 181
		DEFAULT => -150
	},
	{#State 182
		DEFAULT => -194
	},
	{#State 183
		ACTIONS => {
			"]" => 250
		}
	},
	{#State 184
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			'OP01_NAMED' => 96,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"<STDIN>" => 251,
			"(" => 110,
			"%{" => 79,
			"{" => 83,
			"undef" => 89,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Expression' => 253,
			'Variable' => 124,
			'Literal' => 91,
			'Operator' => 71,
			'ExpressionOrStdin' => 252,
			'HashReference' => 107
		}
	},
	{#State 185
		ACTIONS => {
			'WORD' => 254
		}
	},
	{#State 186
		DEFAULT => -94
	},
	{#State 187
		ACTIONS => {
			"{" => 83,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91,
			'Variable' => 124,
			'Expression' => 255,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'ArrayDereferenced' => 76
		}
	},
	{#State 188
		DEFAULT => -16
	},
	{#State 189
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			")" => -87,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP01_QW' => 153,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"my" => 118,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'Literal' => 91,
			'OPTIONAL-34' => 257,
			'Operator' => 71,
			'ListElement' => 145,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ListElements' => 256,
			'TypeInner' => 151,
			'Expression' => 154,
			'Variable' => 124
		}
	},
	{#State 190
		ACTIONS => {
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 135,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			")" => 258,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP18_TERNARY' => 142
		}
	},
	{#State 191
		ACTIONS => {
			";" => 259
		}
	},
	{#State 192
		DEFAULT => -213
	},
	{#State 193
		ACTIONS => {
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			'OP16_LOGICAL_OR' => 135,
			")" => 260,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP18_TERNARY' => 142,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139
		}
	},
	{#State 194
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"my" => 118,
			'OP01_QW' => 153,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			")" => -119
		},
		GOTOS => {
			'Literal' => 91,
			'Operator' => 71,
			'ListElement' => 145,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'Expression' => 154,
			'ListElements' => 261,
			'OPTIONAL-37' => 262,
			'TypeInner' => 151,
			'Variable' => 124
		}
	},
	{#State 195
		ACTIONS => {
			'OP01_QW' => 153,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"my" => 118,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			")" => -133,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110
		},
		GOTOS => {
			'Literal' => 91,
			'OPTIONAL-41' => 263,
			'Operator' => 71,
			'ListElement' => 145,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'TypeInner' => 151,
			'ListElements' => 264,
			'Expression' => 154,
			'Variable' => 124
		}
	},
	{#State 196
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			"]" => -104,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -104,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -104,
			".." => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP08_MATH_ADD_SUB' => 141,
			'OP21_LIST_COMMA' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			")" => -104,
			"}" => -104,
			'OP18_TERNARY' => -104
		}
	},
	{#State 197
		DEFAULT => -42
	},
	{#State 198
		ACTIONS => {
			"{" => 83,
			'OP01_PRINT_VOID_PAREN' => 112,
			"while (" => -152,
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			"foreach my" => -152,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"if (" => 88,
			"undef" => 89,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP01_PRINT_VOID' => 78,
			'OP05_MATH_NEG' => 106,
			"for my integer" => -152,
			"(" => 110,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			'OP01_NAMED_VOID_PAREN' => 81,
			'WORD' => 109,
			'OP19_LOOP_CONTROL' => 108,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			"my" => 74,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94
		},
		GOTOS => {
			'Statement' => 90,
			'OPTIONAL-44' => 87,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Operation' => 266,
			'HashDereferenced' => 82,
			'PLUS-17' => 265,
			'HashReference' => 107,
			'Expression' => 77,
			'Conditional' => 103,
			'Variable' => 100,
			'VariableModification' => 101,
			'ArrayDereferenced' => 76,
			'LoopLabel' => 98,
			'PAREN-43' => 75,
			'OperatorVoid' => 97,
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'Operator' => 71
		}
	},
	{#State 199
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 267
		}
	},
	{#State 200
		ACTIONS => {
			";" => 268
		}
	},
	{#State 201
		ACTIONS => {
			"\$TYPED_" => 269
		}
	},
	{#State 202
		DEFAULT => -40
	},
	{#State 203
		ACTIONS => {
			"use constant" => 45,
			"our %properties = (" => 270
		},
		GOTOS => {
			'Properties' => 272,
			'Constant' => 271
		}
	},
	{#State 204
		DEFAULT => -53
	},
	{#State 205
		DEFAULT => -174
	},
	{#State 206
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"{" => 83,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Expression' => 273,
			'Variable' => 124
		}
	},
	{#State 207
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'WORD' => 275,
			"%{" => 79,
			"(" => 110,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83
		},
		GOTOS => {
			'HashReference' => 107,
			'Literal' => 91,
			'Operator' => 71,
			'Expression' => 274,
			'Variable' => 124,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'HashDereferenced' => 82
		}
	},
	{#State 208
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 276,
			";" => 277
		}
	},
	{#State 209
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP21_LIST_COMMA' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP18_TERNARY' => -108,
			")" => -108,
			"}" => -108,
			'OP17_LIST_RANGE' => -108,
			'OP23_LOGICAL_AND' => -108,
			";" => -108,
			"]" => -108,
			'OP09_BITWISE_SHIFT' => 137,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => -108,
			'OP11_COMPARE_LT_GT' => 139,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140
		}
	},
	{#State 210
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -99,
			".." => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			"]" => -99,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP06_REGEX_MATCH' => 131,
			'OP18_TERNARY' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			")" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP08_MATH_ADD_SUB' => -99
		}
	},
	{#State 211
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP18_TERNARY' => -109,
			")" => -109,
			"}" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP17_LIST_RANGE' => -109,
			";" => -109,
			"]" => -109,
			'OP09_BITWISE_SHIFT' => 137,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -109,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => -109,
			'OP11_COMPARE_LT_GT' => 139,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140
		}
	},
	{#State 212
		DEFAULT => -98
	},
	{#State 213
		ACTIONS => {
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => -106,
			";" => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP12_COMPARE_EQ_NEQ' => undef,
			".." => -106,
			'OP11_COMPARE_LT_GT' => 139,
			'OP13_BITWISE_AND' => -106,
			'OP08_MATH_ADD_SUB' => 141,
			'OP16_LOGICAL_OR' => -106,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP18_TERNARY' => -106
		}
	},
	{#State 214
		ACTIONS => {
			'OP08_STRING_CAT' => -101,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			".." => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -101,
			"]" => -101,
			'OP09_BITWISE_SHIFT' => -101,
			";" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			"}" => -101,
			'OP18_TERNARY' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP08_MATH_ADD_SUB' => 141,
			'OP21_LIST_COMMA' => -101,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 215
		ACTIONS => {
			";" => -115,
			"]" => -115,
			'OP09_BITWISE_SHIFT' => 137,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			".." => -115,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			'OP21_LIST_COMMA' => -115,
			'OP16_LOGICAL_OR' => 135,
			'OP18_TERNARY' => 142,
			")" => -115,
			"}" => -115,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143
		}
	},
	{#State 216
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			"]" => -110,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -110,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => -110,
			'OP11_COMPARE_LT_GT' => 139,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP17_LIST_RANGE' => -110,
			")" => -110,
			"}" => -110,
			'OP18_TERNARY' => -110
		}
	},
	{#State 217
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => -107,
			'OP11_COMPARE_LT_GT' => 139,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -107,
			"]" => -107,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP18_TERNARY' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP17_LIST_RANGE' => -107,
			")" => -107,
			"}" => -107,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP21_LIST_COMMA' => -107
		}
	},
	{#State 218
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP08_MATH_ADD_SUB' => 141,
			'OP18_TERNARY' => -102,
			"}" => -102,
			")" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP23_LOGICAL_AND' => -102,
			";" => -102,
			'OP09_BITWISE_SHIFT' => -102,
			"]" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP12_COMPARE_EQ_NEQ' => -102,
			".." => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140
		}
	},
	{#State 219
		ACTIONS => {
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -105,
			".." => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP11_COMPARE_LT_GT' => undef,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -105,
			"]" => -105,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			"}" => -105,
			'OP18_TERNARY' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP08_MATH_ADD_SUB' => 141,
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 220
		ACTIONS => {
			'OP06_REGEX_MATCH' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			";" => -95,
			"]" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_STRING_CAT' => -95,
			'OP04_MATH_POW' => 140,
			'OP12_COMPARE_EQ_NEQ' => -95,
			".." => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP21_LIST_COMMA' => -95,
			")" => -95,
			"}" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95
		}
	},
	{#State 221
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			"]" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => -100,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => -100,
			".." => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP13_BITWISE_AND' => -100,
			"}" => -100,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100
		}
	},
	{#State 222
		ACTIONS => {
			'COLON' => 278
		}
	},
	{#State 223
		ACTIONS => {
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => 135,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			'OP23_LOGICAL_AND' => -111,
			'OP17_LIST_RANGE' => undef,
			"}" => -111,
			")" => -111,
			'OP18_TERNARY' => -111,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP06_REGEX_MATCH' => 131,
			'OP09_BITWISE_SHIFT' => 137,
			"]" => -111,
			";" => -111,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => 139,
			".." => -111,
			'OP12_COMPARE_EQ_NEQ' => 132
		}
	},
	{#State 224
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			";" => -114,
			'OP09_BITWISE_SHIFT' => 137,
			"]" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP18_TERNARY' => 142,
			"}" => -114,
			")" => -114,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP16_LOGICAL_OR' => 135,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141
		}
	},
	{#State 225
		ACTIONS => {
			"]" => -189,
			'OP21_LIST_COMMA' => 279,
			";" => -189,
			")" => -189
		},
		GOTOS => {
			'PAREN-51' => 280
		}
	},
	{#State 226
		DEFAULT => -124
	},
	{#State 227
		ACTIONS => {
			";" => 281
		}
	},
	{#State 228
		DEFAULT => -193
	},
	{#State 229
		ACTIONS => {
			"}" => 282
		}
	},
	{#State 230
		DEFAULT => -129
	},
	{#State 231
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP21_LIST_COMMA' => -192,
			'OP16_LOGICAL_OR' => 135,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => 144,
			")" => -192,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			"]" => -192,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -192,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139
		}
	},
	{#State 232
		ACTIONS => {
			'VARIABLE_SYMBOL' => 283
		}
	},
	{#State 233
		ACTIONS => {
			'WORD' => 285
		},
		GOTOS => {
			'PLUS-53' => 284
		}
	},
	{#State 234
		DEFAULT => -209
	},
	{#State 235
		DEFAULT => -210
	},
	{#State 236
		DEFAULT => -128
	},
	{#State 237
		ACTIONS => {
			";" => 286
		}
	},
	{#State 238
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => -200,
			'OP05_MATH_NEG' => -200,
			'WORD' => -200,
			"(" => -200,
			"%{" => -200,
			"{" => -200,
			'OP05_LOGICAL_NEG' => -200,
			"\@{" => -200,
			"undef" => -200,
			'LITERAL_NUMBER' => -200,
			'OP10_NAMED_UNARY_STRINGIFY' => -200,
			'OP22_LOGICAL_NOT' => -200,
			'OP10_NAMED_UNARY' => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'OP01_OPEN_CLOSE' => -200,
			'OP01_NAMED' => -200,
			"my" => 118,
			"[" => -200,
			'WORD_SCOPED' => -200,
			'LITERAL_STRING' => -200
		},
		GOTOS => {
			'OPTIONAL-55' => 287,
			'TypeInner' => 288
		}
	},
	{#State 239
		ACTIONS => {
			"}" => 291,
			'OP21_LIST_COMMA' => 290
		},
		GOTOS => {
			'PAREN-56' => 289
		}
	},
	{#State 240
		DEFAULT => -198
	},
	{#State 241
		DEFAULT => -197
	},
	{#State 242
		ACTIONS => {
			"(" => 292
		}
	},
	{#State 243
		ACTIONS => {
			'VARIABLE_SYMBOL' => 293
		}
	},
	{#State 244
		ACTIONS => {
			'OP18_TERNARY' => 142,
			")" => 294,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 135,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP09_BITWISE_SHIFT' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128
		}
	},
	{#State 245
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 295
		}
	},
	{#State 246
		DEFAULT => -88
	},
	{#State 247
		ACTIONS => {
			";" => 297
		}
	},
	{#State 248
		ACTIONS => {
			")" => 298
		}
	},
	{#State 249
		DEFAULT => -84
	},
	{#State 250
		DEFAULT => -196
	},
	{#State 251
		DEFAULT => -149
	},
	{#State 252
		ACTIONS => {
			";" => 299
		}
	},
	{#State 253
		ACTIONS => {
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP09_BITWISE_SHIFT' => 137,
			";" => -148,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP18_TERNARY' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135
		}
	},
	{#State 254
		ACTIONS => {
			"(" => 300
		}
	},
	{#State 255
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			";" => 301,
			'OP09_BITWISE_SHIFT' => 137,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => 144,
			'OP18_TERNARY' => 142,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			'OP16_LOGICAL_OR' => 135
		}
	},
	{#State 256
		DEFAULT => -86
	},
	{#State 257
		ACTIONS => {
			")" => 302
		}
	},
	{#State 258
		DEFAULT => -97
	},
	{#State 259
		DEFAULT => -131
	},
	{#State 260
		DEFAULT => -147
	},
	{#State 261
		DEFAULT => -118
	},
	{#State 262
		ACTIONS => {
			")" => 303
		}
	},
	{#State 263
		ACTIONS => {
			")" => 304
		}
	},
	{#State 264
		DEFAULT => -132
	},
	{#State 265
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP05_MATH_NEG' => 106,
			"for my integer" => -152,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP19_LOOP_CONTROL' => 108,
			'WORD' => 109,
			"(" => 110,
			'OP01_PRINT_VOID_PAREN' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"}" => 306,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'VARIABLE_SYMBOL' => 73,
			"my" => 74,
			'OP01_PRINT_VOID' => 78,
			'OP01_NAMED_VOID_PAREN' => 81,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			"{" => 83,
			"foreach my" => -152,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"if (" => 88,
			'OP05_LOGICAL_NEG' => 84,
			"while (" => -152
		},
		GOTOS => {
			'OPTIONAL-44' => 87,
			'Statement' => 90,
			'WordScoped' => 113,
			'Operation' => 305,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'HashReference' => 107,
			'VariableModification' => 101,
			'Variable' => 100,
			'Conditional' => 103,
			'Expression' => 77,
			'OperatorVoid' => 97,
			'PAREN-43' => 75,
			'LoopLabel' => 98,
			'ArrayDereferenced' => 76,
			'Operator' => 71,
			'VariableDeclaration' => 92,
			'Literal' => 91
		}
	},
	{#State 266
		DEFAULT => -45
	},
	{#State 267
		ACTIONS => {
			'VARIABLE_SYMBOL' => 307
		}
	},
	{#State 268
		DEFAULT => -41
	},
	{#State 269
		ACTIONS => {
			'WORD' => 308
		}
	},
	{#State 270
		ACTIONS => {
			"## no critic qw(" => 6,
			")" => 310
		},
		GOTOS => {
			'Critic' => 309
		}
	},
	{#State 271
		DEFAULT => -55
	},
	{#State 272
		ACTIONS => {
			"our %properties_class = (" => 313,
			'LITERAL_NUMBER' => -58,
			"our" => -58
		},
		GOTOS => {
			'PropertiesClass' => 311,
			'OPTIONAL-23' => 312
		}
	},
	{#State 273
		ACTIONS => {
			'OP18_TERNARY' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 134,
			"]" => 314,
			'OP09_BITWISE_SHIFT' => 137,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130
		}
	},
	{#State 274
		ACTIONS => {
			"}" => 315,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP18_TERNARY' => 142,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 140,
			'OP08_STRING_CAT' => 133,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137
		}
	},
	{#State 275
		ACTIONS => {
			"(" => -211,
			"}" => 316
		}
	},
	{#State 276
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			"<STDIN>" => 251,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 253,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'ExpressionOrStdin' => 317,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 277
		DEFAULT => -180
	},
	{#State 278
		ACTIONS => {
			'VARIABLE_SYMBOL' => 73
		},
		GOTOS => {
			'Variable' => 318
		}
	},
	{#State 279
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			"my" => 118,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'ListElement' => 319,
			'Literal' => 91,
			'Variable' => 124,
			'TypeInner' => 151,
			'Expression' => 154,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76
		}
	},
	{#State 280
		DEFAULT => -185
	},
	{#State 281
		DEFAULT => -130
	},
	{#State 282
		DEFAULT => -216
	},
	{#State 283
		DEFAULT => -217
	},
	{#State 284
		ACTIONS => {
			")" => 321,
			'WORD' => 320
		}
	},
	{#State 285
		DEFAULT => -188
	},
	{#State 286
		DEFAULT => -126
	},
	{#State 287
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"{" => 83,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70
		},
		GOTOS => {
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 322,
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107
		}
	},
	{#State 288
		DEFAULT => -199
	},
	{#State 289
		DEFAULT => -206
	},
	{#State 290
		ACTIONS => {
			'WORD' => 163,
			"%{" => 79
		},
		GOTOS => {
			'HashEntry' => 323,
			'HashDereferenced' => 165
		}
	},
	{#State 291
		DEFAULT => -208
	},
	{#State 292
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'WORD' => 24,
			"%{" => 79,
			"(" => 110,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP01_NAMED' => 96,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'Operator' => 71,
			'Literal' => 91,
			'HashReference' => 107,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76,
			'Variable' => 124,
			'Expression' => 324
		}
	},
	{#State 293
		ACTIONS => {
			"(" => 325
		}
	},
	{#State 294
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 295
		DEFAULT => -160,
		GOTOS => {
			'STAR-46' => 327
		}
	},
	{#State 296
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99,
			'VARIABLE_SYMBOL' => 73,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"my" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP05_LOGICAL_NEG' => 84,
			"if (" => 88,
			"foreach my" => -152,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			"undef" => 89,
			"while (" => -152,
			'OP01_PRINT_VOID_PAREN' => 112,
			"{" => 83,
			'OP19_LOOP_CONTROL' => 108,
			'WORD' => 109,
			"(" => 110,
			"%{" => 79,
			'OP01_NAMED_VOID' => 80,
			'OP01_NAMED_VOID_PAREN' => 81,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP01_PRINT_VOID' => 78,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 106
		},
		GOTOS => {
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'Operator' => 71,
			'ArrayDereferenced' => 76,
			'LoopLabel' => 98,
			'OperatorVoid' => 97,
			'PAREN-43' => 75,
			'Conditional' => 103,
			'Expression' => 77,
			'VariableModification' => 101,
			'Variable' => 100,
			'HashReference' => 107,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'Operation' => 328,
			'WordScoped' => 113,
			'Statement' => 90,
			'PLUS-49' => 329,
			'OPTIONAL-44' => 87
		}
	},
	{#State 297
		DEFAULT => -92
	},
	{#State 298
		DEFAULT => -90
	},
	{#State 299
		DEFAULT => -182
	},
	{#State 300
		ACTIONS => {
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			")" => -135,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79,
			'OP01_QW' => 153,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			"my" => 118,
			'OP01_NAMED' => 96
		},
		GOTOS => {
			'Variable' => 124,
			'OPTIONAL-42' => 330,
			'Expression' => 154,
			'ListElements' => 331,
			'TypeInner' => 151,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'ListElement' => 145,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 301
		DEFAULT => -183
	},
	{#State 302
		ACTIONS => {
			";" => 332
		}
	},
	{#State 303
		ACTIONS => {
			";" => 333
		}
	},
	{#State 304
		DEFAULT => -145
	},
	{#State 305
		DEFAULT => -44
	},
	{#State 306
		ACTIONS => {
			";" => 334
		}
	},
	{#State 307
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 335
		}
	},
	{#State 308
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 336
		}
	},
	{#State 309
		ACTIONS => {
			"%{" => 79,
			'WORD' => 337
		},
		GOTOS => {
			'HashEntryTyped' => 339,
			'HashDereferenced' => 338
		}
	},
	{#State 310
		ACTIONS => {
			";" => 340
		}
	},
	{#State 311
		DEFAULT => -57
	},
	{#State 312
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 341
		}
	},
	{#State 313
		ACTIONS => {
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 342
		}
	},
	{#State 314
		DEFAULT => -177
	},
	{#State 315
		DEFAULT => -178
	},
	{#State 316
		DEFAULT => -179
	},
	{#State 317
		ACTIONS => {
			";" => 343
		}
	},
	{#State 318
		DEFAULT => -112
	},
	{#State 319
		DEFAULT => -184
	},
	{#State 320
		DEFAULT => -187
	},
	{#State 321
		DEFAULT => -190
	},
	{#State 322
		ACTIONS => {
			'OP16_LOGICAL_OR' => 135,
			'OP21_LIST_COMMA' => -201,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			"}" => -201,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => 144,
			'OP18_TERNARY' => 142,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132
		}
	},
	{#State 323
		DEFAULT => -205
	},
	{#State 324
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP16_LOGICAL_OR' => 135,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP18_TERNARY' => 142,
			'OP06_REGEX_MATCH' => 131,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP12_COMPARE_EQ_NEQ' => 132,
			".." => 344,
			'OP11_COMPARE_LT_GT' => 139
		}
	},
	{#State 325
		ACTIONS => {
			'OP01_QW' => 153,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			"my" => 118,
			'OP01_NAMED' => 96,
			'KEYS_OR_VALUES' => 147,
			"{" => 83,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 24,
			"(" => 110,
			"%{" => 79
		},
		GOTOS => {
			'HashReference' => 107,
			'Operator' => 71,
			'ListElement' => 145,
			'Literal' => 91,
			'Variable' => 124,
			'Expression' => 154,
			'ListElements' => 345,
			'TypeInner' => 151,
			'ArrayReference' => 111,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayDereferenced' => 76
		}
	},
	{#State 326
		DEFAULT => -170
	},
	{#State 327
		ACTIONS => {
			"while (" => -163,
			'OP05_LOGICAL_NEG' => -163,
			"foreach my" => -163,
			"if (" => -163,
			"\@{" => -163,
			'LITERAL_NUMBER' => -163,
			"undef" => -163,
			"elsif (" => 350,
			"{" => -163,
			"%{" => -163,
			'OP01_NAMED_VOID' => -163,
			'OP01_NAMED_VOID_PAREN' => -163,
			'' => -163,
			'OP01_PRINT_VOID' => -163,
			"my" => -163,
			'VARIABLE_SYMBOL' => -163,
			'OP10_NAMED_UNARY' => -163,
			'OP22_LOGICAL_NOT' => -163,
			"}" => -163,
			'OP10_NAMED_UNARY_STRINGIFY' => -163,
			'OP01_PRINT_VOID_PAREN' => -163,
			"(" => -163,
			'OP19_LOOP_CONTROL' => -163,
			'WORD' => -163,
			'OP01_OPEN_CLOSE_PAREN' => -163,
			'OP05_MATH_NEG' => -163,
			"for my integer" => -163,
			'LITERAL_STRING' => -163,
			'WORD_SCOPED' => -163,
			"[" => -163,
			'OP01_NAMED' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP01_OPEN_CLOSE' => -163,
			"else" => 346
		},
		GOTOS => {
			'PAREN-47' => 349,
			'OPTIONAL-48' => 347,
			'PAREN-45' => 348
		}
	},
	{#State 328
		DEFAULT => -172
	},
	{#State 329
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 81,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			'OP01_PRINT_VOID' => 78,
			"undef" => 89,
			"foreach my" => -152,
			"if (" => 88,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 84,
			"while (" => -152,
			"{" => 83,
			'VARIABLE_SYMBOL' => 73,
			"my" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'WORD' => 109,
			'OP19_LOOP_CONTROL' => 108,
			"(" => 110,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"}" => 351,
			'OP01_PRINT_VOID_PAREN' => 112,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"[" => 99
		},
		GOTOS => {
			'Operator' => 71,
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'Variable' => 100,
			'VariableModification' => 101,
			'Expression' => 77,
			'Conditional' => 103,
			'PAREN-43' => 75,
			'OperatorVoid' => 97,
			'ArrayDereferenced' => 76,
			'LoopLabel' => 98,
			'HashReference' => 107,
			'OPTIONAL-44' => 87,
			'Statement' => 90,
			'Operation' => 352,
			'HashDereferenced' => 82,
			'WordScoped' => 113,
			'ArrayReference' => 111
		}
	},
	{#State 330
		ACTIONS => {
			")" => 353
		}
	},
	{#State 331
		DEFAULT => -134
	},
	{#State 332
		DEFAULT => -91
	},
	{#State 333
		DEFAULT => -127
	},
	{#State 334
		DEFAULT => -46
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 356,
			")" => 355
		},
		GOTOS => {
			'PAREN-18' => 354
		}
	},
	{#State 336
		DEFAULT => -215
	},
	{#State 337
		ACTIONS => {
			'OP20_HASH_FATARROW' => 357
		}
	},
	{#State 338
		DEFAULT => -204
	},
	{#State 339
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 358
		}
	},
	{#State 340
		ACTIONS => {
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 359
		}
	},
	{#State 341
		ACTIONS => {
			"our" => 363,
			'LITERAL_NUMBER' => 364
		},
		GOTOS => {
			'Method' => 361,
			'MethodOrSubroutine' => 362,
			'Subroutine' => 360
		}
	},
	{#State 342
		ACTIONS => {
			'WORD' => 337,
			"%{" => 79
		},
		GOTOS => {
			'HashDereferenced' => 338,
			'HashEntryTyped' => 365
		}
	},
	{#State 343
		DEFAULT => -181
	},
	{#State 344
		ACTIONS => {
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'LITERAL_NUMBER' => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			"undef" => 89,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83
		},
		GOTOS => {
			'Literal' => 91,
			'Operator' => 71,
			'HashReference' => 107,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'Expression' => 366,
			'Variable' => 124
		}
	},
	{#State 345
		ACTIONS => {
			")" => 367
		}
	},
	{#State 346
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 368
		}
	},
	{#State 347
		DEFAULT => -164
	},
	{#State 348
		DEFAULT => -159
	},
	{#State 349
		DEFAULT => -162
	},
	{#State 350
		ACTIONS => {
			'OP01_NAMED' => 96,
			'VARIABLE_SYMBOL' => 73,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			"%{" => 79,
			"(" => 110,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP05_MATH_NEG' => 106,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 89,
			"{" => 83
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 369,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 351
		DEFAULT => -173
	},
	{#State 352
		DEFAULT => -171
	},
	{#State 353
		DEFAULT => -146
	},
	{#State 354
		DEFAULT => -48
	},
	{#State 355
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 370
		}
	},
	{#State 356
		ACTIONS => {
			"my" => 371
		}
	},
	{#State 357
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInner' => 372
		}
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 374,
			")" => 375
		},
		GOTOS => {
			'PAREN-25' => 373
		}
	},
	{#State 359
		DEFAULT => -66
	},
	{#State 360
		DEFAULT => -81
	},
	{#State 361
		DEFAULT => -80
	},
	{#State 362
		DEFAULT => -59
	},
	{#State 363
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 376
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 364
		ACTIONS => {
			";" => 377
		}
	},
	{#State 365
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 378
		}
	},
	{#State 366
		ACTIONS => {
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP09_BITWISE_SHIFT' => 137,
			'OP23_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => 379,
			'OP18_TERNARY' => 142,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			'OP16_LOGICAL_OR' => 135
		}
	},
	{#State 367
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 368
		DEFAULT => -161
	},
	{#State 369
		ACTIONS => {
			'OP16_LOGICAL_OR' => 135,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 141,
			")" => 381,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => 144,
			'OP18_TERNARY' => 142,
			'OP15_LOGICAL_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP06_REGEX_MATCH' => 131,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP09_BITWISE_SHIFT' => 137,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => 139,
			'OP12_COMPARE_EQ_NEQ' => 132
		}
	},
	{#State 370
		ACTIONS => {
			"\@_;" => 382
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 383
		}
	},
	{#State 372
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22,
			"[" => 99,
			'OP01_NAMED' => 96,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_OPEN_CLOSE' => 94,
			'VARIABLE_SYMBOL' => 73,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"undef" => 89,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 84,
			"{" => 83,
			"(" => 110,
			"%{" => 79,
			'WORD' => 24,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105
		},
		GOTOS => {
			'Variable' => 124,
			'Expression' => 384,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'HashDereferenced' => 82,
			'ArrayDereferenced' => 76,
			'HashReference' => 107,
			'Operator' => 71,
			'Literal' => 91
		}
	},
	{#State 373
		DEFAULT => -63
	},
	{#State 374
		ACTIONS => {
			'WORD' => 337,
			"%{" => 79
		},
		GOTOS => {
			'HashDereferenced' => 338,
			'HashEntryTyped' => 385
		}
	},
	{#State 375
		ACTIONS => {
			";" => 386
		}
	},
	{#State 376
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 377
		DEFAULT => -61
	},
	{#State 378
		ACTIONS => {
			'OP21_LIST_COMMA' => 388,
			")" => 389
		},
		GOTOS => {
			'PAREN-27' => 390
		}
	},
	{#State 379
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 380
		DEFAULT => -169
	},
	{#State 381
		ACTIONS => {
			"{" => 296
		},
		GOTOS => {
			'CodeBlock' => 392
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
			'OP14_BITWISE_OR_XOR' => 128,
			'OP06_REGEX_MATCH' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 129,
			'OP15_LOGICAL_AND' => 130,
			'OP09_BITWISE_SHIFT' => 137,
			'OP08_STRING_CAT' => 133,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP11_COMPARE_LT_GT' => 139,
			'OP08_MATH_ADD_SUB' => 141,
			'OP13_BITWISE_AND' => 136,
			'OP21_LIST_COMMA' => -203,
			'OP16_LOGICAL_OR' => 135,
			'OP17_LIST_RANGE' => 143,
			'OP23_LOGICAL_AND' => 144,
			")" => -203,
			'OP18_TERNARY' => 142
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
			"= sub {" => 394
		}
	},
	{#State 388
		ACTIONS => {
			'WORD' => 337,
			"%{" => 79
		},
		GOTOS => {
			'HashDereferenced' => 338,
			'HashEntryTyped' => 395
		}
	},
	{#State 389
		ACTIONS => {
			";" => 396
		}
	},
	{#State 390
		DEFAULT => -68
	},
	{#State 391
		DEFAULT => -168
	},
	{#State 392
		DEFAULT => -158
	},
	{#State 393
		DEFAULT => -47
	},
	{#State 394
		ACTIONS => {
			'OP05_MATH_NEG' => -72,
			"for my integer" => -72,
			'OP01_OPEN_CLOSE_PAREN' => -72,
			'OP19_LOOP_CONTROL' => -72,
			'WORD' => -72,
			"(" => -72,
			'OP01_PRINT_VOID_PAREN' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'OP01_OPEN_CLOSE' => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_NAMED' => -72,
			"[" => -72,
			'WORD_SCOPED' => -72,
			'LITERAL_STRING' => -72,
			'OP01_PRINT_VOID' => -72,
			'OP01_NAMED_VOID_PAREN' => -72,
			'OP01_NAMED_VOID' => -72,
			"%{" => -72,
			"{" => -72,
			"if (" => -72,
			"\@{" => -72,
			"undef" => -72,
			"foreach my" => -72,
			'LITERAL_NUMBER' => -72,
			'OP05_LOGICAL_NEG' => -72,
			"( my" => 397,
			"while (" => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP10_NAMED_UNARY' => -72,
			'VARIABLE_SYMBOL' => -72,
			"my" => -72
		},
		GOTOS => {
			'MethodArguments' => 399,
			'OPTIONAL-29' => 398
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
			'OP05_MATH_NEG' => 106,
			"for my integer" => -152,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'OP01_PRINT_VOID' => 78,
			'OP01_NAMED_VOID_PAREN' => 81,
			"(" => 110,
			'OP01_NAMED_VOID' => 80,
			"%{" => 79,
			'OP19_LOOP_CONTROL' => 108,
			'WORD' => 109,
			"{" => 83,
			'OP01_PRINT_VOID_PAREN' => 112,
			"while (" => -152,
			"foreach my" => -152,
			"undef" => 89,
			"if (" => 88,
			'LITERAL_NUMBER' => 85,
			"\@{" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			'OP05_LOGICAL_NEG' => 84,
			'OP10_NAMED_UNARY' => 72,
			'OP22_LOGICAL_NOT' => 70,
			"my" => 74,
			'OP01_NAMED' => 96,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'VARIABLE_SYMBOL' => 73,
			"[" => 99,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Operation' => 401,
			'Statement' => 90,
			'OPTIONAL-44' => 87,
			'HashReference' => 107,
			'PLUS-30' => 402,
			'ArrayDereferenced' => 76,
			'LoopLabel' => 98,
			'OperatorVoid' => 97,
			'PAREN-43' => 75,
			'Conditional' => 103,
			'Expression' => 77,
			'VariableModification' => 101,
			'Variable' => 100,
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'Operator' => 71
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
		DEFAULT => -74
	},
	{#State 402
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP10_NAMED_UNARY' => 72,
			'VARIABLE_SYMBOL' => 73,
			"my" => 74,
			'OP01_PRINT_VOID' => 78,
			'OP01_NAMED_VOID_PAREN' => 81,
			"%{" => 79,
			'OP01_NAMED_VOID' => 80,
			"{" => 83,
			"undef" => 89,
			"foreach my" => -152,
			"if (" => 88,
			"\@{" => 86,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 84,
			"while (" => -152,
			'OP01_OPEN_CLOSE' => 94,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 96,
			"[" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 102,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 106,
			'OP01_OPEN_CLOSE_PAREN' => 105,
			'WORD' => 109,
			'OP19_LOOP_CONTROL' => 108,
			"(" => 110,
			'OP01_PRINT_VOID_PAREN' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 115,
			"}" => 404
		},
		GOTOS => {
			'HashReference' => 107,
			'OPTIONAL-44' => 87,
			'Statement' => 90,
			'HashDereferenced' => 82,
			'ArrayReference' => 111,
			'WordScoped' => 113,
			'Operation' => 405,
			'Operator' => 71,
			'Literal' => 91,
			'VariableDeclaration' => 92,
			'VariableModification' => 101,
			'Variable' => 100,
			'Expression' => 77,
			'Conditional' => 103,
			'PAREN-43' => 75,
			'OperatorVoid' => 97,
			'LoopLabel' => 98,
			'ArrayDereferenced' => 76
		}
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 408,
			")" => 406
		},
		GOTOS => {
			'PAREN-31' => 407
		}
	},
	{#State 404
		ACTIONS => {
			";" => 409
		}
	},
	{#State 405
		DEFAULT => -73
	},
	{#State 406
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 407
		DEFAULT => -77
	},
	{#State 408
		ACTIONS => {
			"my" => 411
		}
	},
	{#State 409
		DEFAULT => -75
	},
	{#State 410
		ACTIONS => {
			"\@_;" => 412
		}
	},
	{#State 411
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 413
		}
	},
	{#State 412
		DEFAULT => -79
	},
	{#State 413
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 414
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5593 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5600 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5607 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5614 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5625 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5636 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5643 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5650 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5756 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5906 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5956 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5967 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5974 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5981 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6123 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6137 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6284 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6291 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6298 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6305 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6411 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6532 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6554 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6576 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6587 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6605 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6619 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6712 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_148
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_149
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 4,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-49', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7143 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_189
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_190
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7342 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7353 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_197
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_198
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_203
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_204
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_209
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_210
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7520 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_215
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_216
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_217
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_218
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7586 lib/RPerl/Grammar.pm
	]
],
#line 7589 lib/RPerl/Grammar.pm
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
         'TypeInner_215', 
         'FileHandle_216', 
         'FileHandle_217', 
         'Literal_218', 
         'Literal_219', );
  $self;
}

#line 181 "lib/RPerl/Grammar.eyp"


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


#line 7857 lib/RPerl/Grammar.pm



1;
