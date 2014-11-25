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
    our $VERSION = 0.000_740;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\<STDIN\>|while\ \(|elsif\ \(|\=\ sub\ \{|\$TYPED_|package|undef|else|\(\ my|if\ \(|\@_\;|qw\(|use|our|\%\{|1\;|\{\*|\@\{|\.\.|my|\/|\}|\{|\(|\]|\)|\;|\[)}gc and return ($1, $1);

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
			'SHEBANG' => 5,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'PAREN-1' => 7,
			'ModuleHeader' => 2,
			'Critic' => 8,
			'Program' => 3,
			'PLUS-2' => 1,
			'CompileUnit' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 9,
			'' => -5
		},
		GOTOS => {
			'Critic' => 8,
			'PAREN-1' => 10,
			'ModuleHeader' => 2,
			'OPTIONAL-9' => 6
		}
	},
	{#State 2
		ACTIONS => {
			"use parent qw(" => 12,
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Class' => 14,
			'STAR-10' => 15,
			'Package' => 13,
			'Module' => 11
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'' => 16
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 9,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 18,
			'OPTIONAL-3' => 17
		}
	},
	{#State 6
		ACTIONS => {
			"package" => 19
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		DEFAULT => -19
	},
	{#State 9
		ACTIONS => {
			'WORD' => 21
		},
		GOTOS => {
			'PLUS-14' => 20
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -1
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
		DEFAULT => -22
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 9,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 25
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 18
		DEFAULT => -6
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 21
		DEFAULT => -35
	},
	{#State 22
		DEFAULT => -220
	},
	{#State 23
		ACTIONS => {
			")" => 32
		}
	},
	{#State 24
		DEFAULT => -219
	},
	{#State 25
		ACTIONS => {
			"use" => 34,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 33,
			'Include' => 35
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			"use warnings;" => 36
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
			";" => 38
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
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => 42,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 40,
			'Constant' => 41,
			'PLUS-13' => 44
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			"use RPerl;" => 46
		}
	},
	{#State 37
		ACTIONS => {
			'OP01_OPEN_CLOSE' => -11,
			'OP01_PRINT_VOID' => -11,
			'OP01_NAMED' => -11,
			'LITERAL_NUMBER' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'VARIABLE_SYMBOL' => -11,
			"[" => -11,
			"use constant" => -11,
			"undef" => -11,
			'WORD_SCOPED' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"(" => -11,
			'OP05_MATH_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			"my" => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			"foreach my" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"{" => -11,
			"for my integer" => -11,
			"our" => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"use" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"%{" => -11,
			'LITERAL_STRING' => -11,
			'WORD' => -11,
			'OP01_OPEN_CLOSE_PAREN' => -11,
			"while (" => -11,
			'OP10_NAMED_UNARY' => -11,
			"if (" => -11,
			"\@{" => -11,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 47,
			'STAR-5' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		DEFAULT => -31
	},
	{#State 41
		DEFAULT => -28
	},
	{#State 42
		ACTIONS => {
			'WORD' => 51
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 43,
			"1;" => 55
		},
		GOTOS => {
			'Subroutine' => 54
		}
	},
	{#State 45
		ACTIONS => {
			";" => 56,
			"qw(" => 57
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
			'LITERAL_STRING' => -13,
			"%{" => -13,
			'WORD' => -13,
			"\@{" => -13,
			"while (" => -13,
			'OP10_NAMED_UNARY' => -13,
			"if (" => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use" => 34,
			"our" => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			"{" => -13,
			"for my integer" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"my" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG' => -13,
			"(" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			"foreach my" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_OPEN_CLOSE' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT_VOID' => -13,
			'WORD_SCOPED' => -13,
			"use constant" => -13,
			"undef" => -13,
			"[" => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 59
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 62
		}
	},
	{#State 52
		DEFAULT => -224
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 54
		DEFAULT => -30
	},
	{#State 55
		ACTIONS => {
			"1;" => 64
		}
	},
	{#State 56
		DEFAULT => -39
	},
	{#State 57
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
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
			"\@{" => -15,
			"if (" => -15,
			'OP10_NAMED_UNARY' => -15,
			"while (" => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			'WORD' => -15,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"our" => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			"{" => -15,
			"for my integer" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			"foreach my" => -15,
			"my" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"(" => -15,
			'WORD_SCOPED' => -15,
			"undef" => -15,
			"use constant" => 42,
			"[" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT_VOID' => -15,
			'OP01_OPEN_CLOSE' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 68
		}
	},
	{#State 61
		ACTIONS => {
			"use" => -60,
			"use constant" => -60,
			"our %properties = (" => -60,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 70,
			'STAR-24' => 71
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
			")" => 75,
			'WORD' => 76
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP01_PRINT_VOID' => 102,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP01_NAMED_VOID' => 111,
			"my" => 116,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"for my integer" => -160,
			"{" => 78,
			'OP01_NAMED_VOID_PAREN' => 77,
			"our" => 43,
			'OP19_LOOP_CONTROL' => 80,
			'OP03_MATH_INC_DEC' => 85,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 90,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"while (" => -160,
			"if (" => 93,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 99
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 81,
			'Operation' => 79,
			'Subroutine' => 108,
			'PLUS-8' => 82,
			'HashDereferenced' => 86,
			'OperatorVoid' => 84,
			'LoopLabel' => 83,
			'VariableDeclaration' => 113,
			'HashReference' => 89,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Statement' => 117,
			'PAREN-49' => 96,
			'ArrayReference' => 118,
			'Conditional' => 122,
			'OPTIONAL-50' => 121,
			'VariableModification' => 98,
			'Expression' => 97
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		DEFAULT => -57
	},
	{#State 71
		ACTIONS => {
			"our %properties = (" => -62,
			"use constant" => -62,
			"use" => 34
		},
		GOTOS => {
			'STAR-25' => 123,
			'Include' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'LITERAL_STRING' => 91,
			'LITERAL_NUMBER' => 100
		},
		GOTOS => {
			'Literal' => 125
		}
	},
	{#State 73
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 126
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => -43,
			"%{" => -43,
			'LITERAL_STRING' => -43,
			'OP10_NAMED_UNARY' => -43,
			"if (" => -43,
			"while (" => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			"\@{" => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			"for my integer" => -43,
			"( my" => 129,
			"{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_MATH_NEG' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"(" => -43,
			"my" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"foreach my" => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_PRINT_VOID' => -43,
			'OP01_NAMED' => -43,
			'OP01_OPEN_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP22_LOGICAL_NOT' => -43,
			"[" => -43,
			'WORD_SCOPED' => -43,
			"undef" => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 127,
			'SubroutineArguments' => 128
		}
	},
	{#State 75
		ACTIONS => {
			";" => 130
		}
	},
	{#State 76
		DEFAULT => -37
	},
	{#State 77
		ACTIONS => {
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			")" => -128,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'KEYS_OR_VALUES' => 135,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"my" => 73,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP01_QW' => 133,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103
		},
		GOTOS => {
			'OPTIONAL-43' => 138,
			'ArrayReference' => 118,
			'ListElement' => 136,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'Expression' => 132,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'Operator' => 106,
			'Variable' => 134,
			'ListElements' => 137
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 142,
			"}" => 141,
			"%{" => 92
		},
		GOTOS => {
			'HashEntry' => 139,
			'HashDereferenced' => 140
		}
	},
	{#State 79
		DEFAULT => -17
	},
	{#State 80
		ACTIONS => {
			'WORD' => 143
		},
		GOTOS => {
			'LoopLabel' => 144
		}
	},
	{#State 81
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -146,
			'OP08_STRING_CAT' => -146,
			'OP18_TERNARY' => -146,
			'OP19_VARIABLE_ASSIGN_BY' => 148,
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP13_BITWISE_AND' => -146,
			'OP24_LOGICAL_OR_XOR' => -146,
			'OP17_LIST_RANGE' => -146,
			'OP04_MATH_POW' => -146,
			'OP08_MATH_ADD_SUB' => -146,
			'OP14_BITWISE_OR_XOR' => -146,
			";" => -146,
			'OP19_VARIABLE_ASSIGN' => 146,
			'OP16_LOGICAL_OR' => -146,
			'OP06_REGEX_MATCH' => -146,
			'OP03_MATH_INC_DEC' => 147,
			'OP11_COMPARE_LT_GT' => -146,
			'OP15_LOGICAL_AND' => -146,
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP02_METHOD_THINARROW' => 145,
			'OP23_LOGICAL_AND' => -146
		}
	},
	{#State 82
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED' => 101,
			'' => -18,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107,
			"my" => 116,
			'OP01_NAMED_VOID' => 111,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_PRINT_VOID_PAREN' => 120,
			"foreach my" => -160,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_NAMED_VOID_PAREN' => 77,
			"for my integer" => -160,
			"{" => 78,
			'OP03_MATH_INC_DEC' => 85,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 90,
			"\@{" => 99,
			"while (" => -160,
			"if (" => 93,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95
		},
		GOTOS => {
			'LoopLabel' => 83,
			'OperatorVoid' => 84,
			'HashDereferenced' => 86,
			'Operation' => 149,
			'Operator' => 106,
			'Variable' => 81,
			'ArrayReference' => 118,
			'PAREN-49' => 96,
			'Expression' => 97,
			'VariableModification' => 98,
			'Conditional' => 122,
			'OPTIONAL-50' => 121,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'VariableDeclaration' => 113,
			'Statement' => 117
		}
	},
	{#State 83
		ACTIONS => {
			'COLON' => 150
		}
	},
	{#State 84
		DEFAULT => -163
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 151
		}
	},
	{#State 86
		DEFAULT => -150
	},
	{#State 87
		DEFAULT => -148
	},
	{#State 88
		DEFAULT => -145
	},
	{#State 89
		DEFAULT => -149
	},
	{#State 90
		ACTIONS => {
			'COLON' => -225,
			"(" => -219
		}
	},
	{#State 91
		DEFAULT => -226
	},
	{#State 92
		ACTIONS => {
			"{" => 153,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 154,
			'HashReference' => 152
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Expression' => 155,
			'HashDereferenced' => 86,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'Operator' => 106,
			'Variable' => 134
		}
	},
	{#State 94
		ACTIONS => {
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109
		},
		GOTOS => {
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 156
		}
	},
	{#State 95
		ACTIONS => {
			"my" => 159,
			"{*" => 158
		},
		GOTOS => {
			'FileHandle' => 157
		}
	},
	{#State 96
		DEFAULT => -159
	},
	{#State 97
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			";" => 170,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 161,
			'OP23_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 175
		}
	},
	{#State 98
		DEFAULT => -165
	},
	{#State 99
		ACTIONS => {
			"[" => 107,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'ArrayReference' => 177,
			'Variable' => 178
		}
	},
	{#State 100
		DEFAULT => -227
	},
	{#State 101
		ACTIONS => {
			"(" => 179
		}
	},
	{#State 102
		ACTIONS => {
			"{*" => 158,
			"my" => 159
		},
		GOTOS => {
			'FileHandle' => 180
		}
	},
	{#State 103
		ACTIONS => {
			"my" => 159,
			"{*" => 158
		},
		GOTOS => {
			'FileHandle' => 181
		}
	},
	{#State 104
		ACTIONS => {
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'LITERAL_NUMBER' => 100
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89,
			'Expression' => 182,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 105
		DEFAULT => -183,
		GOTOS => {
			'STAR-56' => 183
		}
	},
	{#State 106
		DEFAULT => -152
	},
	{#State 107
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107,
			"my" => 73,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP01_QW' => 133,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"\@{" => 99,
			"]" => -203,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95
		},
		GOTOS => {
			'Variable' => 134,
			'OPTIONAL-60' => 184,
			'Operator' => 106,
			'ListElements' => 185,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'Expression' => 132,
			'ArrayReference' => 118,
			'ListElement' => 136
		}
	},
	{#State 108
		DEFAULT => -14
	},
	{#State 109
		DEFAULT => -144
	},
	{#State 110
		ACTIONS => {
			"(" => 186
		}
	},
	{#State 111
		ACTIONS => {
			"[" => 107,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP01_QW' => 133,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			";" => -132,
			"my" => 73
		},
		GOTOS => {
			'HashDereferenced' => 86,
			'TypeInner' => 131,
			'Expression' => 132,
			'OPTIONAL-45' => 187,
			'ArrayReference' => 118,
			'ListElement' => 136,
			'Variable' => 134,
			'Operator' => 106,
			'ListElements' => 188,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89
		}
	},
	{#State 112
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114
		},
		GOTOS => {
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 189,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134
		}
	},
	{#State 113
		DEFAULT => -164
	},
	{#State 114
		ACTIONS => {
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100
		},
		GOTOS => {
			'HashReference' => 89,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'Expression' => 190,
			'HashDereferenced' => 86
		}
	},
	{#State 115
		ACTIONS => {
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107
		},
		GOTOS => {
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 191,
			'HashReference' => 89,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 117
		DEFAULT => -94
	},
	{#State 118
		DEFAULT => -147
	},
	{#State 119
		ACTIONS => {
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'Expression' => 193,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 120
		ACTIONS => {
			"my" => 159,
			"{*" => 158
		},
		GOTOS => {
			'FileHandle' => 194
		}
	},
	{#State 121
		ACTIONS => {
			"while (" => 201,
			"for my integer" => 200,
			"foreach my" => 197
		},
		GOTOS => {
			'LoopWhile' => 196,
			'LoopForEach' => 199,
			'LoopFor' => 198,
			'Loop' => 195
		}
	},
	{#State 122
		DEFAULT => -161
	},
	{#State 123
		ACTIONS => {
			"use constant" => 42,
			"our %properties = (" => 203
		},
		GOTOS => {
			'Properties' => 202,
			'Constant' => 204
		}
	},
	{#State 124
		DEFAULT => -59
	},
	{#State 125
		ACTIONS => {
			";" => 205
		}
	},
	{#State 126
		ACTIONS => {
			"\$TYPED_" => 206
		}
	},
	{#State 127
		ACTIONS => {
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			"if (" => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"while (" => -160,
			"foreach my" => -160,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP01_PRINT_VOID_PAREN' => 120,
			"my" => 116,
			'WORD' => 90,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'OP01_NAMED_VOID' => 111,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_NAMED_VOID_PAREN' => 77,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_PRINT_VOID' => 102,
			"{" => 78,
			"for my integer" => -160,
			'OP01_OPEN_CLOSE' => 103
		},
		GOTOS => {
			'PLUS-17' => 207,
			'Statement' => 117,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'VariableDeclaration' => 113,
			'Expression' => 97,
			'VariableModification' => 98,
			'Conditional' => 122,
			'OPTIONAL-50' => 121,
			'ArrayReference' => 118,
			'PAREN-49' => 96,
			'Operation' => 208,
			'Operator' => 106,
			'Variable' => 81,
			'LoopLabel' => 83,
			'OperatorVoid' => 84,
			'HashDereferenced' => 86
		}
	},
	{#State 128
		DEFAULT => -42
	},
	{#State 129
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 209
		}
	},
	{#State 130
		DEFAULT => -40
	},
	{#State 131
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'HashDereferenced' => 86,
			'Expression' => 210,
			'ArrayReference' => 118,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89
		}
	},
	{#State 132
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => -199,
			"]" => -199,
			'OP18_TERNARY' => 161,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			";" => -199,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP21_LIST_COMMA' => -199,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP23_LOGICAL_AND' => 176
		}
	},
	{#State 133
		ACTIONS => {
			"(" => 211
		}
	},
	{#State 134
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -146,
			'OP15_LOGICAL_AND' => -146,
			'OP11_COMPARE_LT_GT' => -146,
			'OP03_MATH_INC_DEC' => 147,
			'OP21_LIST_COMMA' => -146,
			'OP02_METHOD_THINARROW' => 145,
			'OP16_LOGICAL_OR' => -146,
			'OP06_REGEX_MATCH' => -146,
			"}" => -146,
			'OP23_LOGICAL_AND' => -146,
			".." => -146,
			'OP18_TERNARY' => -146,
			"]" => -146,
			")" => -146,
			'OP08_STRING_CAT' => -146,
			'OP09_BITWISE_SHIFT' => -146,
			'OP14_BITWISE_OR_XOR' => -146,
			'OP08_MATH_ADD_SUB' => -146,
			";" => -146,
			'OP24_LOGICAL_OR_XOR' => -146,
			'OP13_BITWISE_AND' => -146,
			'OP12_COMPARE_EQ_NEQ' => -146,
			'OP17_LIST_RANGE' => -146,
			'OP04_MATH_POW' => -146
		}
	},
	{#State 135
		ACTIONS => {
			"%{" => 92
		},
		GOTOS => {
			'HashDereferenced' => 212
		}
	},
	{#State 136
		DEFAULT => -194,
		GOTOS => {
			'STAR-58' => 213
		}
	},
	{#State 137
		DEFAULT => -127
	},
	{#State 138
		ACTIONS => {
			")" => 214
		}
	},
	{#State 139
		DEFAULT => -215,
		GOTOS => {
			'STAR-63' => 215
		}
	},
	{#State 140
		DEFAULT => -210
	},
	{#State 141
		DEFAULT => -151
	},
	{#State 142
		ACTIONS => {
			'OP20_HASH_FATARROW' => 216
		}
	},
	{#State 143
		DEFAULT => -225
	},
	{#State 144
		ACTIONS => {
			";" => 217
		}
	},
	{#State 145
		ACTIONS => {
			'WORD' => 218
		}
	},
	{#State 146
		ACTIONS => {
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY' => 94,
			"<STDIN>" => 220,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Expression' => 221,
			'HashDereferenced' => 86,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'ExpressionOrStdin' => 219,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 147
		DEFAULT => -105
	},
	{#State 148
		ACTIONS => {
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'HashReference' => 89,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Expression' => 222,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 149
		DEFAULT => -16
	},
	{#State 150
		DEFAULT => -158
	},
	{#State 151
		DEFAULT => -104
	},
	{#State 152
		ACTIONS => {
			"}" => 223
		}
	},
	{#State 153
		ACTIONS => {
			"%{" => 92,
			'WORD' => 142
		},
		GOTOS => {
			'HashEntry' => 139,
			'HashDereferenced' => 140
		}
	},
	{#State 154
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 155
		ACTIONS => {
			'OP15_LOGICAL_AND' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => 225,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NEQ' => 169
		}
	},
	{#State 156
		ACTIONS => {
			"}" => -114,
			".." => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => -114,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -114,
			";" => -114,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"]" => -114,
			'OP18_TERNARY' => -114,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => -114
		}
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			"my" => 73,
			'WORD' => 24,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'OP01_QW' => 133,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			")" => -98,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95
		},
		GOTOS => {
			'Expression' => 132,
			'HashDereferenced' => 86,
			'TypeInner' => 131,
			'ListElement' => 136,
			'ArrayReference' => 118,
			'OPTIONAL-41' => 226,
			'ListElements' => 227,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 228
		}
	},
	{#State 159
		ACTIONS => {
			"filehandle_ref" => 229
		}
	},
	{#State 160
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95
		},
		GOTOS => {
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 230
		}
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 231
		}
	},
	{#State 162
		ACTIONS => {
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109
		},
		GOTOS => {
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 232,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'HashReference' => 89,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99
		},
		GOTOS => {
			'Expression' => 233,
			'HashDereferenced' => 86,
			'ArrayReference' => 118,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89
		}
	},
	{#State 164
		ACTIONS => {
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 99,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 106,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Expression' => 234,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 165
		ACTIONS => {
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'Expression' => 235,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 166
		ACTIONS => {
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114
		},
		GOTOS => {
			'Expression' => 236,
			'HashDereferenced' => 86,
			'ArrayReference' => 118,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89
		}
	},
	{#State 167
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 106,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'HashDereferenced' => 86,
			'Expression' => 237,
			'ArrayReference' => 118
		}
	},
	{#State 168
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114
		},
		GOTOS => {
			'HashReference' => 89,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'Expression' => 238,
			'HashDereferenced' => 86
		}
	},
	{#State 169
		ACTIONS => {
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 106,
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'Expression' => 239,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 170
		DEFAULT => -93
	},
	{#State 171
		ACTIONS => {
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Expression' => 240,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 172
		ACTIONS => {
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 241
		}
	},
	{#State 173
		ACTIONS => {
			"/" => 242
		}
	},
	{#State 174
		ACTIONS => {
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107
		},
		GOTOS => {
			'Expression' => 243,
			'HashDereferenced' => 86,
			'ArrayReference' => 118,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89
		}
	},
	{#State 175
		ACTIONS => {
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 244
		}
	},
	{#State 176
		ACTIONS => {
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'LITERAL_NUMBER' => 100,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'WORD' => 24,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'Expression' => 245,
			'HashDereferenced' => 86
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 246
		}
	},
	{#State 178
		ACTIONS => {
			"}" => 247
		}
	},
	{#State 179
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'KEYS_OR_VALUES' => 135,
			")" => -96,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 99,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_QW' => 133,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			"my" => 73,
			"[" => 107,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'ListElement' => 136,
			'ArrayReference' => 118,
			'Expression' => 132,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'OPTIONAL-40' => 249,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'HashReference' => 89,
			'ListElements' => 248,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => 24,
			";" => -134,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			"my" => 73,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP01_QW' => 133,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 107
		},
		GOTOS => {
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'Operator' => 106,
			'Variable' => 134,
			'ListElements' => 251,
			'ArrayReference' => 118,
			'OPTIONAL-46' => 250,
			'ListElement' => 136,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'Expression' => 132
		}
	},
	{#State 181
		ACTIONS => {
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'KEYS_OR_VALUES' => 135,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP01_QW' => 133,
			'WORD' => 24,
			";" => -100,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			"my" => 73
		},
		GOTOS => {
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'Variable' => 134,
			'Operator' => 106,
			'ListElements' => 253,
			'ArrayReference' => 118,
			'ListElement' => 136,
			'OPTIONAL-42' => 252,
			'HashDereferenced' => 86,
			'TypeInner' => 131,
			'Expression' => 132
		}
	},
	{#State 182
		ACTIONS => {
			"]" => -124,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => -124,
			";" => -124,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP21_LIST_COMMA' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			"}" => -124,
			".." => -124,
			'OP23_LOGICAL_AND' => -124
		}
	},
	{#State 183
		ACTIONS => {
			'OP06_REGEX_MATCH' => -184,
			'OP16_LOGICAL_OR' => -184,
			'OP19_VARIABLE_ASSIGN' => -184,
			'OP21_LIST_COMMA' => -184,
			'OP02_METHOD_THINARROW' => -184,
			'COLON' => -184,
			'OP03_MATH_INC_DEC' => -184,
			'OP11_COMPARE_LT_GT' => -184,
			'OP07_MATH_MULT_DIV_MOD' => -184,
			'OP15_LOGICAL_AND' => -184,
			".." => -184,
			'OP23_LOGICAL_AND' => -184,
			"}" => -184,
			'OP08_STRING_CAT' => -184,
			'OP09_BITWISE_SHIFT' => -184,
			'OP02_ARRAY_THINARROW' => 255,
			")" => -184,
			"]" => -184,
			'OP18_TERNARY' => -184,
			'OP19_VARIABLE_ASSIGN_BY' => -184,
			'OP17_LIST_RANGE' => -184,
			'OP04_MATH_POW' => -184,
			'OP02_HASH_THINARROW' => 256,
			'OP12_COMPARE_EQ_NEQ' => -184,
			'OP24_LOGICAL_OR_XOR' => -184,
			'OP13_BITWISE_AND' => -184,
			";" => -184,
			'OP08_MATH_ADD_SUB' => -184,
			'OP14_BITWISE_OR_XOR' => -184
		},
		GOTOS => {
			'VariableRetrieval' => 254
		}
	},
	{#State 184
		ACTIONS => {
			"]" => 257
		}
	},
	{#State 185
		DEFAULT => -202
	},
	{#State 186
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 107,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			"my" => 73,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_QW' => 133,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'KEYS_OR_VALUES' => 135,
			")" => -141,
			'OP10_NAMED_UNARY_STRINGIFY' => 119
		},
		GOTOS => {
			'HashReference' => 89,
			'OPTIONAL-47' => 259,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'ListElements' => 258,
			'Variable' => 134,
			'Operator' => 106,
			'ListElement' => 136,
			'ArrayReference' => 118,
			'Expression' => 132,
			'HashDereferenced' => 86,
			'TypeInner' => 131
		}
	},
	{#State 187
		ACTIONS => {
			";" => 260
		}
	},
	{#State 188
		DEFAULT => -131
	},
	{#State 189
		ACTIONS => {
			'OP23_LOGICAL_AND' => 176,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP18_TERNARY' => 161,
			")" => 261,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 190
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => 262,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => 162,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP12_COMPARE_EQ_NEQ' => 169
		}
	},
	{#State 191
		ACTIONS => {
			")" => -107,
			'OP08_STRING_CAT' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP18_TERNARY' => -107,
			"]" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP13_BITWISE_AND' => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			";" => -107,
			'OP06_REGEX_MATCH' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP23_LOGICAL_AND' => -107,
			".." => -107,
			"}" => -107
		}
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 263
		}
	},
	{#State 193
		ACTIONS => {
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP23_LOGICAL_AND' => -115,
			".." => -115,
			"}" => -115,
			")" => -115,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => -115,
			"]" => -115,
			'OP13_BITWISE_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -115
		}
	},
	{#State 194
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			"my" => 73,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP01_QW' => 133,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			")" => -130,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'ArrayReference' => 118,
			'ListElement' => 136,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'Expression' => 132,
			'OPTIONAL-44' => 264,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ListElements' => 265
		}
	},
	{#State 195
		DEFAULT => -162
	},
	{#State 196
		DEFAULT => -175
	},
	{#State 197
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 266
		}
	},
	{#State 198
		DEFAULT => -173
	},
	{#State 199
		DEFAULT => -174
	},
	{#State 200
		ACTIONS => {
			'VARIABLE_SYMBOL' => 267
		}
	},
	{#State 201
		ACTIONS => {
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'HashDereferenced' => 86,
			'Expression' => 268,
			'ArrayReference' => 118,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89
		}
	},
	{#State 202
		ACTIONS => {
			"our %properties_class = (" => 271,
			"1;" => -64,
			"our" => -64
		},
		GOTOS => {
			'PropertiesClass' => 270,
			'OPTIONAL-26' => 269
		}
	},
	{#State 203
		ACTIONS => {
			")" => 273,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 272
		}
	},
	{#State 204
		DEFAULT => -61
	},
	{#State 205
		DEFAULT => -41
	},
	{#State 206
		ACTIONS => {
			'WORD' => 274
		}
	},
	{#State 207
		ACTIONS => {
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 90,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"while (" => -160,
			'OP10_NAMED_UNARY' => 94,
			"if (" => 93,
			"\@{" => 99,
			"for my integer" => -160,
			"{" => 78,
			'OP01_NAMED_VOID_PAREN' => 77,
			"}" => 275,
			'OP19_LOOP_CONTROL' => 80,
			'OP03_MATH_INC_DEC' => 85,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP01_NAMED_VOID' => 111,
			"my" => 116,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89,
			'VariableDeclaration' => 113,
			'Statement' => 117,
			'ArrayReference' => 118,
			'PAREN-49' => 96,
			'Expression' => 97,
			'VariableModification' => 98,
			'OPTIONAL-50' => 121,
			'Conditional' => 122,
			'Operation' => 276,
			'Variable' => 81,
			'Operator' => 106,
			'LoopLabel' => 83,
			'HashDereferenced' => 86,
			'OperatorVoid' => 84
		}
	},
	{#State 208
		DEFAULT => -45
	},
	{#State 209
		ACTIONS => {
			'VARIABLE_SYMBOL' => 277
		}
	},
	{#State 210
		ACTIONS => {
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -200,
			'OP23_LOGICAL_AND' => 176,
			")" => -200,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP18_TERNARY' => 161,
			"]" => -200,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -200
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 278
		},
		GOTOS => {
			'PLUS-59' => 279
		}
	},
	{#State 212
		DEFAULT => -201
	},
	{#State 213
		ACTIONS => {
			")" => -197,
			";" => -197,
			"]" => -197,
			'OP21_LIST_COMMA' => 280
		},
		GOTOS => {
			'PAREN-57' => 281
		}
	},
	{#State 214
		ACTIONS => {
			";" => 282
		}
	},
	{#State 215
		ACTIONS => {
			"}" => 284,
			'OP21_LIST_COMMA' => 283
		},
		GOTOS => {
			'PAREN-62' => 285
		}
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => -208,
			'OP22_LOGICAL_NOT' => -208,
			'OP01_OPEN_CLOSE' => -208,
			"{" => -208,
			'OP01_NAMED' => -208,
			'LITERAL_NUMBER' => -208,
			"undef" => -208,
			'OP03_MATH_INC_DEC' => -208,
			'WORD_SCOPED' => -208,
			"[" => -208,
			"%{" => -208,
			'LITERAL_STRING' => -208,
			'WORD' => -208,
			"my" => 73,
			'OP05_LOGICAL_NEG' => -208,
			"(" => -208,
			'OP05_MATH_NEG' => -208,
			"\@{" => -208,
			'OP01_OPEN_CLOSE_PAREN' => -208,
			'OP10_NAMED_UNARY_STRINGIFY' => -208,
			'OP10_NAMED_UNARY' => -208
		},
		GOTOS => {
			'TypeInner' => 287,
			'OPTIONAL-61' => 286
		}
	},
	{#State 217
		DEFAULT => -139
	},
	{#State 218
		ACTIONS => {
			"(" => 288
		}
	},
	{#State 219
		ACTIONS => {
			";" => 289
		}
	},
	{#State 220
		DEFAULT => -157
	},
	{#State 221
		ACTIONS => {
			'OP23_LOGICAL_AND' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -156,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 222
		ACTIONS => {
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			";" => 290,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 223
		DEFAULT => -218
	},
	{#State 224
		DEFAULT => -217
	},
	{#State 225
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 291
		}
	},
	{#State 226
		ACTIONS => {
			")" => 293
		}
	},
	{#State 227
		DEFAULT => -97
	},
	{#State 228
		ACTIONS => {
			"}" => 294
		}
	},
	{#State 229
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 230
		ACTIONS => {
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => -112,
			".." => -112,
			'OP23_LOGICAL_AND' => -112,
			"}" => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP08_STRING_CAT' => -112,
			")" => -112,
			"]" => -112,
			'OP18_TERNARY' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			";" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 172
		}
	},
	{#State 231
		ACTIONS => {
			'COLON' => 296
		}
	},
	{#State 232
		ACTIONS => {
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -122,
			")" => -122,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => -122,
			"]" => -122,
			'OP23_LOGICAL_AND' => -122,
			".." => -122,
			"}" => -122,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -122
		}
	},
	{#State 233
		ACTIONS => {
			".." => -106,
			'OP23_LOGICAL_AND' => -106,
			"}" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP08_STRING_CAT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			")" => -106,
			"]" => -106,
			'OP18_TERNARY' => -106
		}
	},
	{#State 234
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP21_LIST_COMMA' => -118,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -118,
			"}" => -118,
			'OP23_LOGICAL_AND' => -118,
			".." => -118,
			'OP18_TERNARY' => -118,
			"]" => -118,
			")" => -118,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => -118,
			";" => -118,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP13_BITWISE_AND' => -118,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -118
		}
	},
	{#State 235
		ACTIONS => {
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -121,
			'OP23_LOGICAL_AND' => -121,
			".." => -121,
			"}" => -121,
			")" => -121,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP18_TERNARY' => -121,
			"]" => -121,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP13_BITWISE_AND' => 164,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -121,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			";" => -121
		}
	},
	{#State 236
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -116,
			"}" => -116,
			'OP23_LOGICAL_AND' => -116,
			".." => -116,
			'OP18_TERNARY' => -116,
			"]" => -116,
			")" => -116,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => -116,
			";" => -116,
			'OP12_COMPARE_EQ_NEQ' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP17_LIST_RANGE' => -116,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 237
		ACTIONS => {
			'OP17_LIST_RANGE' => -113,
			'OP04_MATH_POW' => 163,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			";" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => 172,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => -113,
			")" => -113,
			"]" => -113,
			'OP18_TERNARY' => -113,
			".." => -113,
			'OP23_LOGICAL_AND' => -113,
			"}" => -113,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => -113
		}
	},
	{#State 238
		ACTIONS => {
			'OP21_LIST_COMMA' => -126,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			"}" => -126,
			".." => -126,
			'OP23_LOGICAL_AND' => 176,
			"]" => -126,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => -126,
			";" => -126,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => 162,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP13_BITWISE_AND' => 164
		}
	},
	{#State 239
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP21_LIST_COMMA' => -117,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -117,
			"}" => -117,
			'OP23_LOGICAL_AND' => -117,
			".." => -117,
			'OP18_TERNARY' => -117,
			"]" => -117,
			")" => -117,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => -117,
			";" => -117,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP13_BITWISE_AND' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -117
		}
	},
	{#State 240
		ACTIONS => {
			'OP15_LOGICAL_AND' => -119,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP21_LIST_COMMA' => -119,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -119,
			"}" => -119,
			'OP23_LOGICAL_AND' => -119,
			".." => -119,
			'OP18_TERNARY' => -119,
			"]" => -119,
			")" => -119,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP13_BITWISE_AND' => 164,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP17_LIST_RANGE' => -119,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 241
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			";" => -111,
			")" => -111,
			'OP08_STRING_CAT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP18_TERNARY' => -111,
			"]" => -111,
			'OP23_LOGICAL_AND' => -111,
			".." => -111,
			"}" => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP06_REGEX_MATCH' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111
		}
	},
	{#State 242
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 297
		}
	},
	{#State 243
		ACTIONS => {
			'OP18_TERNARY' => -120,
			"]" => -120,
			")" => -120,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			";" => -120,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -120,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP21_LIST_COMMA' => -120,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -120,
			"}" => -120,
			'OP23_LOGICAL_AND' => -120,
			".." => -120
		}
	},
	{#State 244
		ACTIONS => {
			'OP23_LOGICAL_AND' => -110,
			".." => -110,
			"}" => -110,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP07_MATH_MULT_DIV_MOD' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			";" => -110,
			")" => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP08_STRING_CAT' => -110,
			'OP18_TERNARY' => -110,
			"]" => -110
		}
	},
	{#State 245
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			";" => -125,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP13_BITWISE_AND' => 164,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP18_TERNARY' => 161,
			"]" => -125,
			")" => -125,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			"}" => -125,
			'OP23_LOGICAL_AND' => -125,
			".." => -125,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -125,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165
		}
	},
	{#State 246
		DEFAULT => -206
	},
	{#State 247
		DEFAULT => -205
	},
	{#State 248
		DEFAULT => -95
	},
	{#State 249
		ACTIONS => {
			")" => 298
		}
	},
	{#State 250
		ACTIONS => {
			";" => 299
		}
	},
	{#State 251
		DEFAULT => -133
	},
	{#State 252
		ACTIONS => {
			";" => 300
		}
	},
	{#State 253
		DEFAULT => -99
	},
	{#State 254
		DEFAULT => -182
	},
	{#State 255
		ACTIONS => {
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Operator' => 106,
			'Variable' => 134,
			'HashReference' => 89,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'HashDereferenced' => 86,
			'Expression' => 301,
			'ArrayReference' => 118
		}
	},
	{#State 256
		ACTIONS => {
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 303,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99
		},
		GOTOS => {
			'HashReference' => 89,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'Expression' => 302,
			'HashDereferenced' => 86
		}
	},
	{#State 257
		DEFAULT => -204
	},
	{#State 258
		DEFAULT => -140
	},
	{#State 259
		ACTIONS => {
			")" => 304
		}
	},
	{#State 260
		DEFAULT => -137
	},
	{#State 261
		DEFAULT => -108
	},
	{#State 262
		DEFAULT => -155
	},
	{#State 263
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 306,
			";" => 305
		}
	},
	{#State 264
		ACTIONS => {
			")" => 307
		}
	},
	{#State 265
		DEFAULT => -129
	},
	{#State 266
		ACTIONS => {
			'VARIABLE_SYMBOL' => 308
		}
	},
	{#State 267
		ACTIONS => {
			"(" => 309
		}
	},
	{#State 268
		ACTIONS => {
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 161,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			")" => 310,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168
		}
	},
	{#State 269
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 311
		}
	},
	{#State 270
		DEFAULT => -63
	},
	{#State 271
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 312
		}
	},
	{#State 272
		ACTIONS => {
			'WORD' => 313,
			"%{" => 92
		},
		GOTOS => {
			'HashEntryTyped' => 314,
			'HashDereferenced' => 315
		}
	},
	{#State 273
		ACTIONS => {
			";" => 316
		}
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 317
		}
	},
	{#State 275
		ACTIONS => {
			";" => 318
		}
	},
	{#State 276
		DEFAULT => -44
	},
	{#State 277
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 319
		}
	},
	{#State 278
		DEFAULT => -196
	},
	{#State 279
		ACTIONS => {
			")" => 320,
			'WORD' => 321
		}
	},
	{#State 280
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			"my" => 73,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'KEYS_OR_VALUES' => 135,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'ArrayReference' => 118,
			'ListElement' => 322,
			'HashDereferenced' => 86,
			'TypeInner' => 131,
			'Expression' => 132,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'HashReference' => 89,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 281
		DEFAULT => -193
	},
	{#State 282
		DEFAULT => -135
	},
	{#State 283
		ACTIONS => {
			'WORD' => 142,
			"%{" => 92
		},
		GOTOS => {
			'HashEntry' => 323,
			'HashDereferenced' => 140
		}
	},
	{#State 284
		DEFAULT => -216
	},
	{#State 285
		DEFAULT => -214
	},
	{#State 286
		ACTIONS => {
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			"[" => 107,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 99
		},
		GOTOS => {
			'HashReference' => 89,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Literal' => 88,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'Expression' => 324,
			'HashDereferenced' => 86
		}
	},
	{#State 287
		DEFAULT => -207
	},
	{#State 288
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			")" => -143,
			'KEYS_OR_VALUES' => 135,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			'OP01_QW' => 133,
			'WORD' => 24,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			"my" => 73,
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'LITERAL_NUMBER' => 100,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'HashReference' => 89,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'Variable' => 134,
			'Operator' => 106,
			'ListElements' => 325,
			'OPTIONAL-48' => 326,
			'ArrayReference' => 118,
			'ListElement' => 136,
			'TypeInner' => 131,
			'HashDereferenced' => 86,
			'Expression' => 132
		}
	},
	{#State 289
		DEFAULT => -190
	},
	{#State 290
		DEFAULT => -191
	},
	{#State 291
		DEFAULT => -168,
		GOTOS => {
			'STAR-52' => 327
		}
	},
	{#State 292
		ACTIONS => {
			'OP01_NAMED_VOID' => 111,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			"my" => 116,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 90,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"while (" => -160,
			'OP10_NAMED_UNARY' => 94,
			"if (" => 93,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED_VOID_PAREN' => 77,
			'OP01_OPEN_CLOSE' => 103,
			"for my integer" => -160,
			"{" => 78,
			'OP01_NAMED' => 101,
			'OP01_PRINT_VOID' => 102,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL' => 80,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109
		},
		GOTOS => {
			'PAREN-49' => 96,
			'PLUS-55' => 328,
			'ArrayReference' => 118,
			'VariableModification' => 98,
			'Conditional' => 122,
			'OPTIONAL-50' => 121,
			'Expression' => 97,
			'HashReference' => 89,
			'VariableDeclaration' => 113,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Statement' => 117,
			'LoopLabel' => 83,
			'HashDereferenced' => 86,
			'OperatorVoid' => 84,
			'Operator' => 106,
			'Variable' => 81,
			'Operation' => 329
		}
	},
	{#State 293
		ACTIONS => {
			";" => 330
		}
	},
	{#State 294
		DEFAULT => -221
	},
	{#State 295
		DEFAULT => -222
	},
	{#State 296
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105
		},
		GOTOS => {
			'Variable' => 331
		}
	},
	{#State 297
		ACTIONS => {
			"/" => 332
		}
	},
	{#State 298
		DEFAULT => -101
	},
	{#State 299
		DEFAULT => -138
	},
	{#State 300
		DEFAULT => -103
	},
	{#State 301
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 176,
			"]" => 333,
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168
		}
	},
	{#State 302
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 161,
			'OP23_LOGICAL_AND' => 176,
			"}" => 334,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174
		}
	},
	{#State 303
		ACTIONS => {
			"(" => -219,
			"}" => 335
		}
	},
	{#State 304
		DEFAULT => -153
	},
	{#State 305
		DEFAULT => -188
	},
	{#State 306
		ACTIONS => {
			"<STDIN>" => 220,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP05_MATH_NEG' => 112,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			"[" => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104
		},
		GOTOS => {
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'ExpressionOrStdin' => 336,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'Expression' => 221,
			'HashDereferenced' => 86
		}
	},
	{#State 307
		ACTIONS => {
			";" => 337
		}
	},
	{#State 308
		ACTIONS => {
			"(" => 338
		}
	},
	{#State 309
		ACTIONS => {
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Expression' => 339,
			'HashDereferenced' => 86,
			'Literal' => 88,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'HashReference' => 89,
			'Variable' => 134,
			'Operator' => 106
		}
	},
	{#State 310
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 340
		}
	},
	{#State 311
		ACTIONS => {
			"our" => 343,
			"1;" => 342
		},
		GOTOS => {
			'Method' => 341
		}
	},
	{#State 312
		ACTIONS => {
			"%{" => 92,
			'WORD' => 313
		},
		GOTOS => {
			'HashEntryTyped' => 344,
			'HashDereferenced' => 315
		}
	},
	{#State 313
		ACTIONS => {
			'OP20_HASH_FATARROW' => 345
		}
	},
	{#State 314
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 346
		}
	},
	{#State 315
		DEFAULT => -212
	},
	{#State 316
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 347
		}
	},
	{#State 317
		DEFAULT => -223
	},
	{#State 318
		DEFAULT => -46
	},
	{#State 319
		ACTIONS => {
			'OP21_LIST_COMMA' => 350,
			")" => 348
		},
		GOTOS => {
			'PAREN-18' => 349
		}
	},
	{#State 320
		DEFAULT => -198
	},
	{#State 321
		DEFAULT => -195
	},
	{#State 322
		DEFAULT => -192
	},
	{#State 323
		DEFAULT => -213
	},
	{#State 324
		ACTIONS => {
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -209,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165,
			"}" => -209,
			'OP23_LOGICAL_AND' => 176
		}
	},
	{#State 325
		DEFAULT => -142
	},
	{#State 326
		ACTIONS => {
			")" => 351
		}
	},
	{#State 327
		ACTIONS => {
			"elsif (" => 354,
			"my" => -171,
			'OP05_MATH_NEG' => -171,
			'OP05_LOGICAL_NEG' => -171,
			"(" => -171,
			'OP01_NAMED_VOID' => -171,
			'OP01_PRINT_VOID_PAREN' => -171,
			"foreach my" => -171,
			'OP10_NAMED_UNARY_STRINGIFY' => -171,
			'OP22_LOGICAL_NOT' => -171,
			'VARIABLE_SYMBOL' => -171,
			'OP01_PRINT_VOID' => -171,
			'OP01_NAMED' => -171,
			'OP01_OPEN_CLOSE' => -171,
			'LITERAL_NUMBER' => -171,
			"undef" => -171,
			'WORD_SCOPED' => -171,
			'' => -171,
			"[" => -171,
			'WORD' => -171,
			'LITERAL_STRING' => -171,
			"%{" => -171,
			"else" => 352,
			"\@{" => -171,
			'OP01_OPEN_CLOSE_PAREN' => -171,
			'OP10_NAMED_UNARY' => -171,
			"if (" => -171,
			"while (" => -171,
			'OP19_LOOP_CONTROL' => -171,
			"}" => -171,
			"{" => -171,
			"for my integer" => -171,
			'OP01_NAMED_VOID_PAREN' => -171,
			'OP03_MATH_INC_DEC' => -171
		},
		GOTOS => {
			'PAREN-51' => 353,
			'OPTIONAL-54' => 355,
			'PAREN-53' => 356
		}
	},
	{#State 328
		ACTIONS => {
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP01_PRINT_VOID' => 102,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107,
			"my" => 116,
			'OP01_NAMED_VOID' => 111,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			"}" => 357,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_NAMED_VOID_PAREN' => 77,
			"for my integer" => -160,
			"{" => 78,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 90,
			"\@{" => 99,
			"while (" => -160,
			'OP10_NAMED_UNARY' => 94,
			"if (" => 93,
			'OP01_OPEN_CLOSE_PAREN' => 95
		},
		GOTOS => {
			'Statement' => 117,
			'VariableDeclaration' => 113,
			'HashReference' => 89,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Conditional' => 122,
			'OPTIONAL-50' => 121,
			'VariableModification' => 98,
			'Expression' => 97,
			'PAREN-49' => 96,
			'ArrayReference' => 118,
			'Operator' => 106,
			'Variable' => 81,
			'Operation' => 358,
			'OperatorVoid' => 84,
			'HashDereferenced' => 86,
			'LoopLabel' => 83
		}
	},
	{#State 329
		DEFAULT => -180
	},
	{#State 330
		DEFAULT => -102
	},
	{#State 331
		DEFAULT => -123
	},
	{#State 332
		DEFAULT => -109
	},
	{#State 333
		DEFAULT => -185
	},
	{#State 334
		DEFAULT => -186
	},
	{#State 335
		DEFAULT => -187
	},
	{#State 336
		ACTIONS => {
			";" => 359
		}
	},
	{#State 337
		DEFAULT => -136
	},
	{#State 338
		ACTIONS => {
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'KEYS_OR_VALUES' => 135,
			'WORD' => 24,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			"my" => 73,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP01_QW' => 133,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'LITERAL_NUMBER' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Operator' => 106,
			'Variable' => 134,
			'ListElements' => 360,
			'ArrayReference' => 118,
			'ListElement' => 136,
			'HashDereferenced' => 86,
			'TypeInner' => 131,
			'Expression' => 132
		}
	},
	{#State 339
		ACTIONS => {
			".." => 361,
			'OP23_LOGICAL_AND' => 176,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 161,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 340
		DEFAULT => -178
	},
	{#State 341
		DEFAULT => -65
	},
	{#State 342
		ACTIONS => {
			"1;" => 362
		}
	},
	{#State 343
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 363
		}
	},
	{#State 344
		DEFAULT => -80,
		GOTOS => {
			'STAR-34' => 364
		}
	},
	{#State 345
		ACTIONS => {
			"my" => 73
		},
		GOTOS => {
			'TypeInner' => 365
		}
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 367,
			")" => 368
		},
		GOTOS => {
			'PAREN-31' => 366
		}
	},
	{#State 347
		DEFAULT => -77
	},
	{#State 348
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 369
		}
	},
	{#State 349
		DEFAULT => -48
	},
	{#State 350
		ACTIONS => {
			"my" => 370
		}
	},
	{#State 351
		DEFAULT => -154
	},
	{#State 352
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 371
		}
	},
	{#State 353
		DEFAULT => -167
	},
	{#State 354
		ACTIONS => {
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114
		},
		GOTOS => {
			'HashReference' => 89,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayReference' => 118,
			'HashDereferenced' => 86,
			'Expression' => 372
		}
	},
	{#State 355
		DEFAULT => -172
	},
	{#State 356
		DEFAULT => -170
	},
	{#State 357
		DEFAULT => -181
	},
	{#State 358
		DEFAULT => -179
	},
	{#State 359
		DEFAULT => -189
	},
	{#State 360
		ACTIONS => {
			")" => 373
		}
	},
	{#State 361
		ACTIONS => {
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 106,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89,
			'HashDereferenced' => 86,
			'Expression' => 374,
			'ArrayReference' => 118
		}
	},
	{#State 362
		ACTIONS => {
			"package" => -71,
			"our" => 43,
			"## no critic qw(" => -71,
			'' => -71
		},
		GOTOS => {
			'Subroutine' => 375,
			'PAREN-29' => 376,
			'OPTIONAL-30' => 377,
			'PLUS-28' => 378
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 364
		ACTIONS => {
			")" => 380,
			'OP21_LIST_COMMA' => 381
		},
		GOTOS => {
			'PAREN-33' => 382
		}
	},
	{#State 365
		ACTIONS => {
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 24,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"\@{" => 99,
			'LITERAL_NUMBER' => 100,
			'OP01_NAMED' => 101,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"[" => 107,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109
		},
		GOTOS => {
			'Expression' => 383,
			'HashDereferenced' => 86,
			'ArrayReference' => 118,
			'Variable' => 134,
			'Operator' => 106,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'HashReference' => 89
		}
	},
	{#State 366
		DEFAULT => -74
	},
	{#State 367
		ACTIONS => {
			'WORD' => 313,
			"%{" => 92
		},
		GOTOS => {
			'HashDereferenced' => 315,
			'HashEntryTyped' => 384
		}
	},
	{#State 368
		ACTIONS => {
			";" => 385
		}
	},
	{#State 369
		ACTIONS => {
			"\@_;" => 386
		}
	},
	{#State 370
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 387
		}
	},
	{#State 371
		DEFAULT => -169
	},
	{#State 372
		ACTIONS => {
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			")" => 388,
			'OP18_TERNARY' => 161,
			'OP23_LOGICAL_AND' => 176,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174
		}
	},
	{#State 373
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 374
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => 162,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP13_BITWISE_AND' => 164,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => 390,
			'OP18_TERNARY' => 161,
			'OP23_LOGICAL_AND' => 176,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175
		}
	},
	{#State 375
		DEFAULT => -68
	},
	{#State 376
		DEFAULT => -70
	},
	{#State 377
		DEFAULT => -72
	},
	{#State 378
		ACTIONS => {
			"our" => 43,
			"1;" => 391
		},
		GOTOS => {
			'Subroutine' => 392
		}
	},
	{#State 379
		ACTIONS => {
			"= sub {" => 393
		}
	},
	{#State 380
		ACTIONS => {
			";" => 394
		}
	},
	{#State 381
		ACTIONS => {
			"%{" => 92,
			'WORD' => 313
		},
		GOTOS => {
			'HashDereferenced' => 315,
			'HashEntryTyped' => 395
		}
	},
	{#State 382
		DEFAULT => -79
	},
	{#State 383
		ACTIONS => {
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP21_LIST_COMMA' => -211,
			'OP23_LOGICAL_AND' => 176,
			")" => -211,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 161,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171
		}
	},
	{#State 384
		DEFAULT => -73
	},
	{#State 385
		DEFAULT => -76
	},
	{#State 386
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 396
		}
	},
	{#State 387
		ACTIONS => {
			'VARIABLE_SYMBOL' => 397
		}
	},
	{#State 388
		ACTIONS => {
			"{" => 292
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
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 399
		}
	},
	{#State 391
		ACTIONS => {
			"1;" => 400
		}
	},
	{#State 392
		DEFAULT => -67
	},
	{#State 393
		ACTIONS => {
			'OP01_NAMED_VOID' => -83,
			'OP05_MATH_NEG' => -83,
			'OP05_LOGICAL_NEG' => -83,
			"(" => -83,
			"my" => -83,
			'OP10_NAMED_UNARY_STRINGIFY' => -83,
			'OP01_PRINT_VOID_PAREN' => -83,
			"foreach my" => -83,
			'LITERAL_NUMBER' => -83,
			'OP01_NAMED' => -83,
			'OP01_PRINT_VOID' => -83,
			'OP01_OPEN_CLOSE' => -83,
			'OP22_LOGICAL_NOT' => -83,
			'VARIABLE_SYMBOL' => -83,
			"[" => -83,
			'WORD_SCOPED' => -83,
			"undef" => -83,
			'WORD' => -83,
			"%{" => -83,
			'LITERAL_STRING' => -83,
			'OP10_NAMED_UNARY' => -83,
			"if (" => -83,
			"while (" => -83,
			'OP01_OPEN_CLOSE_PAREN' => -83,
			"\@{" => -83,
			'OP01_NAMED_VOID_PAREN' => -83,
			"for my integer" => -83,
			"( my" => 403,
			"{" => -83,
			'OP19_LOOP_CONTROL' => -83,
			'OP03_MATH_INC_DEC' => -83
		},
		GOTOS => {
			'MethodArguments' => 402,
			'OPTIONAL-35' => 401
		}
	},
	{#State 394
		DEFAULT => -81
	},
	{#State 395
		DEFAULT => -78
	},
	{#State 396
		ACTIONS => {
			"[" => -52,
			"undef" => -52,
			'WORD_SCOPED' => -52,
			'OP01_PRINT_VOID' => -52,
			'OP01_NAMED' => -52,
			'OP01_OPEN_CLOSE' => -52,
			'LITERAL_NUMBER' => -52,
			'OP22_LOGICAL_NOT' => -52,
			'VARIABLE_SYMBOL' => -52,
			'OP01_PRINT_VOID_PAREN' => -52,
			"foreach my" => -52,
			'OP10_NAMED_UNARY_STRINGIFY' => -52,
			'OP05_LOGICAL_NEG' => -52,
			'OP05_MATH_NEG' => -52,
			"(" => -52,
			'OP01_NAMED_VOID' => -52,
			"my" => -52,
			'OP03_MATH_INC_DEC' => -52,
			"for my integer" => -52,
			"{" => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			'OP19_LOOP_CONTROL' => -52,
			'OP01_OPEN_CLOSE_PAREN' => -52,
			"if (" => -52,
			'OP10_NAMED_UNARY' => -52,
			"while (" => -52,
			"\@{" => -52,
			'CHECK_OR_CHECKTRACE' => 404,
			'WORD' => -52,
			'LITERAL_STRING' => -52,
			"%{" => -52
		},
		GOTOS => {
			'ArgumentCheck' => 405
		}
	},
	{#State 397
		DEFAULT => -47
	},
	{#State 398
		DEFAULT => -166
	},
	{#State 399
		DEFAULT => -176
	},
	{#State 400
		DEFAULT => -69
	},
	{#State 401
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 109,
			"[" => 107,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_NAMED_VOID_PAREN' => 77,
			'LITERAL_NUMBER' => 100,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED' => 101,
			"{" => 78,
			"for my integer" => -160,
			'OP01_OPEN_CLOSE' => 103,
			"\@{" => 99,
			'OP10_NAMED_UNARY' => 94,
			"if (" => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"while (" => -160,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			"my" => 116,
			'WORD' => 90,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'OP01_NAMED_VOID' => 111,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Statement' => 117,
			'VariableDeclaration' => 113,
			'HashReference' => 89,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'OPTIONAL-50' => 121,
			'Conditional' => 122,
			'VariableModification' => 98,
			'Expression' => 97,
			'PAREN-49' => 96,
			'ArrayReference' => 118,
			'Variable' => 81,
			'Operator' => 106,
			'Operation' => 406,
			'HashDereferenced' => 86,
			'PLUS-36' => 407,
			'OperatorVoid' => 84,
			'LoopLabel' => 83
		}
	},
	{#State 402
		DEFAULT => -82
	},
	{#State 403
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 408
		}
	},
	{#State 404
		ACTIONS => {
			"(" => 409
		}
	},
	{#State 405
		DEFAULT => -50
	},
	{#State 406
		DEFAULT => -85
	},
	{#State 407
		ACTIONS => {
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			'OP01_PRINT_VOID' => 102,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"foreach my" => -160,
			'OP01_PRINT_VOID_PAREN' => 120,
			"my" => 116,
			'OP01_NAMED_VOID' => 111,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 80,
			"}" => 411,
			'OP01_NAMED_VOID_PAREN' => 77,
			"{" => 78,
			"for my integer" => -160,
			"\@{" => 99,
			"if (" => 93,
			'OP10_NAMED_UNARY' => 94,
			"while (" => -160,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'WORD' => 90,
			'LITERAL_STRING' => 91,
			"%{" => 92
		},
		GOTOS => {
			'HashReference' => 89,
			'VariableDeclaration' => 113,
			'WordScoped' => 110,
			'Literal' => 88,
			'ArrayDereferenced' => 87,
			'Statement' => 117,
			'PAREN-49' => 96,
			'ArrayReference' => 118,
			'VariableModification' => 98,
			'OPTIONAL-50' => 121,
			'Conditional' => 122,
			'Expression' => 97,
			'Variable' => 81,
			'Operator' => 106,
			'Operation' => 410,
			'LoopLabel' => 83,
			'HashDereferenced' => 86,
			'OperatorVoid' => 84
		}
	},
	{#State 408
		DEFAULT => -89,
		GOTOS => {
			'STAR-38' => 412
		}
	},
	{#State 409
		ACTIONS => {
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG' => 112,
			"(" => 114,
			"\@{" => 99,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'LITERAL_NUMBER' => 100,
			"{" => 78,
			'OP01_OPEN_CLOSE' => 103,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"undef" => 109,
			"[" => 107
		},
		GOTOS => {
			'HashReference' => 89,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'Operator' => 106,
			'Variable' => 134,
			'ArrayReference' => 118,
			'Expression' => 413,
			'HashDereferenced' => 86
		}
	},
	{#State 410
		DEFAULT => -84
	},
	{#State 411
		ACTIONS => {
			";" => 414
		}
	},
	{#State 412
		ACTIONS => {
			")" => 415,
			'OP21_LIST_COMMA' => 417
		},
		GOTOS => {
			'PAREN-37' => 416
		}
	},
	{#State 413
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => 162,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP18_TERNARY' => 161,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			")" => -55,
			'OP23_LOGICAL_AND' => 176,
			'OP21_LIST_COMMA' => 419,
			'OP15_LOGICAL_AND' => 174,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP06_REGEX_MATCH' => 173,
			'OP16_LOGICAL_OR' => 165
		},
		GOTOS => {
			'OPTIONAL-22' => 418,
			'PAREN-21' => 420
		}
	},
	{#State 414
		DEFAULT => -86
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421
		}
	},
	{#State 416
		DEFAULT => -88
	},
	{#State 417
		ACTIONS => {
			"my" => 422
		}
	},
	{#State 418
		ACTIONS => {
			")" => 423
		}
	},
	{#State 419
		ACTIONS => {
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 22,
			"[" => 107,
			'VARIABLE_SYMBOL' => 105,
			'OP22_LOGICAL_NOT' => 104,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'OP01_NAMED' => 101,
			'LITERAL_NUMBER' => 100,
			"\@{" => 99,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			'OP10_NAMED_UNARY' => 94,
			"%{" => 92,
			'LITERAL_STRING' => 91,
			'WORD' => 24,
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114
		},
		GOTOS => {
			'HashDereferenced' => 86,
			'Expression' => 424,
			'ArrayReference' => 118,
			'Variable' => 134,
			'Operator' => 106,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89
		}
	},
	{#State 420
		DEFAULT => -54
	},
	{#State 421
		ACTIONS => {
			"\@_;" => 425
		}
	},
	{#State 422
		ACTIONS => {
			'WORD' => 52
		},
		GOTOS => {
			'Type' => 426
		}
	},
	{#State 423
		ACTIONS => {
			";" => 427
		}
	},
	{#State 424
		ACTIONS => {
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP21_LIST_COMMA' => 428,
			'OP11_COMPARE_LT_GT' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP15_LOGICAL_AND' => 174,
			'OP23_LOGICAL_AND' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_STRING_CAT' => 160,
			'OP18_TERNARY' => 161,
			'OP17_LIST_RANGE' => 162,
			'OP04_MATH_POW' => 163,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP08_MATH_ADD_SUB' => 172,
			'OP14_BITWISE_OR_XOR' => 171
		}
	},
	{#State 425
		DEFAULT => -91,
		GOTOS => {
			'STAR-39' => 429
		}
	},
	{#State 426
		ACTIONS => {
			'VARIABLE_SYMBOL' => 430
		}
	},
	{#State 427
		DEFAULT => -56
	},
	{#State 428
		ACTIONS => {
			'OP05_MATH_NEG' => 112,
			'OP05_LOGICAL_NEG' => 115,
			"(" => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 91,
			"%{" => 92,
			'OP01_OPEN_CLOSE_PAREN' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP10_NAMED_UNARY_STRINGIFY' => 119,
			"\@{" => 99,
			'OP01_NAMED' => 101,
			'OP01_OPEN_CLOSE' => 103,
			"{" => 78,
			'LITERAL_NUMBER' => 100,
			'OP22_LOGICAL_NOT' => 104,
			'VARIABLE_SYMBOL' => 105,
			"[" => 107,
			"undef" => 109,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 106,
			'ArrayDereferenced' => 87,
			'Literal' => 88,
			'WordScoped' => 110,
			'HashReference' => 89,
			'Expression' => 431,
			'HashDereferenced' => 86,
			'ArrayReference' => 118
		}
	},
	{#State 429
		ACTIONS => {
			'WORD' => -92,
			'LITERAL_STRING' => -92,
			"%{" => -92,
			'OP01_OPEN_CLOSE_PAREN' => -92,
			"if (" => -92,
			'OP10_NAMED_UNARY' => -92,
			"while (" => -92,
			'CHECK_OR_CHECKTRACE' => 404,
			"\@{" => -92,
			"for my integer" => -92,
			"{" => -92,
			'OP01_NAMED_VOID_PAREN' => -92,
			'OP19_LOOP_CONTROL' => -92,
			'OP03_MATH_INC_DEC' => -92,
			"(" => -92,
			'OP05_LOGICAL_NEG' => -92,
			'OP05_MATH_NEG' => -92,
			'OP01_NAMED_VOID' => -92,
			"my" => -92,
			'OP01_PRINT_VOID_PAREN' => -92,
			"foreach my" => -92,
			'OP10_NAMED_UNARY_STRINGIFY' => -92,
			'OP01_NAMED' => -92,
			'OP01_PRINT_VOID' => -92,
			'OP01_OPEN_CLOSE' => -92,
			'LITERAL_NUMBER' => -92,
			'OP22_LOGICAL_NOT' => -92,
			'VARIABLE_SYMBOL' => -92,
			"[" => -92,
			"undef" => -92,
			'WORD_SCOPED' => -92
		},
		GOTOS => {
			'ArgumentCheck' => 432
		}
	},
	{#State 430
		DEFAULT => -87
	},
	{#State 431
		ACTIONS => {
			'OP18_TERNARY' => 161,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 167,
			")" => -53,
			'OP14_BITWISE_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 172,
			'OP04_MATH_POW' => 163,
			'OP17_LIST_RANGE' => 162,
			'OP24_LOGICAL_OR_XOR' => 168,
			'OP13_BITWISE_AND' => 164,
			'OP12_COMPARE_EQ_NEQ' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 175,
			'OP11_COMPARE_LT_GT' => 166,
			'OP15_LOGICAL_AND' => 174,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 173,
			'OP23_LOGICAL_AND' => 176
		}
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
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6305 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
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
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6337 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6351 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6372 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6393 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 3,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
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
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
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
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
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
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6574 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6581 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
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
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
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
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
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
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
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
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
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
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7353 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
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
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
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
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
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
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
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
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
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
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7715 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
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
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7773 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7780 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
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


#line 8198 lib/RPerl/Grammar.pm



1;
