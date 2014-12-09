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
    our $VERSION = 0.000_751;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|__method|\$TYPED_|while\ \(|package|elsif\ \(|\<STDIN\>|\=\ sub\ \{|undef|\(\ my|if\ \(|else|\@_\;|our|qw\(|use|my|\@\{|\.\.|\{\*|\%\{|\/|\]|\;|\}|\[|\(|\)|\{)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
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
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandle', 'OPTIONAL-44', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_151' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-46', ')' ], 0 ],
  [ 'Expression_155' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_156' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_157' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'OPTIONAL-48', 'Loop' ], 0 ],
  [ 'Statement_163' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_164' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_165' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'PAREN-51' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'Conditional_172' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-50', 'OPTIONAL-52' ], 0 ],
  [ 'Loop_173' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_174' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_175' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_176' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_177' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_178' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'Operation' ], 0 ],
  [ 'CodeBlock_181' => 'CodeBlock', [ '{', 'PLUS-53', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [ 'STAR-54', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [  ], 0 ],
  [ 'Variable_184' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-54' ], 0 ],
  [ 'VariableRetrieval_185' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_186' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_187' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_188' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_189' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_190' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_191' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-57', [ 'PLUS-57', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-57', [ 'WORD' ], 0 ],
  [ 'ListElements_197' => 'ListElements', [ 'ListElement', 'STAR-56' ], 0 ],
  [ 'ListElements_198' => 'ListElements', [ 'OP01_QW', '(', 'PLUS-57', ')' ], 0 ],
  [ 'ListElement_199' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_200' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_201' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'ArrayReference_204' => 'ArrayReference', [ '[', 'OPTIONAL-58', ']' ], 0 ],
  [ 'ArrayDereferenced_205' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_206' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'HashEntry_209' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-59', 'Expression' ], 0 ],
  [ 'HashEntry_210' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_211' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_212' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'HashReference_216' => 'HashReference', [ '{', 'HashEntry', 'STAR-61', '}' ], 0 ],
  [ 'HashDereferenced_217' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_218' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_220' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_221' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_222' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeMethod_223' => 'TypeMethod', [ 'WORD', '__method' ], 0 ],
  [ 'TypeInner_224' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandle_225' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_226' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'Literal_227' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_228' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  'OperatorVoid_139' => 139,
  '_OPTIONAL' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  '_OPTIONAL' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'Expression_148' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'Expression_154' => 154,
  'Expression_155' => 155,
  'ExpressionOrStdin_156' => 156,
  'ExpressionOrStdin_157' => 157,
  '_PAREN' => 158,
  '_OPTIONAL' => 159,
  '_OPTIONAL' => 160,
  'Statement_161' => 161,
  'Statement_162' => 162,
  'Statement_163' => 163,
  'Statement_164' => 164,
  'Statement_165' => 165,
  '_PAREN' => 166,
  '_STAR_LIST' => 167,
  '_STAR_LIST' => 168,
  '_PAREN' => 169,
  '_OPTIONAL' => 170,
  '_OPTIONAL' => 171,
  'Conditional_172' => 172,
  'Loop_173' => 173,
  'Loop_174' => 174,
  'Loop_175' => 175,
  'LoopFor_176' => 176,
  'LoopForEach_177' => 177,
  'LoopWhile_178' => 178,
  '_PLUS_LIST' => 179,
  '_PLUS_LIST' => 180,
  'CodeBlock_181' => 181,
  '_STAR_LIST' => 182,
  '_STAR_LIST' => 183,
  'Variable_184' => 184,
  'VariableRetrieval_185' => 185,
  'VariableRetrieval_186' => 186,
  'VariableRetrieval_187' => 187,
  'VariableDeclaration_188' => 188,
  'VariableDeclaration_189' => 189,
  'VariableModification_190' => 190,
  'VariableModification_191' => 191,
  '_PAREN' => 192,
  '_STAR_LIST' => 193,
  '_STAR_LIST' => 194,
  '_PLUS_LIST' => 195,
  '_PLUS_LIST' => 196,
  'ListElements_197' => 197,
  'ListElements_198' => 198,
  'ListElement_199' => 199,
  'ListElement_200' => 200,
  'ListElement_201' => 201,
  '_OPTIONAL' => 202,
  '_OPTIONAL' => 203,
  'ArrayReference_204' => 204,
  'ArrayDereferenced_205' => 205,
  'ArrayDereferenced_206' => 206,
  '_OPTIONAL' => 207,
  '_OPTIONAL' => 208,
  'HashEntry_209' => 209,
  'HashEntry_210' => 210,
  'HashEntryTyped_211' => 211,
  'HashEntryTyped_212' => 212,
  '_PAREN' => 213,
  '_STAR_LIST' => 214,
  '_STAR_LIST' => 215,
  'HashReference_216' => 216,
  'HashDereferenced_217' => 217,
  'HashDereferenced_218' => 218,
  'WordScoped_219' => 219,
  'WordScoped_220' => 220,
  'LoopLabel_221' => 221,
  'Type_222' => 222,
  'TypeMethod_223' => 223,
  'TypeInner_224' => 224,
  'FileHandle_225' => 225,
  'FileHandle_226' => 226,
  'Literal_227' => 227,
  'Literal_228' => 228,
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
			'SHEBANG' => 5,
			"package" => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'CompileUnit' => 4,
			'Program' => 7,
			'Critic' => 3,
			'PAREN-1' => 9,
			'OPTIONAL-9' => 8,
			'PLUS-2' => 1,
			'ModuleHeader' => 6
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 2,
			'' => -5
		},
		GOTOS => {
			'Critic' => 3,
			'PAREN-1' => 10,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 6
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
			'' => 13
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 15,
			'OPTIONAL-3' => 14
		}
	},
	{#State 6
		ACTIONS => {
			"use constant" => -25,
			"use parent qw(" => 17,
			"## no critic qw(" => -25,
			"our" => -25,
			"use" => -25
		},
		GOTOS => {
			'STAR-10' => 18,
			'Class' => 20,
			'Module' => 19,
			'Package' => 16
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			")" => 22,
			'WORD' => 23
		}
	},
	{#State 12
		DEFAULT => -35
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => -22
	},
	{#State 17
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 18
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"## no critic qw(" => 2,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 30,
			'STAR-11' => 29
		}
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => -23
	},
	{#State 21
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -36
	},
	{#State 23
		DEFAULT => -34
	},
	{#State 24
		ACTIONS => {
			"use warnings;" => 32
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
			")" => 34
		}
	},
	{#State 27
		DEFAULT => -219
	},
	{#State 28
		DEFAULT => -220
	},
	{#State 29
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 35
		},
		GOTOS => {
			'STAR-12' => 37,
			'Include' => 36
		}
	},
	{#State 30
		DEFAULT => -24
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
			"[" => -11,
			'OP05_MATH_NEG' => -11,
			'OP01_NAMED' => -11,
			"\@{" => -11,
			"for my integer" => -11,
			"use" => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'LITERAL_NUMBER' => -11,
			"%{" => -11,
			"{" => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD' => -11,
			"(" => -11,
			"use constant" => -11,
			"foreach my" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_PRINT_VOID' => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			"undef" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_OPEN_CLOSE' => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			'WORD_SCOPED' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 2,
			"while (" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'LITERAL_STRING' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			"my" => -11,
			"if (" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP19_LOOP_CONTROL' => -11
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-5' => 41
		}
	},
	{#State 34
		ACTIONS => {
			";" => 42
		}
	},
	{#State 35
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			"our" => 45,
			"use constant" => 48
		},
		GOTOS => {
			'Subroutine' => 46,
			'PLUS-13' => 44,
			'Constant' => 47
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 24
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
			'OP19_LOOP_CONTROL' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"if (" => -13,
			"my" => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'LITERAL_STRING' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"while (" => -13,
			'WORD_SCOPED' => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			'OP01_OPEN_CLOSE' => -13,
			"undef" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT_VOID' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"foreach my" => -13,
			"(" => -13,
			"use constant" => -13,
			'WORD' => -13,
			'VARIABLE_SYMBOL' => -13,
			"{" => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			"use" => 35,
			"for my integer" => -13,
			"our" => -13,
			"\@{" => -13,
			'OP01_NAMED' => -13,
			"[" => -13,
			'OP05_MATH_NEG' => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
		}
	},
	{#State 42
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 43
		ACTIONS => {
			"qw(" => 55,
			";" => 54
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 45,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 58
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		DEFAULT => -28
	},
	{#State 48
		ACTIONS => {
			'WORD' => 60
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
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			"\@{" => -15,
			"[" => -15,
			'OP05_MATH_NEG' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_NUMBER' => -15,
			"for my integer" => -15,
			"our" => -15,
			"(" => -15,
			"use constant" => 48,
			"foreach my" => -15,
			"{" => -15,
			"%{" => -15,
			'WORD' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			"undef" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_PRINT_VOID' => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			'OP01_OPEN_CLOSE' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"while (" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			"my" => -15,
			"if (" => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 62
		}
	},
	{#State 53
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 64
		}
	},
	{#State 54
		DEFAULT => -39
	},
	{#State 55
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 56
		DEFAULT => -30
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 59
		DEFAULT => -222
	},
	{#State 60
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			"{" => 101,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 98,
			"(" => 97,
			"foreach my" => -160,
			"our" => 45,
			"for my integer" => -160,
			'LITERAL_NUMBER' => 113,
			'OP01_NAMED_VOID' => 112,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"if (" => 79,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"while (" => -160,
			'OP05_LOGICAL_NEG' => 72,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82
		},
		GOTOS => {
			'OPTIONAL-48' => 96,
			'VariableDeclaration' => 95,
			'Operation' => 103,
			'Variable' => 104,
			'PAREN-47' => 77,
			'Operator' => 76,
			'LoopLabel' => 102,
			'Subroutine' => 73,
			'Expression' => 78,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'PLUS-8' => 106,
			'ArrayReference' => 83,
			'OperatorVoid' => 85,
			'Statement' => 115,
			'ArrayDereferenced' => 93,
			'VariableModification' => 94,
			'WordScoped' => 111,
			'Conditional' => 114
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"use" => -60,
			"our %properties = (" => -60,
			"## no critic qw(" => 2,
			"use constant" => -60
		},
		GOTOS => {
			'Critic' => 116,
			'STAR-24' => 117
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 119,
			")" => 118
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 120
		}
	},
	{#State 69
		ACTIONS => {
			"my" => 122
		},
		GOTOS => {
			'TypeInner' => 121
		}
	},
	{#State 70
		DEFAULT => -227
	},
	{#State 71
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108
		},
		GOTOS => {
			'Expression' => 123,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86
		}
	},
	{#State 72
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'Expression' => 125,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'ArrayDereferenced' => 93
		}
	},
	{#State 73
		DEFAULT => -14
	},
	{#State 74
		ACTIONS => {
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 126,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 128
		},
		GOTOS => {
			'LoopLabel' => 127
		}
	},
	{#State 76
		DEFAULT => -152
	},
	{#State 77
		DEFAULT => -159
	},
	{#State 78
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			";" => 145,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP18_TERNARY' => 135,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136
		}
	},
	{#State 79
		ACTIONS => {
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Expression' => 146,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'ArrayReference' => 83
		}
	},
	{#State 80
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 147
		}
	},
	{#State 81
		ACTIONS => {
			"my" => 150,
			"{*" => 148
		},
		GOTOS => {
			'FileHandle' => 149
		}
	},
	{#State 82
		DEFAULT => -144
	},
	{#State 83
		DEFAULT => -147
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99
		},
		GOTOS => {
			'Variable' => 151
		}
	},
	{#State 85
		DEFAULT => -163
	},
	{#State 86
		DEFAULT => -145
	},
	{#State 87
		ACTIONS => {
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			'OP01_QW' => 158,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			")" => -125,
			'KEYS_OR_VALUES' => 156,
			"my" => 122,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'TypeInner' => 154,
			'Literal' => 86,
			'ListElements' => 153,
			'OPTIONAL-40' => 157,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111
		}
	},
	{#State 88
		ACTIONS => {
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			";" => -131,
			'OP10_NAMED_UNARY' => 105,
			'KEYS_OR_VALUES' => 156,
			"my" => 162,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"{*" => 148,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97
		},
		GOTOS => {
			'Expression' => 155,
			'Variable' => 124,
			'Operator' => 76,
			'FileHandle' => 160,
			'WordScoped' => 111,
			'ArrayDereferenced' => 93,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'TypeInner' => 154,
			'OPTIONAL-43' => 161,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ListElements' => 159
		}
	},
	{#State 89
		DEFAULT => -150
	},
	{#State 90
		DEFAULT => -149
	},
	{#State 91
		ACTIONS => {
			"{*" => 148,
			"my" => 150
		},
		GOTOS => {
			'FileHandle' => 163
		}
	},
	{#State 92
		ACTIONS => {
			"{*" => 148,
			"my" => 150
		},
		GOTOS => {
			'FileHandle' => 164
		}
	},
	{#State 93
		DEFAULT => -148
	},
	{#State 94
		DEFAULT => -165
	},
	{#State 95
		DEFAULT => -164
	},
	{#State 96
		ACTIONS => {
			"foreach my" => 168,
			"while (" => 165,
			"for my integer" => 171
		},
		GOTOS => {
			'LoopForEach' => 170,
			'LoopWhile' => 166,
			'LoopFor' => 169,
			'Loop' => 167
		}
	},
	{#State 97
		ACTIONS => {
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Expression' => 172,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89
		}
	},
	{#State 98
		ACTIONS => {
			"(" => -219,
			'COLON' => -221
		}
	},
	{#State 99
		DEFAULT => -183,
		GOTOS => {
			'STAR-54' => 173
		}
	},
	{#State 100
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99,
			"{" => 175
		},
		GOTOS => {
			'HashReference' => 176,
			'Variable' => 174
		}
	},
	{#State 101
		ACTIONS => {
			"}" => 180,
			'WORD' => 179,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 178,
			'HashEntry' => 177
		}
	},
	{#State 102
		ACTIONS => {
			'COLON' => 181
		}
	},
	{#State 103
		DEFAULT => -17
	},
	{#State 104
		ACTIONS => {
			";" => -146,
			'OP02_METHOD_THINARROW' => 182,
			'OP24_LOGICAL_OR_XOR' => -146,
			'OP23_LOGICAL_AND' => -146,
			'OP18_TERNARY' => -146,
			'OP16_LOGICAL_OR' => -146,
			'OP09_BITWISE_SHIFT' => -146,
			'OP17_LIST_RANGE' => -146,
			'OP15_LOGICAL_AND' => -146,
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP19_VARIABLE_ASSIGN_BY' => 183,
			'OP19_VARIABLE_ASSIGN' => 185,
			'OP14_BITWISE_OR_XOR' => -146,
			'OP13_BITWISE_AND' => -146,
			'OP04_MATH_POW' => -146,
			'OP11_COMPARE_LT_GT' => -146,
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP08_MATH_ADD_SUB' => -146,
			'OP06_REGEX_MATCH' => -146,
			'OP03_MATH_INC_DEC' => 184,
			'OP08_STRING_CAT' => -146
		}
	},
	{#State 105
		ACTIONS => {
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Expression' => 186,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'ArrayReference' => 83
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"while (" => -160,
			'OP05_LOGICAL_NEG' => 72,
			'WORD_SCOPED' => 28,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"if (" => 79,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_PRINT_VOID_PAREN' => 92,
			"foreach my" => -160,
			"(" => 97,
			'WORD' => 98,
			'VARIABLE_SYMBOL' => 99,
			"%{" => 100,
			"{" => 101,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'' => -18,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'LITERAL_NUMBER' => 113,
			'OP01_NAMED_VOID' => 112,
			"for my integer" => -160
		},
		GOTOS => {
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96,
			'Expression' => 78,
			'PAREN-47' => 77,
			'Operation' => 187,
			'Variable' => 104,
			'Operator' => 76,
			'LoopLabel' => 102,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'OperatorVoid' => 85,
			'ArrayReference' => 83,
			'VariableModification' => 94,
			'Statement' => 115,
			'ArrayDereferenced' => 93,
			'Conditional' => 114,
			'WordScoped' => 111
		}
	},
	{#State 107
		ACTIONS => {
			"[" => 110,
			'VARIABLE_SYMBOL' => 99
		},
		GOTOS => {
			'ArrayReference' => 189,
			'Variable' => 188
		}
	},
	{#State 108
		ACTIONS => {
			"(" => 190
		}
	},
	{#State 109
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 191,
			'ArrayDereferenced' => 93
		}
	},
	{#State 110
		ACTIONS => {
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			"]" => -203,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'KEYS_OR_VALUES' => 156,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 155,
			'ListElements' => 193,
			'HashDereferenced' => 89,
			'TypeInner' => 154,
			'HashReference' => 90,
			'Literal' => 86,
			'ArrayReference' => 83,
			'OPTIONAL-58' => 192,
			'ListElement' => 152
		}
	},
	{#State 111
		ACTIONS => {
			"(" => 194
		}
	},
	{#State 112
		ACTIONS => {
			'KEYS_OR_VALUES' => 156,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			'OP10_NAMED_UNARY' => 105,
			";" => -129,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP01_QW' => 158,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ListElements' => 195,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'TypeInner' => 154,
			'Literal' => 86,
			'ArrayReference' => 83,
			'ListElement' => 152,
			'ArrayDereferenced' => 93,
			'OPTIONAL-42' => 196,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 155
		}
	},
	{#State 113
		DEFAULT => -228
	},
	{#State 114
		DEFAULT => -161
	},
	{#State 115
		DEFAULT => -91
	},
	{#State 116
		DEFAULT => -57
	},
	{#State 117
		ACTIONS => {
			"use constant" => -62,
			"use" => 35,
			"our %properties = (" => -62
		},
		GOTOS => {
			'STAR-25' => 198,
			'Include' => 197
		}
	},
	{#State 118
		ACTIONS => {
			";" => 199
		}
	},
	{#State 119
		DEFAULT => -37
	},
	{#State 120
		ACTIONS => {
			'OP01_OPEN_CLOSE' => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			"undef" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			'OP01_PRINT_VOID' => -43,
			"( my" => 201,
			'OP19_LOOP_CONTROL' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"my" => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			"if (" => -43,
			'OP22_LOGICAL_NOT' => -43,
			'LITERAL_STRING' => -43,
			'WORD_SCOPED' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"while (" => -43,
			'OP01_NAMED_VOID' => -43,
			'LITERAL_NUMBER' => -43,
			"for my integer" => -43,
			"\@{" => -43,
			"[" => -43,
			'OP05_MATH_NEG' => -43,
			'OP01_NAMED' => -43,
			'OP10_NAMED_UNARY' => -43,
			"(" => -43,
			"foreach my" => -43,
			"{" => -43,
			"%{" => -43,
			'WORD' => -43,
			'VARIABLE_SYMBOL' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 200,
			'OPTIONAL-16' => 202
		}
	},
	{#State 121
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'LITERAL_NUMBER' => 113
		},
		GOTOS => {
			'Literal' => 203
		}
	},
	{#State 122
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 123
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -121,
			"}" => -121,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP21_LIST_COMMA' => -121,
			"]" => -121,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP23_LOGICAL_AND' => -121,
			";" => -121,
			")" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 142,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136
		}
	},
	{#State 124
		ACTIONS => {
			'OP23_LOGICAL_AND' => -146,
			'OP24_LOGICAL_OR_XOR' => -146,
			'OP02_METHOD_THINARROW' => 182,
			";" => -146,
			")" => -146,
			'OP17_LIST_RANGE' => -146,
			'OP15_LOGICAL_AND' => -146,
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP18_TERNARY' => -146,
			'OP16_LOGICAL_OR' => -146,
			'OP09_BITWISE_SHIFT' => -146,
			'OP14_BITWISE_OR_XOR' => -146,
			'OP08_STRING_CAT' => -146,
			'OP06_REGEX_MATCH' => -146,
			'OP03_MATH_INC_DEC' => 184,
			"}" => -146,
			'OP08_MATH_ADD_SUB' => -146,
			".." => -146,
			"]" => -146,
			'OP21_LIST_COMMA' => -146,
			'OP11_COMPARE_LT_GT' => -146,
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP13_BITWISE_AND' => -146,
			'OP04_MATH_POW' => -146
		}
	},
	{#State 125
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -104,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => -104,
			'OP08_STRING_CAT' => -104,
			"}" => -104,
			".." => -104,
			'OP08_MATH_ADD_SUB' => -104,
			";" => -104,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => -104
		}
	},
	{#State 126
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -112,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			"}" => -112,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -112,
			'OP21_LIST_COMMA' => -112,
			"]" => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			";" => -112,
			")" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => -112
		}
	},
	{#State 127
		ACTIONS => {
			";" => 205
		}
	},
	{#State 128
		DEFAULT => -221
	},
	{#State 129
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 206,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90
		}
	},
	{#State 130
		ACTIONS => {
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Expression' => 207,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'ArrayReference' => 83
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 208,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76
		}
	},
	{#State 132
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 209,
			'ArrayDereferenced' => 93
		}
	},
	{#State 133
		ACTIONS => {
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 210,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90
		}
	},
	{#State 134
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'Expression' => 211,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'ArrayDereferenced' => 93
		}
	},
	{#State 135
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99
		},
		GOTOS => {
			'Variable' => 212
		}
	},
	{#State 136
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 213,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ArrayReference' => 83
		}
	},
	{#State 137
		ACTIONS => {
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 214,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89
		}
	},
	{#State 138
		ACTIONS => {
			"/" => 215
		}
	},
	{#State 139
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Expression' => 216,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'ArrayDereferenced' => 93
		}
	},
	{#State 140
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'Expression' => 217,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'ArrayReference' => 83
		}
	},
	{#State 141
		ACTIONS => {
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 218,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89
		}
	},
	{#State 142
		ACTIONS => {
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 219,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86
		}
	},
	{#State 143
		ACTIONS => {
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 220,
			'ArrayDereferenced' => 93
		}
	},
	{#State 144
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 221,
			'ArrayDereferenced' => 93
		}
	},
	{#State 145
		DEFAULT => -90
	},
	{#State 146
		ACTIONS => {
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			")" => 222
		}
	},
	{#State 147
		ACTIONS => {
			'VARIABLE_SYMBOL' => 223
		}
	},
	{#State 148
		ACTIONS => {
			'WORD' => 224
		}
	},
	{#State 149
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			")" => -95,
			'KEYS_OR_VALUES' => 156,
			"my" => 122,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 155,
			'OPTIONAL-38' => 225,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'ListElement' => 152,
			'ListElements' => 226,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'TypeInner' => 154
		}
	},
	{#State 150
		ACTIONS => {
			"filehandle_ref" => 227
		}
	},
	{#State 151
		DEFAULT => -101
	},
	{#State 152
		DEFAULT => -194,
		GOTOS => {
			'STAR-56' => 228
		}
	},
	{#State 153
		DEFAULT => -124
	},
	{#State 154
		ACTIONS => {
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 229,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90
		}
	},
	{#State 155
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			"]" => -199,
			'OP21_LIST_COMMA' => -199,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			")" => -199,
			";" => -199,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134
		}
	},
	{#State 156
		ACTIONS => {
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 230
		}
	},
	{#State 157
		ACTIONS => {
			")" => 231
		}
	},
	{#State 158
		ACTIONS => {
			"(" => 232
		}
	},
	{#State 159
		DEFAULT => -130
	},
	{#State 160
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			";" => -133,
			'OP10_NAMED_UNARY' => 105,
			"my" => 122,
			'KEYS_OR_VALUES' => 156,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP01_QW' => 158,
			'OP05_MATH_NEG' => 109,
			"[" => 110
		},
		GOTOS => {
			'TypeInner' => 154,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'ListElements' => 234,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'OPTIONAL-44' => 233,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76
		}
	},
	{#State 161
		ACTIONS => {
			";" => 235
		}
	},
	{#State 162
		ACTIONS => {
			'WORD' => 59,
			"filehandle_ref" => 227
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 163
		ACTIONS => {
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			'KEYS_OR_VALUES' => 156,
			'OP10_NAMED_UNARY' => 105,
			";" => -97,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'OPTIONAL-39' => 237,
			'Expression' => 155,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Literal' => 86,
			'TypeInner' => 154,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'ListElements' => 236,
			'ListElement' => 152,
			'ArrayReference' => 83
		}
	},
	{#State 164
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			"my" => 122,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'KEYS_OR_VALUES' => 156,
			")" => -127,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110
		},
		GOTOS => {
			'HashReference' => 90,
			'TypeInner' => 154,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ListElements' => 239,
			'OPTIONAL-41' => 238,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76
		}
	},
	{#State 165
		ACTIONS => {
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81
		},
		GOTOS => {
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 240,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124
		}
	},
	{#State 166
		DEFAULT => -175
	},
	{#State 167
		DEFAULT => -162
	},
	{#State 168
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 241
		}
	},
	{#State 169
		DEFAULT => -173
	},
	{#State 170
		DEFAULT => -174
	},
	{#State 171
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 172
		ACTIONS => {
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			")" => 243,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144
		}
	},
	{#State 173
		ACTIONS => {
			'OP02_HASH_THINARROW' => 244,
			'OP09_BITWISE_SHIFT' => -184,
			'OP18_TERNARY' => -184,
			'OP16_LOGICAL_OR' => -184,
			'OP07_MATH_MULT_DIV_MOD' => -184,
			'OP17_LIST_RANGE' => -184,
			'OP15_LOGICAL_AND' => -184,
			")" => -184,
			";" => -184,
			'OP02_METHOD_THINARROW' => -184,
			'OP24_LOGICAL_OR_XOR' => -184,
			'OP23_LOGICAL_AND' => -184,
			'OP13_BITWISE_AND' => -184,
			'OP04_MATH_POW' => -184,
			'COLON' => -184,
			'OP11_COMPARE_LT_GT' => -184,
			'OP12_COMPARE_EQ_NEQ' => -184,
			"]" => -184,
			'OP21_LIST_COMMA' => -184,
			".." => -184,
			'OP08_MATH_ADD_SUB' => -184,
			"}" => -184,
			'OP06_REGEX_MATCH' => -184,
			'OP03_MATH_INC_DEC' => -184,
			'OP08_STRING_CAT' => -184,
			'OP19_VARIABLE_ASSIGN_BY' => -184,
			'OP02_ARRAY_THINARROW' => 245,
			'OP14_BITWISE_OR_XOR' => -184,
			'OP19_VARIABLE_ASSIGN' => -184
		},
		GOTOS => {
			'VariableRetrieval' => 246
		}
	},
	{#State 174
		ACTIONS => {
			"}" => 247
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => 179,
			"%{" => 100
		},
		GOTOS => {
			'HashEntry' => 177,
			'HashDereferenced' => 178
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 177
		DEFAULT => -215,
		GOTOS => {
			'STAR-61' => 249
		}
	},
	{#State 178
		DEFAULT => -210
	},
	{#State 179
		ACTIONS => {
			'OP20_HASH_FATARROW' => 250
		}
	},
	{#State 180
		DEFAULT => -151
	},
	{#State 181
		DEFAULT => -158
	},
	{#State 182
		ACTIONS => {
			'WORD' => 251
		}
	},
	{#State 183
		ACTIONS => {
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Expression' => 252,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'ArrayDereferenced' => 93
		}
	},
	{#State 184
		DEFAULT => -102
	},
	{#State 185
		ACTIONS => {
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP10_NAMED_UNARY' => 105,
			"<STDIN>" => 254,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Expression' => 255,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ArrayReference' => 83,
			'ExpressionOrStdin' => 253
		}
	},
	{#State 186
		ACTIONS => {
			'OP18_TERNARY' => -111,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			";" => -111,
			")" => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			"]" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -111,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			"}" => -111,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -111,
			'OP14_BITWISE_OR_XOR' => -111
		}
	},
	{#State 187
		DEFAULT => -16
	},
	{#State 188
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 189
		ACTIONS => {
			"}" => 257
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			"{" => 101,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP10_NAMED_UNARY' => 105,
			")" => -93,
			"my" => 122,
			'KEYS_OR_VALUES' => 156,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'ArrayReference' => 83,
			'ListElement' => 152,
			'ListElements' => 259,
			'Literal' => 86,
			'TypeInner' => 154,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 155,
			'ArrayDereferenced' => 93,
			'OPTIONAL-37' => 258
		}
	},
	{#State 191
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP08_MATH_ADD_SUB' => 137,
			")" => 260,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132
		}
	},
	{#State 192
		ACTIONS => {
			"]" => 261
		}
	},
	{#State 193
		DEFAULT => -202
	},
	{#State 194
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'KEYS_OR_VALUES' => 156,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			")" => -141,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED' => 108,
			'OP01_QW' => 158,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'TypeInner' => 154,
			'Literal' => 86,
			'OPTIONAL-45' => 262,
			'ListElements' => 263,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76
		}
	},
	{#State 195
		DEFAULT => -128
	},
	{#State 196
		ACTIONS => {
			";" => 264
		}
	},
	{#State 197
		DEFAULT => -59
	},
	{#State 198
		ACTIONS => {
			"use constant" => 48,
			"our %properties = (" => 266
		},
		GOTOS => {
			'Constant' => 265,
			'Properties' => 267
		}
	},
	{#State 199
		DEFAULT => -40
	},
	{#State 200
		DEFAULT => -42
	},
	{#State 201
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 202
		ACTIONS => {
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED_VOID' => 112,
			'LITERAL_NUMBER' => 113,
			"for my integer" => -160,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"[" => 110,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"if (" => 79,
			'OP10_NAMED_UNARY' => 105,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			"foreach my" => -160,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 98,
			'VARIABLE_SYMBOL' => 99,
			"while (" => -160
		},
		GOTOS => {
			'Conditional' => 114,
			'WordScoped' => 111,
			'VariableModification' => 94,
			'ArrayDereferenced' => 93,
			'Statement' => 115,
			'OperatorVoid' => 85,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Expression' => 78,
			'Operator' => 76,
			'LoopLabel' => 102,
			'Operation' => 269,
			'Variable' => 104,
			'PAREN-47' => 77,
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96,
			'PLUS-17' => 270
		}
	},
	{#State 203
		ACTIONS => {
			";" => 271
		}
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 272
		}
	},
	{#State 205
		DEFAULT => -139
	},
	{#State 206
		ACTIONS => {
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -114,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP11_COMPARE_LT_GT' => 130,
			'OP21_LIST_COMMA' => -114,
			"]" => -114,
			".." => -114,
			'OP08_MATH_ADD_SUB' => 137,
			"}" => -114,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP18_TERNARY' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP09_BITWISE_SHIFT' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => -114,
			'OP17_LIST_RANGE' => -114,
			")" => -114,
			";" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP23_LOGICAL_AND' => -114
		}
	},
	{#State 207
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP23_LOGICAL_AND' => -113,
			";" => -113,
			")" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP18_TERNARY' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP09_BITWISE_SHIFT' => 136,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			".." => -113,
			'OP08_MATH_ADD_SUB' => 137,
			"}" => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP11_COMPARE_LT_GT' => undef,
			'OP21_LIST_COMMA' => -113,
			"]" => -113,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -113
		}
	},
	{#State 208
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP17_LIST_RANGE' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => -116,
			";" => -116,
			")" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			"]" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -116,
			"}" => -116,
			'OP14_BITWISE_OR_XOR' => -116
		}
	},
	{#State 209
		ACTIONS => {
			".." => -107,
			'OP08_MATH_ADD_SUB' => -107,
			"}" => -107,
			'OP08_STRING_CAT' => -107,
			'OP06_REGEX_MATCH' => 138,
			'OP13_BITWISE_AND' => -107,
			'OP04_MATH_POW' => 141,
			'OP11_COMPARE_LT_GT' => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			"]" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP18_TERNARY' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP23_LOGICAL_AND' => -107,
			")" => -107,
			";" => -107
		}
	},
	{#State 210
		ACTIONS => {
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP21_LIST_COMMA' => -117,
			"]" => -117,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -117,
			"}" => -117,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => -117,
			'OP17_LIST_RANGE' => -117,
			")" => -117,
			";" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP23_LOGICAL_AND' => -117
		}
	},
	{#State 211
		ACTIONS => {
			"]" => -118,
			'OP21_LIST_COMMA' => -118,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			"}" => -118,
			".." => -118,
			'OP08_MATH_ADD_SUB' => 137,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => -118,
			";" => -118,
			")" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP24_LOGICAL_OR_XOR' => -118
		}
	},
	{#State 212
		ACTIONS => {
			'COLON' => 273
		}
	},
	{#State 213
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -110,
			"}" => -110,
			".." => -110,
			'OP08_MATH_ADD_SUB' => 137,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -110,
			"]" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			")" => -110,
			";" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP18_TERNARY' => -110,
			'OP09_BITWISE_SHIFT' => -110
		}
	},
	{#State 214
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP18_TERNARY' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			")" => -108,
			";" => -108,
			"}" => -108,
			".." => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP08_STRING_CAT' => -108,
			'OP06_REGEX_MATCH' => 138,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP12_COMPARE_EQ_NEQ' => -108,
			'OP14_BITWISE_OR_XOR' => -108
		}
	},
	{#State 215
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 274
		}
	},
	{#State 216
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"]" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => -109,
			".." => -109,
			'OP08_MATH_ADD_SUB' => 137,
			"}" => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP18_TERNARY' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => -109,
			";" => -109,
			")" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP23_LOGICAL_AND' => -109
		}
	},
	{#State 217
		ACTIONS => {
			";" => -115,
			")" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP18_TERNARY' => -115,
			'OP09_BITWISE_SHIFT' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			"]" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP13_BITWISE_AND' => -115,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			"}" => -115,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -115
		}
	},
	{#State 218
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -103,
			'OP06_REGEX_MATCH' => -103,
			'OP08_STRING_CAT' => -103,
			'OP08_MATH_ADD_SUB' => -103,
			".." => -103,
			"}" => -103,
			'OP11_COMPARE_LT_GT' => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP21_LIST_COMMA' => -103,
			"]" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP04_MATH_POW' => 141,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			";" => -103,
			")" => -103,
			'OP07_MATH_MULT_DIV_MOD' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP09_BITWISE_SHIFT' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP18_TERNARY' => -103
		}
	},
	{#State 219
		ACTIONS => {
			'OP23_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			")" => -119,
			";" => -119,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => -119,
			'OP16_LOGICAL_OR' => 134,
			'OP14_BITWISE_OR_XOR' => 131,
			"}" => -119,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -119,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			"]" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129
		}
	},
	{#State 220
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP21_LIST_COMMA' => -122,
			"]" => -122,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			"}" => -122,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -122,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			")" => -122,
			";" => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132
		}
	},
	{#State 221
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP23_LOGICAL_AND' => 143,
			";" => -123,
			")" => -123,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP18_TERNARY' => 135,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -123,
			"}" => -123,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP21_LIST_COMMA' => -123,
			"]" => -123,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141
		}
	},
	{#State 222
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 276
		}
	},
	{#State 223
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 278,
			";" => 277
		}
	},
	{#State 224
		ACTIONS => {
			"}" => 279
		}
	},
	{#State 225
		ACTIONS => {
			")" => 280
		}
	},
	{#State 226
		DEFAULT => -94
	},
	{#State 227
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 228
		ACTIONS => {
			")" => -197,
			"]" => -197,
			";" => -197,
			'OP21_LIST_COMMA' => 283
		},
		GOTOS => {
			'PAREN-55' => 282
		}
	},
	{#State 229
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			"]" => -200,
			'OP21_LIST_COMMA' => -200,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 142,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			")" => -200,
			";" => -200
		}
	},
	{#State 230
		DEFAULT => -201
	},
	{#State 231
		ACTIONS => {
			";" => 284
		}
	},
	{#State 232
		ACTIONS => {
			'WORD' => 286
		},
		GOTOS => {
			'PLUS-57' => 285
		}
	},
	{#State 233
		ACTIONS => {
			";" => 287
		}
	},
	{#State 234
		DEFAULT => -132
	},
	{#State 235
		DEFAULT => -137
	},
	{#State 236
		DEFAULT => -96
	},
	{#State 237
		ACTIONS => {
			";" => 288
		}
	},
	{#State 238
		ACTIONS => {
			")" => 289
		}
	},
	{#State 239
		DEFAULT => -126
	},
	{#State 240
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP16_LOGICAL_OR' => 134,
			'OP17_LIST_RANGE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => 133,
			")" => 290,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144
		}
	},
	{#State 241
		ACTIONS => {
			'VARIABLE_SYMBOL' => 291
		}
	},
	{#State 242
		ACTIONS => {
			"(" => 292
		}
	},
	{#State 243
		DEFAULT => -155
	},
	{#State 244
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'WORD' => 293,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 294
		}
	},
	{#State 245
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 295,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'ArrayReference' => 83
		}
	},
	{#State 246
		DEFAULT => -182
	},
	{#State 247
		DEFAULT => -217
	},
	{#State 248
		DEFAULT => -218
	},
	{#State 249
		ACTIONS => {
			'OP21_LIST_COMMA' => 298,
			"}" => 297
		},
		GOTOS => {
			'PAREN-60' => 296
		}
	},
	{#State 250
		ACTIONS => {
			"undef" => -208,
			'OP03_MATH_INC_DEC' => -208,
			"\@{" => -208,
			'OP01_NAMED' => -208,
			"[" => -208,
			'OP05_MATH_NEG' => -208,
			'LITERAL_NUMBER' => -208,
			'OP01_OPEN_CLOSE' => -208,
			'LITERAL_STRING' => -208,
			"(" => -208,
			'OP22_LOGICAL_NOT' => -208,
			'VARIABLE_SYMBOL' => -208,
			'WORD' => -208,
			'OP05_LOGICAL_NEG' => -208,
			'WORD_SCOPED' => -208,
			"%{" => -208,
			"{" => -208,
			'OP10_NAMED_UNARY_STRINGIFY' => -208,
			'OP10_NAMED_UNARY' => -208,
			'OP01_OPEN_CLOSE_PAREN' => -208,
			"my" => 122
		},
		GOTOS => {
			'OPTIONAL-59' => 299,
			'TypeInner' => 300
		}
	},
	{#State 251
		ACTIONS => {
			"(" => 301
		}
	},
	{#State 252
		ACTIONS => {
			";" => 302,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137
		}
	},
	{#State 253
		ACTIONS => {
			";" => 303
		}
	},
	{#State 254
		DEFAULT => -157
	},
	{#State 255
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			";" => -156,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132
		}
	},
	{#State 256
		DEFAULT => -205
	},
	{#State 257
		DEFAULT => -206
	},
	{#State 258
		ACTIONS => {
			")" => 304
		}
	},
	{#State 259
		DEFAULT => -92
	},
	{#State 260
		DEFAULT => -105
	},
	{#State 261
		DEFAULT => -204
	},
	{#State 262
		ACTIONS => {
			")" => 305
		}
	},
	{#State 263
		DEFAULT => -140
	},
	{#State 264
		DEFAULT => -136
	},
	{#State 265
		DEFAULT => -61
	},
	{#State 266
		ACTIONS => {
			")" => 306,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 307
		}
	},
	{#State 267
		ACTIONS => {
			"our %properties_class = (" => 310,
			"our" => -64,
			'LITERAL_NUMBER' => -64
		},
		GOTOS => {
			'PropertiesClass' => 308,
			'OPTIONAL-26' => 309
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
			"(" => 97,
			"foreach my" => -160,
			"{" => 101,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 98,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 107,
			"}" => 313,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP01_NAMED_VOID' => 112,
			'LITERAL_NUMBER' => 113,
			"for my integer" => -160,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 72,
			"while (" => -160,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"if (" => 79,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_PRINT_VOID_PAREN' => 92
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Statement' => 115,
			'VariableModification' => 94,
			'WordScoped' => 111,
			'Conditional' => 114,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'ArrayReference' => 83,
			'OperatorVoid' => 85,
			'LoopLabel' => 102,
			'Operator' => 76,
			'Operation' => 312,
			'Variable' => 104,
			'PAREN-47' => 77,
			'Expression' => 78,
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96
		}
	},
	{#State 271
		DEFAULT => -41
	},
	{#State 272
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 273
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99
		},
		GOTOS => {
			'Variable' => 315
		}
	},
	{#State 274
		ACTIONS => {
			"/" => 316
		}
	},
	{#State 275
		ACTIONS => {
			"for my integer" => -160,
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP01_NAMED_VOID' => 112,
			'OP01_PRINT_VOID' => 88,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 80,
			'OP10_NAMED_UNARY' => 105,
			"if (" => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP19_LOOP_CONTROL' => 75,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"while (" => -160,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 98,
			'OP05_LOGICAL_NEG' => 72,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"foreach my" => -160
		},
		GOTOS => {
			'WordScoped' => 111,
			'Conditional' => 114,
			'Statement' => 115,
			'ArrayDereferenced' => 93,
			'VariableModification' => 94,
			'ArrayReference' => 83,
			'OperatorVoid' => 85,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'Operation' => 317,
			'Variable' => 104,
			'PAREN-47' => 77,
			'Operator' => 76,
			'LoopLabel' => 102,
			'Expression' => 78,
			'PLUS-53' => 318,
			'OPTIONAL-48' => 96,
			'VariableDeclaration' => 95
		}
	},
	{#State 276
		DEFAULT => -168,
		GOTOS => {
			'STAR-50' => 319
		}
	},
	{#State 277
		DEFAULT => -188
	},
	{#State 278
		ACTIONS => {
			"<STDIN>" => 254,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107
		},
		GOTOS => {
			'ExpressionOrStdin' => 320,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 255,
			'ArrayDereferenced' => 93
		}
	},
	{#State 279
		DEFAULT => -225
	},
	{#State 280
		ACTIONS => {
			";" => 321
		}
	},
	{#State 281
		DEFAULT => -226
	},
	{#State 282
		DEFAULT => -193
	},
	{#State 283
		ACTIONS => {
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			'KEYS_OR_VALUES' => 156,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayReference' => 83,
			'ListElement' => 322,
			'TypeInner' => 154,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'Expression' => 155,
			'ArrayDereferenced' => 93
		}
	},
	{#State 284
		DEFAULT => -134
	},
	{#State 285
		ACTIONS => {
			'WORD' => 324,
			")" => 323
		}
	},
	{#State 286
		DEFAULT => -196
	},
	{#State 287
		DEFAULT => -138
	},
	{#State 288
		DEFAULT => -100
	},
	{#State 289
		ACTIONS => {
			";" => 325
		}
	},
	{#State 290
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 291
		ACTIONS => {
			"(" => 327
		}
	},
	{#State 292
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Expression' => 328,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'ArrayDereferenced' => 93,
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89
		}
	},
	{#State 293
		ACTIONS => {
			"}" => 329,
			"(" => -219
		}
	},
	{#State 294
		ACTIONS => {
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			"}" => 330,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139
		}
	},
	{#State 295
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP08_MATH_ADD_SUB' => 137,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			"]" => 331
		}
	},
	{#State 296
		DEFAULT => -214
	},
	{#State 297
		DEFAULT => -216
	},
	{#State 298
		ACTIONS => {
			"%{" => 100,
			'WORD' => 179
		},
		GOTOS => {
			'HashEntry' => 332,
			'HashDereferenced' => 178
		}
	},
	{#State 299
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'Expression' => 333,
			'ArrayDereferenced' => 93
		}
	},
	{#State 300
		DEFAULT => -207
	},
	{#State 301
		ACTIONS => {
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'OP01_NAMED' => 108,
			'OP01_QW' => 158,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP10_NAMED_UNARY' => 105,
			")" => -143,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"my" => 122,
			'KEYS_OR_VALUES' => 156,
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'TypeInner' => 154,
			'Literal' => 86,
			'OPTIONAL-46' => 335,
			'ListElements' => 334,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111
		}
	},
	{#State 302
		DEFAULT => -191
	},
	{#State 303
		DEFAULT => -190
	},
	{#State 304
		DEFAULT => -98
	},
	{#State 305
		DEFAULT => -153
	},
	{#State 306
		ACTIONS => {
			";" => 336
		}
	},
	{#State 307
		ACTIONS => {
			'WORD' => 338,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 339,
			'HashEntryTyped' => 337
		}
	},
	{#State 308
		DEFAULT => -63
	},
	{#State 309
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 340
		}
	},
	{#State 310
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 341
		}
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
		DEFAULT => -120
	},
	{#State 316
		DEFAULT => -106
	},
	{#State 317
		DEFAULT => -180
	},
	{#State 318
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 98,
			"{" => 101,
			"%{" => 100,
			"foreach my" => -160,
			"(" => 97,
			"for my integer" => -160,
			'OP01_NAMED_VOID' => 112,
			'LITERAL_NUMBER' => 113,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			"\@{" => 107,
			"}" => 345,
			"if (" => 79,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_LOGICAL_NEG' => 72,
			"while (" => -160,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_OPEN_CLOSE' => 91,
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_PRINT_VOID' => 88,
			'OP01_NAMED_VOID_PAREN' => 87,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayReference' => 83,
			'OperatorVoid' => 85,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 111,
			'Conditional' => 114,
			'ArrayDereferenced' => 93,
			'Statement' => 115,
			'VariableModification' => 94,
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96,
			'Operator' => 76,
			'LoopLabel' => 102,
			'PAREN-47' => 77,
			'Variable' => 104,
			'Operation' => 346,
			'Expression' => 78
		}
	},
	{#State 319
		ACTIONS => {
			"while (" => -171,
			'OP05_LOGICAL_NEG' => -171,
			'WORD_SCOPED' => -171,
			'LITERAL_STRING' => -171,
			'OP22_LOGICAL_NOT' => -171,
			"if (" => -171,
			"my" => -171,
			'OP01_OPEN_CLOSE_PAREN' => -171,
			'OP19_LOOP_CONTROL' => -171,
			'OP10_NAMED_UNARY_STRINGIFY' => -171,
			'OP01_PRINT_VOID' => -171,
			'OP01_NAMED_VOID_PAREN' => -171,
			'OP03_MATH_INC_DEC' => -171,
			"undef" => -171,
			'OP01_PRINT_VOID_PAREN' => -171,
			'OP01_OPEN_CLOSE' => -171,
			'VARIABLE_SYMBOL' => -171,
			'WORD' => -171,
			"{" => -171,
			"%{" => -171,
			"foreach my" => -171,
			"(" => -171,
			'OP10_NAMED_UNARY' => -171,
			"elsif (" => 350,
			'OP01_NAMED' => -171,
			"else" => 349,
			"[" => -171,
			'OP05_MATH_NEG' => -171,
			'' => -171,
			"}" => -171,
			"\@{" => -171,
			"for my integer" => -171,
			'LITERAL_NUMBER' => -171,
			'OP01_NAMED_VOID' => -171
		},
		GOTOS => {
			'PAREN-49' => 351,
			'PAREN-51' => 347,
			'OPTIONAL-52' => 348
		}
	},
	{#State 320
		ACTIONS => {
			";" => 352
		}
	},
	{#State 321
		DEFAULT => -99
	},
	{#State 322
		DEFAULT => -192
	},
	{#State 323
		DEFAULT => -198
	},
	{#State 324
		DEFAULT => -195
	},
	{#State 325
		DEFAULT => -135
	},
	{#State 326
		DEFAULT => -178
	},
	{#State 327
		ACTIONS => {
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_QW' => 158,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			"my" => 122,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'KEYS_OR_VALUES' => 156,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'HashReference' => 90,
			'TypeInner' => 154,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ListElements' => 353,
			'ListElement' => 152,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Expression' => 155,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111
		}
	},
	{#State 328
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			".." => 354
		}
	},
	{#State 329
		DEFAULT => -187
	},
	{#State 330
		DEFAULT => -186
	},
	{#State 331
		DEFAULT => -185
	},
	{#State 332
		DEFAULT => -213
	},
	{#State 333
		ACTIONS => {
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP21_LIST_COMMA' => -209,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			"}" => -209,
			'OP08_MATH_ADD_SUB' => 137,
			'OP08_STRING_CAT' => 139,
			'OP06_REGEX_MATCH' => 138,
			'OP14_BITWISE_OR_XOR' => 131
		}
	},
	{#State 334
		DEFAULT => -142
	},
	{#State 335
		ACTIONS => {
			")" => 355
		}
	},
	{#State 336
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 356
		}
	},
	{#State 337
		DEFAULT => -70,
		GOTOS => {
			'STAR-29' => 357
		}
	},
	{#State 338
		ACTIONS => {
			'OP20_HASH_FATARROW' => 358
		}
	},
	{#State 339
		DEFAULT => -212
	},
	{#State 340
		ACTIONS => {
			"our" => 359,
			'LITERAL_NUMBER' => 360
		},
		GOTOS => {
			'Subroutine' => 363,
			'Method' => 362,
			'MethodOrSubroutine' => 361
		}
	},
	{#State 341
		ACTIONS => {
			'WORD' => 338,
			"%{" => 100
		},
		GOTOS => {
			'HashEntryTyped' => 364,
			'HashDereferenced' => 339
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
		DEFAULT => -224
	},
	{#State 345
		DEFAULT => -181
	},
	{#State 346
		DEFAULT => -179
	},
	{#State 347
		DEFAULT => -170
	},
	{#State 348
		DEFAULT => -172
	},
	{#State 349
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 368
		}
	},
	{#State 350
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'Literal' => 86,
			'Variable' => 124,
			'Operator' => 76,
			'WordScoped' => 111,
			'Expression' => 369,
			'ArrayDereferenced' => 93
		}
	},
	{#State 351
		DEFAULT => -167
	},
	{#State 352
		DEFAULT => -189
	},
	{#State 353
		ACTIONS => {
			")" => 370
		}
	},
	{#State 354
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 72,
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'LITERAL_STRING' => 70,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashDereferenced' => 89,
			'HashReference' => 90,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'Expression' => 371,
			'ArrayDereferenced' => 93
		}
	},
	{#State 355
		DEFAULT => -154
	},
	{#State 356
		DEFAULT => -72
	},
	{#State 357
		ACTIONS => {
			'OP21_LIST_COMMA' => 374,
			")" => 373
		},
		GOTOS => {
			'PAREN-28' => 372
		}
	},
	{#State 358
		ACTIONS => {
			"my" => 122
		},
		GOTOS => {
			'TypeInner' => 375
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 376
		},
		GOTOS => {
			'Type' => 58,
			'TypeMethod' => 377
		}
	},
	{#State 360
		ACTIONS => {
			";" => 378
		}
	},
	{#State 361
		DEFAULT => -65
	},
	{#State 362
		DEFAULT => -88
	},
	{#State 363
		DEFAULT => -89
	},
	{#State 364
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 379
		}
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
		DEFAULT => -169
	},
	{#State 369
		ACTIONS => {
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP17_LIST_RANGE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP15_LOGICAL_AND' => 133,
			")" => 382,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP14_BITWISE_OR_XOR' => 131
		}
	},
	{#State 370
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 371
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			")" => 384,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP09_BITWISE_SHIFT' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133
		}
	},
	{#State 372
		DEFAULT => -69
	},
	{#State 373
		ACTIONS => {
			";" => 385
		}
	},
	{#State 374
		ACTIONS => {
			'WORD' => 338,
			"%{" => 100
		},
		GOTOS => {
			'HashDereferenced' => 339,
			'HashEntryTyped' => 386
		}
	},
	{#State 375
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 101,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 27,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70,
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Operator' => 76,
			'WordScoped' => 111,
			'Variable' => 124,
			'Expression' => 387,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'ArrayReference' => 83
		}
	},
	{#State 376
		ACTIONS => {
			'VARIABLE_SYMBOL' => -222,
			"__method" => 388
		}
	},
	{#State 377
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 378
		DEFAULT => -67
	},
	{#State 379
		ACTIONS => {
			")" => 392,
			'OP21_LIST_COMMA' => 391
		},
		GOTOS => {
			'PAREN-30' => 390
		}
	},
	{#State 380
		ACTIONS => {
			"\@_;" => 393
		}
	},
	{#State 381
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 394
		}
	},
	{#State 382
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 395
		}
	},
	{#State 383
		DEFAULT => -177
	},
	{#State 384
		ACTIONS => {
			"{" => 275
		},
		GOTOS => {
			'CodeBlock' => 396
		}
	},
	{#State 385
		DEFAULT => -71
	},
	{#State 386
		DEFAULT => -68
	},
	{#State 387
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 131,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP21_LIST_COMMA' => -211,
			'OP11_COMPARE_LT_GT' => 130,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			")" => -211,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP18_TERNARY' => 135,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142
		}
	},
	{#State 388
		DEFAULT => -223
	},
	{#State 389
		ACTIONS => {
			"= sub {" => 397
		}
	},
	{#State 390
		DEFAULT => -74
	},
	{#State 391
		ACTIONS => {
			"%{" => 100,
			'WORD' => 338
		},
		GOTOS => {
			'HashEntryTyped' => 398,
			'HashDereferenced' => 339
		}
	},
	{#State 392
		ACTIONS => {
			";" => 399
		}
	},
	{#State 393
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 400
		}
	},
	{#State 394
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 395
		DEFAULT => -166
	},
	{#State 396
		DEFAULT => -176
	},
	{#State 397
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -78,
			"undef" => -78,
			'OP01_NAMED_VOID_PAREN' => -78,
			'OP01_PRINT_VOID' => -78,
			'OP01_PRINT_VOID_PAREN' => -78,
			'OP01_OPEN_CLOSE' => -78,
			'OP22_LOGICAL_NOT' => -78,
			'LITERAL_STRING' => -78,
			'WORD_SCOPED' => -78,
			"while (" => -78,
			'OP05_LOGICAL_NEG' => -78,
			"( my" => 402,
			'OP19_LOOP_CONTROL' => -78,
			'OP10_NAMED_UNARY_STRINGIFY' => -78,
			'OP01_OPEN_CLOSE_PAREN' => -78,
			"my" => -78,
			"if (" => -78,
			"\@{" => -78,
			"[" => -78,
			'OP05_MATH_NEG' => -78,
			'OP01_NAMED' => -78,
			'LITERAL_NUMBER' => -78,
			'OP01_NAMED_VOID' => -78,
			"for my integer" => -78,
			"(" => -78,
			"foreach my" => -78,
			"%{" => -78,
			"{" => -78,
			'WORD' => -78,
			'VARIABLE_SYMBOL' => -78,
			'OP10_NAMED_UNARY' => -78
		},
		GOTOS => {
			'MethodArguments' => 404,
			'OPTIONAL-32' => 403
		}
	},
	{#State 398
		DEFAULT => -73
	},
	{#State 399
		DEFAULT => -76
	},
	{#State 400
		ACTIONS => {
			'OP01_NAMED_VOID' => -52,
			'LITERAL_NUMBER' => -52,
			"for my integer" => -52,
			"\@{" => -52,
			"[" => -52,
			'OP05_MATH_NEG' => -52,
			'OP01_NAMED' => -52,
			'CHECK_OR_CHECKTRACE' => 406,
			'OP10_NAMED_UNARY' => -52,
			"(" => -52,
			"foreach my" => -52,
			"%{" => -52,
			"{" => -52,
			'VARIABLE_SYMBOL' => -52,
			'WORD' => -52,
			'OP01_OPEN_CLOSE' => -52,
			'OP01_PRINT_VOID_PAREN' => -52,
			"undef" => -52,
			'OP03_MATH_INC_DEC' => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			'OP01_PRINT_VOID' => -52,
			'OP10_NAMED_UNARY_STRINGIFY' => -52,
			'OP19_LOOP_CONTROL' => -52,
			'OP01_OPEN_CLOSE_PAREN' => -52,
			"my" => -52,
			"if (" => -52,
			'OP22_LOGICAL_NOT' => -52,
			'LITERAL_STRING' => -52,
			'WORD_SCOPED' => -52,
			'OP05_LOGICAL_NEG' => -52,
			"while (" => -52
		},
		GOTOS => {
			'ArgumentCheck' => 405
		}
	},
	{#State 401
		DEFAULT => -47
	},
	{#State 402
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 407
		}
	},
	{#State 403
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_NAMED_VOID' => 112,
			'LITERAL_NUMBER' => 113,
			"for my integer" => -160,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			"if (" => 79,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			"foreach my" => -160,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"{" => 101,
			"%{" => 100,
			'OP05_LOGICAL_NEG' => 72,
			'WORD' => 98,
			'VARIABLE_SYMBOL' => 99,
			"while (" => -160
		},
		GOTOS => {
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96,
			'LoopLabel' => 102,
			'Operator' => 76,
			'PAREN-47' => 77,
			'Operation' => 408,
			'Variable' => 104,
			'Expression' => 78,
			'ArrayReference' => 83,
			'OperatorVoid' => 85,
			'PLUS-33' => 409,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 111,
			'Conditional' => 114,
			'ArrayDereferenced' => 93,
			'Statement' => 115,
			'VariableModification' => 94
		}
	},
	{#State 404
		DEFAULT => -77
	},
	{#State 405
		DEFAULT => -50
	},
	{#State 406
		ACTIONS => {
			"(" => 410
		}
	},
	{#State 407
		DEFAULT => -84,
		GOTOS => {
			'STAR-35' => 411
		}
	},
	{#State 408
		DEFAULT => -80
	},
	{#State 409
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			"(" => 97,
			"foreach my" => -160,
			"%{" => 100,
			"{" => 101,
			'WORD' => 98,
			'VARIABLE_SYMBOL' => 99,
			'LITERAL_NUMBER' => 113,
			'OP01_NAMED_VOID' => 112,
			"for my integer" => -160,
			"}" => 413,
			"\@{" => 107,
			'OP05_MATH_NEG' => 109,
			"[" => 110,
			'OP01_NAMED' => 108,
			'OP19_LOOP_CONTROL' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"my" => 80,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			"if (" => 79,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 28,
			"while (" => -160,
			'OP05_LOGICAL_NEG' => 72,
			'OP01_PRINT_VOID_PAREN' => 92,
			'OP01_OPEN_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			'OP01_NAMED_VOID_PAREN' => 87,
			'OP01_PRINT_VOID' => 88
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'OperatorVoid' => 85,
			'ArrayReference' => 83,
			'VariableModification' => 94,
			'Statement' => 115,
			'ArrayDereferenced' => 93,
			'Conditional' => 114,
			'WordScoped' => 111,
			'VariableDeclaration' => 95,
			'OPTIONAL-48' => 96,
			'Expression' => 78,
			'Variable' => 104,
			'PAREN-47' => 77,
			'Operation' => 412,
			'LoopLabel' => 102,
			'Operator' => 76
		}
	},
	{#State 410
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 91,
			'LITERAL_NUMBER' => 113,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP01_NAMED' => 108,
			"\@{" => 107,
			"undef" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"%{" => 100,
			"{" => 101,
			'WORD_SCOPED' => 28,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 97,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'ArrayReference' => 83,
			'ArrayDereferenced' => 93,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'Expression' => 414
		}
	},
	{#State 411
		ACTIONS => {
			'OP21_LIST_COMMA' => 417,
			")" => 416
		},
		GOTOS => {
			'PAREN-34' => 415
		}
	},
	{#State 412
		DEFAULT => -79
	},
	{#State 413
		ACTIONS => {
			";" => 418
		}
	},
	{#State 414
		ACTIONS => {
			'OP15_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP18_TERNARY' => 135,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144,
			")" => -55,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => 421,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 131
		},
		GOTOS => {
			'OPTIONAL-22' => 419,
			'PAREN-21' => 420
		}
	},
	{#State 415
		DEFAULT => -83
	},
	{#State 416
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 422
		}
	},
	{#State 417
		ACTIONS => {
			"my" => 423
		}
	},
	{#State 418
		DEFAULT => -81
	},
	{#State 419
		ACTIONS => {
			")" => 424
		}
	},
	{#State 420
		DEFAULT => -54
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 99,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 72,
			'WORD_SCOPED' => 28,
			"%{" => 100,
			"{" => 101,
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Literal' => 86,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Expression' => 425,
			'WordScoped' => 111,
			'Operator' => 76,
			'Variable' => 124,
			'ArrayDereferenced' => 93
		}
	},
	{#State 422
		ACTIONS => {
			"\@_;" => 426
		}
	},
	{#State 423
		ACTIONS => {
			'WORD' => 59
		},
		GOTOS => {
			'Type' => 427
		}
	},
	{#State 424
		ACTIONS => {
			";" => 428
		}
	},
	{#State 425
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 132,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP18_TERNARY' => 135,
			'OP16_LOGICAL_OR' => 134,
			'OP09_BITWISE_SHIFT' => 136,
			'OP24_LOGICAL_OR_XOR' => 144,
			'OP23_LOGICAL_AND' => 143,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP21_LIST_COMMA' => 429,
			'OP13_BITWISE_AND' => 140,
			'OP04_MATH_POW' => 141,
			'OP14_BITWISE_OR_XOR' => 131
		}
	},
	{#State 426
		DEFAULT => -86,
		GOTOS => {
			'STAR-36' => 430
		}
	},
	{#State 427
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 428
		DEFAULT => -56
	},
	{#State 429
		ACTIONS => {
			'OP01_NAMED' => 108,
			"[" => 110,
			'OP05_MATH_NEG' => 109,
			'OP03_MATH_INC_DEC' => 84,
			"undef" => 82,
			"\@{" => 107,
			'LITERAL_NUMBER' => 113,
			'OP01_OPEN_CLOSE' => 91,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 99,
			'OP05_LOGICAL_NEG' => 72,
			"%{" => 100,
			'WORD_SCOPED' => 28,
			"{" => 101,
			'LITERAL_STRING' => 70,
			"(" => 97,
			'OP22_LOGICAL_NOT' => 71,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayReference' => 83,
			'HashReference' => 90,
			'HashDereferenced' => 89,
			'Literal' => 86,
			'Variable' => 124,
			'WordScoped' => 111,
			'Operator' => 76,
			'Expression' => 432,
			'ArrayDereferenced' => 93
		}
	},
	{#State 430
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -87,
			'LITERAL_STRING' => -87,
			'WORD_SCOPED' => -87,
			"while (" => -87,
			'OP05_LOGICAL_NEG' => -87,
			'OP19_LOOP_CONTROL' => -87,
			'OP10_NAMED_UNARY_STRINGIFY' => -87,
			"my" => -87,
			'OP01_OPEN_CLOSE_PAREN' => -87,
			"if (" => -87,
			'OP03_MATH_INC_DEC' => -87,
			"undef" => -87,
			'OP01_PRINT_VOID' => -87,
			'OP01_NAMED_VOID_PAREN' => -87,
			'OP01_PRINT_VOID_PAREN' => -87,
			'OP01_OPEN_CLOSE' => -87,
			"(" => -87,
			"foreach my" => -87,
			"%{" => -87,
			"{" => -87,
			'VARIABLE_SYMBOL' => -87,
			'WORD' => -87,
			'CHECK_OR_CHECKTRACE' => 406,
			'OP10_NAMED_UNARY' => -87,
			"\@{" => -87,
			"[" => -87,
			'OP05_MATH_NEG' => -87,
			'OP01_NAMED' => -87,
			'LITERAL_NUMBER' => -87,
			'OP01_NAMED_VOID' => -87,
			"for my integer" => -87
		},
		GOTOS => {
			'ArgumentCheck' => 433
		}
	},
	{#State 431
		DEFAULT => -82
	},
	{#State 432
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 129,
			'OP11_COMPARE_LT_GT' => 130,
			'OP04_MATH_POW' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP14_BITWISE_OR_XOR' => 131,
			'OP09_BITWISE_SHIFT' => 136,
			'OP16_LOGICAL_OR' => 134,
			'OP18_TERNARY' => 135,
			'OP17_LIST_RANGE' => 142,
			'OP15_LOGICAL_AND' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 132,
			")" => -53,
			'OP23_LOGICAL_AND' => 143,
			'OP24_LOGICAL_OR_XOR' => 144
		}
	},
	{#State 433
		DEFAULT => -85
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5946 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6216 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6295 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6309 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-21', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_56
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6373 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6429 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Class_67
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6454 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_71
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_72
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6497 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6504 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6511 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_76
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6522 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6536 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6550 lib/RPerl/Grammar.pm
	],
	[#Rule Method_81
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6561 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_87
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_88
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_89
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_90
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6665 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6704 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6869 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6880 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6902 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6913 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6946 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6968 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7143 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_155
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_157
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_165
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_172
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7448 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_175
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_176
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7470 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_177
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_178
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7492 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_181
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_184
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_187
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7586 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_189
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7608 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_191
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7619 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7626 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-57', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-57', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7654 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7665 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_198
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7687 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_201
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7723 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_204
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_206
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7756 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_210
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_212
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7828 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7835 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_216
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7846 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7857 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_218
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7868 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7879 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_220
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7890 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_221
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7901 lib/RPerl/Grammar.pm
	],
	[#Rule Type_222
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7912 lib/RPerl/Grammar.pm
	],
	[#Rule TypeMethod_223
		 'TypeMethod', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_224
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7934 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_225
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7945 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_226
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7956 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_227
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7967 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_228
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7978 lib/RPerl/Grammar.pm
	]
],
#line 7981 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         'OperatorVoid_139', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'Expression_148', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'Expression_154', 
         'Expression_155', 
         'ExpressionOrStdin_156', 
         'ExpressionOrStdin_157', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_161', 
         'Statement_162', 
         'Statement_163', 
         'Statement_164', 
         'Statement_165', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_172', 
         'Loop_173', 
         'Loop_174', 
         'Loop_175', 
         'LoopFor_176', 
         'LoopForEach_177', 
         'LoopWhile_178', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_181', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_184', 
         'VariableRetrieval_185', 
         'VariableRetrieval_186', 
         'VariableRetrieval_187', 
         'VariableDeclaration_188', 
         'VariableDeclaration_189', 
         'VariableModification_190', 
         'VariableModification_191', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_197', 
         'ListElements_198', 
         'ListElement_199', 
         'ListElement_200', 
         'ListElement_201', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_204', 
         'ArrayDereferenced_205', 
         'ArrayDereferenced_206', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_209', 
         'HashEntry_210', 
         'HashEntryTyped_211', 
         'HashEntryTyped_212', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_216', 
         'HashDereferenced_217', 
         'HashDereferenced_218', 
         'WordScoped_219', 
         'WordScoped_220', 
         'LoopLabel_221', 
         'Type_222', 
         'TypeMethod_223', 
         'TypeInner_224', 
         'FileHandle_225', 
         'FileHandle_226', 
         'Literal_227', 
         'Literal_228', );
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


#line 8258 lib/RPerl/Grammar.pm



1;
