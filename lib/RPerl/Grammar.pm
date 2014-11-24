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

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|package|elsif\ \(|\=\ sub\ \{|\$TYPED_|\<STDIN\>|while\ \(|undef|else|if\ \(|\(\ my|our|\@_\;|use|qw\(|my|\%\{|\{\*|\@\{|\.\.|1\;|\(|\)|\}|\{|\/|\]|\[|\;)}gc and return ($1, $1);

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
      /\G((print|croak|return|exit)\s*\()/gc and return ('OP01_NAMED_VOID_PAREN', $1);
      /\G(print|croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_NAMED_QW', $1);
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


#line 115 lib/RPerl/Grammar.pm

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
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-27', [ 'PLUS-27', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-27', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-28', [ 'PLUS-27', '1;', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [ 'PAREN-28' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [  ], 0 ],
  [ 'Class_70' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-23', 'STAR-24', 'STAR-25', 'Properties', 'STAR-26', '1;', '1;', 'OPTIONAL-29' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'Properties_74' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-31', ')', ';' ], 0 ],
  [ 'Properties_75' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'PLUS-33', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'Operation' ], 0 ],
  [ 'Method_80' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-32', 'PLUS-33', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'PAREN-34' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'MethodArguments_86' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-35', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-36' ], 0 ],
  [ 'Operation_87' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_88' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-37', ')' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-38', ')', ';' ], 0 ],
  [ 'OperatorVoid_124' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'FileHandle', 'OPTIONAL-39', ')', ';' ], 0 ],
  [ 'OperatorVoid_125' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-40', ';' ], 0 ],
  [ 'OperatorVoid_126' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-41', ';' ], 0 ],
  [ 'OperatorVoid_127' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_134' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_135' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_137' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_138' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_139' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-43', ')' ], 0 ],
  [ 'Expression_143' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_144' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_145' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'PAREN-44' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OPTIONAL-45', 'Loop' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'PAREN-48' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'Conditional_160' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-47', 'OPTIONAL-49' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_164' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_165' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_166' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-50', [ 'PLUS-50', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-50', [ 'Operation' ], 0 ],
  [ 'CodeBlock_169' => 'CodeBlock', [ '{', 'PLUS-50', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [ 'STAR-51', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-51', [  ], 0 ],
  [ 'Variable_172' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-51' ], 0 ],
  [ 'VariableRetrieval_173' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_176' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_177' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_178' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_179' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-52', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'PAREN-52' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'PLUS-54', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'WORD' ], 0 ],
  [ 'ListElements_185' => 'ListElements', [ 'ListElement', 'STAR-53' ], 0 ],
  [ 'ListElements_186' => 'ListElements', [ 'OP01_NAMED_QW', '(', 'PLUS-54', ')' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'ArrayReference_192' => 'ArrayReference', [ '[', 'OPTIONAL-55', ']' ], 0 ],
  [ 'ArrayDereferenced_193' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_194' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'HashEntry_197' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-56', 'Expression' ], 0 ],
  [ 'HashEntry_198' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_199' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_200' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'HashReference_204' => 'HashReference', [ '{', 'HashEntry', 'STAR-58', '}' ], 0 ],
  [ 'HashDereferenced_205' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_206' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_208' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_209' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_210' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_211' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_212' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_213' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Literal_214' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_215' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  '_PLUS_LIST' => 65,
  '_PLUS_LIST' => 66,
  '_PAREN' => 67,
  '_OPTIONAL' => 68,
  '_OPTIONAL' => 69,
  'Class_70' => 70,
  '_PAREN' => 71,
  '_STAR_LIST' => 72,
  '_STAR_LIST' => 73,
  'Properties_74' => 74,
  'Properties_75' => 75,
  '_OPTIONAL' => 76,
  '_OPTIONAL' => 77,
  '_PLUS_LIST' => 78,
  '_PLUS_LIST' => 79,
  'Method_80' => 80,
  '_PAREN' => 81,
  '_STAR_LIST' => 82,
  '_STAR_LIST' => 83,
  '_STAR_LIST' => 84,
  '_STAR_LIST' => 85,
  'MethodArguments_86' => 86,
  'Operation_87' => 87,
  'Operation_88' => 88,
  '_OPTIONAL' => 89,
  '_OPTIONAL' => 90,
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
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  'OperatorVoid_123' => 123,
  'OperatorVoid_124' => 124,
  'OperatorVoid_125' => 125,
  'OperatorVoid_126' => 126,
  'OperatorVoid_127' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'Expression_134' => 134,
  'Expression_135' => 135,
  'Expression_136' => 136,
  'Expression_137' => 137,
  'Expression_138' => 138,
  'Expression_139' => 139,
  'Expression_140' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'ExpressionOrStdin_144' => 144,
  'ExpressionOrStdin_145' => 145,
  '_PAREN' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  '_PAREN' => 154,
  '_STAR_LIST' => 155,
  '_STAR_LIST' => 156,
  '_PAREN' => 157,
  '_OPTIONAL' => 158,
  '_OPTIONAL' => 159,
  'Conditional_160' => 160,
  'Loop_161' => 161,
  'Loop_162' => 162,
  'Loop_163' => 163,
  'LoopFor_164' => 164,
  'LoopForEach_165' => 165,
  'LoopWhile_166' => 166,
  '_PLUS_LIST' => 167,
  '_PLUS_LIST' => 168,
  'CodeBlock_169' => 169,
  '_STAR_LIST' => 170,
  '_STAR_LIST' => 171,
  'Variable_172' => 172,
  'VariableRetrieval_173' => 173,
  'VariableRetrieval_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableDeclaration_176' => 176,
  'VariableDeclaration_177' => 177,
  'VariableModification_178' => 178,
  'VariableModification_179' => 179,
  '_PAREN' => 180,
  '_STAR_LIST' => 181,
  '_STAR_LIST' => 182,
  '_PLUS_LIST' => 183,
  '_PLUS_LIST' => 184,
  'ListElements_185' => 185,
  'ListElements_186' => 186,
  'ListElement_187' => 187,
  'ListElement_188' => 188,
  'ListElement_189' => 189,
  '_OPTIONAL' => 190,
  '_OPTIONAL' => 191,
  'ArrayReference_192' => 192,
  'ArrayDereferenced_193' => 193,
  'ArrayDereferenced_194' => 194,
  '_OPTIONAL' => 195,
  '_OPTIONAL' => 196,
  'HashEntry_197' => 197,
  'HashEntry_198' => 198,
  'HashEntryTyped_199' => 199,
  'HashEntryTyped_200' => 200,
  '_PAREN' => 201,
  '_STAR_LIST' => 202,
  '_STAR_LIST' => 203,
  'HashReference_204' => 204,
  'HashDereferenced_205' => 205,
  'HashDereferenced_206' => 206,
  'WordScoped_207' => 207,
  'WordScoped_208' => 208,
  'FileHandle_209' => 209,
  'FileHandle_210' => 210,
  'TypeInner_211' => 211,
  'Type_212' => 212,
  'LoopLabel_213' => 213,
  'Literal_214' => 214,
  'Literal_215' => 215,
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
	OP01_NAMED_QW => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_PAREN => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			"package" => -20,
			'SHEBANG' => 9
		},
		GOTOS => {
			'Program' => 5,
			'CompileUnit' => 6,
			'OPTIONAL-9' => 7,
			'PLUS-2' => 3,
			'ModuleHeader' => 1,
			'Critic' => 4,
			'PAREN-1' => 8
		}
	},
	{#State 1
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 13,
			"## no critic qw(" => -25,
			"use" => -25
		},
		GOTOS => {
			'Package' => 11,
			'STAR-10' => 10,
			'Module' => 12,
			'Class' => 14
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-14' => 15
		}
	},
	{#State 3
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 4,
			'PAREN-1' => 17,
			'OPTIONAL-9' => 7,
			'ModuleHeader' => 1
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		ACTIONS => {
			'' => 18
		}
	},
	{#State 7
		ACTIONS => {
			"package" => 19
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 21
		}
	},
	{#State 10
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 23,
			'STAR-11' => 22
		}
	},
	{#State 11
		DEFAULT => -22
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 16
		DEFAULT => -35
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 29
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
			"use" => 33,
			"use constant" => -29,
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
		DEFAULT => -208
	},
	{#State 25
		DEFAULT => -207
	},
	{#State 26
		ACTIONS => {
			")" => 35
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
			";" => 36
		}
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
			"use constant" => 42,
			"our" => 40
		},
		GOTOS => {
			'Constant' => 39,
			'Subroutine' => 41,
			'PLUS-13' => 43
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 24
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
			"if (" => -11,
			"for my integer" => -11,
			"my" => -11,
			"undef" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			"while (" => -11,
			'VARIABLE_SYMBOL' => -11,
			"## no critic qw(" => 2,
			"use" => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD_SCOPED' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP05_MATH_NEG' => -11,
			'WORD' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"[" => -11,
			"%{" => -11,
			"(" => -11,
			"foreach my" => -11,
			"\@{" => -11,
			"{" => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 48
		}
	},
	{#State 39
		DEFAULT => -28
	},
	{#State 40
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 50
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'WORD' => 52
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 40,
			"1;" => 54
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 44
		ACTIONS => {
			"qw(" => 56,
			";" => 55
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
		ACTIONS => {
			"\@{" => -13,
			"foreach my" => -13,
			"{" => -13,
			'WORD' => -13,
			'OP05_MATH_NEG' => -13,
			"(" => -13,
			"%{" => -13,
			"[" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP01_NAMED_VOID' => -13,
			"while (" => -13,
			"use" => 33,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"my" => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED' => -13,
			"if (" => -13,
			"for my integer" => -13
		},
		GOTOS => {
			'STAR-6' => 59,
			'Include' => 60
		}
	},
	{#State 49
		DEFAULT => -8
	},
	{#State 50
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61
		}
	},
	{#State 51
		DEFAULT => -212
	},
	{#State 52
		ACTIONS => {
			'OP20_HASH_FATARROW' => 62
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			"1;" => 63
		}
	},
	{#State 55
		DEFAULT => -39
	},
	{#State 56
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 65
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
			'OP01_NAMED' => -15,
			'OP10_NAMED_UNARY' => -15,
			"my" => -15,
			"undef" => -15,
			'LITERAL_NUMBER' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"use constant" => 42,
			'OP01_NAMED_VOID_PAREN' => -15,
			"for my integer" => -15,
			"if (" => -15,
			"(" => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"[" => -15,
			'WORD' => -15,
			'OP05_MATH_NEG' => -15,
			"{" => -15,
			"\@{" => -15,
			"foreach my" => -15,
			'VARIABLE_SYMBOL' => -15,
			"while (" => -15,
			'WORD_SCOPED' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP01_NAMED_VOID' => -15,
			"our" => -15,
			'LITERAL_STRING' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 68
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
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 72
		}
	},
	{#State 63
		DEFAULT => -32
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
			"## no critic qw(" => 2,
			"use" => -60,
			"our %properties = (" => -60,
			"use constant" => -60
		},
		GOTOS => {
			'STAR-24' => 75,
			'Critic' => 76
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'OP01_NAMED' => 112,
			"my" => 115,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_NUMBER' => 94,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED_VOID_PAREN' => 96,
			"for my integer" => -148,
			"if (" => 111,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 84,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			"foreach my" => -148,
			'VARIABLE_SYMBOL' => 97,
			"while (" => -148,
			'OP01_NAMED_VOID' => 78,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101,
			"our" => 40
		},
		GOTOS => {
			'Statement' => 105,
			'WordScoped' => 82,
			'VariableModification' => 109,
			'Operator' => 110,
			'Expression' => 85,
			'HashReference' => 87,
			'OperatorVoid' => 108,
			'VariableDeclaration' => 107,
			'Operation' => 99,
			'OPTIONAL-45' => 98,
			'PLUS-8' => 80,
			'PAREN-44' => 100,
			'LoopLabel' => 113,
			'HashDereferenced' => 95,
			'Conditional' => 118,
			'Subroutine' => 92,
			'Literal' => 93,
			'Variable' => 88,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"( my" => 119,
			"for my integer" => -43,
			"if (" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			'OP01_NAMED' => -43,
			"undef" => -43,
			"my" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'WORD_SCOPED' => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'OP01_NAMED_VOID' => -43,
			'LITERAL_STRING' => -43,
			'VARIABLE_SYMBOL' => -43,
			"while (" => -43,
			"{" => -43,
			"foreach my" => -43,
			"\@{" => -43,
			"[" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"(" => -43,
			"%{" => -43,
			'OP05_MATH_NEG' => -43,
			'WORD' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 121,
			'OPTIONAL-16' => 120
		}
	},
	{#State 71
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 122
		}
	},
	{#State 72
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'Literal' => 123
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			";" => 124
		}
	},
	{#State 75
		ACTIONS => {
			"use constant" => -62,
			"our %properties = (" => -62,
			"use" => 33
		},
		GOTOS => {
			'STAR-25' => 125,
			'Include' => 126
		}
	},
	{#State 76
		DEFAULT => -57
	},
	{#State 77
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"\@{" => 86,
			"{" => 106,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 128,
			'HashReference' => 87,
			'Literal' => 93,
			'WordScoped' => 82
		}
	},
	{#State 78
		ACTIONS => {
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"{*" => 132,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'KEYS_OR_VALUES' => 130,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			";" => -120,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"my" => 138,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED_QW' => 136
		},
		GOTOS => {
			'Literal' => 93,
			'OPTIONAL-40' => 134,
			'Operator' => 110,
			'ListElements' => 137,
			'Expression' => 131,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'WordScoped' => 82,
			'FileHandle' => 133,
			'ArrayDereferenced' => 90,
			'ListElement' => 135,
			'TypeInner' => 129,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 79
		ACTIONS => {
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90,
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'Expression' => 139,
			'Operator' => 110,
			'HashReference' => 87,
			'Literal' => 93
		}
	},
	{#State 80
		ACTIONS => {
			"if (" => 111,
			"for my integer" => -148,
			'OP01_NAMED_VOID_PAREN' => 96,
			'LITERAL_NUMBER' => 94,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			"my" => 115,
			'' => -18,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP01_NAMED_VOID' => 78,
			"while (" => -148,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"foreach my" => -148,
			"{" => 106,
			'WORD' => 84,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'VariableDeclaration' => 107,
			'OperatorVoid' => 108,
			'Expression' => 85,
			'HashReference' => 87,
			'Operator' => 110,
			'VariableModification' => 109,
			'Statement' => 105,
			'WordScoped' => 82,
			'PAREN-44' => 100,
			'OPTIONAL-45' => 98,
			'Operation' => 140,
			'Literal' => 93,
			'Conditional' => 118,
			'HashDereferenced' => 95,
			'LoopLabel' => 113,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 88
		}
	},
	{#State 81
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'KEYS_OR_VALUES' => 130,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"]" => -191,
			'OP01_NAMED_QW' => 136,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED' => 112,
			"undef" => 116,
			"my" => 71,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'OPTIONAL-55' => 141,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 131,
			'ListElements' => 142,
			'HashReference' => 87,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'TypeInner' => 129,
			'ListElement' => 135,
			'Variable' => 127,
			'ArrayReference' => 89
		}
	},
	{#State 82
		ACTIONS => {
			"(" => 143
		}
	},
	{#State 83
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81
		},
		GOTOS => {
			'Expression' => 144,
			'Operator' => 110,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 84
		ACTIONS => {
			"(" => -207,
			'COLON' => -213
		}
	},
	{#State 85
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 148,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			";" => 153,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160
		}
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			"[" => 81
		},
		GOTOS => {
			'ArrayReference' => 163,
			'Variable' => 162
		}
	},
	{#State 87
		DEFAULT => -137
	},
	{#State 88
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 167,
			'OP19_VARIABLE_ASSIGN' => 165,
			'OP08_MATH_ADD_SUB' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP04_MATH_POW' => -134,
			'OP19_VARIABLE_ASSIGN_BY' => 166,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP08_STRING_CAT' => -134,
			'OP16_LOGICAL_OR' => -134,
			";" => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP02_METHOD_THINARROW' => 164,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP18_TERNARY' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP12_COMPARE_EQ_NEQ' => -134
		}
	},
	{#State 89
		DEFAULT => -135
	},
	{#State 90
		DEFAULT => -136
	},
	{#State 91
		ACTIONS => {
			'WORD' => 169
		},
		GOTOS => {
			'LoopLabel' => 168
		}
	},
	{#State 92
		DEFAULT => -14
	},
	{#State 93
		DEFAULT => -133
	},
	{#State 94
		DEFAULT => -215
	},
	{#State 95
		DEFAULT => -138
	},
	{#State 96
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			"my" => 138,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			")" => -116,
			'OP01_NAMED_QW' => 136,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			"{*" => 132,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 130,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'WordScoped' => 82,
			'OPTIONAL-38' => 172,
			'HashDereferenced' => 95,
			'Expression' => 131,
			'HashReference' => 87,
			'ListElements' => 171,
			'Operator' => 110,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'TypeInner' => 129,
			'ListElement' => 135,
			'FileHandle' => 170,
			'ArrayDereferenced' => 90
		}
	},
	{#State 97
		DEFAULT => -171,
		GOTOS => {
			'STAR-51' => 173
		}
	},
	{#State 98
		ACTIONS => {
			"while (" => 179,
			"for my integer" => 178,
			"foreach my" => 174
		},
		GOTOS => {
			'LoopFor' => 175,
			'LoopWhile' => 180,
			'Loop' => 176,
			'LoopForEach' => 177
		}
	},
	{#State 99
		DEFAULT => -17
	},
	{#State 100
		DEFAULT => -147
	},
	{#State 101
		DEFAULT => -214
	},
	{#State 102
		ACTIONS => {
			"%{" => 103,
			"(" => 104,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'Expression' => 181,
			'HashReference' => 87,
			'Operator' => 110,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			"{" => 184
		},
		GOTOS => {
			'HashReference' => 182,
			'Variable' => 183
		}
	},
	{#State 104
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"{" => 106,
			"\@{" => 86,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Literal' => 93,
			'HashDereferenced' => 95,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 185,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89
		}
	},
	{#State 105
		DEFAULT => -88
	},
	{#State 106
		ACTIONS => {
			"}" => 188,
			"%{" => 103,
			'WORD' => 189
		},
		GOTOS => {
			'HashEntry' => 186,
			'HashDereferenced' => 187
		}
	},
	{#State 107
		DEFAULT => -152
	},
	{#State 108
		DEFAULT => -151
	},
	{#State 109
		DEFAULT => -153
	},
	{#State 110
		DEFAULT => -140
	},
	{#State 111
		ACTIONS => {
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 190,
			'WordScoped' => 82
		}
	},
	{#State 112
		ACTIONS => {
			"(" => 191
		}
	},
	{#State 113
		ACTIONS => {
			'COLON' => 192
		}
	},
	{#State 114
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 193,
			'HashReference' => 87,
			'WordScoped' => 82
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 194
		}
	},
	{#State 116
		DEFAULT => -132
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Variable' => 195
		}
	},
	{#State 118
		DEFAULT => -149
	},
	{#State 119
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 120
		ACTIONS => {
			"if (" => 111,
			"for my integer" => -148,
			'OP01_NAMED_VOID_PAREN' => 96,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"undef" => 116,
			"my" => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_NAMED_VOID' => 78,
			'WORD_SCOPED' => 24,
			"while (" => -148,
			'VARIABLE_SYMBOL' => 97,
			"foreach my" => -148,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 84,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 88,
			'Conditional' => 118,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'LoopLabel' => 113,
			'PAREN-44' => 100,
			'PLUS-17' => 197,
			'Operation' => 198,
			'OPTIONAL-45' => 98,
			'Operator' => 110,
			'Expression' => 85,
			'HashReference' => 87,
			'VariableModification' => 109,
			'VariableDeclaration' => 107,
			'OperatorVoid' => 108,
			'Statement' => 105,
			'WordScoped' => 82
		}
	},
	{#State 121
		DEFAULT => -42
	},
	{#State 122
		ACTIONS => {
			"\$TYPED_" => 199
		}
	},
	{#State 123
		ACTIONS => {
			";" => 200
		}
	},
	{#State 124
		DEFAULT => -40
	},
	{#State 125
		ACTIONS => {
			"our %properties = (" => 201,
			"use constant" => 42
		},
		GOTOS => {
			'Constant' => 202,
			'Properties' => 203
		}
	},
	{#State 126
		DEFAULT => -59
	},
	{#State 127
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP02_METHOD_THINARROW' => 164,
			";" => -134,
			"}" => -134,
			'OP17_LIST_RANGE' => -134,
			'OP12_COMPARE_EQ_NEQ' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			".." => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP18_TERNARY' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP08_STRING_CAT' => -134,
			'OP16_LOGICAL_OR' => -134,
			"]" => -134,
			")" => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP04_MATH_POW' => -134,
			'OP21_LIST_COMMA' => -134,
			'OP03_MATH_INC_DEC' => 167,
			'OP08_MATH_ADD_SUB' => -134
		}
	},
	{#State 128
		ACTIONS => {
			")" => -103,
			'OP06_REGEX_MATCH' => 146,
			"]" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP08_MATH_ADD_SUB' => 148,
			";" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			"}" => -103,
			'OP13_BITWISE_AND' => -103,
			'OP09_BITWISE_SHIFT' => 150,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP18_TERNARY' => -103,
			".." => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -103
		}
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"{" => 106,
			"\@{" => 86,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'WordScoped' => 82,
			'Expression' => 204,
			'HashReference' => 87,
			'Operator' => 110,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 130
		ACTIONS => {
			"%{" => 103
		},
		GOTOS => {
			'HashDereferenced' => 205
		}
	},
	{#State 131
		ACTIONS => {
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			";" => -187,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP06_REGEX_MATCH' => 146,
			")" => -187,
			"]" => -187,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -187
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 206
		}
	},
	{#State 133
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 130,
			";" => -122,
			'LITERAL_STRING' => 101,
			'OP01_NAMED' => 112,
			"undef" => 116,
			"my" => 71,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_QW' => 136
		},
		GOTOS => {
			'HashReference' => 87,
			'Expression' => 131,
			'Operator' => 110,
			'ListElements' => 208,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82,
			'OPTIONAL-41' => 207,
			'ListElement' => 135,
			'TypeInner' => 129,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 134
		ACTIONS => {
			";" => 209
		}
	},
	{#State 135
		DEFAULT => -182,
		GOTOS => {
			'STAR-53' => 210
		}
	},
	{#State 136
		ACTIONS => {
			"(" => 211
		}
	},
	{#State 137
		DEFAULT => -119
	},
	{#State 138
		ACTIONS => {
			'WORD' => 51,
			"filehandle_ref" => 212
		},
		GOTOS => {
			'Type' => 122
		}
	},
	{#State 139
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154,
			";" => -112,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => -112,
			"}" => -112,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP18_TERNARY' => 151,
			".." => -112,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP21_LIST_COMMA' => -112,
			'OP08_MATH_ADD_SUB' => 148,
			")" => -112,
			'OP06_REGEX_MATCH' => 146,
			"]" => -112,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -112
		}
	},
	{#State 140
		DEFAULT => -16
	},
	{#State 141
		ACTIONS => {
			"]" => 213
		}
	},
	{#State 142
		DEFAULT => -190
	},
	{#State 143
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"undef" => 116,
			"my" => 71,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			")" => -129,
			'OP01_NAMED_QW' => 136,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ListElement' => 135,
			'TypeInner' => 129,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Literal' => 93,
			'ListElements' => 215,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 131,
			'HashDereferenced' => 95,
			'OPTIONAL-42' => 214,
			'WordScoped' => 82
		}
	},
	{#State 144
		ACTIONS => {
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154,
			'OP06_REGEX_MATCH' => 146,
			")" => 216,
			'OP15_LOGICAL_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP08_MATH_ADD_SUB' => 148
		}
	},
	{#State 145
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'WordScoped' => 82,
			'Literal' => 93,
			'Operator' => 110,
			'Expression' => 217,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 146
		ACTIONS => {
			"/" => 218
		}
	},
	{#State 147
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Expression' => 219,
			'Operator' => 110,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 220,
			'WordScoped' => 82
		}
	},
	{#State 149
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"\@{" => 86,
			"{" => 106,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 221,
			'Literal' => 93,
			'WordScoped' => 82
		}
	},
	{#State 150
		ACTIONS => {
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86
		},
		GOTOS => {
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Expression' => 222,
			'Operator' => 110,
			'HashReference' => 87,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89
		}
	},
	{#State 151
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Variable' => 223
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Literal' => 93,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 224,
			'HashDereferenced' => 95,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 153
		DEFAULT => -87
	},
	{#State 154
		ACTIONS => {
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 225,
			'WordScoped' => 82
		}
	},
	{#State 155
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"{" => 106,
			"\@{" => 86,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'WordScoped' => 82,
			'Expression' => 226,
			'Operator' => 110,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 156
		ACTIONS => {
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 103,
			"(" => 104,
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'VARIABLE_SYMBOL' => 97,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP01_NAMED' => 112
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashReference' => 87,
			'Expression' => 227,
			'Operator' => 110,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90,
			'WordScoped' => 82,
			'Literal' => 93,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 228,
			'HashDereferenced' => 95
		}
	},
	{#State 158
		ACTIONS => {
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'WordScoped' => 82,
			'Operator' => 110,
			'Expression' => 229,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 159
		ACTIONS => {
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103,
			"\@{" => 86,
			"{" => 106
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Literal' => 93,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 230,
			'HashDereferenced' => 95,
			'WordScoped' => 82
		}
	},
	{#State 160
		ACTIONS => {
			"%{" => 103,
			"(" => 104,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 231,
			'HashReference' => 87,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89
		}
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"\@{" => 86,
			"{" => 106,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'WordScoped' => 82,
			'Operator' => 110,
			'Expression' => 232,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 162
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 163
		ACTIONS => {
			"}" => 234
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 235
		}
	},
	{#State 165
		ACTIONS => {
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"<STDIN>" => 237,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 103,
			"(" => 104,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ExpressionOrStdin' => 238,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Literal' => 93,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 236,
			'HashDereferenced' => 95,
			'WordScoped' => 82
		}
	},
	{#State 166
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'HashReference' => 87,
			'Expression' => 239,
			'Operator' => 110,
			'Literal' => 93,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89
		}
	},
	{#State 167
		DEFAULT => -93
	},
	{#State 168
		ACTIONS => {
			";" => 240
		}
	},
	{#State 169
		DEFAULT => -213
	},
	{#State 170
		ACTIONS => {
			"undef" => 116,
			"my" => 71,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED_QW' => 136,
			")" => -118,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'KEYS_OR_VALUES' => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79
		},
		GOTOS => {
			'Variable' => 127,
			'ArrayReference' => 89,
			'TypeInner' => 129,
			'ListElement' => 135,
			'ArrayDereferenced' => 90,
			'WordScoped' => 82,
			'OPTIONAL-39' => 241,
			'HashDereferenced' => 95,
			'HashReference' => 87,
			'Operator' => 110,
			'ListElements' => 242,
			'Expression' => 131,
			'Literal' => 93
		}
	},
	{#State 171
		DEFAULT => -115
	},
	{#State 172
		ACTIONS => {
			")" => 243
		}
	},
	{#State 173
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -172,
			'OP08_STRING_CAT' => -172,
			'OP16_LOGICAL_OR' => -172,
			'OP23_LOGICAL_AND' => -172,
			'OP11_COMPARE_LT_GT' => -172,
			'OP02_METHOD_THINARROW' => -172,
			";" => -172,
			"}" => -172,
			'OP17_LIST_RANGE' => -172,
			'OP12_COMPARE_EQ_NEQ' => -172,
			'OP13_BITWISE_AND' => -172,
			'OP09_BITWISE_SHIFT' => -172,
			'OP18_TERNARY' => -172,
			".." => -172,
			'OP14_BITWISE_OR_XOR' => -172,
			'OP21_LIST_COMMA' => -172,
			'OP19_VARIABLE_ASSIGN' => -172,
			'OP03_MATH_INC_DEC' => -172,
			'OP08_MATH_ADD_SUB' => -172,
			'OP02_HASH_THINARROW' => 246,
			"]" => -172,
			'COLON' => -172,
			'OP06_REGEX_MATCH' => -172,
			")" => -172,
			'OP15_LOGICAL_AND' => -172,
			'OP02_ARRAY_THINARROW' => 245,
			'OP19_VARIABLE_ASSIGN_BY' => -172,
			'OP24_LOGICAL_OR_XOR' => -172,
			'OP04_MATH_POW' => -172
		},
		GOTOS => {
			'VariableRetrieval' => 244
		}
	},
	{#State 174
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 247
		}
	},
	{#State 175
		DEFAULT => -161
	},
	{#State 176
		DEFAULT => -150
	},
	{#State 177
		DEFAULT => -162
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 248
		}
	},
	{#State 179
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 249,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 180
		DEFAULT => -163
	},
	{#State 181
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP08_STRING_CAT' => -95,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP23_LOGICAL_AND' => -95,
			"}" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP18_TERNARY' => -95,
			".." => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			")" => -95,
			'OP06_REGEX_MATCH' => -95,
			"]" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -95
		}
	},
	{#State 182
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 183
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 184
		ACTIONS => {
			"%{" => 103,
			'WORD' => 189
		},
		GOTOS => {
			'HashDereferenced' => 187,
			'HashEntry' => 186
		}
	},
	{#State 185
		ACTIONS => {
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP08_MATH_ADD_SUB' => 148,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			")" => 252,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147
		}
	},
	{#State 186
		DEFAULT => -203,
		GOTOS => {
			'STAR-58' => 253
		}
	},
	{#State 187
		DEFAULT => -198
	},
	{#State 188
		DEFAULT => -139
	},
	{#State 189
		ACTIONS => {
			'OP20_HASH_FATARROW' => 254
		}
	},
	{#State 190
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 148,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			")" => 255,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => 154,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149
		}
	},
	{#State 191
		ACTIONS => {
			")" => -90,
			'OP01_NAMED_QW' => 136,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"my" => 71,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'KEYS_OR_VALUES' => 130,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'WordScoped' => 82,
			'OPTIONAL-37' => 256,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'ListElements' => 257,
			'Expression' => 131,
			'HashReference' => 87,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'TypeInner' => 129,
			'ListElement' => 135,
			'ArrayDereferenced' => 90
		}
	},
	{#State 192
		DEFAULT => -146
	},
	{#State 193
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP08_MATH_ADD_SUB' => 148,
			"]" => -102,
			")" => -102,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP04_MATH_POW' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP23_LOGICAL_AND' => -102,
			";" => -102,
			"}" => -102,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP09_BITWISE_SHIFT' => 150,
			".." => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP18_TERNARY' => -102
		}
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 258
		}
	},
	{#State 195
		DEFAULT => -92
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 259
		}
	},
	{#State 197
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP19_LOOP_CONTROL' => 91,
			'OP01_NAMED_VOID_PAREN' => 96,
			'OP01_NAMED' => 112,
			"my" => 115,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			"for my integer" => -148,
			"if (" => 111,
			"{" => 106,
			"\@{" => 86,
			"foreach my" => -148,
			"%{" => 103,
			"(" => 104,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'WORD' => 84,
			'OP05_MATH_NEG' => 83,
			"}" => 261,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID' => 78,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"while (" => -148
		},
		GOTOS => {
			'OPTIONAL-45' => 98,
			'Operation' => 260,
			'PAREN-44' => 100,
			'Statement' => 105,
			'WordScoped' => 82,
			'OperatorVoid' => 108,
			'VariableDeclaration' => 107,
			'HashReference' => 87,
			'Expression' => 85,
			'Operator' => 110,
			'VariableModification' => 109,
			'ArrayReference' => 89,
			'Variable' => 88,
			'ArrayDereferenced' => 90,
			'LoopLabel' => 113,
			'Literal' => 93,
			'Conditional' => 118,
			'HashDereferenced' => 95
		}
	},
	{#State 198
		DEFAULT => -45
	},
	{#State 199
		ACTIONS => {
			'WORD' => 262
		}
	},
	{#State 200
		DEFAULT => -41
	},
	{#State 201
		ACTIONS => {
			")" => 264,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 263
		}
	},
	{#State 202
		DEFAULT => -61
	},
	{#State 203
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 265
		}
	},
	{#State 204
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154,
			";" => -188,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP21_LIST_COMMA' => -188,
			'OP08_MATH_ADD_SUB' => 148,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			")" => -188,
			"]" => -188,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156
		}
	},
	{#State 205
		DEFAULT => -189
	},
	{#State 206
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 207
		ACTIONS => {
			";" => 267
		}
	},
	{#State 208
		DEFAULT => -121
	},
	{#State 209
		DEFAULT => -125
	},
	{#State 210
		ACTIONS => {
			'OP21_LIST_COMMA' => 268,
			"]" => -185,
			")" => -185,
			";" => -185
		},
		GOTOS => {
			'PAREN-52' => 269
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 271
		},
		GOTOS => {
			'PLUS-54' => 270
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 272
		}
	},
	{#State 213
		DEFAULT => -192
	},
	{#State 214
		ACTIONS => {
			")" => 273
		}
	},
	{#State 215
		DEFAULT => -128
	},
	{#State 216
		DEFAULT => -96
	},
	{#State 217
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP04_MATH_POW' => 145,
			"]" => -94,
			'OP06_REGEX_MATCH' => -94,
			")" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP12_COMPARE_EQ_NEQ' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP13_BITWISE_AND' => -94,
			".." => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP23_LOGICAL_AND' => -94,
			";" => -94,
			"}" => -94
		}
	},
	{#State 218
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 274
		}
	},
	{#State 219
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -108,
			";" => -108,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => -108,
			"}" => -108,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => -108,
			'OP18_TERNARY' => -108,
			".." => -108,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP21_LIST_COMMA' => -108,
			'OP08_MATH_ADD_SUB' => 148,
			")" => -108,
			'OP06_REGEX_MATCH' => 146,
			"]" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -108
		}
	},
	{#State 220
		ACTIONS => {
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			")" => -99,
			'OP06_REGEX_MATCH' => 146,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			".." => -99,
			'OP18_TERNARY' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			"}" => -99,
			";" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_STRING_CAT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 221
		ACTIONS => {
			"]" => -105,
			")" => -105,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -105,
			'OP08_MATH_ADD_SUB' => 148,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => 159,
			";" => -105,
			"}" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => -105,
			".." => -105,
			'OP18_TERNARY' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 222
		ACTIONS => {
			"]" => -101,
			")" => -101,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -101,
			'OP08_MATH_ADD_SUB' => 148,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			";" => -101,
			"}" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101,
			".." => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 223
		ACTIONS => {
			'COLON' => 275
		}
	},
	{#State 224
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP04_MATH_POW' => 145,
			'OP15_LOGICAL_AND' => -107,
			"]" => -107,
			")" => -107,
			'OP06_REGEX_MATCH' => 146,
			'OP16_LOGICAL_OR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP14_BITWISE_OR_XOR' => -107,
			".." => -107,
			'OP18_TERNARY' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			"}" => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 159,
			";" => -107
		}
	},
	{#State 225
		ACTIONS => {
			")" => -109,
			'OP06_REGEX_MATCH' => 146,
			"]" => -109,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP08_MATH_ADD_SUB' => 148,
			";" => -109,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => -109,
			".." => -109,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => -109
		}
	},
	{#State 226
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			".." => -98,
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			";" => -98,
			"}" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => -98,
			'OP07_MATH_MULT_DIV_MOD' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP04_MATH_POW' => 145,
			"]" => -98,
			'OP06_REGEX_MATCH' => 146,
			")" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => -98,
			'OP21_LIST_COMMA' => -98
		}
	},
	{#State 227
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -114,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP15_LOGICAL_AND' => 147,
			")" => -114,
			'OP06_REGEX_MATCH' => 146,
			"]" => -114,
			'OP16_LOGICAL_OR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP18_TERNARY' => 151,
			".." => -114,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			"}" => -114,
			";" => -114,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160
		}
	},
	{#State 228
		ACTIONS => {
			"}" => -110,
			";" => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP11_COMPARE_LT_GT' => 159,
			".." => -110,
			'OP18_TERNARY' => -110,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => 154,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			")" => -110,
			"]" => -110,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP08_MATH_ADD_SUB' => 148
		}
	},
	{#State 229
		ACTIONS => {
			"]" => -106,
			")" => -106,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -106,
			'OP08_MATH_ADD_SUB' => 148,
			'OP23_LOGICAL_AND' => -106,
			'OP11_COMPARE_LT_GT' => 159,
			";" => -106,
			"}" => -106,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => -106,
			".." => -106,
			'OP18_TERNARY' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -106
		}
	},
	{#State 230
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP04_MATH_POW' => 145,
			"]" => -104,
			'OP06_REGEX_MATCH' => 146,
			")" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => -104,
			'OP18_TERNARY' => -104,
			".." => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -104,
			";" => -104,
			"}" => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161
		}
	},
	{#State 231
		ACTIONS => {
			"]" => -113,
			")" => -113,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -113,
			'OP08_MATH_ADD_SUB' => 148,
			'OP23_LOGICAL_AND' => -113,
			'OP11_COMPARE_LT_GT' => 159,
			";" => -113,
			"}" => -113,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP14_BITWISE_OR_XOR' => 152,
			".." => -113,
			'OP18_TERNARY' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => 154
		}
	},
	{#State 232
		ACTIONS => {
			"]" => -100,
			")" => -100,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => 145,
			'OP21_LIST_COMMA' => -100,
			'OP08_MATH_ADD_SUB' => 148,
			'OP11_COMPARE_LT_GT' => -100,
			'OP23_LOGICAL_AND' => -100,
			";" => -100,
			"}" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP13_BITWISE_AND' => -100,
			".." => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_STRING_CAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 233
		DEFAULT => -193
	},
	{#State 234
		DEFAULT => -194
	},
	{#State 235
		ACTIONS => {
			"(" => 276
		}
	},
	{#State 236
		ACTIONS => {
			'OP16_LOGICAL_OR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			";" => -144,
			'OP08_MATH_ADD_SUB' => 148,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147
		}
	},
	{#State 237
		DEFAULT => -145
	},
	{#State 238
		ACTIONS => {
			";" => 277
		}
	},
	{#State 239
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP16_LOGICAL_OR' => 154,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			";" => 278,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP08_MATH_ADD_SUB' => 148,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145
		}
	},
	{#State 240
		DEFAULT => -127
	},
	{#State 241
		ACTIONS => {
			")" => 279
		}
	},
	{#State 242
		DEFAULT => -117
	},
	{#State 243
		ACTIONS => {
			";" => 280
		}
	},
	{#State 244
		DEFAULT => -170
	},
	{#State 245
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97,
			"{" => 106,
			"\@{" => 86,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 103,
			"(" => 104,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'Operator' => 110,
			'Expression' => 281,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 246
		ACTIONS => {
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 282,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90,
			'WordScoped' => 82,
			'Literal' => 93,
			'Operator' => 110,
			'Expression' => 283,
			'HashReference' => 87,
			'HashDereferenced' => 95
		}
	},
	{#State 247
		ACTIONS => {
			'VARIABLE_SYMBOL' => 284
		}
	},
	{#State 248
		ACTIONS => {
			"(" => 285
		}
	},
	{#State 249
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP08_MATH_ADD_SUB' => 148,
			'OP06_REGEX_MATCH' => 146,
			")" => 286,
			'OP15_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156
		}
	},
	{#State 250
		DEFAULT => -206
	},
	{#State 251
		DEFAULT => -205
	},
	{#State 252
		DEFAULT => -143
	},
	{#State 253
		ACTIONS => {
			"}" => 287,
			'OP21_LIST_COMMA' => 289
		},
		GOTOS => {
			'PAREN-57' => 288
		}
	},
	{#State 254
		ACTIONS => {
			"\@{" => -196,
			"{" => -196,
			'WORD' => -196,
			'OP05_MATH_NEG' => -196,
			"%{" => -196,
			"(" => -196,
			"[" => -196,
			'OP05_LOGICAL_NEG' => -196,
			'LITERAL_STRING' => -196,
			'WORD_SCOPED' => -196,
			'OP22_LOGICAL_NOT' => -196,
			'OP10_NAMED_UNARY_STRINGIFY' => -196,
			'VARIABLE_SYMBOL' => -196,
			'LITERAL_NUMBER' => -196,
			'OP03_MATH_INC_DEC' => -196,
			'OP10_NAMED_UNARY' => -196,
			"my" => 71,
			"undef" => -196,
			'OP01_NAMED' => -196
		},
		GOTOS => {
			'OPTIONAL-56' => 291,
			'TypeInner' => 290
		}
	},
	{#State 255
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 293
		}
	},
	{#State 256
		ACTIONS => {
			")" => 294
		}
	},
	{#State 257
		DEFAULT => -89
	},
	{#State 258
		ACTIONS => {
			";" => 296,
			'OP19_VARIABLE_ASSIGN' => 295
		}
	},
	{#State 259
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 297
		}
	},
	{#State 260
		DEFAULT => -44
	},
	{#State 261
		ACTIONS => {
			";" => 298
		}
	},
	{#State 262
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 263
		ACTIONS => {
			'WORD' => 302,
			"%{" => 103
		},
		GOTOS => {
			'HashDereferenced' => 300,
			'HashEntryTyped' => 301
		}
	},
	{#State 264
		ACTIONS => {
			";" => 303
		}
	},
	{#State 265
		ACTIONS => {
			"our" => 304,
			"1;" => 306
		},
		GOTOS => {
			'Method' => 305
		}
	},
	{#State 266
		DEFAULT => -209
	},
	{#State 267
		DEFAULT => -126
	},
	{#State 268
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY' => 114,
			"my" => 71,
			"undef" => 116,
			"{" => 106,
			"\@{" => 86,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'KEYS_OR_VALUES' => 130,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Expression' => 131,
			'Operator' => 110,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82,
			'ListElement' => 307,
			'TypeInner' => 129,
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127
		}
	},
	{#State 269
		DEFAULT => -181
	},
	{#State 270
		ACTIONS => {
			")" => 309,
			'WORD' => 308
		}
	},
	{#State 271
		DEFAULT => -184
	},
	{#State 272
		DEFAULT => -210
	},
	{#State 273
		DEFAULT => -141
	},
	{#State 274
		ACTIONS => {
			"/" => 310
		}
	},
	{#State 275
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Variable' => 311
		}
	},
	{#State 276
		ACTIONS => {
			")" => -131,
			'OP01_NAMED_QW' => 136,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			"undef" => 116,
			"my" => 71,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24,
			'KEYS_OR_VALUES' => 130,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81
		},
		GOTOS => {
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90,
			'ListElement' => 135,
			'TypeInner' => 129,
			'WordScoped' => 82,
			'Literal' => 93,
			'OPTIONAL-43' => 313,
			'Operator' => 110,
			'ListElements' => 312,
			'Expression' => 131,
			'HashReference' => 87,
			'HashDereferenced' => 95
		}
	},
	{#State 277
		DEFAULT => -178
	},
	{#State 278
		DEFAULT => -179
	},
	{#State 279
		ACTIONS => {
			";" => 314
		}
	},
	{#State 280
		DEFAULT => -123
	},
	{#State 281
		ACTIONS => {
			'OP15_LOGICAL_AND' => 147,
			"]" => 315,
			'OP06_REGEX_MATCH' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP08_MATH_ADD_SUB' => 148,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154
		}
	},
	{#State 282
		ACTIONS => {
			"}" => 316,
			"(" => -207
		}
	},
	{#State 283
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			"}" => 317,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 284
		ACTIONS => {
			"(" => 318
		}
	},
	{#State 285
		ACTIONS => {
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 319,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82
		}
	},
	{#State 286
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 320
		}
	},
	{#State 287
		DEFAULT => -204
	},
	{#State 288
		DEFAULT => -202
	},
	{#State 289
		ACTIONS => {
			"%{" => 103,
			'WORD' => 189
		},
		GOTOS => {
			'HashEntry' => 321,
			'HashDereferenced' => 187
		}
	},
	{#State 290
		DEFAULT => -195
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			"{" => 106,
			"\@{" => 86,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'LITERAL_STRING' => 101,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashReference' => 87,
			'Expression' => 322,
			'Operator' => 110,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90
		}
	},
	{#State 292
		ACTIONS => {
			"if (" => 111,
			"for my integer" => -148,
			'OP10_NAMED_UNARY' => 114,
			"my" => 115,
			"undef" => 116,
			'OP01_NAMED' => 112,
			'OP01_NAMED_VOID_PAREN' => 96,
			'LITERAL_NUMBER' => 94,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			"while (" => -148,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP01_NAMED_VOID' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'WORD' => 84,
			'OP05_MATH_NEG' => 83,
			"%{" => 103,
			"(" => 104,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"\@{" => 86,
			"foreach my" => -148,
			"{" => 106
		},
		GOTOS => {
			'PLUS-50' => 324,
			'Variable' => 88,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90,
			'LoopLabel' => 113,
			'HashDereferenced' => 95,
			'Conditional' => 118,
			'Literal' => 93,
			'Operation' => 323,
			'OPTIONAL-45' => 98,
			'PAREN-44' => 100,
			'Statement' => 105,
			'WordScoped' => 82,
			'VariableModification' => 109,
			'Operator' => 110,
			'HashReference' => 87,
			'Expression' => 85,
			'OperatorVoid' => 108,
			'VariableDeclaration' => 107
		}
	},
	{#State 293
		DEFAULT => -156,
		GOTOS => {
			'STAR-47' => 325
		}
	},
	{#State 294
		DEFAULT => -91
	},
	{#State 295
		ACTIONS => {
			"<STDIN>" => 237,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"%{" => 103,
			"(" => 104,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"\@{" => 86,
			"{" => 106
		},
		GOTOS => {
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 236,
			'HashReference' => 87,
			'WordScoped' => 82,
			'ArrayDereferenced' => 90,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ExpressionOrStdin' => 326
		}
	},
	{#State 296
		DEFAULT => -176
	},
	{#State 297
		ACTIONS => {
			")" => 329,
			'OP21_LIST_COMMA' => 328
		},
		GOTOS => {
			'PAREN-18' => 327
		}
	},
	{#State 298
		DEFAULT => -46
	},
	{#State 299
		DEFAULT => -211
	},
	{#State 300
		DEFAULT => -200
	},
	{#State 301
		DEFAULT => -73,
		GOTOS => {
			'STAR-31' => 330
		}
	},
	{#State 302
		ACTIONS => {
			'OP20_HASH_FATARROW' => 331
		}
	},
	{#State 303
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 332
		}
	},
	{#State 304
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 305
		DEFAULT => -63
	},
	{#State 306
		ACTIONS => {
			"1;" => 334
		}
	},
	{#State 307
		DEFAULT => -180
	},
	{#State 308
		DEFAULT => -183
	},
	{#State 309
		DEFAULT => -186
	},
	{#State 310
		DEFAULT => -97
	},
	{#State 311
		DEFAULT => -111
	},
	{#State 312
		DEFAULT => -130
	},
	{#State 313
		ACTIONS => {
			")" => 335
		}
	},
	{#State 314
		DEFAULT => -124
	},
	{#State 315
		DEFAULT => -173
	},
	{#State 316
		DEFAULT => -175
	},
	{#State 317
		DEFAULT => -174
	},
	{#State 318
		ACTIONS => {
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 103,
			"(" => 104,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'KEYS_OR_VALUES' => 130,
			'WORD_SCOPED' => 24,
			"my" => 71,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_QW' => 136
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'HashReference' => 87,
			'Expression' => 131,
			'ListElements' => 336,
			'Operator' => 110,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'TypeInner' => 129,
			'ListElement' => 135,
			'ArrayDereferenced' => 90
		}
	},
	{#State 319
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP14_BITWISE_OR_XOR' => 152,
			".." => 337,
			'OP18_TERNARY' => 151,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148
		}
	},
	{#State 320
		DEFAULT => -166
	},
	{#State 321
		DEFAULT => -201
	},
	{#State 322
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -197,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			"}" => -197,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 323
		DEFAULT => -168
	},
	{#State 324
		ACTIONS => {
			"foreach my" => -148,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 84,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			"}" => 338,
			"while (" => -148,
			'VARIABLE_SYMBOL' => 97,
			'OP01_NAMED_VOID_PAREN' => 96,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			"my" => 115,
			'OP01_NAMED' => 112,
			"if (" => 111,
			"for my integer" => -148
		},
		GOTOS => {
			'VariableModification' => 109,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 85,
			'OperatorVoid' => 108,
			'VariableDeclaration' => 107,
			'WordScoped' => 82,
			'Statement' => 105,
			'PAREN-44' => 100,
			'Operation' => 339,
			'OPTIONAL-45' => 98,
			'HashDereferenced' => 95,
			'Conditional' => 118,
			'Literal' => 93,
			'LoopLabel' => 113,
			'ArrayDereferenced' => 90,
			'Variable' => 88,
			'ArrayReference' => 89
		}
	},
	{#State 325
		ACTIONS => {
			"else" => 342,
			'VARIABLE_SYMBOL' => -159,
			"elsif (" => 344,
			"while (" => -159,
			"}" => -159,
			'WORD_SCOPED' => -159,
			'OP10_NAMED_UNARY_STRINGIFY' => -159,
			'OP01_NAMED_VOID' => -159,
			'OP22_LOGICAL_NOT' => -159,
			'LITERAL_STRING' => -159,
			"%{" => -159,
			"(" => -159,
			"[" => -159,
			'OP05_LOGICAL_NEG' => -159,
			'WORD' => -159,
			'OP05_MATH_NEG' => -159,
			"{" => -159,
			"\@{" => -159,
			"foreach my" => -159,
			"for my integer" => -159,
			"if (" => -159,
			'OP01_NAMED' => -159,
			'' => -159,
			"my" => -159,
			'OP10_NAMED_UNARY' => -159,
			"undef" => -159,
			'LITERAL_NUMBER' => -159,
			'OP03_MATH_INC_DEC' => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP01_NAMED_VOID_PAREN' => -159
		},
		GOTOS => {
			'PAREN-48' => 343,
			'PAREN-46' => 341,
			'OPTIONAL-49' => 340
		}
	},
	{#State 326
		ACTIONS => {
			";" => 345
		}
	},
	{#State 327
		DEFAULT => -48
	},
	{#State 328
		ACTIONS => {
			"my" => 346
		}
	},
	{#State 329
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 347
		}
	},
	{#State 330
		ACTIONS => {
			'OP21_LIST_COMMA' => 348,
			")" => 350
		},
		GOTOS => {
			'PAREN-30' => 349
		}
	},
	{#State 331
		ACTIONS => {
			"my" => 71
		},
		GOTOS => {
			'TypeInner' => 351
		}
	},
	{#State 332
		DEFAULT => -75
	},
	{#State 333
		ACTIONS => {
			'VARIABLE_SYMBOL' => 352
		}
	},
	{#State 334
		ACTIONS => {
			"our" => 40,
			"## no critic qw(" => -69,
			'' => -69,
			"package" => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 356,
			'Subroutine' => 355,
			'PAREN-28' => 354,
			'PLUS-27' => 353
		}
	},
	{#State 335
		DEFAULT => -142
	},
	{#State 336
		ACTIONS => {
			")" => 357
		}
	},
	{#State 337
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"{" => 106,
			"\@{" => 86,
			'VARIABLE_SYMBOL' => 97,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'LITERAL_STRING' => 101,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'WordScoped' => 82,
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Expression' => 358,
			'Operator' => 110,
			'HashReference' => 87,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 338
		DEFAULT => -169
	},
	{#State 339
		DEFAULT => -167
	},
	{#State 340
		DEFAULT => -160
	},
	{#State 341
		DEFAULT => -155
	},
	{#State 342
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 359
		}
	},
	{#State 343
		DEFAULT => -158
	},
	{#State 344
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP03_MATH_INC_DEC' => 117,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP01_NAMED' => 112,
			"\@{" => 86,
			"{" => 106,
			'WORD' => 25,
			'OP05_MATH_NEG' => 83,
			"(" => 104,
			"%{" => 103,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127,
			'HashReference' => 87,
			'Operator' => 110,
			'Expression' => 360,
			'HashDereferenced' => 95,
			'Literal' => 93,
			'WordScoped' => 82
		}
	},
	{#State 345
		DEFAULT => -177
	},
	{#State 346
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 361
		}
	},
	{#State 347
		ACTIONS => {
			"\@_;" => 362
		}
	},
	{#State 348
		ACTIONS => {
			"%{" => 103,
			'WORD' => 302
		},
		GOTOS => {
			'HashDereferenced' => 300,
			'HashEntryTyped' => 363
		}
	},
	{#State 349
		DEFAULT => -72
	},
	{#State 350
		ACTIONS => {
			";" => 364
		}
	},
	{#State 351
		ACTIONS => {
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 102,
			"%{" => 103,
			"(" => 104,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'ArrayReference' => 89,
			'Variable' => 127,
			'Literal' => 93,
			'Expression' => 365,
			'Operator' => 110,
			'HashReference' => 87,
			'HashDereferenced' => 95,
			'WordScoped' => 82
		}
	},
	{#State 352
		ACTIONS => {
			"= sub {" => 366
		}
	},
	{#State 353
		ACTIONS => {
			"1;" => 367,
			"our" => 40
		},
		GOTOS => {
			'Subroutine' => 368
		}
	},
	{#State 354
		DEFAULT => -68
	},
	{#State 355
		DEFAULT => -66
	},
	{#State 356
		DEFAULT => -70
	},
	{#State 357
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 358
		ACTIONS => {
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP16_LOGICAL_OR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146,
			")" => 370,
			'OP08_MATH_ADD_SUB' => 148
		}
	},
	{#State 359
		DEFAULT => -157
	},
	{#State 360
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			")" => 371,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148
		}
	},
	{#State 361
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 362
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 373
		}
	},
	{#State 363
		DEFAULT => -71
	},
	{#State 364
		DEFAULT => -74
	},
	{#State 365
		ACTIONS => {
			'OP16_LOGICAL_OR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP08_STRING_CAT' => 161,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => -199,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP06_REGEX_MATCH' => 146,
			")" => -199,
			'OP15_LOGICAL_AND' => 147
		}
	},
	{#State 366
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -77,
			"[" => -77,
			"(" => -77,
			"%{" => -77,
			'OP05_MATH_NEG' => -77,
			'WORD' => -77,
			"{" => -77,
			"foreach my" => -77,
			"\@{" => -77,
			'VARIABLE_SYMBOL' => -77,
			"while (" => -77,
			'WORD_SCOPED' => -77,
			'OP22_LOGICAL_NOT' => -77,
			'OP10_NAMED_UNARY_STRINGIFY' => -77,
			'OP01_NAMED_VOID' => -77,
			'LITERAL_STRING' => -77,
			'OP01_NAMED' => -77,
			'OP10_NAMED_UNARY' => -77,
			"my" => -77,
			"undef" => -77,
			'OP03_MATH_INC_DEC' => -77,
			'OP19_LOOP_CONTROL' => -77,
			'LITERAL_NUMBER' => -77,
			'OP01_NAMED_VOID_PAREN' => -77,
			"for my integer" => -77,
			"if (" => -77,
			"( my" => 376
		},
		GOTOS => {
			'OPTIONAL-32' => 375,
			'MethodArguments' => 374
		}
	},
	{#State 367
		ACTIONS => {
			"1;" => 377
		}
	},
	{#State 368
		DEFAULT => -65
	},
	{#State 369
		DEFAULT => -165
	},
	{#State 370
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 371
		ACTIONS => {
			"{" => 292
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 372
		DEFAULT => -47
	},
	{#State 373
		ACTIONS => {
			"if (" => -52,
			"for my integer" => -52,
			"my" => -52,
			"undef" => -52,
			'OP10_NAMED_UNARY' => -52,
			'OP01_NAMED' => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			'OP19_LOOP_CONTROL' => -52,
			'OP03_MATH_INC_DEC' => -52,
			'LITERAL_NUMBER' => -52,
			"while (" => -52,
			'VARIABLE_SYMBOL' => -52,
			'LITERAL_STRING' => -52,
			'WORD_SCOPED' => -52,
			'OP10_NAMED_UNARY_STRINGIFY' => -52,
			'OP22_LOGICAL_NOT' => -52,
			'OP01_NAMED_VOID' => -52,
			'OP05_MATH_NEG' => -52,
			'CHECK_OR_CHECKTRACE' => 381,
			'WORD' => -52,
			"[" => -52,
			'OP05_LOGICAL_NEG' => -52,
			"(" => -52,
			"%{" => -52,
			"foreach my" => -52,
			"\@{" => -52,
			"{" => -52
		},
		GOTOS => {
			'ArgumentCheck' => 380
		}
	},
	{#State 374
		DEFAULT => -76
	},
	{#State 375
		ACTIONS => {
			"for my integer" => -148,
			"if (" => 111,
			'OP01_NAMED' => 112,
			"my" => 115,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 117,
			'OP19_LOOP_CONTROL' => 91,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_VOID_PAREN' => 96,
			'VARIABLE_SYMBOL' => 97,
			"while (" => -148,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP01_NAMED_VOID' => 78,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 101,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"(" => 104,
			"%{" => 103,
			'OP05_MATH_NEG' => 83,
			'WORD' => 84,
			"{" => 106,
			"foreach my" => -148,
			"\@{" => 86
		},
		GOTOS => {
			'PAREN-44' => 100,
			'OPTIONAL-45' => 98,
			'Operation' => 382,
			'VariableDeclaration' => 107,
			'OperatorVoid' => 108,
			'HashReference' => 87,
			'Expression' => 85,
			'Operator' => 110,
			'VariableModification' => 109,
			'WordScoped' => 82,
			'Statement' => 105,
			'ArrayDereferenced' => 90,
			'PLUS-33' => 383,
			'ArrayReference' => 89,
			'Variable' => 88,
			'Literal' => 93,
			'Conditional' => 118,
			'HashDereferenced' => 95,
			'LoopLabel' => 113
		}
	},
	{#State 376
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 384
		}
	},
	{#State 377
		DEFAULT => -67
	},
	{#State 378
		DEFAULT => -164
	},
	{#State 379
		DEFAULT => -154
	},
	{#State 380
		DEFAULT => -50
	},
	{#State 381
		ACTIONS => {
			"(" => 385
		}
	},
	{#State 382
		DEFAULT => -79
	},
	{#State 383
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			"while (" => -148,
			"}" => 386,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'OP01_NAMED_VOID' => 78,
			'LITERAL_STRING' => 101,
			"(" => 104,
			"%{" => 103,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			'WORD' => 84,
			'OP05_MATH_NEG' => 83,
			"{" => 106,
			"\@{" => 86,
			"foreach my" => -148,
			"for my integer" => -148,
			"if (" => 111,
			'OP01_NAMED' => 112,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			"my" => 115,
			'LITERAL_NUMBER' => 94,
			'OP19_LOOP_CONTROL' => 91,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_NAMED_VOID_PAREN' => 96
		},
		GOTOS => {
			'Literal' => 93,
			'HashDereferenced' => 95,
			'Conditional' => 118,
			'LoopLabel' => 113,
			'ArrayDereferenced' => 90,
			'Variable' => 88,
			'ArrayReference' => 89,
			'VariableDeclaration' => 107,
			'OperatorVoid' => 108,
			'VariableModification' => 109,
			'Operator' => 110,
			'Expression' => 85,
			'HashReference' => 87,
			'Statement' => 105,
			'WordScoped' => 82,
			'PAREN-44' => 100,
			'OPTIONAL-45' => 98,
			'Operation' => 387
		}
	},
	{#State 384
		DEFAULT => -83,
		GOTOS => {
			'STAR-35' => 388
		}
	},
	{#State 385
		ACTIONS => {
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			"\@{" => 86,
			"{" => 106
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'Expression' => 389,
			'Operator' => 110,
			'HashReference' => 87,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 386
		ACTIONS => {
			";" => 390
		}
	},
	{#State 387
		DEFAULT => -78
	},
	{#State 388
		ACTIONS => {
			'OP21_LIST_COMMA' => 392,
			")" => 393
		},
		GOTOS => {
			'PAREN-34' => 391
		}
	},
	{#State 389
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			")" => -55,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => 394
		},
		GOTOS => {
			'OPTIONAL-22' => 395,
			'PAREN-21' => 396
		}
	},
	{#State 390
		DEFAULT => -80
	},
	{#State 391
		DEFAULT => -82
	},
	{#State 392
		ACTIONS => {
			"my" => 397
		}
	},
	{#State 393
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 398
		}
	},
	{#State 394
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			"undef" => 116,
			'OP01_NAMED' => 112,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			"\@{" => 86,
			"{" => 106,
			'VARIABLE_SYMBOL' => 97,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NOT' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayReference' => 89,
			'Variable' => 127,
			'ArrayDereferenced' => 90,
			'WordScoped' => 82,
			'Literal' => 93,
			'HashReference' => 87,
			'Expression' => 399,
			'Operator' => 110,
			'HashDereferenced' => 95
		}
	},
	{#State 395
		ACTIONS => {
			")" => 400
		}
	},
	{#State 396
		DEFAULT => -54
	},
	{#State 397
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 401
		}
	},
	{#State 398
		ACTIONS => {
			"\@_;" => 402
		}
	},
	{#State 399
		ACTIONS => {
			'OP16_LOGICAL_OR' => 154,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 151,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 150,
			'OP17_LIST_RANGE' => 157,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP23_LOGICAL_AND' => 160,
			'OP11_COMPARE_LT_GT' => 159,
			'OP08_MATH_ADD_SUB' => 148,
			'OP21_LIST_COMMA' => 403,
			'OP04_MATH_POW' => 145,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 146
		}
	},
	{#State 400
		ACTIONS => {
			";" => 404
		}
	},
	{#State 401
		ACTIONS => {
			'VARIABLE_SYMBOL' => 405
		}
	},
	{#State 402
		DEFAULT => -85,
		GOTOS => {
			'STAR-36' => 406
		}
	},
	{#State 403
		ACTIONS => {
			'LITERAL_STRING' => 101,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY_STRINGIFY' => 77,
			'OP22_LOGICAL_NOT' => 79,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 86,
			"{" => 106,
			'OP05_MATH_NEG' => 83,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 102,
			"[" => 81,
			"%{" => 103,
			"(" => 104,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 94,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 112
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashDereferenced' => 95,
			'Operator' => 110,
			'Expression' => 407,
			'HashReference' => 87,
			'Literal' => 93,
			'Variable' => 127,
			'ArrayReference' => 89,
			'ArrayDereferenced' => 90
		}
	},
	{#State 404
		DEFAULT => -56
	},
	{#State 405
		DEFAULT => -81
	},
	{#State 406
		ACTIONS => {
			"for my integer" => -86,
			"if (" => -86,
			'OP01_NAMED' => -86,
			"undef" => -86,
			"my" => -86,
			'OP10_NAMED_UNARY' => -86,
			'OP03_MATH_INC_DEC' => -86,
			'OP19_LOOP_CONTROL' => -86,
			'LITERAL_NUMBER' => -86,
			'OP01_NAMED_VOID_PAREN' => -86,
			'VARIABLE_SYMBOL' => -86,
			"while (" => -86,
			'OP10_NAMED_UNARY_STRINGIFY' => -86,
			'WORD_SCOPED' => -86,
			'OP01_NAMED_VOID' => -86,
			'OP22_LOGICAL_NOT' => -86,
			'LITERAL_STRING' => -86,
			"[" => -86,
			'OP05_LOGICAL_NEG' => -86,
			"(" => -86,
			"%{" => -86,
			'CHECK_OR_CHECKTRACE' => 381,
			'OP05_MATH_NEG' => -86,
			'WORD' => -86,
			"{" => -86,
			"foreach my" => -86,
			"\@{" => -86
		},
		GOTOS => {
			'ArgumentCheck' => 408
		}
	},
	{#State 407
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 148,
			")" => -53,
			'OP06_REGEX_MATCH' => 146,
			'OP15_LOGICAL_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP04_MATH_POW' => 145,
			'OP08_STRING_CAT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 154,
			'OP11_COMPARE_LT_GT' => 159,
			'OP23_LOGICAL_AND' => 160,
			'OP12_COMPARE_EQ_NEQ' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 158,
			'OP18_TERNARY' => 151,
			'OP14_BITWISE_OR_XOR' => 152
		}
	},
	{#State 408
		DEFAULT => -84
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5475 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5482 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5489 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5496 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5507 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5518 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5525 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5532 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5539 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5553 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5560 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5574 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5581 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5588 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5595 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5602 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5613 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5627 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5638 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5649 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5660 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5667 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5674 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5681 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5688 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5695 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5702 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5709 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5716 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5763 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5770 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5849 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-21', 4,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_56
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5934 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5941 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 3,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Class_70
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_74
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_75
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6100 lib/RPerl/Grammar.pm
	],
	[#Rule Method_80
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6132 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_86
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_87
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6168 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_88
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6464 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6471 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_124
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_125
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_134
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_135
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_144
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6739 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_145
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6750 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6764 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6782 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 4,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6833 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6923 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_165
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_166
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-50', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-50', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_169
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-51', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_172
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_179
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-52', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_185
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_186
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_192
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_193
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_194
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_197
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_198
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_199
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_200
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_204
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_205
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_206
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_209
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7354 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_210
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_211
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule Type_212
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_215
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	]
],
#line 7423 lib/RPerl/Grammar.pm
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
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Class_70', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_74', 
         'Properties_75', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_80', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_86', 
         'Operation_87', 
         'Operation_88', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_123', 
         'OperatorVoid_124', 
         'OperatorVoid_125', 
         'OperatorVoid_126', 
         'OperatorVoid_127', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_132', 
         'Expression_133', 
         'Expression_134', 
         'Expression_135', 
         'Expression_136', 
         'Expression_137', 
         'Expression_138', 
         'Expression_139', 
         'Expression_140', 
         'Expression_141', 
         'Expression_142', 
         'Expression_143', 
         'ExpressionOrStdin_144', 
         'ExpressionOrStdin_145', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_160', 
         'Loop_161', 
         'Loop_162', 
         'Loop_163', 
         'LoopFor_164', 
         'LoopForEach_165', 
         'LoopWhile_166', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_169', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_172', 
         'VariableRetrieval_173', 
         'VariableRetrieval_174', 
         'VariableRetrieval_175', 
         'VariableDeclaration_176', 
         'VariableDeclaration_177', 
         'VariableModification_178', 
         'VariableModification_179', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_185', 
         'ListElements_186', 
         'ListElement_187', 
         'ListElement_188', 
         'ListElement_189', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_192', 
         'ArrayDereferenced_193', 
         'ArrayDereferenced_194', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_197', 
         'HashEntry_198', 
         'HashEntryTyped_199', 
         'HashEntryTyped_200', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_204', 
         'HashDereferenced_205', 
         'HashDereferenced_206', 
         'WordScoped_207', 
         'WordScoped_208', 
         'FileHandle_209', 
         'FileHandle_210', 
         'TypeInner_211', 
         'Type_212', 
         'LoopLabel_213', 
         'Literal_214', 
         'Literal_215', );
  $self;
}

#line 178 "lib/RPerl/Grammar.eyp"


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


#line 7687 lib/RPerl/Grammar.pm



1;
