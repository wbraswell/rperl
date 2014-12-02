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
    our $VERSION = 0.000_750;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|__method|while\ \(|\=\ sub\ \{|elsif\ \(|package|\<STDIN\>|\$TYPED_|undef|\(\ my|if\ \(|else|use|\@_\;|our|qw\(|my|\%\{|\@\{|\{\*|\.\.|\[|\)|\}|\(|\;|\{|\]|\/)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ \=\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(::[a-zA-Z]\w*__CHECK(TRACE)?)/gc and return ('CHECK_OR_CHECKTRACE', $1);
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
      /\G(scalar)/gc and return ('OP10_NAMED_UNARY', $1);
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
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-20' ], 0 ],
  [ '_PAREN' => 'PAREN-21', [ 'OP21_LIST_COMMA', 'Expression', 'OP21_LIST_COMMA', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'PAREN-21' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ 'ArgumentCheck_56' => 'ArgumentCheck', [ 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-22', ')', ';' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [ 'PropertiesClass' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Class_67' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-23', 'STAR-24', 'STAR-25', 'Properties', 'OPTIONAL-26', 'STAR-27', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-28', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'PAREN-28' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'Properties_71' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-29', ')', ';' ], 0 ],
  [ 'Properties_72' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'PropertiesClass_76' => 'PropertiesClass', [ 'our %properties_class = (', 'Critic', 'HashEntryTyped', 'STAR-31', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'PLUS-33', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'Operation' ], 0 ],
  [ 'Method_81' => 'Method', [ 'our', 'TypeMethod', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-32', 'PLUS-33', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'PAREN-34' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'MethodArguments_87' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-35', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-36' ], 0 ],
  [ 'MethodOrSubroutine_88' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_89' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_90' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_91' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-37', ')' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP01_OPEN_CLOSE_PAREN', 'FileHandle', 'OPTIONAL-38', ')', ';' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP01_OPEN_CLOSE', 'FileHandle', 'OPTIONAL-39', ';' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'OperatorVoid_132' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_133' => 'OperatorVoid', [ 'OP01_PRINT_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandle', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_148' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-44', ')' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_152' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_153' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_154' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'PAREN-46' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'Statement_158' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_159' => 'Statement', [ 'OPTIONAL-47', 'Loop' ], 0 ],
  [ 'Statement_160' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'PAREN-50' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'Conditional_169' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-49', 'OPTIONAL-51' ], 0 ],
  [ 'Loop_170' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_171' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_172' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_173' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_174' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_175' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'Operation' ], 0 ],
  [ 'CodeBlock_178' => 'CodeBlock', [ '{', 'PLUS-52', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'Variable_181' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-53' ], 0 ],
  [ 'VariableRetrieval_182' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_183' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_184' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_186' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_188' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-54', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [ 'STAR-55', 'PAREN-54' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-56', [ 'PLUS-56', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-56', [ 'WORD' ], 0 ],
  [ 'ListElements_194' => 'ListElements', [ 'ListElement', 'STAR-55' ], 0 ],
  [ 'ListElements_195' => 'ListElements', [ 'OP01_QW', '(', 'PLUS-56', ')' ], 0 ],
  [ 'ListElement_196' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_197' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_198' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'ArrayReference_201' => 'ArrayReference', [ '[', 'OPTIONAL-57', ']' ], 0 ],
  [ 'ArrayDereferenced_202' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_203' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-58', 'Expression' ], 0 ],
  [ 'HashEntry_207' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_208' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_209' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-59', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [ 'STAR-60', 'PAREN-59' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [  ], 0 ],
  [ 'HashReference_213' => 'HashReference', [ '{', 'HashEntry', 'STAR-60', '}' ], 0 ],
  [ 'HashDereferenced_214' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_215' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_216' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_217' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_218' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_219' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeMethod_220' => 'TypeMethod', [ 'WORD', '__method' ], 0 ],
  [ 'TypeInner_221' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandle_222' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_223' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'Literal_224' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_225' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_STAR_LIST' => 50,
  '_STAR_LIST' => 51,
  'SubroutineArguments_52' => 52,
  '_PAREN' => 53,
  '_OPTIONAL' => 54,
  '_OPTIONAL' => 55,
  'ArgumentCheck_56' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  '_OPTIONAL' => 63,
  '_OPTIONAL' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  'Class_67' => 67,
  '_PAREN' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  'Properties_71' => 71,
  'Properties_72' => 72,
  '_PAREN' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'PropertiesClass_76' => 76,
  '_OPTIONAL' => 77,
  '_OPTIONAL' => 78,
  '_PLUS_LIST' => 79,
  '_PLUS_LIST' => 80,
  'Method_81' => 81,
  '_PAREN' => 82,
  '_STAR_LIST' => 83,
  '_STAR_LIST' => 84,
  '_STAR_LIST' => 85,
  '_STAR_LIST' => 86,
  'MethodArguments_87' => 87,
  'MethodOrSubroutine_88' => 88,
  'MethodOrSubroutine_89' => 89,
  'Operation_90' => 90,
  'Operation_91' => 91,
  '_OPTIONAL' => 92,
  '_OPTIONAL' => 93,
  '_OPTIONAL' => 94,
  '_OPTIONAL' => 95,
  '_OPTIONAL' => 96,
  '_OPTIONAL' => 97,
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
  'Operator_116' => 116,
  'Operator_117' => 117,
  'Operator_118' => 118,
  'Operator_119' => 119,
  'Operator_120' => 120,
  'Operator_121' => 121,
  'Operator_122' => 122,
  'Operator_123' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  'OperatorVoid_132' => 132,
  'OperatorVoid_133' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'Expression_148' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'ExpressionOrStdin_153' => 153,
  'ExpressionOrStdin_154' => 154,
  '_PAREN' => 155,
  '_OPTIONAL' => 156,
  '_OPTIONAL' => 157,
  'Statement_158' => 158,
  'Statement_159' => 159,
  'Statement_160' => 160,
  'Statement_161' => 161,
  'Statement_162' => 162,
  '_PAREN' => 163,
  '_STAR_LIST' => 164,
  '_STAR_LIST' => 165,
  '_PAREN' => 166,
  '_OPTIONAL' => 167,
  '_OPTIONAL' => 168,
  'Conditional_169' => 169,
  'Loop_170' => 170,
  'Loop_171' => 171,
  'Loop_172' => 172,
  'LoopFor_173' => 173,
  'LoopForEach_174' => 174,
  'LoopWhile_175' => 175,
  '_PLUS_LIST' => 176,
  '_PLUS_LIST' => 177,
  'CodeBlock_178' => 178,
  '_STAR_LIST' => 179,
  '_STAR_LIST' => 180,
  'Variable_181' => 181,
  'VariableRetrieval_182' => 182,
  'VariableRetrieval_183' => 183,
  'VariableRetrieval_184' => 184,
  'VariableDeclaration_185' => 185,
  'VariableDeclaration_186' => 186,
  'VariableModification_187' => 187,
  'VariableModification_188' => 188,
  '_PAREN' => 189,
  '_STAR_LIST' => 190,
  '_STAR_LIST' => 191,
  '_PLUS_LIST' => 192,
  '_PLUS_LIST' => 193,
  'ListElements_194' => 194,
  'ListElements_195' => 195,
  'ListElement_196' => 196,
  'ListElement_197' => 197,
  'ListElement_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'ArrayReference_201' => 201,
  'ArrayDereferenced_202' => 202,
  'ArrayDereferenced_203' => 203,
  '_OPTIONAL' => 204,
  '_OPTIONAL' => 205,
  'HashEntry_206' => 206,
  'HashEntry_207' => 207,
  'HashEntryTyped_208' => 208,
  'HashEntryTyped_209' => 209,
  '_PAREN' => 210,
  '_STAR_LIST' => 211,
  '_STAR_LIST' => 212,
  'HashReference_213' => 213,
  'HashDereferenced_214' => 214,
  'HashDereferenced_215' => 215,
  'WordScoped_216' => 216,
  'WordScoped_217' => 217,
  'LoopLabel_218' => 218,
  'Type_219' => 219,
  'TypeMethod_220' => 220,
  'TypeInner_221' => 221,
  'FileHandle_222' => 222,
  'FileHandle_223' => 223,
  'Literal_224' => 224,
  'Literal_225' => 225,
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
	CHECK_OR_CHECKTRACE => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 8
		},
		GOTOS => {
			'PLUS-2' => 5,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 9,
			'Critic' => 3,
			'CompileUnit' => 7,
			'ModuleHeader' => 6,
			'Program' => 2
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 5
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 13,
			'Critic' => 3,
			'ModuleHeader' => 6
		}
	},
	{#State 6
		ACTIONS => {
			"our" => -25,
			"use parent qw(" => 17,
			"use" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Package' => 18,
			'STAR-10' => 14,
			'Class' => 15
		}
	},
	{#State 7
		ACTIONS => {
			'' => 19
		}
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 21
		}
	},
	{#State 9
		DEFAULT => -3
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
		DEFAULT => -35
	},
	{#State 12
		ACTIONS => {
			")" => 26,
			'WORD' => 25
		}
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 27,
			'STAR-11' => 28
		}
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -217
	},
	{#State 24
		DEFAULT => -216
	},
	{#State 25
		DEFAULT => -34
	},
	{#State 26
		DEFAULT => -36
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 35
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 33
		}
	},
	{#State 29
		ACTIONS => {
			")" => 36
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
			"use warnings;" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"our" => 44,
			"use constant" => 42
		},
		GOTOS => {
			'Constant' => 40,
			'PLUS-13' => 43,
			'Subroutine' => 41
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 45
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
			"foreach my" => -11,
			"%{" => -11,
			"(" => -11,
			"use constant" => -11,
			'OP05_MATH_NEG' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"{" => -11,
			'WORD' => -11,
			"for my integer" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"if (" => -11,
			"[" => -11,
			'LITERAL_NUMBER' => -11,
			"## no critic qw(" => 4,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			"our" => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			"while (" => -11,
			'LITERAL_STRING' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN_CLOSE' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"my" => -11,
			"undef" => -11,
			'OP01_PRINT_VOID' => -11,
			"use" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP22_LOGICAL_NOT' => -11
		},
		GOTOS => {
			'STAR-5' => 47,
			'Critic' => 48
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
		DEFAULT => -28
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'WORD' => 50
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 52
		},
		GOTOS => {
			'Subroutine' => 51
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 45
		ACTIONS => {
			"qw(" => 55,
			";" => 56
		}
	},
	{#State 46
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 47
		ACTIONS => {
			'OP10_NAMED_UNARY' => -13,
			'OP01_PRINT_VOID' => -13,
			"use" => 35,
			'OP01_NAMED_VOID' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP01_NAMED' => -13,
			'OP01_OPEN_CLOSE' => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			"undef" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			"our" => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"while (" => -13,
			'LITERAL_STRING' => -13,
			"[" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_SCOPED' => -13,
			"for my integer" => -13,
			"if (" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_MATH_NEG' => -13,
			'WORD' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"{" => -13,
			"%{" => -13,
			"(" => -13,
			"\@{" => -13,
			"foreach my" => -13,
			"use constant" => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 58
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			"our" => 60
		}
	},
	{#State 50
		ACTIONS => {
			'OP20_HASH_FATARROW' => 61
		}
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			";" => 62
		}
	},
	{#State 53
		DEFAULT => -219
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 55
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 56
		DEFAULT => -39
	},
	{#State 57
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 66
		}
	},
	{#State 58
		ACTIONS => {
			'OP05_MATH_NEG' => -15,
			'WORD' => -15,
			"{" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"%{" => -15,
			"(" => -15,
			"\@{" => -15,
			"foreach my" => -15,
			"use constant" => 42,
			"[" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_SCOPED' => -15,
			"for my integer" => -15,
			"if (" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN_CLOSE' => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			"undef" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"my" => -15,
			"our" => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			"while (" => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_PRINT_VOID' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP22_LOGICAL_NOT' => -15
		},
		GOTOS => {
			'Constant' => 67,
			'STAR-7' => 68
		}
	},
	{#State 59
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 70
		}
	},
	{#State 62
		DEFAULT => -32
	},
	{#State 63
		ACTIONS => {
			"= sub {" => 72
		}
	},
	{#State 64
		DEFAULT => -38
	},
	{#State 65
		ACTIONS => {
			")" => 74,
			'WORD' => 73
		}
	},
	{#State 66
		ACTIONS => {
			"use" => -60,
			"use constant" => -60,
			"## no critic qw(" => 4,
			"our %properties = (" => -60
		},
		GOTOS => {
			'Critic' => 75,
			'STAR-24' => 76
		}
	},
	{#State 67
		DEFAULT => -12
	},
	{#State 68
		ACTIONS => {
			'OP01_PRINT_VOID' => 102,
			'OP10_NAMED_UNARY' => 105,
			'OP01_NAMED_VOID' => 107,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_PRINT_VOID_PAREN' => 116,
			'OP01_NAMED_VOID_PAREN' => 119,
			"our" => 44,
			'LITERAL_STRING' => 122,
			"while (" => -157,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			"my" => 114,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 115,
			"for my integer" => -157,
			'OP03_MATH_INC_DEC' => 85,
			"if (" => 87,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 82,
			"foreach my" => -157,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'OP05_MATH_NEG' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'WORD' => 93
		},
		GOTOS => {
			'Literal' => 77,
			'Subroutine' => 78,
			'VariableModification' => 101,
			'HashReference' => 80,
			'Expression' => 104,
			'OperatorVoid' => 84,
			'OPTIONAL-47' => 83,
			'Operator' => 103,
			'Operation' => 106,
			'PLUS-8' => 86,
			'Statement' => 112,
			'ArrayDereferenced' => 92,
			'LoopLabel' => 90,
			'Variable' => 97,
			'HashDereferenced' => 98,
			'PAREN-46' => 118,
			'WordScoped' => 117,
			'VariableDeclaration' => 121,
			'ArrayReference' => 100,
			'Conditional' => 99
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 123
		}
	},
	{#State 71
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'OP01_NAMED' => -43,
			'OP01_OPEN_CLOSE' => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			"undef" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"my" => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			"while (" => -43,
			'VARIABLE_SYMBOL' => -43,
			'LITERAL_STRING' => -43,
			"( my" => 127,
			'OP10_NAMED_UNARY' => -43,
			'OP01_PRINT_VOID' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP05_MATH_NEG' => -43,
			'WORD' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"{" => -43,
			"(" => -43,
			"%{" => -43,
			"\@{" => -43,
			"foreach my" => -43,
			"[" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LITERAL_NUMBER' => -43,
			'WORD_SCOPED' => -43,
			"for my integer" => -43,
			"if (" => -43,
			'OP03_MATH_INC_DEC' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 125,
			'SubroutineArguments' => 126
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			";" => 128
		}
	},
	{#State 75
		DEFAULT => -57
	},
	{#State 76
		ACTIONS => {
			"use" => 35,
			"our %properties = (" => -62,
			"use constant" => -62
		},
		GOTOS => {
			'Include' => 129,
			'STAR-25' => 130
		}
	},
	{#State 77
		DEFAULT => -142
	},
	{#State 78
		DEFAULT => -14
	},
	{#State 79
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP01_QW' => 131,
			"[" => 79,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"]" => -200,
			"%{" => 95,
			"(" => 96,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			"my" => 71,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110
		},
		GOTOS => {
			'Expression' => 137,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'OPTIONAL-57' => 136,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayReference' => 100,
			'ListElements' => 132,
			'Literal' => 77,
			'TypeInner' => 138,
			'ListElement' => 135,
			'ArrayDereferenced' => 92,
			'HashReference' => 80
		}
	},
	{#State 80
		DEFAULT => -146
	},
	{#State 81
		DEFAULT => -225
	},
	{#State 82
		ACTIONS => {
			'WORD' => 140
		},
		GOTOS => {
			'LoopLabel' => 139
		}
	},
	{#State 83
		ACTIONS => {
			"while (" => 142,
			"foreach my" => 147,
			"for my integer" => 144
		},
		GOTOS => {
			'Loop' => 145,
			'LoopForEach' => 143,
			'LoopFor' => 146,
			'LoopWhile' => 141
		}
	},
	{#State 84
		DEFAULT => -160
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 148
		}
	},
	{#State 86
		ACTIONS => {
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 114,
			'OP01_NAMED_VOID_PAREN' => 119,
			'OP01_PRINT_VOID_PAREN' => 116,
			"while (" => -157,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'' => -18,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED_VOID' => 107,
			'OP22_LOGICAL_NOT' => 108,
			'OP05_MATH_NEG' => 88,
			'WORD' => 93,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			"foreach my" => -157,
			"[" => 79,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"for my integer" => -157,
			"if (" => 87,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'LoopLabel' => 90,
			'Statement' => 112,
			'ArrayReference' => 100,
			'VariableDeclaration' => 121,
			'Conditional' => 99,
			'Variable' => 97,
			'HashDereferenced' => 98,
			'PAREN-46' => 118,
			'WordScoped' => 117,
			'VariableModification' => 101,
			'HashReference' => 80,
			'Literal' => 77,
			'Operation' => 149,
			'OperatorVoid' => 84,
			'Expression' => 104,
			'OPTIONAL-47' => 83,
			'Operator' => 103
		}
	},
	{#State 87
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Expression' => 150,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100
		}
	},
	{#State 88
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'WORD' => 24,
			"undef" => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'Expression' => 151,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 89
		ACTIONS => {
			'WORD' => 155,
			"}" => 154,
			"%{" => 95
		},
		GOTOS => {
			'HashEntry' => 152,
			'HashDereferenced' => 153
		}
	},
	{#State 90
		ACTIONS => {
			'COLON' => 156
		}
	},
	{#State 91
		ACTIONS => {
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 24,
			"undef" => 115,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 157,
			'ArrayReference' => 100
		}
	},
	{#State 92
		DEFAULT => -145
	},
	{#State 93
		ACTIONS => {
			"(" => -216,
			'COLON' => -218
		}
	},
	{#State 94
		ACTIONS => {
			"[" => 79,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 159,
			'ArrayReference' => 158
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120,
			"{" => 161
		},
		GOTOS => {
			'Variable' => 162,
			'HashReference' => 160
		}
	},
	{#State 96
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			"undef" => 115
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'HashDereferenced' => 98,
			'Expression' => 163,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100
		}
	},
	{#State 97
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -143,
			'OP11_COMPARE_LT_GT' => -143,
			'OP02_METHOD_THINARROW' => 166,
			'OP16_LOGICAL_OR' => -143,
			'OP15_LOGICAL_AND' => -143,
			'OP07_MATH_MULT_DIV_MOD' => -143,
			";" => -143,
			'OP12_COMPARE_EQ_NEQ' => -143,
			'OP17_LIST_RANGE' => -143,
			'OP19_VARIABLE_ASSIGN' => 164,
			'OP14_BITWISE_OR_XOR' => -143,
			'OP19_VARIABLE_ASSIGN_BY' => 167,
			'OP08_STRING_CAT' => -143,
			'OP03_MATH_INC_DEC' => 165,
			'OP04_MATH_POW' => -143,
			'OP23_LOGICAL_AND' => -143,
			'OP18_TERNARY' => -143,
			'OP08_MATH_ADD_SUB' => -143,
			'OP24_LOGICAL_OR_XOR' => -143,
			'OP06_REGEX_MATCH' => -143,
			'OP13_BITWISE_AND' => -143
		}
	},
	{#State 98
		DEFAULT => -147
	},
	{#State 99
		DEFAULT => -158
	},
	{#State 100
		DEFAULT => -144
	},
	{#State 101
		DEFAULT => -162
	},
	{#State 102
		ACTIONS => {
			"{*" => 169,
			"my" => 170
		},
		GOTOS => {
			'FileHandle' => 168
		}
	},
	{#State 103
		DEFAULT => -149
	},
	{#State 104
		ACTIONS => {
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => 178
		}
	},
	{#State 105
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			"undef" => 115,
			'WORD' => 24,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 188,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayReference' => 100
		}
	},
	{#State 106
		DEFAULT => -17
	},
	{#State 107
		ACTIONS => {
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			";" => -129,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'KEYS_OR_VALUES' => 133,
			"my" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'OP01_QW' => 131,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'Expression' => 137,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayReference' => 100,
			'ListElements' => 189,
			'Literal' => 77,
			'TypeInner' => 138,
			'ListElement' => 135,
			'ArrayDereferenced' => 92,
			'OPTIONAL-42' => 190,
			'HashReference' => 80
		}
	},
	{#State 108
		ACTIONS => {
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"undef" => 115,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Expression' => 191,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77
		}
	},
	{#State 109
		ACTIONS => {
			"{*" => 169,
			"my" => 170
		},
		GOTOS => {
			'FileHandle' => 192
		}
	},
	{#State 110
		ACTIONS => {
			"(" => 193
		}
	},
	{#State 111
		ACTIONS => {
			"my" => 170,
			"{*" => 169
		},
		GOTOS => {
			'FileHandle' => 194
		}
	},
	{#State 112
		DEFAULT => -91
	},
	{#State 113
		ACTIONS => {
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 195,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 114
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 115
		DEFAULT => -141
	},
	{#State 116
		ACTIONS => {
			"{*" => 169,
			"my" => 170
		},
		GOTOS => {
			'FileHandle' => 197
		}
	},
	{#State 117
		ACTIONS => {
			"(" => 198
		}
	},
	{#State 118
		DEFAULT => -156
	},
	{#State 119
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			")" => -125,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 79,
			'OP01_QW' => 131,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			"my" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'ArrayReference' => 100,
			'ListElements' => 200,
			'Variable' => 134,
			'Expression' => 137,
			'HashDereferenced' => 98,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'OPTIONAL-40' => 199,
			'ListElement' => 135,
			'TypeInner' => 138
		}
	},
	{#State 120
		DEFAULT => -180,
		GOTOS => {
			'STAR-53' => 201
		}
	},
	{#State 121
		DEFAULT => -161
	},
	{#State 122
		DEFAULT => -224
	},
	{#State 123
		ACTIONS => {
			";" => 202
		}
	},
	{#State 124
		ACTIONS => {
			"\$TYPED_" => 203
		}
	},
	{#State 125
		ACTIONS => {
			'OP01_PRINT_VOID' => 102,
			'OP10_NAMED_UNARY' => 105,
			"for my integer" => -157,
			'OP03_MATH_INC_DEC' => 85,
			"if (" => 87,
			'OP01_NAMED_VOID' => 107,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 82,
			"foreach my" => -157,
			"\@{" => 94,
			'OP01_PRINT_VOID_PAREN' => 116,
			'OP01_NAMED_VOID_PAREN' => 119,
			"%{" => 95,
			"(" => 96,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"while (" => -157,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			"my" => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 93,
			"undef" => 115
		},
		GOTOS => {
			'LoopLabel' => 90,
			'PLUS-17' => 205,
			'ArrayDereferenced' => 92,
			'Statement' => 112,
			'Conditional' => 99,
			'ArrayReference' => 100,
			'VariableDeclaration' => 121,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 97,
			'PAREN-46' => 118,
			'VariableModification' => 101,
			'HashReference' => 80,
			'Literal' => 77,
			'Operation' => 204,
			'Operator' => 103,
			'OperatorVoid' => 84,
			'Expression' => 104,
			'OPTIONAL-47' => 83
		}
	},
	{#State 126
		DEFAULT => -42
	},
	{#State 127
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 206
		}
	},
	{#State 128
		DEFAULT => -40
	},
	{#State 129
		DEFAULT => -59
	},
	{#State 130
		ACTIONS => {
			"our %properties = (" => 208,
			"use constant" => 42
		},
		GOTOS => {
			'Properties' => 207,
			'Constant' => 209
		}
	},
	{#State 131
		ACTIONS => {
			"(" => 210
		}
	},
	{#State 132
		DEFAULT => -199
	},
	{#State 133
		ACTIONS => {
			"%{" => 95
		},
		GOTOS => {
			'HashDereferenced' => 211
		}
	},
	{#State 134
		ACTIONS => {
			'OP08_STRING_CAT' => -143,
			'OP14_BITWISE_OR_XOR' => -143,
			'OP17_LIST_RANGE' => -143,
			'OP23_LOGICAL_AND' => -143,
			'OP04_MATH_POW' => -143,
			")" => -143,
			'OP03_MATH_INC_DEC' => 165,
			'OP08_MATH_ADD_SUB' => -143,
			'OP18_TERNARY' => -143,
			'OP13_BITWISE_AND' => -143,
			'OP06_REGEX_MATCH' => -143,
			'OP24_LOGICAL_OR_XOR' => -143,
			".." => -143,
			'OP11_COMPARE_LT_GT' => -143,
			"]" => -143,
			'OP09_BITWISE_SHIFT' => -143,
			'OP16_LOGICAL_OR' => -143,
			'OP21_LIST_COMMA' => -143,
			'OP02_METHOD_THINARROW' => 166,
			";" => -143,
			'OP12_COMPARE_EQ_NEQ' => -143,
			'OP07_MATH_MULT_DIV_MOD' => -143,
			'OP15_LOGICAL_AND' => -143,
			"}" => -143
		}
	},
	{#State 135
		DEFAULT => -191,
		GOTOS => {
			'STAR-55' => 212
		}
	},
	{#State 136
		ACTIONS => {
			"]" => 213
		}
	},
	{#State 137
		ACTIONS => {
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => -196,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -196,
			'OP09_BITWISE_SHIFT' => 184,
			";" => -196,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			")" => -196,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => 173,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181
		}
	},
	{#State 138
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"undef" => 115,
			'WORD' => 24,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'Expression' => 214,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 139
		ACTIONS => {
			";" => 215
		}
	},
	{#State 140
		DEFAULT => -218
	},
	{#State 141
		DEFAULT => -172
	},
	{#State 142
		ACTIONS => {
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'HashDereferenced' => 98,
			'Expression' => 216,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100
		}
	},
	{#State 143
		DEFAULT => -171
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 217
		}
	},
	{#State 145
		DEFAULT => -159
	},
	{#State 146
		DEFAULT => -170
	},
	{#State 147
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 218
		}
	},
	{#State 148
		DEFAULT => -101
	},
	{#State 149
		DEFAULT => -16
	},
	{#State 150
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => 173,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			")" => 219,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => 175
		}
	},
	{#State 151
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			")" => 220,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179
		}
	},
	{#State 152
		DEFAULT => -212,
		GOTOS => {
			'STAR-60' => 221
		}
	},
	{#State 153
		DEFAULT => -207
	},
	{#State 154
		DEFAULT => -148
	},
	{#State 155
		ACTIONS => {
			'OP20_HASH_FATARROW' => 222
		}
	},
	{#State 156
		DEFAULT => -155
	},
	{#State 157
		ACTIONS => {
			'OP18_TERNARY' => -112,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => -112,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP04_MATH_POW' => 172,
			")" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => -112,
			";" => -112,
			"}" => -112,
			'OP09_BITWISE_SHIFT' => 184,
			".." => -112,
			'OP11_COMPARE_LT_GT' => -112,
			"]" => -112,
			'OP21_LIST_COMMA' => -112,
			'OP16_LOGICAL_OR' => -112
		}
	},
	{#State 158
		ACTIONS => {
			"}" => 223
		}
	},
	{#State 159
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 160
		ACTIONS => {
			"}" => 225
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 155,
			"%{" => 95
		},
		GOTOS => {
			'HashDereferenced' => 153,
			'HashEntry' => 152
		}
	},
	{#State 162
		ACTIONS => {
			"}" => 226
		}
	},
	{#State 163
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => 173,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			")" => 227,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => 175
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			"undef" => 115,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"[" => 79,
			"<STDIN>" => 230,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'ExpressionOrStdin' => 229,
			'Literal' => 77,
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'Variable' => 134,
			'Expression' => 228,
			'HashDereferenced' => 98
		}
	},
	{#State 165
		DEFAULT => -102
	},
	{#State 166
		ACTIONS => {
			'WORD' => 231
		}
	},
	{#State 167
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 232,
			'WordScoped' => 117,
			'Operator' => 103
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			";" => -131,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			"my" => 71,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"[" => 79,
			'OP01_QW' => 131,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'Operator' => 103,
			'WordScoped' => 117,
			'Variable' => 134,
			'Expression' => 137,
			'HashDereferenced' => 98,
			'ListElements' => 234,
			'ArrayReference' => 100,
			'ListElement' => 135,
			'TypeInner' => 138,
			'Literal' => 77,
			'OPTIONAL-43' => 233,
			'HashReference' => 80,
			'ArrayDereferenced' => 92
		}
	},
	{#State 169
		ACTIONS => {
			'WORD' => 235
		}
	},
	{#State 170
		ACTIONS => {
			"filehandle_ref" => 236
		}
	},
	{#State 171
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'HashDereferenced' => 98,
			'Expression' => 237,
			'Variable' => 134,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 172
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			"undef" => 115,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Variable' => 134,
			'Expression' => 238,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77
		}
	},
	{#State 173
		ACTIONS => {
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 115,
			'WORD' => 24,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122
		},
		GOTOS => {
			'WordScoped' => 117,
			'Operator' => 103,
			'HashDereferenced' => 98,
			'Expression' => 239,
			'Variable' => 134,
			'ArrayReference' => 100,
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			"undef" => 115,
			'WORD' => 24,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Expression' => 240,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => 24,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'WordScoped' => 117,
			'Operator' => 103,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Expression' => 241,
			'ArrayReference' => 100,
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92
		}
	},
	{#State 176
		ACTIONS => {
			"/" => 242
		}
	},
	{#State 177
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 243,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 178
		DEFAULT => -90
	},
	{#State 179
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			"undef" => 115,
			'WORD' => 24,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 244,
			'Operator' => 103,
			'WordScoped' => 117
		}
	},
	{#State 180
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'Expression' => 245,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100,
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80
		}
	},
	{#State 181
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 246
		}
	},
	{#State 182
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Expression' => 247,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayReference' => 100
		}
	},
	{#State 183
		ACTIONS => {
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'WORD' => 24,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122
		},
		GOTOS => {
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Expression' => 248,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100
		}
	},
	{#State 184
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'Expression' => 249,
			'Variable' => 134,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100,
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80
		}
	},
	{#State 185
		ACTIONS => {
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Expression' => 250,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117
		}
	},
	{#State 186
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'WORD' => 24,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 251,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 187
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115
		},
		GOTOS => {
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'WordScoped' => 117,
			'Operator' => 103,
			'HashDereferenced' => 98,
			'Expression' => 252,
			'Variable' => 134,
			'ArrayReference' => 100
		}
	},
	{#State 188
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			";" => -111,
			"}" => -111,
			'OP09_BITWISE_SHIFT' => 184,
			".." => -111,
			"]" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP18_TERNARY' => -111,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => -111,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP23_LOGICAL_AND' => -111,
			")" => -111,
			'OP04_MATH_POW' => 172
		}
	},
	{#State 189
		DEFAULT => -128
	},
	{#State 190
		ACTIONS => {
			";" => 253
		}
	},
	{#State 191
		ACTIONS => {
			'OP17_LIST_RANGE' => 173,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			")" => -121,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => -121,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -121,
			".." => -121,
			'OP21_LIST_COMMA' => -121,
			'OP16_LOGICAL_OR' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => -121,
			"}" => -121
		}
	},
	{#State 192
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP01_QW' => 131,
			"[" => 79,
			'OP03_MATH_INC_DEC' => 85,
			")" => -95,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 71,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'KEYS_OR_VALUES' => 133,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95
		},
		GOTOS => {
			'Literal' => 77,
			'TypeInner' => 138,
			'ListElement' => 135,
			'OPTIONAL-38' => 254,
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 137,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100,
			'ListElements' => 255
		}
	},
	{#State 193
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 85,
			")" => -93,
			'OP22_LOGICAL_NOT' => 108,
			"[" => 79,
			'OP01_QW' => 131,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133,
			"my" => 71,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			"undef" => 115
		},
		GOTOS => {
			'ListElement' => 135,
			'TypeInner' => 138,
			'Literal' => 77,
			'OPTIONAL-37' => 257,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 137,
			'ListElements' => 256,
			'ArrayReference' => 100
		}
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 71,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			";" => -97,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP01_QW' => 131,
			"[" => 79
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'OPTIONAL-39' => 259,
			'HashReference' => 80,
			'Literal' => 77,
			'TypeInner' => 138,
			'ListElement' => 135,
			'ArrayReference' => 100,
			'ListElements' => 258,
			'HashDereferenced' => 98,
			'Expression' => 137,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 117
		}
	},
	{#State 195
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			";" => -104,
			"}" => -104,
			'OP09_BITWISE_SHIFT' => -104,
			".." => -104,
			'OP11_COMPARE_LT_GT' => -104,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP18_TERNARY' => -104,
			'OP08_MATH_ADD_SUB' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP06_REGEX_MATCH' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP08_STRING_CAT' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			")" => -104,
			'OP04_MATH_POW' => 172
		}
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 260
		}
	},
	{#State 197
		ACTIONS => {
			"[" => 79,
			'OP01_QW' => 131,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			")" => -127,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			"my" => 71,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'ListElements' => 261,
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'Expression' => 137,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'OPTIONAL-41' => 262,
			'ListElement' => 135,
			'TypeInner' => 138,
			'Literal' => 77
		}
	},
	{#State 198
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			")" => -138,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP01_QW' => 131,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			"my" => 71,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133
		},
		GOTOS => {
			'ListElements' => 263,
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Expression' => 137,
			'HashReference' => 80,
			'OPTIONAL-44' => 264,
			'ArrayDereferenced' => 92,
			'ListElement' => 135,
			'TypeInner' => 138,
			'Literal' => 77
		}
	},
	{#State 199
		ACTIONS => {
			")" => 265
		}
	},
	{#State 200
		DEFAULT => -124
	},
	{#State 201
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP13_BITWISE_AND' => -181,
			'OP18_TERNARY' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			")" => -181,
			'OP04_MATH_POW' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP08_STRING_CAT' => -181,
			"}" => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			";" => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP21_LIST_COMMA' => -181,
			'OP02_ARRAY_THINARROW' => 266,
			'OP16_LOGICAL_OR' => -181,
			'OP02_HASH_THINARROW' => 267,
			'COLON' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			"]" => -181,
			'OP11_COMPARE_LT_GT' => -181,
			".." => -181
		},
		GOTOS => {
			'VariableRetrieval' => 268
		}
	},
	{#State 202
		DEFAULT => -41
	},
	{#State 203
		ACTIONS => {
			'WORD' => 269
		}
	},
	{#State 204
		DEFAULT => -45
	},
	{#State 205
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED_VOID' => 107,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_NAMED_VOID_PAREN' => 119,
			'OP01_PRINT_VOID_PAREN' => 116,
			"while (" => -157,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 114,
			"for my integer" => -157,
			"if (" => 87,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 79,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88,
			"}" => 270,
			'WORD' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89
		},
		GOTOS => {
			'ArrayReference' => 100,
			'VariableDeclaration' => 121,
			'Conditional' => 99,
			'PAREN-46' => 118,
			'HashDereferenced' => 98,
			'Variable' => 97,
			'WordScoped' => 117,
			'ArrayDereferenced' => 92,
			'LoopLabel' => 90,
			'Statement' => 112,
			'Operation' => 271,
			'OPTIONAL-47' => 83,
			'Expression' => 104,
			'OperatorVoid' => 84,
			'Operator' => 103,
			'HashReference' => 80,
			'VariableModification' => 101,
			'Literal' => 77
		}
	},
	{#State 206
		ACTIONS => {
			'VARIABLE_SYMBOL' => 272
		}
	},
	{#State 207
		ACTIONS => {
			"our" => -64,
			"our %properties_class = (" => 274,
			'LITERAL_NUMBER' => -64
		},
		GOTOS => {
			'PropertiesClass' => 275,
			'OPTIONAL-26' => 273
		}
	},
	{#State 208
		ACTIONS => {
			"## no critic qw(" => 4,
			")" => 277
		},
		GOTOS => {
			'Critic' => 276
		}
	},
	{#State 209
		DEFAULT => -61
	},
	{#State 210
		ACTIONS => {
			'WORD' => 279
		},
		GOTOS => {
			'PLUS-56' => 278
		}
	},
	{#State 211
		DEFAULT => -198
	},
	{#State 212
		ACTIONS => {
			")" => -194,
			'OP21_LIST_COMMA' => 280,
			";" => -194,
			"]" => -194
		},
		GOTOS => {
			'PAREN-54' => 281
		}
	},
	{#State 213
		DEFAULT => -201
	},
	{#State 214
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			")" => -197,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => 173,
			";" => -197,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => -197,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -197,
			'OP09_BITWISE_SHIFT' => 184
		}
	},
	{#State 215
		DEFAULT => -136
	},
	{#State 216
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 172,
			")" => 282,
			'OP23_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => 173,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 183,
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184
		}
	},
	{#State 217
		ACTIONS => {
			"(" => 283
		}
	},
	{#State 218
		ACTIONS => {
			'VARIABLE_SYMBOL' => 284
		}
	},
	{#State 219
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 285
		}
	},
	{#State 220
		DEFAULT => -105
	},
	{#State 221
		ACTIONS => {
			'OP21_LIST_COMMA' => 289,
			"}" => 287
		},
		GOTOS => {
			'PAREN-59' => 288
		}
	},
	{#State 222
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -205,
			'OP22_LOGICAL_NOT' => -205,
			'OP10_NAMED_UNARY' => -205,
			'WORD_SCOPED' => -205,
			'LITERAL_NUMBER' => -205,
			"[" => -205,
			'LITERAL_STRING' => -205,
			'VARIABLE_SYMBOL' => -205,
			"\@{" => -205,
			"%{" => -205,
			"(" => -205,
			"my" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => -205,
			'OP05_LOGICAL_NEG' => -205,
			"{" => -205,
			'WORD' => -205,
			"undef" => -205,
			'OP01_OPEN_CLOSE_PAREN' => -205,
			'OP05_MATH_NEG' => -205,
			'OP01_NAMED' => -205,
			'OP01_OPEN_CLOSE' => -205
		},
		GOTOS => {
			'TypeInner' => 290,
			'OPTIONAL-58' => 291
		}
	},
	{#State 223
		DEFAULT => -203
	},
	{#State 224
		DEFAULT => -202
	},
	{#State 225
		DEFAULT => -215
	},
	{#State 226
		DEFAULT => -214
	},
	{#State 227
		DEFAULT => -152
	},
	{#State 228
		ACTIONS => {
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP16_LOGICAL_OR' => 183,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			";" => -153,
			'OP12_COMPARE_EQ_NEQ' => 187
		}
	},
	{#State 229
		ACTIONS => {
			";" => 292
		}
	},
	{#State 230
		DEFAULT => -154
	},
	{#State 231
		ACTIONS => {
			"(" => 293
		}
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP16_LOGICAL_OR' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			";" => 294,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176
		}
	},
	{#State 233
		ACTIONS => {
			";" => 295
		}
	},
	{#State 234
		DEFAULT => -130
	},
	{#State 235
		ACTIONS => {
			"}" => 296
		}
	},
	{#State 236
		ACTIONS => {
			'VARIABLE_SYMBOL' => 297
		}
	},
	{#State 237
		ACTIONS => {
			'OP21_LIST_COMMA' => -122,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			"]" => -122,
			'OP11_COMPARE_LT_GT' => 185,
			".." => -122,
			"}" => -122,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => -122,
			'OP04_MATH_POW' => 172,
			")" => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP17_LIST_RANGE' => 173,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182
		}
	},
	{#State 238
		ACTIONS => {
			'OP06_REGEX_MATCH' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_MATH_ADD_SUB' => -103,
			'OP18_TERNARY' => -103,
			'OP04_MATH_POW' => 172,
			")" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP08_STRING_CAT' => -103,
			'OP17_LIST_RANGE' => -103,
			"}" => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			";" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			"]" => -103,
			".." => -103,
			'OP09_BITWISE_SHIFT' => -103
		}
	},
	{#State 239
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			";" => -119,
			'OP12_COMPARE_EQ_NEQ' => 187,
			"}" => -119,
			'OP09_BITWISE_SHIFT' => 184,
			".." => -119,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP16_LOGICAL_OR' => 183,
			'OP18_TERNARY' => -119,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => undef,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP23_LOGICAL_AND' => -119,
			'OP04_MATH_POW' => 172,
			")" => -119
		}
	},
	{#State 240
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => -109,
			'OP18_TERNARY' => -109,
			'OP08_MATH_ADD_SUB' => 182,
			'OP04_MATH_POW' => 172,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP08_STRING_CAT' => -109,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			";" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"]" => -109,
			".." => -109
		}
	},
	{#State 241
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => 173,
			")" => -123,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => -123,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"}" => -123,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -123,
			".." => -123,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => -123
		}
	},
	{#State 242
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 298
		}
	},
	{#State 243
		ACTIONS => {
			"}" => -117,
			";" => -117,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP21_LIST_COMMA' => -117,
			".." => -117,
			"]" => -117,
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => -117,
			'OP23_LOGICAL_AND' => -117,
			")" => -117,
			'OP04_MATH_POW' => 172,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => -117
		}
	},
	{#State 244
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => -116,
			"}" => -116,
			'OP09_BITWISE_SHIFT' => 184,
			".." => -116,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP18_TERNARY' => -116,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => -116,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP04_MATH_POW' => 172,
			")" => -116
		}
	},
	{#State 245
		ACTIONS => {
			"}" => -115,
			";" => -115,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP21_LIST_COMMA' => -115,
			".." => -115,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -115,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => -115,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => -115,
			'OP23_LOGICAL_AND' => -115,
			")" => -115,
			'OP04_MATH_POW' => 172,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP17_LIST_RANGE' => -115
		}
	},
	{#State 246
		ACTIONS => {
			'COLON' => 299
		}
	},
	{#State 247
		ACTIONS => {
			'OP18_TERNARY' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP08_STRING_CAT' => -108,
			'OP04_MATH_POW' => 172,
			")" => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			";" => -108,
			'OP12_COMPARE_EQ_NEQ' => -108,
			"}" => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			"]" => -108,
			".." => -108,
			'OP21_LIST_COMMA' => -108,
			'OP16_LOGICAL_OR' => -108
		}
	},
	{#State 248
		ACTIONS => {
			'OP18_TERNARY' => -118,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP17_LIST_RANGE' => -118,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP04_MATH_POW' => 172,
			")" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			";" => -118,
			"}" => -118,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -118,
			".." => -118,
			'OP21_LIST_COMMA' => -118,
			'OP16_LOGICAL_OR' => -118
		}
	},
	{#State 249
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => -110,
			'OP04_MATH_POW' => 172,
			")" => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => -110,
			"}" => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			";" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => -110,
			'OP21_LIST_COMMA' => -110,
			"]" => -110,
			'OP11_COMPARE_LT_GT' => -110,
			".." => -110,
			'OP09_BITWISE_SHIFT' => -110
		}
	},
	{#State 250
		ACTIONS => {
			'OP17_LIST_RANGE' => -113,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 172,
			")" => -113,
			'OP18_TERNARY' => -113,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 184,
			".." => -113,
			"]" => -113,
			'OP11_COMPARE_LT_GT' => undef,
			'OP21_LIST_COMMA' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			";" => -113,
			"}" => -113
		}
	},
	{#State 251
		ACTIONS => {
			'OP08_STRING_CAT' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 172,
			")" => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP18_TERNARY' => -107,
			'OP13_BITWISE_AND' => -107,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => -107,
			".." => -107,
			"]" => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP21_LIST_COMMA' => -107,
			";" => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP15_LOGICAL_AND' => -107,
			"}" => -107
		}
	},
	{#State 252
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -114,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => -114,
			'OP04_MATH_POW' => 172,
			")" => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => -114,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => -114,
			".." => -114,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP12_COMPARE_EQ_NEQ' => undef,
			";" => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"}" => -114
		}
	},
	{#State 253
		DEFAULT => -134
	},
	{#State 254
		ACTIONS => {
			")" => 300
		}
	},
	{#State 255
		DEFAULT => -94
	},
	{#State 256
		DEFAULT => -92
	},
	{#State 257
		ACTIONS => {
			")" => 301
		}
	},
	{#State 258
		DEFAULT => -96
	},
	{#State 259
		ACTIONS => {
			";" => 302
		}
	},
	{#State 260
		ACTIONS => {
			";" => 304,
			'OP19_VARIABLE_ASSIGN' => 303
		}
	},
	{#State 261
		DEFAULT => -126
	},
	{#State 262
		ACTIONS => {
			")" => 305
		}
	},
	{#State 263
		DEFAULT => -137
	},
	{#State 264
		ACTIONS => {
			")" => 306
		}
	},
	{#State 265
		ACTIONS => {
			";" => 307
		}
	},
	{#State 266
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 308,
			'HashDereferenced' => 98,
			'WordScoped' => 117,
			'Operator' => 103,
			'ArrayReference' => 100,
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80
		}
	},
	{#State 267
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'WORD' => 310,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77,
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 309
		}
	},
	{#State 268
		DEFAULT => -179
	},
	{#State 269
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 311
		}
	},
	{#State 270
		ACTIONS => {
			";" => 312
		}
	},
	{#State 271
		DEFAULT => -44
	},
	{#State 272
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 313
		}
	},
	{#State 273
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 314
		}
	},
	{#State 274
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 315
		}
	},
	{#State 275
		DEFAULT => -63
	},
	{#State 276
		ACTIONS => {
			"%{" => 95,
			'WORD' => 317
		},
		GOTOS => {
			'HashEntryTyped' => 318,
			'HashDereferenced' => 316
		}
	},
	{#State 277
		ACTIONS => {
			";" => 319
		}
	},
	{#State 278
		ACTIONS => {
			'WORD' => 321,
			")" => 320
		}
	},
	{#State 279
		DEFAULT => -193
	},
	{#State 280
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 24,
			"undef" => 115,
			"my" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94
		},
		GOTOS => {
			'WordScoped' => 117,
			'Operator' => 103,
			'Expression' => 137,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'ArrayReference' => 100,
			'TypeInner' => 138,
			'ListElement' => 322,
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92
		}
	},
	{#State 281
		DEFAULT => -190
	},
	{#State 282
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 283
		ACTIONS => {
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Variable' => 134,
			'Expression' => 324,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117
		}
	},
	{#State 284
		ACTIONS => {
			"(" => 325
		}
	},
	{#State 285
		DEFAULT => -165,
		GOTOS => {
			'STAR-49' => 326
		}
	},
	{#State 286
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			"if (" => 87,
			'OP01_NAMED_VOID' => 107,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT_VOID' => 102,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			"while (" => -157,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"(" => 96,
			"%{" => 95,
			'OP01_NAMED_VOID_PAREN' => 119,
			"\@{" => 94,
			'OP01_PRINT_VOID_PAREN' => 116,
			"foreach my" => -157,
			"undef" => 115,
			'WORD' => 93,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 114,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109
		},
		GOTOS => {
			'Operation' => 328,
			'Operator' => 103,
			'OPTIONAL-47' => 83,
			'OperatorVoid' => 84,
			'Expression' => 104,
			'HashReference' => 80,
			'VariableModification' => 101,
			'Literal' => 77,
			'Conditional' => 99,
			'VariableDeclaration' => 121,
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'PAREN-46' => 118,
			'HashDereferenced' => 98,
			'Variable' => 97,
			'LoopLabel' => 90,
			'ArrayDereferenced' => 92,
			'PLUS-52' => 327,
			'Statement' => 112
		}
	},
	{#State 287
		DEFAULT => -213
	},
	{#State 288
		DEFAULT => -211
	},
	{#State 289
		ACTIONS => {
			"%{" => 95,
			'WORD' => 155
		},
		GOTOS => {
			'HashEntry' => 329,
			'HashDereferenced' => 153
		}
	},
	{#State 290
		DEFAULT => -204
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			"undef" => 115,
			'WORD' => 24,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Expression' => 330,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117
		}
	},
	{#State 292
		DEFAULT => -187
	},
	{#State 293
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'WORD' => 24,
			"undef" => 115,
			"my" => 71,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP22_LOGICAL_NOT' => 108,
			")" => -140,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP01_QW' => 131
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'TypeInner' => 138,
			'OPTIONAL-45' => 331,
			'ListElement' => 135,
			'ArrayReference' => 100,
			'ListElements' => 332,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Expression' => 137,
			'WordScoped' => 117,
			'Operator' => 103
		}
	},
	{#State 294
		DEFAULT => -188
	},
	{#State 295
		DEFAULT => -135
	},
	{#State 296
		DEFAULT => -222
	},
	{#State 297
		DEFAULT => -223
	},
	{#State 298
		ACTIONS => {
			"/" => 333
		}
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 334
		}
	},
	{#State 300
		ACTIONS => {
			";" => 335
		}
	},
	{#State 301
		DEFAULT => -98
	},
	{#State 302
		DEFAULT => -100
	},
	{#State 303
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"undef" => 115,
			'WORD' => 24,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"\@{" => 94,
			"(" => 96,
			"%{" => 95,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"<STDIN>" => 230,
			"[" => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'ExpressionOrStdin' => 336,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'Expression' => 228,
			'Variable' => 134,
			'HashDereferenced' => 98
		}
	},
	{#State 304
		DEFAULT => -185
	},
	{#State 305
		ACTIONS => {
			";" => 337
		}
	},
	{#State 306
		DEFAULT => -150
	},
	{#State 307
		DEFAULT => -132
	},
	{#State 308
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			"]" => 338,
			'OP16_LOGICAL_OR' => 183,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP17_LIST_RANGE' => 173,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171
		}
	},
	{#State 309
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"}" => 339,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => 173,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => 175
		}
	},
	{#State 310
		ACTIONS => {
			"(" => -216,
			"}" => 340
		}
	},
	{#State 311
		DEFAULT => -221
	},
	{#State 312
		DEFAULT => -46
	},
	{#State 313
		ACTIONS => {
			'OP21_LIST_COMMA' => 342,
			")" => 341
		},
		GOTOS => {
			'PAREN-18' => 343
		}
	},
	{#State 314
		ACTIONS => {
			"our" => 348,
			'LITERAL_NUMBER' => 345
		},
		GOTOS => {
			'Subroutine' => 346,
			'MethodOrSubroutine' => 347,
			'Method' => 344
		}
	},
	{#State 315
		ACTIONS => {
			"%{" => 95,
			'WORD' => 317
		},
		GOTOS => {
			'HashEntryTyped' => 349,
			'HashDereferenced' => 316
		}
	},
	{#State 316
		DEFAULT => -209
	},
	{#State 317
		ACTIONS => {
			'OP20_HASH_FATARROW' => 350
		}
	},
	{#State 318
		DEFAULT => -70,
		GOTOS => {
			'STAR-29' => 351
		}
	},
	{#State 319
		ACTIONS => {
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 352
		}
	},
	{#State 320
		DEFAULT => -195
	},
	{#State 321
		DEFAULT => -192
	},
	{#State 322
		DEFAULT => -189
	},
	{#State 323
		DEFAULT => -175
	},
	{#State 324
		ACTIONS => {
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP17_LIST_RANGE' => 173,
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP24_LOGICAL_OR_XOR' => 175,
			".." => 353,
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP16_LOGICAL_OR' => 183,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186
		}
	},
	{#State 325
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'OP01_QW' => 131,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			"my" => 71,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'KEYS_OR_VALUES' => 133
		},
		GOTOS => {
			'ListElement' => 135,
			'TypeInner' => 138,
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'WordScoped' => 117,
			'Operator' => 103,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 137,
			'ListElements' => 354,
			'ArrayReference' => 100
		}
	},
	{#State 326
		ACTIONS => {
			"for my integer" => -168,
			"else" => 356,
			"if (" => -168,
			'OP03_MATH_INC_DEC' => -168,
			"[" => -168,
			'OP19_LOOP_CONTROL' => -168,
			'LITERAL_NUMBER' => -168,
			'WORD_SCOPED' => -168,
			"(" => -168,
			"%{" => -168,
			"\@{" => -168,
			"foreach my" => -168,
			'OP05_MATH_NEG' => -168,
			"}" => -168,
			'WORD' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			"{" => -168,
			'OP10_NAMED_UNARY' => -168,
			'OP01_PRINT_VOID' => -168,
			'OP01_NAMED_VOID' => -168,
			'OP22_LOGICAL_NOT' => -168,
			'' => -168,
			"elsif (" => 359,
			'OP01_NAMED_VOID_PAREN' => -168,
			'OP01_PRINT_VOID_PAREN' => -168,
			'VARIABLE_SYMBOL' => -168,
			"while (" => -168,
			'LITERAL_STRING' => -168,
			'OP01_NAMED' => -168,
			'OP01_OPEN_CLOSE' => -168,
			'OP01_OPEN_CLOSE_PAREN' => -168,
			"undef" => -168,
			'OP05_LOGICAL_NEG' => -168,
			"my" => -168
		},
		GOTOS => {
			'OPTIONAL-51' => 358,
			'PAREN-50' => 357,
			'PAREN-48' => 355
		}
	},
	{#State 327
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP01_NAMED_VOID' => 107,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT_VOID' => 102,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 114,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'VARIABLE_SYMBOL' => 120,
			"while (" => -157,
			'LITERAL_STRING' => 122,
			'OP01_NAMED_VOID_PAREN' => 119,
			'OP01_PRINT_VOID_PAREN' => 116,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			"if (" => 87,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -157,
			"}" => 361,
			'WORD' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_MATH_NEG' => 88,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			"foreach my" => -157
		},
		GOTOS => {
			'WordScoped' => 117,
			'PAREN-46' => 118,
			'HashDereferenced' => 98,
			'Variable' => 97,
			'Conditional' => 99,
			'ArrayReference' => 100,
			'VariableDeclaration' => 121,
			'Statement' => 112,
			'LoopLabel' => 90,
			'ArrayDereferenced' => 92,
			'Operator' => 103,
			'OPTIONAL-47' => 83,
			'Expression' => 104,
			'OperatorVoid' => 84,
			'Operation' => 360,
			'Literal' => 77,
			'HashReference' => 80,
			'VariableModification' => 101
		}
	},
	{#State 328
		DEFAULT => -177
	},
	{#State 329
		DEFAULT => -210
	},
	{#State 330
		ACTIONS => {
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => 173,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181,
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => -206,
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			"}" => -206,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186
		}
	},
	{#State 331
		ACTIONS => {
			")" => 362
		}
	},
	{#State 332
		DEFAULT => -139
	},
	{#State 333
		DEFAULT => -106
	},
	{#State 334
		DEFAULT => -120
	},
	{#State 335
		DEFAULT => -99
	},
	{#State 336
		ACTIONS => {
			";" => 363
		}
	},
	{#State 337
		DEFAULT => -133
	},
	{#State 338
		DEFAULT => -182
	},
	{#State 339
		DEFAULT => -183
	},
	{#State 340
		DEFAULT => -184
	},
	{#State 341
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 364
		}
	},
	{#State 342
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 343
		DEFAULT => -48
	},
	{#State 344
		DEFAULT => -88
	},
	{#State 345
		ACTIONS => {
			";" => 366
		}
	},
	{#State 346
		DEFAULT => -89
	},
	{#State 347
		DEFAULT => -65
	},
	{#State 348
		ACTIONS => {
			'WORD' => 367
		},
		GOTOS => {
			'TypeMethod' => 368,
			'Type' => 54
		}
	},
	{#State 349
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 369
		}
	},
	{#State 350
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 370
		}
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 373,
			")" => 371
		},
		GOTOS => {
			'PAREN-28' => 372
		}
	},
	{#State 352
		DEFAULT => -72
	},
	{#State 353
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'WORD' => 24,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Operator' => 103,
			'WordScoped' => 117,
			'Expression' => 374,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77
		}
	},
	{#State 354
		ACTIONS => {
			")" => 375
		}
	},
	{#State 355
		DEFAULT => -164
	},
	{#State 356
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 376
		}
	},
	{#State 357
		DEFAULT => -167
	},
	{#State 358
		DEFAULT => -169
	},
	{#State 359
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"\@{" => 94,
			"%{" => 95,
			"(" => 96,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'WORD' => 24,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79
		},
		GOTOS => {
			'Expression' => 377,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'Operator' => 103,
			'WordScoped' => 117,
			'ArrayReference' => 100,
			'Literal' => 77,
			'ArrayDereferenced' => 92,
			'HashReference' => 80
		}
	},
	{#State 360
		DEFAULT => -176
	},
	{#State 361
		DEFAULT => -178
	},
	{#State 362
		DEFAULT => -151
	},
	{#State 363
		DEFAULT => -186
	},
	{#State 364
		ACTIONS => {
			"\@_;" => 378
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 379
		}
	},
	{#State 366
		DEFAULT => -67
	},
	{#State 367
		ACTIONS => {
			"__method" => 380,
			'VARIABLE_SYMBOL' => -219
		}
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 369
		ACTIONS => {
			'OP21_LIST_COMMA' => 382,
			")" => 384
		},
		GOTOS => {
			'PAREN-30' => 383
		}
	},
	{#State 370
		ACTIONS => {
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Expression' => 385,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'WordScoped' => 117,
			'Operator' => 103
		}
	},
	{#State 371
		ACTIONS => {
			";" => 386
		}
	},
	{#State 372
		DEFAULT => -69
	},
	{#State 373
		ACTIONS => {
			"%{" => 95,
			'WORD' => 317
		},
		GOTOS => {
			'HashDereferenced' => 316,
			'HashEntryTyped' => 387
		}
	},
	{#State 374
		ACTIONS => {
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP23_LOGICAL_AND' => 171,
			")" => 388,
			'OP04_MATH_POW' => 172,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP16_LOGICAL_OR' => 183
		}
	},
	{#State 375
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 376
		DEFAULT => -166
	},
	{#State 377
		ACTIONS => {
			'OP23_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 172,
			")" => 390,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187
		}
	},
	{#State 378
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 391
		}
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 380
		DEFAULT => -220
	},
	{#State 381
		ACTIONS => {
			"= sub {" => 393
		}
	},
	{#State 382
		ACTIONS => {
			'WORD' => 317,
			"%{" => 95
		},
		GOTOS => {
			'HashDereferenced' => 316,
			'HashEntryTyped' => 394
		}
	},
	{#State 383
		DEFAULT => -74
	},
	{#State 384
		ACTIONS => {
			";" => 395
		}
	},
	{#State 385
		ACTIONS => {
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP21_LIST_COMMA' => -208,
			'OP16_LOGICAL_OR' => 183,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => 173,
			'OP08_STRING_CAT' => 174,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP23_LOGICAL_AND' => 171,
			")" => -208,
			'OP04_MATH_POW' => 172
		}
	},
	{#State 386
		DEFAULT => -71
	},
	{#State 387
		DEFAULT => -68
	},
	{#State 388
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 396
		}
	},
	{#State 389
		DEFAULT => -174
	},
	{#State 390
		ACTIONS => {
			"{" => 286
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 391
		ACTIONS => {
			'OP01_NAMED_VOID' => -52,
			'OP22_LOGICAL_NOT' => -52,
			'OP10_NAMED_UNARY' => -52,
			'OP01_PRINT_VOID' => -52,
			'CHECK_OR_CHECKTRACE' => 398,
			'VARIABLE_SYMBOL' => -52,
			"while (" => -52,
			'LITERAL_STRING' => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			'OP01_PRINT_VOID_PAREN' => -52,
			"undef" => -52,
			'OP05_LOGICAL_NEG' => -52,
			"my" => -52,
			'OP01_OPEN_CLOSE' => -52,
			'OP01_NAMED' => -52,
			'OP01_OPEN_CLOSE_PAREN' => -52,
			"if (" => -52,
			'OP03_MATH_INC_DEC' => -52,
			"for my integer" => -52,
			'OP19_LOOP_CONTROL' => -52,
			'LITERAL_NUMBER' => -52,
			'WORD_SCOPED' => -52,
			"[" => -52,
			"%{" => -52,
			"(" => -52,
			"\@{" => -52,
			"foreach my" => -52,
			'WORD' => -52,
			'OP10_NAMED_UNARY_STRINGIFY' => -52,
			"{" => -52,
			'OP05_MATH_NEG' => -52
		},
		GOTOS => {
			'ArgumentCheck' => 399
		}
	},
	{#State 392
		DEFAULT => -47
	},
	{#State 393
		ACTIONS => {
			'OP01_OPEN_CLOSE' => -78,
			'OP01_NAMED' => -78,
			'OP01_OPEN_CLOSE_PAREN' => -78,
			"undef" => -78,
			'OP05_LOGICAL_NEG' => -78,
			"my" => -78,
			'OP01_NAMED_VOID_PAREN' => -78,
			'OP01_PRINT_VOID_PAREN' => -78,
			"while (" => -78,
			'VARIABLE_SYMBOL' => -78,
			'LITERAL_STRING' => -78,
			"( my" => 400,
			'OP10_NAMED_UNARY' => -78,
			'OP01_PRINT_VOID' => -78,
			'OP01_NAMED_VOID' => -78,
			'OP22_LOGICAL_NOT' => -78,
			'OP05_MATH_NEG' => -78,
			'WORD' => -78,
			'OP10_NAMED_UNARY_STRINGIFY' => -78,
			"{" => -78,
			"%{" => -78,
			"(" => -78,
			"\@{" => -78,
			"foreach my" => -78,
			"[" => -78,
			'OP19_LOOP_CONTROL' => -78,
			'LITERAL_NUMBER' => -78,
			'WORD_SCOPED' => -78,
			"for my integer" => -78,
			"if (" => -78,
			'OP03_MATH_INC_DEC' => -78
		},
		GOTOS => {
			'MethodArguments' => 402,
			'OPTIONAL-32' => 401
		}
	},
	{#State 394
		DEFAULT => -73
	},
	{#State 395
		DEFAULT => -76
	},
	{#State 396
		DEFAULT => -173
	},
	{#State 397
		DEFAULT => -163
	},
	{#State 398
		ACTIONS => {
			"(" => 403
		}
	},
	{#State 399
		DEFAULT => -50
	},
	{#State 400
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 404
		}
	},
	{#State 401
		ACTIONS => {
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"while (" => -157,
			"foreach my" => -157,
			"\@{" => 94,
			'OP01_PRINT_VOID_PAREN' => 116,
			'OP01_NAMED_VOID_PAREN' => 119,
			"%{" => 95,
			"(" => 96,
			"my" => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 93,
			"undef" => 115,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"if (" => 87,
			'OP22_LOGICAL_NOT' => 108,
			'OP01_NAMED_VOID' => 107,
			'OP01_PRINT_VOID' => 102,
			'OP10_NAMED_UNARY' => 105,
			"for my integer" => -157,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 82,
			"[" => 79
		},
		GOTOS => {
			'ArrayReference' => 100,
			'VariableDeclaration' => 121,
			'Conditional' => 99,
			'Variable' => 97,
			'HashDereferenced' => 98,
			'PAREN-46' => 118,
			'WordScoped' => 117,
			'ArrayDereferenced' => 92,
			'LoopLabel' => 90,
			'Statement' => 112,
			'Operation' => 405,
			'OperatorVoid' => 84,
			'Expression' => 104,
			'OPTIONAL-47' => 83,
			'Operator' => 103,
			'PLUS-33' => 406,
			'VariableModification' => 101,
			'HashReference' => 80,
			'Literal' => 77
		}
	},
	{#State 402
		DEFAULT => -77
	},
	{#State 403
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"[" => 79,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'WORD' => 24,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'HashReference' => 80,
			'Literal' => 77,
			'ArrayReference' => 100,
			'Expression' => 407,
			'Variable' => 134,
			'HashDereferenced' => 98,
			'WordScoped' => 117,
			'Operator' => 103
		}
	},
	{#State 404
		DEFAULT => -84,
		GOTOS => {
			'STAR-35' => 408
		}
	},
	{#State 405
		DEFAULT => -80
	},
	{#State 406
		ACTIONS => {
			"if (" => 87,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			"[" => 79,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			"foreach my" => -157,
			"}" => 409,
			'WORD' => 93,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			'OP05_MATH_NEG' => 88,
			'OP01_NAMED_VOID' => 107,
			'OP22_LOGICAL_NOT' => 108,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT_VOID' => 102,
			"while (" => -157,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			'OP01_NAMED_VOID_PAREN' => 119,
			'OP01_PRINT_VOID_PAREN' => 116,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"my" => 114,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE_PAREN' => 109
		},
		GOTOS => {
			'Literal' => 77,
			'VariableModification' => 101,
			'HashReference' => 80,
			'Operator' => 103,
			'Expression' => 104,
			'OperatorVoid' => 84,
			'OPTIONAL-47' => 83,
			'Operation' => 410,
			'Statement' => 112,
			'LoopLabel' => 90,
			'ArrayDereferenced' => 92,
			'WordScoped' => 117,
			'Variable' => 97,
			'HashDereferenced' => 98,
			'PAREN-46' => 118,
			'Conditional' => 99,
			'ArrayReference' => 100,
			'VariableDeclaration' => 121
		}
	},
	{#State 407
		ACTIONS => {
			")" => -55,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP17_LIST_RANGE' => 173,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => 412,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP12_COMPARE_EQ_NEQ' => 187
		},
		GOTOS => {
			'PAREN-21' => 411,
			'OPTIONAL-22' => 413
		}
	},
	{#State 408
		ACTIONS => {
			")" => 414,
			'OP21_LIST_COMMA' => 415
		},
		GOTOS => {
			'PAREN-34' => 416
		}
	},
	{#State 409
		ACTIONS => {
			";" => 417
		}
	},
	{#State 410
		DEFAULT => -79
	},
	{#State 411
		DEFAULT => -54
	},
	{#State 412
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 79,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 81,
			"(" => 96,
			"%{" => 95,
			"\@{" => 94,
			'LITERAL_STRING' => 122,
			'VARIABLE_SYMBOL' => 120,
			'OP01_NAMED' => 110,
			'OP01_OPEN_CLOSE' => 111,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			'OP05_MATH_NEG' => 88,
			'WORD' => 24,
			"undef" => 115,
			'OP05_LOGICAL_NEG' => 113,
			"{" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 91
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Literal' => 77,
			'ArrayReference' => 100,
			'WordScoped' => 117,
			'Operator' => 103,
			'Variable' => 134,
			'Expression' => 418,
			'HashDereferenced' => 98
		}
	},
	{#State 413
		ACTIONS => {
			")" => 419
		}
	},
	{#State 414
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 415
		ACTIONS => {
			"my" => 421
		}
	},
	{#State 416
		DEFAULT => -83
	},
	{#State 417
		DEFAULT => -81
	},
	{#State 418
		ACTIONS => {
			'OP16_LOGICAL_OR' => 183,
			'OP21_LIST_COMMA' => 422,
			'OP11_COMPARE_LT_GT' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 177,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP17_LIST_RANGE' => 173,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP08_MATH_ADD_SUB' => 182,
			'OP18_TERNARY' => 181
		}
	},
	{#State 419
		ACTIONS => {
			";" => 423
		}
	},
	{#State 420
		ACTIONS => {
			"\@_;" => 424
		}
	},
	{#State 421
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 422
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 111,
			'OP01_NAMED' => 110,
			'OP05_MATH_NEG' => 88,
			'OP01_OPEN_CLOSE_PAREN' => 109,
			"undef" => 115,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 91,
			"{" => 89,
			"%{" => 95,
			"(" => 96,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 122,
			"[" => 79,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 108,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'Literal' => 77,
			'HashReference' => 80,
			'ArrayDereferenced' => 92,
			'Operator' => 103,
			'WordScoped' => 117,
			'HashDereferenced' => 98,
			'Variable' => 134,
			'Expression' => 426,
			'ArrayReference' => 100
		}
	},
	{#State 423
		DEFAULT => -56
	},
	{#State 424
		DEFAULT => -86,
		GOTOS => {
			'STAR-36' => 427
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 428
		}
	},
	{#State 426
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => 180,
			'OP18_TERNARY' => 181,
			'OP08_MATH_ADD_SUB' => 182,
			")" => -53,
			'OP04_MATH_POW' => 172,
			'OP23_LOGICAL_AND' => 171,
			'OP17_LIST_RANGE' => 173,
			'OP14_BITWISE_OR_XOR' => 179,
			'OP08_STRING_CAT' => 174,
			'OP15_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP12_COMPARE_EQ_NEQ' => 187,
			'OP16_LOGICAL_OR' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP11_COMPARE_LT_GT' => 185
		}
	},
	{#State 427
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => -87,
			'OP01_OPEN_CLOSE' => -87,
			'OP01_NAMED' => -87,
			"my" => -87,
			'OP05_LOGICAL_NEG' => -87,
			"undef" => -87,
			'OP01_PRINT_VOID_PAREN' => -87,
			'OP01_NAMED_VOID_PAREN' => -87,
			'LITERAL_STRING' => -87,
			'VARIABLE_SYMBOL' => -87,
			"while (" => -87,
			'CHECK_OR_CHECKTRACE' => 398,
			'OP01_PRINT_VOID' => -87,
			'OP10_NAMED_UNARY' => -87,
			'OP01_NAMED_VOID' => -87,
			'OP22_LOGICAL_NOT' => -87,
			'OP05_MATH_NEG' => -87,
			'OP10_NAMED_UNARY_STRINGIFY' => -87,
			"{" => -87,
			'WORD' => -87,
			"foreach my" => -87,
			"\@{" => -87,
			"%{" => -87,
			"(" => -87,
			"[" => -87,
			'WORD_SCOPED' => -87,
			'LITERAL_NUMBER' => -87,
			'OP19_LOOP_CONTROL' => -87,
			"for my integer" => -87,
			'OP03_MATH_INC_DEC' => -87,
			"if (" => -87
		},
		GOTOS => {
			'ArgumentCheck' => 429
		}
	},
	{#State 428
		DEFAULT => -82
	},
	{#State 429
		DEFAULT => -85
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-21', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_56
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6304 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6311 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6318 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6374 lib/RPerl/Grammar.pm
	],
	[#Rule Class_67
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_71
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_72
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6449 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_76
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Method_81
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_87
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_88
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_89
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_90
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6610 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_132
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_133
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_153
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_154
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-54', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-56', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-56', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_194
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_195
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_196
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_197
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_201
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_202
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_203
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_207
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_208
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_209
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-59', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_213
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_214
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_215
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule TypeMethod_220
		 'TypeMethod', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7836 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_221
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_222
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_223
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7869 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_224
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7880 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7891 lib/RPerl/Grammar.pm
	]
],
#line 7894 lib/RPerl/Grammar.pm
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
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_52', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArgumentCheck_56', 
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
         'Class_67', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_71', 
         'Properties_72', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'PropertiesClass_76', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_81', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_87', 
         'MethodOrSubroutine_88', 
         'MethodOrSubroutine_89', 
         'Operation_90', 
         'Operation_91', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Operator_116', 
         'Operator_117', 
         'Operator_118', 
         'Operator_119', 
         'Operator_120', 
         'Operator_121', 
         'Operator_122', 
         'Operator_123', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_132', 
         'OperatorVoid_133', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_141', 
         'Expression_142', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'Expression_148', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'ExpressionOrStdin_153', 
         'ExpressionOrStdin_154', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_158', 
         'Statement_159', 
         'Statement_160', 
         'Statement_161', 
         'Statement_162', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_169', 
         'Loop_170', 
         'Loop_171', 
         'Loop_172', 
         'LoopFor_173', 
         'LoopForEach_174', 
         'LoopWhile_175', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_178', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_181', 
         'VariableRetrieval_182', 
         'VariableRetrieval_183', 
         'VariableRetrieval_184', 
         'VariableDeclaration_185', 
         'VariableDeclaration_186', 
         'VariableModification_187', 
         'VariableModification_188', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_194', 
         'ListElements_195', 
         'ListElement_196', 
         'ListElement_197', 
         'ListElement_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_201', 
         'ArrayDereferenced_202', 
         'ArrayDereferenced_203', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_206', 
         'HashEntry_207', 
         'HashEntryTyped_208', 
         'HashEntryTyped_209', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_213', 
         'HashDereferenced_214', 
         'HashDereferenced_215', 
         'WordScoped_216', 
         'WordScoped_217', 
         'LoopLabel_218', 
         'Type_219', 
         'TypeMethod_220', 
         'TypeInner_221', 
         'FileHandle_222', 
         'FileHandle_223', 
         'Literal_224', 
         'Literal_225', );
  $self;
}

#line 184 "lib/RPerl/Grammar.eyp"


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


#line 8168 lib/RPerl/Grammar.pm



1;
