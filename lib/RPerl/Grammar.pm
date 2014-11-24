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
    our $VERSION = 0.000_738;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\<STDIN\>|elsif\ \(|while\ \(|\$TYPED_|\=\ sub\ \{|package|undef|else|\(\ my|if\ \(|use|\@_\;|qw\(|our|1\;|\.\.|my|\%\{|\@\{|\{\*|\;|\)|\/|\(|\{|\}|\[|\])}gc and return ($1, $1);

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
  [ 'Package_32' => 'Package', [ 'STAR-10', 'STAR-11', 'STAR-12', 'PLUS-13', '1;', '1;' ], 0 ],
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
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'PLUS-28', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'PLUS-28', '1;', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-30', [ 'PAREN-29' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-30', [  ], 0 ],
  [ 'Class_72' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-23', 'STAR-24', 'STAR-25', 'Properties', 'OPTIONAL-26', 'STAR-27', '1;', '1;', 'OPTIONAL-30' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'PAREN-31' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'Properties_76' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-32', ')', ';' ], 0 ],
  [ 'Properties_77' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [ 'STAR-34', 'PAREN-33' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [  ], 0 ],
  [ 'PropertiesClass_81' => 'PropertiesClass', [ 'our %properties_class = (', 'Critic', 'HashEntryTyped', 'STAR-34', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-36', [ 'PLUS-36', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-36', [ 'Operation' ], 0 ],
  [ 'Method_86' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-35', 'PLUS-36', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ 'MethodArguments_92' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-38', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-39' ], 0 ],
  [ 'Operation_93' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_94' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-40', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_OPEN_CLOSE_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP01_OPEN_CLOSE', 'FileHandle', 'OPTIONAL-42', ';' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-43', ')', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_PRINT_VOID_PAREN', 'FileHandle', 'OPTIONAL-44', ')', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-45', ';' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandle', 'OPTIONAL-46', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_151' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-47', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-48', ')' ], 0 ],
  [ 'Expression_155' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_156' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_157' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'OPTIONAL-50', 'Loop' ], 0 ],
  [ 'Statement_163' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_164' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_165' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'PAREN-53' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'Conditional_172' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-52', 'OPTIONAL-54' ], 0 ],
  [ 'Loop_173' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_174' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_175' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_176' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_177' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_178' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'PLUS-55', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'Operation' ], 0 ],
  [ 'CodeBlock_181' => 'CodeBlock', [ '{', 'PLUS-55', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'Variable_184' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-56' ], 0 ],
  [ 'VariableRetrieval_185' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_186' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_187' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_188' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_189' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_190' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_191' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-59', [ 'PLUS-59', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-59', [ 'WORD' ], 0 ],
  [ 'ListElements_197' => 'ListElements', [ 'ListElement', 'STAR-58' ], 0 ],
  [ 'ListElements_198' => 'ListElements', [ 'OP01_QW', '(', 'PLUS-59', ')' ], 0 ],
  [ 'ListElement_199' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_200' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_201' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'ArrayReference_204' => 'ArrayReference', [ '[', 'OPTIONAL-60', ']' ], 0 ],
  [ 'ArrayDereferenced_205' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_206' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [  ], 0 ],
  [ 'HashEntry_209' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-61', 'Expression' ], 0 ],
  [ 'HashEntry_210' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_211' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_212' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-62', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [ 'STAR-63', 'PAREN-62' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [  ], 0 ],
  [ 'HashReference_216' => 'HashReference', [ '{', 'HashEntry', 'STAR-63', '}' ], 0 ],
  [ 'HashDereferenced_217' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_218' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_220' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_221' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_222' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_223' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_224' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_225' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Literal_226' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_227' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PLUS_LIST' => 67,
  '_PLUS_LIST' => 68,
  '_PAREN' => 69,
  '_OPTIONAL' => 70,
  '_OPTIONAL' => 71,
  'Class_72' => 72,
  '_PAREN' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'Properties_76' => 76,
  'Properties_77' => 77,
  '_PAREN' => 78,
  '_STAR_LIST' => 79,
  '_STAR_LIST' => 80,
  'PropertiesClass_81' => 81,
  '_OPTIONAL' => 82,
  '_OPTIONAL' => 83,
  '_PLUS_LIST' => 84,
  '_PLUS_LIST' => 85,
  'Method_86' => 86,
  '_PAREN' => 87,
  '_STAR_LIST' => 88,
  '_STAR_LIST' => 89,
  '_STAR_LIST' => 90,
  '_STAR_LIST' => 91,
  'MethodArguments_92' => 92,
  'Operation_93' => 93,
  'Operation_94' => 94,
  '_OPTIONAL' => 95,
  '_OPTIONAL' => 96,
  '_OPTIONAL' => 97,
  '_OPTIONAL' => 98,
  '_OPTIONAL' => 99,
  '_OPTIONAL' => 100,
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
  'Operator_124' => 124,
  'Operator_125' => 125,
  'Operator_126' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
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
  'FileHandle_221' => 221,
  'FileHandle_222' => 222,
  'TypeInner_223' => 223,
  'Type_224' => 224,
  'LoopLabel_225' => 225,
  'Literal_226' => 226,
  'Literal_227' => 227,
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
	'1;' => { ISSEMANTIC => 0 },
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
			"package" => -20,
			'SHEBANG' => 9,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-9' => 4,
			'ModuleHeader' => 3,
			'Program' => 6,
			'Critic' => 1,
			'PAREN-1' => 5,
			'PLUS-2' => 2,
			'CompileUnit' => 7
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-9' => 4,
			'ModuleHeader' => 3,
			'Critic' => 1,
			'PAREN-1' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use" => -25,
			"use constant" => -25,
			"our" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 15
		},
		GOTOS => {
			'STAR-10' => 12,
			'Module' => 13,
			'Package' => 11,
			'Class' => 14
		}
	},
	{#State 4
		ACTIONS => {
			"package" => 16
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			'' => 17
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 20
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -22
	},
	{#State 12
		ACTIONS => {
			"use" => -27,
			"use constant" => -27,
			"## no critic qw(" => 8,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 22,
			'Critic' => 23
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 16
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			")" => 28,
			'WORD' => 29
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 31
		}
	},
	{#State 22
		ACTIONS => {
			"use constant" => -29,
			"use" => 33,
			"our" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 32
		}
	},
	{#State 23
		DEFAULT => -24
	},
	{#State 24
		ACTIONS => {
			")" => 35
		}
	},
	{#State 25
		DEFAULT => -220
	},
	{#State 26
		DEFAULT => -219
	},
	{#State 27
		ACTIONS => {
			";" => 36
		}
	},
	{#State 28
		DEFAULT => -36
	},
	{#State 29
		DEFAULT => -34
	},
	{#State 30
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 31
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use constant" => 43,
			"our" => 39
		},
		GOTOS => {
			'PLUS-13' => 41,
			'Constant' => 42,
			'Subroutine' => 40
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			"[" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			"\@{" => -11,
			"foreach my" => -11,
			"(" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD_SCOPED' => -11,
			"our" => -11,
			"{" => -11,
			"if (" => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			'OP01_PRINT_VOID' => -11,
			'OP01_OPEN_CLOSE' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"while (" => -11,
			"undef" => -11,
			'OP22_LOGICAL_NOT' => -11,
			"## no critic qw(" => 8,
			'OP03_MATH_INC_DEC' => -11,
			"my" => -11,
			"for my integer" => -11,
			'OP01_NAMED' => -11,
			"use" => -11,
			"%{" => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			'OP05_MATH_NEG' => -11
		},
		GOTOS => {
			'STAR-5' => 49,
			'Critic' => 48
		}
	},
	{#State 39
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 50
		}
	},
	{#State 40
		DEFAULT => -31
	},
	{#State 41
		ACTIONS => {
			"our" => 39,
			"1;" => 52
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 42
		DEFAULT => -28
	},
	{#State 43
		ACTIONS => {
			'WORD' => 54
		}
	},
	{#State 44
		ACTIONS => {
			";" => 55,
			"qw(" => 56
		}
	},
	{#State 45
		ACTIONS => {
			"use" => 33
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 46
		DEFAULT => -21
	},
	{#State 47
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			'OP01_NAMED_VOID' => -13,
			"if (" => -13,
			"our" => -13,
			"{" => -13,
			'WORD_SCOPED' => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			"use constant" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			"[" => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"(" => -13,
			"foreach my" => -13,
			"\@{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"my" => -13,
			'OP22_LOGICAL_NOT' => -13,
			"%{" => -13,
			'OP01_NAMED' => -13,
			"use" => 33,
			"for my integer" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_STRING' => -13,
			'OP05_MATH_NEG' => -13,
			'WORD' => -13,
			'OP01_PRINT_VOID' => -13,
			'OP01_OPEN_CLOSE' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"while (" => -13
		},
		GOTOS => {
			'Include' => 60,
			'STAR-6' => 59
		}
	},
	{#State 50
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61
		}
	},
	{#State 51
		DEFAULT => -224
	},
	{#State 52
		ACTIONS => {
			"1;" => 62
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			'OP20_HASH_FATARROW' => 63
		}
	},
	{#State 55
		DEFAULT => -39
	},
	{#State 56
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 64
		}
	},
	{#State 57
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 66
		}
	},
	{#State 58
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 67
		}
	},
	{#State 59
		ACTIONS => {
			"{" => -15,
			"our" => -15,
			"if (" => -15,
			'WORD_SCOPED' => -15,
			"use constant" => 43,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"(" => -15,
			"foreach my" => -15,
			"\@{" => -15,
			"[" => -15,
			'OP10_NAMED_UNARY' => -15,
			'LITERAL_STRING' => -15,
			'OP05_MATH_NEG' => -15,
			'WORD' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"my" => -15,
			'OP22_LOGICAL_NOT' => -15,
			"%{" => -15,
			"for my integer" => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			"while (" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"undef" => -15,
			'OP01_PRINT_VOID' => -15,
			'OP01_OPEN_CLOSE' => -15,
			'VARIABLE_SYMBOL' => -15
		},
		GOTOS => {
			'Constant' => 68,
			'STAR-7' => 69
		}
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			"= sub {" => 70
		}
	},
	{#State 62
		DEFAULT => -32
	},
	{#State 63
		ACTIONS => {
			"my" => 72
		},
		GOTOS => {
			'TypeInner' => 71
		}
	},
	{#State 64
		ACTIONS => {
			")" => 73,
			'WORD' => 74
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			"use" => -60,
			"use constant" => -60,
			"our %properties = (" => -60,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'STAR-24' => 76,
			'Critic' => 75
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		ACTIONS => {
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 97,
			'OP05_MATH_NEG' => 98,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 95,
			'OP01_NAMED' => 89,
			"for my integer" => -160,
			"%{" => 91,
			'OP01_PRINT_VOID_PAREN' => 88,
			"undef" => 86,
			"while (" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			'OP01_PRINT_VOID' => 81,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'WORD_SCOPED' => 25,
			"if (" => 122,
			"{" => 121,
			"our" => 39,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_NAMED_VOID' => 114,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"foreach my" => -160,
			"\@{" => 107,
			"(" => 108,
			"[" => 103
		},
		GOTOS => {
			'WordScoped' => 92,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'Conditional' => 115,
			'PLUS-8' => 116,
			'Statement' => 96,
			'Variable' => 101,
			'HashReference' => 99,
			'OPTIONAL-50' => 120,
			'HashDereferenced' => 78,
			'VariableModification' => 77,
			'PAREN-49' => 104,
			'OperatorVoid' => 83,
			'Literal' => 82,
			'ArrayReference' => 105,
			'Subroutine' => 84,
			'LoopLabel' => 106,
			'Expression' => 87,
			'Operation' => 112,
			'ArrayDereferenced' => 111
		}
	},
	{#State 70
		ACTIONS => {
			"while (" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"undef" => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			'OP01_OPEN_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_PRINT_VOID' => -43,
			'WORD' => -43,
			'OP05_MATH_NEG' => -43,
			'LITERAL_STRING' => -43,
			'OP10_NAMED_UNARY' => -43,
			"for my integer" => -43,
			'OP01_NAMED' => -43,
			"%{" => -43,
			'OP22_LOGICAL_NOT' => -43,
			"my" => -43,
			'OP03_MATH_INC_DEC' => -43,
			"foreach my" => -43,
			"\@{" => -43,
			"(" => -43,
			'LITERAL_NUMBER' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"[" => -43,
			"( my" => 123,
			'OP01_NAMED_VOID_PAREN' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			'WORD_SCOPED' => -43,
			"{" => -43,
			"if (" => -43,
			'OP01_NAMED_VOID' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 124,
			'OPTIONAL-16' => 125
		}
	},
	{#State 71
		ACTIONS => {
			'LITERAL_STRING' => 100,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'Literal' => 126
		}
	},
	{#State 72
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 127
		}
	},
	{#State 73
		ACTIONS => {
			";" => 128
		}
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		DEFAULT => -57
	},
	{#State 76
		ACTIONS => {
			"use constant" => -62,
			"use" => 33,
			"our %properties = (" => -62
		},
		GOTOS => {
			'Include' => 130,
			'STAR-25' => 129
		}
	},
	{#State 77
		DEFAULT => -165
	},
	{#State 78
		DEFAULT => -150
	},
	{#State 79
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 133
		}
	},
	{#State 80
		DEFAULT => -183,
		GOTOS => {
			'STAR-56' => 134
		}
	},
	{#State 81
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 135
		}
	},
	{#State 82
		DEFAULT => -145
	},
	{#State 83
		DEFAULT => -163
	},
	{#State 84
		DEFAULT => -14
	},
	{#State 85
		ACTIONS => {
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'HashReference' => 99,
			'Expression' => 137,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92
		}
	},
	{#State 86
		DEFAULT => -144
	},
	{#State 87
		ACTIONS => {
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153,
			";" => 143,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => 138,
			'OP13_BITWISE_AND' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149
		}
	},
	{#State 88
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 155
		}
	},
	{#State 89
		ACTIONS => {
			"(" => 156
		}
	},
	{#State 90
		DEFAULT => -164
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			"{" => 157
		},
		GOTOS => {
			'HashReference' => 158,
			'Variable' => 159
		}
	},
	{#State 92
		ACTIONS => {
			"(" => 160
		}
	},
	{#State 93
		ACTIONS => {
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 161,
			'Variable' => 136,
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Variable' => 162
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 163
		}
	},
	{#State 96
		DEFAULT => -94
	},
	{#State 97
		ACTIONS => {
			"(" => -219,
			'COLON' => -225
		}
	},
	{#State 98
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 164,
			'Variable' => 136,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82
		}
	},
	{#State 99
		DEFAULT => -149
	},
	{#State 100
		DEFAULT => -226
	},
	{#State 101
		ACTIONS => {
			'OP08_STRING_CAT' => -146,
			'OP24_LOGICAL_OR_XOR' => -146,
			'OP04_MATH_POW' => -146,
			'OP19_VARIABLE_ASSIGN' => 165,
			'OP16_LOGICAL_OR' => -146,
			'OP18_TERNARY' => -146,
			'OP15_LOGICAL_AND' => -146,
			'OP19_VARIABLE_ASSIGN_BY' => 166,
			";" => -146,
			'OP08_MATH_ADD_SUB' => -146,
			'OP02_METHOD_THINARROW' => 167,
			'OP14_BITWISE_OR_XOR' => -146,
			'OP03_MATH_INC_DEC' => 168,
			'OP06_REGEX_MATCH' => -146,
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP23_LOGICAL_AND' => -146,
			'OP13_BITWISE_AND' => -146,
			'OP11_COMPARE_LT_GT' => -146,
			'OP09_BITWISE_SHIFT' => -146,
			'OP17_LIST_RANGE' => -146
		}
	},
	{#State 102
		ACTIONS => {
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 107,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119
		},
		GOTOS => {
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82,
			'ArrayDereferenced' => 111,
			'Expression' => 169,
			'HashReference' => 99,
			'Variable' => 136
		}
	},
	{#State 103
		ACTIONS => {
			"my" => 72,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP01_QW' => 174,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172,
			"]" => -203
		},
		GOTOS => {
			'ListElement' => 171,
			'Variable' => 136,
			'OPTIONAL-60' => 176,
			'HashReference' => 99,
			'Expression' => 173,
			'TypeInner' => 175,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'ListElements' => 170,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 104
		DEFAULT => -159
	},
	{#State 105
		DEFAULT => -147
	},
	{#State 106
		ACTIONS => {
			'COLON' => 177
		}
	},
	{#State 107
		ACTIONS => {
			"[" => 103,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'ArrayReference' => 178,
			'Variable' => 179
		}
	},
	{#State 108
		ACTIONS => {
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'Variable' => 136,
			'Expression' => 180,
			'HashReference' => 99,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113
		}
	},
	{#State 109
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Expression' => 181,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92
		}
	},
	{#State 110
		DEFAULT => -227
	},
	{#State 111
		DEFAULT => -148
	},
	{#State 112
		DEFAULT => -17
	},
	{#State 113
		DEFAULT => -152
	},
	{#State 114
		ACTIONS => {
			"my" => 72,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP01_QW' => 174,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			";" => -132,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172
		},
		GOTOS => {
			'ArrayReference' => 105,
			'ListElements' => 182,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'TypeInner' => 175,
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'OPTIONAL-45' => 183,
			'Expression' => 173,
			'HashReference' => 99,
			'ListElement' => 171
		}
	},
	{#State 115
		DEFAULT => -161
	},
	{#State 116
		ACTIONS => {
			"[" => 103,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 107,
			"foreach my" => -160,
			"(" => 108,
			'OP01_NAMED_VOID' => 114,
			'WORD_SCOPED' => 25,
			"{" => 121,
			"if (" => 122,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP01_PRINT_VOID' => 81,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP01_PRINT_VOID_PAREN' => 88,
			'' => -18,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"while (" => -160,
			"undef" => 86,
			'OP22_LOGICAL_NOT' => 93,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 97,
			'OP05_MATH_NEG' => 98
		},
		GOTOS => {
			'Statement' => 96,
			'OPTIONAL-50' => 120,
			'Variable' => 101,
			'HashReference' => 99,
			'WordScoped' => 92,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'Conditional' => 115,
			'LoopLabel' => 106,
			'Operation' => 184,
			'ArrayDereferenced' => 111,
			'Expression' => 87,
			'HashDereferenced' => 78,
			'VariableModification' => 77,
			'ArrayReference' => 105,
			'PAREN-49' => 104,
			'OperatorVoid' => 83,
			'Literal' => 82
		}
	},
	{#State 117
		ACTIONS => {
			"[" => 103,
			'OP01_QW' => 174,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP01_NAMED' => 89,
			"%{" => 91,
			")" => -128,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'TypeInner' => 175,
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 173,
			'ListElement' => 171,
			'OPTIONAL-43' => 186,
			'ArrayReference' => 105,
			'ListElements' => 185,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 188
		},
		GOTOS => {
			'LoopLabel' => 187
		}
	},
	{#State 119
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 189
		}
	},
	{#State 120
		ACTIONS => {
			"while (" => 191,
			"for my integer" => 190,
			"foreach my" => 193
		},
		GOTOS => {
			'LoopForEach' => 196,
			'LoopFor' => 195,
			'Loop' => 192,
			'LoopWhile' => 194
		}
	},
	{#State 121
		ACTIONS => {
			"}" => 197,
			'WORD' => 199,
			"%{" => 91
		},
		GOTOS => {
			'HashEntry' => 200,
			'HashDereferenced' => 198
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 107,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 89,
			"%{" => 91
		},
		GOTOS => {
			'HashReference' => 99,
			'Expression' => 201,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 124
		DEFAULT => -42
	},
	{#State 125
		ACTIONS => {
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP01_NAMED_VOID' => 114,
			'OP22_LOGICAL_NOT' => 93,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 97,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP19_LOOP_CONTROL' => 118,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			"if (" => 122,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP01_PRINT_VOID' => 81,
			"[" => 103,
			"\@{" => 107,
			"foreach my" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"while (" => -160,
			"(" => 108,
			"undef" => 86,
			'OP01_PRINT_VOID_PAREN' => 88,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'Conditional' => 115,
			'PLUS-17' => 204,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashReference' => 99,
			'Variable' => 101,
			'OPTIONAL-50' => 120,
			'Statement' => 96,
			'Literal' => 82,
			'OperatorVoid' => 83,
			'PAREN-49' => 104,
			'ArrayReference' => 105,
			'VariableModification' => 77,
			'HashDereferenced' => 78,
			'Expression' => 87,
			'ArrayDereferenced' => 111,
			'Operation' => 203,
			'LoopLabel' => 106
		}
	},
	{#State 126
		ACTIONS => {
			";" => 205
		}
	},
	{#State 127
		ACTIONS => {
			"\$TYPED_" => 206
		}
	},
	{#State 128
		DEFAULT => -40
	},
	{#State 129
		ACTIONS => {
			"our %properties = (" => 207,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 208,
			'Properties' => 209
		}
	},
	{#State 130
		DEFAULT => -59
	},
	{#State 131
		ACTIONS => {
			"filehandle_ref" => 210
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 211
		}
	},
	{#State 133
		ACTIONS => {
			'OP01_QW' => 174,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			";" => -100,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'ListElements' => 213,
			'Literal' => 82,
			'ArrayReference' => 105,
			'ListElement' => 171,
			'Variable' => 136,
			'Expression' => 173,
			'HashReference' => 99,
			'OPTIONAL-42' => 212,
			'TypeInner' => 175,
			'ArrayDereferenced' => 111
		}
	},
	{#State 134
		ACTIONS => {
			")" => -184,
			'OP02_METHOD_THINARROW' => -184,
			'OP08_MATH_ADD_SUB' => -184,
			'OP14_BITWISE_OR_XOR' => -184,
			'OP03_MATH_INC_DEC' => -184,
			'OP07_MATH_MULT_DIV_MOD' => -184,
			'OP12_COMPARE_EQ_NEQ' => -184,
			'OP23_LOGICAL_AND' => -184,
			'OP06_REGEX_MATCH' => -184,
			'OP21_LIST_COMMA' => -184,
			'COLON' => -184,
			'OP13_BITWISE_AND' => -184,
			"}" => -184,
			'OP17_LIST_RANGE' => -184,
			'OP11_COMPARE_LT_GT' => -184,
			'OP09_BITWISE_SHIFT' => -184,
			'OP08_STRING_CAT' => -184,
			'OP24_LOGICAL_OR_XOR' => -184,
			'OP02_HASH_THINARROW' => 215,
			".." => -184,
			'OP04_MATH_POW' => -184,
			'OP02_ARRAY_THINARROW' => 214,
			'OP19_VARIABLE_ASSIGN' => -184,
			'OP16_LOGICAL_OR' => -184,
			'OP18_TERNARY' => -184,
			"]" => -184,
			'OP15_LOGICAL_AND' => -184,
			";" => -184,
			'OP19_VARIABLE_ASSIGN_BY' => -184
		},
		GOTOS => {
			'VariableRetrieval' => 216
		}
	},
	{#State 135
		ACTIONS => {
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			'OP01_QW' => 174,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			";" => -134,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'ListElement' => 171,
			'TypeInner' => 175,
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'Expression' => 173,
			'HashReference' => 99,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'OPTIONAL-46' => 218,
			'ArrayReference' => 105,
			'ListElements' => 217,
			'Literal' => 82
		}
	},
	{#State 136
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP23_LOGICAL_AND' => -146,
			'OP06_REGEX_MATCH' => -146,
			'OP21_LIST_COMMA' => -146,
			'OP13_BITWISE_AND' => -146,
			"}" => -146,
			'OP17_LIST_RANGE' => -146,
			'OP11_COMPARE_LT_GT' => -146,
			'OP09_BITWISE_SHIFT' => -146,
			")" => -146,
			'OP02_METHOD_THINARROW' => 167,
			'OP08_MATH_ADD_SUB' => -146,
			'OP14_BITWISE_OR_XOR' => -146,
			'OP03_MATH_INC_DEC' => 168,
			'OP16_LOGICAL_OR' => -146,
			'OP18_TERNARY' => -146,
			"]" => -146,
			'OP15_LOGICAL_AND' => -146,
			";" => -146,
			'OP08_STRING_CAT' => -146,
			'OP24_LOGICAL_OR_XOR' => -146,
			".." => -146,
			'OP04_MATH_POW' => -146
		}
	},
	{#State 137
		ACTIONS => {
			'OP23_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP13_BITWISE_AND' => -115,
			"}" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -115,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP16_LOGICAL_OR' => -115,
			"]" => -115,
			'OP18_TERNARY' => -115,
			'OP15_LOGICAL_AND' => -115,
			";" => -115,
			'OP08_STRING_CAT' => 144,
			".." => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP04_MATH_POW' => 145
		}
	},
	{#State 138
		ACTIONS => {
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 219,
			'Variable' => 136,
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 139
		ACTIONS => {
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'Expression' => 220,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayDereferenced' => 111
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Expression' => 221,
			'HashReference' => 99,
			'Variable' => 136,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82
		}
	},
	{#State 141
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'Expression' => 222,
			'HashReference' => 99,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82
		}
	},
	{#State 142
		ACTIONS => {
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			"\@{" => 107,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Expression' => 223,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 143
		DEFAULT => -93
	},
	{#State 144
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			"\@{" => 107
		},
		GOTOS => {
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayDereferenced' => 111,
			'Expression' => 224,
			'HashReference' => 99,
			'Variable' => 136
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82,
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 225,
			'Variable' => 136
		}
	},
	{#State 146
		ACTIONS => {
			"/" => 226
		}
	},
	{#State 147
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashReference' => 99,
			'Expression' => 227,
			'Variable' => 136,
			'ArrayDereferenced' => 111
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'ArrayReference' => 105,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'Expression' => 228,
			'HashReference' => 99
		}
	},
	{#State 149
		ACTIONS => {
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26
		},
		GOTOS => {
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 229,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 150
		ACTIONS => {
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashReference' => 99,
			'Expression' => 230,
			'Variable' => 136,
			'ArrayDereferenced' => 111
		}
	},
	{#State 151
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Variable' => 231
		}
	},
	{#State 152
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'Expression' => 232,
			'HashReference' => 99,
			'ArrayReference' => 105,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78
		}
	},
	{#State 153
		ACTIONS => {
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103
		},
		GOTOS => {
			'Variable' => 136,
			'Expression' => 233,
			'HashReference' => 99,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 154
		ACTIONS => {
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 234,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82
		}
	},
	{#State 155
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP01_QW' => 174,
			"[" => 103,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			")" => -130,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP22_LOGICAL_NOT' => 93,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'HashDereferenced' => 78,
			'Operator' => 113,
			'OPTIONAL-44' => 236,
			'WordScoped' => 92,
			'Literal' => 82,
			'ListElements' => 235,
			'ArrayReference' => 105,
			'ListElement' => 171,
			'Expression' => 173,
			'HashReference' => 99,
			'Variable' => 136,
			'TypeInner' => 175,
			'ArrayDereferenced' => 111
		}
	},
	{#State 156
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP22_LOGICAL_NOT' => 93,
			")" => -96,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP01_QW' => 174,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172
		},
		GOTOS => {
			'TypeInner' => 175,
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'OPTIONAL-40' => 237,
			'HashReference' => 99,
			'Expression' => 173,
			'ListElement' => 171,
			'ArrayReference' => 105,
			'ListElements' => 238,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 91,
			'WORD' => 199
		},
		GOTOS => {
			'HashEntry' => 200,
			'HashDereferenced' => 198
		}
	},
	{#State 158
		ACTIONS => {
			"}" => 239
		}
	},
	{#State 159
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 160
		ACTIONS => {
			"my" => 72,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			")" => -141,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP01_QW' => 174,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172
		},
		GOTOS => {
			'OPTIONAL-47' => 242,
			'ListElement' => 171,
			'Expression' => 173,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'TypeInner' => 175,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'Literal' => 82,
			'ListElements' => 241,
			'ArrayReference' => 105
		}
	},
	{#State 161
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			".." => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP15_LOGICAL_AND' => 153,
			";" => -124,
			'OP16_LOGICAL_OR' => 152,
			"]" => -124,
			'OP18_TERNARY' => 151,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -124,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 150,
			"}" => -124,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 149,
			'OP23_LOGICAL_AND' => -124,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP21_LIST_COMMA' => -124
		}
	},
	{#State 162
		DEFAULT => -104
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 243
		}
	},
	{#State 164
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP15_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP08_MATH_ADD_SUB' => 142,
			")" => 244,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149,
			'OP23_LOGICAL_AND' => 138,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139
		}
	},
	{#State 165
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			"<STDIN>" => 246,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100
		},
		GOTOS => {
			'ArrayReference' => 105,
			'ExpressionOrStdin' => 245,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 247,
			'Variable' => 136
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103
		},
		GOTOS => {
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 248,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => 249
		}
	},
	{#State 168
		DEFAULT => -105
	},
	{#State 169
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -114,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -114,
			'OP13_BITWISE_AND' => -114,
			"}" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -114,
			";" => -114,
			'OP15_LOGICAL_AND' => -114,
			"]" => -114,
			'OP18_TERNARY' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP04_MATH_POW' => 145,
			".." => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP08_STRING_CAT' => 144
		}
	},
	{#State 170
		DEFAULT => -202
	},
	{#State 171
		DEFAULT => -194,
		GOTOS => {
			'STAR-58' => 250
		}
	},
	{#State 172
		ACTIONS => {
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 251
		}
	},
	{#State 173
		ACTIONS => {
			'OP21_LIST_COMMA' => -199,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 138,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 149,
			'OP13_BITWISE_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -199,
			"]" => -199,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			";" => -199,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145
		}
	},
	{#State 174
		ACTIONS => {
			"(" => 252
		}
	},
	{#State 175
		ACTIONS => {
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Expression' => 253,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 176
		ACTIONS => {
			"]" => 254
		}
	},
	{#State 177
		DEFAULT => -158
	},
	{#State 178
		ACTIONS => {
			"}" => 255
		}
	},
	{#State 179
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 180
		ACTIONS => {
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153,
			'OP08_MATH_ADD_SUB' => 142,
			")" => 257,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP13_BITWISE_AND' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149
		}
	},
	{#State 181
		ACTIONS => {
			'OP15_LOGICAL_AND' => -107,
			";" => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP18_TERNARY' => -107,
			"]" => -107,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			".." => -107,
			"}" => -107,
			'OP13_BITWISE_AND' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP06_REGEX_MATCH' => -107,
			'OP21_LIST_COMMA' => -107,
			")" => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP14_BITWISE_OR_XOR' => -107
		}
	},
	{#State 182
		DEFAULT => -131
	},
	{#State 183
		ACTIONS => {
			";" => 258
		}
	},
	{#State 184
		DEFAULT => -16
	},
	{#State 185
		DEFAULT => -127
	},
	{#State 186
		ACTIONS => {
			")" => 259
		}
	},
	{#State 187
		ACTIONS => {
			";" => 260
		}
	},
	{#State 188
		DEFAULT => -225
	},
	{#State 189
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP22_LOGICAL_NOT' => 93,
			")" => -98,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP01_QW' => 174,
			"[" => 103,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'KEYS_OR_VALUES' => 172
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'TypeInner' => 175,
			'Expression' => 173,
			'HashReference' => 99,
			'Variable' => 136,
			'ListElement' => 171,
			'ArrayReference' => 105,
			'Literal' => 82,
			'ListElements' => 262,
			'OPTIONAL-41' => 261,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 263
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			"\@{" => 107,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashReference' => 99,
			'Expression' => 264,
			'Variable' => 136,
			'ArrayDereferenced' => 111
		}
	},
	{#State 192
		DEFAULT => -162
	},
	{#State 193
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 265
		}
	},
	{#State 194
		DEFAULT => -175
	},
	{#State 195
		DEFAULT => -173
	},
	{#State 196
		DEFAULT => -174
	},
	{#State 197
		DEFAULT => -151
	},
	{#State 198
		DEFAULT => -210
	},
	{#State 199
		ACTIONS => {
			'OP20_HASH_FATARROW' => 266
		}
	},
	{#State 200
		DEFAULT => -215,
		GOTOS => {
			'STAR-63' => 267
		}
	},
	{#State 201
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 141,
			")" => 268,
			'OP08_MATH_ADD_SUB' => 142,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 150,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			'OP15_LOGICAL_AND' => 153
		}
	},
	{#State 202
		ACTIONS => {
			'VARIABLE_SYMBOL' => 269
		}
	},
	{#State 203
		DEFAULT => -45
	},
	{#State 204
		ACTIONS => {
			"{" => 121,
			"}" => 270,
			"if (" => 122,
			'WORD_SCOPED' => 25,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP01_NAMED_VOID' => 114,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"(" => 108,
			"\@{" => 107,
			"foreach my" => -160,
			"[" => 103,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'WORD' => 97,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			'OP01_PRINT_VOID_PAREN' => 88,
			"while (" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			'OP01_PRINT_VOID' => 81,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'LoopLabel' => 106,
			'Expression' => 87,
			'ArrayDereferenced' => 111,
			'Operation' => 271,
			'VariableModification' => 77,
			'HashDereferenced' => 78,
			'Literal' => 82,
			'OperatorVoid' => 83,
			'PAREN-49' => 104,
			'ArrayReference' => 105,
			'Statement' => 96,
			'HashReference' => 99,
			'Variable' => 101,
			'OPTIONAL-50' => 120,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'WordScoped' => 92,
			'Conditional' => 115
		}
	},
	{#State 205
		DEFAULT => -41
	},
	{#State 206
		ACTIONS => {
			'WORD' => 272
		}
	},
	{#State 207
		ACTIONS => {
			"## no critic qw(" => 8,
			")" => 273
		},
		GOTOS => {
			'Critic' => 274
		}
	},
	{#State 208
		DEFAULT => -61
	},
	{#State 209
		ACTIONS => {
			"1;" => -64,
			"our" => -64,
			"our %properties_class = (" => 277
		},
		GOTOS => {
			'PropertiesClass' => 275,
			'OPTIONAL-26' => 276
		}
	},
	{#State 210
		ACTIONS => {
			'VARIABLE_SYMBOL' => 278
		}
	},
	{#State 211
		ACTIONS => {
			"}" => 279
		}
	},
	{#State 212
		ACTIONS => {
			";" => 280
		}
	},
	{#State 213
		DEFAULT => -99
	},
	{#State 214
		ACTIONS => {
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 281,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 215
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 282,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'Expression' => 283,
			'HashReference' => 99,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92
		}
	},
	{#State 216
		DEFAULT => -182
	},
	{#State 217
		DEFAULT => -133
	},
	{#State 218
		ACTIONS => {
			";" => 284
		}
	},
	{#State 219
		ACTIONS => {
			")" => -125,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 150,
			"}" => -125,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP23_LOGICAL_AND' => -125,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => -125,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => -125,
			".." => -125,
			'OP15_LOGICAL_AND' => 153,
			";" => -125,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			"]" => -125
		}
	},
	{#State 220
		ACTIONS => {
			")" => -117,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP13_BITWISE_AND' => -117,
			"}" => -117,
			'OP17_LIST_RANGE' => -117,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP23_LOGICAL_AND' => -117,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => -117,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => -117,
			".." => -117,
			'OP15_LOGICAL_AND' => -117,
			";" => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP18_TERNARY' => -117,
			"]" => -117
		}
	},
	{#State 221
		ACTIONS => {
			"}" => -116,
			'OP13_BITWISE_AND' => -116,
			'OP11_COMPARE_LT_GT' => undef,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -116,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP15_LOGICAL_AND' => -116,
			";" => -116,
			'OP16_LOGICAL_OR' => -116,
			"]" => -116,
			'OP18_TERNARY' => -116,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			".." => -116,
			'OP24_LOGICAL_OR_XOR' => -116
		}
	},
	{#State 222
		ACTIONS => {
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP16_LOGICAL_OR' => -119,
			";" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			".." => -119,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -119,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => -119,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 150,
			"}" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			")" => -119,
			'OP08_MATH_ADD_SUB' => 142
		}
	},
	{#State 223
		ACTIONS => {
			"}" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => -111,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			")" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => -111,
			";" => -111,
			'OP16_LOGICAL_OR' => -111,
			"]" => -111,
			'OP18_TERNARY' => -111,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => -111,
			".." => -111,
			'OP24_LOGICAL_OR_XOR' => -111
		}
	},
	{#State 224
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 142,
			")" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			"}" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP08_STRING_CAT' => -112,
			".." => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => -112,
			"]" => -112,
			'OP18_TERNARY' => -112,
			'OP15_LOGICAL_AND' => -112,
			";" => -112
		}
	},
	{#State 225
		ACTIONS => {
			";" => -106,
			'OP15_LOGICAL_AND' => -106,
			"]" => -106,
			'OP18_TERNARY' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP04_MATH_POW' => 145,
			".." => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP13_BITWISE_AND' => -106,
			"}" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			")" => -106
		}
	},
	{#State 226
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 285
		}
	},
	{#State 227
		ACTIONS => {
			".." => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_STRING_CAT' => -110,
			'OP04_MATH_POW' => 145,
			"]" => -110,
			'OP18_TERNARY' => -110,
			'OP16_LOGICAL_OR' => -110,
			";" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			")" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP07_MATH_MULT_DIV_MOD' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP06_REGEX_MATCH' => 146,
			'OP11_COMPARE_LT_GT' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP17_LIST_RANGE' => -110,
			"}" => -110,
			'OP13_BITWISE_AND' => -110
		}
	},
	{#State 228
		ACTIONS => {
			'OP15_LOGICAL_AND' => -113,
			";" => -113,
			'OP16_LOGICAL_OR' => -113,
			"]" => -113,
			'OP18_TERNARY' => -113,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			".." => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"}" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => -113,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -113,
			'OP14_BITWISE_OR_XOR' => -113
		}
	},
	{#State 229
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -122,
			'OP21_LIST_COMMA' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => undef,
			"}" => -122,
			'OP13_BITWISE_AND' => 150,
			".." => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145,
			"]" => -122,
			'OP18_TERNARY' => -122,
			'OP16_LOGICAL_OR' => 152,
			";" => -122,
			'OP15_LOGICAL_AND' => 153
		}
	},
	{#State 230
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 142,
			")" => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP13_BITWISE_AND' => -118,
			"}" => -118,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => -118,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			".." => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			";" => -118,
			'OP16_LOGICAL_OR' => -118,
			"]" => -118,
			'OP18_TERNARY' => -118
		}
	},
	{#State 231
		ACTIONS => {
			'COLON' => 286
		}
	},
	{#State 232
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 142,
			")" => -121,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => -121,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => -121,
			"}" => -121,
			'OP13_BITWISE_AND' => 150,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => -121,
			'OP08_STRING_CAT' => 144,
			".." => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => -121,
			"]" => -121,
			'OP18_TERNARY' => -121,
			'OP15_LOGICAL_AND' => 153,
			";" => -121
		}
	},
	{#State 233
		ACTIONS => {
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => -120,
			".." => -120,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => -120,
			'OP18_TERNARY' => -120,
			"]" => -120,
			'OP15_LOGICAL_AND' => -120,
			";" => -120,
			")" => -120,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => -120,
			'OP21_LIST_COMMA' => -120,
			"}" => -120,
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => -120,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => -126,
			'OP23_LOGICAL_AND' => 138,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 150,
			"}" => -126,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => -126,
			'OP08_MATH_ADD_SUB' => 142,
			'OP18_TERNARY' => 151,
			"]" => -126,
			'OP16_LOGICAL_OR' => 152,
			";" => -126,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => -126,
			".." => -126,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145
		}
	},
	{#State 235
		DEFAULT => -129
	},
	{#State 236
		ACTIONS => {
			")" => 287
		}
	},
	{#State 237
		ACTIONS => {
			")" => 288
		}
	},
	{#State 238
		DEFAULT => -95
	},
	{#State 239
		DEFAULT => -218
	},
	{#State 240
		DEFAULT => -217
	},
	{#State 241
		DEFAULT => -140
	},
	{#State 242
		ACTIONS => {
			")" => 289
		}
	},
	{#State 243
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 290,
			";" => 291
		}
	},
	{#State 244
		DEFAULT => -108
	},
	{#State 245
		ACTIONS => {
			";" => 292
		}
	},
	{#State 246
		DEFAULT => -157
	},
	{#State 247
		ACTIONS => {
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 153,
			";" => -156,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154
		}
	},
	{#State 248
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP13_BITWISE_AND' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153,
			";" => 293
		}
	},
	{#State 249
		ACTIONS => {
			"(" => 294
		}
	},
	{#State 250
		ACTIONS => {
			";" => -197,
			")" => -197,
			'OP21_LIST_COMMA' => 295,
			"]" => -197
		},
		GOTOS => {
			'PAREN-57' => 296
		}
	},
	{#State 251
		DEFAULT => -201
	},
	{#State 252
		ACTIONS => {
			'WORD' => 298
		},
		GOTOS => {
			'PLUS-59' => 297
		}
	},
	{#State 253
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP04_MATH_POW' => 145,
			'OP18_TERNARY' => 151,
			"]" => -200,
			'OP16_LOGICAL_OR' => 152,
			";" => -200,
			'OP15_LOGICAL_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => -200,
			'OP08_MATH_ADD_SUB' => 142,
			'OP21_LIST_COMMA' => -200,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP17_LIST_RANGE' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP13_BITWISE_AND' => 150
		}
	},
	{#State 254
		DEFAULT => -204
	},
	{#State 255
		DEFAULT => -206
	},
	{#State 256
		DEFAULT => -205
	},
	{#State 257
		DEFAULT => -155
	},
	{#State 258
		DEFAULT => -137
	},
	{#State 259
		ACTIONS => {
			";" => 299
		}
	},
	{#State 260
		DEFAULT => -139
	},
	{#State 261
		ACTIONS => {
			")" => 300
		}
	},
	{#State 262
		DEFAULT => -97
	},
	{#State 263
		ACTIONS => {
			"(" => 301
		}
	},
	{#State 264
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 150,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 149,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 142,
			")" => 302,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 265
		ACTIONS => {
			'VARIABLE_SYMBOL' => 303
		}
	},
	{#State 266
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -208,
			'LITERAL_NUMBER' => -208,
			"(" => -208,
			"undef" => -208,
			'OP10_NAMED_UNARY_STRINGIFY' => -208,
			"\@{" => -208,
			"[" => -208,
			'VARIABLE_SYMBOL' => -208,
			'OP01_OPEN_CLOSE' => -208,
			"{" => -208,
			'OP10_NAMED_UNARY' => -208,
			'LITERAL_STRING' => -208,
			'WORD_SCOPED' => -208,
			'OP01_OPEN_CLOSE_PAREN' => -208,
			'OP05_MATH_NEG' => -208,
			'WORD' => -208,
			'OP03_MATH_INC_DEC' => -208,
			"my" => 72,
			'OP22_LOGICAL_NOT' => -208,
			"%{" => -208,
			'OP01_NAMED' => -208
		},
		GOTOS => {
			'OPTIONAL-61' => 304,
			'TypeInner' => 305
		}
	},
	{#State 267
		ACTIONS => {
			"}" => 306,
			'OP21_LIST_COMMA' => 307
		},
		GOTOS => {
			'PAREN-62' => 308
		}
	},
	{#State 268
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 309
		}
	},
	{#State 269
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 311
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
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 273
		ACTIONS => {
			";" => 314
		}
	},
	{#State 274
		ACTIONS => {
			'WORD' => 316,
			"%{" => 91
		},
		GOTOS => {
			'HashEntryTyped' => 315,
			'HashDereferenced' => 317
		}
	},
	{#State 275
		DEFAULT => -63
	},
	{#State 276
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 318
		}
	},
	{#State 277
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 319
		}
	},
	{#State 278
		DEFAULT => -222
	},
	{#State 279
		DEFAULT => -221
	},
	{#State 280
		DEFAULT => -103
	},
	{#State 281
		ACTIONS => {
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			"]" => 320,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154
		}
	},
	{#State 282
		ACTIONS => {
			"(" => -219,
			"}" => 321
		}
	},
	{#State 283
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 142,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			"}" => 322,
			'OP13_BITWISE_AND' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139
		}
	},
	{#State 284
		DEFAULT => -138
	},
	{#State 285
		ACTIONS => {
			"/" => 323
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Variable' => 324
		}
	},
	{#State 287
		ACTIONS => {
			";" => 325
		}
	},
	{#State 288
		DEFAULT => -101
	},
	{#State 289
		DEFAULT => -153
	},
	{#State 290
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"<STDIN>" => 246,
			"[" => 103
		},
		GOTOS => {
			'Variable' => 136,
			'Expression' => 247,
			'HashReference' => 99,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ExpressionOrStdin' => 326,
			'ArrayReference' => 105
		}
	},
	{#State 291
		DEFAULT => -188
	},
	{#State 292
		DEFAULT => -190
	},
	{#State 293
		DEFAULT => -191
	},
	{#State 294
		ACTIONS => {
			'KEYS_OR_VALUES' => 172,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			'OP01_QW' => 174,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'OP01_NAMED' => 89,
			"%{" => 91,
			")" => -143,
			'OP22_LOGICAL_NOT' => 93,
			"my" => 72,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'ListElements' => 328,
			'Literal' => 82,
			'ArrayReference' => 105,
			'OPTIONAL-48' => 327,
			'ListElement' => 171,
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 173,
			'ArrayDereferenced' => 111,
			'TypeInner' => 175
		}
	},
	{#State 295
		ACTIONS => {
			"my" => 72,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'KEYS_OR_VALUES' => 172,
			"\@{" => 107
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashReference' => 99,
			'Expression' => 173,
			'Variable' => 136,
			'ArrayDereferenced' => 111,
			'TypeInner' => 175,
			'ListElement' => 329
		}
	},
	{#State 296
		DEFAULT => -193
	},
	{#State 297
		ACTIONS => {
			'WORD' => 330,
			")" => 331
		}
	},
	{#State 298
		DEFAULT => -196
	},
	{#State 299
		DEFAULT => -135
	},
	{#State 300
		ACTIONS => {
			";" => 332
		}
	},
	{#State 301
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 89,
			"%{" => 91
		},
		GOTOS => {
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'Literal' => 82,
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 333,
			'Variable' => 136
		}
	},
	{#State 302
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 334
		}
	},
	{#State 303
		ACTIONS => {
			"(" => 335
		}
	},
	{#State 304
		ACTIONS => {
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93
		},
		GOTOS => {
			'ArrayReference' => 105,
			'Literal' => 82,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'ArrayDereferenced' => 111,
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 336
		}
	},
	{#State 305
		DEFAULT => -207
	},
	{#State 306
		DEFAULT => -216
	},
	{#State 307
		ACTIONS => {
			"%{" => 91,
			'WORD' => 199
		},
		GOTOS => {
			'HashEntry' => 337,
			'HashDereferenced' => 198
		}
	},
	{#State 308
		DEFAULT => -214
	},
	{#State 309
		DEFAULT => -168,
		GOTOS => {
			'STAR-52' => 338
		}
	},
	{#State 310
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 93,
			'OP01_NAMED_VOID' => 114,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			"if (" => 122,
			'OP01_NAMED_VOID_PAREN' => 117,
			'WORD' => 97,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'OP01_PRINT_VOID' => 81,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP01_PRINT_VOID_PAREN' => 88,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 107,
			"foreach my" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"while (" => -160,
			"undef" => 86,
			"(" => 108
		},
		GOTOS => {
			'Variable' => 101,
			'HashReference' => 99,
			'OPTIONAL-50' => 120,
			'Statement' => 96,
			'Conditional' => 115,
			'PLUS-55' => 340,
			'WordScoped' => 92,
			'Operator' => 113,
			'VariableDeclaration' => 90,
			'Expression' => 87,
			'Operation' => 339,
			'ArrayDereferenced' => 111,
			'LoopLabel' => 106,
			'OperatorVoid' => 83,
			'PAREN-49' => 104,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'VariableModification' => 77
		}
	},
	{#State 311
		ACTIONS => {
			")" => 343,
			'OP21_LIST_COMMA' => 341
		},
		GOTOS => {
			'PAREN-18' => 342
		}
	},
	{#State 312
		DEFAULT => -46
	},
	{#State 313
		DEFAULT => -223
	},
	{#State 314
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 344
		}
	},
	{#State 315
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 345
		}
	},
	{#State 316
		ACTIONS => {
			'OP20_HASH_FATARROW' => 346
		}
	},
	{#State 317
		DEFAULT => -212
	},
	{#State 318
		ACTIONS => {
			"our" => 349,
			"1;" => 348
		},
		GOTOS => {
			'Method' => 347
		}
	},
	{#State 319
		ACTIONS => {
			"%{" => 91,
			'WORD' => 316
		},
		GOTOS => {
			'HashEntryTyped' => 350,
			'HashDereferenced' => 317
		}
	},
	{#State 320
		DEFAULT => -185
	},
	{#State 321
		DEFAULT => -187
	},
	{#State 322
		DEFAULT => -186
	},
	{#State 323
		DEFAULT => -109
	},
	{#State 324
		DEFAULT => -123
	},
	{#State 325
		DEFAULT => -136
	},
	{#State 326
		ACTIONS => {
			";" => 351
		}
	},
	{#State 327
		ACTIONS => {
			")" => 352
		}
	},
	{#State 328
		DEFAULT => -142
	},
	{#State 329
		DEFAULT => -192
	},
	{#State 330
		DEFAULT => -195
	},
	{#State 331
		DEFAULT => -198
	},
	{#State 332
		DEFAULT => -102
	},
	{#State 333
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			".." => 353,
			'OP04_MATH_POW' => 145,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => 138,
			'OP06_REGEX_MATCH' => 146,
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 334
		DEFAULT => -178
	},
	{#State 335
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'KEYS_OR_VALUES' => 172,
			"\@{" => 107,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP01_QW' => 174,
			"[" => 103,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 72,
			'OP22_LOGICAL_NOT' => 93
		},
		GOTOS => {
			'ListElement' => 171,
			'ArrayDereferenced' => 111,
			'TypeInner' => 175,
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 173,
			'WordScoped' => 92,
			'Operator' => 113,
			'HashDereferenced' => 78,
			'ArrayReference' => 105,
			'ListElements' => 354,
			'Literal' => 82
		}
	},
	{#State 336
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 142,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149,
			'OP13_BITWISE_AND' => 150,
			"}" => -209,
			'OP21_LIST_COMMA' => -209,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139
		}
	},
	{#State 337
		DEFAULT => -213
	},
	{#State 338
		ACTIONS => {
			"else" => 357,
			"[" => -171,
			"(" => -171,
			"\@{" => -171,
			"foreach my" => -171,
			'LITERAL_NUMBER' => -171,
			'OP05_LOGICAL_NEG' => -171,
			'OP01_NAMED_VOID' => -171,
			'OP19_LOOP_CONTROL' => -171,
			'OP01_OPEN_CLOSE_PAREN' => -171,
			'OP01_NAMED_VOID_PAREN' => -171,
			"}" => -171,
			"{" => -171,
			"if (" => -171,
			'WORD_SCOPED' => -171,
			'OP01_OPEN_CLOSE' => -171,
			'VARIABLE_SYMBOL' => -171,
			"elsif (" => 356,
			'OP01_PRINT_VOID' => -171,
			'' => -171,
			'OP10_NAMED_UNARY_STRINGIFY' => -171,
			"while (" => -171,
			"undef" => -171,
			'OP01_PRINT_VOID_PAREN' => -171,
			"%{" => -171,
			"for my integer" => -171,
			'OP01_NAMED' => -171,
			"my" => -171,
			'OP03_MATH_INC_DEC' => -171,
			'OP22_LOGICAL_NOT' => -171,
			'OP05_MATH_NEG' => -171,
			'WORD' => -171,
			'OP10_NAMED_UNARY' => -171,
			'LITERAL_STRING' => -171
		},
		GOTOS => {
			'OPTIONAL-54' => 358,
			'PAREN-51' => 355,
			'PAREN-53' => 359
		}
	},
	{#State 339
		DEFAULT => -180
	},
	{#State 340
		ACTIONS => {
			'OP01_PRINT_VOID_PAREN' => 88,
			"while (" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			'OP01_PRINT_VOID' => 81,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'WORD' => 97,
			'OP03_MATH_INC_DEC' => 94,
			"my" => 95,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			"(" => 108,
			"\@{" => 107,
			"foreach my" => -160,
			"[" => 103,
			"}" => 360,
			"{" => 121,
			"if (" => 122,
			'WORD_SCOPED' => 25,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP01_NAMED_VOID' => 114
		},
		GOTOS => {
			'LoopLabel' => 106,
			'Expression' => 87,
			'ArrayDereferenced' => 111,
			'Operation' => 361,
			'VariableModification' => 77,
			'HashDereferenced' => 78,
			'Literal' => 82,
			'PAREN-49' => 104,
			'OperatorVoid' => 83,
			'ArrayReference' => 105,
			'Statement' => 96,
			'HashReference' => 99,
			'Variable' => 101,
			'OPTIONAL-50' => 120,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'WordScoped' => 92,
			'Conditional' => 115
		}
	},
	{#State 341
		ACTIONS => {
			"my" => 362
		}
	},
	{#State 342
		DEFAULT => -48
	},
	{#State 343
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 344
		DEFAULT => -77
	},
	{#State 345
		ACTIONS => {
			'OP21_LIST_COMMA' => 364,
			")" => 366
		},
		GOTOS => {
			'PAREN-31' => 365
		}
	},
	{#State 346
		ACTIONS => {
			"my" => 72
		},
		GOTOS => {
			'TypeInner' => 367
		}
	},
	{#State 347
		DEFAULT => -65
	},
	{#State 348
		ACTIONS => {
			"1;" => 368
		}
	},
	{#State 349
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 369
		}
	},
	{#State 350
		DEFAULT => -80,
		GOTOS => {
			'STAR-34' => 370
		}
	},
	{#State 351
		DEFAULT => -189
	},
	{#State 352
		DEFAULT => -154
	},
	{#State 353
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			'OP01_NAMED' => 89,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			"[" => 103,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			"\@{" => 107
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Variable' => 136,
			'Expression' => 371,
			'HashReference' => 99,
			'ArrayDereferenced' => 111
		}
	},
	{#State 354
		ACTIONS => {
			")" => 372
		}
	},
	{#State 355
		DEFAULT => -167
	},
	{#State 356
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'Variable' => 136,
			'HashReference' => 99,
			'Expression' => 373,
			'ArrayDereferenced' => 111,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Literal' => 82,
			'ArrayReference' => 105
		}
	},
	{#State 357
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 374
		}
	},
	{#State 358
		DEFAULT => -172
	},
	{#State 359
		DEFAULT => -170
	},
	{#State 360
		DEFAULT => -181
	},
	{#State 361
		DEFAULT => -179
	},
	{#State 362
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 376
		}
	},
	{#State 364
		ACTIONS => {
			'WORD' => 316,
			"%{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 317,
			'HashEntryTyped' => 377
		}
	},
	{#State 365
		DEFAULT => -74
	},
	{#State 366
		ACTIONS => {
			";" => 378
		}
	},
	{#State 367
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 107,
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103
		},
		GOTOS => {
			'Variable' => 136,
			'Expression' => 379,
			'HashReference' => 99,
			'ArrayDereferenced' => 111,
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113
		}
	},
	{#State 368
		ACTIONS => {
			"## no critic qw(" => -71,
			"our" => 39,
			'' => -71,
			"package" => -71
		},
		GOTOS => {
			'OPTIONAL-30' => 383,
			'PLUS-28' => 382,
			'PAREN-29' => 381,
			'Subroutine' => 380
		}
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 370
		ACTIONS => {
			")" => 385,
			'OP21_LIST_COMMA' => 387
		},
		GOTOS => {
			'PAREN-33' => 386
		}
	},
	{#State 371
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP15_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			'OP14_BITWISE_OR_XOR' => 141,
			")" => 388,
			'OP08_MATH_ADD_SUB' => 142,
			'OP17_LIST_RANGE' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP13_BITWISE_AND' => 150,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138
		}
	},
	{#State 372
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 373
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP23_LOGICAL_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			")" => 390,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 374
		DEFAULT => -169
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 376
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 392
		}
	},
	{#State 377
		DEFAULT => -73
	},
	{#State 378
		DEFAULT => -76
	},
	{#State 379
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP15_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			")" => -211,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP06_REGEX_MATCH' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP23_LOGICAL_AND' => 138,
			'OP21_LIST_COMMA' => -211
		}
	},
	{#State 380
		DEFAULT => -68
	},
	{#State 381
		DEFAULT => -70
	},
	{#State 382
		ACTIONS => {
			"our" => 39,
			"1;" => 393
		},
		GOTOS => {
			'Subroutine' => 394
		}
	},
	{#State 383
		DEFAULT => -72
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 385
		ACTIONS => {
			";" => 396
		}
	},
	{#State 386
		DEFAULT => -79
	},
	{#State 387
		ACTIONS => {
			"%{" => 91,
			'WORD' => 316
		},
		GOTOS => {
			'HashEntryTyped' => 397,
			'HashDereferenced' => 317
		}
	},
	{#State 388
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 398
		}
	},
	{#State 389
		DEFAULT => -177
	},
	{#State 390
		ACTIONS => {
			"{" => 310
		},
		GOTOS => {
			'CodeBlock' => 399
		}
	},
	{#State 391
		DEFAULT => -47
	},
	{#State 392
		ACTIONS => {
			'OP01_NAMED_VOID' => -52,
			'WORD_SCOPED' => -52,
			"if (" => -52,
			"{" => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			'OP01_OPEN_CLOSE_PAREN' => -52,
			'OP19_LOOP_CONTROL' => -52,
			"[" => -52,
			'LITERAL_NUMBER' => -52,
			'OP05_LOGICAL_NEG' => -52,
			"foreach my" => -52,
			"\@{" => -52,
			"(" => -52,
			'OP22_LOGICAL_NOT' => -52,
			'OP03_MATH_INC_DEC' => -52,
			"my" => -52,
			'OP01_NAMED' => -52,
			"for my integer" => -52,
			'CHECK_OR_CHECKTRACE' => 401,
			"%{" => -52,
			'LITERAL_STRING' => -52,
			'OP10_NAMED_UNARY' => -52,
			'WORD' => -52,
			'OP05_MATH_NEG' => -52,
			'OP01_PRINT_VOID' => -52,
			'OP01_OPEN_CLOSE' => -52,
			'VARIABLE_SYMBOL' => -52,
			'OP01_PRINT_VOID_PAREN' => -52,
			"undef" => -52,
			"while (" => -52,
			'OP10_NAMED_UNARY_STRINGIFY' => -52
		},
		GOTOS => {
			'ArgumentCheck' => 400
		}
	},
	{#State 393
		ACTIONS => {
			"1;" => 402
		}
	},
	{#State 394
		DEFAULT => -67
	},
	{#State 395
		ACTIONS => {
			"for my integer" => -83,
			'OP01_NAMED' => -83,
			"%{" => -83,
			'OP22_LOGICAL_NOT' => -83,
			"my" => -83,
			'OP03_MATH_INC_DEC' => -83,
			'WORD' => -83,
			'OP05_MATH_NEG' => -83,
			'LITERAL_STRING' => -83,
			'OP10_NAMED_UNARY' => -83,
			'VARIABLE_SYMBOL' => -83,
			'OP01_OPEN_CLOSE' => -83,
			'OP01_PRINT_VOID' => -83,
			'OP10_NAMED_UNARY_STRINGIFY' => -83,
			"while (" => -83,
			"undef" => -83,
			'OP01_PRINT_VOID_PAREN' => -83,
			'OP01_NAMED_VOID' => -83,
			'OP01_NAMED_VOID_PAREN' => -83,
			'OP19_LOOP_CONTROL' => -83,
			'OP01_OPEN_CLOSE_PAREN' => -83,
			'WORD_SCOPED' => -83,
			"{" => -83,
			"if (" => -83,
			"[" => -83,
			"( my" => 403,
			"foreach my" => -83,
			"\@{" => -83,
			"(" => -83,
			'LITERAL_NUMBER' => -83,
			'OP05_LOGICAL_NEG' => -83
		},
		GOTOS => {
			'OPTIONAL-35' => 405,
			'MethodArguments' => 404
		}
	},
	{#State 396
		DEFAULT => -81
	},
	{#State 397
		DEFAULT => -78
	},
	{#State 398
		DEFAULT => -176
	},
	{#State 399
		DEFAULT => -166
	},
	{#State 400
		DEFAULT => -50
	},
	{#State 401
		ACTIONS => {
			"(" => 406
		}
	},
	{#State 402
		DEFAULT => -69
	},
	{#State 403
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 407
		}
	},
	{#State 404
		DEFAULT => -82
	},
	{#State 405
		ACTIONS => {
			'WORD' => 97,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP19_LOOP_CONTROL' => 118,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			"if (" => 122,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP01_NAMED_VOID' => 114,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 107,
			"foreach my" => -160,
			"while (" => -160,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"undef" => 86,
			"(" => 108,
			'OP01_PRINT_VOID_PAREN' => 88,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			'OP01_PRINT_VOID' => 81
		},
		GOTOS => {
			'HashReference' => 99,
			'Variable' => 101,
			'OPTIONAL-50' => 120,
			'Statement' => 96,
			'Conditional' => 115,
			'VariableDeclaration' => 90,
			'Operator' => 113,
			'WordScoped' => 92,
			'PLUS-36' => 408,
			'Expression' => 87,
			'ArrayDereferenced' => 111,
			'Operation' => 409,
			'LoopLabel' => 106,
			'Literal' => 82,
			'PAREN-49' => 104,
			'OperatorVoid' => 83,
			'ArrayReference' => 105,
			'VariableModification' => 77,
			'HashDereferenced' => 78
		}
	},
	{#State 406
		ACTIONS => {
			"\@{" => 107,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"(" => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			"[" => 103,
			'WORD' => 26,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 100,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'OP01_NAMED' => 89,
			"%{" => 91,
			'OP22_LOGICAL_NOT' => 93,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Variable' => 136,
			'Expression' => 410,
			'HashReference' => 99,
			'ArrayDereferenced' => 111
		}
	},
	{#State 407
		DEFAULT => -89,
		GOTOS => {
			'STAR-38' => 411
		}
	},
	{#State 408
		ACTIONS => {
			"[" => 103,
			'LITERAL_NUMBER' => 110,
			'OP05_LOGICAL_NEG' => 109,
			"(" => 108,
			"\@{" => 107,
			"foreach my" => -160,
			'OP01_NAMED_VOID' => 114,
			"}" => 412,
			"{" => 121,
			"if (" => 122,
			'WORD_SCOPED' => 25,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP01_NAMED_VOID_PAREN' => 117,
			'OP01_PRINT_VOID' => 81,
			'OP01_OPEN_CLOSE' => 79,
			'VARIABLE_SYMBOL' => 80,
			'OP01_PRINT_VOID_PAREN' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"while (" => -160,
			"undef" => 86,
			"my" => 95,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			"%{" => 91,
			"for my integer" => -160,
			'OP01_NAMED' => 89,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'OP05_MATH_NEG' => 98,
			'WORD' => 97
		},
		GOTOS => {
			'Expression' => 87,
			'ArrayDereferenced' => 111,
			'Operation' => 413,
			'LoopLabel' => 106,
			'Literal' => 82,
			'PAREN-49' => 104,
			'OperatorVoid' => 83,
			'ArrayReference' => 105,
			'VariableModification' => 77,
			'HashDereferenced' => 78,
			'HashReference' => 99,
			'Variable' => 101,
			'OPTIONAL-50' => 120,
			'Statement' => 96,
			'Conditional' => 115,
			'Operator' => 113,
			'VariableDeclaration' => 90,
			'WordScoped' => 92
		}
	},
	{#State 409
		DEFAULT => -85
	},
	{#State 410
		ACTIONS => {
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153,
			'OP08_MATH_ADD_SUB' => 142,
			")" => -55,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP21_LIST_COMMA' => 416,
			'OP13_BITWISE_AND' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 149
		},
		GOTOS => {
			'PAREN-21' => 414,
			'OPTIONAL-22' => 415
		}
	},
	{#State 411
		ACTIONS => {
			")" => 417,
			'OP21_LIST_COMMA' => 419
		},
		GOTOS => {
			'PAREN-37' => 418
		}
	},
	{#State 412
		ACTIONS => {
			";" => 420
		}
	},
	{#State 413
		DEFAULT => -84
	},
	{#State 414
		DEFAULT => -54
	},
	{#State 415
		ACTIONS => {
			")" => 421
		}
	},
	{#State 416
		ACTIONS => {
			"undef" => 86,
			"(" => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'OP05_MATH_NEG' => 98,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 102,
			"{" => 121,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93
		},
		GOTOS => {
			'Literal' => 82,
			'ArrayReference' => 105,
			'HashDereferenced' => 78,
			'WordScoped' => 92,
			'Operator' => 113,
			'Variable' => 136,
			'Expression' => 422,
			'HashReference' => 99,
			'ArrayDereferenced' => 111
		}
	},
	{#State 417
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 418
		DEFAULT => -88
	},
	{#State 419
		ACTIONS => {
			"my" => 424
		}
	},
	{#State 420
		DEFAULT => -86
	},
	{#State 421
		ACTIONS => {
			";" => 425
		}
	},
	{#State 422
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 151,
			'OP16_LOGICAL_OR' => 152,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP08_STRING_CAT' => 144,
			'OP17_LIST_RANGE' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP13_BITWISE_AND' => 150,
			'OP21_LIST_COMMA' => 426,
			'OP23_LOGICAL_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 142
		}
	},
	{#State 423
		ACTIONS => {
			"\@_;" => 427
		}
	},
	{#State 424
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 428
		}
	},
	{#State 425
		DEFAULT => -56
	},
	{#State 426
		ACTIONS => {
			"%{" => 91,
			'OP01_NAMED' => 89,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NOT' => 93,
			'OP05_MATH_NEG' => 98,
			'OP01_OPEN_CLOSE_PAREN' => 119,
			'WORD' => 26,
			"{" => 121,
			'OP10_NAMED_UNARY' => 102,
			'LITERAL_STRING' => 100,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 80,
			'OP01_OPEN_CLOSE' => 79,
			"[" => 103,
			"(" => 108,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 85,
			"\@{" => 107,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 110
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'HashReference' => 99,
			'Expression' => 429,
			'Variable' => 136,
			'ArrayReference' => 105,
			'Literal' => 82,
			'Operator' => 113,
			'WordScoped' => 92,
			'HashDereferenced' => 78
		}
	},
	{#State 427
		DEFAULT => -91,
		GOTOS => {
			'STAR-39' => 430
		}
	},
	{#State 428
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 429
		ACTIONS => {
			")" => -53,
			'OP08_MATH_ADD_SUB' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => 138,
			'OP06_REGEX_MATCH' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP13_BITWISE_AND' => 150,
			'OP17_LIST_RANGE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 140,
			'OP08_STRING_CAT' => 144,
			'OP24_LOGICAL_OR_XOR' => 154,
			'OP04_MATH_POW' => 145,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 151,
			'OP15_LOGICAL_AND' => 153
		}
	},
	{#State 430
		ACTIONS => {
			"my" => -92,
			'OP03_MATH_INC_DEC' => -92,
			'OP22_LOGICAL_NOT' => -92,
			"%{" => -92,
			'OP01_NAMED' => -92,
			'CHECK_OR_CHECKTRACE' => 401,
			"for my integer" => -92,
			'OP10_NAMED_UNARY' => -92,
			'LITERAL_STRING' => -92,
			'OP05_MATH_NEG' => -92,
			'WORD' => -92,
			'OP01_PRINT_VOID' => -92,
			'VARIABLE_SYMBOL' => -92,
			'OP01_OPEN_CLOSE' => -92,
			'OP01_PRINT_VOID_PAREN' => -92,
			"undef" => -92,
			'OP10_NAMED_UNARY_STRINGIFY' => -92,
			"while (" => -92,
			'OP01_NAMED_VOID' => -92,
			"if (" => -92,
			"{" => -92,
			'WORD_SCOPED' => -92,
			'OP01_OPEN_CLOSE_PAREN' => -92,
			'OP19_LOOP_CONTROL' => -92,
			'OP01_NAMED_VOID_PAREN' => -92,
			"[" => -92,
			'OP05_LOGICAL_NEG' => -92,
			'LITERAL_NUMBER' => -92,
			"(" => -92,
			"foreach my" => -92,
			"\@{" => -92
		},
		GOTOS => {
			'ArgumentCheck' => 432
		}
	},
	{#State 431
		DEFAULT => -87
	},
	{#State 432
		DEFAULT => -90
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5878 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5885 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5892 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5899 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5956 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5963 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5970 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5984 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5991 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6005 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6063 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6070 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6084 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6091 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6105 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6213 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6234 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6241 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6252 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6266 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6273 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6280 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6287 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6298 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-21', 4,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6305 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6319 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_56
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6330 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6337 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6351 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6372 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6393 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 3,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Class_72
		 'Class', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_76
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_77
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6489 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_81
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Method_86
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6574 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6581 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_93
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_94
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6736 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6835 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6923 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6956 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7023 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7095 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_155
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_157
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_165
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7325 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7353 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7367 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_172
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7378 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_175
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_176
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_177
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_178
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_181
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_184
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_187
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_189
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_191
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_198
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_201
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_204
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7686 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7697 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_206
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7708 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7715 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_210
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_212
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7773 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7780 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7787 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_216
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_218
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_220
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_222
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_223
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule Type_224
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_225
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_227
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	]
],
#line 7922 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Class_72', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_76', 
         'Properties_77', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'PropertiesClass_81', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_86', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_92', 
         'Operation_93', 
         'Operation_94', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Operator_124', 
         'Operator_125', 
         'Operator_126', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'FileHandle_221', 
         'FileHandle_222', 
         'TypeInner_223', 
         'Type_224', 
         'LoopLabel_225', 
         'Literal_226', 
         'Literal_227', );
  $self;
}

#line 185 "lib/RPerl/Grammar.eyp"


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


#line 8198 lib/RPerl/Grammar.pm



1;
